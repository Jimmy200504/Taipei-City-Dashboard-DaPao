package models

import "encoding/json"

/* ----- Models ----- */

type EVChargingStation struct {
	StationID          string          `gorm:"column:station_id"           json:"station_id"`
	StationName        string          `gorm:"column:station_name"         json:"station_name"`
	City               string          `gorm:"column:city"                 json:"city"`
	District           string          `gorm:"column:district"             json:"district"`
	Address            string          `gorm:"column:address"              json:"address"`
	OperatorID         string          `gorm:"column:operator_id"          json:"operator_id"`
	OperationType      *int            `gorm:"column:operation_type"       json:"operation_type"`
	Spaces             *int            `gorm:"column:spaces"               json:"spaces"`
	ChargingPointCount *int            `gorm:"column:charging_point_count" json:"charging_point_count"`
	ConnectorCount     *int            `gorm:"column:connector_count"      json:"connector_count"`
	MaxPowerKw         *float64        `gorm:"column:max_power_kw"         json:"max_power_kw"`
	MaxPowerBucket     string          `gorm:"column:max_power_bucket"     json:"max_power_bucket"`
	PowerSummary       json.RawMessage `gorm:"column:power_summary"        json:"power_summary"`
	PowerDetail        json.RawMessage `gorm:"column:power_detail"         json:"power_detail"`
	ServiceTime        string          `gorm:"column:service_time"         json:"service_time"`
	ParkingRate        string          `gorm:"column:parking_rate"         json:"parking_rate"`
	ChargingRate       string          `gorm:"column:charging_rate"        json:"charging_rate"`
	SourceName         string          `gorm:"column:source_name"          json:"source_name"`
	DataTime           string          `gorm:"column:data_time"            json:"data_time"`
	Geometry           json.RawMessage `gorm:"column:geometry"             json:"geometry"`
}

/* ----- Handlers ----- */

// GetEVChargingStations returns station rows with GeoJSON geometry for the given city scope.
// cityScope accepts "taipei" or "twin_city".
func GetEVChargingStations(cityScope string) ([]EVChargingStation, error) {
	var stations []EVChargingStation

	query := DBDashboard.Table("env_ev_charging_stations").
		Select(`
			station_id,
			station_name,
			city,
			district,
			address,
			operator_id,
			operation_type,
			spaces,
			charging_point_count,
			connector_count,
			max_power_kw,
			max_power_bucket,
			power_summary,
			power_detail,
			service_time,
			parking_rate,
			charging_rate,
			source_name,
			data_time::text,
			ST_AsGeoJSON(wkb_geometry)::json AS geometry
		`).
		Where("wkb_geometry IS NOT NULL")

	switch cityScope {
	case "taipei":
		query = query.Where("city = ?", "臺北市")
	case "twin_city":
		query = query.Where("city IN ?", []string{"臺北市", "新北市"})
	}

	err := query.Scan(&stations).Error
	return stations, err
}
