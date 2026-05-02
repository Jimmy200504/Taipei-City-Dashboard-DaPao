import re

import pandas as pd
from operators.common_pipeline import CommonDag
from sqlalchemy import create_engine, text as sa_text
from utils.extract_stage import NewTaipeiAPIClient
from utils.get_time import get_tpe_now_time_str
from utils.load_stage import (
    save_geodataframe_to_postgresql,
    update_lasttime_in_data_to_dataset_info,
)
from utils.transform_geometry import add_point_wkbgeometry_column_to_df

RID = "39149fe0-85ab-4e6c-99e5-60657d44895f"
GEOMETRY_TYPE = "Point"

BUCKET_ORDER = {
    "ultra_low": 1,
    "low": 2,
    "medium": 3,
    "high": 4,
    "very_high": 5,
    "unknown": 6,
}


def _parse_watt(s):
    if pd.isnull(s):
        return None
    cleaned = re.sub(r"[Ww\s,]", "", str(s))
    try:
        return float(cleaned)
    except ValueError:
        return None


def _classify_bucket(w):
    if pd.isnull(w):
        return "unknown", 6
    if w <= 30:
        return "ultra_low", 1
    if w <= 80:
        return "low", 2
    if w <= 150:
        return "medium", 3
    if w <= 250:
        return "high", 4
    return "very_high", 5


_DISTRICT_INSERT_SQL = """
INSERT INTO env_streetlight_district_summary
    (city_scope, city, district, light_count, avg_watt, median_watt, unknown_watt_count, data_time)
SELECT
    'taipei' AS city_scope,
    city,
    district,
    COUNT(*) AS light_count,
    ROUND(AVG(watt) FILTER (WHERE watt IS NOT NULL), 2) AS avg_watt,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY watt) FILTER (WHERE watt IS NOT NULL) AS median_watt,
    COUNT(*) FILTER (WHERE watt IS NULL) AS unknown_watt_count,
    MAX(data_time) AS data_time
FROM env_streetlight_assets_tpe
GROUP BY city, district
UNION ALL
SELECT
    'twin_city' AS city_scope,
    city,
    district,
    COUNT(*) AS light_count,
    ROUND(AVG(watt) FILTER (WHERE watt IS NOT NULL), 2) AS avg_watt,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY watt) FILTER (WHERE watt IS NOT NULL) AS median_watt,
    COUNT(*) FILTER (WHERE watt IS NULL) AS unknown_watt_count,
    MAX(data_time) AS data_time
FROM (
    SELECT city, district, watt, data_time FROM env_streetlight_assets_tpe
    UNION ALL
    SELECT city, district, watt, data_time FROM env_streetlight_assets_ntpe
) combined
GROUP BY city, district
"""

_BUCKET_INSERT_SQL = """
INSERT INTO env_streetlight_watt_bucket_summary
    (city_scope, watt_bucket, watt_bucket_order, light_count, light_ratio, data_time)
WITH base AS (
    SELECT 'taipei'    AS scope, watt_bucket, watt_bucket_order, data_time FROM env_streetlight_assets_tpe
    UNION ALL
    SELECT 'twin_city' AS scope, watt_bucket, watt_bucket_order, data_time FROM env_streetlight_assets_tpe
    UNION ALL
    SELECT 'twin_city' AS scope, watt_bucket, watt_bucket_order, data_time FROM env_streetlight_assets_ntpe
),
totals AS (
    SELECT scope, COUNT(*) AS total_count FROM base GROUP BY scope
)
SELECT
    b.scope,
    b.watt_bucket,
    b.watt_bucket_order,
    COUNT(*) AS light_count,
    ROUND(COUNT(*)::numeric / t.total_count, 4) AS light_ratio,
    MAX(b.data_time) AS data_time
FROM base b
JOIN totals t ON b.scope = t.scope
GROUP BY b.scope, b.watt_bucket, b.watt_bucket_order, t.total_count
"""


def _build_summary_tables(engine):
    with engine.begin() as conn:
        conn.execute(sa_text("TRUNCATE TABLE env_streetlight_district_summary"))
        conn.execute(sa_text(_DISTRICT_INSERT_SQL))
        conn.execute(sa_text("TRUNCATE TABLE env_streetlight_watt_bucket_summary"))
        conn.execute(sa_text(_BUCKET_INSERT_SQL))
    print("Summary tables rebuilt.")


def _transfer(**kwargs):
    ready_data_db_uri = kwargs.get("ready_data_db_uri")
    dag_infos = kwargs.get("dag_infos")
    dag_id = dag_infos.get("dag_id")
    load_behavior = dag_infos.get("load_behavior")
    default_table = dag_infos.get("ready_data_default_table")
    history_table = dag_infos.get("ready_data_history_table")

    # Extract（~280k 筆，需時數分鐘）
    client = NewTaipeiAPIClient(RID, input_format="json")
    raw = client.get_all_data(size=1000)
    df = pd.DataFrame(raw)
    print(f"NTPC raw rows: {len(df)}")

    # Transform
    df["watt"] = df["power"].apply(_parse_watt)
    bucket_result = df["watt"].apply(_classify_bucket)
    df["watt_bucket"] = bucket_result.apply(lambda x: x[0])
    df["watt_bucket_order"] = bucket_result.apply(lambda x: x[1])

    df["longitude"] = pd.to_numeric(df["longitude"], errors="coerce")
    df["latitude"] = pd.to_numeric(df["latitude"], errors="coerce")
    df["pole_height"] = pd.to_numeric(df["height"] if "height" in df.columns else None, errors="coerce")

    # 過濾無效座標
    df = df[df["longitude"].notna() & df["latitude"].notna()].reset_index(drop=True)

    gdf = add_point_wkbgeometry_column_to_df(df, df["longitude"], df["latitude"], from_crs=4326)

    data_time = get_tpe_now_time_str(is_with_tz=True)
    gdf["light_id"] = gdf["seqno"].astype(str)
    gdf["city"] = "新北市"
    gdf["district"] = gdf["town"].astype(str)
    gdf["address"] = gdf["address"].astype(str)
    gdf["light_type"] = "unknown"
    gdf["light_year"] = None
    gdf["source_name"] = "新北市路燈資料"
    gdf["data_time"] = pd.Timestamp(data_time)

    final_cols = [
        "light_id", "source_name", "city", "district", "address",
        "light_type", "watt", "watt_bucket", "watt_bucket_order",
        "pole_height", "light_year", "longitude", "latitude",
        "data_time", "wkb_geometry",
    ]
    final_df = gdf[final_cols].copy()
    final_df = final_df[final_df["wkb_geometry"].notna()].reset_index(drop=True)
    print(f"NTPC ready rows: {len(final_df)}")

    engine = create_engine(ready_data_db_uri)
    save_geodataframe_to_postgresql(
        engine,
        gdata=final_df,
        load_behavior=load_behavior,
        default_table=default_table,
        history_table=history_table,
        geometry_type=GEOMETRY_TYPE,
    )

    # 兩張聚合表（此步驟依賴 env_streetlight_assets_tpe 已存在）
    _build_summary_tables(engine)

    update_lasttime_in_data_to_dataset_info(
        engine,
        airflow_dag_id=f"proj_new_taipei_city_dashboard_{dag_id}",
        lasttime_in_data=data_time,
    )


dag = CommonDag(proj_folder="proj_new_taipei_city_dashboard", dag_folder="streetlight_watt_ntpe")
dag.create_dag(etl_func=_transfer)
