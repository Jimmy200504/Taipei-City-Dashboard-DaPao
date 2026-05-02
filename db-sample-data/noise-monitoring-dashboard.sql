-- =============================================================================
-- Noise Monitoring Dashboard Registration
-- Target DB: dashboardmanager (postgres_manager)
--
-- Run AFTER:
--   1. noise-monitoring-tables.sql      (dashboard DB)
--   2. noise-monitoring-component.sql   (initial component_maps / components / query_charts)
--   3. update-map-query.py              (fixes map_legend to use quarterly stats)
--   4. update-district-query.py         (fixes two_d / percent to use latest available data)
--
-- This script:
--   1. Keeps only map_legend rows under env_noise_monitoring (removes time/two_d/percent)
--   2. Creates 3 additional components: env_noise_trend, env_noise_district, env_noise_exceed
--   3. Inserts query_charts for the 3 new components (with fixed queries)
--   4. Inserts component_charts for all 4 components
--   5. Creates taipei + metrotaipei dashboards and links them to city groups
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. Clean up: env_noise_monitoring → map-only
--    The backend returns only ONE row per (component_id, city) lookup.
--    Multiple query_types under the same index cause non-deterministic results.
-- ---------------------------------------------------------------------------
DELETE FROM public.query_charts
WHERE index = 'env_noise_monitoring'
  AND query_type <> 'map_legend';


-- ---------------------------------------------------------------------------
-- 2. New components
-- ---------------------------------------------------------------------------
INSERT INTO public.components (index, name) VALUES
  ('env_noise_trend',    '噪音季度趨勢'),
  ('env_noise_district', '行政區噪音分佈'),
  ('env_noise_exceed',   '行政區噪音超標率')
ON CONFLICT (index) DO NOTHING;


-- ---------------------------------------------------------------------------
-- 3. query_charts for env_noise_trend  (query_type = 'time')
-- ---------------------------------------------------------------------------
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
) VALUES

-- city = taipei
('env_noise_trend', NULL, '{}', '{}',
 'static', NULL, 1, 'month',
 '臺北市環境保護局',
 '臺北市各季均能噪音折線圖',
 '呈現臺北市噪音監測站過去三年各季日間、晚間、夜間均能音量變化趨勢，涵蓋交通噪音與環境噪音兩類。',
 '觀察臺北市噪音季節性波動，評估長期趨勢，輔助噪音防制政策決策。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx}',
 '{doit}',
 NOW(), NOW(),
 'time',
 'SELECT
  noise_category,
  quarter_label AS x,
  period        AS y_axis,
  avg_db        AS data
FROM env_noise_quarterly_stats_tpe
WHERE year >= EXTRACT(YEAR FROM NOW())::int - 2
ORDER BY year, quarter, period, noise_category',
 NULL,
 'taipei'),

-- city = metrotaipei
('env_noise_trend', NULL, '{}', '{}',
 'static', NULL, 1, 'month',
 '臺北市環境保護局 / 新北市環境保護局',
 '雙北各季均能噪音折線圖',
 '呈現臺北市及新北市噪音監測站過去三年各季日間、晚間、夜間均能音量變化趨勢，涵蓋交通噪音與環境噪音兩類。',
 '比較雙北噪音季節性波動，評估城市整體噪音水準。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx,https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats}',
 '{doit,ntpc}',
 NOW(), NOW(),
 'time',
 'SELECT
  noise_category,
  quarter_label AS x,
  period        AS y_axis,
  avg_db        AS data
FROM (
  SELECT noise_category, quarter_label, period, avg_db, year, quarter
  FROM env_noise_quarterly_stats_tpe
  UNION ALL
  SELECT noise_category, quarter_label, period, avg_db, year, quarter
  FROM env_noise_quarterly_stats_new_tpe
) combined
WHERE year >= EXTRACT(YEAR FROM NOW())::int - 2
ORDER BY year, quarter, period, noise_category',
 NULL,
 'metrotaipei');


-- ---------------------------------------------------------------------------
-- 4. query_charts for env_noise_district  (query_type = 'two_d')
--    Uses latest available (year, quarter) — same fix as update-district-query.py
-- ---------------------------------------------------------------------------
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
) VALUES

-- city = taipei
('env_noise_district', NULL, '{}', '{}',
 'static', NULL, 1, 'month',
 '臺北市環境保護局',
 '臺北市各行政區日間均能音量',
 '呈現臺北市各行政區最近一季的日間均能音量平均值。',
 '比較臺北市各行政區噪音水準，識別高噪音熱點。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx}',
 '{doit}',
 NOW(), NOW(),
 'two_d',
 'SELECT
  noise_category,
  district   AS x_axis,
  avg_day_db AS data
FROM env_noise_district_summary_tpe
WHERE (year, quarter) = (
  SELECT year, quarter FROM env_noise_district_summary_tpe
  ORDER BY year DESC, quarter DESC LIMIT 1
)
ORDER BY district, noise_category',
 NULL,
 'taipei'),

-- city = metrotaipei
('env_noise_district', NULL, '{}', '{}',
 'static', NULL, 1, 'month',
 '臺北市環境保護局 / 新北市環境保護局',
 '雙北各行政區日間均能音量',
 '呈現雙北各行政區最近一季的日間均能音量平均值。',
 '比較雙北各行政區噪音水準，識別高噪音熱點。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx,https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats}',
 '{doit,ntpc}',
 NOW(), NOW(),
 'two_d',
 'SELECT
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
ORDER BY district, noise_category',
 NULL,
 'metrotaipei');


-- ---------------------------------------------------------------------------
-- 5. query_charts for env_noise_exceed  (query_type = 'percent')
--    Uses latest available year — same fix as update-district-query.py
-- ---------------------------------------------------------------------------
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
) VALUES

-- city = taipei
('env_noise_exceed', NULL, '{}', '{}',
 'static', NULL, 1, 'month',
 '臺北市環境保護局',
 '臺北市各行政區噪音超標率',
 '呈現臺北市各行政區本年度噪音超標率。超標率 = 超標季次 / 有效量測季次。',
 '識別臺北市噪音超標熱點，輔助執法資源配置。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx}',
 '{doit}',
 NOW(), NOW(),
 'percent',
 'SELECT
  noise_category,
  district                             AS x_axis,
  ROUND(exceed_rate * 100)::int        AS data
FROM env_noise_district_summary_tpe
WHERE year = (SELECT MAX(year) FROM env_noise_district_summary_tpe)
ORDER BY exceed_rate DESC, noise_category',
 NULL,
 'taipei'),

-- city = metrotaipei
('env_noise_exceed', NULL, '{}', '{}',
 'static', NULL, 1, 'month',
 '臺北市環境保護局 / 新北市環境保護局',
 '雙北各行政區噪音超標率',
 '呈現雙北各行政區本年度噪音超標率。',
 '識別雙北噪音超標熱點，輔助跨城市執法資源配置。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx,https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats}',
 '{doit,ntpc}',
 NOW(), NOW(),
 'percent',
 'SELECT
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
ORDER BY exceed_rate DESC, noise_category',
 NULL,
 'metrotaipei');


-- ---------------------------------------------------------------------------
-- 6. component_charts  (frontend chart type & color config)
-- ---------------------------------------------------------------------------
-- env_noise_monitoring: map with noise-level color gradient
-- env_noise_trend:      time-series; 6 colors for 3 periods × 2 categories
-- env_noise_district:   bar chart; 2 colors for traffic vs environmental
-- env_noise_exceed:     percent bar; 2 colors for traffic vs environmental
INSERT INTO public.component_charts (index, color, types, unit) VALUES
  ('env_noise_monitoring',
   '{#4CAF50,#CDDC39,#FFEB3B,#FF9800,#F44336}',
   '{MapLegend}',
   'dB'),
  ('env_noise_trend',
   '{#29B6F6,#81D4FA,#0288D1,#66BB6A,#A5D6A7,#388E3C}',
   '{TimelineSeparateChart}',
   'dB'),
  ('env_noise_district',
   '{#FF7043,#66BB6A}',
   '{BarChart}',
   'dB'),
  ('env_noise_exceed',
   '{#EF5350,#FB8C00}',
   '{BarPercentChart}',
   '%')
ON CONFLICT (index) DO NOTHING;

-- ---------------------------------------------------------------------------
-- 7. Dashboard setup
--    Intentionally omitted — add components to dashboards via the UI
--    after merging all team members' components.
-- ---------------------------------------------------------------------------
