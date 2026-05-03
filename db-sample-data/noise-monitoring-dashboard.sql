-- =============================================================================
-- Noise Monitoring Dashboard Registration
-- Target DB: dashboardmanager (postgres_manager)
--
-- Run AFTER:
--   1. noise-monitoring-tables.sql      (dashboard DB)
--   2. noise-monitoring-component.sql   (component_maps / components)
--
-- This script is idempotent — re-running clears and rebuilds all env_noise_*
-- query_charts and component_charts from scratch.
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. Clean up: remove all env_noise_* query_charts and component_charts
-- ---------------------------------------------------------------------------
DELETE FROM public.query_charts   WHERE index LIKE 'env_noise%';
DELETE FROM public.component_charts WHERE index LIKE 'env_noise%';


-- ---------------------------------------------------------------------------
-- 2. New components (idempotent)
-- ---------------------------------------------------------------------------
INSERT INTO public.components (index, name) VALUES
  ('env_noise_trend',    '噪音季度趨勢'),
  ('env_noise_district', '行政區噪音分佈'),
  ('env_noise_exceed',   '行政區噪音超標率')
ON CONFLICT (index) DO NOTHING;


-- ---------------------------------------------------------------------------
-- 3. query_charts for env_noise_monitoring  (query_type = 'map_legend')
--    Returns legend color-scale items only.
--    GeoJSON station data served from static files in public/mapData/.
--    taipei:      map_config_ids → env_noise_monitoring       (Taipei only)
--    metrotaipei: map_config_ids → env_noise_monitoring_metro (Taipei + New Taipei)
-- ---------------------------------------------------------------------------
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
) VALUES
('env_noise_monitoring', NULL,
 ARRAY[(SELECT id FROM public.component_maps WHERE index = 'env_noise_monitoring')], '{}',
 'static', NULL, 3, 'month',
 '臺北市環境保護局',
 '臺北市噪音測站分佈',
 '顯示臺北市所有噪音監測站位置，點位顏色依最新日間均能音量深淺呈現。',
 '點擊測站可查看詳細資訊，包含量測值、管制標準與超標記錄。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx}',
 '{doit}',
 NOW(), NOW(),
 'map_legend',
 $$SELECT unnest(array['< 55 dB','55-65 dB','65-70 dB','70-75 dB','> 75 dB']) AS name,
        'circle' AS type$$,
 NULL,
 'taipei'),
('env_noise_monitoring', NULL,
 ARRAY[(SELECT id FROM public.component_maps WHERE index = 'env_noise_monitoring_metro')], '{}',
 'static', NULL, 3, 'month',
 '臺北市環境保護局 / 新北市環境保護局',
 '雙北噪音測站分佈',
 '顯示臺北市及新北市所有噪音監測站位置，點位顏色依最新日間均能音量深淺呈現。',
 '點擊測站可查看詳細資訊，包含量測值、管制標準與超標記錄。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx,https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats}',
 '{doit,ntpc}',
 NOW(), NOW(),
 'map_legend',
 $$SELECT unnest(array['< 55 dB','55-65 dB','65-70 dB','70-75 dB','> 75 dB']) AS name,
        'circle' AS type$$,
 NULL,
 'metrotaipei');


-- ---------------------------------------------------------------------------
-- 4. query_charts for env_noise_trend  (query_type = 'time')
--    x_axis: first day of each quarter as timestamp via MAKE_DATE
--    y_axis: Chinese period labels (日間/晚間/夜間)
--    data:   AVG across all stations and noise categories, rounded to 1 decimal
-- ---------------------------------------------------------------------------
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
) VALUES
('env_noise_trend', NULL, '{}', '{}',
 'static', NULL, 3, 'month',
 '臺北市環境保護局',
 '臺北市各季均能噪音折線圖',
 '呈現臺北市噪音監測站過去三年各季日間、晚間、夜間均能音量變化趨勢。',
 '觀察臺北市噪音季節性波動，評估長期趨勢，輔助噪音防制政策決策。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx}',
 '{doit}',
 NOW(), NOW(),
 'time',
 $$SELECT
  MAKE_DATE(year, (quarter-1)*3+1, 1)::timestamp AS x_axis,
  CASE period WHEN 'day' THEN '日間' WHEN 'evening' THEN '晚間' ELSE '夜間' END AS y_axis,
  ROUND(AVG(avg_db)::numeric, 1) AS data
FROM env_noise_quarterly_stats_tpe
WHERE year >= EXTRACT(YEAR FROM NOW())::int - 2
GROUP BY year, quarter, period
ORDER BY year, quarter, period$$,
 NULL,
 'taipei'),
('env_noise_trend', NULL, '{}', '{}',
 'static', NULL, 3, 'month',
 '臺北市環境保護局 / 新北市環境保護局',
 '雙北各季均能噪音折線圖',
 '呈現臺北市及新北市噪音監測站過去三年各季日間、晚間、夜間均能音量變化趨勢。',
 '比較雙北噪音季節性波動，評估城市整體噪音水準。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx,https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats}',
 '{doit,ntpc}',
 NOW(), NOW(),
 'time',
 $$SELECT
  MAKE_DATE(year, (quarter-1)*3+1, 1)::timestamp AS x_axis,
  CASE period WHEN 'day' THEN '日間' WHEN 'evening' THEN '晚間' ELSE '夜間' END AS y_axis,
  ROUND(AVG(avg_db)::numeric, 1) AS data
FROM (
  SELECT year, quarter, period, avg_db
  FROM env_noise_quarterly_stats_tpe
  WHERE year >= EXTRACT(YEAR FROM NOW())::int - 2
  UNION ALL
  SELECT year, quarter, period, avg_db
  FROM env_noise_quarterly_stats_new_tpe
  WHERE year >= EXTRACT(YEAR FROM NOW())::int - 2
) combined
GROUP BY year, quarter, period
ORDER BY year, quarter, period$$,
 NULL,
 'metrotaipei');


-- ---------------------------------------------------------------------------
-- 5. query_charts for env_noise_district  (query_type = 'two_d')
--    Latest available (year, quarter). AVG across noise categories. Sorted desc.
-- ---------------------------------------------------------------------------
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
) VALUES
('env_noise_district', NULL, '{}', '{}',
 'static', NULL, 3, 'month',
 '臺北市環境保護局',
 '臺北市各行政區日間均能音量',
 '呈現臺北市各行政區最近一季的日間均能音量平均值。',
 '比較臺北市各行政區噪音水準，識別高噪音熱點。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx}',
 '{doit}',
 NOW(), NOW(),
 'two_d',
 $$SELECT
  district   AS x_axis,
  ROUND(AVG(avg_day_db)::numeric, 1) AS data
FROM env_noise_district_summary_tpe
WHERE (year, quarter) = (
  SELECT year, quarter FROM env_noise_district_summary_tpe
  ORDER BY year DESC, quarter DESC LIMIT 1
)
GROUP BY district
ORDER BY data DESC$$,
 NULL,
 'taipei'),
('env_noise_district', NULL, '{}', '{}',
 'static', NULL, 3, 'month',
 '臺北市環境保護局 / 新北市環境保護局',
 '雙北各行政區日間均能音量',
 '呈現雙北各行政區最近一季的日間均能音量平均值。',
 '比較雙北各行政區噪音水準，識別高噪音熱點。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx,https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats}',
 '{doit,ntpc}',
 NOW(), NOW(),
 'two_d',
 $$SELECT
  district   AS x_axis,
  ROUND(AVG(avg_day_db)::numeric, 1) AS data
FROM (
  SELECT district, avg_day_db, year, quarter
  FROM env_noise_district_summary_tpe
  UNION ALL
  SELECT district, avg_day_db, year, quarter
  FROM env_noise_district_summary_new_tpe
) combined
WHERE (year, quarter) = (
  SELECT year, quarter FROM (
    SELECT year, quarter FROM env_noise_district_summary_tpe
    UNION ALL
    SELECT year, quarter FROM env_noise_district_summary_new_tpe
  ) all_q ORDER BY year DESC, quarter DESC LIMIT 1
)
GROUP BY district
ORDER BY data DESC$$,
 NULL,
 'metrotaipei');


-- ---------------------------------------------------------------------------
-- 6. query_charts for env_noise_exceed  (query_type = 'two_d')
--    exceed_count = stations in district where any period exceeded standard.
--    Latest available (year, quarter). Sorted desc.
-- ---------------------------------------------------------------------------
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
) VALUES
('env_noise_exceed', NULL, '{}', '{}',
 'static', NULL, 3, 'month',
 '臺北市環境保護局',
 '臺北市各行政區噪音超標次數',
 '呈現臺北市各行政區最新一季超標測站數。超標定義：任一時段（日/晚/夜）均能音量超過管制標準。',
 '識別臺北市噪音超標熱點，輔助執法資源配置。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx}',
 '{doit}',
 NOW(), NOW(),
 'two_d',
 $$SELECT
  district          AS x_axis,
  exceed_count::int AS data
FROM env_noise_district_summary_tpe
WHERE (year, quarter) = (
  SELECT year, quarter FROM env_noise_district_summary_tpe
  ORDER BY year DESC, quarter DESC LIMIT 1
)
ORDER BY data DESC$$,
 NULL,
 'taipei'),
('env_noise_exceed', NULL, '{}', '{}',
 'static', NULL, 3, 'month',
 '臺北市環境保護局 / 新北市環境保護局',
 '雙北各行政區噪音超標次數',
 '呈現雙北各行政區最新一季超標測站數。',
 '識別雙北噪音超標熱點，輔助跨城市執法資源配置。',
 '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx,https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats}',
 '{doit,ntpc}',
 NOW(), NOW(),
 'two_d',
 $$SELECT
  district          AS x_axis,
  exceed_count::int AS data
FROM (
  SELECT district, exceed_count, year, quarter
  FROM env_noise_district_summary_tpe
  UNION ALL
  SELECT district, exceed_count, year, quarter
  FROM env_noise_district_summary_new_tpe
) combined
WHERE (year, quarter) = (
  SELECT year, quarter FROM (
    SELECT year, quarter FROM env_noise_district_summary_tpe
    UNION ALL
    SELECT year, quarter FROM env_noise_district_summary_new_tpe
  ) all_q ORDER BY year DESC, quarter DESC LIMIT 1
)
GROUP BY district, exceed_count
ORDER BY data DESC$$,
 NULL,
 'metrotaipei');


-- ---------------------------------------------------------------------------
-- 7. component_charts  (frontend chart type & color config)
--    ON CONFLICT DO UPDATE ensures re-running corrects any stale values.
-- ---------------------------------------------------------------------------
INSERT INTO public.component_charts (index, color, types, unit) VALUES
  ('env_noise_monitoring',
   '{#4CAF50,#CDDC39,#FFEB3B,#FF9800,#F44336}',
   '{MapLegend}',
   'dB'),
  ('env_noise_trend',
   '{#FF9800,#7E57C2,#1E88E5}',
   '{TimelineSeparateChart}',
   'dB'),
  ('env_noise_district',
   '{#F44336,#EE4636,#E84A37,#E24E38,#DC5139,#D7553A,#D1593B,#CB5D3C,#C5603D,#BF643E,#BA683E,#B46B3F,#AE6F40,#A87341,#A27742,#9D7A43,#977E44,#918245,#8B8646,#858947,#808D47,#7A9148,#749449,#6E984A,#689C4B,#63A04C,#5DA34D,#57A74E,#51AB4F,#4CAF50}',
   '{BarChart}',
   'dB'),
  ('env_noise_exceed',
   '{#EF5350}',
   '{DistrictChart,BarChart}',
   '次')
ON CONFLICT (index) DO UPDATE SET
  color = EXCLUDED.color,
  types = EXCLUDED.types,
  unit  = EXCLUDED.unit;

-- ---------------------------------------------------------------------------
-- 8. Dashboard setup
--    Intentionally omitted — add components to dashboards via the UI
--    after merging all team members' components.
-- ---------------------------------------------------------------------------
