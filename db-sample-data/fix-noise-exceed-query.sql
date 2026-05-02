-- Fix env_noise_exceed: cast exceed_rate (numeric 0-1) to int percentage (0-100)
-- Target DB: dashboardmanager (postgres_manager)

UPDATE public.query_charts
SET query_chart = $$SELECT
  noise_category,
  district                             AS x_axis,
  ROUND(exceed_rate * 100)::int        AS data
FROM env_noise_district_summary_tpe
WHERE year = (SELECT MAX(year) FROM env_noise_district_summary_tpe)
ORDER BY exceed_rate DESC, noise_category$$
WHERE index = 'env_noise_exceed'
  AND city = 'taipei'
  AND query_type = 'percent';

UPDATE public.query_charts
SET query_chart = $$SELECT
  noise_category,
  district                             AS x_axis,
  ROUND(exceed_rate * 100)::int        AS data
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
ORDER BY exceed_rate DESC, noise_category$$
WHERE index = 'env_noise_exceed'
  AND city = 'metrotaipei'
  AND query_type = 'percent';
