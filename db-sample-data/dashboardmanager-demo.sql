-- ============================================================
-- EV Charging Station Dashboard
-- ============================================================

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- components (sequence auto-assigns id)
INSERT INTO public.components (index, name) VALUES
  ('ev_charging_district_stations', '行政區充電站數量'),
  ('ev_charging_district_points',   '行政區充電樁數量'),
  ('ev_charging_connector_power',   '充電槍功率比例')
ON CONFLICT (index) DO NOTHING;

-- component_charts (primary key is index)
INSERT INTO public.component_charts (index, color, types, unit) VALUES
  ('ev_charging_district_stations', '{#4CAF50}',                         '{DistrictChart,ColumnChart}',   '站'),
  ('ev_charging_district_points',   '{#2196F3}',                         '{DistrictChart,ColumnChart}',   '樁'),
  ('ev_charging_connector_power',   '{#81C784,#4FC3F7,#FFB74D,#E57373}', '{BarPercentChart,ColumnChart}', '支')
ON CONFLICT (index) DO NOTHING;

-- contributor TtouTsai (user_id has no unique constraint, use WHERE NOT EXISTS)
INSERT INTO public.contributors (user_id, user_name, image, link, identity, description, include, created_at, updated_at)
SELECT 'TtouTsai', 'TtouTsai', 'https://github.com/TtouTsai.png', 'https://github.com/TtouTsai', NULL, NULL, false, '2026-05-02 19:01:30.596418+00', '2026-05-02 19:01:30.596418+00'
WHERE NOT EXISTS (SELECT 1 FROM public.contributors WHERE user_id = 'TtouTsai');

-- component_maps (index has no unique constraint, use WHERE NOT EXISTS)
INSERT INTO public.component_maps (index, title, type, source, size, icon, paint, property)
SELECT 'ev_charging_stations_tpe', '充電站', 'circle', 'api', NULL, NULL,
  '{"circle-color":"#4CAF50","circle-radius":6,"circle-stroke-width":1.5,"circle-stroke-color":"#fff","circle-opacity":0.9}',
  '[{"key":"station_name","name":"站名"},{"key":"spaces","name":"充電車位數"},{"key":"charging_point_count","name":"充電樁數"},{"key":"connector_count","name":"充電槍數"},{"key":"service_time","name":"服務時間"},{"key":"parking_rate","name":"停車費率"},{"key":"charging_rate","name":"充電費率"},{"key":"power_summary","name":"充電槍功率摘要"},{"key":"data_time","name":"資料時間"}]'
WHERE NOT EXISTS (SELECT 1 FROM public.component_maps WHERE index = 'ev_charging_stations_tpe');

INSERT INTO public.component_maps (index, title, type, source, size, icon, paint, property)
SELECT 'ev_charging_stations_metrotaipei', '充電站', 'circle', 'api', NULL, NULL,
  '{"circle-color":"#4CAF50","circle-radius":6,"circle-stroke-width":1.5,"circle-stroke-color":"#fff","circle-opacity":0.9}',
  '[{"key":"station_name","name":"站名"},{"key":"spaces","name":"充電車位數"},{"key":"charging_point_count","name":"充電樁數"},{"key":"connector_count","name":"充電槍數"},{"key":"service_time","name":"服務時間"},{"key":"parking_rate","name":"停車費率"},{"key":"charging_rate","name":"充電費率"},{"key":"power_summary","name":"充電槍功率摘要"},{"key":"data_time","name":"資料時間"}]'
WHERE NOT EXISTS (SELECT 1 FROM public.component_maps WHERE index = 'ev_charging_stations_metrotaipei');

-- dashboards (sequence auto-assigns id; components array references component ids by subquery)
INSERT INTO public.dashboards (index, name, components, icon, updated_at, created_at)
SELECT
  'ev_charging_tpe', '汽車充電',
  ARRAY(SELECT id FROM public.components WHERE index IN ('ev_charging_district_stations','ev_charging_district_points','ev_charging_connector_power') ORDER BY index),
  'electric_car', '2026-05-02 16:27:57.829836+00', '2026-05-02 16:27:57.829836+00'
WHERE NOT EXISTS (SELECT 1 FROM public.dashboards WHERE index = 'ev_charging_tpe');

INSERT INTO public.dashboards (index, name, components, icon, updated_at, created_at)
SELECT
  'ev_charging_newtpe', '汽車充電',
  ARRAY(SELECT id FROM public.components WHERE index IN ('ev_charging_district_stations','ev_charging_district_points','ev_charging_connector_power') ORDER BY index),
  'electric_car', '2026-05-02 16:27:57.829836+00', '2026-05-02 16:27:57.829836+00'
WHERE NOT EXISTS (SELECT 1 FROM public.dashboards WHERE index = 'ev_charging_newtpe');

-- query_charts: ev_charging_district_stations (taipei)
INSERT INTO public.query_charts
  (index, history_config, map_config_ids, map_filter, time_from, time_to, update_freq, update_freq_unit, source, short_desc, long_desc, use_case, links, contributors, created_at, updated_at, query_type, query_chart, query_history, city)
SELECT
  'ev_charging_district_stations', NULL,
  ARRAY(SELECT id FROM public.component_maps WHERE index = 'ev_charging_stations_tpe'),
  '{}', 'static', NULL, 1, 'week',
  '環保署／交通部',
  '顯示臺北市各行政區電動車充電站數量分布',
  '顯示臺北市與新北市各行政區的電動汽車充電站總數分布，資料來自交通部 TDX CityEVCharging API，整合中央目的事業主管機關公開之充電站位置與營運資訊，每日更新。',
  '透過本組件可以掌握雙北充電站於各行政區的布建密度與整體均衡度，辨識仍須加強的區域，作為雙北政府協同推動電動運具普及、加速汰換燃油車輛、降低都會區交通溫室氣體排放的參考依據，攜手實踐淨零城市願景。',
  '{https://tdx.transportdata.tw/api-service/swagger/basic/b378d320-04a9-4fba-80b8-0df1b96dd5e8#/CityEVCharging/ParkingEV_API_Connector}',
  ARRAY(SELECT user_id FROM public.contributors WHERE user_id = 'TtouTsai'),
  '2026-05-02 16:27:57.829836+00', '2026-05-02 16:27:57.829836+00',
  'two_d',
  'SELECT district AS x_axis, station_count AS data FROM env_ev_charging_district_summary WHERE city_scope = ''taipei'' ORDER BY district',
  NULL, 'taipei'
WHERE NOT EXISTS (SELECT 1 FROM public.query_charts WHERE index = 'ev_charging_district_stations' AND city = 'taipei');

-- query_charts: ev_charging_district_stations (metrotaipei)
INSERT INTO public.query_charts
  (index, history_config, map_config_ids, map_filter, time_from, time_to, update_freq, update_freq_unit, source, short_desc, long_desc, use_case, links, contributors, created_at, updated_at, query_type, query_chart, query_history, city)
SELECT
  'ev_charging_district_stations', NULL,
  ARRAY(SELECT id FROM public.component_maps WHERE index = 'ev_charging_stations_metrotaipei'),
  '{}', 'static', NULL, 1, 'week',
  '環保署／交通部',
  '顯示雙北各行政區電動車充電站數量分布',
  '顯示臺北市與新北市各行政區的電動汽車充電站總數分布，資料來自交通部 TDX CityEVCharging API，整合中央目的事業主管機關公開之充電站位置與營運資訊，每日更新。',
  '透過本組件可以掌握雙北充電站於各行政區的布建密度與整體均衡度，辨識仍須加強的區域，作為雙北政府協同推動電動運具普及、加速汰換燃油車輛、降低都會區交通溫室氣體排放的參考依據，攜手實踐淨零城市願景。',
  '{https://tdx.transportdata.tw/api-service/swagger/basic/b378d320-04a9-4fba-80b8-0df1b96dd5e8#/CityEVCharging/ParkingEV_API_Connector}',
  ARRAY(SELECT user_id FROM public.contributors WHERE user_id = 'TtouTsai'),
  '2026-05-02 16:27:57.829836+00', '2026-05-02 16:27:57.829836+00',
  'two_d',
  'SELECT district AS x_axis, station_count AS data FROM env_ev_charging_district_summary WHERE city_scope = ''twin_city'' ORDER BY district',
  NULL, 'metrotaipei'
WHERE NOT EXISTS (SELECT 1 FROM public.query_charts WHERE index = 'ev_charging_district_stations' AND city = 'metrotaipei');

-- query_charts: ev_charging_district_points (taipei)
INSERT INTO public.query_charts
  (index, history_config, map_config_ids, map_filter, time_from, time_to, update_freq, update_freq_unit, source, short_desc, long_desc, use_case, links, contributors, created_at, updated_at, query_type, query_chart, query_history, city)
SELECT
  'ev_charging_district_points', NULL, '{}', '{}', 'static', NULL, 1, 'week',
  '環保署／交通部',
  '顯示臺北市各行政區電動車充電樁數量分布',
  '顯示臺北市與新北市各行政區的電動汽車充電樁總數分布。充電樁是每座充電站可同時供電的設備數，相較於充電站數量更能反映實際充電服務量能。資料來自交通部 TDX CityEVCharging API 之 ChargingPoint 資料集，每日更新。',
  '透過本組件可以了解雙北各行政區實際可同時服務電動車的容量分布，辨識熱門區位是否需要擴建樁位以避免排隊與里程焦慮，鼓勵更多市民安心改用電動車，從源頭降低交通部門碳排與都會區空氣污染，加速綠色運輸轉型。',
  '{https://tdx.transportdata.tw/api-service/swagger/basic/b378d320-04a9-4fba-80b8-0df1b96dd5e8#/CityEVCharging/ParkingEV_API_Connector}',
  ARRAY(SELECT user_id FROM public.contributors WHERE user_id = 'TtouTsai'),
  '2026-05-02 16:27:57.829836+00', '2026-05-02 16:27:57.829836+00',
  'two_d',
  'SELECT district AS x_axis, charging_point_count AS data FROM env_ev_charging_district_summary WHERE city_scope = ''taipei'' ORDER BY district',
  NULL, 'taipei'
WHERE NOT EXISTS (SELECT 1 FROM public.query_charts WHERE index = 'ev_charging_district_points' AND city = 'taipei');

-- query_charts: ev_charging_district_points (metrotaipei)
INSERT INTO public.query_charts
  (index, history_config, map_config_ids, map_filter, time_from, time_to, update_freq, update_freq_unit, source, short_desc, long_desc, use_case, links, contributors, created_at, updated_at, query_type, query_chart, query_history, city)
SELECT
  'ev_charging_district_points', NULL, '{}', '{}', 'static', NULL, 1, 'week',
  '環保署／交通部',
  '顯示雙北各行政區電動車充電樁數量分布',
  '顯示臺北市與新北市各行政區的電動汽車充電樁總數分布。充電樁是每座充電站可同時供電的設備數，相較於充電站數量更能反映實際充電服務量能。資料來自交通部 TDX CityEVCharging API 之 ChargingPoint 資料集，每日更新。',
  '透過本組件可以了解雙北各行政區實際可同時服務電動車的容量分布，辨識熱門區位是否需要擴建樁位以避免排隊與里程焦慮，鼓勵更多市民安心改用電動車，從源頭降低交通部門碳排與都會區空氣污染，加速綠色運輸轉型。',
  '{https://tdx.transportdata.tw/api-service/swagger/basic/b378d320-04a9-4fba-80b8-0df1b96dd5e8#/CityEVCharging/ParkingEV_API_Connector}',
  ARRAY(SELECT user_id FROM public.contributors WHERE user_id = 'TtouTsai'),
  '2026-05-02 16:27:57.829836+00', '2026-05-02 16:27:57.829836+00',
  'two_d',
  'SELECT district AS x_axis, charging_point_count AS data FROM env_ev_charging_district_summary WHERE city_scope = ''twin_city'' ORDER BY district',
  NULL, 'metrotaipei'
WHERE NOT EXISTS (SELECT 1 FROM public.query_charts WHERE index = 'ev_charging_district_points' AND city = 'metrotaipei');

-- query_charts: ev_charging_connector_power (taipei)
INSERT INTO public.query_charts
  (index, history_config, map_config_ids, map_filter, time_from, time_to, update_freq, update_freq_unit, source, short_desc, long_desc, use_case, links, contributors, created_at, updated_at, query_type, query_chart, query_history, city)
SELECT
  'ev_charging_connector_power', NULL, '{}', '{}', 'static', NULL, 1, 'week',
  '環保署／交通部',
  '顯示臺北市各行政區充電槍功率級距比例',
  '顯示臺北市與新北市各行政區「充電槍」（連接器）的功率級距分布比例，分為慢充（AC）、中速快充（DC 22-50 kW）、快充（DC 50-150 kW）、急速快充（DC ≥150 kW）四級。資料來自交通部 TDX CityEVCharging API 之 Connector 資料集，每日更新。',
  '透過本組件可以比較雙北各行政區的快充覆蓋率，辨識仍以慢充為主、缺乏高功率充電服務的區域，作為政府引導業者布建快充樁、規劃跨市長程移動快充走廊的參考，協助縮短電動車充電等待時間、提升使用者體驗，進一步加速燃油車汰換與運輸部門減碳進程。',
  '{https://tdx.transportdata.tw/api-service/swagger/basic/b378d320-04a9-4fba-80b8-0df1b96dd5e8#/CityEVCharging/ParkingEV_API_Connector}',
  ARRAY(SELECT user_id FROM public.contributors WHERE user_id = 'TtouTsai'),
  '2026-05-02 16:27:57.829836+00', '2026-05-02 16:27:57.829836+00',
  'three_d',
  'SELECT s.district AS x_axis, CASE s.power_bucket WHEN ''slow_ac'' THEN ''0-22kW'' WHEN ''medium_dc'' THEN ''22-50kW'' WHEN ''fast_dc'' THEN ''50-150kW'' WHEN ''ultra_fast_dc'' THEN ''150kW以上'' END AS y_axis, s.connector_count AS data FROM env_ev_charging_connector_power_district s JOIN (SELECT district, SUM(CASE WHEN power_bucket IN (''medium_dc'',''fast_dc'',''ultra_fast_dc'') THEN connector_count ELSE 0 END)::float / NULLIF(SUM(CASE WHEN power_bucket <> ''unknown'' THEN connector_count ELSE 0 END), 0) AS fast_ratio FROM env_ev_charging_connector_power_district WHERE city_scope = ''taipei'' GROUP BY district) r ON r.district = s.district WHERE s.city_scope = ''taipei'' AND s.power_bucket <> ''unknown'' ORDER BY r.fast_ratio DESC NULLS LAST, s.district, s.power_bucket_order',
  NULL, 'taipei'
WHERE NOT EXISTS (SELECT 1 FROM public.query_charts WHERE index = 'ev_charging_connector_power' AND city = 'taipei');

-- query_charts: ev_charging_connector_power (metrotaipei)
INSERT INTO public.query_charts
  (index, history_config, map_config_ids, map_filter, time_from, time_to, update_freq, update_freq_unit, source, short_desc, long_desc, use_case, links, contributors, created_at, updated_at, query_type, query_chart, query_history, city)
SELECT
  'ev_charging_connector_power', NULL, '{}', '{}', 'static', NULL, 1, 'week',
  '環保署／交通部',
  '顯示雙北各行政區充電槍功率級距比例',
  '顯示臺北市與新北市各行政區「充電槍」（連接器）的功率級距分布比例，分為慢充（AC）、中速快充（DC 22-50 kW）、快充（DC 50-150 kW）、急速快充（DC ≥150 kW）四級。資料來自交通部 TDX CityEVCharging API 之 Connector 資料集，每日更新。',
  '透過本組件可以比較雙北各行政區的快充覆蓋率，辨識仍以慢充為主、缺乏高功率充電服務的區域，作為政府引導業者布建快充樁、規劃跨市長程移動快充走廊的參考，協助縮短電動車充電等待時間、提升使用者體驗，進一步加速燃油車汰換與運輸部門減碳進程。',
  '{https://tdx.transportdata.tw/api-service/swagger/basic/b378d320-04a9-4fba-80b8-0df1b96dd5e8#/CityEVCharging/ParkingEV_API_Connector}',
  ARRAY(SELECT user_id FROM public.contributors WHERE user_id = 'TtouTsai'),
  '2026-05-02 16:27:57.829836+00', '2026-05-02 16:27:57.829836+00',
  'three_d',
  'SELECT s.district AS x_axis, CASE s.power_bucket WHEN ''slow_ac'' THEN ''0-22kW'' WHEN ''medium_dc'' THEN ''22-50kW'' WHEN ''fast_dc'' THEN ''50-150kW'' WHEN ''ultra_fast_dc'' THEN ''150kW以上'' END AS y_axis, s.connector_count AS data FROM env_ev_charging_connector_power_district s JOIN (SELECT district, SUM(CASE WHEN power_bucket IN (''medium_dc'',''fast_dc'',''ultra_fast_dc'') THEN connector_count ELSE 0 END)::float / NULLIF(SUM(CASE WHEN power_bucket <> ''unknown'' THEN connector_count ELSE 0 END), 0) AS fast_ratio FROM env_ev_charging_connector_power_district WHERE city_scope = ''twin_city'' GROUP BY district) r ON r.district = s.district WHERE s.city_scope = ''twin_city'' AND s.power_bucket <> ''unknown'' ORDER BY r.fast_ratio DESC NULLS LAST, s.district, s.power_bucket_order',
  NULL, 'metrotaipei'
WHERE NOT EXISTS (SELECT 1 FROM public.query_charts WHERE index = 'ev_charging_connector_power' AND city = 'metrotaipei');

-- sync sequences after inserts
SELECT pg_catalog.setval('public.components_id_seq',    (SELECT COALESCE(MAX(id), 0) FROM public.components),    true);
SELECT pg_catalog.setval('public.component_maps_id_seq',(SELECT COALESCE(MAX(id), 0) FROM public.component_maps),true);
SELECT pg_catalog.setval('public.contributors_id_seq',  (SELECT COALESCE(MAX(id), 0) FROM public.contributors),  true);
SELECT pg_catalog.setval('public.dashboards_id_seq',    (SELECT COALESCE(MAX(id), 0) FROM public.dashboards),    true);