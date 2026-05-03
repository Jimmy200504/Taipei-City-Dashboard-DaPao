# Noise Monitoring ETL Pipeline

> Sources: 臺北市環保局 / 新北市環保局規格文件, 2026-05-03
> Raw: [噪音監測與分佈（draft）](../../raw/taipei-dashboard-dataend/噪音監測與分佈.md); [噪音監測與分佈（spec）](../../raw/taipei-dashboard-dataend/2026-05-03-noise-monitoring-spec.md)

## Overview

The environmental noise monitoring component ingests monthly dB measurements from two cities — Taipei (HTML scraping) and New Taipei (PDF parsing) — into four PostgreSQL tables. Three Airflow DAGs handle extraction, transformation, and quarterly aggregation. The pipeline runs monthly for Taipei and yearly for New Taipei (annual report constraint), covering both traffic noise (`traffic`) and environmental noise (`environmental`) categories.

## Data Sources

| City | Source Format | ETL Method | Update Cadence |
|------|--------------|------------|----------------|
| 臺北市 | HTML table at `tldep.gov.taipei` | `requests` + `BeautifulSoup` | Monthly (16th) |
| 新北市 (measurements) | PDF annual report at `epd.ntpc.gov.tw` | `pdfplumber` bbox parsing | Yearly (Jan 1) |
| 新北市 (station addresses) | Static HTML pages (manual + auto stations) | `requests` + `BeautifulSoup` | On new station |

Neither source provides a public API. New Taipei data lags by approximately one year due to the annual report cycle.

## Special Symbol Handling

Raw measurement cells may contain symbols that must be parsed before storing numeric values:

| Symbol | Meaning | ETL Action |
|--------|---------|-----------|
| `-` | No measurement / missing | Store `NULL`; set `quality_flag = 'missing'` |
| `*` | Value exceeds noise standard | Store numeric value; set `exceeded_standard = True` |
| `#` | Station uploads to 環境部 | Capture in `upload_flag` column |
| `&` | Station uploads to SIP | Capture in `upload_flag` column |

Use regex to strip symbols before `float()` conversion. Track flags in separate boolean/text columns.

## Quarter Calculation

Monthly data is aggregated to quarters for the frontend timeline chart:

```python
quarter = (month - 1) // 3 + 1   # month 1-3 → Q1, 4-6 → Q2, etc.
quarter_label = f"{year}Q{quarter}"  # e.g. "2025Q1"
```

## Four Database Tables

All tables live in the `dashboard_data` (postgres_default) database.

### `env_noise_stations` — Station Master (with PostGIS geometry)

Key columns: `station_id` (text PK), `station_name`, `city`, `district`, `noise_category` (`traffic`/`environmental`), `monitoring_type` (`manual`/`automatic`), `control_zone`, `standard_day_db`, `standard_evening_db`, `standard_night_db`, `total_exceed_count`, `latest_year`, `latest_month`, `longitude`, `latitude`, `address`, `wkb_geometry` (Point EPSG:4326), `geocode_quality`, `source_name`, `source_url`, `data_time`.

Geometry is set once via geocoding and **never overwritten** by subsequent ETL runs. Stations without coordinates are excluded from the map layer but retained in district statistics.

### `env_noise_monthly_measurements` — Monthly Raw Values

Key columns: `station_id`, `city`, `district`, `noise_category`, `measurement_year`, `measurement_month`, `quarter`, `day_db`, `evening_db`, `night_db`, `exceeded_standard`, `day_exceeded`, `evening_exceeded`, `night_exceeded`, `quality_flag` (`ok`/`missing`/`partial`), `data_time`.

Upsert key: `(station_id, measurement_year, measurement_month)`.

### `env_noise_quarterly_stats_tpe` / `env_noise_quarterly_stats_new_tpe` — Quarterly Aggregation

Two city-split tables with identical structure (no `city_scope` column). Metro-area queries combine them with `UNION ALL` at query time.

Key columns: `station_name`, `noise_category`, `year`, `quarter`, `quarter_label`, `period` (`day`/`evening`/`night`), `avg_db`, `data_time`.

Computed by D990103; replaced in full on each run. `quarter_label` format: `"2025Q1"`.

### `env_noise_district_summary_tpe` / `env_noise_district_summary_new_tpe` — District Rollup

Two city-split tables with identical structure (no `city_scope` column).

Key columns: `district`, `noise_category`, `year`, `quarter`, `avg_day_db`, `avg_evening_db`, `avg_night_db`, `exceed_count`, `exceed_rate`, `data_time`.

Also computed by D990103. `exceed_rate = exceed_count / measurement_count`.

## Three Airflow DAGs

| DAG | Schedule | Tables Written | Method |
|-----|----------|---------------|--------|
| D990101 | `0 3 16 * *` (monthly 16th) | `env_noise_monthly_measurements`, `env_noise_stations` | HTML scraping (Taipei) |
| D990102 | `0 4 1 1 *` (yearly Jan 1) | Same + geocoding | PDF parsing (New Taipei) |
| D990103 | `0 6 16 * *` (monthly, after D990101) | `env_noise_quarterly_stats_tpe`, `env_noise_quarterly_stats_new_tpe`, `env_noise_district_summary_tpe`, `env_noise_district_summary_new_tpe` | Derived aggregation |

D990102 also scrapes `/StaticPage/manual-stations` and `/StaticPage/auto-stations` to collect station addresses before geocoding.

## Coordinate Sources (No Geocoding API Required)

Coordinates come from official open data — no third-party geocoding API needed.

| City | Source | Endpoint | Auth | Match Key |
|------|--------|----------|------|-----------|
| 臺北市 | data.taipei open data | `https://data.taipei/api/v1/dataset/ac5e1557-5590-4bec-8709-e5f0f8d4bd1e?scope=resourceAquire` | None | `測點編號` = `station_id` |
| 新北市 (交通噪音) | MOENV GISEPA_P_18 | `https://data.moenv.gov.tw/api/v2/GISEPA_P_18?api_key={key}&format=json` | `MOENV_API_KEY` Airflow Variable | `number` = `station_id` |
| 新北市 (環境噪音) | MOENV GISEPA_P_19 | `https://data.moenv.gov.tw/api/v2/GISEPA_P_19?api_key={key}&format=json` | `MOENV_API_KEY` Airflow Variable | `no` = `station_id` |

Both GISEPA datasets return WGS84 (EPSG:4326) coordinates directly in `latitude`/`longitude` fields. The data.taipei endpoint returns `緯度`/`經度` fields also in WGS84.

**Fallback chain:**
1. Try primary source (data.taipei for Taipei, MOENV API for New Taipei)
2. If MOENV_API_KEY not set or station not found → district centroid, `geocode_quality = 'district_centroid'`
3. Only update stations where `wkb_geometry IS NULL` — never overwrite confirmed coordinates.

Use `add_point_wkbgeometry_column_to_df()` from `utils/transform_geometry.py` to build the PostGIS column.

## Noise Standard Reference

| Noise Category | Control Zone | Day (dB) | Evening (dB) | Night (dB) |
|---------------|-------------|---------|-------------|-----------|
| Traffic | 二 | 71 | 69 | 63 |
| Traffic | 三 | 74 | 70 | 67 |
| Traffic | 四 | 76 | 75 | 72 |
| Environmental | 一 | 55 | 50 | 45 |
| Environmental | 二 | 55 | 50 | 45 |
| Environmental | 三 | 60 | 55 | 50 |
| Environmental | 四 | 65 | 60 | 55 |
| Environmental | 五 | 75 | 70 | 65 |

Standards are stored per station in `env_noise_stations` and used at query time to compute `exceeded_standard`.

## ETL Difficulty Points

| Challenge | Root Cause | Strategy |
|-----------|-----------|----------|
| No public API | Official sites are query forms only | `requests` + retry with custom User-Agent |
| PDF table complexity | Multi-level headers, merged cells | `pdfplumber` bbox-based table extraction per page |
| New Taipei data lag | Annual report only (~1 year behind) | Yearly DAG + monitor for future Open Data API |
| Missing station coordinates | Sources provide names only, no coords | Use data.taipei API (Taipei) and MOENV GISEPA_P_18/P_19 (New Taipei); district centroid as last resort |
| Special measurement symbols | `*`, `-`, `#`, `&` embedded in numeric cells | Regex strip → float conversion; flag columns |

## Utility Functions to Reuse

| Function | File | Purpose |
|----------|------|---------|
| `save_dataframe_to_postgresql` | `utils/load_stage.py` | Store non-spatial DataFrame |
| `save_geodataframe_to_postgresql` | `utils/load_stage.py` | Store GeoDataFrame with PostGIS |
| `add_point_wkbgeometry_column_to_df` | `utils/transform_spatial.py` | Build WKBGeometry from lng/lat |
| `update_lasttime_in_data_to_dataset_info` | `utils/load_stage.py` | Sync `dataset_info` metadata |
| `convert_str_to_time_format` | `utils/transform_time.py` | Normalize timestamps to ISO 8601 |

## Deployment

### First-time setup

```bash
# Step 1 — create dashboard DB tables
docker cp db-sample-data/noise-monitoring-tables.sql postgres-data:/tmp/noise-monitoring-tables.sql
docker exec postgres-data psql -U postgres -d dashboard -f /tmp/noise-monitoring-tables.sql

# Step 2 — register component + dashboard in dashboardmanager
docker cp db-sample-data/noise-monitoring-component.sql postgres-manager:/tmp/noise-monitoring-component.sql
docker exec postgres-manager psql -U postgres -d dashboardmanager -f /tmp/noise-monitoring-component.sql
docker cp db-sample-data/noise-monitoring-dashboard.sql postgres-manager:/tmp/noise-monitoring-dashboard.sql
docker exec postgres-manager psql -U postgres -d dashboardmanager -f /tmp/noise-monitoring-dashboard.sql
```

### Schema re-deploy

```bash
docker exec postgres-data psql -U postgres -d dashboard -c \
  "DROP TABLE IF EXISTS env_noise_stations, env_noise_monthly_measurements,
   env_noise_quarterly_stats_tpe, env_noise_quarterly_stats_new_tpe,
   env_noise_district_summary_tpe, env_noise_district_summary_new_tpe CASCADE;"
```

Then re-run Step 1–2 above.

### Run ETL

```bash
# Steps 3–4: Taipei + New Taipei (can run in parallel)
docker exec develop-airflow-webserver-1 airflow dags unpause proj_city_dashboard_D990101
docker exec develop-airflow-webserver-1 airflow dags trigger proj_city_dashboard_D990101
docker exec develop-airflow-webserver-1 airflow dags unpause proj_city_dashboard_D990102
docker exec develop-airflow-webserver-1 airflow dags trigger proj_city_dashboard_D990102

# Step 5: aggregation (after D990101 + D990102 etl tasks both succeed)
docker exec develop-airflow-webserver-1 airflow dags unpause proj_city_dashboard_D990103
docker exec develop-airflow-webserver-1 airflow dags trigger proj_city_dashboard_D990103
```

> Overall DAG status shows `failed` in test env because `update_dataset_info` cannot find `dataset_info`. Verify the `etl` task itself is `success`.

### Verification queries

```sql
SELECT COUNT(*) FROM env_noise_stations WHERE city='臺北市';    -- expect 23
SELECT COUNT(*) FROM env_noise_stations WHERE city='新北市';    -- expect 27
SELECT COUNT(*) FROM env_noise_quarterly_stats_tpe;             -- expect ~360
SELECT COUNT(*) FROM env_noise_quarterly_stats_new_tpe;         -- expect ~687
SELECT COUNT(*) FROM env_noise_district_summary_tpe;            -- expect ~75
SELECT COUNT(*) FROM env_noise_district_summary_new_tpe;        -- expect ~115
SELECT year, quarter FROM env_noise_quarterly_stats_tpe ORDER BY year DESC, quarter DESC LIMIT 1;
```

## See Also

- [Airflow DAG Development](airflow-dag-development.md)
- [Data Tables and Metadata](data-tables-and-metadata.md)
- [Data-End Utility Functions](data-end-utility-functions.md)
- [Noise Monitoring Backend Component](../taipei-dashboard-backend/noise-monitoring-component.md)
