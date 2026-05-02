"""
Manual script: generate GeoJSON map files for the streetlight dashboard.

Run AFTER both TPE and NTPE ETL DAGs have completed successfully.

Usage (inside airflow-worker container):
    docker exec develop-airflow-worker-default-1 python \\
        /opt/airflow/dags/proj_city_dashboard/streetlight_watt_tpe/generate_geojson.py

Then copy to FE:
    docker cp develop-airflow-worker-default-1:/tmp/mapData/streetlight_watt_tpe.geojson \\
        Taipei-City-Dashboard-FE/public/mapData/
    docker cp develop-airflow-worker-default-1:/tmp/mapData/streetlight_watt_metrotaipei.geojson \\
        Taipei-City-Dashboard-FE/public/mapData/

DB connection reads from environment variables:
    DB_DASHBOARD_HOST, DB_DASHBOARD_PORT, DB_DASHBOARD_USER,
    DB_DASHBOARD_PASSWORD, DB_DASHBOARD_DBNAME
(set in Taipei-City-Dashboard-DE/docker/develop/.env)
"""

import json
import os
from pathlib import Path

from sqlalchemy import create_engine, text


TPE_QUERY = """
    SELECT serial_no, district, light_height, watt, watt_bucket, watt_bucket_order,
           lon, lat
    FROM env_streetlight_assets_tpe
    ORDER BY serial_no
"""

NTPE_QUERY = """
    SELECT serial_no, district, watt, watt_bucket, watt_bucket_order, lon, lat
    FROM env_streetlight_assets_ntpe
    ORDER BY serial_no
"""


def _row_to_feature_tpe(row):
    props = {
        "serial_no": row["serial_no"],
        "district":  row["district"],
        "watt":      float(row["watt"]),
        "level":     f"{row['watt_bucket_order']}-{row['watt_bucket']}",
    }
    if row["light_height"] is not None:
        props["light_height"] = float(row["light_height"])

    return {
        "type": "Feature",
        "geometry": {
            "type": "Point",
            "coordinates": [float(row["lon"]), float(row["lat"])],
        },
        "properties": props,
    }


def _row_to_feature_ntpe(row):
    return {
        "type": "Feature",
        "geometry": {
            "type": "Point",
            "coordinates": [float(row["lon"]), float(row["lat"])],
        },
        "properties": {
            "serial_no": row["serial_no"],
            "district":  row["district"],
            "watt":      float(row["watt"]),
            "level":     f"{row['watt_bucket_order']}-{row['watt_bucket']}",
        },
    }


def _write_geojson(features, out_path: Path):
    geojson = {
        "type": "FeatureCollection",
        "features": features,
    }
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(geojson, f, ensure_ascii=False, separators=(",", ":"))
    size_mb = out_path.stat().st_size / 1024 / 1024
    print(f"{out_path.name}  ({size_mb:.1f} MB,  {len(features):,} features)")


def generate(db_uri: str, out_dir: Path):
    engine = create_engine(db_uri)

    with engine.connect() as conn:
        # TPE only
        tpe_rows = conn.execute(text(TPE_QUERY)).mappings().all()
        tpe_features = [_row_to_feature_tpe(r) for r in tpe_rows]
        _write_geojson(tpe_features, out_dir / "streetlight_watt_tpe.geojson")

        # Metro Taipei (TPE + NTPE)
        ntpe_rows = conn.execute(text(NTPE_QUERY)).mappings().all()
        ntpe_features = [_row_to_feature_ntpe(r) for r in ntpe_rows]
        _write_geojson(
            tpe_features + ntpe_features,
            out_dir / "streetlight_watt_metrotaipei.geojson",
        )


def _db_uri_from_env() -> str:
    host = os.environ.get("DB_DASHBOARD_HOST", "postgres-data")
    port = os.environ.get("DB_DASHBOARD_PORT", "5432")
    user = os.environ.get("DB_DASHBOARD_USER", "postgres")
    password = os.environ.get("DB_DASHBOARD_PASSWORD", "")
    dbname = os.environ.get("DB_DASHBOARD_DBNAME", "dashboard")
    return f"postgresql://{user}:{password}@{host}:{port}/{dbname}"


if __name__ == "__main__":
    generate(_db_uri_from_env(), Path("/tmp/mapData"))
