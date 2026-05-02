# Noise Monitoring Backend Component

> Sources: 臺北市環保局 / 新北市環保局規格文件, 2026-05-02
> Raw: [噪音監測與分佈](../../raw/taipei-dashboard-dataend/噪音監測與分佈.md)

## Overview

The noise monitoring component (`env_noise_monitoring`) is registered in the `dashboardmanager` database. It requires no new Go code — all four query types (timeline, district heatmap, exceed-rate bar chart, map layer) are served by the existing component data querying infrastructure via SQL strings stored in `query_charts`. The map layer uses PostGIS `ST_AsGeoJSON` and is filtered by `city_scope` parameter at query time.

## Component Registration

Three tables in `dashboardmanager` must be populated. See `db-sample-data/dashboardmanager-demo.sql` for exact column lists before inserting.

```sql
-- components table
INSERT INTO components (index, name)
VALUES ('env_noise_monitoring', '環境噪音監測與分佈');
```

## Query Charts (Four SQL Strings)

### 1. Quarterly Trend Line Chart (`time` type)

Returns one row per (quarter_label, period). Frontend renders three series: `day`, `evening`, `night`.

```sql
SELECT
  quarter_label AS x,
  period        AS y_axis,
  avg_db        AS data
FROM env_noise_quarterly_stats
WHERE city_scope     = %s
  AND noise_category = %s
  AND year          >= (EXTRACT(YEAR FROM NOW()) - 2)
ORDER BY year, quarter, period;
```

Parameters: `%s` → `city_scope` (`taipei`/`twin_city`), `%s` → `noise_category` (`traffic`/`environmental`).

`quarter_label` format: `"2025Q1"`. Frontend maps `period` values to Chinese labels: `day`→日間, `evening`→晚間, `night`→夜間.

### 2. District Noise Heatmap (`two_d` type)

```sql
SELECT
  district   AS x_axis,
  avg_day_db AS data
FROM env_noise_district_summary
WHERE city_scope     = %s
  AND noise_category = %s
  AND year           = %s
  AND quarter        = %s
ORDER BY district;
```

Parameters: `city_scope`, `noise_category`, `year` (integer), `quarter` (1–4).

### 3. Exceed-Rate Bar Chart (`percent` type)

```sql
SELECT
  district    AS x_axis,
  exceed_rate AS data
FROM env_noise_district_summary
WHERE city_scope     = %s
  AND noise_category = %s
  AND year           = %s
ORDER BY exceed_rate DESC;
```

Parameters: `city_scope`, `noise_category`, `year`.

### 4. Map Layer (`map_legend` type)

Returns one row per station. `geometry` column carries GeoJSON Point for the frontend map renderer.

```sql
SELECT
  s.station_id,
  s.station_name,
  s.city,
  s.district,
  s.noise_category,
  s.monitoring_type,
  s.control_zone,
  s.standard_day_db,
  s.standard_evening_db,
  s.standard_night_db,
  m.measurement_year,
  m.measurement_month,
  m.day_db     AS latest_day_db,
  m.evening_db AS latest_evening_db,
  m.night_db   AS latest_night_db,
  m.exceeded_standard,
  s.total_exceed_count,
  s.source_name,
  s.data_time,
  ST_AsGeoJSON(s.wkb_geometry)::json AS geometry
FROM env_noise_stations s
LEFT JOIN env_noise_monthly_measurements m
  ON m.station_id        = s.station_id
 AND m.measurement_year  = s.latest_year
 AND m.measurement_month = s.latest_month
WHERE
  CASE
    WHEN %s = 'taipei'    THEN s.city = '臺北市'
    WHEN %s = 'twin_city' THEN s.city IN ('臺北市', '新北市')
  END
  AND s.wkb_geometry IS NOT NULL;
```

Parameters: two `%s` for `city_scope` (both sides of the CASE).

## Map Layer Configuration (`component_maps`)

```sql
INSERT INTO component_maps (index, title, type, source, paint, property)
VALUES (
  'env_noise_monitoring',
  '噪音測站',
  'circle',
  'geojson',
  '{
    "circle-color": [
      "step", ["get", "latest_day_db"],
      "#4CAF50", 55,
      "#CDDC39", 65,
      "#FFEB3B", 70,
      "#FF9800", 75,
      "#F44336"
    ]
  }',
  '{"name": "station_name", "city": "city", "exceeded": "exceeded_standard"}'
);
```

Color scale by `latest_day_db`:

| Range | Color |
|-------|-------|
| < 55 dB | Green `#4CAF50` |
| 55–65 dB | Yellow-green `#CDDC39` |
| 65–70 dB | Yellow `#FFEB3B` |
| 70–75 dB | Orange `#FF9800` |
| ≥ 75 dB | Red `#F44336` |

## Station Popup Fields

When a map point is clicked, the popup should display:

`station_name`, `city`, `district`, `station_id`, `noise_category` (交通噪音/環境噪音), `monitoring_type` (人工/自動), `control_zone`, `standard_day_db`/`standard_evening_db`/`standard_night_db`, `measurement_year`+`measurement_month`, `latest_day_db`/`latest_evening_db`/`latest_night_db`, `exceeded_standard`, `total_exceed_count`, `data_time`, data source label (臺北市環保局 / 新北市環保局).

## AI Chat Tool Calling Interface

Five tools connect the AI Chat service to the noise monitoring data. All tools must be implemented in `Taipei-City-Dashboard-BE/app/services/`.

| Tool | Parameters | Returns |
|------|-----------|---------|
| `get_noise_summary` | `city_scope`, `noise_category`, `year` | Station count, average dB, exceed rate, latest data quarter |
| `get_noise_quarterly_trend` | `city_scope`, `noise_category`, `year_range` (int array) | Per-quarter day/evening/night avg dB |
| `get_noise_district_ranking` | `city_scope`, `noise_category`, `year`, `quarter` | Districts ranked by avg dB and exceed rate |
| `get_noise_station_detail` | `station_id` | Station metadata + full monthly measurement history + exceed log |
| `set_noise_view` | `city_scope`, `noise_category`, `focus_district?`, `focus_station_id?` | Frontend view-control command |

Parameter constraints: `city_scope` ∈ `{taipei, twin_city}`; `noise_category` ∈ `{traffic, environmental}`; `year_range` defaults to last 3 years when omitted; `station_id` must match format `\d{7}[TE]N\d{3}`.

AI responses must include data timestamp and source attribution. When citing New Taipei data, note the ~1-year lag from annual report cycle.

## See Also

- [Component Data Querying](component-data-querying.md)
- [AI Chat and Chatlog Services](ai-chat-and-chatlog-services.md)
- [Noise Monitoring ETL Pipeline](../taipei-dashboard-dataend/noise-monitoring-etl.md)
