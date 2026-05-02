"""
Fix three bugs in noise monitoring query_charts and generate GeoJSON static file.

Run inside the Airflow container (has access to both postgres-manager and postgres-data):
  docker exec -i airflow-scheduler python < /path/fix-noise-queries.py

Or copy into container and run:
  docker cp fix-noise-queries.py airflow-scheduler:/tmp/
  docker exec airflow-scheduler python /tmp/fix-noise-queries.py
"""

import json
from sqlalchemy import create_engine, text

MGR  = create_engine("postgresql://postgres:0410@postgres-manager:5432/dashboardmanager")
DATA = create_engine("postgresql://postgres:0410@postgres-data:5432/dashboard")

# ---------------------------------------------------------------------------
# Fix 1: env_noise_trend — x_axis must be time.Time (timestamp)
#   old: quarter_label AS x  (string, parse fails)
#   new: MAKE_DATE(year, (quarter-1)*3+1, 1) AS x_axis
# ---------------------------------------------------------------------------
TREND_TAIPEI = """SELECT
  MAKE_DATE(year, (quarter-1)*3+1, 1)::timestamp AS x_axis,
  period        AS y_axis,
  avg_db        AS data
FROM env_noise_quarterly_stats_tpe
WHERE year >= EXTRACT(YEAR FROM NOW())::int - 2
ORDER BY year, quarter, period"""

TREND_METRO = """SELECT
  MAKE_DATE(year, (quarter-1)*3+1, 1)::timestamp AS x_axis,
  period        AS y_axis,
  avg_db        AS data
FROM (
  SELECT year, quarter, period, avg_db
  FROM env_noise_quarterly_stats_tpe
  UNION ALL
  SELECT year, quarter, period, avg_db
  FROM env_noise_quarterly_stats_new_tpe
) combined
WHERE year >= EXTRACT(YEAR FROM NOW())::int - 2
ORDER BY year, quarter, period"""

# ---------------------------------------------------------------------------
# Fix 2: env_noise_monitoring map_legend — return legend items only
#   The actual GeoJSON comes from the static file generated below.
#   Backend struct expects: name, type, icon, value
# ---------------------------------------------------------------------------
MAP_TAIPEI = "SELECT '噪音測站' AS name, 'circle' AS type"
MAP_METRO  = "SELECT '噪音測站' AS name, 'circle' AS type"

# ---------------------------------------------------------------------------
# Fix 3: env_noise_exceed — add y_axis (noise_category)
#   percent query_type uses GetThreeDimensionalData → requires y_axis column
# ---------------------------------------------------------------------------
EXCEED_TAIPEI = """SELECT
  district    AS x_axis,
  noise_category AS y_axis,
  ROUND(exceed_rate::numeric, 1) AS data
FROM env_noise_district_summary_tpe
WHERE year = (SELECT MAX(year) FROM env_noise_district_summary_tpe)
ORDER BY district, noise_category"""

EXCEED_METRO = """SELECT
  district    AS x_axis,
  noise_category AS y_axis,
  ROUND(exceed_rate::numeric, 1) AS data
FROM (
  SELECT noise_category, district, exceed_rate, year
  FROM env_noise_district_summary_tpe
  UNION ALL
  SELECT noise_category, district, exceed_rate, year
  FROM env_noise_district_summary_new_tpe
) combined
WHERE year = (
  SELECT MAX(year) FROM (
    SELECT year FROM env_noise_district_summary_tpe
    UNION ALL
    SELECT year FROM env_noise_district_summary_new_tpe
  ) all_y
)
ORDER BY district, noise_category"""

def update_query_charts():
    updates = [
        ("env_noise_trend",    "time",       "taipei",      TREND_TAIPEI),
        ("env_noise_trend",    "time",       "metrotaipei", TREND_METRO),
        ("env_noise_monitoring","map_legend", "taipei",      MAP_TAIPEI),
        ("env_noise_monitoring","map_legend", "metrotaipei", MAP_METRO),
        ("env_noise_exceed",   "percent",    "taipei",      EXCEED_TAIPEI),
        ("env_noise_exceed",   "percent",    "metrotaipei", EXCEED_METRO),
    ]
    with MGR.connect() as conn:
        for idx, qtype, city, sql in updates:
            r = conn.execute(text(
                "UPDATE query_charts SET query_chart = :q "
                "WHERE index=:i AND query_type=:t AND city=:c"
            ), {"q": sql, "i": idx, "t": qtype, "c": city})
            print(f"  {idx} [{qtype}/{city}]: {r.rowcount} row(s) updated")
        conn.execute(text("COMMIT"))


# ---------------------------------------------------------------------------
# Generate GeoJSON static file
#   Reads env_noise_stations joined with latest quarterly data
#   Writes to stdout (redirect to the geojson file)
# ---------------------------------------------------------------------------
STATION_SQL = """
WITH latest AS (
  SELECT
    station_name,
    MAX(CASE WHEN period = 'day'     THEN avg_db END) AS latest_day_db,
    MAX(CASE WHEN period = 'evening' THEN avg_db END) AS latest_evening_db,
    MAX(CASE WHEN period = 'night'   THEN avg_db END) AS latest_night_db,
    MAX(year * 10 + quarter) AS yq
  FROM (
    SELECT station_name, year, quarter, period, avg_db
    FROM env_noise_quarterly_stats_tpe
    UNION ALL
    SELECT station_name, year, quarter, period, avg_db
    FROM env_noise_quarterly_stats_new_tpe
  ) all_stats
  WHERE (station_name, year, quarter) IN (
    SELECT station_name,
           FIRST_VALUE(year)    OVER w AS year,
           FIRST_VALUE(quarter) OVER w AS quarter
    FROM (
      SELECT DISTINCT station_name, year, quarter
      FROM env_noise_quarterly_stats_tpe
      UNION
      SELECT DISTINCT station_name, year, quarter
      FROM env_noise_quarterly_stats_new_tpe
    ) uniq
    WINDOW w AS (PARTITION BY station_name ORDER BY year DESC, quarter DESC)
  )
  GROUP BY station_name
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
  s.total_exceed_count,
  s.source_name,
  COALESCE(l.latest_day_db,     0) AS latest_day_db,
  COALESCE(l.latest_evening_db, 0) AS latest_evening_db,
  COALESCE(l.latest_night_db,   0) AS latest_night_db,
  ST_X(s.wkb_geometry::geometry) AS lon,
  ST_Y(s.wkb_geometry::geometry) AS lat
FROM env_noise_stations s
LEFT JOIN latest l ON l.station_name = s.station_name
WHERE s.wkb_geometry IS NOT NULL
ORDER BY s.station_id
"""

def generate_geojson(out_path: str):
    features = []
    with DATA.connect() as conn:
        rows = conn.execute(text(STATION_SQL))
        for r in rows:
            features.append({
                "type": "Feature",
                "properties": {
                    "station_id":          r.station_id,
                    "station_name":        r.station_name,
                    "city":                r.city,
                    "district":            r.district,
                    "noise_category":      r.noise_category,
                    "monitoring_type":     r.monitoring_type,
                    "control_zone":        r.control_zone,
                    "standard_day_db":     float(r.standard_day_db)     if r.standard_day_db     else None,
                    "standard_evening_db": float(r.standard_evening_db) if r.standard_evening_db else None,
                    "standard_night_db":   float(r.standard_night_db)   if r.standard_night_db   else None,
                    "total_exceed_count":  int(r.total_exceed_count)     if r.total_exceed_count  else 0,
                    "source_name":         r.source_name,
                    "latest_day_db":       float(r.latest_day_db),
                    "latest_evening_db":   float(r.latest_evening_db),
                    "latest_night_db":     float(r.latest_night_db),
                },
                "geometry": {
                    "type": "Point",
                    "coordinates": [float(r.lon), float(r.lat)]
                }
            })

    fc = {
        "type": "FeatureCollection",
        "crs": {
            "type": "name",
            "properties": {"name": "urn:ogc:def:crs:OGC:1.3:CRS84"}
        },
        "features": features
    }
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(fc, f, ensure_ascii=False, indent=2)
    print(f"  GeoJSON written: {out_path} ({len(features)} features)")


if __name__ == "__main__":
    print("=== Fix 1-3: updating query_charts ===")
    update_query_charts()

    print("=== Generating GeoJSON ===")
    generate_geojson("/tmp/env_noise_monitoring.geojson")

    print("Done.")
