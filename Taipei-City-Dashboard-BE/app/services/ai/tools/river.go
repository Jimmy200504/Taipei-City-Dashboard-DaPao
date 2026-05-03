package tools

import (
	"TaipeiCityDashboardBE/app/models"
	"context"
	"fmt"
	"strings"
	"time"

	"github.com/tmc/langchaingo/llms"
)

const (
	ToolGetRiverRpiSummary          = "get_river_rpi_summary"
	ToolGetRiverSiteDetail          = "get_river_site_detail"
	ToolGetRiverPollutionByName     = "get_river_pollution_by_name"
	ToolGetRiverPollutionByLocation = "get_river_pollution_by_location"
)

func init() {
	Register(ToolGetRiverRpiSummary, GetRiverRpiSummary)
	Register(ToolGetRiverSiteDetail, GetRiverSiteDetail)
	Register(ToolGetRiverPollutionByName, GetRiverPollutionByName)
	Register(ToolGetRiverPollutionByLocation, GetRiverPollutionByLocation)

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetRiverRpiSummary,
			Description: "查詢臺北市或雙北河川水質 RPI 風險概況，包含最新月份各風險等級測站數、最高 RPI 測站與資料時間。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"city_scope": map[string]interface{}{
						"type":        "string",
						"description": "城市範圍。臺北市使用 taipei，雙北（臺北市＋新北市）使用 metrotaipei。",
						"enum":        []string{"taipei", "metrotaipei"},
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
			Name:        ToolGetRiverSiteDetail,
			Description: "查詢指定測站的河川水質詳細資料，包含 RPI 值、風險等級、採樣月份；其他單位測站另提供 DO/BOD5/SS/NH3-N 子指標。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"site_id": map[string]interface{}{
						"type":        "string",
						"description": "測站 ID。環境部官方測站為數字字串（如 \"1540\"）；其他單位測站格式為 \"ext:{SiteMgt_ID}:{SiteID}\"。",
					},
				},
				"required":             []string{"site_id"},
				"additionalProperties": false,
			},
		},
	})

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetRiverPollutionByName,
			Description: "依河川名稱查詢該河川所有測站的最新 RPI 污染程度，支援部分名稱比對（如輸入「基隆」可找到「基隆河」）。回傳測站列表與各站污染等級，並標出最嚴重測站。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"river_name": map[string]interface{}{
						"type":        "string",
						"description": "河川名稱或關鍵字，支援部分比對（例如「基隆」、「新店」、「淡水」）。",
					},
					"city_scope": map[string]interface{}{
						"type":        "string",
						"description": "城市範圍篩選（選填）。taipei 只看臺北市測站，metrotaipei 看雙北，省略則不限城市。",
						"enum":        []string{"taipei", "metrotaipei"},
					},
				},
				"required":             []string{"river_name"},
				"additionalProperties": false,
			},
		},
	})

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetRiverPollutionByLocation,
			Description: "依地名（行政區、河川、流域）查詢附近水域的河川水質狀況。適合回答「xxx 附近的水域如何」、「xxx 的水質」等地理位置式提問。同時比對行政區、河川名、流域名，可回傳多條河川的測站資料。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"location": map[string]interface{}{
						"type":        "string",
						"description": "地名關鍵字，支援行政區（如「三峽」、「新店」、「淡水」）或河川名稱（如「基隆河」），不需加「區」或「附近」等字。",
					},
				},
				"required":             []string{"location"},
				"additionalProperties": false,
			},
		},
	})

	RegisterContext("雙北河川水質 RPI 風險等級概況（最新月份測站分布）與個別測站詳細水質資料")
}

var riskLevelLabel = map[string]string{
	"unpolluted": "未受污染",
	"mild":       "輕度污染",
	"moderate":   "中度污染",
	"severe":     "嚴重污染",
}

var riskLevelOrder = []string{"unpolluted", "mild", "moderate", "severe"}

type riverCityArgs struct {
	CityScope string `json:"city_scope"`
}

type riverSiteArgs struct {
	SiteID string `json:"site_id"`
}

func cityWhereClause(cityScope string) (string, error) {
	switch cityScope {
	case "taipei":
		return "city = '臺北市'", nil
	case "metrotaipei":
		return "city IN ('臺北市','新北市')", nil
	default:
		return "", fmt.Errorf("city_scope 必須是 'taipei' 或 'metrotaipei'")
	}
}

// GetRiverRpiSummary returns risk level distribution + top station for the given city scope
func GetRiverRpiSummary(ctx context.Context, args string) (string, error) {
	var params riverCityArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	cityWhere, err := cityWhereClause(params.CityScope)
	if err != nil {
		return "", err
	}
	cityName := map[string]string{"taipei": "臺北市", "metrotaipei": "雙北"}[params.CityScope]

	// risk level distribution
	var riskRows []struct {
		RiskLevel      string `gorm:"column:risk_level"`
		RiskLevelOrder int    `gorm:"column:risk_level_order"`
		Count          int    `gorm:"column:count"`
	}
	err = models.DBDashboard.Raw(fmt.Sprintf(
		`SELECT risk_level, risk_level_order, COUNT(*)::int AS count
		 FROM env_river_site_rpi_latest
		 WHERE %s AND rpi_flag = 'complete'
		 GROUP BY risk_level, risk_level_order
		 ORDER BY risk_level_order`, cityWhere),
	).Scan(&riskRows).Error
	if err != nil {
		return "", fmt.Errorf("查詢風險等級分布失敗: %v", err)
	}

	// top RPI station
	var top struct {
		SiteName    string    `gorm:"column:site_name"`
		RpiValue    float64   `gorm:"column:rpi_value"`
		RiskLevel   string    `gorm:"column:risk_level"`
		SampleMonth time.Time `gorm:"column:sample_month"`
		SourceLabel string    `gorm:"column:source_label"`
	}
	err = models.DBDashboard.Raw(fmt.Sprintf(
		`SELECT site_name, rpi_value, risk_level, sample_month, source_label
		 FROM env_river_site_rpi_latest
		 WHERE %s AND rpi_flag = 'complete'
		 ORDER BY rpi_value DESC LIMIT 1`, cityWhere),
	).Scan(&top).Error
	if err != nil {
		return "", fmt.Errorf("查詢最高 RPI 測站失敗: %v", err)
	}

	// source breakdown
	var srcRows []struct {
		SourceLabel string `gorm:"column:source_label"`
		Count       int    `gorm:"column:count"`
	}
	models.DBDashboard.Raw(fmt.Sprintf(
		`SELECT source_label, COUNT(*)::int AS count
		 FROM env_river_site_rpi_latest
		 WHERE %s AND rpi_flag = 'complete'
		 GROUP BY source_label`, cityWhere),
	).Scan(&srcRows)

	// build output
	riskCounts := map[string]int{}
	total := 0
	sampleMonth := ""
	for _, r := range riskRows {
		riskCounts[r.RiskLevel] = r.Count
		total += r.Count
	}
	if !top.SampleMonth.IsZero() {
		sampleMonth = top.SampleMonth.Format("2006 年 1 月")
	}

	var sb strings.Builder
	fmt.Fprintf(&sb, "【%s 河川水質 RPI 風險概況】\n", cityName)
	if sampleMonth != "" {
		fmt.Fprintf(&sb, "資料月份：%s\n", sampleMonth)
	}
	fmt.Fprintf(&sb, "\n風險等級分布（共 %d 站，complete 資料）：\n", total)
	for _, lvl := range riskLevelOrder {
		label, ok := riskLevelLabel[lvl]
		if !ok {
			label = lvl
		}
		fmt.Fprintf(&sb, "  %-8s：%d 站\n", label, riskCounts[lvl])
	}

	if top.SiteName != "" {
		lvlLabel := riskLevelLabel[top.RiskLevel]
		fmt.Fprintf(&sb, "\n最高 RPI 測站：%s（RPI=%.2f，%s）\n", top.SiteName, top.RpiValue, lvlLabel)
	}

	srcMap := map[string]int{}
	for _, s := range srcRows {
		srcMap[s.SourceLabel] = s.Count
	}
	fmt.Fprintf(&sb, "資料來源：環境部官方測站 %d 站 / 其他單位測站 %d 站",
		srcMap["moenv_river"], srcMap["moenv_ext_river"])

	return sb.String(), nil
}

// GetRiverSiteDetail returns full detail for a single monitoring station
func GetRiverSiteDetail(ctx context.Context, args string) (string, error) {
	var params riverSiteArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if params.SiteID == "" {
		return "", fmt.Errorf("site_id 不得為空")
	}

	var row struct {
		SiteName         string     `gorm:"column:site_name"`
		City             string     `gorm:"column:city"`
		District         *string    `gorm:"column:district"`
		River            string     `gorm:"column:river"`
		Basin            string     `gorm:"column:basin"`
		RpiValue         *float64   `gorm:"column:rpi_value"`
		RiskLevel        *string    `gorm:"column:risk_level"`
		RpiMethod        string     `gorm:"column:rpi_method"`
		WqStdGrade       *string    `gorm:"column:wq_std_grade"`
		SampleMonth      *time.Time `gorm:"column:sample_month"`
		RpiFlag          string     `gorm:"column:rpi_flag"`
		SourceLabel      string     `gorm:"column:source_label"`
		DoValue          *float64   `gorm:"column:do_value"`
		Bod5Value        *float64   `gorm:"column:bod5_value"`
		SsValue          *float64   `gorm:"column:ss_value"`
		Nh3nValue        *float64   `gorm:"column:nh3n_value"`
		ConductValue     *float64   `gorm:"column:conductivity_value"`
		DoScore          *float64   `gorm:"column:do_score"`
		Bod5Score        *float64   `gorm:"column:bod5_score"`
		SsScore          *float64   `gorm:"column:ss_score"`
		Nh3nScore        *float64   `gorm:"column:nh3n_score"`
	}

	err := models.DBDashboard.Table("env_river_site_rpi_latest").
		Where("site_id = ?", params.SiteID).
		First(&row).Error
	if err != nil {
		return "", fmt.Errorf("找不到測站 %s: %v", params.SiteID, err)
	}

	var sb strings.Builder
	fmt.Fprintf(&sb, "【測站詳情：%s】\n", row.SiteName)
	fmt.Fprintf(&sb, "城市：%s", row.City)
	if row.District != nil && *row.District != "" {
		fmt.Fprintf(&sb, " | 行政區：%s", *row.District)
	}
	sb.WriteString("\n")
	fmt.Fprintf(&sb, "流域：%s | 河川：%s\n", row.Basin, row.River)

	if row.RpiValue != nil {
		lvlLabel := ""
		if row.RiskLevel != nil {
			lvlLabel = riskLevelLabel[*row.RiskLevel]
		}
		fmt.Fprintf(&sb, "RPI：%.2f | 風險等級：%s\n", *row.RpiValue, lvlLabel)
	} else {
		sb.WriteString("RPI：無完整資料（rpi_flag=incomplete）\n")
	}

	methodLabel := map[string]string{
		"source_wq_index":       "環境部直接提供（WQ_Index）",
		"calculated_from_items": "由 DO/BOD5/SS/NH3-N 四項指標平均計算",
	}
	fmt.Fprintf(&sb, "計算方式：%s\n", methodLabel[row.RpiMethod])

	if row.WqStdGrade != nil && *row.WqStdGrade != "" {
		fmt.Fprintf(&sb, "水體分類：%s\n", *row.WqStdGrade)
	}
	if row.SampleMonth != nil {
		fmt.Fprintf(&sb, "資料月份：%s\n", row.SampleMonth.Format("2006 年 1 月"))
	}
	fmt.Fprintf(&sb, "來源：%s\n", row.SourceLabel)

	// sub-indicators (ext stations only)
	if row.RpiMethod == "calculated_from_items" {
		sb.WriteString("\n子指標：\n")
		writeIndicator(&sb, "DO", "mg/L", row.DoValue, row.DoScore)
		writeIndicator(&sb, "BOD5", "mg/L", row.Bod5Value, row.Bod5Score)
		writeIndicator(&sb, "SS", "mg/L", row.SsValue, row.SsScore)
		writeIndicator(&sb, "NH3-N", "mg/L", row.Nh3nValue, row.Nh3nScore)
		if row.ConductValue != nil {
			fmt.Fprintf(&sb, "  導電度：%.1f μS/cm（不入 RPI）\n", *row.ConductValue)
		}
	}

	return sb.String(), nil
}

type riverByNameArgs struct {
	RiverName string `json:"river_name"`
	CityScope string `json:"city_scope"`
}

// GetRiverPollutionByName queries all stations on rivers matching the given name keyword
func GetRiverPollutionByName(ctx context.Context, args string) (string, error) {
	var params riverByNameArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if params.RiverName == "" {
		return "", fmt.Errorf("river_name 不得為空")
	}

	// build WHERE clause
	conditions := []string{"rpi_flag = 'complete'", "river ILIKE ?"}
	queryArgs := []interface{}{"%" + params.RiverName + "%"}
	switch params.CityScope {
	case "taipei":
		conditions = append(conditions, "city = '臺北市'")
	case "metrotaipei":
		conditions = append(conditions, "city IN ('臺北市','新北市')")
	}
	where := strings.Join(conditions, " AND ")

	var rows []struct {
		River       string     `gorm:"column:river"`
		SiteName    string     `gorm:"column:site_name"`
		City        string     `gorm:"column:city"`
		RpiValue    float64    `gorm:"column:rpi_value"`
		RiskLevel   string     `gorm:"column:risk_level"`
		SampleMonth *time.Time `gorm:"column:sample_month"`
	}
	err := models.DBDashboard.Raw(
		fmt.Sprintf(`SELECT river, site_name, city, rpi_value, risk_level, sample_month
		             FROM env_river_site_rpi_latest
		             WHERE %s
		             ORDER BY river, rpi_value DESC`, where),
		queryArgs...,
	).Scan(&rows).Error
	if err != nil {
		return "", fmt.Errorf("查詢失敗: %v", err)
	}
	if len(rows) == 0 {
		return fmt.Sprintf("找不到名稱包含「%s」的河川測站資料。", params.RiverName), nil
	}

	// group by river
	type riverGroup struct {
		stations []struct {
			name        string
			city        string
			rpiValue    float64
			riskLevel   string
			sampleMonth *time.Time
		}
	}
	riverOrder := []string{}
	riverMap := map[string]*riverGroup{}
	for _, r := range rows {
		if _, ok := riverMap[r.River]; !ok {
			riverMap[r.River] = &riverGroup{}
			riverOrder = append(riverOrder, r.River)
		}
		riverMap[r.River].stations = append(riverMap[r.River].stations, struct {
			name        string
			city        string
			rpiValue    float64
			riskLevel   string
			sampleMonth *time.Time
		}{r.SiteName, r.City, r.RpiValue, r.RiskLevel, r.SampleMonth})
	}

	var sb strings.Builder
	for _, river := range riverOrder {
		g := riverMap[river]
		sampleMonthStr := ""
		if g.stations[0].sampleMonth != nil {
			sampleMonthStr = "（" + g.stations[0].sampleMonth.Format("2006 年 1 月") + "）"
		}
		fmt.Fprintf(&sb, "【%s】%s\n", river, sampleMonthStr)

		worstRisk := ""
		worstRPI := 0.0
		for _, s := range g.stations {
			lvlLabel := riskLevelLabel[s.riskLevel]
			fmt.Fprintf(&sb, "  %-20s %s  RPI=%.2f（%s）\n", s.name, s.city, s.rpiValue, lvlLabel)
			if s.rpiValue > worstRPI {
				worstRPI = s.rpiValue
				worstRisk = lvlLabel
			}
		}
		if len(g.stations) > 1 {
			fmt.Fprintf(&sb, "  ▶ 整條河川整體評估：最高污染 %s（RPI=%.2f）\n", worstRisk, worstRPI)
		}
		sb.WriteString("\n")
	}

	return strings.TrimRight(sb.String(), "\n"), nil
}

type riverByLocationArgs struct {
	Location string `json:"location"`
}

// GetRiverPollutionByLocation queries stations matching a location keyword
// across district, river name, and basin — for "xxx 附近的水域" style queries.
func GetRiverPollutionByLocation(ctx context.Context, args string) (string, error) {
	var params riverByLocationArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if params.Location == "" {
		return "", fmt.Errorf("location 不得為空")
	}

	kw := "%" + params.Location + "%"
	var rows []struct {
		River       string     `gorm:"column:river"`
		Basin       string     `gorm:"column:basin"`
		SiteName    string     `gorm:"column:site_name"`
		City        string     `gorm:"column:city"`
		District    *string    `gorm:"column:district"`
		RpiValue    float64    `gorm:"column:rpi_value"`
		RiskLevel   string     `gorm:"column:risk_level"`
		SampleMonth *time.Time `gorm:"column:sample_month"`
		MatchField  string     `gorm:"column:match_field"`
	}
	// Search district + river. Basin is intentionally excluded: large basins
	// like 淡水河流域 cover most of Taipei and would return irrelevant results.
	err := models.DBDashboard.Raw(`
		SELECT river, basin, site_name, city, district, rpi_value, risk_level, sample_month,
		       CASE
		         WHEN district ILIKE $1 THEN 'district'
		         ELSE 'river'
		       END AS match_field
		FROM env_river_site_rpi_latest
		WHERE rpi_flag = 'complete'
		  AND (district ILIKE $1 OR river ILIKE $1)
		ORDER BY river, rpi_value DESC`, kw,
	).Scan(&rows).Error
	if err != nil {
		return "", fmt.Errorf("查詢失敗: %v", err)
	}
	if len(rows) == 0 {
		return fmt.Sprintf("找不到與「%s」相關的河川測站資料（已搜尋行政區與河川名）。", params.Location), nil
	}

	// group by river
	riverOrder := []string{}
	type stationRow struct {
		name        string
		city        string
		district    string
		rpiValue    float64
		riskLevel   string
		sampleMonth *time.Time
	}
	riverStations := map[string][]stationRow{}
	riverBasin := map[string]string{}
	for _, r := range rows {
		if _, ok := riverStations[r.River]; !ok {
			riverOrder = append(riverOrder, r.River)
			riverBasin[r.River] = r.Basin
		}
		dist := ""
		if r.District != nil {
			dist = *r.District
		}
		riverStations[r.River] = append(riverStations[r.River], stationRow{
			r.SiteName, r.City, dist, r.RpiValue, r.RiskLevel, r.SampleMonth,
		})
	}

	var sb strings.Builder
	fmt.Fprintf(&sb, "【與「%s」相關的水域水質】\n\n", params.Location)

	for _, river := range riverOrder {
		stations := riverStations[river]
		sampleMonthStr := ""
		if stations[0].sampleMonth != nil {
			sampleMonthStr = "（" + stations[0].sampleMonth.Format("2006 年 1 月") + "）"
		}
		fmt.Fprintf(&sb, "▍%s（流域：%s）%s\n", river, riverBasin[river], sampleMonthStr)

		worstRPI := 0.0
		worstRisk := ""
		for _, s := range stations {
			lvlLabel := riskLevelLabel[s.riskLevel]
			distStr := ""
			if s.district != "" {
				distStr = s.district + "、"
			}
			fmt.Fprintf(&sb, "  %-22s %s%s  RPI=%.2f（%s）\n",
				s.name, distStr, s.city, s.rpiValue, lvlLabel)
			if s.rpiValue > worstRPI {
				worstRPI = s.rpiValue
				worstRisk = lvlLabel
			}
		}
		if len(stations) > 1 {
			fmt.Fprintf(&sb, "  ▶ 最高污染：%s（RPI=%.2f）\n", worstRisk, worstRPI)
		}
		sb.WriteString("\n")
	}

	return strings.TrimRight(sb.String(), "\n"), nil
}

func writeIndicator(sb *strings.Builder, name, unit string, val, score *float64) {
	if val != nil {
		scoreStr := ""
		if score != nil {
			scoreStr = fmt.Sprintf("，分數：%.0f", *score)
		}
		fmt.Fprintf(sb, "  %-6s：%.2f %s%s\n", name, *val, unit, scoreStr)
	} else {
		fmt.Fprintf(sb, "  %-6s：缺值\n", name)
	}
}
