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
	ToolGetNoiseSummary         = "get_noise_summary"
	ToolGetNoiseQuarterlyTrend  = "get_noise_quarterly_trend"
	ToolGetNoiseDistrictRanking = "get_noise_district_ranking"
	ToolGetNoiseStationDetail   = "get_noise_station_detail"
)

func init() {
	Register(ToolGetNoiseSummary, GetNoiseSummary)
	Register(ToolGetNoiseQuarterlyTrend, GetNoiseQuarterlyTrend)
	Register(ToolGetNoiseDistrictRanking, GetNoiseDistrictRanking)
	Register(ToolGetNoiseStationDetail, GetNoiseStationDetail)

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetNoiseSummary,
			Description: "查詢臺北市或雙北噪音監測整體概況，包含測站數、各時段均能音量、行政區平均超標率與最新資料季度。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"city_scope": map[string]interface{}{
						"type":        "string",
						"description": "城市範圍。臺北市使用 taipei，雙北（臺北市＋新北市）使用 metrotaipei。",
						"enum":        []string{"taipei", "metrotaipei"},
					},
					"noise_category": map[string]interface{}{
						"type":        "string",
						"description": "噪音類別。交通噪音使用 traffic，環境噪音使用 environmental。",
						"enum":        []string{"traffic", "environmental"},
					},
					"year": map[string]interface{}{
						"type":        "integer",
						"description": "資料年份（選填，未指定時使用最新年份）。",
					},
				},
				"required":             []string{"city_scope", "noise_category"},
				"additionalProperties": false,
			},
		},
	})

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetNoiseQuarterlyTrend,
			Description: "查詢臺北市或雙北噪音監測的季度趨勢，回傳指定年份範圍內各季日間、晚間、夜間均能音量。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"city_scope": map[string]interface{}{
						"type":        "string",
						"description": "城市範圍。臺北市使用 taipei，雙北使用 metrotaipei。",
						"enum":        []string{"taipei", "metrotaipei"},
					},
					"noise_category": map[string]interface{}{
						"type":        "string",
						"description": "噪音類別。交通噪音使用 traffic，環境噪音使用 environmental。",
						"enum":        []string{"traffic", "environmental"},
					},
					"year_range": map[string]interface{}{
						"type":        "array",
						"description": "年份陣列（選填，如 [2023, 2024, 2025]，未指定時預設最近三年）。",
						"items": map[string]interface{}{
							"type": "integer",
						},
					},
				},
				"required":             []string{"city_scope", "noise_category"},
				"additionalProperties": false,
			},
		},
	})

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetNoiseDistrictRanking,
			Description: "查詢臺北市或雙北各行政區噪音排名，依日間均能音量由高到低排列，包含各時段均值、超標站數與超標率。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"city_scope": map[string]interface{}{
						"type":        "string",
						"description": "城市範圍。臺北市使用 taipei，雙北使用 metrotaipei。",
						"enum":        []string{"taipei", "metrotaipei"},
					},
					"noise_category": map[string]interface{}{
						"type":        "string",
						"description": "噪音類別。交通噪音使用 traffic，環境噪音使用 environmental。",
						"enum":        []string{"traffic", "environmental"},
					},
					"year": map[string]interface{}{
						"type":        "integer",
						"description": "資料年份（必填）。",
					},
					"quarter": map[string]interface{}{
						"type":        "integer",
						"description": "季別 1–4（必填）。",
					},
				},
				"required":             []string{"city_scope", "noise_category", "year", "quarter"},
				"additionalProperties": false,
			},
		},
	})

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetNoiseStationDetail,
			Description: "依測站編號查詢噪音測站詳細資料，包含基本資訊、管制標準、近 24 個月量測值與超標記錄。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"station_id": map[string]interface{}{
						"type":        "string",
						"description": "測站編號（如 \"0401020TN003\"）。",
					},
				},
				"required":             []string{"station_id"},
				"additionalProperties": false,
			},
		},
	})

	RegisterContext("雙北噪音監測站概況（交通噪音／環境噪音，最近三年季度趨勢、行政區排名、單站量測歷史）")
}

var noiseCategoryLabel = map[string]string{
	"traffic":       "交通噪音",
	"environmental": "環境噪音",
}

var noisePeriodLabel = map[string]string{
	"day":     "日間",
	"evening": "晚間",
	"night":   "夜間",
}

var noisePeriodOrder = []string{"day", "evening", "night"}

type noiseSummaryArgs struct {
	CityScope     string `json:"city_scope"`
	NoiseCategory string `json:"noise_category"`
	Year          int    `json:"year"`
}

type noiseTrendArgs struct {
	CityScope     string `json:"city_scope"`
	NoiseCategory string `json:"noise_category"`
	YearRange     []int  `json:"year_range"`
}

type noiseDistrictArgs struct {
	CityScope     string `json:"city_scope"`
	NoiseCategory string `json:"noise_category"`
	Year          int    `json:"year"`
	Quarter       int    `json:"quarter"`
}

type noiseStationArgs struct {
	StationID string `json:"station_id"`
}

// noiseSource returns the FROM clause for city-split noise tables.
// taipei returns the table name directly; metrotaipei returns a UNION ALL subquery.
func noiseSource(cityScope, tpeTable, newTpeTable string) (string, error) {
	switch cityScope {
	case "taipei":
		return tpeTable, nil
	case "metrotaipei":
		return fmt.Sprintf(
			"(SELECT * FROM %s UNION ALL SELECT * FROM %s) combined",
			tpeTable, newTpeTable), nil
	default:
		return "", fmt.Errorf("city_scope 必須是 'taipei' 或 'metrotaipei'")
	}
}

// GetNoiseSummary returns station count, avg dB per period, exceed rate, and latest quarter.
func GetNoiseSummary(ctx context.Context, args string) (string, error) {
	var params noiseSummaryArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}

	cityWhere, err := cityWhereClause(params.CityScope)
	if err != nil {
		return "", err
	}
	cityName := map[string]string{"taipei": "臺北市", "metrotaipei": "雙北"}[params.CityScope]
	catLabel := noiseCategoryLabel[params.NoiseCategory]

	statsSrc, err := noiseSource(params.CityScope,
		"env_noise_quarterly_stats_tpe", "env_noise_quarterly_stats_new_tpe")
	if err != nil {
		return "", err
	}
	distSrc, _ := noiseSource(params.CityScope,
		"env_noise_district_summary_tpe", "env_noise_district_summary_new_tpe")

	// station count
	var stationCount int
	models.DBDashboard.Raw(fmt.Sprintf(
		"SELECT COUNT(*)::int FROM env_noise_stations WHERE %s AND noise_category = ?", cityWhere),
		params.NoiseCategory,
	).Scan(&stationCount)

	// latest (year, quarter) — optionally constrained to params.Year
	var latest struct {
		Year    int `gorm:"column:year"`
		Quarter int `gorm:"column:quarter"`
	}
	if params.Year != 0 {
		models.DBDashboard.Raw(fmt.Sprintf(
			"SELECT year, quarter FROM %s WHERE noise_category = ? AND year = ? ORDER BY quarter DESC LIMIT 1",
			statsSrc), params.NoiseCategory, params.Year,
		).Scan(&latest)
	} else {
		models.DBDashboard.Raw(fmt.Sprintf(
			"SELECT year, quarter FROM %s WHERE noise_category = ? ORDER BY year DESC, quarter DESC LIMIT 1",
			statsSrc), params.NoiseCategory,
		).Scan(&latest)
	}
	if latest.Year == 0 {
		return fmt.Sprintf("【%s %s】\n暫無資料。", cityName, catLabel), nil
	}

	// avg dB per period for the latest quarter
	var periodRows []struct {
		Period string  `gorm:"column:period"`
		AvgDB  float64 `gorm:"column:avg_db"`
	}
	models.DBDashboard.Raw(fmt.Sprintf(
		`SELECT period, ROUND(AVG(avg_db)::numeric, 1) AS avg_db
		 FROM %s
		 WHERE noise_category = ? AND year = ? AND quarter = ?
		 GROUP BY period`, statsSrc),
		params.NoiseCategory, latest.Year, latest.Quarter,
	).Scan(&periodRows)

	// avg exceed_rate across districts for the same quarter
	var exceedRate float64
	models.DBDashboard.Raw(fmt.Sprintf(
		"SELECT COALESCE(ROUND(AVG(exceed_rate)::numeric, 4), 0) FROM %s WHERE noise_category = ? AND year = ? AND quarter = ?",
		distSrc),
		params.NoiseCategory, latest.Year, latest.Quarter,
	).Scan(&exceedRate)

	periodMap := map[string]float64{}
	for _, r := range periodRows {
		periodMap[r.Period] = r.AvgDB
	}

	var sb strings.Builder
	fmt.Fprintf(&sb, "【%s %s 概況】\n", cityName, catLabel)
	fmt.Fprintf(&sb, "最新資料季度：%dQ%d\n", latest.Year, latest.Quarter)
	fmt.Fprintf(&sb, "測站數：%d\n", stationCount)
	sb.WriteString("\n各時段均能音量：\n")
	for _, p := range noisePeriodOrder {
		if v, ok := periodMap[p]; ok {
			fmt.Fprintf(&sb, "  %-4s：%.1f dB\n", noisePeriodLabel[p], v)
		}
	}
	fmt.Fprintf(&sb, "\n行政區平均超標率：%.1f%%\n", exceedRate*100)
	sb.WriteString("資料來源：臺北市環保局 / 新北市環保局")
	return sb.String(), nil
}

// GetNoiseQuarterlyTrend returns per-quarter avg dB for day/evening/night periods.
func GetNoiseQuarterlyTrend(ctx context.Context, args string) (string, error) {
	var params noiseTrendArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}

	cityName := map[string]string{"taipei": "臺北市", "metrotaipei": "雙北"}[params.CityScope]
	catLabel := noiseCategoryLabel[params.NoiseCategory]

	statsSrc, err := noiseSource(params.CityScope,
		"env_noise_quarterly_stats_tpe", "env_noise_quarterly_stats_new_tpe")
	if err != nil {
		return "", err
	}

	// default year_range to last 3 years
	yearRange := params.YearRange
	if len(yearRange) == 0 {
		cur := time.Now().Year()
		yearRange = []int{cur - 2, cur - 1, cur}
	}

	// build IN clause
	placeholders := make([]string, len(yearRange))
	queryArgs := make([]interface{}, 1+len(yearRange))
	queryArgs[0] = params.NoiseCategory
	for i, y := range yearRange {
		placeholders[i] = "?"
		queryArgs[i+1] = y
	}
	yearIn := strings.Join(placeholders, ",")

	var rows []struct {
		Year         int     `gorm:"column:year"`
		Quarter      int     `gorm:"column:quarter"`
		QuarterLabel string  `gorm:"column:quarter_label"`
		Period       string  `gorm:"column:period"`
		AvgDB        float64 `gorm:"column:avg_db"`
	}
	err = models.DBDashboard.Raw(fmt.Sprintf(
		`SELECT year, quarter, quarter_label, period, ROUND(AVG(avg_db)::numeric, 1) AS avg_db
		 FROM %s
		 WHERE noise_category = ? AND year IN (%s)
		 GROUP BY year, quarter, quarter_label, period
		 ORDER BY year, quarter, period`, statsSrc, yearIn),
		queryArgs...,
	).Scan(&rows).Error
	if err != nil {
		return "", fmt.Errorf("查詢季度趨勢失敗: %v", err)
	}
	if len(rows) == 0 {
		return fmt.Sprintf("【%s %s 季度趨勢】\n無資料（指定年份：%v）", cityName, catLabel, yearRange), nil
	}

	// group rows by (year, quarter)
	type qKey struct{ Year, Quarter int }
	type qData struct {
		Label   string
		Values  map[string]float64
	}
	order := []qKey{}
	qMap := map[qKey]*qData{}
	for _, r := range rows {
		k := qKey{r.Year, r.Quarter}
		if _, ok := qMap[k]; !ok {
			order = append(order, k)
			qMap[k] = &qData{Label: r.QuarterLabel, Values: map[string]float64{}}
		}
		qMap[k].Values[r.Period] = r.AvgDB
	}

	var sb strings.Builder
	fmt.Fprintf(&sb, "【%s %s 季度趨勢】\n", cityName, catLabel)
	fmt.Fprintf(&sb, "%-8s  %-9s  %-9s  %-9s\n", "季度", "日間(dB)", "晚間(dB)", "夜間(dB)")
	for _, k := range order {
		d := qMap[k]
		fmt.Fprintf(&sb, "%-8s  %-9.1f  %-9.1f  %-9.1f\n",
			d.Label, d.Values["day"], d.Values["evening"], d.Values["night"])
	}
	return strings.TrimRight(sb.String(), "\n"), nil
}

// GetNoiseDistrictRanking returns districts ranked by avg day dB for a given quarter.
func GetNoiseDistrictRanking(ctx context.Context, args string) (string, error) {
	var params noiseDistrictArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if params.Quarter < 1 || params.Quarter > 4 {
		return "", fmt.Errorf("quarter 必須是 1–4")
	}

	cityName := map[string]string{"taipei": "臺北市", "metrotaipei": "雙北"}[params.CityScope]
	catLabel := noiseCategoryLabel[params.NoiseCategory]

	distSrc, err := noiseSource(params.CityScope,
		"env_noise_district_summary_tpe", "env_noise_district_summary_new_tpe")
	if err != nil {
		return "", err
	}

	var rows []struct {
		District    string  `gorm:"column:district"`
		AvgDayDB    float64 `gorm:"column:avg_day_db"`
		AvgEveDB    float64 `gorm:"column:avg_evening_db"`
		AvgNightDB  float64 `gorm:"column:avg_night_db"`
		ExceedCount int     `gorm:"column:exceed_count"`
		ExceedRate  float64 `gorm:"column:exceed_rate"`
	}
	err = models.DBDashboard.Raw(fmt.Sprintf(
		`SELECT district, avg_day_db, avg_evening_db, avg_night_db,
		        exceed_count::int, exceed_rate
		 FROM %s
		 WHERE noise_category = ? AND year = ? AND quarter = ?
		 ORDER BY avg_day_db DESC`, distSrc),
		params.NoiseCategory, params.Year, params.Quarter,
	).Scan(&rows).Error
	if err != nil {
		return "", fmt.Errorf("查詢行政區排名失敗: %v", err)
	}
	if len(rows) == 0 {
		return fmt.Sprintf("【%s %s %dQ%d 行政區排名】\n無資料。",
			cityName, catLabel, params.Year, params.Quarter), nil
	}

	var sb strings.Builder
	fmt.Fprintf(&sb, "【%s %s %dQ%d 行政區噪音排名（依日間 dB 由高到低）】\n\n",
		cityName, catLabel, params.Year, params.Quarter)
	fmt.Fprintf(&sb, "%-4s %-8s  %-8s  %-8s  %-8s  %-6s  超標率\n",
		"名次", "行政區", "日間dB", "晚間dB", "夜間dB", "超標站")
	for i, r := range rows {
		fmt.Fprintf(&sb, "%-4d %-8s  %-8.1f  %-8.1f  %-8.1f  %-6d  %.1f%%\n",
			i+1, r.District, r.AvgDayDB, r.AvgEveDB, r.AvgNightDB,
			r.ExceedCount, r.ExceedRate*100)
	}
	return strings.TrimRight(sb.String(), "\n"), nil
}

// GetNoiseStationDetail returns station metadata and all available quarterly measurements.
func GetNoiseStationDetail(ctx context.Context, args string) (string, error) {
	var params noiseStationArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if params.StationID == "" {
		return "", fmt.Errorf("station_id 不得為空")
	}

	var s struct {
		StationName    string     `gorm:"column:station_name"`
		City           string     `gorm:"column:city"`
		District       string     `gorm:"column:district"`
		StationID      string     `gorm:"column:station_id"`
		NoiseCategory  string     `gorm:"column:noise_category"`
		MonitoringType string     `gorm:"column:monitoring_type"`
		ControlZone    string     `gorm:"column:control_zone"`
		StdDayDB       float64    `gorm:"column:standard_day_db"`
		StdEveDB       float64    `gorm:"column:standard_evening_db"`
		StdNightDB     float64    `gorm:"column:standard_night_db"`
		TotalExceed    int        `gorm:"column:total_exceed_count"`
		LatestYear     int        `gorm:"column:latest_year"`
		LatestMonth    int        `gorm:"column:latest_month"`
		SourceName     string     `gorm:"column:source_name"`
		DataTime       *time.Time `gorm:"column:data_time"`
	}
	models.DBDashboard.Raw(
		`SELECT station_name, city, district, station_id, noise_category,
		        monitoring_type, control_zone,
		        standard_day_db, standard_evening_db, standard_night_db,
		        total_exceed_count, latest_year, latest_month, source_name, data_time
		 FROM env_noise_stations WHERE station_id = ?`, params.StationID,
	).Scan(&s)

	if s.StationName == "" {
		return fmt.Sprintf("找不到測站 %s。", params.StationID), nil
	}

	// quarterly stats are city-split; pick table by city
	statsTable := "env_noise_quarterly_stats_tpe"
	if s.City == "新北市" {
		statsTable = "env_noise_quarterly_stats_new_tpe"
	}

	var qRows []struct {
		Year         int     `gorm:"column:year"`
		Quarter      int     `gorm:"column:quarter"`
		QuarterLabel string  `gorm:"column:quarter_label"`
		Period       string  `gorm:"column:period"`
		AvgDB        float64 `gorm:"column:avg_db"`
	}
	models.DBDashboard.Raw(fmt.Sprintf(
		`SELECT year, quarter, quarter_label, period, avg_db
		 FROM %s
		 WHERE station_name = ? AND noise_category = ?
		 ORDER BY year DESC, quarter DESC, period`, statsTable),
		s.StationName, s.NoiseCategory,
	).Scan(&qRows)

	monitorLabel := map[string]string{"manual": "人工", "automatic": "自動"}
	catLabel := noiseCategoryLabel[s.NoiseCategory]

	var sb strings.Builder
	fmt.Fprintf(&sb, "【測站詳情：%s】\n", s.StationName)
	fmt.Fprintf(&sb, "城市：%s | 行政區：%s\n", s.City, s.District)
	fmt.Fprintf(&sb, "測站編號：%s | 類別：%s | 監測方式：%s\n",
		s.StationID, catLabel, monitorLabel[s.MonitoringType])
	fmt.Fprintf(&sb, "管制區別：%s 區\n", s.ControlZone)
	fmt.Fprintf(&sb, "管制標準：日間 %.0f dB | 晚間 %.0f dB | 夜間 %.0f dB\n",
		s.StdDayDB, s.StdEveDB, s.StdNightDB)
	fmt.Fprintf(&sb, "歷年超標次數：%d\n", s.TotalExceed)
	fmt.Fprintf(&sb, "來源：%s\n", s.SourceName)
	if s.DataTime != nil {
		fmt.Fprintf(&sb, "資料更新：%s\n", s.DataTime.Format("2006-01-02"))
	}

	if len(qRows) > 0 {
		// pivot period rows into per-quarter records
		type qKey struct{ Year, Quarter int }
		type qVals struct {
			Label   string
			Day     float64
			Evening float64
			Night   float64
		}
		order := []qKey{}
		qMap := map[qKey]*qVals{}
		for _, r := range qRows {
			k := qKey{r.Year, r.Quarter}
			if _, ok := qMap[k]; !ok {
				order = append(order, k)
				qMap[k] = &qVals{Label: r.QuarterLabel}
			}
			switch r.Period {
			case "day":
				qMap[k].Day = r.AvgDB
			case "evening":
				qMap[k].Evening = r.AvgDB
			case "night":
				qMap[k].Night = r.AvgDB
			}
		}

		sb.WriteString("\n各季均能音量（日間 / 晚間 / 夜間）：\n")
		sb.WriteString("季度      日間dB  晚間dB  夜間dB  超標\n")
		for _, k := range order {
			v := qMap[k]
			exceeded := v.Day > s.StdDayDB || v.Evening > s.StdEveDB || v.Night > s.StdNightDB
			mark := ""
			if exceeded {
				mark = "★"
			}
			fmt.Fprintf(&sb, "%-8s  %-6.1f  %-6.1f  %-6.1f  %s\n",
				v.Label, v.Day, v.Evening, v.Night, mark)
		}
	}

	return strings.TrimRight(sb.String(), "\n"), nil
}
