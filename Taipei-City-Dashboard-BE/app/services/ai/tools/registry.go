package tools

import (
	"context"
	"encoding/json"
	"fmt"
	"time"

	"github.com/tmc/langchaingo/llms"
)

// ToolFunc defines the signature for a tool function
type ToolFunc func(ctx context.Context, args string) (string, error)

const ToolGetCurrentTime = "get_current_time"

var (
	registry            = make(map[string]ToolFunc)
	definitionsRegistry []llms.Tool
)

func init() {
	Register(ToolGetCurrentTime, GetCurrentTime)
	RegisterDefinition(llms.Tool{
		Type: "function",
		Function: &llms.FunctionDefinition{
			Name:        ToolGetCurrentTime,
			Description: "取得目前台北時間。",
			Parameters: map[string]interface{}{
				"type":                 "object",
				"properties":           map[string]interface{}{},
				"additionalProperties": false,
			},
		},
	})
}

// Register adds a tool function to the registry
func Register(name string, fn ToolFunc) {
	registry[name] = fn
}

// RegisterDefinition adds a tool schema to the definitions registry.
// Call from each tool file's init() alongside Register().
func RegisterDefinition(tool llms.Tool) {
	definitionsRegistry = append(definitionsRegistry, tool)
}

// Execute calls a registered tool with the given arguments
func Execute(ctx context.Context, name string, args string) (string, error) {
	fn, ok := registry[name]
	if !ok {
		return "", fmt.Errorf("tool %s not found", name)
	}
	return fn(ctx, args)
}

// Definitions returns all registered tool schemas to expose to the model
func Definitions() []llms.Tool {
	return definitionsRegistry
}

// GetCurrentTime returns the current time in Asia/Taipei timezone
func GetCurrentTime(ctx context.Context, args string) (string, error) {
	loc, err := time.LoadLocation("Asia/Taipei")
	if err != nil {
		return time.Now().Format(time.RFC3339), nil
	}
	return time.Now().In(loc).Format("2006-01-02 15:04:05"), nil
}

// parseArgs unmarshals JSON tool arguments into a struct
func parseArgs(args string, v interface{}) error {
	return json.Unmarshal([]byte(args), v)
}
