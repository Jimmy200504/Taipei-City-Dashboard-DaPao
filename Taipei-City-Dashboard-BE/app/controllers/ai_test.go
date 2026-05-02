package controllers

import (
	aitools "TaipeiCityDashboardBE/app/services/ai/tools"
	"testing"

	"github.com/tmc/langchaingo/llms"
)

func TestToCallOptionsInjectsServerOwnedTools(t *testing.T) {
	input := AIChatInput{}

	opts := applyCallOptions(input.ToCallOptions())

	if opts.ToolChoice != "auto" {
		t.Fatalf("ToolChoice = %v, want auto", opts.ToolChoice)
	}

	names := toolNames(opts.Tools)
	if !names[aitools.ToolGetCurrentTime] {
		t.Fatal("expected server-owned get_current_time tool to be injected")
	}
	if !names[aitools.ToolGetPopulationSummary] {
		t.Fatal("expected server-owned get_population_summary tool to be injected")
	}
}

func TestToCallOptionsIgnoresClientSuppliedTools(t *testing.T) {
	input := AIChatInput{
		Tools: []AIChatToolInput{
			{
				Type: "function",
				Function: AIChatToolFunctionInput{
					Name:        "client_supplied_tool",
					Description: "A tool that should never be trusted from the client",
					Parameters:  map[string]interface{}{"type": "object"},
				},
			},
		},
		ToolChoice: map[string]interface{}{
			"type": "function",
			"function": map[string]interface{}{
				"name": "client_supplied_tool",
			},
		},
	}

	opts := applyCallOptions(input.ToCallOptions())
	names := toolNames(opts.Tools)

	if names["client_supplied_tool"] {
		t.Fatal("client-supplied tool was forwarded to the model")
	}
	if opts.ToolChoice != "auto" {
		t.Fatalf("ToolChoice = %v, want server-owned auto", opts.ToolChoice)
	}
}

func applyCallOptions(options []llms.CallOption) llms.CallOptions {
	var opts llms.CallOptions
	for _, option := range options {
		option(&opts)
	}
	return opts
}

func toolNames(tools []llms.Tool) map[string]bool {
	names := make(map[string]bool, len(tools))
	for _, tool := range tools {
		if tool.Function != nil {
			names[tool.Function.Name] = true
		}
	}
	return names
}
