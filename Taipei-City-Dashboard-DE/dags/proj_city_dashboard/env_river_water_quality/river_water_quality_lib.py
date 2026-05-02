import json
import logging
import math
import os
import re
import time
from typing import Dict, List, NamedTuple, Optional, Tuple

import geopandas as gpd
import pandas as pd
import requests
from shapely.geometry import LineString, Point
from shapely.ops import substring

logger = logging.getLogger(__name__)

MOENV_RIVER_STATIONS_URL = (
    "https://wq.moenv.gov.tw/EWQP_GIS/dataFile/AJAX_Main.aspx"
    "?Type=Get_point_WQStation_River"
)

WRA_RIVER_SHAPEFILE_URL = (
    "https://gic.wra.gov.tw/gis/gic/API/Google/DownLoad.aspx"
    "?fname=RIVER&filetype=SHP"
)
WRA_RIVER_CRS = "EPSG:3826"

RIVER_NAME_ALIAS = {
    "淡水河本流": "淡水河",
    "三峽河": "三峽溪",
}

SOURCE_NAME = "環境部"
TARGET_CITIES = ("臺北市", "新北市")

RPI_FLAG_COMPLETE = "complete"
RPI_FLAG_INCOMPLETE = "incomplete"
GEOMETRY_SOURCE_REAL_RIVER = "real_river"
GEOMETRY_SOURCE_STRAIGHT_LINE = "straight_line"
GEOMETRY_SOURCE_CURATED_ROUTE = "curated_route"

RISK_LEVEL_MAP = {
    "未（稍）受污染": ("unpolluted", 1),
    "未(稍)受污染": ("unpolluted", 1),
    "輕度污染": ("mild", 2),
    "中度污染": ("moderate", 3),
    "嚴重污染": ("severe", 4),
}

INCOMPLETE_LABEL = "無檢測資料"

STATION_OFF_RIVER_TOLERANCE_M = 1500.0
ROUTE_ENDPOINT_SNAP_TOLERANCE_M = 750.0
SITE_ENDPOINT_EXPORT_TOLERANCE_M = 75.0

_MONTH_PATTERN = re.compile(r"(\d{3,4})\s*年\s*(\d{1,2})\s*月")

_SITE_COLUMNS = [
    "source_name",
    "city",
    "district",
    "basin",
    "river",
    "site_id",
    "site_name",
    "site_name_en",
    "site_address",
    "status_of_use",
    "wq_std_grade",
    "longitude",
    "latitude",
    "data_time",
]

_LATEST_COLUMNS = [
    "source_name",
    "city",
    "district",
    "basin",
    "river",
    "river_id",
    "station_order",
    "site_id",
    "site_name",
    "wq_std_grade",
    "sample_month",
    "rpi_value",
    "risk_level",
    "risk_level_order",
    "rpi_flag",
    "data_time",
    "longitude",
    "latitude",
]

_SEGMENT_COLUMNS = [
    "segment_id",
    "river_id",
    "river",
    "basin",
    "upstream_site_id",
    "upstream_site_name",
    "upstream_city",
    "upstream_rpi",
    "downstream_site_id",
    "downstream_site_name",
    "downstream_city",
    "downstream_rpi",
    "sample_month",
    "geometry_source",
    "data_time",
    "wkb_geometry",
]


class _Projection(NamedTuple):
    feature_idx: int
    t_along: float
    dist_m: float
    nearest_pt: Point


def fetch_river_station_records(
    session: Optional[requests.Session] = None,
    timeout: int = 30,
) -> list:
    sess = session or requests.Session()
    response = sess.get(MOENV_RIVER_STATIONS_URL, timeout=timeout)
    response.raise_for_status()
    payload = response.json()
    if not isinstance(payload, list):
        raise ValueError("MOENV river-station endpoint returned non-list payload.")
    return payload


def parse_month_date(value):
    if value is None:
        return None
    text = str(value).strip()
    if not text:
        return None
    match = _MONTH_PATTERN.search(text)
    if not match:
        return None
    year = int(match.group(1))
    month = int(match.group(2))
    if year < 1900:
        year += 1911
    if not 1 <= month <= 12:
        return None
    return pd.Timestamp(year=year, month=month, day=1).date()


def map_risk_level(value) -> Tuple[Optional[str], Optional[int], str]:
    if value is None:
        return None, None, RPI_FLAG_INCOMPLETE
    text = str(value).strip()
    if not text or text == INCOMPLETE_LABEL:
        return None, None, RPI_FLAG_INCOMPLETE
    if text in RISK_LEVEL_MAP:
        level, order = RISK_LEVEL_MAP[text]
        return level, order, RPI_FLAG_COMPLETE
    return None, None, RPI_FLAG_INCOMPLETE


def _to_numeric_or_none(value):
    result = pd.to_numeric(value, errors="coerce")
    if pd.isna(result):
        return None
    return float(result)


def _to_str_or_none(value):
    if value is None:
        return None
    text = str(value).strip()
    return text or None


def normalize_records(records: list, data_time: str) -> Tuple[pd.DataFrame, pd.DataFrame]:
    if not records:
        return pd.DataFrame(columns=_SITE_COLUMNS), pd.DataFrame(columns=_LATEST_COLUMNS)

    df = pd.DataFrame(records)
    df = df[df["County_Name"].isin(TARGET_CITIES)].copy()
    if df.empty:
        return pd.DataFrame(columns=_SITE_COLUMNS), pd.DataFrame(columns=_LATEST_COLUMNS)

    df["site_id"] = df["Station_ID"].astype(str).str.strip()
    df = df[df["site_id"] != ""].drop_duplicates(subset=["site_id"], keep="last")

    df["source_name"] = SOURCE_NAME
    df["city"] = df["County_Name"]
    df["district"] = df["Town_Cname"]
    df["basin"] = df["Basin_Name"]
    df["river"] = df["River_Name"]
    df["river_id"] = df["River_ID"].map(_to_str_or_none)
    df["station_order"] = pd.to_numeric(df["Station_Order"], errors="coerce").astype("Int64")
    df["site_name"] = df["Station_Name"]
    df["site_name_en"] = df["Station_EName"]
    df["site_address"] = df["Station_Address"]
    df["status_of_use"] = df["測站使用狀態"]
    df["wq_std_grade"] = df["Wqstd_Name"]
    df["longitude"] = df["Gis_X"].map(_to_numeric_or_none)
    df["latitude"] = df["Gis_Y"].map(_to_numeric_or_none)
    df["data_time"] = data_time

    df["sample_month"] = df["MonthDate_Dec"].map(parse_month_date)

    df["rpi_value"] = df["WQ_Index"].map(_to_numeric_or_none)
    risk_mapping = df["WQ_Index_Dec"].map(map_risk_level)
    df["risk_level"] = risk_mapping.map(lambda triple: triple[0])
    df["risk_level_order"] = risk_mapping.map(lambda triple: triple[1]).astype("Int64")
    df["rpi_flag"] = risk_mapping.map(lambda triple: triple[2])
    rpi_missing = df["rpi_value"].isna()
    df.loc[rpi_missing, "rpi_flag"] = RPI_FLAG_INCOMPLETE
    df.loc[rpi_missing, "risk_level"] = None
    df.loc[rpi_missing, "risk_level_order"] = pd.NA

    return df[_SITE_COLUMNS].copy(), df[_LATEST_COLUMNS].copy()


def fetch_wra_river_geodataframe(
    cache_dir: str,
    ttl_days: int = 7,
    timeout: int = 120,
    session: Optional[requests.Session] = None,
) -> gpd.GeoDataFrame:
    os.makedirs(cache_dir, exist_ok=True)
    cache_path = os.path.join(cache_dir, "wra_river.zip")
    needs_download = True
    if os.path.exists(cache_path):
        age_days = (time.time() - os.path.getmtime(cache_path)) / 86400.0
        if age_days < ttl_days and os.path.getsize(cache_path) > 0:
            needs_download = False

    if needs_download:
        sess = session or requests.Session()
        tmp_path = cache_path + ".tmp"
        with sess.get(WRA_RIVER_SHAPEFILE_URL, stream=True, timeout=timeout) as resp:
            resp.raise_for_status()
            with open(tmp_path, "wb") as fh:
                for chunk in resp.iter_content(chunk_size=1 << 16):
                    if chunk:
                        fh.write(chunk)
        os.replace(tmp_path, cache_path)

    return gpd.read_file(f"zip://{cache_path}!river/river.shp")


def load_curated_route_geodataframe(path: str) -> Optional[gpd.GeoDataFrame]:
    if not path or not os.path.exists(path):
        return None
    return gpd.read_file(path)


def _straight_line_segment(upstream_row, downstream_row) -> LineString:
    return LineString(
        [
            (float(upstream_row["longitude"]), float(upstream_row["latitude"])),
            (float(downstream_row["longitude"]), float(downstream_row["latitude"])),
        ]
    )


def _station_point(station_row) -> Point:
    return Point(float(station_row["longitude"]), float(station_row["latitude"]))


def _haversine_meters(p1: Point, p2: Point) -> float:
    lat_mean = math.radians((p1.y + p2.y) / 2.0)
    dx = (p2.x - p1.x) * 111320.0 * math.cos(lat_mean)
    dy = (p2.y - p1.y) * 110540.0
    return math.hypot(dx, dy)


def _project_to_nearest_feature(point: Point, features: List[LineString]) -> _Projection:
    best: Optional[_Projection] = None
    for idx, line in enumerate(features):
        t = line.project(point)
        np_ = line.interpolate(t)
        d = _haversine_meters(point, np_)
        if best is None or d < best.dist_m:
            best = _Projection(idx, t, d, np_)
    return best


def _safe_substring(line: LineString, t_a: float, t_b: float) -> Optional[LineString]:
    if line is None or line.is_empty or line.length <= 0:
        return None
    a, b = sorted((t_a, t_b))
    a = max(0.0, min(a, line.length))
    b = max(0.0, min(b, line.length))
    if b - a < 1e-9:
        return None
    seg = substring(line, a, b)
    if seg is None or seg.is_empty:
        return None
    return seg


def _bridge_two_features(
    line_a: LineString, t_a: float, line_b: LineString, t_b: float
) -> Optional[LineString]:
    a_start = Point(line_a.coords[0])
    a_end = Point(line_a.coords[-1])
    b_start = Point(line_b.coords[0])
    b_end = Point(line_b.coords[-1])

    use_a_end = a_end.distance(line_b) <= a_start.distance(line_b)
    use_b_start = b_start.distance(line_a) <= b_end.distance(line_a)

    upstream_part = _safe_substring(line_a, t_a, line_a.length if use_a_end else 0.0)
    downstream_part = _safe_substring(
        line_b, 0.0 if use_b_start else line_b.length, t_b
    )

    coords: List[tuple] = []
    if upstream_part is not None:
        coords.extend(upstream_part.coords)
    if downstream_part is not None:
        for c in downstream_part.coords:
            if not coords or coords[-1] != c:
                coords.append(c)
    if len(coords) < 2:
        return None
    return LineString(coords)


def _real_river_geometry(
    features: List[LineString], proj_a: _Projection, proj_b: _Projection
) -> Optional[LineString]:
    if proj_a.feature_idx == proj_b.feature_idx:
        geom = _safe_substring(features[proj_a.feature_idx], proj_a.t_along, proj_b.t_along)
    else:
        geom = _bridge_two_features(
            features[proj_a.feature_idx], proj_a.t_along,
            features[proj_b.feature_idx], proj_b.t_along,
        )
    if geom is None or geom.is_empty:
        return None
    return geom


def _segment_id(river_id, upstream_site_id, downstream_site_id) -> str:
    return f"{river_id}-{upstream_site_id}-{downstream_site_id}"


def _replace_endpoint_if_close(
    coords: List[tuple],
    station_point: Point,
    endpoint_index: int,
) -> None:
    endpoint = Point(coords[endpoint_index])
    if _haversine_meters(station_point, endpoint) <= ROUTE_ENDPOINT_SNAP_TOLERANCE_M:
        coords[endpoint_index] = (station_point.x, station_point.y)


def _snap_segment_geometry_to_stations(
    geom: LineString,
    upstream_row,
    downstream_row,
) -> LineString:
    if geom is None or geom.is_empty or geom.geom_type != "LineString":
        return geom

    coords = list(geom.coords)
    if len(coords) < 2:
        return geom

    _replace_endpoint_if_close(coords, _station_point(upstream_row), 0)
    _replace_endpoint_if_close(coords, _station_point(downstream_row), -1)
    return LineString(coords)


def _index_curated_routes(
    route_gdf: Optional[gpd.GeoDataFrame],
) -> Dict[str, LineString]:
    if route_gdf is None or len(route_gdf) == 0:
        return {}
    routes = route_gdf.copy()
    if routes.crs is not None and str(routes.crs).upper() != "EPSG:4326":
        routes = routes.to_crs("EPSG:4326")

    out: Dict[str, LineString] = {}
    for _, row in routes.iterrows():
        geom = row.geometry
        if (
            geom is None
            or geom.is_empty
            or geom.geom_type not in ("LineString", "MultiLineString")
        ):
            continue

        segment_id = _to_str_or_none(row.get("segment_id"))
        if not segment_id:
            river_id = _to_str_or_none(row.get("river_id"))
            upstream_site_id = _to_str_or_none(row.get("upstream_site_id"))
            downstream_site_id = _to_str_or_none(row.get("downstream_site_id"))
            if not river_id or not upstream_site_id or not downstream_site_id:
                continue
            segment_id = _segment_id(river_id, upstream_site_id, downstream_site_id)

        out[segment_id] = geom
    return out


def _index_river_features(
    wra_gdf: gpd.GeoDataFrame, moenv_river_names
) -> Dict[str, List[LineString]]:
    if wra_gdf is None or len(wra_gdf) == 0:
        return {}
    wanted = {RIVER_NAME_ALIAS.get(name, name): name for name in moenv_river_names}
    wra_filtered = wra_gdf[wra_gdf["NAME"].isin(wanted.keys())]
    if wra_filtered.empty:
        return {}
    if wra_filtered.crs is not None and str(wra_filtered.crs).upper() != "EPSG:4326":
        wra_filtered = wra_filtered.to_crs("EPSG:4326")
    out: Dict[str, List[LineString]] = {}
    for wra_name, group in wra_filtered.groupby("NAME"):
        feats = [
            g
            for g in group.geometry.values
            if g is not None and not g.is_empty and g.geom_type == "LineString"
        ]
        if feats:
            out[wanted[wra_name]] = feats
    return out


def build_river_segments(
    latest_df: pd.DataFrame,
    wra_gdf: Optional[gpd.GeoDataFrame] = None,
    route_gdf: Optional[gpd.GeoDataFrame] = None,
) -> pd.DataFrame:
    empty = pd.DataFrame(columns=_SEGMENT_COLUMNS)
    if latest_df is None or latest_df.empty:
        return empty

    df = latest_df.dropna(
        subset=["river_id", "station_order", "longitude", "latitude", "rpi_value"]
    ).copy()
    if df.empty:
        return empty

    df["river"] = df["river"].fillna("")
    df["station_order"] = df["station_order"].astype(int)

    river_features = _index_river_features(wra_gdf, df["river"].unique().tolist())
    curated_routes = _index_curated_routes(route_gdf)

    rows: List[dict] = []
    for (river_id, river_name), group in df.groupby(["river_id", "river"], dropna=False):
        if not river_id:
            continue
        features = river_features.get(river_name)
        ordered = group.sort_values("station_order").to_dict(orient="records")

        projections: List[Optional[_Projection]] = [None] * len(ordered)
        if features:
            for i, station in enumerate(ordered):
                pt = Point(float(station["longitude"]), float(station["latitude"]))
                proj = _project_to_nearest_feature(pt, features)
                if proj.dist_m <= STATION_OFF_RIVER_TOLERANCE_M:
                    projections[i] = proj

        if not features or all(p is None for p in projections):
            logger.warning(
                (
                    "River %r: no WRA features matched within tolerance; "
                    "%d segments use straight_line."
                ),
                river_name,
                max(0, len(ordered) - 1),
            )

        for i in range(len(ordered) - 1):
            s_a, s_b = ordered[i], ordered[i + 1]
            segment_id = _segment_id(river_id, s_a["site_id"], s_b["site_id"])
            curated_geom = curated_routes.get(segment_id)
            if curated_geom is not None:
                curated_geom = _snap_segment_geometry_to_stations(
                    curated_geom,
                    s_a,
                    s_b,
                )
                rows.append(
                    _segment_row(
                        river_id,
                        river_name,
                        s_a,
                        s_b,
                        curated_geom,
                        GEOMETRY_SOURCE_CURATED_ROUTE,
                    )
                )
                continue

            proj_a, proj_b = projections[i], projections[i + 1]
            geom = None
            if features and proj_a is not None and proj_b is not None:
                geom = _real_river_geometry(features, proj_a, proj_b)
            if geom is not None:
                geom = _snap_segment_geometry_to_stations(geom, s_a, s_b)
                source = GEOMETRY_SOURCE_REAL_RIVER
            else:
                geom = _straight_line_segment(s_a, s_b)
                source = GEOMETRY_SOURCE_STRAIGHT_LINE
            rows.append(_segment_row(river_id, river_name, s_a, s_b, geom, source))

    if not rows:
        return empty
    return pd.DataFrame(rows, columns=_SEGMENT_COLUMNS).drop_duplicates(
        subset=["segment_id"], keep="first"
    )


_SITE_GEOJSON_PROPS = [
    "site_id",
    "site_name",
    "city",
    "district",
    "basin",
    "river",
    "wq_std_grade",
    "sample_month",
    "rpi_value",
    "risk_level",
    "rpi_flag",
    "source_name",
    "data_time",
]

_SEGMENT_GEOJSON_PROPS = [
    "segment_id",
    "river_id",
    "river",
    "basin",
    "upstream_site_id",
    "upstream_site_name",
    "upstream_city",
    "upstream_rpi",
    "downstream_site_id",
    "downstream_site_name",
    "downstream_city",
    "downstream_rpi",
    "sample_month",
    "geometry_source",
    "data_time",
]


def export_geojson_layers(
    latest_gdf: gpd.GeoDataFrame,
    segments_gdf: Optional[gpd.GeoDataFrame],
    out_dir: str = "/opt/airflow/fe_mapData",
) -> None:
    os.makedirs(out_dir, exist_ok=True)
    taipei = TARGET_CITIES[0]

    sites = latest_gdf[latest_gdf["wkb_geometry"].notna()].copy()
    sites["sample_month"] = sites["sample_month"].map(_iso_or_none)

    segs_taipei_path = os.path.join(out_dir, "env_river_segments_taipei.geojson")
    segs_metro_path = os.path.join(out_dir, "env_river_segments_metrotaipei.geojson")
    if segments_gdf is None or segments_gdf.empty:
        _write_empty_collection(os.path.join(out_dir, "env_river_sites_taipei.geojson"))
        _write_empty_collection(
            os.path.join(out_dir, "env_river_sites_metrotaipei.geojson")
        )
        _write_empty_collection(segs_taipei_path)
        _write_empty_collection(segs_metro_path)
        return

    segs = segments_gdf[segments_gdf["wkb_geometry"].notna()].copy()
    segs["sample_month"] = segs["sample_month"].map(_iso_or_none)
    segs = _segments_connected_to_sites(segs, sites)

    segs_taipei = segs[
        (segs["upstream_city"] == taipei) & (segs["downstream_city"] == taipei)
    ]
    taipei_site_ids = _connected_site_ids_from_segments(segs_taipei, sites)
    metro_site_ids = _connected_site_ids_from_segments(segs, sites)

    _write_geojson(
        sites[(sites["city"] == taipei) & (sites["site_id"].isin(taipei_site_ids))],
        _SITE_GEOJSON_PROPS,
        os.path.join(out_dir, "env_river_sites_taipei.geojson"),
    )
    _write_geojson(
        sites[sites["site_id"].isin(metro_site_ids)],
        _SITE_GEOJSON_PROPS,
        os.path.join(out_dir, "env_river_sites_metrotaipei.geojson"),
    )
    _write_geojson(segs_taipei, _SEGMENT_GEOJSON_PROPS, segs_taipei_path)
    _write_geojson(segs, _SEGMENT_GEOJSON_PROPS, segs_metro_path)


def _site_ids_from_segments(segs: gpd.GeoDataFrame) -> set:
    if segs is None or segs.empty:
        return set()
    upstream = set(segs["upstream_site_id"].dropna().astype(str))
    downstream = set(segs["downstream_site_id"].dropna().astype(str))
    return upstream | downstream


def _connected_site_ids_from_segments(
    segs: gpd.GeoDataFrame,
    sites: gpd.GeoDataFrame,
) -> set:
    if segs is None or segs.empty or sites is None or sites.empty:
        return set()

    site_points = {
        str(row.site_id): row.wkb_geometry
        for row in sites[["site_id", "wkb_geometry"]].itertuples()
        if row.wkb_geometry is not None and not row.wkb_geometry.is_empty
    }

    connected = set()
    for row in segs.itertuples():
        geom = row.wkb_geometry
        if geom is None or geom.is_empty or geom.geom_type != "LineString":
            continue
        endpoints = (
            (str(row.upstream_site_id), Point(geom.coords[0])),
            (str(row.downstream_site_id), Point(geom.coords[-1])),
        )
        for site_id, endpoint in endpoints:
            site_point = site_points.get(site_id)
            if site_point is None:
                continue
            if (
                _endpoint_is_connected_to_site(site_point, endpoint)
            ):
                connected.add(site_id)
    return connected


def _segments_connected_to_sites(
    segs: gpd.GeoDataFrame,
    sites: gpd.GeoDataFrame,
) -> gpd.GeoDataFrame:
    if segs is None or segs.empty or sites is None or sites.empty:
        return segs

    site_points = {
        str(row.site_id): row.wkb_geometry
        for row in sites[["site_id", "wkb_geometry"]].itertuples()
        if row.wkb_geometry is not None and not row.wkb_geometry.is_empty
    }
    keep_indexes = []
    for idx, row in segs.iterrows():
        geom = row["wkb_geometry"]
        if geom is None or geom.is_empty or geom.geom_type != "LineString":
            continue
        upstream = site_points.get(str(row["upstream_site_id"]))
        downstream = site_points.get(str(row["downstream_site_id"]))
        if upstream is None or downstream is None:
            continue
        if _endpoint_is_connected_to_site(upstream, Point(geom.coords[0])) and (
            _endpoint_is_connected_to_site(downstream, Point(geom.coords[-1]))
        ):
            keep_indexes.append(idx)

    return segs.loc[keep_indexes].copy()


def _endpoint_is_connected_to_site(site_point: Point, endpoint: Point) -> bool:
    return _haversine_meters(site_point, endpoint) <= SITE_ENDPOINT_EXPORT_TOLERANCE_M


def _iso_or_none(value):
    if pd.isna(value):
        return None
    if hasattr(value, "isoformat"):
        return value.isoformat()
    return str(value)


def _write_geojson(gdf: gpd.GeoDataFrame, props: List[str], path: str) -> None:
    if gdf is None or gdf.empty:
        _write_empty_collection(path)
        return
    cols = [c for c in props if c in gdf.columns]
    out = gpd.GeoDataFrame(
        gdf[cols + ["wkb_geometry"]].rename(columns={"wkb_geometry": "geometry"}),
        geometry="geometry",
        crs="EPSG:4326",
    )
    out.to_file(path, driver="GeoJSON")


def _write_empty_collection(path: str) -> None:
    with open(path, "w", encoding="utf-8") as fh:
        json.dump({"type": "FeatureCollection", "features": []}, fh, ensure_ascii=False)


def _segment_row(river_id, river_name, upstream, downstream, geom, source) -> dict:
    return {
        "segment_id": _segment_id(river_id, upstream["site_id"], downstream["site_id"]),
        "river_id": river_id,
        "river": river_name,
        "basin": upstream["basin"],
        "upstream_site_id": upstream["site_id"],
        "upstream_site_name": upstream["site_name"],
        "upstream_city": upstream["city"],
        "upstream_rpi": float(upstream["rpi_value"]) if pd.notna(upstream["rpi_value"]) else None,
        "downstream_site_id": downstream["site_id"],
        "downstream_site_name": downstream["site_name"],
        "downstream_city": downstream["city"],
        "downstream_rpi": (
            float(downstream["rpi_value"])
            if pd.notna(downstream["rpi_value"])
            else None
        ),
        "sample_month": upstream["sample_month"],
        "geometry_source": source,
        "data_time": upstream["data_time"],
        "wkb_geometry": geom,
    }
