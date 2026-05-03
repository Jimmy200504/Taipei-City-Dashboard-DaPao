package tools

import (
	"TaipeiCityDashboardBE/app/models"
	"context"
	"fmt"
	"strings"

	"github.com/tmc/langchaingo/llms"
)

const (
	ToolGetStreetlightDistrictWatt = "get_streetlight_district_watt"
	ToolGetStreetlightWattDist     = "get_streetlight_watt_distribution"
)

func init() {
	Register(ToolGetStreetlightDistrictWatt, GetStreetlightDistrictWatt)
	Register(ToolGetStreetlightWattDist, GetStreetlightWattDist)

	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetStreetlightDistrictWatt,
			Description: "查詢臺北市或雙北各行政區路燈平均瓦數排名。",
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
			Name:        ToolGetStreetlightWattDist,
			Description: "查詢臺北市或雙北路燈用電等級（≤30W / 31-80W / 81-150W / 151-250W / >250W）分布。可指定行政區或查全市。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"city_scope": map[string]interface{}{
						"type":        "string",
						"description": "城市範圍。taipei 或 metrotaipei。",
						"enum":        []string{"taipei", "metrotaipei"},
					},
					"district": map[string]interface{}{
						"type":        "string",
						"description": "行政區名稱（含「區」字，例如「信義區」）。省略則回傳全市所有行政區。",
					},
				},
				"required":             []string{"city_scope"},
				"additionalProperties": false,
			},
		},
	})

	RegisterContext("雙北路燈各行政區平均瓦數排名、各行政區用電等級（≤30W 至 >250W）燈數比例")
}

type streetlightCityArgs struct {
	CityScope string `json:"city_scope"`
}

type streetlightDistArgs struct {
	CityScope string `json:"city_scope"`
	District  string `json:"district"`
}

// GetStreetlightDistrictWatt returns avg watt per district ranked by consumption
func GetStreetlightDistrictWatt(ctx context.Context, args string) (string, error) {
	var params streetlightCityArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if params.CityScope != "taipei" && params.CityScope != "metrotaipei" {
		return "", fmt.Errorf("city_scope 必須是 'taipei' 或 'metrotaipei'")
	}

	var rows []struct {
		District  string  `gorm:"column:district"`
		AvgWatt   float64 `gorm:"column:avg_watt"`
		LampCount int     `gorm:"column:lamp_count"`
	}
	err := models.DBDashboard.Table("env_streetlight_district_summary").
		Where("city_scope = ?", params.CityScope).
		Order("avg_watt DESC").
		Find(&rows).Error
	if err != nil || len(rows) == 0 {
		return "", fmt.Errorf("查無資料（city_scope=%s）", params.CityScope)
	}

	cityName := map[string]string{"taipei": "臺北市", "metrotaipei": "雙北"}[params.CityScope]
	var sb strings.Builder
	fmt.Fprintf(&sb, "【%s 各行政區路燈平均瓦數排名】\n", cityName)
	for i, r := range rows {
		fmt.Fprintf(&sb, "%2d. %-6s 平均 %d W（%d 盞）\n", i+1, r.District, int(r.AvgWatt+0.5), r.LampCount)
	}
	return sb.String(), nil
}

var bucketLabel = map[string]string{
	"ultra_low": "≤30W",
	"low":       "31-80W",
	"medium":    "81-150W",
	"high":      "151-250W",
	"very_high": ">250W",
}

var bucketOrder = []string{"ultra_low", "low", "medium", "high", "very_high"}

// GetStreetlightWattDist returns watt bucket distribution per district (or city-wide)
func GetStreetlightWattDist(ctx context.Context, args string) (string, error) {
	var params streetlightDistArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}
	if params.CityScope != "taipei" && params.CityScope != "metrotaipei" {
		return "", fmt.Errorf("city_scope 必須是 'taipei' 或 'metrotaipei'")
	}

	var rows []struct {
		District        string `gorm:"column:district"`
		WattBucket      string `gorm:"column:watt_bucket"`
		WattBucketOrder int    `gorm:"column:watt_bucket_order"`
		LampCount       int    `gorm:"column:lamp_count"`
	}
	q := models.DBDashboard.Table("env_streetlight_district_watt_bucket").
		Where("city_scope = ?", params.CityScope)
	if params.District != "" {
		q = q.Where("district = ?", params.District)
	}
	err := q.Order("district, watt_bucket_order").Find(&rows).Error
	if err != nil || len(rows) == 0 {
		return "", fmt.Errorf("查無資料")
	}

	// aggregate by district
	type distStat struct {
		counts map[string]int
		total  int
	}
	distMap := map[string]*distStat{}
	distOrder := []string{}
	for _, r := range rows {
		if _, ok := distMap[r.District]; !ok {
			distMap[r.District] = &distStat{counts: map[string]int{}}
			distOrder = append(distOrder, r.District)
		}
		distMap[r.District].counts[r.WattBucket] += r.LampCount
		distMap[r.District].total += r.LampCount
	}

	cityName := map[string]string{"taipei": "臺北市", "metrotaipei": "雙北"}[params.CityScope]
	var sb strings.Builder
	if params.District != "" {
		fmt.Fprintf(&sb, "【%s %s 路燈用電等級分布】\n", cityName, params.District)
	} else {
		fmt.Fprintf(&sb, "【%s 各行政區路燈用電等級分布】\n", cityName)
	}

	for _, dist := range distOrder {
		d := distMap[dist]
		fmt.Fprintf(&sb, "\n%s（共 %d 盞）\n", dist, d.total)
		for _, b := range bucketOrder {
			cnt := d.counts[b]
			pct := 0.0
			if d.total > 0 {
				pct = float64(cnt) / float64(d.total) * 100
			}
			fmt.Fprintf(&sb, "  %-10s %5d 盞（%4.1f%%）\n", bucketLabel[b], cnt, pct)
		}
	}
	return sb.String(), nil
}
