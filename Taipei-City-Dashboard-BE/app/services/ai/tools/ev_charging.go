package tools

import (
	"TaipeiCityDashboardBE/app/models"
	"context"
	"encoding/json"
	"fmt"
	"strings"
	"time"

	"github.com/tmc/langchaingo/llms"
)

const (
	ToolGetEvChargingSummary        = "get_ev_charging_summary"
	ToolGetEvChargingDistrictCounts = "get_ev_charging_district_counts"
	ToolGetEvChargingPowerMix       = "get_ev_charging_power_mix"
	ToolGetEvChargingStationDetail  = "get_ev_charging_station_detail"
	ToolGetEvFastChargingStations   = "get_ev_fast_charging_stations"
)

func init() {
	Register(ToolGetEvChargingSummary, GetEvChargingSummary)
	Register(ToolGetEvChargingDistrictCounts, GetEvChargingDistrictCounts)
	Register(ToolGetEvChargingPowerMix, GetEvChargingPowerMix)
	Register(ToolGetEvChargingStationDetail, GetEvChargingStationDetail)
	Register(ToolGetEvFastChargingStations, GetEvFastChargingStations)

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetEvChargingSummary,
			Description: "查詢臺北市或雙北電動車充電基礎建設整體概況：總站數、樁數、槍數、前五名行政區、快充與慢充槍比例。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"city_scope": map[string]interface{}{
						"type":        "string",
						"description": "城市範圍。臺北市使用 taipei，雙北（臺北市＋新北市）使用 twin_city。",
						"enum":        []string{"taipei", "twin_city"},
					},
				},
				"required":             []string{"city_scope"},
				"additionalProperties": false,
			},
		},
	})

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetEvChargingDistrictCounts,
			Description: "查詢臺北市或雙北各行政區充電站、充電樁、充電槍數量排名，用於比較行政區間的供給差距。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"city_scope": map[string]interface{}{
						"type":        "string",
						"description": "城市範圍。taipei 或 twin_city。",
						"enum":        []string{"taipei", "twin_city"},
					},
				},
				"required":             []string{"city_scope"},
				"additionalProperties": false,
			},
		},
	})

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetEvChargingPowerMix,
			Description: "查詢臺北市或雙北充電槍的功率級距分布（慢充 AC / 中速 DC / 快充 DC / 超快充 DC）。可指定行政區查詢單區，或省略查全市。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"city_scope": map[string]interface{}{
						"type":        "string",
						"description": "城市範圍。taipei 或 twin_city。",
						"enum":        []string{"taipei", "twin_city"},
					},
					"district": map[string]interface{}{
						"type":        "string",
						"description": "行政區名稱（含「區」字，例如「信義區」）。省略則回傳全市加總。",
					},
				},
				"required":             []string{"city_scope"},
				"additionalProperties": false,
			},
		},
	})

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetEvChargingStationDetail,
			Description: "依站名關鍵字搜尋充電站，回傳詳細資訊：行政區、業者、車位數、充電樁數、槍數、各功率槍數明細（含最大功率 kW）、服務時間、充電費率。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"station_name": map[string]interface{}{
						"type":        "string",
						"description": "充電站名稱關鍵字，支援部分比對（例如「愛買」、「大安森林」）。",
					},
				},
				"required":             []string{"station_name"},
				"additionalProperties": false,
			},
		},
	})

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetEvFastChargingStations,
			Description: "查詢臺北市或雙北提供快充（DC 50kW 以上）的充電站清單，依最大功率排序。可篩選行政區，或只看超快充（≥150kW）。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"city_scope": map[string]interface{}{
						"type":        "string",
						"description": "城市範圍。taipei 或 twin_city。",
						"enum":        []string{"taipei", "twin_city"},
					},
					"district": map[string]interface{}{
						"type":        "string",
						"description": "行政區名稱（含「區」字）。省略則查全市。",
					},
					"ultra_only": map[string]interface{}{
						"type":        "boolean",
						"description": "true 時只回傳超快充（≥150kW）站；false 或省略包含所有快充（≥50kW）。",
					},
				},
				"required":             []string{"city_scope"},
				"additionalProperties": false,
			},
		},
	})

	RegisterContext("雙北電動車充電站整體概況、行政區分布、功率級距比例、單站詳情（含最大功率 kW）、快充站清單")
}

// ── shared helpers ────────────────────────────────────────────────────────────

var evPowerBucketLabel = map[string]string{
	"slow_ac":       "慢充 AC（<22kW）",
	"medium_dc":     "中速 DC（22-50kW）",
	"fast_dc":       "快充 DC（50-150kW）",
	"ultra_fast_dc": "超快充 DC（≥150kW）",
	"unknown":       "未知",
}

var evPowerBucketOrder = []string{"slow_ac", "medium_dc", "fast_dc", "ultra_fast_dc", "unknown"}

func validateEvCityScope(s string) error {
	if s != "taipei" && s != "twin_city" {
		return fmt.Errorf("city_scope 必須是 'taipei' 或 'twin_city'")
	}
	return nil
}

func evCityFilter(cityScope string) string {
	if cityScope == "twin_city" {
		return "city IN ('臺北市','新北市')"
	}
	return "city = '臺北市'"
}

func evCityName(cityScope string) string {
	if cityScope == "twin_city" {
		return "雙北"
	}
	return "臺北市"
}

// powerDetailString formats the power_detail jsonb array for human display.
// Input example: [{"kw":7.0,"count":4},{"kw":250.0,"count":6}]
// Output example: "7kW×4、250kW×6"
func powerDetailString(raw []byte) string {
	if len(raw) == 0 {
		return ""
	}
	var items []struct {
		KW    float64 `json:"kw"`
		Count int     `json:"count"`
	}
	if err := json.Unmarshal(raw, &items); err != nil || len(items) == 0 {
		return ""
	}
	parts := make([]string, 0, len(items))
	for _, it := range items {
		if it.KW == float64(int(it.KW)) {
			parts = append(parts, fmt.Sprintf("%dkW×%d", int(it.KW), it.Count))
		} else {
			parts = append(parts, fmt.Sprintf("%.1fkW×%d", it.KW, it.Count))
		}
	}
	return strings.Join(parts, "、")
}

// ── get_ev_charging_summary ───────────────────────────────────────────────────

type evCityScopeArgs struct {
	CityScope string `json:"city_scope"`
}

func GetEvChargingSummary(ctx context.Context, args string) (string, error) {
	var params evCityScopeArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if err := validateEvCityScope(params.CityScope); err != nil {
		return "", err
	}

	var total struct {
		Stations   int       `gorm:"column:stations"`
		Points     int       `gorm:"column:points"`
		Connectors int       `gorm:"column:connectors"`
		DataTime   time.Time `gorm:"column:data_time"`
	}
	models.DBDashboard.Raw(`
		SELECT SUM(station_count)::int AS stations,
		       SUM(charging_point_count)::int AS points,
		       SUM(connector_count)::int AS connectors,
		       MAX(data_time) AS data_time
		FROM env_ev_charging_district_summary WHERE city_scope = ?`, params.CityScope,
	).Scan(&total)

	var topDistricts []struct {
		District string `gorm:"column:district"`
		Stations int    `gorm:"column:station_count"`
		Points   int    `gorm:"column:charging_point_count"`
	}
	models.DBDashboard.Raw(`
		SELECT district, station_count, charging_point_count
		FROM env_ev_charging_district_summary
		WHERE city_scope = ? ORDER BY station_count DESC LIMIT 5`, params.CityScope,
	).Scan(&topDistricts)

	var powerRows []struct {
		PowerBucket string `gorm:"column:power_bucket"`
		Total       int    `gorm:"column:total"`
	}
	models.DBDashboard.Raw(`
		SELECT power_bucket, SUM(connector_count)::int AS total
		FROM env_ev_charging_connector_power_district
		WHERE city_scope = ?
		GROUP BY power_bucket, power_bucket_order
		ORDER BY power_bucket_order`, params.CityScope,
	).Scan(&powerRows)

	var sb strings.Builder
	fmt.Fprintf(&sb, "【%s 電動車充電基礎建設概況】\n", evCityName(params.CityScope))
	fmt.Fprintf(&sb, "資料時間：%s\n\n", total.DataTime.Format("2006-01-02"))
	fmt.Fprintf(&sb, "充電站：%d 站\n充電樁：%d 樁\n充電槍：%d 槍\n", total.Stations, total.Points, total.Connectors)

	if len(topDistricts) > 0 {
		sb.WriteString("\n充電站最多行政區（前五名）：\n")
		for i, d := range topDistricts {
			fmt.Fprintf(&sb, "  %d. %-6s %d 站（%d 樁）\n", i+1, d.District, d.Stations, d.Points)
		}
	}

	if len(powerRows) > 0 {
		sb.WriteString("\n充電槍功率分布：\n")
		for _, r := range powerRows {
			if r.Total == 0 {
				continue
			}
			pct := 0.0
			if total.Connectors > 0 {
				pct = float64(r.Total) / float64(total.Connectors) * 100
			}
			fmt.Fprintf(&sb, "  %-22s %4d 槍（%4.1f%%）\n", evPowerBucketLabel[r.PowerBucket], r.Total, pct)
		}
	}

	return sb.String(), nil
}

// ── get_ev_charging_district_counts ──────────────────────────────────────────

func GetEvChargingDistrictCounts(ctx context.Context, args string) (string, error) {
	var params evCityScopeArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if err := validateEvCityScope(params.CityScope); err != nil {
		return "", err
	}

	var rows []struct {
		District   string `gorm:"column:district"`
		Stations   int    `gorm:"column:station_count"`
		Points     int    `gorm:"column:charging_point_count"`
		Connectors int    `gorm:"column:connector_count"`
	}
	err := models.DBDashboard.Raw(`
		SELECT district, station_count, charging_point_count, connector_count
		FROM env_ev_charging_district_summary
		WHERE city_scope = ? ORDER BY station_count DESC`, params.CityScope,
	).Scan(&rows).Error
	if err != nil || len(rows) == 0 {
		return "", fmt.Errorf("查無資料（city_scope=%s）", params.CityScope)
	}

	var sb strings.Builder
	fmt.Fprintf(&sb, "【%s 各行政區充電設施數量】\n", evCityName(params.CityScope))
	fmt.Fprintf(&sb, "%-8s %5s %5s %5s\n", "行政區", "站", "樁", "槍")
	sb.WriteString(strings.Repeat("-", 30) + "\n")
	for _, r := range rows {
		fmt.Fprintf(&sb, "%-8s %5d %5d %5d\n", r.District, r.Stations, r.Points, r.Connectors)
	}
	return sb.String(), nil
}

// ── get_ev_charging_power_mix ─────────────────────────────────────────────────

type evPowerMixArgs struct {
	CityScope string `json:"city_scope"`
	District  string `json:"district"`
}

func GetEvChargingPowerMix(ctx context.Context, args string) (string, error) {
	var params evPowerMixArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if err := validateEvCityScope(params.CityScope); err != nil {
		return "", err
	}

	var rows []struct {
		District         string  `gorm:"column:district"`
		PowerBucket      string  `gorm:"column:power_bucket"`
		PowerBucketOrder int     `gorm:"column:power_bucket_order"`
		ConnectorCount   int     `gorm:"column:connector_count"`
		ConnectorRatio   float64 `gorm:"column:connector_ratio"`
	}
	q := models.DBDashboard.Table("env_ev_charging_connector_power_district").
		Where("city_scope = ?", params.CityScope)
	if params.District != "" {
		q = q.Where("district = ?", params.District)
	}
	err := q.Order("district, power_bucket_order").Find(&rows).Error
	if err != nil || len(rows) == 0 {
		return "", fmt.Errorf("查無資料")
	}

	type distPower struct {
		counts map[string]int
		ratios map[string]float64
		total  int
	}
	distOrder := []string{}
	distMap := map[string]*distPower{}
	for _, r := range rows {
		if _, ok := distMap[r.District]; !ok {
			distMap[r.District] = &distPower{
				counts: map[string]int{},
				ratios: map[string]float64{},
			}
			distOrder = append(distOrder, r.District)
		}
		distMap[r.District].counts[r.PowerBucket] += r.ConnectorCount
		distMap[r.District].ratios[r.PowerBucket] = r.ConnectorRatio
		distMap[r.District].total += r.ConnectorCount
	}

	var sb strings.Builder
	if params.District != "" {
		fmt.Fprintf(&sb, "【%s %s 充電槍功率分布】\n", evCityName(params.CityScope), params.District)
	} else {
		fmt.Fprintf(&sb, "【%s 各行政區充電槍功率分布】\n", evCityName(params.CityScope))
	}

	for _, dist := range distOrder {
		d := distMap[dist]
		fmt.Fprintf(&sb, "\n%s（共 %d 槍）\n", dist, d.total)
		for _, b := range evPowerBucketOrder {
			cnt := d.counts[b]
			if cnt == 0 {
				continue
			}
			pct := d.ratios[b] * 100
			fmt.Fprintf(&sb, "  %-22s %4d 槍（%4.1f%%）\n", evPowerBucketLabel[b], cnt, pct)
		}
	}
	return strings.TrimRight(sb.String(), "\n"), nil
}

// ── get_ev_charging_station_detail ────────────────────────────────────────────

type evStationArgs struct {
	StationName string `json:"station_name"`
}

func GetEvChargingStationDetail(ctx context.Context, args string) (string, error) {
	var params evStationArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if params.StationName == "" {
		return "", fmt.Errorf("station_name 不得為空")
	}

	var rows []struct {
		StationName        string    `gorm:"column:station_name"`
		City               string    `gorm:"column:city"`
		District           string    `gorm:"column:district"`
		Address            string    `gorm:"column:address"`
		OperatorID         string    `gorm:"column:operator_id"`
		Spaces             *int      `gorm:"column:spaces"`
		ChargingPointCount int       `gorm:"column:charging_point_count"`
		ConnectorCount     int       `gorm:"column:connector_count"`
		MaxPowerKW         *float64  `gorm:"column:max_power_kw"`
		MaxPowerBucket     string    `gorm:"column:max_power_bucket"`
		PowerDetail        []byte    `gorm:"column:power_detail"`
		ServiceTime        string    `gorm:"column:service_time"`
		ParkingRate        string    `gorm:"column:parking_rate"`
		ChargingRate       string    `gorm:"column:charging_rate"`
		DataTime           time.Time `gorm:"column:data_time"`
	}
	err := models.DBDashboard.Raw(`
		SELECT station_name, city, district, address, operator_id, spaces,
		       charging_point_count, connector_count,
		       max_power_kw, max_power_bucket, power_detail,
		       service_time, parking_rate, charging_rate, data_time
		FROM env_ev_charging_stations
		WHERE station_name ILIKE ?
		ORDER BY station_name LIMIT 5`, "%"+params.StationName+"%",
	).Scan(&rows).Error
	if err != nil {
		return "", fmt.Errorf("查詢失敗: %v", err)
	}
	if len(rows) == 0 {
		return fmt.Sprintf("找不到站名包含「%s」的充電站。", params.StationName), nil
	}

	if len(rows) > 1 {
		var sb strings.Builder
		fmt.Fprintf(&sb, "找到 %d 個符合「%s」的充電站：\n\n", len(rows), params.StationName)
		for i, r := range rows {
			maxPwr := ""
			if r.MaxPowerKW != nil {
				maxPwr = fmt.Sprintf("，最高 %.0fkW", *r.MaxPowerKW)
			}
			fmt.Fprintf(&sb, "%d. %s（%s %s）— %d 樁 / %d 槍%s\n",
				i+1, r.StationName, r.City, r.District,
				r.ChargingPointCount, r.ConnectorCount, maxPwr)
		}
		sb.WriteString("\n請提供更精確的站名以查看詳細資訊。")
		return sb.String(), nil
	}

	r := rows[0]
	var sb strings.Builder
	fmt.Fprintf(&sb, "【充電站詳情：%s】\n", r.StationName)
	fmt.Fprintf(&sb, "城市：%s | 行政區：%s\n", r.City, r.District)
	if r.Address != "" {
		fmt.Fprintf(&sb, "地址：%s\n", r.Address)
	}
	fmt.Fprintf(&sb, "營運業者：%s\n", r.OperatorID)
	if r.Spaces != nil && *r.Spaces > 0 {
		fmt.Fprintf(&sb, "充電車位：%d 位\n", *r.Spaces)
	}
	fmt.Fprintf(&sb, "充電樁：%d 樁 | 充電槍：%d 槍\n", r.ChargingPointCount, r.ConnectorCount)

	if r.MaxPowerKW != nil {
		maxBucketLabel := evPowerBucketLabel[r.MaxPowerBucket]
		fmt.Fprintf(&sb, "最大功率：%.0f kW（%s）\n", *r.MaxPowerKW, maxBucketLabel)
	}
	if detail := powerDetailString(r.PowerDetail); detail != "" {
		fmt.Fprintf(&sb, "槍功率明細：%s\n", detail)
	}

	if r.ServiceTime != "" {
		fmt.Fprintf(&sb, "服務時間：%s\n", r.ServiceTime)
	}
	if r.ParkingRate != "" {
		fmt.Fprintf(&sb, "停車費率：%s\n", r.ParkingRate)
	}
	if r.ChargingRate != "" {
		fmt.Fprintf(&sb, "充電費率：%s\n", r.ChargingRate)
	}
	fmt.Fprintf(&sb, "資料時間：%s | 來源：TDX CityEVCharging", r.DataTime.Format("2006-01-02"))
	return sb.String(), nil
}

// ── get_ev_fast_charging_stations ────────────────────────────────────────────

type evFastChargingArgs struct {
	CityScope  string `json:"city_scope"`
	District   string `json:"district"`
	UltraOnly  bool   `json:"ultra_only"`
}

func GetEvFastChargingStations(ctx context.Context, args string) (string, error) {
	var params evFastChargingArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if err := validateEvCityScope(params.CityScope); err != nil {
		return "", err
	}

	cityFilter := evCityFilter(params.CityScope)
	bucketFilter := "max_power_bucket IN ('fast_dc','ultra_fast_dc')"
	if params.UltraOnly {
		bucketFilter = "max_power_bucket = 'ultra_fast_dc'"
	}

	conditions := []string{cityFilter, bucketFilter}
	queryArgs := []interface{}{}
	if params.District != "" {
		conditions = append(conditions, "district = ?")
		queryArgs = append(queryArgs, params.District)
	}
	where := strings.Join(conditions, " AND ")

	var rows []struct {
		StationName    string   `gorm:"column:station_name"`
		City           string   `gorm:"column:city"`
		District       string   `gorm:"column:district"`
		ConnectorCount int      `gorm:"column:connector_count"`
		MaxPowerKW     float64  `gorm:"column:max_power_kw"`
		MaxPowerBucket string   `gorm:"column:max_power_bucket"`
		PowerDetail    []byte   `gorm:"column:power_detail"`
		ServiceTime    string   `gorm:"column:service_time"`
	}
	err := models.DBDashboard.Raw(
		fmt.Sprintf(`SELECT station_name, city, district, connector_count,
		             max_power_kw, max_power_bucket, power_detail, service_time
		             FROM env_ev_charging_stations
		             WHERE %s
		             ORDER BY max_power_kw DESC, connector_count DESC`, where),
		queryArgs...,
	).Scan(&rows).Error
	if err != nil {
		return "", fmt.Errorf("查詢失敗: %v", err)
	}
	if len(rows) == 0 {
		label := "快充（≥50kW）"
		if params.UltraOnly {
			label = "超快充（≥150kW）"
		}
		return fmt.Sprintf("找不到符合條件的%s充電站。", label), nil
	}

	title := "快充（≥50kW）"
	if params.UltraOnly {
		title = "超快充（≥150kW）"
	}
	var sb strings.Builder
	if params.District != "" {
		fmt.Fprintf(&sb, "【%s %s %s充電站清單】共 %d 站\n\n",
			evCityName(params.CityScope), params.District, title, len(rows))
	} else {
		fmt.Fprintf(&sb, "【%s %s充電站清單】共 %d 站\n\n",
			evCityName(params.CityScope), title, len(rows))
	}

	for _, r := range rows {
		detail := powerDetailString(r.PowerDetail)
		svc := ""
		if r.ServiceTime != "" {
			svc = "　" + r.ServiceTime
		}
		fmt.Fprintf(&sb, "• %s（%s %s）　最高 %.0fkW　%d 槍",
			r.StationName, r.City, r.District, r.MaxPowerKW, r.ConnectorCount)
		if detail != "" {
			fmt.Fprintf(&sb, "　[%s]", detail)
		}
		sb.WriteString(svc + "\n")
	}
	return strings.TrimRight(sb.String(), "\n"), nil
}
