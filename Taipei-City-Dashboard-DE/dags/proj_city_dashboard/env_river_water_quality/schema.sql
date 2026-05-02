CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE IF NOT EXISTS dataset_info (
    id text PRIMARY KEY,
    psql_table_name text,
    name_cn text,
    airflow_dag_id text UNIQUE,
    mongo_collection text,
    maintain_type text,
    airflow_update_freq text,
    source text,
    source_type text,
    source_department text,
    lasttime_in_data timestamptz,
    resource_updatetime timestamptz,
    gis_format text,
    coordinate text,
    is_geometry integer,
    dataset_description text,
    etl_description text,
    been_used_count integer DEFAULT 0,
    sensitivity text,
    schedule_interval text,
    update_at timestamptz,
    create_at timestamptz,
    _mtime timestamptz DEFAULT now()
);

DROP VIEW IF EXISTS env_river_site_rpi_monthly_latest;
DROP TABLE IF EXISTS env_river_rpi_segments_latest;
DROP TABLE IF EXISTS env_river_rpi_monthly_distribution;
DROP TABLE IF EXISTS env_river_site_rpi_monthly;
DROP TABLE IF EXISTS env_river_water_quality_measurements;
DROP TABLE IF EXISTS env_river_site_rpi_latest;
DROP TABLE IF EXISTS env_river_monitoring_sites;

CREATE TABLE env_river_monitoring_sites (
    source_name text NOT NULL,
    city text,
    district text,
    basin text,
    river text,
    site_id text NOT NULL,
    site_name text,
    site_name_en text,
    site_address text,
    status_of_use text,
    wq_std_grade text,
    longitude numeric,
    latitude numeric,
    data_time timestamptz,
    wkb_geometry geometry(Point, 4326),
    CONSTRAINT env_river_monitoring_sites_pk PRIMARY KEY (site_id)
);

CREATE INDEX env_river_monitoring_sites_geom_idx
    ON env_river_monitoring_sites USING gist (wkb_geometry);

CREATE INDEX env_river_monitoring_sites_city_idx
    ON env_river_monitoring_sites (city);

CREATE TABLE env_river_site_rpi_latest (
    source_name text NOT NULL,
    city text,
    district text,
    basin text,
    river text,
    site_id text NOT NULL,
    site_name text,
    wq_std_grade text,
    sample_month date,
    rpi_value numeric,
    risk_level text,
    risk_level_order integer,
    rpi_flag text,
    data_time timestamptz,
    wkb_geometry geometry(Point, 4326),
    CONSTRAINT env_river_site_rpi_latest_pk PRIMARY KEY (site_id)
);

CREATE INDEX env_river_site_rpi_latest_geom_idx
    ON env_river_site_rpi_latest USING gist (wkb_geometry);

CREATE INDEX env_river_site_rpi_latest_city_idx
    ON env_river_site_rpi_latest (city, risk_level_order);

DROP TABLE IF EXISTS env_river_rpi_segments_latest;

CREATE TABLE env_river_rpi_segments_latest (
    segment_id text NOT NULL,
    river_id text,
    river text,
    basin text,
    upstream_site_id text,
    upstream_site_name text,
    upstream_city text,
    upstream_rpi numeric,
    downstream_site_id text,
    downstream_site_name text,
    downstream_city text,
    downstream_rpi numeric,
    sample_month date,
    geometry_source text DEFAULT 'real_river',
    data_time timestamptz,
    wkb_geometry geometry(LineString, 4326),
    CONSTRAINT env_river_rpi_segments_latest_pk PRIMARY KEY (segment_id)
);

CREATE INDEX env_river_rpi_segments_latest_geom_idx
    ON env_river_rpi_segments_latest USING gist (wkb_geometry);

CREATE INDEX env_river_rpi_segments_latest_river_idx
    ON env_river_rpi_segments_latest (river_id);
