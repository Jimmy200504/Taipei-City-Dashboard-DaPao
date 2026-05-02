-- ============================================================
-- 雙北路燈瓦數分布 — DBManager 元件設定
-- 目標：postgres-manager:5432 / database: dashboardmanager
--
-- 執行指令（從專案根目錄）：
--   docker exec -i postgres-manager \
--     psql -U postgres -d dashboardmanager \
--     < db-sample-data/streetlight_dbmanager.sql
--
-- 注意：
--   - component_maps.id 使用 200、201；若已存在請先刪除或調整。
--   - components.id 使用 219、220；若已存在請先刪除或調整。
--   - 執行完成後確認 component_maps id，再至 dashboards 加入元件。
-- ============================================================

-- 地圖圖層設定
-- 對應 GeoJSON 檔案（須先執行 generate_geojson.py 生成）：
--   Taipei-City-Dashboard-FE/public/mapData/streetlight_watt_tpe.geojson
--   Taipei-City-Dashboard-FE/public/mapData/streetlight_watt_metrotaipei.geojson
INSERT INTO public.component_maps (id, index, title, type, source, size, icon, paint, property)
VALUES
(
    200,
    'streetlight_watt_tpe',
    '臺北市路燈點位',
    'circle',
    'geojson',
    NULL,
    NULL,
    '{"circle-color":["match",["get","watt_bucket"],"ultra_low","#2196F3","low","#00BCD4","medium","#FFEB3B","high","#FF9800","very_high","#F44336","#9E9E9E"],"circle-radius":3,"circle-opacity":0.8}',
    '[{"key":"district","name":"行政區"},{"key":"watt","name":"瓦數 (W)"},{"key":"watt_bucket","name":"瓦數級距"},{"key":"light_type","name":"燈種"},{"key":"light_year","name":"裝設年分"},{"key":"data_time","name":"資料時間"}]'
),
(
    201,
    'streetlight_watt_metrotaipei',
    '雙北路燈點位',
    'circle',
    'geojson',
    NULL,
    NULL,
    '{"circle-color":["match",["get","watt_bucket"],"ultra_low","#2196F3","low","#00BCD4","medium","#FFEB3B","high","#FF9800","very_high","#F44336","#9E9E9E"],"circle-radius":3,"circle-opacity":0.8}',
    '[{"key":"city","name":"城市"},{"key":"district","name":"行政區"},{"key":"watt","name":"瓦數 (W)"},{"key":"watt_bucket","name":"瓦數級距"},{"key":"light_type","name":"燈種"},{"key":"data_time","name":"資料時間"}]'
);

-- 元件圖表樣式
INSERT INTO public.component_charts (index, color, types, unit)
VALUES
(
    'streetlight_district',
    '{#1a237e,#283593,#3949ab,#5c6bc0,#7986cb,#9fa8da,#c5cae9,#e8eaf6}',
    '{DistrictChart}',
    'W'
),
(
    'streetlight_watt_bucket',
    '{#2196F3,#00BCD4,#FFEB3B,#FF9800,#F44336,#9E9E9E}',
    '{DonutChart}',
    '盞'
);

-- 元件基本資料
INSERT INTO public.components (id, index, name)
VALUES
(219, 'streetlight_district',    '雙北路燈行政區平均瓦數'),
(220, 'streetlight_watt_bucket', '雙北路燈瓦數級距分布');

-- 查詢設定（DistrictChart：台北市 + 雙北）
INSERT INTO public.query_charts
    (index, history_config, map_config_ids, map_filter,
     time_from, time_to, update_freq, update_freq_unit,
     source, short_desc, long_desc, use_case, links, contributors,
     created_at, updated_at, query_type, query_chart, query_history, city)
VALUES
(
    'streetlight_district',
    NULL, '{200}', '{}',
    'static', NULL, 7, 'day',
    '臺北市政府資料平台',
    '臺北市各行政區路燈平均瓦數',
    '依行政區顯示臺北市路燈平均耗電強度（W）。數值越高代表該行政區路燈能耗越大，可作為節能政策優先序的參考。',
    '用於識別高耗電行政區，協助政府優先推動 LED 換燈計畫，降低整體路燈能耗。',
    '{"https://tppkl.blob.core.windows.net/blobfs/TaipeiLight.json"}',
    '{doit}',
    NOW(), NOW(),
    'two_d',
    'SELECT district AS x_axis, ROUND(avg_watt, 1) AS data FROM env_streetlight_district_summary WHERE city_scope = ''taipei'' ORDER BY avg_watt DESC',
    NULL, 'taipei'
),
(
    'streetlight_district',
    NULL, '{201}', '{}',
    'static', NULL, 7, 'day',
    '臺北市政府資料平台、新北市政府開放資料',
    '雙北各行政區路燈平均瓦數',
    '依行政區顯示臺北市與新北市路燈平均耗電強度（W）。數值越高代表該行政區路燈能耗越大。',
    '比較雙北各行政區路燈能耗差異，找出換燈效益最高的地區。',
    '{"https://tppkl.blob.core.windows.net/blobfs/TaipeiLight.json","https://data.ntpc.gov.tw/api/datasets/39149fe0-85ab-4e6c-99e5-60657d44895f/json"}',
    '{doit,ntpc}',
    NOW(), NOW(),
    'two_d',
    'SELECT district AS x_axis, ROUND(avg_watt, 1) AS data FROM env_streetlight_district_summary WHERE city_scope = ''twin_city'' ORDER BY avg_watt DESC',
    NULL, 'metrotaipei'
);

-- 查詢設定（DonutChart：台北市 + 雙北）
INSERT INTO public.query_charts
    (index, history_config, map_config_ids, map_filter,
     time_from, time_to, update_freq, update_freq_unit,
     source, short_desc, long_desc, use_case, links, contributors,
     created_at, updated_at, query_type, query_chart, query_history, city)
VALUES
(
    'streetlight_watt_bucket',
    NULL, '{200}', '{}',
    'static', NULL, 7, 'day',
    '臺北市政府資料平台',
    '臺北市路燈瓦數級距占比',
    '顯示臺北市路燈依瓦數分為六個級距的數量占比。ultra_low（≤30W）代表現代 LED；very_high（>250W）代表高功率傳統燈。',
    '評估節能換燈進展：ultra_low 與 low 占比越高，代表 LED 滲透率越好。',
    '{"https://tppkl.blob.core.windows.net/blobfs/TaipeiLight.json"}',
    '{doit}',
    NOW(), NOW(),
    'percent',
    'SELECT watt_bucket AS x_axis, light_count AS data FROM env_streetlight_watt_bucket_summary WHERE city_scope = ''taipei'' ORDER BY watt_bucket_order',
    NULL, 'taipei'
),
(
    'streetlight_watt_bucket',
    NULL, '{201}', '{}',
    'static', NULL, 7, 'day',
    '臺北市政府資料平台、新北市政府開放資料',
    '雙北路燈瓦數級距占比',
    '顯示臺北市與新北市路燈依瓦數分為六個級距的數量占比。',
    '比較雙北路燈能效結構，評估整體節能換燈進度。',
    '{"https://tppkl.blob.core.windows.net/blobfs/TaipeiLight.json","https://data.ntpc.gov.tw/api/datasets/39149fe0-85ab-4e6c-99e5-60657d44895f/json"}',
    '{doit,ntpc}',
    NOW(), NOW(),
    'percent',
    'SELECT watt_bucket AS x_axis, light_count AS data FROM env_streetlight_watt_bucket_summary WHERE city_scope = ''twin_city'' ORDER BY watt_bucket_order',
    NULL, 'metrotaipei'
);

-- ============================================================
-- 最後一步：將元件加入 dashboard
-- 請先確認 dashboard id，再執行以下指令。
--
-- 範例：加入現有的 taipei dashboard (id=356) 與 metrotaipei dashboard (id=355)
--   UPDATE public.dashboards SET components = components || ARRAY[219,220]
--   WHERE id IN (356, 355);
--
-- 或建立新的能源儀表板：
--   INSERT INTO public.dashboards (index, name, components, icon)
--   VALUES ('street_energy_tpe',        '路燈能源效率', ARRAY[219,220], 'lightbulb'),
--          ('street_energy_metrotaipei', '路燈能源效率', ARRAY[219,220], 'lightbulb');
-- ============================================================
