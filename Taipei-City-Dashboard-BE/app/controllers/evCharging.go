package controllers

import (
	"net/http"

	"TaipeiCityDashboardBE/app/models"

	"github.com/gin-gonic/gin"
)

/*
GetEVChargingMapData returns point-layer data for the EV charging station map.
GET /api/v1/component/ev-charging/map

Query params:
  - city_scope: "taipei" (default) or "twin_city"
*/
func GetEVChargingMapData(c *gin.Context) {
	cityScope := c.DefaultQuery("city_scope", "taipei")
	if cityScope != "taipei" && cityScope != "twin_city" {
		c.JSON(http.StatusBadRequest, gin.H{"status": "error", "message": "city_scope must be 'taipei' or 'twin_city'"})
		return
	}

	stations, err := models.GetEVChargingStations(cityScope)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"status": "error", "message": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"status": "success", "data": stations})
}
