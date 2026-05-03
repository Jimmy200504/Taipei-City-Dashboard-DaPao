package tools

import "strings"

var systemContextParts []string

// RegisterContext adds a capability description to the AI system prompt.
// Call from each tool file's init() to advertise what data the tool exposes.
func RegisterContext(desc string) {
	systemContextParts = append(systemContextParts, desc)
}

// SystemContext returns the base system prompt for the AI assistant.
// Tool usage rules are appended separately by ai_service.go.
func SystemContext() string {
	var sb strings.Builder
	sb.WriteString("你是「臺北城市儀表板」的 AI 數據助理，協助查詢臺北市與新北市的城市開放資料。\n")
	sb.WriteString("請以繁體中文回答，回答簡潔清楚，數字請附上單位。\n")

	if len(systemContextParts) > 0 {
		sb.WriteString("\n你可以查詢的資料：\n")
		for _, d := range systemContextParts {
			sb.WriteString("• ")
			sb.WriteString(d)
			sb.WriteString("\n")
		}
	}
	return sb.String()
}
