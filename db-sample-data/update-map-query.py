"""Update map_legend query_charts to use quarterly stats instead of monthly_measurements."""
from sqlalchemy import create_engine, text

engine = create_engine("postgresql://postgres:0410@postgres-manager:5432/dashboardmanager")

MAP_TEMPLATE = """WITH latest AS (
  SELECT station_name,
         year AS latest_year, quarter AS latest_quarter,
         MAX(CASE WHEN period='day'     THEN avg_db END) AS day_db,
         MAX(CASE WHEN period='evening' THEN avg_db END) AS evening_db,
         MAX(CASE WHEN period='night'   THEN avg_db END) AS night_db,
         ROW_NUMBER() OVER (
           PARTITION BY station_name ORDER BY year DESC, quarter DESC
         ) AS rn
  FROM ({stats_source}) q
  GROUP BY station_name, year, quarter
)
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
  l.latest_year     AS measurement_year,
  l.latest_quarter * 3 AS latest_measurement_month,
  l.day_db          AS latest_day_db,
  l.evening_db      AS latest_evening_db,
  l.night_db        AS latest_night_db,
  (
    (l.day_db IS NOT NULL AND s.standard_day_db IS NOT NULL
     AND l.day_db > s.standard_day_db)
    OR (l.evening_db IS NOT NULL AND s.standard_evening_db IS NOT NULL
        AND l.evening_db > s.standard_evening_db)
    OR (l.night_db IS NOT NULL AND s.standard_night_db IS NOT NULL
        AND l.night_db > s.standard_night_db)
  ) AS exceeded_standard,
  s.total_exceed_count,
  s.source_name,
  s.data_time,
  ST_AsGeoJSON(s.wkb_geometry)::json AS geometry
FROM env_noise_stations s
LEFT JOIN latest l ON l.station_name = s.station_name AND l.rn = 1
WHERE {city_filter}
  AND s.wkb_geometry IS NOT NULL"""

TAIPEI_SOURCE = "SELECT station_name, year, quarter, period, avg_db FROM env_noise_quarterly_stats_tpe"
METRO_SOURCE  = (
    "SELECT station_name, year, quarter, period, avg_db FROM env_noise_quarterly_stats_tpe "
    "UNION ALL "
    "SELECT station_name, year, quarter, period, avg_db FROM env_noise_quarterly_stats_new_tpe"
)

q_taipei = MAP_TEMPLATE.format(
    stats_source=TAIPEI_SOURCE,
    city_filter="s.city = '臺北市'",
)
q_metro = MAP_TEMPLATE.format(
    stats_source=METRO_SOURCE,
    city_filter="s.city IN ('臺北市', '新北市')",
)

with engine.connect() as conn:
    r1 = conn.execute(text(
        "UPDATE query_charts SET query_chart = :q "
        "WHERE index='env_noise_monitoring' AND query_type='map_legend' AND city='taipei'"
    ), {"q": q_taipei})
    r2 = conn.execute(text(
        "UPDATE query_charts SET query_chart = :q "
        "WHERE index='env_noise_monitoring' AND query_type='map_legend' AND city='metrotaipei'"
    ), {"q": q_metro})
    conn.execute(text("COMMIT"))
    print(f"Updated taipei: {r1.rowcount}, metrotaipei: {r2.rowcount}")
