-- =============================================================================
-- EV Charging Tables — dashboard DB (postgres-data)
--
-- This file is for reference only. The actual table creation and data loading
-- is handled by load_ev_charging.py (which runs DROP + CREATE + INSERT).
--
-- To load data, run:
--   docker compose --env-file docker/.env \
--     -f docker/docker-compose-ev-charging.yaml up --build
-- =============================================================================

-- ---------------------------------------------------------------------------
-- Map layer: one row per station
-- max_power_bucket drives map dot colour (slow_ac / medium_dc / fast_dc / ultra_fast_dc)
-- power_summary (jsonb) drives popup power count breakdown
-- power_detail  (jsonb) drives popup per-kW detail list
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.env_ev_charging_stations (
    station_id            text PRIMARY KEY,
    station_name          text,
    city                  text,
    district              text,
    address               text,
    operator_id           text,
    operation_type        integer,
    spaces                integer,
    charging_point_count  integer,
    connector_count       integer,
    max_power_kw          numeric,
    max_power_bucket      text,
    power_summary         jsonb,
    power_detail          jsonb,
    service_time          text,
    parking_rate          text,
    charging_rate         text,
    floors                text,
    telephone             text,
    longitude             numeric,
    latitude              numeric,
    source_name           text,
    data_time             timestamptz,
    wkb_geometry          geometry(Point, 4326)
);

CREATE INDEX IF NOT EXISTS idx_ev_stations_city
    ON public.env_ev_charging_stations (city);
CREATE INDEX IF NOT EXISTS idx_ev_stations_district
    ON public.env_ev_charging_stations (district);
CREATE INDEX IF NOT EXISTS idx_ev_stations_max_power_bucket
    ON public.env_ev_charging_stations (max_power_bucket);
CREATE INDEX IF NOT EXISTS idx_ev_stations_geometry
    ON public.env_ev_charging_stations USING GIST (wkb_geometry);

-- ---------------------------------------------------------------------------
-- Dashboard chart: station / point / connector counts by district
-- city_scope: 'taipei' (臺北市 only) or 'twin_city' (臺北市 + 新北市)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.env_ev_charging_district_summary (
    city_scope            text NOT NULL,
    city                  text NOT NULL,
    district              text NOT NULL,
    station_count         integer,
    charging_point_count  integer,
    connector_count       integer,
    data_time             timestamptz,
    PRIMARY KEY (city_scope, city, district)
);

-- ---------------------------------------------------------------------------
-- Dashboard chart: connector count + ratio by power bucket per district
-- Used by BarPercentChart. power_bucket_order ensures stable series order.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.env_ev_charging_connector_power_district (
    city_scope            text NOT NULL,
    city                  text NOT NULL,
    district              text NOT NULL,
    power_bucket          text NOT NULL,
    power_bucket_order    integer,
    connector_count       integer,
    connector_ratio       numeric,
    data_time             timestamptz,
    PRIMARY KEY (city_scope, city, district, power_bucket)
);
