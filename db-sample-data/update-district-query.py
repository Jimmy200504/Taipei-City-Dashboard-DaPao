"""Fix two_d and percent queries to use latest available quarter instead of current quarter."""
from sqlalchemy import create_engine, text

engine = create_engine("postgresql://postgres:0410@postgres-manager:5432/dashboardmanager")

# two_d: district heatmap — latest available (year, quarter)
Q2D_TAIPEI = """SELECT
  noise_category,
  district   AS x_axis,
  avg_day_db AS data
FROM env_noise_district_summary_tpe
WHERE (year, quarter) = (
  SELECT year, quarter FROM env_noise_district_summary_tpe
  ORDER BY year DESC, quarter DESC LIMIT 1
)
ORDER BY district, noise_category"""

Q2D_METRO = """SELECT
  noise_category,
  district   AS x_axis,
  avg_day_db AS data
FROM (
  SELECT noise_category, district, avg_day_db, year, quarter
  FROM env_noise_district_summary_tpe
  UNION ALL
  SELECT noise_category, district, avg_day_db, year, quarter
  FROM env_noise_district_summary_new_tpe
) combined
WHERE (year, quarter) = (
  SELECT year, quarter FROM (
    SELECT year, quarter FROM env_noise_district_summary_tpe
    UNION ALL
    SELECT year, quarter FROM env_noise_district_summary_new_tpe
  ) all_q ORDER BY year DESC, quarter DESC LIMIT 1
)
ORDER BY district, noise_category"""

# percent: exceed rate — latest available year
QPCT_TAIPEI = """SELECT
  noise_category,
  district    AS x_axis,
  exceed_rate AS data
FROM env_noise_district_summary_tpe
WHERE year = (
  SELECT MAX(year) FROM env_noise_district_summary_tpe
)
ORDER BY exceed_rate DESC, noise_category"""

QPCT_METRO = """SELECT
  noise_category,
  district    AS x_axis,
  exceed_rate AS data
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
ORDER BY exceed_rate DESC, noise_category"""

with engine.connect() as conn:
    for city, q2d, qpct in (("taipei", Q2D_TAIPEI, QPCT_TAIPEI),
                              ("metrotaipei", Q2D_METRO, QPCT_METRO)):
        r1 = conn.execute(text(
            "UPDATE query_charts SET query_chart = :q "
            "WHERE index='env_noise_monitoring' AND query_type='two_d' AND city=:c"
        ), {"q": q2d, "c": city})
        r2 = conn.execute(text(
            "UPDATE query_charts SET query_chart = :q "
            "WHERE index='env_noise_monitoring' AND query_type='percent' AND city=:c"
        ), {"q": qpct, "c": city})
        print(f"{city}: two_d updated={r1.rowcount}, percent updated={r2.rowcount}")
    conn.execute(text("COMMIT"))
