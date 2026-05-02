import re
from datetime import date

import pandas as pd
import requests
from airflow import DAG
from operators.common_pipeline import CommonDag
from sqlalchemy import create_engine, text
from utils.transform_geometry import convert_twd97_to_wgs84


WATT_BUCKETS = [
    (30,  "ultra_low", 1),
    (80,  "low",       2),
    (150, "medium",    3),
    (250, "high",      4),
]

TPE_DISTRICTS = {
    "中正", "大同", "中山", "松山", "大安", "萬華",
    "信義", "士林", "北投", "內湖", "南港", "文山",
}
# DistrictChart expects district names with 區 suffix
TPE_DISTRICT_MAP = {d: d + "區" for d in TPE_DISTRICTS}


def _parse_watt(raw):
    if raw is None:
        return 0.0
    cleaned = re.sub(r"[^\d.]", "", str(raw))
    try:
        return float(cleaned) if cleaned else 0.0
    except ValueError:
        return 0.0


def _assign_bucket(watt):
    for threshold, name, order in WATT_BUCKETS:
        if watt <= threshold:
            return name, order
    return "very_high", 5


def _compute_pole_watt(row):
    kinds = [row.get(f"LightKind{i}", "") for i in range(1, 6)]
    watts = [row.get(f"LightWatt{i}", "") for i in range(1, 6)]
    active_kinds = [k for k in kinds if k and str(k).strip()]

    if len(active_kinds) <= 1:
        qty = max(int(row.get("Quantity") or 1), 1)
        return _parse_watt(watts[0]) * qty
    else:
        return sum(_parse_watt(w) for w in watts)


def _transfer(**kwargs):
    ready_data_db_uri = kwargs.get("ready_data_db_uri")
    dag_infos = kwargs.get("dag_infos")
    default_table = dag_infos.get("ready_data_default_table")

    # Extract
    resp = requests.get(
        "https://tppkl.blob.core.windows.net/blobfs/TaipeiLight.json",
        timeout=120,
    )
    resp.raise_for_status()
    raw_data = resp.json()

    # Transform
    records = []
    for item in raw_data:
        district_raw = str(item.get("Dist", "")).strip()
        if district_raw not in TPE_DISTRICTS:
            continue
        district = TPE_DISTRICT_MAP[district_raw]

        watt = _compute_pole_watt(item)
        if watt == 0:
            continue

        bucket, order = _assign_bucket(watt)
        light_types = [
            str(item.get(f"LightKind{i}", "") or "").strip()
            for i in range(1, 6)
        ]
        light_type = ",".join(t for t in light_types if t) or None

        try:
            light_year = int(item["LightYear"]) if item.get("LightYear") else None
        except (ValueError, TypeError):
            light_year = None

        try:
            light_height = float(item["LightHeight"]) if item.get("LightHeight") else None
        except (ValueError, TypeError):
            light_height = None

        records.append({
            "serial_no":        str(item["SerialNumber"]),
            "district":         district,
            "light_height":     light_height,
            "light_year":       light_year,
            "light_type":       light_type,
            "watt":             round(watt, 1),
            "watt_bucket":      bucket,
            "watt_bucket_order": order,
            "TWD97X":           item.get("TWD97X"),
            "TWD97Y":           item.get("TWD97Y"),
            "data_time":        date.today().isoformat(),
        })

    df = pd.DataFrame(records)
    df = df.dropna(subset=["TWD97X", "TWD97Y"])
    df["TWD97X"] = pd.to_numeric(df["TWD97X"], errors="coerce")
    df["TWD97Y"] = pd.to_numeric(df["TWD97Y"], errors="coerce")
    df = df.dropna(subset=["TWD97X", "TWD97Y"])

    lng_series, lat_series = convert_twd97_to_wgs84(df, "TWD97X", "TWD97Y")
    df["lon"] = lng_series.values
    df["lat"] = lat_series.values

    final_df = df[[
        "serial_no", "district", "light_height", "light_year", "light_type",
        "watt", "watt_bucket", "watt_bucket_order", "lon", "lat", "data_time",
    ]]

    # Load
    engine = create_engine(ready_data_db_uri)
    with engine.begin() as conn:
        conn.execute(text(f"TRUNCATE TABLE {default_table}"))
        final_df.to_sql(default_table, conn, if_exists="append", index=False)

        # Rebuild taipei summaries from scratch (delete avoids stale district rows)
        conn.execute(text("DELETE FROM env_streetlight_district_summary WHERE city_scope = 'taipei'"))
        conn.execute(text("""
            INSERT INTO env_streetlight_district_summary
                (city_scope, district, avg_watt, lamp_count)
            SELECT 'taipei', district, ROUND(AVG(watt)::numeric, 1), COUNT(*)
            FROM env_streetlight_assets_tpe
            GROUP BY district
        """))

        conn.execute(text("DELETE FROM env_streetlight_district_watt_bucket WHERE city_scope = 'taipei'"))
        conn.execute(text("""
            INSERT INTO env_streetlight_district_watt_bucket
                (city_scope, district, watt_bucket, watt_bucket_order, total_watt, lamp_count)
            SELECT 'taipei', district, watt_bucket, watt_bucket_order,
                   ROUND(SUM(watt)::numeric, 1), COUNT(*)
            FROM env_streetlight_assets_tpe
            GROUP BY district, watt_bucket, watt_bucket_order
        """))

    print(f"Loaded {len(final_df)} TPE streetlight records into {default_table}")


dag = CommonDag(
    proj_folder="proj_city_dashboard",
    dag_folder="streetlight_watt_tpe",
)
dag.create_dag(etl_func=_transfer)
