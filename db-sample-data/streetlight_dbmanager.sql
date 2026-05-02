-- DBManager setup for streetlight wattage dashboard
-- Target: postgres-manager:5432, db: dashboardmanager
-- Run: docker exec -i postgres-manager psql -U postgres -d dashboardmanager < db-sample-data/streetlight_dbmanager.sql

-- component_maps: one GeoJSON circle layer per city
INSERT INTO public.component_maps (id, index, title, type, source, size, icon, paint, property)
OVERRIDING SYSTEM VALUE
VALUES
(
    200,
    'streetlight_watt_tpe',
    '路燈瓦數（臺北市）',
    'circle',
    'geojson',
    NULL,
    NULL,
    '{
        "circle-color": ["match", ["get", "level"],
            "1-ultra_low", "#2196F3",
            "2-low",       "#00BCD4",
            "3-medium",    "#FFEB3B",
            "4-high",      "#FF9800",
            "5-very_high", "#F44336",
            "#cccccc"
        ],
        "circle-radius": 4,
        "circle-opacity": 0.75
    }',
    '[
        {"key": "district",     "name": "行政區"},
        {"key": "serial_no",    "name": "路燈編號"},
        {"key": "light_height", "name": "燈桿高度（m）"},
        {"key": "watt",         "name": "總瓦數（W）"},
        {"key": "level",        "name": "用電等級"}
    ]'
),
(
    201,
    'streetlight_watt_metrotaipei',
    '路燈瓦數（雙北）',
    'circle',
    'geojson',
    NULL,
    NULL,
    '{
        "circle-color": ["match", ["get", "level"],
            "1-ultra_low", "#2196F3",
            "2-low",       "#00BCD4",
            "3-medium",    "#FFEB3B",
            "4-high",      "#FF9800",
            "5-very_high", "#F44336",
            "#cccccc"
        ],
        "circle-radius": 4,
        "circle-opacity": 0.75
    }',
    '[
        {"key": "district",  "name": "行政區"},
        {"key": "serial_no", "name": "路燈編號"},
        {"key": "watt",      "name": "總瓦數（W）"},
        {"key": "level",     "name": "用電等級"}
    ]'
)
ON CONFLICT (id) DO NOTHING;

-- Advance sequence past the manually inserted IDs
SELECT setval('component_maps_id_seq', GREATEST(201, (SELECT MAX(id) FROM component_maps)));

-- components: two chart components
INSERT INTO public.components (id, index, name)
OVERRIDING SYSTEM VALUE
VALUES
    (219, 'streetlight_avg_watt',  '路燈平均瓦數'),
    (220, 'streetlight_watt_dist', '路燈用電比例')
ON CONFLICT (id) DO UPDATE
    SET name = EXCLUDED.name;

SELECT setval('components_id_seq', GREATEST(220, (SELECT MAX(id) FROM components)));

-- component_charts
-- summary column: 'avg' → DistrictChart shows 平均 instead of 總合 (NULL = default sum behavior)
ALTER TABLE public.component_charts ADD COLUMN IF NOT EXISTS summary character varying;

INSERT INTO public.component_charts (index, color, types, unit, summary)
VALUES
    (
        'streetlight_avg_watt',
        '{"#FF9800"}',
        '{"DistrictChart","ColumnChart"}',
        'W',
        'avg'
    ),
    (
        'streetlight_watt_dist',
        '{"#2196F3","#00BCD4","#FFEB3B","#FF9800","#F44336"}',
        '{"BarPercentChart","ColumnChart"}',
        '盞',
        NULL
    )
ON CONFLICT (index) DO UPDATE
    SET color   = EXCLUDED.color,
        types   = EXCLUDED.types,
        unit    = EXCLUDED.unit,
        summary = EXCLUDED.summary;

-- query_charts: 2 components × 2 cities = 4 rows

-- Component A (streetlight_avg_watt) — taipei
INSERT INTO public.query_charts
    (index, map_config_ids, map_filter, update_freq, update_freq_unit,
     source, short_desc, long_desc, use_case,
     links, contributors, created_at, updated_at,
     query_type, query_chart, query_history, city,
     time_from, time_to)
VALUES
(
    'streetlight_avg_watt',
    '{}',
    '{}',
    7, 'day',
    '臺北市工務局',
    '臺北市各行政區路燈平均用電量',
    '以行政區著色深淺呈現臺北市 12 行政區的路燈平均瓦數，顏色越深代表平均用電量越高。可切換縱向長條圖依排名比較各區差異。資料來自臺北市工務局路燈資產清冊，每週更新。',
    '識別高耗能路燈集中的行政區，輔助評估 LED 路燈汰換優先順序與節能潛力。',
    '{"https://data.taipei/dataset/detail?id=262e80cf-579c-4bfb-ba73-31621bc84616"}',
    '{"doit"}',
    NOW(), NOW(),
    'two_d',
    'SELECT district AS x_axis, ROUND(avg_watt)::int AS data
FROM env_streetlight_district_summary
WHERE city_scope = ''taipei''
ORDER BY avg_watt DESC',
    NULL,
    'taipei',
    'static', NULL
),

-- Component A (streetlight_avg_watt) — metrotaipei
(
    'streetlight_avg_watt',
    '{}',
    '{}',
    7, 'day',
    '臺北市工務局、新北市工務局',
    '雙北各行政區路燈平均用電量',
    '以行政區著色深淺整合呈現臺北市與新北市共 43 行政區的路燈平均瓦數，顏色越深代表平均用電量越高。可切換縱向長條圖查看跨縣市排名。',
    '跨縣市比較路燈能源效率，協助雙北節能政策的行政區優先排序與資源分配。',
    '{"https://data.taipei/dataset/detail?id=262e80cf-579c-4bfb-ba73-31621bc84616","https://data.ntpc.gov.tw/datasets/39149fe0-85ab-4e6c-99e5-60657d44895f"}',
    '{"doit","ntpc"}',
    NOW(), NOW(),
    'two_d',
    'SELECT district AS x_axis, ROUND(avg_watt)::int AS data
FROM env_streetlight_district_summary
WHERE city_scope = ''metrotaipei''
ORDER BY avg_watt DESC',
    NULL,
    'metrotaipei',
    'static', NULL
),

-- Component B (streetlight_watt_dist) — taipei
(
    'streetlight_watt_dist',
    '{200}',
    '{}',
    7, 'day',
    '臺北市工務局',
    '臺北市各行政區路燈瓦數等級組成',
    '以百分比堆疊長條圖呈現臺北市 12 行政區的路燈瓦數等級分布，每色段對應一個等級（≤30W／31–80W／81–150W／151–250W／>250W），長度代表該等級路燈數佔行政區總燈數的比例。可切換縱向長條圖查看各等級絕對燈數。',
    '掌握各行政區高耗能（>250W）路燈佔比，協助規劃 LED 節能汰換批次與預算分配。',
    '{"https://data.taipei/dataset/detail?id=262e80cf-579c-4bfb-ba73-31621bc84616"}',
    '{"doit"}',
    NOW(), NOW(),
    'three_d',
    'SELECT d.district AS x_axis,
       CASE b.watt_bucket
         WHEN ''ultra_low'' THEN ''≤30W''
         WHEN ''low''       THEN ''31-80W''
         WHEN ''medium''    THEN ''81-150W''
         WHEN ''high''      THEN ''151-250W''
         WHEN ''very_high'' THEN ''>250W''
       END AS y_axis,
       COALESCE(w.lamp_count, 0) AS data
FROM (SELECT DISTINCT district FROM env_streetlight_district_watt_bucket WHERE city_scope = ''taipei'') d
CROSS JOIN (SELECT DISTINCT watt_bucket, watt_bucket_order FROM env_streetlight_district_watt_bucket) b
LEFT JOIN env_streetlight_district_watt_bucket w
  ON w.district = d.district AND w.watt_bucket = b.watt_bucket AND w.city_scope = ''taipei''
ORDER BY b.watt_bucket_order, d.district',
    NULL,
    'taipei',
    'static', NULL
),

-- Component B (streetlight_watt_dist) — metrotaipei
(
    'streetlight_watt_dist',
    '{201}',
    '{}',
    7, 'day',
    '臺北市工務局、新北市工務局',
    '雙北各行政區路燈瓦數等級組成',
    '以百分比堆疊長條圖整合呈現臺北市與新北市共 43 行政區的路燈瓦數等級分布，各色段對應一個等級（≤30W 至 >250W），長度代表該等級路燈數佔行政區總燈數的比例。可切換縱向長條圖查看各等級絕對燈數。',
    '跨縣市比較各行政區路燈能源結構，識別高耗能等級集中的區域，支援雙北聯合節能政策規劃。',
    '{"https://data.taipei/dataset/detail?id=262e80cf-579c-4bfb-ba73-31621bc84616","https://data.ntpc.gov.tw/datasets/39149fe0-85ab-4e6c-99e5-60657d44895f"}',
    '{"doit","ntpc"}',
    NOW(), NOW(),
    'three_d',
    'SELECT d.district AS x_axis,
       CASE b.watt_bucket
         WHEN ''ultra_low'' THEN ''≤30W''
         WHEN ''low''       THEN ''31-80W''
         WHEN ''medium''    THEN ''81-150W''
         WHEN ''high''      THEN ''151-250W''
         WHEN ''very_high'' THEN ''>250W''
       END AS y_axis,
       COALESCE(w.lamp_count, 0) AS data
FROM (SELECT DISTINCT district FROM env_streetlight_district_watt_bucket WHERE city_scope = ''metrotaipei'') d
CROSS JOIN (SELECT DISTINCT watt_bucket, watt_bucket_order FROM env_streetlight_district_watt_bucket) b
LEFT JOIN env_streetlight_district_watt_bucket w
  ON w.district = d.district AND w.watt_bucket = b.watt_bucket AND w.city_scope = ''metrotaipei''
ORDER BY b.watt_bucket_order, d.district',
    NULL,
    'metrotaipei',
    'static', NULL
);
