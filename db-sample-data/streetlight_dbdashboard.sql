-- ============================================================
-- 雙北路燈瓦數分布 — DBDashboard 建表
-- 目標：postgres-data:5432 / database: dashboard
--
-- 執行指令（從專案根目錄）：
--   docker exec -i postgres-data \
--     psql -U postgres -d dashboard \
--     < db-sample-data/streetlight_dbdashboard.sql
-- ============================================================

-- 路燈明細表（台北市）
CREATE TABLE IF NOT EXISTS public.env_streetlight_assets_tpe (
    light_id          text,
    source_name       text,
    city              text,
    district          text,
    address           text,
    light_type        text,
    watt              numeric,
    watt_bucket       text,
    watt_bucket_order integer,
    pole_height       numeric,
    light_year        integer,
    longitude         numeric,
    latitude          numeric,
    data_time         timestamptz,
    wkb_geometry      public.geometry(Point, 4326),
    ogc_fid           serial PRIMARY KEY
);

-- 路燈明細表（新北市）
CREATE TABLE IF NOT EXISTS public.env_streetlight_assets_ntpe (
    light_id          text,
    source_name       text,
    city              text,
    district          text,
    address           text,
    light_type        text,
    watt              numeric,
    watt_bucket       text,
    watt_bucket_order integer,
    pole_height       numeric,
    light_year        integer,
    longitude         numeric,
    latitude          numeric,
    data_time         timestamptz,
    wkb_geometry      public.geometry(Point, 4326),
    ogc_fid           serial PRIMARY KEY
);

-- 行政區聚合表
CREATE TABLE IF NOT EXISTS public.env_streetlight_district_summary (
    city_scope          text,
    city                text,
    district            text,
    light_count         integer,
    avg_watt            numeric,
    median_watt         numeric,
    unknown_watt_count  integer,
    data_time           timestamptz
);

-- 瓦數級距聚合表
CREATE TABLE IF NOT EXISTS public.env_streetlight_watt_bucket_summary (
    city_scope          text,
    watt_bucket         text,
    watt_bucket_order   integer,
    light_count         integer,
    light_ratio         numeric,
    data_time           timestamptz
);

-- ETL metadata 表（CommonDag 的 update_dataset_info task 會 upsert 此表）
CREATE TABLE IF NOT EXISTS public.dataset_info (
    id                   text PRIMARY KEY,
    psql_table_name      text,
    name_cn              text,
    airflow_dag_id       text,
    mongo_collection     text,
    maintain_type        text,
    airflow_update_freq  text,
    source               text,
    source_type          text,
    source_department    text,
    gis_format           text,
    coordinate           text,
    is_geometry          text,
    dataset_description  text,
    etl_description      text,
    sensitivity          text,
    schedule_interval    text,
    lasttime_in_data     timestamptz,
    resource_updatetime  timestamptz
);
