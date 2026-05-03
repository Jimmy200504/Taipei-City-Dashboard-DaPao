# Noise Monitoring Backend Component

> Sources: 臺北市環保局 / 新北市環保局規格文件, 2026-05-03
> Raw: [噪音監測與分佈（draft）](../../raw/taipei-dashboard-dataend/噪音監測與分佈.md); [噪音監測與分佈（spec）](../../raw/taipei-dashboard-dataend/2026-05-03-noise-monitoring-spec.md)

## Overview

The noise monitoring component (`env_noise_monitoring`) serves four chart types from the `dashboard` database. All SQL strings are stored in `query_charts` — no new Go code is required for the data layer. The map layer uses static GeoJSON files instead of a DB query: the `map_legend` query type returns only the color-scale legend items, while the actual station points come from pre-built GeoJSON in `public/mapData/`.

Key design decision: quarterly stats and district summary are stored in **city-split tables** (`_tpe` for Taipei, `_new_tpe` for New Taipei). Metro-area queries use `UNION ALL` at query time — there is no `city_scope` column in these tables.

## Component Registration

Three tables in `dashboardmanager` must be populated:

```sql
INSERT INTO components (index, name)
VALUES ('env_noise_monitoring', '環境噪音監測與分佈');
```

See `db-sample-data/noise-monitoring-component.sql` for the full insert including all four `query_charts` rows.

## Query Charts (Four SQL Strings)

### 1. Quarterly Trend (`env_noise_trend`, `time` type)

Returns one row per (year, quarter, period). Frontend renders three series: 日間 / 晚間 / 夜間.

**Taipei (`city = 'taipei'`)**

```sql
SELECT
  MAKE_DATE(year, (quarter-1)*3+1, 1)::timestamp AS x_axis,
  CASE period WHEN 'day' THEN '日間' WHEN 'evening' THEN '晚間' ELSE '夜間' END AS y_axis,
  ROUND(AVG(avg_db)::numeric, 1) AS data
FROM env_noise_quarterly_stats_tpe
WHERE year >= EXTRACT(YEAR FROM NOW())::int - 2
GROUP BY year, quarter, period
ORDER BY year, quarter, period
```

**Metro (`city = 'metrotaipei'`)**

```sql
SELECT
  MAKE_DATE(year, (quarter-1)*3+1, 1)::timestamp AS x_axis,
  CASE period WHEN 'day' THEN '日間' WHEN 'evening' THEN '晚間' ELSE '夜間' END AS y_axis,
  ROUND(AVG(avg_db)::numeric, 1) AS data
FROM (
  SELECT year, quarter, period, avg_db FROM env_noise_quarterly_stats_tpe
  WHERE year >= EXTRACT(YEAR FROM NOW())::int - 2
  UNION ALL
  SELECT year, quarter, period, avg_db FROM env_noise_quarterly_stats_new_tpe
  WHERE year >= EXTRACT(YEAR FROM NOW())::int - 2
) combined
GROUP BY year, quarter, period
ORDER BY year, quarter, period
```

### 2. District Noise Bar Chart (`env_noise_district`, `two_d` type)

Returns avg day dB per district for the latest quarter, ordered high to low.

**Taipei**

```sql
SELECT
  district   AS x_axis,
  ROUND(AVG(avg_day_db)::numeric, 1) AS data
FROM env_noise_district_summary_tpe
WHERE (year, quarter) = (
  SELECT year, quarter FROM env_noise_district_summary_tpe
  ORDER BY year DESC, quarter DESC LIMIT 1
)
GROUP BY district
ORDER BY data DESC
```

**Metro**: same pattern with `UNION ALL` across `env_noise_district_summary_tpe` and `env_noise_district_summary_new_tpe`. Latest quarter is derived from the union.

### 3. Exceed Count (`env_noise_exceed`, `two_d` type)

Returns exceed station count per district for the latest quarter.

**Taipei**

```sql
SELECT
  district          AS x_axis,
  exceed_count::int AS data
FROM env_noise_district_summary_tpe
WHERE (year, quarter) = (
  SELECT year, quarter FROM env_noise_district_summary_tpe
  ORDER BY year DESC, quarter DESC LIMIT 1
)
ORDER BY data DESC
```

**Metro**: `UNION ALL` pattern, latest quarter from both tables.

### 4. Map Legend (`env_noise_monitoring`, `map_legend` type)

Returns only the five legend items. Station points come from static GeoJSON, not this query.

```sql
SELECT unnest(array['< 55 dB','55-65 dB','65-70 dB','70-75 dB','> 75 dB']) AS name,
       'circle' AS type
```

## Static GeoJSON Map Layer

Map points are served from pre-built GeoJSON files, not PostGIS queries:

| Scope | File | Stations |
|-------|------|----------|
| Taipei | `public/mapData/env_noise_monitoring.geojson` | 23 |
| Metro | `public/mapData/env_noise_monitoring_metro.geojson` | 49 |

`component_maps` entries:

| index | map_config_ids |
|-------|---------------|
| `env_noise_monitoring` (Taipei) | `{200}` |
| `env_noise_monitoring_metro` (Metro) | `{202}` |

Color scale by `latest_day_db`:

| Range | Color |
|-------|-------|
| < 55 dB | Green `#4CAF50` |
| 55–65 dB | Yellow-green `#CDDC39` |
| 65–70 dB | Yellow `#FFEB3B` |
| 70–75 dB | Orange `#FF9800` |
| ≥ 75 dB | Red `#F44336` |

## Station Popup Fields

When a map point is clicked, show: `station_name`, `city`, `district`, `station_id`, `noise_category` (交通噪音/環境噪音), `monitoring_type` (人工/自動), `control_zone`, `standard_day_db`/`standard_evening_db`/`standard_night_db`, `latest_year`+`latest_month`, `latest_day_db`/`latest_evening_db`/`latest_night_db`, `exceeded_standard`, `total_exceed_count`, `data_time`, data source label.

## AI Chat Tool Calling Interface

Four tools are implemented in `Taipei-City-Dashboard-BE/app/services/ai/tools/noise.go`. (`set_noise_view` is deferred — no frontend SSE mechanism for view control yet.)

| Tool | Parameters | Returns |
|------|-----------|---------|
| `get_noise_summary` | `city_scope`, `noise_category`, `year` (opt) | Station count, avg dB per period, exceed rate, latest quarter |
| `get_noise_quarterly_trend` | `city_scope`, `noise_category`, `year_range` (opt int[]) | Per-quarter day/evening/night avg dB |
| `get_noise_district_ranking` | `city_scope`, `noise_category`, `year`, `quarter` | Districts ranked by day dB with exceed stats |
| `get_noise_station_detail` | `station_id` | Station metadata + 24-month measurement history |

Parameter constraints: `city_scope` ∈ `{taipei, metrotaipei}`; `noise_category` ∈ `{traffic, environmental}`; `year_range` defaults to last 3 years; `station_id` is the raw station code (e.g. `0401020TN003`).

The implementation uses `noiseSource()` to route queries to the correct city table(s) and reuses `cityWhereClause()` from `river.go` for `env_noise_stations` filtering.

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

### Trigger ETL

```bash
# Step 3 — Taipei ETL (~1 min)
docker exec develop-airflow-webserver-1 airflow dags unpause proj_city_dashboard_D990101
docker exec develop-airflow-webserver-1 airflow dags trigger proj_city_dashboard_D990101

# Step 4 — New Taipei ETL (~3 min, can run in parallel)
docker exec develop-airflow-webserver-1 airflow dags unpause proj_city_dashboard_D990102
docker exec develop-airflow-webserver-1 airflow dags trigger proj_city_dashboard_D990102

# Step 5 — aggregation DAG (after Steps 3 & 4 succeed)
docker exec develop-airflow-webserver-1 airflow dags unpause proj_city_dashboard_D990103
docker exec develop-airflow-webserver-1 airflow dags trigger proj_city_dashboard_D990103
```

> Note: overall DAG status shows `failed` because `update_dataset_info` cannot find `dataset_info` in test env. Verify the `etl` task itself is `success`.

### Verification

```sql
SELECT COUNT(*) FROM env_noise_stations WHERE city='臺北市';           -- expect 23
SELECT COUNT(*) FROM env_noise_stations WHERE city='新北市';           -- expect 27
SELECT COUNT(*) FROM env_noise_quarterly_stats_tpe;                    -- expect ~360
SELECT COUNT(*) FROM env_noise_quarterly_stats_new_tpe;                -- expect ~687
SELECT index, city FROM query_charts WHERE index LIKE 'env_noise%'
ORDER BY index, city;                                                  -- expect 8 rows
```

## See Also

- [Component Data Querying](component-data-querying.md)
- [AI Chat and Chatlog Services](ai-chat-and-chatlog-services.md)
- [Noise Monitoring ETL Pipeline](../taipei-dashboard-dataend/noise-monitoring-etl.md)
