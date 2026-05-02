const riverRiskLevelAliases = {
	unpolluted: "unpolluted",
	unpoluuted: "unpolluted",
	"未（稍）受污染": "unpolluted",
	"未(稍)受污染": "unpolluted",
	mild: "mild",
	"輕度污染": "mild",
	moderate: "moderate",
	"中度污染": "moderate",
	severe: "severe",
	"嚴重污染": "severe",
	incomplete: "incomplete",
	"無檢測資料": "incomplete",
};

const riverRiskLevels = {
	unpolluted: {
		label: "未（稍）受污染",
		range: "RPI <= 2.0",
	},
	mild: {
		label: "輕度污染",
		range: "2.0 < RPI <= 3.0",
	},
	moderate: {
		label: "中度污染",
		range: "3.1 <= RPI <= 6.0",
	},
	severe: {
		label: "嚴重污染",
		range: "RPI > 6.0",
	},
	incomplete: {
		label: "資料不足",
		range: "無有效 RPI",
	},
};

const riverGeometrySourceLabels = {
	curated_route: "人工檢核河道",
	real_river: "實際河道",
	straight_line: "直線示意",
};

const riverRiskKeys = new Set([
	"risk_level",
	"risk_level_raw",
	"WQ_Index_Dec",
]);

function getRiverRiskLevel(value) {
	return riverRiskLevels[riverRiskLevelAliases[value]];
}

export function formatRiverRiskLevel(value) {
	return getRiverRiskLevel(value)?.label || value;
}

export function getRiverRiskLevelDetail(value) {
	const riskLevel = getRiverRiskLevel(value);

	return riskLevel ? `${riskLevel.label}：${riskLevel.range}` : value;
}

export function formatRiverPopupValue(key, value) {
	if (value === null || value === undefined || value === "") {
		return "-";
	}

	if (riverRiskKeys.has(key)) {
		return getRiverRiskLevelDetail(value);
	}

	if (key === "geometry_source") {
		return riverGeometrySourceLabels[value] || value;
	}

	return value;
}
