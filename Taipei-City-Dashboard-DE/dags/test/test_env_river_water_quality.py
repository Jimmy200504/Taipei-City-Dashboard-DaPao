import geopandas as gpd
import pandas as pd
from shapely.geometry import LineString

from proj_city_dashboard.env_river_water_quality.river_water_quality_lib import (
    GEOMETRY_SOURCE_REAL_RIVER,
    GEOMETRY_SOURCE_STRAIGHT_LINE,
    RPI_FLAG_COMPLETE,
    RPI_FLAG_INCOMPLETE,
    SOURCE_NAME,
    TARGET_CITIES,
    build_river_segments,
    map_risk_level,
    normalize_records,
    parse_month_date,
)


def test_parse_month_date_handles_western_year():
    assert parse_month_date("2026 年 3 月") == pd.Timestamp("2026-03-01").date()
    assert parse_month_date("2026年 12月") == pd.Timestamp("2026-12-01").date()


def test_parse_month_date_converts_roc_year():
    assert parse_month_date("115 年 3 月") == pd.Timestamp("2026-03-01").date()


def test_parse_month_date_returns_none_for_invalid():
    assert parse_month_date(None) is None
    assert parse_month_date("") is None
    assert parse_month_date("無資料") is None
    assert parse_month_date("2026 年 13 月") is None


def test_map_risk_level_covers_all_classifications():
    assert map_risk_level("未（稍）受污染") == ("unpolluted", 1, RPI_FLAG_COMPLETE)
    assert map_risk_level("未(稍)受污染") == ("unpolluted", 1, RPI_FLAG_COMPLETE)
    assert map_risk_level("輕度污染") == ("mild", 2, RPI_FLAG_COMPLETE)
    assert map_risk_level("中度污染") == ("moderate", 3, RPI_FLAG_COMPLETE)
    assert map_risk_level("嚴重污染") == ("severe", 4, RPI_FLAG_COMPLETE)
    assert map_risk_level("無檢測資料") == (None, None, RPI_FLAG_INCOMPLETE)
    assert map_risk_level(None) == (None, None, RPI_FLAG_INCOMPLETE)
    assert map_risk_level("") == (None, None, RPI_FLAG_INCOMPLETE)


def _moenv_record(**overrides):
    base = {
        "Station_ID": "1001",
        "Station_Name": "忠孝大橋",
        "Station_EName": "Zhongxiao Bridge",
        "River_ID": "11400011",
        "Station_Order": 1,
        "Basin_Name": "淡水河流域",
        "River_Name": "淡水河本流",
        "County_Name": TARGET_CITIES[0],
        "Town_Cname": "中正區",
        "Station_Address": "臺北市中正區",
        "測站使用狀態": "啟用",
        "Wqstd_Name": "丙",
        "Gis_X": "121.5002090",
        "Gis_Y": "25.0511440",
        "MonthDate_Dec": "2026 年 3 月",
        "WQ_Index": "6.50",
        "WQ_Index_Dec": "嚴重污染",
    }
    base.update(overrides)
    return base


def test_normalize_records_filters_and_maps_fields():
    records = [
        _moenv_record(),
        _moenv_record(
            Station_ID="2001", Station_Name="外縣市站", County_Name="桃園市",
            Gis_X="121.3", Gis_Y="25.0", WQ_Index="2.0", WQ_Index_Dec="輕度污染",
        ),
        _moenv_record(
            Station_ID="3001", Station_Name="缺資料站", County_Name=TARGET_CITIES[1],
            Gis_X="121.6", Gis_Y="25.0", WQ_Index="", WQ_Index_Dec="無檢測資料",
        ),
    ]

    sites_df, latest_df = normalize_records(records, "2026-04-01 00:00:00+08")

    assert sites_df["site_id"].tolist() == ["1001", "3001"]
    assert sites_df["city"].tolist() == list(TARGET_CITIES)
    assert sites_df["source_name"].unique().tolist() == [SOURCE_NAME]
    assert sites_df.iloc[0]["longitude"] == 121.5002090

    taipei = latest_df[latest_df["site_id"] == "1001"].iloc[0]
    assert taipei["rpi_value"] == 6.5
    assert taipei["risk_level"] == "severe"
    assert taipei["risk_level_order"] == 4
    assert taipei["rpi_flag"] == RPI_FLAG_COMPLETE
    assert taipei["sample_month"] == pd.Timestamp("2026-03-01").date()

    incomplete = latest_df[latest_df["site_id"] == "3001"].iloc[0]
    assert incomplete["rpi_flag"] == RPI_FLAG_INCOMPLETE
    assert pd.isna(incomplete["rpi_value"])
    assert incomplete["risk_level"] is None
    assert pd.isna(incomplete["risk_level_order"])


def test_normalize_records_handles_empty_input():
    sites_df, latest_df = normalize_records([], "2026-04-01 00:00:00+08")
    assert sites_df.empty
    assert latest_df.empty
    assert "site_id" in sites_df.columns
    assert "rpi_flag" in latest_df.columns


def _make_latest_row(**overrides):
    base = {
        "source_name": SOURCE_NAME,
        "city": TARGET_CITIES[0],
        "district": None,
        "basin": "淡水河流域",
        "river": "新店溪",
        "river_id": "RID-A",
        "station_order": 1,
        "site_id": "S1",
        "site_name": "S1站",
        "wq_std_grade": "丙",
        "sample_month": pd.Timestamp("2026-03-01").date(),
        "rpi_value": 3.0,
        "risk_level": "moderate",
        "risk_level_order": 3,
        "rpi_flag": RPI_FLAG_COMPLETE,
        "data_time": "2026-04-01 00:00:00+08",
        "longitude": 121.50,
        "latitude": 25.00,
    }
    base.update(overrides)
    return base


def test_build_river_segments_uses_real_river_geometry_and_handles_cross_city():
    latest_df = pd.DataFrame(
        [
            _make_latest_row(site_id="S1", site_name="上游", station_order=1, longitude=121.500, latitude=25.000, rpi_value=2.0, city="臺北市"),
            _make_latest_row(site_id="S2", site_name="中游", station_order=2, longitude=121.510, latitude=25.005, rpi_value=4.0, city="臺北市"),
            _make_latest_row(site_id="S3", site_name="下游", station_order=3, longitude=121.520, latitude=25.000, rpi_value=6.0, city="新北市"),
            _make_latest_row(site_id="S4", site_name="孤站", river="磺溪", river_id="RID-LONELY", station_order=1, longitude=121.60, latitude=25.18, rpi_value=1.5),
        ]
    )

    river_line = LineString(
        [
            (121.500, 25.000),
            (121.503, 25.003),
            (121.507, 25.005),
            (121.510, 25.005),
            (121.515, 25.003),
            (121.520, 25.000),
        ]
    )
    wra_gdf = gpd.GeoDataFrame(
        {"NAME": ["新店溪"]},
        geometry=[river_line],
        crs="EPSG:4326",
    )

    segments = build_river_segments(latest_df, wra_gdf)

    real = segments[segments["geometry_source"] == GEOMETRY_SOURCE_REAL_RIVER]
    assert len(real) == 2
    seg_ids = sorted(real["segment_id"].tolist())
    assert seg_ids == ["RID-A-S1-S2", "RID-A-S2-S3"]

    cross = real[real["segment_id"] == "RID-A-S2-S3"].iloc[0]
    assert cross["upstream_city"] == TARGET_CITIES[0]
    assert cross["downstream_city"] == TARGET_CITIES[1]
    assert cross["upstream_rpi"] == 4.0
    assert cross["downstream_rpi"] == 6.0
    assert cross["wkb_geometry"].geom_type == "LineString"
    assert len(cross["wkb_geometry"].coords) >= 2

    lonely = segments[segments["river_id"] == "RID-LONELY"]
    assert lonely.empty


def test_build_river_segments_falls_back_to_straight_line_when_river_missing():
    latest_df = pd.DataFrame(
        [
            _make_latest_row(site_id="S1", station_order=1, longitude=121.40, latitude=24.93, rpi_value=2.0),
            _make_latest_row(site_id="S2", station_order=2, longitude=121.42, latitude=24.94, rpi_value=4.0),
        ]
    )
    empty_wra = gpd.GeoDataFrame({"NAME": []}, geometry=[], crs="EPSG:4326")

    segments = build_river_segments(latest_df, empty_wra)

    assert len(segments) == 1
    row = segments.iloc[0]
    assert row["geometry_source"] == GEOMETRY_SOURCE_STRAIGHT_LINE
    assert row["wkb_geometry"].geom_type == "LineString"
    assert list(row["wkb_geometry"].coords) == [(121.40, 24.93), (121.42, 24.94)]


def test_build_river_segments_returns_empty_for_no_input():
    empty = pd.DataFrame()
    segments = build_river_segments(empty, None)
    assert segments.empty
    assert "segment_id" in segments.columns
