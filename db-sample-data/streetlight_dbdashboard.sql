-- DBDashboard setup for streetlight wattage dashboard
-- Target: postgres-data:5432, db: dashboard
-- Run (first time):
--   docker exec -i postgres-data psql -U postgres -d dashboard < db-sample-data/streetlight_dbdashboard.sql
-- Run (reset / re-deploy):
--   docker exec -i postgres-data psql -U postgres -d dashboard -c \
--     "DROP TABLE IF EXISTS env_streetlight_district_watt_bucket, env_streetlight_district_summary, env_streetlight_assets_ntpe, env_streetlight_assets_tpe CASCADE;"
--   docker exec -i postgres-data psql -U postgres -d dashboard < db-sample-data/streetlight_dbdashboard.sql

CREATE TABLE IF NOT EXISTS env_streetlight_assets_tpe (
    serial_no         text        NOT NULL,
    district          text        NOT NULL,
    light_height      numeric,
    light_year        int,
    light_type        text,
    watt              numeric     NOT NULL,
    watt_bucket       text        NOT NULL,
    watt_bucket_order int         NOT NULL,
    lon               numeric     NOT NULL,
    lat               numeric     NOT NULL,
    data_time         text        NOT NULL
);

CREATE TABLE IF NOT EXISTS env_streetlight_assets_ntpe (
    serial_no         text        NOT NULL,
    district          text        NOT NULL,
    watt              numeric     NOT NULL,
    watt_bucket       text        NOT NULL,
    watt_bucket_order int         NOT NULL,
    lon               numeric     NOT NULL,
    lat               numeric     NOT NULL,
    data_time         text        NOT NULL
);

CREATE TABLE IF NOT EXISTS env_streetlight_district_summary (
    city_scope   text     NOT NULL,
    district     text     NOT NULL,
    avg_watt     numeric  NOT NULL,
    lamp_count   int      NOT NULL,
    PRIMARY KEY (city_scope, district)
);

CREATE TABLE IF NOT EXISTS env_streetlight_district_watt_bucket (
    city_scope        text     NOT NULL,
    district          text     NOT NULL,
    watt_bucket       text     NOT NULL,
    watt_bucket_order int      NOT NULL,
    total_watt        numeric  NOT NULL,
    lamp_count        int      NOT NULL,
    PRIMARY KEY (city_scope, district, watt_bucket)
);

-- Register DAGs in dataset_info (updated by ETL on each run)
INSERT INTO dataset_info (id, psql_table_name, name_cn, airflow_dag_id,
    maintain_type, source, source_type, source_department,
    gis_format, coordinate, is_geometry, dataset_description, etl_description, sensitivity)
VALUES
    (
        'proj_city_dashboard_streetlight_watt_tpe',
        'env_streetlight_assets_tpe',
        '臺北市路燈瓦數分布',
        'proj_city_dashboard_streetlight_watt_tpe',
        'replace',
        'https://tppkl.blob.core.windows.net/blobfs/TaipeiLight.json',
        'static json',
        '臺北市工務局',
        'Point',
        'WGS84',
        '1',
        '臺北市各行政區路燈位置與瓦數資料，一筆記錄代表一根燈桿。',
        '清理瓦數字串，計算每桿總瓦數，轉換 TWD97 座標，刷新行政區聚合表。',
        'public'
    ),
    (
        'proj_new_taipei_city_dashboard_streetlight_watt_ntpe',
        'env_streetlight_assets_ntpe',
        '新北市路燈瓦數分布',
        'proj_new_taipei_city_dashboard_streetlight_watt_ntpe',
        'replace',
        'https://data.ntpc.gov.tw/api/datasets/39149fe0-85ab-4e6c-99e5-60657d44895f/json',
        'paginated json api',
        '新北市工務局',
        'Point',
        'WGS84',
        '1',
        '新北市各行政區路燈位置與瓦數資料，一筆記錄代表一盞路燈。',
        '分頁抓取新北開放資料 API，清理瓦數字串，刷新雙北合併聚合表。',
        'public'
    )
ON CONFLICT (id) DO NOTHING;
