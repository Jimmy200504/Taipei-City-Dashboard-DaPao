-- =============================================================================
-- Noise Monitoring Tables — dashboard_data (postgres_default)
-- Run this ONCE before triggering any noise monitoring DAGs.
-- Naming convention: _tpe = 臺北市, _new_tpe = 新北市 (consistent with project)
-- =============================================================================

CREATE TABLE IF NOT EXISTS public.env_noise_stations (
    station_id            text PRIMARY KEY,
    station_name          text,
    city                  text,
    district              text,
    noise_category        text,          -- 'traffic' | 'environmental'
    monitoring_type       text,          -- 'manual' | 'automatic'
    control_zone          text,
    standard_day_db       numeric,
    standard_evening_db   numeric,
    standard_night_db     numeric,
    upload_flag           text,
    total_exceed_count    integer DEFAULT 0,
    latest_year           integer,
    latest_month          integer,
    longitude             numeric,
    latitude              numeric,
    address               text,
    geocode_quality       text,          -- 'open_data' | 'district_centroid'
    source_name           text,
    source_url            text,
    data_time             timestamptz,
    wkb_geometry          geometry(Point, 4326)
);

CREATE INDEX IF NOT EXISTS idx_env_noise_stations_city
    ON public.env_noise_stations (city);

CREATE INDEX IF NOT EXISTS idx_env_noise_stations_geometry
    ON public.env_noise_stations USING GIST (wkb_geometry);

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.env_noise_monthly_measurements (
    id                  bigserial PRIMARY KEY,
    station_id          text,
    city                text,
    district            text,
    noise_category      text,
    measurement_year    integer,
    measurement_month   integer,
    quarter             integer,
    day_db              numeric,
    evening_db          numeric,
    night_db            numeric,
    exceeded_standard   boolean DEFAULT false,
    day_exceeded        boolean DEFAULT false,
    evening_exceeded    boolean DEFAULT false,
    night_exceeded      boolean DEFAULT false,
    quality_flag        text,            -- 'ok' | 'missing' | 'partial'
    data_time           timestamptz,
    UNIQUE (station_id, measurement_year, measurement_month, noise_category)
);

CREATE INDEX IF NOT EXISTS idx_env_noise_meas_station
    ON public.env_noise_monthly_measurements (station_id);

CREATE INDEX IF NOT EXISTS idx_env_noise_meas_year_month
    ON public.env_noise_monthly_measurements (measurement_year, measurement_month);

-- ---------------------------------------------------------------------------
-- Quarterly stats: one table per city (_tpe / _new_tpe)
-- No city_scope column needed — table name encodes the city.
-- metrotaipei query does UNION ALL of both tables.
-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.env_noise_quarterly_stats_tpe (
    id                  bigserial PRIMARY KEY,
    station_name        text,
    noise_category      text,
    year                integer,
    quarter             integer,
    quarter_label       text,            -- e.g. '2025Q1'
    period              text,            -- 'day' | 'evening' | 'night'
    avg_db              numeric,
    data_time           timestamptz
);

CREATE TABLE IF NOT EXISTS public.env_noise_quarterly_stats_new_tpe (
    LIKE public.env_noise_quarterly_stats_tpe INCLUDING ALL
);

-- ---------------------------------------------------------------------------
-- District summary: one table per city
-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.env_noise_district_summary_tpe (
    id                  bigserial PRIMARY KEY,
    district            text,
    noise_category      text,
    year                integer,
    quarter             integer,
    avg_day_db          numeric,
    avg_evening_db      numeric,
    avg_night_db        numeric,
    station_count       integer,
    measurement_count   integer,
    exceed_count        integer,
    exceed_rate         numeric,
    data_time           timestamptz
);

CREATE TABLE IF NOT EXISTS public.env_noise_district_summary_new_tpe (
    LIKE public.env_noise_district_summary_tpe INCLUDING ALL
);
