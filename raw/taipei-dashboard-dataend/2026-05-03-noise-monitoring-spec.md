# 環境噪音監測與分佈

> Source: 本地規格文件 docs/噪音監測與分佈.md
> Collected: 2026-05-03
> Published: 2026-05-03

## 資料

### 資料來源

本組件整合臺北市與新北市兩個縣市的噪音監測站資料，資料類型分為「交通噪音」與「環境噪音」，監測方式分為「人工監測」與「自動監測」。

| 城市               | 來源                                                                                                                                           | 格式                        | 主要欄位                                                     | 用途                               |
| ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- | ------------------------------------------------------------ | ---------------------------------- |
| 臺北市             | 臺北市環保局噪音品質查詢 `https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx`                                                | HTML 表格（需網頁爬取）     | 測站名稱、測站編號、管制區別、月份、日間/晚間/夜間分貝值     | 臺北市測站月份量測值               |
| 新北市             | 新北市環保局噪音監測統計 `https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats?categoryId=6ca80917-078a-4bd6-8a54-f67cb75d8d80`      | PDF 年報（需 PDF 解析）     | 測站名稱、測站編號、管制區別、月份、日/晚/夜分貝值、音量標準 | 新北市測站月份量測值               |
| 新北市（測站地址） | 新北市環保局人工測站 `https://www.epd.ntpc.gov.tw/StaticPage/manual-stations`、自動測站 `https://www.epd.ntpc.gov.tw/StaticPage/auto-stations` | HTML 靜態頁面（需網頁爬取） | 測站名稱、地址                                               | 新北市測站地址，供地理編碼取得座標 |

兩個資料來源皆無公開 API，ETL 需透過網頁爬取（臺北市）或 PDF 解析（新北市）取得資料，並在 Airflow DAG 中每月觸發，更新最新一個月的量測資料。

#### 測站編號命名規則（以新北市為例）

```text
0401020TN003
│││││││││└── 流水號（測站序號）
│││││││└──── 噪音類別（TN = 交通噪音 Traffic Noise / EN = 環境噪音 Environmental Noise）
││└──────── 年份或類別流水
└────────── 行政區代碼
```

#### 管制區別對應噪音標準

| 噪音類別 | 管制區別 | 日間 (dB) | 晚間 (dB) | 夜間 (dB) |
| -------- | -------- | --------- | --------- | --------- |
| 交通噪音 | 二       | 71        | 69        | 63        |
| 交通噪音 | 三       | 74        | 70        | 67        |
| 交通噪音 | 四       | 76        | 75        | 72        |
| 環境噪音 | 一       | 55        | 50        | 45        |
| 環境噪音 | 二       | 55        | 50        | 45        |
| 環境噪音 | 三       | 60        | 55        | 50        |
| 環境噪音 | 四       | 65        | 60        | 55        |
| 環境噪音 | 五       | 75        | 70        | 65        |

### 欄位解讀

#### 量測值

每個測站每月產生三個時段分貝值：

| 欄位                 | 說明                      |
| -------------------- | ------------------------- |
| 日間（`day_db`）     | 白天量測均能音量，單位 dB |
| 晚間（`evening_db`） | 傍晚量測均能音量，單位 dB |
| 夜間（`night_db`）   | 夜間量測均能音量，單位 dB |

量測值含以下特殊標記，ETL 需辨別處理：

| 原始符號 | 意義                  | ETL 處理                                   |
| -------- | --------------------- | ------------------------------------------ |
| `-`      | 當月未量測或資料缺漏  | 存為 `NULL`，設 `quality_flag = 'missing'` |
| `*`      | 量測值超過音量標準    | 存入數值，設 `exceeded_standard = true`    |
| `#`      | 上傳至環境部的測站    | 保留到 `upload_flag` 欄位                  |
| `&`      | 上傳至 SIP 系統的測站 | 保留到 `upload_flag` 欄位                  |

#### 季別換算

量測資料為月份粒度，前端折線圖以季為單位，ETL 需在聚合表儲存季別欄位：

| 季別 | 月份                |
| ---- | ------------------- |
| Q1   | 1 月、2 月、3 月    |
| Q2   | 4 月、5 月、6 月    |
| Q3   | 7 月、8 月、9 月    |
| Q4   | 10 月、11 月、12 月 |

## 前端

### 前端儀表板

前端儀表板支援 `臺北市` 與 `雙北` 城市範圍切換，以及 `交通噪音` 與 `環境噪音` 監測類別切換。

| 組件 index             | query type  | chart type                | 說明                                                    |
| ---------------------- | ----------- | ------------------------- | ------------------------------------------------------- |
| `env_noise_trend`      | `time`      | `TimelineSeparateChart`   | 3 條折線：日間／晚間／夜間均能音量季度趨勢              |
| `env_noise_district`   | `two_d`     | `BarChart`                | 行政區日間均能音量，最新一季，由高到低排列              |
| `env_noise_exceed`     | `two_d`     | `DistrictChart`, `BarChart` | 行政區超標站數，最新一季，可切換地圖或長條圖顯示      |
| `env_noise_monitoring` | `map_legend` | `MapLegend`              | 測站點位地圖，顏色依日間均能音量分 5 級                 |

每個組件均支援 `臺北市`（`city = 'taipei'`）與 `雙北`（`city = 'metrotaipei'`）切換。折線圖 y_axis 固定為「日間」、「晚間」、「夜間」三條線，x 軸為各季第一天的 timestamp。

### 前端地圖圖層

地圖以噪音測站為點位，點的顏色依最新一季日間均能音量深淺顯示。

**顏色分級**（依日間均能音量）：

| 等級 | 分貝範圍 | 顏色說明 |
| ---- | -------- | -------- |
| 低   | < 55 dB  | 綠色     |
| 中低 | 55–65 dB | 黃綠色   |
| 中   | 65–70 dB | 黃色     |
| 中高 | 70–75 dB | 橙色     |
| 高   | ≥ 75 dB  | 紅色     |

切換 `臺北市` 時只顯示臺北市測站；切換 `雙北` 時同時顯示臺北市與新北市測站。

點擊測站後，彈跳資訊顯示：測站名稱、城市與行政區、測站編號、噪音類別、監測方式、管制區別、管制標準（日/晚/夜）、最新量測月份、最新量測值（日/晚/夜）、是否超標、歷年超標次數、資料時間、資料來源。

地圖資料使用 WGS84/EPSG:4326 點位。若測站座標缺漏，該站不得進入地圖圖層，但仍可在行政區統計中保留（以行政區中心點代替）。

## 後端

後端需提供前端儀表板與地圖圖層兩類資料：季別聚合折線圖資料、行政區彙整資料與測站點位資料。

### 噪音季度趨勢（`env_noise_trend`）

**臺北市（`city = 'taipei'`）**

```sql
SELECT
  MAKE_DATE(year, (quarter-1)*3+1, 1)::timestamp AS x_axis,
  CASE period WHEN 'day' THEN '日間' WHEN 'evening' THEN '晚間' ELSE '夜間' END AS y_axis,
  ROUND(AVG(avg_db)::numeric, 1) AS data
FROM env_noise_quarterly_stats_tpe
WHERE year >= EXTRACT(YEAR FROM NOW())::int - 2
GROUP BY year, quarter, period
ORDER BY year, quarter, period
```

**雙北（`city = 'metrotaipei'`）**：同上但以 UNION ALL 合併 `env_noise_quarterly_stats_new_tpe`。

### 行政區噪音分佈（`env_noise_district`）

**臺北市**：

```sql
SELECT district AS x_axis, ROUND(AVG(avg_day_db)::numeric, 1) AS data
FROM env_noise_district_summary_tpe
WHERE (year, quarter) = (SELECT year, quarter FROM env_noise_district_summary_tpe ORDER BY year DESC, quarter DESC LIMIT 1)
GROUP BY district ORDER BY data DESC
```

**雙北**：UNION ALL 合併 `env_noise_district_summary_new_tpe`，最新季度取兩表合集的最大值。

### 行政區噪音超標次數（`env_noise_exceed`）

```sql
SELECT district AS x_axis, exceed_count::int AS data
FROM env_noise_district_summary_tpe
WHERE (year, quarter) = (...)
ORDER BY data DESC
```

### 環境噪音監測與分佈（`env_noise_monitoring`）

`query_type = 'map_legend'`，僅回傳圖例項目，實際測站點位由前端讀取靜態 GeoJSON 檔。

```sql
SELECT unnest(array['< 55 dB','55-65 dB','65-70 dB','70-75 dB','> 75 dB']) AS name,
       'circle' AS type
```

GeoJSON 靜態檔位於 `Taipei-City-Dashboard-FE/public/mapData/`：
- 臺北市：`env_noise_monitoring.geojson`（23 站）
- 雙北：`env_noise_monitoring_metro.geojson`（49 站）

`component_maps` 對應：臺北市用 `map_config_ids = '{200}'`，雙北用 `'{202}'`。

## 資料端邏輯

### 資料表設計

- **`env_noise_stations`** — 測站主表（含 PostGIS 幾何）
- **`env_noise_monthly_measurements`** — 月份量測明細表
- **`env_noise_quarterly_stats_tpe`** — 臺北市季別聚合表
- **`env_noise_quarterly_stats_new_tpe`** — 新北市季別聚合表（結構相同）
- **`env_noise_district_summary_tpe`** — 臺北市行政區彙整表
- **`env_noise_district_summary_new_tpe`** — 新北市行政區彙整表（結構相同）

雙北查詢以 UNION ALL 合併兩市城市表，無 `city_scope` 欄位。

### Airflow DAG

- **D990101** — 臺北市 HTML 爬取（每月 16 日）
- **D990102** — 新北市 PDF 解析（每年 1 月 1 日）
- **D990103** — 季別聚合（D990101/D990102 成功後，每月 16 日）

## AI Chat 的結合方法

AI Chat 透過後端 tool calling 整合本組件，建議提供以下 tools（`set_noise_view` 待前端支援視圖控制後再實作）：

| Tool                         | 參數                                                                 | 回傳                                   |
| ---------------------------- | -------------------------------------------------------------------- | -------------------------------------- |
| `get_noise_summary`          | `city_scope`, `noise_category`, `year`（選填）                       | 測站數、平均分貝、超標率、最新資料季度 |
| `get_noise_quarterly_trend`  | `city_scope`, `noise_category`, `year_range`（選填 int[]）           | 各季日間/晚間/夜間均能音量             |
| `get_noise_district_ranking` | `city_scope`, `noise_category`, `year`, `quarter`                    | 行政區均能音量與超標率排名             |
| `get_noise_station_detail`   | `station_id`                                                         | 測站基本資訊、歷月量測值、超標記錄     |

`city_scope` 只允許 `taipei` 或 `metrotaipei`。`noise_category` 只允許 `traffic` 或 `environmental`。

## 部署順序

### 首次部署

```bash
# Step 1  建立 dashboard DB 資料表
docker cp db-sample-data/noise-monitoring-tables.sql postgres-data:/tmp/noise-monitoring-tables.sql
docker exec postgres-data psql -U postgres -d dashboard -f /tmp/noise-monitoring-tables.sql

# Step 2  套用 dashboardmanager 元件與 Dashboard 設定
docker cp db-sample-data/noise-monitoring-component.sql postgres-manager:/tmp/noise-monitoring-component.sql
docker exec postgres-manager psql -U postgres -d dashboardmanager -f /tmp/noise-monitoring-component.sql

docker cp db-sample-data/noise-monitoring-dashboard.sql postgres-manager:/tmp/noise-monitoring-dashboard.sql
docker exec postgres-manager psql -U postgres -d dashboardmanager -f /tmp/noise-monitoring-dashboard.sql
```

### 執行 ETL

```bash
# Step 3  臺北市 ETL（約 1 分鐘）
docker exec develop-airflow-webserver-1 airflow dags unpause proj_city_dashboard_D990101
docker exec develop-airflow-webserver-1 airflow dags trigger proj_city_dashboard_D990101

# Step 4  新北市 ETL（約 3 分鐘，可與 Step 3 同時觸發）
docker exec develop-airflow-webserver-1 airflow dags unpause proj_city_dashboard_D990102
docker exec develop-airflow-webserver-1 airflow dags trigger proj_city_dashboard_D990102

# Step 5  聚合 DAG（Step 3、4 的 etl task 均 success 後）
docker exec develop-airflow-webserver-1 airflow dags unpause proj_city_dashboard_D990103
docker exec develop-airflow-webserver-1 airflow dags trigger proj_city_dashboard_D990103
```

## 驗證清單

```sql
-- 臺北市測站筆數（預期 23）
SELECT COUNT(*) FROM env_noise_stations WHERE city='臺北市';
-- 新北市測站筆數（預期 27）
SELECT COUNT(*) FROM env_noise_stations WHERE city='新北市';
-- 臺北市季度統計（預期 ~360 筆）
SELECT COUNT(*) FROM env_noise_quarterly_stats_tpe;
-- query_charts 筆數（預期 8 筆）
SELECT index, city FROM query_charts WHERE index LIKE 'env_noise%' ORDER BY index, city;
```
