from airflow import DAG
from operators.common_pipeline import CommonDag


def _ev_charging(**kwargs):
    """
    ETL for EV charging stations, points, and connectors (Taipei + New Taipei).
    Source: TDX CityEVCharging API v1.
    Writes to:
      - env_ev_charging_stations          (point layer + map popup)
      - env_ev_charging_points            (charging point detail)
      - env_ev_charging_connectors        (connector detail with power bucket)
      - env_ev_charging_district_summary  (aggregated by district + city_scope)
      - env_ev_charging_connector_power_district (power bucket ratio by district)
    """
    import json
    import os
    import re
    import numpy as np
    import pandas as pd
    from sqlalchemy import create_engine
    from utils.load_stage import (
        save_geodataframe_to_postgresql,
        save_dataframe_to_postgresql,
        update_lasttime_in_data_to_dataset_info,
    )
    from utils.transform_geometry import add_point_wkbgeometry_column_to_df
    from utils.transform_time import convert_str_to_time_format

    # ── Config ────────────────────────────────────────────────────────────────
    ready_data_db_uri = kwargs.get("ready_data_db_uri")
    data_path = kwargs.get("data_path")
    dag_infos = kwargs.get("dag_infos")
    dag_id = dag_infos.get("dag_id")

    EV_DATA_DIR = os.path.join(data_path, "ev_charging")

    CITIES = [
        {"file_suffix": "Taipei",    "city_zh": "臺北市"},
        {"file_suffix": "NewTaipei", "city_zh": "新北市"},
    ]

    CONNECTOR_TYPE_MAP = {
        1: "CCS1", 2: "CCCS2", 3: "CHAdeMO", 4: "Tesla_TPC",
        5: "J1772_Type1", 6: "Mennekes_Type2", 254: "Others", 255: "Unknown",
    }
    POWER_TYPE_MAP = {1: "AC", 2: "DC"}

    BUCKET_ORDER = {
        "slow_ac": 1, "medium_dc": 2, "fast_dc": 3, "ultra_fast_dc": 4, "unknown": 5,
    }

    # ── Helpers ───────────────────────────────────────────────────────────────

    def parse_power_kw(raw):
        """Extract numeric kW from PowerRating string, return None if unparseable."""
        if not raw or not isinstance(raw, str):
            return None
        cleaned = re.sub(r"[kKwW\s]", "", raw)
        try:
            return float(cleaned)
        except ValueError:
            return None

    def classify_bucket(power_type, power_kw):
        if power_type == 1:          # AC
            return "slow_ac"
        if power_type == 2:          # DC
            if power_kw is None:
                return "unknown"
            if power_kw < 22:
                return "slow_ac"
            if power_kw < 50:
                return "medium_dc"
            if power_kw < 150:
                return "fast_dc"
            return "ultra_fast_dc"
        return "unknown"

    def build_address(loc):
        """Combine TDX Location.Address sub-fields into a single address string."""
        if not isinstance(loc, dict):
            return ""
        addr = loc.get("Address", {})
        if isinstance(addr, str):
            return addr
        parts = [
            addr.get("City", ""),
            addr.get("Town", ""),
            addr.get("Road", ""),
            addr.get("Lane", ""),
            addr.get("Alley", ""),
            addr.get("No", ""),
        ]
        return "".join(p for p in parts if p)

    def extract_name_zh(name_obj):
        """TDX StationName is an object with Zh_tw / En fields."""
        if isinstance(name_obj, str):
            return name_obj
        if isinstance(name_obj, dict):
            return name_obj.get("Zh_tw") or name_obj.get("En") or str(name_obj)
        return ""

    # ── Extract ───────────────────────────────────────────────────────────────
    def read_json(filepath):
        with open(filepath, "r", encoding="utf-8") as f:
            return json.load(f)

    raw_stations = []
    raw_points = []
    raw_connectors = []

    for city in CITIES:
        suffix = city["file_suffix"]
        zh = city["city_zh"]

        st_raw = read_json(os.path.join(EV_DATA_DIR, f"Station_{suffix}.json"))
        cp_raw = read_json(os.path.join(EV_DATA_DIR, f"ChargingPoint_{suffix}.json"))
        cn_raw = read_json(os.path.join(EV_DATA_DIR, f"Connector_{suffix}.json"))

        update_time = st_raw.get("UpdateTime", "")

        for s in st_raw.get("Stations", []):
            s["_city_zh"] = zh
            s["_update_time"] = update_time
            raw_stations.append(s)

        for cp in cp_raw.get("ChargingPoints", []):
            cp["_city_zh"] = zh
            cp["_update_time"] = cp_raw.get("UpdateTime", update_time)
            raw_points.append(cp)

        for cn in cn_raw.get("Connectors", []):
            cn["_city_zh"] = zh
            cn["_update_time"] = cn_raw.get("UpdateTime", update_time)
            raw_connectors.append(cn)

    # ── Transform: stations ───────────────────────────────────────────────────
    def normalize_district(raw):
        if not isinstance(raw, str):
            return "未分類"
        d = raw.strip()
        if not d:
            return "未分類"
        if not d.endswith(("區", "鄉", "鎮", "市")):
            d = d + "區"
        return d

    station_rows = []
    for s in raw_stations:
        loc = s.get("Location", {})
        addr_obj = loc.get("Address", {}) if isinstance(loc, dict) else {}
        district = normalize_district(addr_obj.get("Town", "") if isinstance(addr_obj, dict) else "")
        address = build_address(loc)

        station_rows.append({
            "source_name":   "TDX CityEVCharging Station",
            "source_url":    "https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/" + s["_city_zh"],
            "city":          s["_city_zh"],
            "district":      district,
            "station_id":    s.get("StationID", ""),
            "station_name":  extract_name_zh(s.get("StationName", "")),
            "operator_id":   s.get("OperatorID", ""),
            "operation_type": s.get("OperationType"),
            "spaces":        s.get("Spaces"),
            "station_reported_charging_points": s.get("ChargingPoints"),
            "charging_point_count": None,   # filled after join
            "connector_count":      None,   # filled after join
            "power_summary":        None,   # filled after join
            "service_time":  s.get("ServiceTime", ""),
            "parking_rate":  s.get("ParkingRate", ""),
            "charging_rate": s.get("ChargingRate", ""),
            "floors":        s.get("Floors", ""),
            "telephone":     s.get("Telephone", ""),
            "address":       address,
            "normalized_address": address,
            "longitude":     s.get("PositionLon"),
            "latitude":      s.get("PositionLat"),
            "data_time":     s["_update_time"],
        })

    df_stations = pd.DataFrame(station_rows)
    df_stations["data_time"] = convert_str_to_time_format(df_stations["data_time"])
    df_stations["longitude"] = pd.to_numeric(df_stations["longitude"], errors="coerce")
    df_stations["latitude"]  = pd.to_numeric(df_stations["latitude"],  errors="coerce")

    # ── Spatial fallback: fill missing district by point-in-polygon ──────────
    try:
        import geopandas as gpd
        from shapely.geometry import Point

        town_files = [
            os.path.join(EV_DATA_DIR, "taipei_town.geojson"),
            os.path.join(EV_DATA_DIR, "metrotaipei_town.geojson"),
        ]
        town_frames = []
        for tf in town_files:
            if os.path.exists(tf):
                g = gpd.read_file(tf)
                if g.crs is None:
                    g = g.set_crs(4326)
                town_frames.append(g[["PNAME", "TNAME", "geometry"]])
        if town_frames:
            towns = gpd.GeoDataFrame(pd.concat(town_frames, ignore_index=True), crs=4326)
            need_lookup = df_stations["district"].eq("未分類") & df_stations["longitude"].notna() & df_stations["latitude"].notna()
            if need_lookup.any():
                pts = gpd.GeoDataFrame(
                    df_stations.loc[need_lookup, ["station_id", "longitude", "latitude"]].copy(),
                    geometry=[Point(xy) for xy in zip(df_stations.loc[need_lookup, "longitude"], df_stations.loc[need_lookup, "latitude"])],
                    crs=4326,
                )
                joined = gpd.sjoin(pts, towns, how="left", predicate="within")
                joined = joined.drop_duplicates("station_id", keep="first")
                lookup = joined.set_index("station_id")["TNAME"].to_dict()
                df_stations.loc[need_lookup, "district"] = df_stations.loc[need_lookup, "station_id"].map(lookup).fillna("未分類")
    except Exception as _e:
        print(f"[ev_charging] spatial district fallback skipped: {_e}")

    # ── Transform: connectors ─────────────────────────────────────────────────
    connector_rows = []
    for cn in raw_connectors:
        power_rating_raw = str(cn.get("PowerRating", "") or "")
        power_kw = parse_power_kw(power_rating_raw)
        power_type = cn.get("Power")
        bucket = classify_bucket(power_type, power_kw)
        connector_rows.append({
            "city":              cn["_city_zh"],
            "station_id":        cn.get("StationID", ""),
            "charging_point_id": cn.get("ChargingPointID", ""),
            "connector_id":      cn.get("ConnectorID", ""),
            "connector_type":    cn.get("Type"),
            "connector_type_name": CONNECTOR_TYPE_MAP.get(cn.get("Type"), "Unknown"),
            "power_type":        power_type,
            "power_type_name":   POWER_TYPE_MAP.get(power_type, "Unknown"),
            "voltage":           str(cn.get("Voltage", "") or ""),
            "current_rating":    str(cn.get("CurrentRating", "") or ""),
            "power_rating":      power_rating_raw,
            "power_kw":          power_kw,
            "power_bucket":      bucket,
            "floor":             str(cn.get("Floor", "") or ""),
            "usage_restriction": str(cn.get("UsageRestriction", "") or ""),
            "data_time":         cn["_update_time"],
        })

    df_connectors = pd.DataFrame(connector_rows)
    df_connectors["data_time"] = convert_str_to_time_format(df_connectors["data_time"])

    # ── Transform: charging points ────────────────────────────────────────────
    point_rows = []
    for cp in raw_points:
        ctype_summary = {
            str(CONNECTOR_TYPE_MAP.get(c.get("Type"), c.get("Type"))): c.get("Quantity", 0)
            for c in (cp.get("Connectors") or [])
        }
        point_rows.append({
            "city":              cp["_city_zh"],
            "district":          "",             # filled after join
            "station_id":        cp.get("StationID", ""),
            "charging_point_id": cp.get("ChargingPointID", ""),
            "operator_id":       cp.get("OperatorID", ""),
            "floor":             str(cp.get("Floor", "") or ""),
            "charging_rate":     cp.get("ChargingRate", ""),
            "usage_restriction": str(cp.get("UsageRestriction", "") or ""),
            "connector_type_summary": json.dumps(ctype_summary, ensure_ascii=False),
            "data_time":         cp["_update_time"],
        })

    df_points = pd.DataFrame(point_rows)
    df_points["data_time"] = convert_str_to_time_format(df_points["data_time"])

    # Join district from stations into points
    station_district = df_stations[["station_id", "district"]].drop_duplicates("station_id")
    df_points = df_points.drop(columns=["district"]).merge(
        station_district, on="station_id", how="left"
    )

    # ── Enrich stations: charging_point_count, connector_count, power_summary ─
    cp_counts = (
        df_points.groupby("station_id")["charging_point_id"]
        .nunique()
        .reset_index()
        .rename(columns={"charging_point_id": "charging_point_count"})
    )
    cn_counts = (
        df_connectors.groupby("station_id")["connector_id"]
        .nunique()
        .reset_index()
        .rename(columns={"connector_id": "connector_count"})
    )
    power_summary_df = (
        df_connectors.groupby(["station_id", "power_bucket"])["connector_id"]
        .nunique()
        .reset_index()
        .rename(columns={"connector_id": "cnt"})
    )
    power_summary_map = (
        power_summary_df.groupby("station_id")
        .apply(lambda g: dict(zip(g["power_bucket"], g["cnt"])))
        .to_dict()
    )

    df_stations = df_stations.drop(columns=["charging_point_count", "connector_count"], errors="ignore")
    df_stations = df_stations.merge(cp_counts, on="station_id", how="left")
    df_stations = df_stations.merge(cn_counts, on="station_id", how="left")
    # Fallback to station-reported values when join produces no data
    df_stations["charging_point_count"] = df_stations["charging_point_count"].fillna(
        df_stations["station_reported_charging_points"]
    ).fillna(0).astype(int)
    df_stations["connector_count"] = df_stations["connector_count"].fillna(0).astype(int)
    df_stations["power_summary"] = df_stations["station_id"].map(
        lambda sid: json.dumps(power_summary_map.get(sid, {}), ensure_ascii=False)
    )

    # ── Build geometry for stations ───────────────────────────────────────────
    valid_geo = df_stations["longitude"].notna() & df_stations["latitude"].notna()
    gdf = add_point_wkbgeometry_column_to_df(
        df_stations[valid_geo].copy(),
        df_stations[valid_geo]["longitude"],
        df_stations[valid_geo]["latitude"],
        from_crs=4326,
    )
    # Stations without coordinates: keep as non-geometry rows (still useful for aggregates)
    df_stations_no_geo = df_stations[~valid_geo].copy()
    df_stations_no_geo["wkb_geometry"] = None

    STATION_COLS = [
        "source_name", "source_url", "city", "district", "station_id", "station_name",
        "operator_id", "operation_type", "spaces", "station_reported_charging_points",
        "charging_point_count", "connector_count", "power_summary",
        "service_time", "parking_rate", "charging_rate", "floors", "telephone",
        "address", "normalized_address", "longitude", "latitude", "data_time", "wkb_geometry",
    ]
    gdf_ready = gdf[[c for c in STATION_COLS if c in gdf.columns]]

    # ── Build district aggregates ─────────────────────────────────────────────
    all_stations = pd.concat(
        [gdf_ready[["city", "district", "station_id", "charging_point_count", "connector_count", "data_time"]],
         df_stations_no_geo[["city", "district", "station_id", "charging_point_count", "connector_count", "data_time"]]],
        ignore_index=True,
    )

    def build_district_summary(df, city_scope, cities):
        subset = df[df["city"].isin(cities)].copy()
        sc_counts = (
            subset.groupby(["city", "district"])
            .agg(
                station_count=("station_id", "nunique"),
                charging_point_count=("charging_point_count", "sum"),
                connector_count=("connector_count", "sum"),
                data_time=("data_time", "max"),
            )
            .reset_index()
        )
        sc_counts["city_scope"] = city_scope
        sc_counts["charging_point_count"] = sc_counts["charging_point_count"].fillna(0).astype(int)
        sc_counts["connector_count"] = sc_counts["connector_count"].fillna(0).astype(int)
        return sc_counts

    summary_tpe = build_district_summary(all_stations, "taipei",    ["臺北市"])
    summary_twin = build_district_summary(all_stations, "twin_city", ["臺北市", "新北市"])
    df_summary = pd.concat([summary_tpe, summary_twin], ignore_index=True)

    # ── Build power bucket aggregates ─────────────────────────────────────────
    cn_with_district = df_connectors.merge(
        df_stations[["station_id", "district"]].drop_duplicates("station_id"),
        on="station_id", how="left",
    )

    def build_power_district(df, city_scope, cities):
        subset = df[df["city"].isin(cities)]
        agg = (
            subset.groupby(["city", "district", "power_bucket"])["connector_id"]
            .nunique()
            .reset_index()
            .rename(columns={"connector_id": "connector_count"})
        )
        # Ensure every district has all 5 buckets (fill missing with 0)
        districts = agg[["city", "district"]].drop_duplicates()
        buckets = pd.DataFrame({"power_bucket": list(BUCKET_ORDER.keys())})
        full = districts.merge(buckets, how="cross")
        agg = full.merge(agg, on=["city", "district", "power_bucket"], how="left")
        agg["connector_count"] = agg["connector_count"].fillna(0).astype(int)

        # Ratio within district
        totals = agg.groupby(["city", "district"])["connector_count"].transform("sum")
        agg["connector_ratio"] = np.where(
            totals > 0, (agg["connector_count"] / totals).round(4), 0.0
        )
        agg["power_bucket_order"] = agg["power_bucket"].map(BUCKET_ORDER)
        agg["city_scope"] = city_scope
        agg["data_time"] = df["data_time"].max()
        return agg

    power_tpe  = build_power_district(cn_with_district, "taipei",    ["臺北市"])
    power_twin = build_power_district(cn_with_district, "twin_city", ["臺北市", "新北市"])
    df_power = pd.concat([power_tpe, power_twin], ignore_index=True)

    # ── Load ──────────────────────────────────────────────────────────────────
    engine = create_engine(ready_data_db_uri)

    # 1. Stations (with geometry)
    save_geodataframe_to_postgresql(
        engine,
        gdata=gdf_ready,
        load_behavior="replace",
        default_table="env_ev_charging_stations",
        history_table=None,
        geometry_type="Point",
    )

    # 2. Charging points
    POINT_COLS = [
        "city", "district", "station_id", "charging_point_id",
        "operator_id", "floor", "charging_rate", "usage_restriction",
        "connector_type_summary", "data_time",
    ]
    save_dataframe_to_postgresql(
        engine,
        data=df_points[[c for c in POINT_COLS if c in df_points.columns]],
        load_behavior="replace",
        default_table="env_ev_charging_points",
        history_table=None,
    )

    # 3. Connectors
    CONNECTOR_COLS = [
        "city", "station_id", "charging_point_id", "connector_id",
        "connector_type", "connector_type_name", "power_type", "power_type_name",
        "voltage", "current_rating", "power_rating", "power_kw",
        "power_bucket", "floor", "usage_restriction", "data_time",
    ]
    save_dataframe_to_postgresql(
        engine,
        data=df_connectors[[c for c in CONNECTOR_COLS if c in df_connectors.columns]],
        load_behavior="replace",
        default_table="env_ev_charging_connectors",
        history_table=None,
    )

    # 4. District summary
    SUMMARY_COLS = [
        "city_scope", "city", "district",
        "station_count", "charging_point_count", "connector_count", "data_time",
    ]
    save_dataframe_to_postgresql(
        engine,
        data=df_summary[SUMMARY_COLS],
        load_behavior="replace",
        default_table="env_ev_charging_district_summary",
        history_table=None,
    )

    # 5. Power bucket district
    POWER_COLS = [
        "city_scope", "city", "district", "power_bucket", "power_bucket_order",
        "connector_count", "connector_ratio", "data_time",
    ]
    save_dataframe_to_postgresql(
        engine,
        data=df_power[POWER_COLS],
        load_behavior="replace",
        default_table="env_ev_charging_connector_power_district",
        history_table=None,
    )

    # Update metadata
    lasttime_in_data = df_stations["data_time"].max()
    update_lasttime_in_data_to_dataset_info(engine, dag_id, lasttime_in_data)


dag = CommonDag(
    proj_folder="proj_new_taipei_city_dashboard",
    dag_folder="ev_charging",
)
dag.create_dag(etl_func=_ev_charging)
