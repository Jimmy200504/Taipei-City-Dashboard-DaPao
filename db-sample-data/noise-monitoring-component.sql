-- =============================================================================
-- Noise Monitoring Component Registration
-- Target DB: dashboardmanager (postgres_manager)
-- Run order: component_maps → components → query_charts
--
-- Prerequisites:
--   1. env_noise_stations, env_noise_monthly_measurements, env_noise_quarterly_stats_tpe,
--      env_noise_district_summary_tpe must exist in dashboard_data (postgres_default).
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. component_maps  (map layer styling for station points)
--    id is auto-assigned by sequence; no hardcoded value to avoid conflicts.
-- ---------------------------------------------------------------------------
INSERT INTO public.component_maps (index, title, type, source, size, icon, paint, property)
SELECT
    'env_noise_monitoring',
    '噪音測站',
    'circle',
    'geojson',
    NULL,
    NULL,
    '{
        "circle-color": [
            "step", ["get", "latest_day_db"],
            "#4CAF50",
            55, "#CDDC39",
            65, "#FFEB3B",
            70, "#FF9800",
            75, "#F44336"
        ],
        "circle-radius": 6,
        "circle-opacity": 0.85
    }',
    '[
        {"key": "station_name",          "name": "測站名稱"},
        {"key": "city",                  "name": "城市"},
        {"key": "district",              "name": "行政區"},
        {"key": "station_id",            "name": "測站編號"},
        {"key": "noise_category",        "name": "噪音類別"},
        {"key": "monitoring_type",       "name": "監測方式"},
        {"key": "control_zone",          "name": "管制區別"},
        {"key": "standard_day_db",       "name": "日間管制標準(dB)"},
        {"key": "standard_evening_db",   "name": "晚間管制標準(dB)"},
        {"key": "standard_night_db",     "name": "夜間管制標準(dB)"},
        {"key": "latest_day_db",         "name": "最新日間(dB)"},
        {"key": "latest_evening_db",     "name": "最新晚間(dB)"},
        {"key": "latest_night_db",       "name": "最新夜間(dB)"},
        {"key": "exceeded_standard",     "name": "是否超標"},
        {"key": "total_exceed_count",    "name": "歷年超標次數"},
        {"key": "measurement_year",      "name": "量測年份"},
        {"key": "measurement_month",     "name": "量測月份"},
        {"key": "data_time",             "name": "資料時間"},
        {"key": "source_name",           "name": "資料來源"}
    ]'
WHERE NOT EXISTS (
    SELECT 1 FROM public.component_maps WHERE index = 'env_noise_monitoring'
);


-- ---------------------------------------------------------------------------
-- 2. components
-- ---------------------------------------------------------------------------
INSERT INTO public.components (index, name)
VALUES ('env_noise_monitoring', '環境噪音監測與分佈')
ON CONFLICT (index) DO NOTHING;


-- ---------------------------------------------------------------------------
-- 3. query_charts
--
-- Notes:
-- • Each component index has one row per city scope:
--     city = 'taipei'      → 臺北市 only
--     city = 'metrotaipei' → 臺北市 + 新北市
-- • noise_category is included as a SELECT column so the frontend can
--   filter between '交通噪音' (traffic) and '環境噪音' (environmental).
--   The dashboard standard query system does not support arbitrary WHERE
--   parameters beyond time_from/time_to, so all categories are returned
--   together and the frontend handles the category toggle.
-- • map_legend query uses a CASE for city_scope matching.
-- ---------------------------------------------------------------------------

-- [A] Quarterly trend line chart (time type) --------------------------------
-- city = taipei
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
)
VALUES (
    'env_noise_monitoring',
    NULL, '{}', '{}',
    'static', NULL, 1, 'month',
    '臺北市環境保護局',
    '臺北市各季均能噪音折線圖',
    '呈現臺北市噪音監測站過去三年各季日間、晚間、夜間均能音量變化趨勢，涵蓋交通噪音與環境噪音兩類。',
    '用於觀察臺北市噪音季節性波動，評估長期趨勢，輔助噪音防制政策決策。',
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
WHERE 1=1  -- all rows in _tpe are Taipei
  AND year >= EXTRACT(YEAR FROM NOW())::int - 2
ORDER BY year, quarter, period, noise_category',
    NULL,
    'taipei'
);

-- city = metrotaipei
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
)
VALUES (
    'env_noise_monitoring',
    NULL, '{}', '{}',
    'static', NULL, 1, 'month',
    '臺北市環境保護局 / 新北市環境保護局',
    '雙北各季均能噪音折線圖',
    '呈現臺北市及新北市噪音監測站過去三年各季日間、晚間、夜間均能音量變化趨勢，涵蓋交通噪音與環境噪音兩類。',
    '用於比較雙北噪音季節性波動，評估城市整體噪音水準，輔助跨城市噪音防制政策決策。',
    '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx,https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats}',
    '{doit,ntpc}',
    NOW(), NOW(),
    'time',
    'SELECT
  noise_category,
  quarter_label AS x,
  period        AS y_axis,
  avg_db        AS data
FROM env_noise_quarterly_stats_tpe
WHERE 1=1  -- UNION ALL handled at query level
  AND year >= EXTRACT(YEAR FROM NOW())::int - 2
ORDER BY year, quarter, period, noise_category',
    NULL,
    'metrotaipei'
);


-- [B] District noise heatmap (two_d type) -----------------------------------
-- city = taipei
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
)
VALUES (
    'env_noise_monitoring',
    NULL, '{}', '{}',
    'static', NULL, 1, 'month',
    '臺北市環境保護局',
    '臺北市各行政區日間均能音量',
    '呈現臺北市各行政區最近一季的日間均能音量平均值。',
    '用於比較臺北市各行政區噪音水準，識別高噪音熱點區域。',
    '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx}',
    '{doit}',
    NOW(), NOW(),
    'two_d',
    'SELECT
  noise_category,
  district  AS x_axis,
  avg_day_db AS data
FROM env_noise_district_summary_tpe
WHERE 1=1  -- all rows in _tpe are Taipei
  AND year = EXTRACT(YEAR FROM NOW())::int
  AND quarter = CEIL(EXTRACT(MONTH FROM NOW()) / 3.0)::int
ORDER BY district, noise_category',
    NULL,
    'taipei'
);

-- city = metrotaipei
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
)
VALUES (
    'env_noise_monitoring',
    NULL, '{}', '{}',
    'static', NULL, 1, 'month',
    '臺北市環境保護局 / 新北市環境保護局',
    '雙北各行政區日間均能音量',
    '呈現雙北各行政區最近一季的日間均能音量平均值。',
    '用於比較雙北各行政區噪音水準，識別高噪音熱點區域。',
    '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx,https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats}',
    '{doit,ntpc}',
    NOW(), NOW(),
    'two_d',
    'SELECT
  noise_category,
  district   AS x_axis,
  avg_day_db AS data
FROM env_noise_district_summary_tpe
WHERE 1=1  -- UNION ALL handled at query level
  AND year = EXTRACT(YEAR FROM NOW())::int
  AND quarter = CEIL(EXTRACT(MONTH FROM NOW()) / 3.0)::int
ORDER BY district, noise_category',
    NULL,
    'metrotaipei'
);


-- [C] Exceed-rate bar chart (percent type) ----------------------------------
-- city = taipei
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
)
VALUES (
    'env_noise_monitoring',
    NULL, '{}', '{}',
    'static', NULL, 1, 'month',
    '臺北市環境保護局',
    '臺北市各行政區超標率',
    '呈現臺北市各行政區本年度噪音超標率，超標率 = 超標月次 / 有效量測月次。',
    '用於識別臺北市噪音超標熱點，輔助執法資源配置。',
    '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx}',
    '{doit}',
    NOW(), NOW(),
    'percent',
    'SELECT
  noise_category,
  district    AS x_axis,
  exceed_rate AS data
FROM env_noise_district_summary_tpe
WHERE 1=1  -- all rows in _tpe are Taipei
  AND year = EXTRACT(YEAR FROM NOW())::int
ORDER BY exceed_rate DESC, noise_category',
    NULL,
    'taipei'
);

-- city = metrotaipei
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
)
VALUES (
    'env_noise_monitoring',
    NULL, '{}', '{}',
    'static', NULL, 1, 'month',
    '臺北市環境保護局 / 新北市環境保護局',
    '雙北各行政區超標率',
    '呈現雙北各行政區本年度噪音超標率。',
    '用於識別雙北噪音超標熱點，輔助跨城市執法資源配置。',
    '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx,https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats}',
    '{doit,ntpc}',
    NOW(), NOW(),
    'percent',
    'SELECT
  noise_category,
  district    AS x_axis,
  exceed_rate AS data
FROM env_noise_district_summary_tpe
WHERE 1=1  -- UNION ALL handled at query level
  AND year = EXTRACT(YEAR FROM NOW())::int
ORDER BY exceed_rate DESC, noise_category',
    NULL,
    'metrotaipei'
);


-- [D] Map layer (map_legend type) -------------------------------------------
-- city = taipei
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
)
VALUES (
    'env_noise_monitoring',
    NULL, ARRAY[(SELECT id FROM public.component_maps WHERE index = 'env_noise_monitoring')], '{}',
    'static', NULL, 1, 'month',
    '臺北市環境保護局',
    '臺北市噪音測站分佈',
    '顯示臺北市所有噪音監測站位置，點位顏色依最新日間均能音量深淺呈現。',
    '點擊測站可查看詳細資訊，包含量測值、管制標準與超標記錄。',
    '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx}',
    '{doit}',
    NOW(), NOW(),
    'map_legend',
    'WITH latest AS (
  SELECT station_name,
         year AS latest_year, quarter AS latest_quarter,
         MAX(CASE WHEN period=''day''     THEN avg_db END) AS day_db,
         MAX(CASE WHEN period=''evening'' THEN avg_db END) AS evening_db,
         MAX(CASE WHEN period=''night''   THEN avg_db END) AS night_db,
         ROW_NUMBER() OVER (
           PARTITION BY station_name ORDER BY year DESC, quarter DESC
         ) AS rn
  FROM (SELECT station_name, year, quarter, period, avg_db
        FROM env_noise_quarterly_stats_tpe) q
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
WHERE s.city = ''臺北市''
  AND s.wkb_geometry IS NOT NULL',
    NULL,
    'taipei'
);

-- city = metrotaipei
INSERT INTO public.query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
)
VALUES (
    'env_noise_monitoring',
    NULL, ARRAY[(SELECT id FROM public.component_maps WHERE index = 'env_noise_monitoring')], '{}',
    'static', NULL, 1, 'month',
    '臺北市環境保護局 / 新北市環境保護局',
    '雙北噪音測站分佈',
    '顯示臺北市及新北市所有噪音監測站位置，點位顏色依最新日間均能音量深淺呈現。',
    '點擊測站可查看詳細資訊，包含量測值、管制標準與超標記錄。',
    '{https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx,https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats}',
    '{doit,ntpc}',
    NOW(), NOW(),
    'map_legend',
    'WITH latest AS (
  SELECT station_name,
         year AS latest_year, quarter AS latest_quarter,
         MAX(CASE WHEN period=''day''     THEN avg_db END) AS day_db,
         MAX(CASE WHEN period=''evening'' THEN avg_db END) AS evening_db,
         MAX(CASE WHEN period=''night''   THEN avg_db END) AS night_db,
         ROW_NUMBER() OVER (
           PARTITION BY station_name ORDER BY year DESC, quarter DESC
         ) AS rn
  FROM (SELECT station_name, year, quarter, period, avg_db
        FROM env_noise_quarterly_stats_tpe
        UNION ALL
        SELECT station_name, year, quarter, period, avg_db
        FROM env_noise_quarterly_stats_new_tpe) q
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
WHERE s.city IN (''臺北市'', ''新北市'')
  AND s.wkb_geometry IS NOT NULL',
    NULL,
    'metrotaipei'
);
