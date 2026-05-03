package tools

import (
	"TaipeiCityDashboardBE/app/models"
	"context"
	"fmt"
	"time"

	"github.com/tmc/langchaingo/llms"
)

const ToolGetPopulationSummary = "get_population_summary"

func init() {
	Register(ToolGetPopulationSummary, GetPopulationSummary)
	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetPopulationSummary,
			Description: "查詢台北市或新北市指定年份的人口結構摘要。",
			Parameters: map[string]interface{}{
				"type": "object",
				"properties": map[string]interface{}{
					"city": map[string]interface{}{
						"type":        "string",
						"description": "城市代碼。台北市使用 taipei，新北市使用 new_taipei。",
						"enum":        []string{"taipei", "new_taipei"},
					},
					"year": map[string]interface{}{
						"type":        "integer",
						"description": "西元年份。",
					},
				},
				"required":             []string{"city", "year"},
				"additionalProperties": false,
			},
		},
	})
	RegisterContext("台北市／新北市各年份人口結構（幼年、青壯年、老年人口數）")
}

type PopulationArgs struct {
	City string `json:"city"`
	Year int    `json:"year"`
}

func GetPopulationSummary(ctx context.Context, args string) (string, error) {
	var params PopulationArgs
	if err := parseArgs(args, &params); err != nil {
		return "", fmt.Errorf("invalid arguments: %v", err)
	}

	tableName := "population_age_distribution_tpe"
	cityName := "台北市"
	if params.City == "new_taipei" {
		tableName = "population_age_distribution_new_tpe"
		cityName = "新北市"
	}

	var result struct {
		Year     int       `gorm:"column:year"`
		Young    int       `gorm:"column:young_population"`
		Working  int       `gorm:"column:working_age_population"`
		Elderly  int       `gorm:"column:elderly_population"`
		DataTime time.Time `gorm:"column:data_time"`
	}

	err := models.DBDashboard.Table(tableName).
		Where("year = ?", params.Year).
		Order("data_time DESC").
		First(&result).Error
	if err != nil {
		return "", fmt.Errorf("找不到 %s %d 年的人口統計資料: %v", cityName, params.Year, err)
	}

	return fmt.Sprintf(
		"【%d年 %s 人口結構概況】\n- 幼年人口 (0-14歲)：%d 人\n- 青壯年人口 (15-64歲)：%d 人\n- 老年人口 (65歲以上)：%d 人\n- 總人口：%d 人\n- 數據更新時間：%s",
		result.Year, cityName,
		result.Young, result.Working, result.Elderly,
		result.Young+result.Working+result.Elderly,
		result.DataTime.Format("2006-01-02"),
	), nil
}
