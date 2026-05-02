"""
手動執行腳本：從 DBDashboard 生成路燈 GeoJSON 並寫入前端 public/mapData/。

使用方式A — 本機（postgres-data 需 port-forward 至 5433）：
    DB_DASHBOARD_URI="postgresql://postgres:0410@localhost:5433/dashboard" \\
        python generate_geojson.py

使用方式B — 在 Airflow worker 容器內執行（推薦，可直連 postgres-data）：
    docker exec develop-airflow-worker-default-1 bash -c "
      python -c \\\"
    import sys; sys.path.insert(0, '/opt/airflow/dags/proj_city_dashboard/streetlight_watt_tpe')
    from pathlib import Path
    import generate_geojson
    generate_geojson.generate(
        'postgresql://postgres:0410@postgres-data:5432/dashboard',
        Path('/tmp/mapData')
    )
    \\\"
    "
    docker cp develop-airflow-worker-default-1:/tmp/mapData/streetlight_watt_tpe.geojson \\
        Taipei-City-Dashboard-FE/public/mapData/
    docker cp develop-airflow-worker-default-1:/tmp/mapData/streetlight_watt_metrotaipei.geojson \\
        Taipei-City-Dashboard-FE/public/mapData/
"""

import json
import os
import sys
from pathlib import Path

# ---------------------------------------------------------------------------
# 設定：DB URI 與輸出目錄
# ---------------------------------------------------------------------------
DB_URI = os.environ.get(
    "DB_DASHBOARD_URI",
    "postgresql://postgres:0410@localhost:5433/dashboard",  # 本機 port-forward 預設
)

# 輸出目錄：優先讀取環境變數 OUTPUT_DIR，否則嘗試從腳本位置往上推算。
# 注意：在 Docker 容器內執行時路徑會不同，請直接傳入 output_dir 參數或設定環境變數。
_SCRIPT_DIR = Path(__file__).resolve().parent
_OUTPUT_DIR_ENV = os.environ.get("OUTPUT_DIR")
if _OUTPUT_DIR_ENV:
    OUTPUT_DIR = Path(_OUTPUT_DIR_ENV)
else:
    # 往上 5 層：dags/proj_.../streetlight.../  →  Taipei-City-Dashboard-DaPao/
    _PROJECT_ROOT = _SCRIPT_DIR.parents[4]
    OUTPUT_DIR = _PROJECT_ROOT / "Taipei-City-Dashboard-FE" / "public" / "mapData"

# ---------------------------------------------------------------------------
# GeoJSON 查詢：精簡 properties 以減小檔案大小
# ---------------------------------------------------------------------------
_TPE_QUERY = """
SELECT json_build_object(
    'type', 'FeatureCollection',
    'features', COALESCE(json_agg(
        json_build_object(
            'type', 'Feature',
            'geometry', ST_AsGeoJSON(wkb_geometry)::json,
            'properties', json_build_object(
                'city',       city,
                'district',   district,
                'light_type', light_type,
                'watt',       watt,
                'watt_bucket', watt_bucket,
                'light_year', light_year,
                'data_time',  TO_CHAR(data_time, 'YYYY-MM-DD')
            )
        )
    ), '[]'::json)
) AS geojson
FROM env_streetlight_assets_tpe
WHERE wkb_geometry IS NOT NULL;
"""

_TWIN_CITY_QUERY = """
SELECT json_build_object(
    'type', 'FeatureCollection',
    'features', COALESCE(json_agg(
        json_build_object(
            'type', 'Feature',
            'geometry', ST_AsGeoJSON(wkb_geometry)::json,
            'properties', json_build_object(
                'city',       city,
                'district',   district,
                'light_type', light_type,
                'watt',       watt,
                'watt_bucket', watt_bucket,
                'light_year', light_year,
                'data_time',  TO_CHAR(data_time, 'YYYY-MM-DD')
            )
        )
    ), '[]'::json)
) AS geojson
FROM (
    SELECT city, district, light_type, watt, watt_bucket, light_year, data_time, wkb_geometry
    FROM env_streetlight_assets_tpe
    WHERE wkb_geometry IS NOT NULL
    UNION ALL
    SELECT city, district, light_type, watt, watt_bucket, light_year, data_time, wkb_geometry
    FROM env_streetlight_assets_ntpe
    WHERE wkb_geometry IS NOT NULL
) combined;
"""


def generate(db_uri: str, output_dir: Path) -> None:
    try:
        import psycopg2
    except ImportError:
        print("需要 psycopg2：pip install psycopg2-binary")
        sys.exit(1)

    output_dir.mkdir(parents=True, exist_ok=True)

    conn = psycopg2.connect(db_uri)
    try:
        cur = conn.cursor()

        print("生成 streetlight_watt_tpe.geojson ...")
        cur.execute(_TPE_QUERY)
        tpe_geojson = cur.fetchone()[0]
        out_tpe = output_dir / "streetlight_watt_tpe.geojson"
        with open(out_tpe, "w", encoding="utf-8") as f:
            json.dump(tpe_geojson, f, ensure_ascii=False)
        size_mb = out_tpe.stat().st_size / 1024 / 1024
        print(f"  完成：{out_tpe}  ({size_mb:.1f} MB)")

        print("生成 streetlight_watt_metrotaipei.geojson（包含全量新北市 ~28萬筆，需時較長）...")
        cur.execute(_TWIN_CITY_QUERY)
        twin_geojson = cur.fetchone()[0]
        out_twin = output_dir / "streetlight_watt_metrotaipei.geojson"
        with open(out_twin, "w", encoding="utf-8") as f:
            json.dump(twin_geojson, f, ensure_ascii=False)
        size_mb = out_twin.stat().st_size / 1024 / 1024
        print(f"  完成：{out_twin}  ({size_mb:.1f} MB)")

    finally:
        conn.close()


if __name__ == "__main__":
    generate(DB_URI, OUTPUT_DIR)
