import re
from datetime import date

import pandas as pd
from airflow import DAG
from operators.common_pipeline import CommonDag
from sqlalchemy import create_engine, text
from utils.extract_stage import NewTaipeiAPIClient


RID = "39149fe0-85ab-4e6c-99e5-60657d44895f"

WATT_BUCKETS = [
    (30,  "ultra_low", 1),
    (80,  "low",       2),
    (150, "medium",    3),
    (250, "high",      4),
]


def _parse_watt(raw):
    """power 欄位可能為逗號分隔的多燈值（如 '130,130'），各別解析後加總。"""
    if raw is None:
        return 0.0
    total = 0.0
    for part in str(raw).split(","):
        cleaned = re.sub(r"[^\d.]", "", part.strip())
        try:
            total += float(cleaned) if cleaned else 0.0
        except ValueError:
            pass
    return total


def _assign_bucket(watt):
    for threshold, name, order in WATT_BUCKETS:
        if watt <= threshold:
            return name, order
    return "very_high", 5


def _transfer(**kwargs):
    ready_data_db_uri = kwargs.get("ready_data_db_uri")
    dag_infos = kwargs.get("dag_infos")
    default_table = dag_infos.get("ready_data_default_table")

    # Extract
    client = NewTaipeiAPIClient(RID, input_format="json")
    raw_data = client.get_all_data(size=1000)
    print(f"NTPE raw rows: {len(raw_data)}")

    # Transform
    records = []
    for item in raw_data:
        watt = _parse_watt(item.get("power"))
        if watt == 0:
            continue

        bucket, order = _assign_bucket(watt)

        try:
            lon = float(item["longitude"])
            lat = float(item["latitude"])
        except (TypeError, ValueError, KeyError):
            continue

        records.append({
            "serial_no":         str(item["seqno"]),
            "district":          str(item.get("town", "")).strip(),
            "watt":              round(watt, 1),
            "watt_bucket":       bucket,
            "watt_bucket_order": order,
            "lon":               lon,
            "lat":               lat,
            "data_time":         date.today().isoformat(),
        })

    final_df = pd.DataFrame(records)

    # Load
    engine = create_engine(ready_data_db_uri)
    with engine.begin() as conn:
        conn.execute(text(f"TRUNCATE TABLE {default_table}"))
        final_df.to_sql(default_table, conn, if_exists="append", index=False)

        # Rebuild metrotaipei summaries from scratch (delete avoids stale district rows)
        conn.execute(text("DELETE FROM env_streetlight_district_summary WHERE city_scope = 'metrotaipei'"))
        conn.execute(text("""
            INSERT INTO env_streetlight_district_summary
                (city_scope, district, avg_watt, lamp_count)
            SELECT 'metrotaipei', district,
                   ROUND(AVG(watt)::numeric, 1), COUNT(*)
            FROM (
                SELECT district, watt FROM env_streetlight_assets_tpe
                UNION ALL
                SELECT district, watt FROM env_streetlight_assets_ntpe
            ) combined
            GROUP BY district
        """))

        conn.execute(text("DELETE FROM env_streetlight_district_watt_bucket WHERE city_scope = 'metrotaipei'"))
        conn.execute(text("""
            INSERT INTO env_streetlight_district_watt_bucket
                (city_scope, district, watt_bucket, watt_bucket_order, total_watt, lamp_count)
            SELECT 'metrotaipei', district, watt_bucket, watt_bucket_order,
                   ROUND(SUM(watt)::numeric, 1), COUNT(*)
            FROM (
                SELECT district, watt, watt_bucket, watt_bucket_order
                FROM env_streetlight_assets_tpe
                UNION ALL
                SELECT district, watt, watt_bucket, watt_bucket_order
                FROM env_streetlight_assets_ntpe
            ) combined
            GROUP BY district, watt_bucket, watt_bucket_order
        """))

    print(f"Loaded {len(final_df)} NTPE streetlight records into {default_table}")


dag = CommonDag(
    proj_folder="proj_new_taipei_city_dashboard",
    dag_folder="streetlight_watt_ntpe",
)
dag.create_dag(etl_func=_transfer)
