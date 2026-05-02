BEGIN;

INSERT INTO components (index, name) VALUES
  ('river_high_risk_sites',   '河川水質高風險測站排名')
ON CONFLICT (index) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO components (index, name) VALUES
  ('river_risk_distribution', '河川水質風險等級分布')
ON CONFLICT (index) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO component_charts (index, color, types, unit) VALUES
  ('river_high_risk_sites',
   ARRAY['#67baca']::varchar[],
   ARRAY['BarChart']::varchar[],
   'RPI')
ON CONFLICT (index) DO UPDATE SET
  color = EXCLUDED.color,
  types = EXCLUDED.types,
  unit  = EXCLUDED.unit;

INSERT INTO component_charts (index, color, types, unit) VALUES
  ('river_risk_distribution',
   ARRAY['#67baca','#f8cf58','#f5ad4a','#ed6a45']::varchar[],
   ARRAY['DonutChart']::varchar[],
   '站')
ON CONFLICT (index) DO UPDATE SET
  color = EXCLUDED.color,
  types = EXCLUDED.types,
  unit  = EXCLUDED.unit;

-- component_maps has no unique constraint on `index`, and query_charts.map_config_ids
-- references the surrogate ids we are about to mint, so wipe-and-rebuild is the
-- only path to idempotent re-runs.
DELETE FROM component_maps WHERE index IN (
  'env_river_sites_taipei',
  'env_river_sites_metrotaipei',
  'env_river_segments_taipei',
  'env_river_segments_metrotaipei'
);

DELETE FROM query_charts WHERE index IN (
  'river_high_risk_sites',
  'river_risk_distribution'
);

DO $$
DECLARE
  sites_tpe_id  integer;
  sites_mtp_id  integer;
  segs_tpe_id   integer;
  segs_mtp_id   integer;
  high_idx      text := 'river_high_risk_sites';
  dist_idx      text := 'river_risk_distribution';
  src_label     text := '環境部水質監測 GIS（含其他單位河川測站）';
  high_short    text := '合併環境部官方與其他單位河川測站，依最新月份 RPI 由高至低排序，呈現雙北高風險測站。';
  high_long     text := '本圖以 RPI（河川污染指數）追蹤雙北河川水質風險，列出最新月份 RPI 數值最高的前 10 座測站。資料來源含兩類：(1) 環境部官方測站直接取用 WQ_Index；(2) 其他單位（地方環保局等）測站則以 DO/BOD5/SS/NH3-N 四項指標分數平均計算 RPI。缺值或子指標不全者不入排名。資料月更新，協助識別需要優先關注的測站。';
  high_use      text := '可用於聚焦近期水質惡化熱點：將排名與測站位置、所在河川與行政區交叉比對，協助環保稽查、河川治理與民眾風險溝通；亦可搭配風險等級分布圖檢視整體變化。RPI 計算方式（直接取用 vs. 重新計算）會在 popup 標註。';
  dist_short    text := '依風險等級統計雙北河川測站數（含其他單位測站），呈現整體水質結構。';
  dist_long     text := '本圖統計最新月份各風險等級（未受污染／輕度／中度／嚴重）的測站數，反映雙北河川整體水質結構。包含環境部官方測站（取自 WQ_Index_Dec）以及由本平台從 DO/BOD5/SS/NH3-N 四項指標重新計算 RPI 的其他單位測站。無檢測資料或子指標不全之測站不入分母。';
  dist_use      text := '配合排名圖可一覽水質結構：嚴重／中度污染比例變化可作為政策成效追蹤指標，並協助比較臺北市單市與雙北範圍下的差異。';
  links         text[] := ARRAY['https://wq.moenv.gov.tw/EWQP_GIS/dataFile/AJAX_Main.aspx?Type=Get_point_WQStation_River','https://wq.moenv.gov.tw/EWQP_GIS/dataFile/AJAX_Main.aspx?Type=Get_point_WQStation_Ext_River','https://gic.wra.gov.tw/gis/gic/API/Google/DownLoad.aspx?fname=RIVER&filetype=SHP'];
  contributors  text[] := ARRAY['doit','ntpc'];

  paint_circle  json := $paint$
    {
      "circle-color": ["match", ["get", "risk_level"],
        "unpolluted", "#67baca",
        "mild",       "#f8cf58",
        "moderate",   "#f5ad4a",
        "severe",     "#ed6a45",
        "#999999"
      ],
      "circle-radius": 6,
      "circle-stroke-color": "#ffffff",
      "circle-stroke-width": 1
    }
  $paint$::json;

  paint_line    json := $paint$
    {
      "line-color": [
        "interpolate", ["linear"],
        ["/", ["+", ["to-number", ["get", "upstream_rpi"]], ["to-number", ["get", "downstream_rpi"]]], 2],
        1, "#67baca",
        3.5, "#f8cf58",
        6, "#f5ad4a",
        10, "#ed6a45"
      ],
      "line-width": 4
    }
  $paint$::json;

  prop_site     json := $prop$
    [
      {"key": "site_name",          "name": "測站"},
      {"key": "rpi_value",          "name": "RPI"},
      {"key": "risk_level",         "name": "風險等級"},
      {"key": "rpi_method",         "name": "RPI 計算方式"},
      {"key": "sample_month",       "name": "採樣月份"},
      {"key": "district",           "name": "行政區"},
      {"key": "river",              "name": "河川"},
      {"key": "wq_std_grade",       "name": "水體分類等級"},
      {"key": "source_label",       "name": "資料來源"},
      {"key": "do_value",           "name": "DO 溶氧 (mg/L)"},
      {"key": "do_method",          "name": "DO 量測方法"},
      {"key": "bod5_value",         "name": "BOD5 (mg/L)"},
      {"key": "ss_value",           "name": "SS 懸浮固體 (mg/L)"},
      {"key": "nh3n_value",         "name": "NH3-N 氨氮 (mg/L)"},
      {"key": "conductivity_value", "name": "導電度 (μS/cm)"}
    ]
  $prop$::json;

  prop_seg      json := $prop$
    [
      {"key": "upstream_site_name",   "name": "上游測站"},
      {"key": "upstream_rpi",         "name": "上游 RPI"},
      {"key": "downstream_site_name", "name": "下游測站"},
      {"key": "downstream_rpi",       "name": "下游 RPI"},
      {"key": "geometry_source",      "name": "幾何來源"},
      {"key": "sample_month",         "name": "採樣月份"}
    ]
  $prop$::json;
BEGIN
  INSERT INTO component_maps (index, title, type, source, paint, property)
    VALUES ('env_river_sites_taipei',     '臺北市河川測站', 'circle', 'geojson', paint_circle, prop_site)
    RETURNING id INTO sites_tpe_id;

  INSERT INTO component_maps (index, title, type, source, paint, property)
    VALUES ('env_river_sites_metrotaipei', '雙北河川測站',  'circle', 'geojson', paint_circle, prop_site)
    RETURNING id INTO sites_mtp_id;

  INSERT INTO component_maps (index, title, type, source, paint, property)
    VALUES ('env_river_segments_taipei',   '臺北市河川 RPI 漸層段', 'line', 'geojson', paint_line, prop_seg)
    RETURNING id INTO segs_tpe_id;

  INSERT INTO component_maps (index, title, type, source, paint, property)
    VALUES ('env_river_segments_metrotaipei', '雙北河川 RPI 漸層段', 'line', 'geojson', paint_line, prop_seg)
    RETURNING id INTO segs_mtp_id;

  INSERT INTO query_charts (
    index, history_config, map_config_ids, map_filter,
    time_from, time_to, update_freq, update_freq_unit,
    source, short_desc, long_desc, use_case, links, contributors,
    created_at, updated_at, query_type, query_chart, query_history, city
  ) VALUES
  (
    high_idx, NULL, NULL, '{}'::json,
    'static', NULL, 1, 'day',
    src_label, high_short, high_long, high_use, links, contributors,
    now(), now(), 'two_d',
    $q$SELECT site_name AS x_axis, rpi_value AS data FROM env_river_site_rpi_latest WHERE city = '臺北市' AND rpi_flag = 'complete' ORDER BY rpi_value DESC LIMIT 10$q$,
    NULL, 'taipei'
  ),
  (
    high_idx, NULL, NULL, '{}'::json,
    'static', NULL, 1, 'day',
    src_label, high_short, high_long, high_use, links, contributors,
    now(), now(), 'two_d',
    $q$SELECT site_name AS x_axis, rpi_value AS data FROM env_river_site_rpi_latest WHERE city IN ('臺北市','新北市') AND rpi_flag = 'complete' ORDER BY rpi_value DESC LIMIT 10$q$,
    NULL, 'metrotaipei'
  ),
  (
    dist_idx, NULL, ARRAY[sites_tpe_id, segs_tpe_id]::integer[], '{}'::json,
    'static', NULL, 1, 'day',
    src_label, dist_short, dist_long, dist_use, links, contributors,
    now(), now(), 'two_d',
    $q$SELECT risk_level AS x_axis, COUNT(*)::int AS data FROM env_river_site_rpi_latest WHERE city = '臺北市' AND rpi_flag = 'complete' GROUP BY risk_level, risk_level_order ORDER BY risk_level_order$q$,
    NULL, 'taipei'
  ),
  (
    dist_idx, NULL, ARRAY[sites_mtp_id, segs_mtp_id]::integer[], '{}'::json,
    'static', NULL, 1, 'day',
    src_label, dist_short, dist_long, dist_use, links, contributors,
    now(), now(), 'two_d',
    $q$SELECT risk_level AS x_axis, COUNT(*)::int AS data FROM env_river_site_rpi_latest WHERE city IN ('臺北市','新北市') AND rpi_flag = 'complete' GROUP BY risk_level, risk_level_order ORDER BY risk_level_order$q$,
    NULL, 'metrotaipei'
  );
END $$;

COMMIT;
