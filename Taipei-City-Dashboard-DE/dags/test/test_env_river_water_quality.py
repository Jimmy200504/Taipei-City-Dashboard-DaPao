from pathlib import Path

import geopandas as gpd
import pandas as pd
from shapely.geometry import LineString, Point

from proj_city_dashboard.env_river_water_quality.river_water_quality_lib import (
    DO_METHOD_DETAIL_ELECTRODE,
    DO_METHOD_DETAIL_TITRATION,
    DO_METHOD_EXT_ENDPOINT,
    GEOMETRY_SOURCE_CURATED_ROUTE,
    GEOMETRY_SOURCE_REAL_RIVER,
    GEOMETRY_SOURCE_STRAIGHT_LINE,
    RPI_FLAG_COMPLETE,
    RPI_FLAG_INCOMPLETE,
    RPI_METHOD_CALCULATED_FROM_ITEMS,
    RPI_METHOD_SOURCE_WQ_INDEX,
    SOURCE_LABEL_MOENV_EXT_RIVER,
    SOURCE_LABEL_MOENV_RIVER,
    SOURCE_NAME,
    TARGET_CITIES,
    build_river_segments,
    compute_rpi_from_items,
    enrich_ext_do_from_detail_pages,
    export_geojson_layers,
    load_curated_route_geodataframe,
    map_risk_level,
    map_rpi_to_risk_level,
    merge_normalized_frames,
    normalize_ext_records,
    normalize_records,
    parse_do_from_detail_html,
    parse_detail_page_year_month,
    parse_indicator_value,
    parse_month_date,
    score_bod5,
    score_do,
    score_nh3n,
    score_ss,
)
from proj_city_dashboard.env_river_water_quality.river_route_generation import (
    generate_route_features,
    synthesize_ext_station_ordering,
    write_route_geojson,
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
    assert taipei["source_label"] == SOURCE_LABEL_MOENV_RIVER
    assert taipei["rpi_method"] == RPI_METHOD_SOURCE_WQ_INDEX
    assert pd.isna(taipei["do_value"]) or taipei["do_value"] is None
    assert pd.isna(taipei["bod5_value"]) or taipei["bod5_value"] is None

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
        "source_label": SOURCE_LABEL_MOENV_RIVER,
        "rpi_method": RPI_METHOD_SOURCE_WQ_INDEX,
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
        "do_value": None,
        "bod5_value": None,
        "ss_value": None,
        "nh3n_value": None,
        "conductivity_value": None,
        "do_score": None,
        "bod5_score": None,
        "ss_score": None,
        "nh3n_score": None,
        "do_method": None,
        "data_time": "2026-04-01 00:00:00+08",
        "longitude": 121.50,
        "latitude": 25.00,
    }
    base.update(overrides)
    return base


def test_build_river_segments_uses_real_river_geometry_and_handles_cross_city():
    latest_df = pd.DataFrame(
        [
            _make_latest_row(
                site_id="S1",
                site_name="上游",
                station_order=1,
                longitude=121.500,
                latitude=25.000,
                rpi_value=2.0,
                city="臺北市",
            ),
            _make_latest_row(
                site_id="S2",
                site_name="中游",
                station_order=2,
                longitude=121.510,
                latitude=25.005,
                rpi_value=4.0,
                city="臺北市",
            ),
            _make_latest_row(
                site_id="S3",
                site_name="下游",
                station_order=3,
                longitude=121.520,
                latitude=25.000,
                rpi_value=6.0,
                city="新北市",
            ),
            _make_latest_row(
                site_id="S4",
                site_name="孤站",
                river="磺溪",
                river_id="RID-LONELY",
                station_order=1,
                longitude=121.60,
                latitude=25.18,
                rpi_value=1.5,
            ),
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


def test_build_river_segments_prefers_curated_route_geometry():
    latest_df = pd.DataFrame(
        [
            _make_latest_row(
                site_id="S1",
                station_order=1,
                longitude=121.40,
                latitude=24.93,
                rpi_value=2.0,
            ),
            _make_latest_row(
                site_id="S2",
                station_order=2,
                longitude=121.42,
                latitude=24.94,
                rpi_value=4.0,
            ),
        ]
    )
    route = LineString(
        [
            (121.40, 24.93),
            (121.405, 24.935),
            (121.415, 24.938),
            (121.42, 24.94),
        ]
    )
    route_gdf = gpd.GeoDataFrame(
        {
            "river_id": ["RID-A"],
            "upstream_site_id": ["S1"],
            "downstream_site_id": ["S2"],
        },
        geometry=[route],
        crs="EPSG:4326",
    )

    segments = build_river_segments(latest_df, wra_gdf=None, route_gdf=route_gdf)

    assert len(segments) == 1
    row = segments.iloc[0]
    assert row["geometry_source"] == GEOMETRY_SOURCE_CURATED_ROUTE
    assert list(row["wkb_geometry"].coords) == list(route.coords)


def test_build_river_segments_snaps_near_curated_route_endpoints_to_sites():
    latest_df = pd.DataFrame(
        [
            _make_latest_row(
                site_id="S1",
                station_order=1,
                longitude=121.40,
                latitude=24.93,
                rpi_value=2.0,
            ),
            _make_latest_row(
                site_id="S2",
                station_order=2,
                longitude=121.42,
                latitude=24.94,
                rpi_value=4.0,
            ),
        ]
    )
    route = LineString(
        [
            (121.401, 24.930),
            (121.405, 24.935),
            (121.415, 24.938),
            (121.419, 24.940),
        ]
    )
    route_gdf = gpd.GeoDataFrame(
        {"segment_id": ["RID-A-S1-S2"]},
        geometry=[route],
        crs="EPSG:4326",
    )

    segments = build_river_segments(latest_df, wra_gdf=None, route_gdf=route_gdf)

    coords = list(segments.iloc[0]["wkb_geometry"].coords)
    assert coords[0] == (121.40, 24.93)
    assert coords[-1] == (121.42, 24.94)


def test_build_river_segments_matches_curated_route_by_explicit_segment_id():
    latest_df = pd.DataFrame(
        [
            _make_latest_row(
                site_id="S1",
                station_order=1,
                longitude=121.40,
                latitude=24.93,
                rpi_value=2.0,
            ),
            _make_latest_row(
                site_id="S2",
                station_order=2,
                longitude=121.42,
                latitude=24.94,
                rpi_value=4.0,
            ),
        ]
    )
    route = LineString([(121.40, 24.93), (121.41, 24.945), (121.42, 24.94)])
    route_gdf = gpd.GeoDataFrame(
        {
            "segment_id": ["RID-A-S1-S2"],
            "river_id": ["WRONG-RIVER"],
            "upstream_site_id": ["WRONG-UP"],
            "downstream_site_id": ["WRONG-DOWN"],
        },
        geometry=[route],
        crs="EPSG:4326",
    )

    segments = build_river_segments(latest_df, wra_gdf=None, route_gdf=route_gdf)

    assert len(segments) == 1
    row = segments.iloc[0]
    assert row["geometry_source"] == GEOMETRY_SOURCE_CURATED_ROUTE
    assert list(row["wkb_geometry"].coords) == list(route.coords)


def test_load_curated_route_geodataframe_returns_none_when_asset_missing(tmp_path):
    missing_path = tmp_path / "missing.geojson"

    assert load_curated_route_geodataframe(str(missing_path)) is None


def test_curated_route_asset_uses_dense_centerline_for_tamsui_river():
    route_path = (
        Path(__file__).resolve().parents[1]
        / "proj_city_dashboard"
        / "env_river_water_quality"
        / "assets"
        / "river_segment_routes.geojson"
    )

    routes = load_curated_route_geodataframe(str(route_path))
    tamsui = routes[
        (routes["river_id"] == "11400011")
        & (routes["upstream_site_id"] == "1001")
        & (routes["downstream_site_id"] == "1002")
    ].iloc[0]

    assert len(tamsui.geometry.coords) >= 10


def test_curated_route_asset_covers_current_metrotaipei_segments():
    route_path = (
        Path(__file__).resolve().parents[1]
        / "proj_city_dashboard"
        / "env_river_water_quality"
        / "assets"
        / "river_segment_routes.geojson"
    )

    routes = load_curated_route_geodataframe(str(route_path))
    segment_ids = {
        f"{row.river_id}-{row.upstream_site_id}-{row.downstream_site_id}"
        for row in routes.itertuples()
    }

    assert len(segment_ids) >= 29
    assert "11402311-1024-1274" in segment_ids


def test_export_geojson_layers_omits_sites_without_visible_segments(tmp_path):
    latest_gdf = gpd.GeoDataFrame(
        [
            {
                "site_id": "S1",
                "site_name": "Connected A",
                "city": TARGET_CITIES[0],
                "district": None,
                "basin": "Test basin",
                "river": "Test river",
                "wq_std_grade": "丙",
                "sample_month": pd.Timestamp("2026-03-01").date(),
                "rpi_value": 2.0,
                "risk_level": "mild",
                "rpi_flag": RPI_FLAG_COMPLETE,
                "source_name": SOURCE_NAME,
                "data_time": "2026-04-01 00:00:00+08",
                "wkb_geometry": Point(121.50, 25.00),
            },
            {
                "site_id": "S2",
                "site_name": "Connected B",
                "city": TARGET_CITIES[0],
                "district": None,
                "basin": "Test basin",
                "river": "Test river",
                "wq_std_grade": "丙",
                "sample_month": pd.Timestamp("2026-03-01").date(),
                "rpi_value": 3.0,
                "risk_level": "moderate",
                "rpi_flag": RPI_FLAG_COMPLETE,
                "source_name": SOURCE_NAME,
                "data_time": "2026-04-01 00:00:00+08",
                "wkb_geometry": Point(121.51, 25.01),
            },
            {
                "site_id": "S3",
                "site_name": "Isolated",
                "city": TARGET_CITIES[0],
                "district": None,
                "basin": "Test basin",
                "river": "Test river",
                "wq_std_grade": "丙",
                "sample_month": pd.Timestamp("2026-03-01").date(),
                "rpi_value": None,
                "risk_level": None,
                "rpi_flag": RPI_FLAG_INCOMPLETE,
                "source_name": SOURCE_NAME,
                "data_time": "2026-04-01 00:00:00+08",
                "wkb_geometry": Point(121.52, 25.02),
            },
        ],
        geometry="wkb_geometry",
        crs="EPSG:4326",
    )
    segments_gdf = gpd.GeoDataFrame(
        [
            {
                "segment_id": "RID-S1-S2",
                "river_id": "RID",
                "river": "Test river",
                "basin": "Test basin",
                "upstream_site_id": "S1",
                "upstream_site_name": "Connected A",
                "upstream_city": TARGET_CITIES[0],
                "upstream_rpi": 2.0,
                "downstream_site_id": "S2",
                "downstream_site_name": "Connected B",
                "downstream_city": TARGET_CITIES[0],
                "downstream_rpi": 3.0,
                "sample_month": pd.Timestamp("2026-03-01").date(),
                "geometry_source": GEOMETRY_SOURCE_CURATED_ROUTE,
                "data_time": "2026-04-01 00:00:00+08",
                "wkb_geometry": LineString([(121.50, 25.00), (121.51, 25.01)]),
            }
        ],
        geometry="wkb_geometry",
        crs="EPSG:4326",
    )

    export_geojson_layers(latest_gdf, segments_gdf, out_dir=str(tmp_path))

    sites = gpd.read_file(tmp_path / "env_river_sites_taipei.geojson")
    assert sorted(sites["site_id"].tolist()) == ["S1", "S2"]


def test_export_geojson_layers_omits_segments_far_from_site_endpoint(tmp_path):
    latest_gdf = gpd.GeoDataFrame(
        [
            {
                "site_id": "S1",
                "site_name": "Connected A",
                "city": TARGET_CITIES[0],
                "district": None,
                "basin": "Test basin",
                "river": "Test river",
                "wq_std_grade": "丙",
                "sample_month": pd.Timestamp("2026-03-01").date(),
                "rpi_value": 2.0,
                "risk_level": "mild",
                "rpi_flag": RPI_FLAG_COMPLETE,
                "source_name": SOURCE_NAME,
                "data_time": "2026-04-01 00:00:00+08",
                "wkb_geometry": Point(121.50, 25.00),
            },
            {
                "site_id": "S2",
                "site_name": "Disconnected B",
                "city": TARGET_CITIES[0],
                "district": None,
                "basin": "Test basin",
                "river": "Test river",
                "wq_std_grade": "丙",
                "sample_month": pd.Timestamp("2026-03-01").date(),
                "rpi_value": 3.0,
                "risk_level": "moderate",
                "rpi_flag": RPI_FLAG_COMPLETE,
                "source_name": SOURCE_NAME,
                "data_time": "2026-04-01 00:00:00+08",
                "wkb_geometry": Point(121.60, 25.10),
            },
        ],
        geometry="wkb_geometry",
        crs="EPSG:4326",
    )
    segments_gdf = gpd.GeoDataFrame(
        [
            {
                "segment_id": "RID-S1-S2",
                "river_id": "RID",
                "river": "Test river",
                "basin": "Test basin",
                "upstream_site_id": "S1",
                "upstream_site_name": "Connected A",
                "upstream_city": TARGET_CITIES[0],
                "upstream_rpi": 2.0,
                "downstream_site_id": "S2",
                "downstream_site_name": "Disconnected B",
                "downstream_city": TARGET_CITIES[0],
                "downstream_rpi": 3.0,
                "sample_month": pd.Timestamp("2026-03-01").date(),
                "geometry_source": GEOMETRY_SOURCE_CURATED_ROUTE,
                "data_time": "2026-04-01 00:00:00+08",
                "wkb_geometry": LineString([(121.50, 25.00), (121.51, 25.01)]),
            }
        ],
        geometry="wkb_geometry",
        crs="EPSG:4326",
    )

    export_geojson_layers(latest_gdf, segments_gdf, out_dir=str(tmp_path))

    sites = gpd.read_file(tmp_path / "env_river_sites_taipei.geojson")
    segments = gpd.read_file(tmp_path / "env_river_segments_taipei.geojson")
    assert sites.empty
    assert segments.empty


def test_build_river_segments_falls_back_to_straight_line_when_river_missing():
    latest_df = pd.DataFrame(
        [
            _make_latest_row(
                site_id="S1",
                station_order=1,
                longitude=121.40,
                latitude=24.93,
                rpi_value=2.0,
            ),
            _make_latest_row(
                site_id="S2",
                station_order=2,
                longitude=121.42,
                latitude=24.94,
                rpi_value=4.0,
            ),
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


def test_generate_route_features_builds_connected_osm_route(tmp_path):
    latest_df = pd.DataFrame(
        [
            _make_latest_row(
                site_id="S1",
                station_order=1,
                longitude=121.500,
                latitude=25.000,
                rpi_value=2.0,
            ),
            _make_latest_row(
                site_id="S2",
                station_order=2,
                longitude=121.530,
                latitude=25.000,
                rpi_value=4.0,
            ),
        ]
    )
    waterways = gpd.GeoDataFrame(
        {"name": ["Test River"]},
        geometry=[
            LineString(
                [
                    (121.501, 25.000),
                    (121.510, 25.003),
                    (121.520, 25.002),
                    (121.529, 25.000),
                ]
            )
        ],
        crs="EPSG:4326",
    )

    route_gdf, report = generate_route_features(latest_df, waterways)

    assert report["generated"] == 1
    assert report["missing"] == []
    route = route_gdf.iloc[0]
    assert route["segment_id"] == "RID-A-S1-S2"
    assert route["river_id"] == "RID-A"
    assert route["upstream_site_id"] == "S1"
    assert route["downstream_site_id"] == "S2"
    assert list(route.geometry.coords)[0] == (121.500, 25.000)
    assert list(route.geometry.coords)[-1] == (121.530, 25.000)
    assert len(route.geometry.coords) == 4

    out_path = tmp_path / "routes.geojson"
    write_route_geojson(route_gdf, out_path)
    saved = gpd.read_file(out_path)
    assert saved["segment_id"].tolist() == ["RID-A-S1-S2"]


def test_generate_route_features_reports_missing_for_far_station():
    latest_df = pd.DataFrame(
        [
            _make_latest_row(
                site_id="S1",
                station_order=1,
                longitude=121.500,
                latitude=25.000,
                rpi_value=2.0,
            ),
            _make_latest_row(
                site_id="S2",
                station_order=2,
                longitude=121.900,
                latitude=25.400,
                rpi_value=4.0,
            ),
        ]
    )
    waterways = gpd.GeoDataFrame(
        {"name": ["Test River"]},
        geometry=[LineString([(121.501, 25.000), (121.530, 25.000)])],
        crs="EPSG:4326",
    )

    route_gdf, report = generate_route_features(
        latest_df,
        waterways,
        max_station_distance_m=500.0,
    )

    assert route_gdf.empty
    assert report["generated"] == 0
    assert len(report["missing"]) == 1
    missing = report["missing"][0]
    assert missing["segment_id"] == "RID-A-S1-S2"
    assert missing["reason"] == "station_too_far_from_waterway"
    assert missing["upstream_distance_m"] < 500.0
    assert missing["downstream_distance_m"] > 500.0


def test_parse_indicator_value_handles_special_tokens():
    import math

    assert parse_indicator_value(None) is None
    assert parse_indicator_value("") is None
    assert parse_indicator_value("  ") is None
    assert parse_indicator_value("－") is None
    assert parse_indicator_value("-") is None
    assert parse_indicator_value("N/A") is None
    assert parse_indicator_value("<0.02") == 0.0
    assert parse_indicator_value("<1.0") == 0.0
    assert parse_indicator_value("3.5") == 3.5
    assert parse_indicator_value(7) == 7.0
    assert parse_indicator_value(math.nan) is None
    assert parse_indicator_value(pd.NA) is None


def test_scoring_functions_treat_nan_as_missing():
    import math

    for fn in (score_do, score_bod5, score_ss, score_nh3n):
        assert fn(math.nan) is None
        assert fn(pd.NA) is None


def test_normalize_ext_records_marks_all_null_indicators_as_incomplete():
    records = [
        {
            "SiteID": 686,
            "ChtName": "全空站",
            "EngName": None,
            "SiteMgt_ID": 25,
            "New_County_Cname": TARGET_CITIES[1],
            "Unit_Cname": "新北市政府環境保護局",
            "Basin_Name": "基隆河",
            "Coord_Type": "WGS84",
            "Gis_X": 121.5,
            "Gis_Y": 25.1,
            "MonthDate_Dec": "近期無檢測資料",
            "Id_204": None,
            "Id_206": None,
            "Id_202": None,
            "Id_209": None,
            "Id_107": None,
        }
    ]
    _, latest_df = normalize_ext_records(records, "2026-04-01 00:00:00+08")

    row = latest_df.iloc[0]
    assert row["rpi_flag"] == RPI_FLAG_INCOMPLETE
    assert row["risk_level"] is None
    assert pd.isna(row["risk_level_order"])
    assert pd.isna(row["rpi_value"]) or row["rpi_value"] is None
    assert row["do_score"] is None
    assert row["bod5_score"] is None


def test_score_do_threshold_boundaries():
    assert score_do(None) is None
    assert score_do(6.5) == 1
    assert score_do(7.0) == 1
    assert score_do(6.49) == 3
    assert score_do(4.6) == 3
    assert score_do(4.59) == 6
    assert score_do(2.0) == 6
    assert score_do(1.99) == 10


def test_score_bod5_threshold_boundaries():
    assert score_bod5(None) is None
    assert score_bod5(0.5) == 1
    assert score_bod5(3.0) == 1
    assert score_bod5(3.1) == 3
    assert score_bod5(4.9) == 3
    assert score_bod5(5.0) == 6
    assert score_bod5(15.0) == 6
    assert score_bod5(15.01) == 10


def test_score_ss_threshold_boundaries():
    assert score_ss(None) is None
    assert score_ss(0) == 1
    assert score_ss(20) == 1
    assert score_ss(20.5) == 3
    assert score_ss(49.9) == 3
    assert score_ss(50) == 6
    assert score_ss(100) == 6
    assert score_ss(100.1) == 10


def test_score_nh3n_threshold_boundaries():
    assert score_nh3n(None) is None
    assert score_nh3n(0.50) == 1
    assert score_nh3n(0.51) == 3
    assert score_nh3n(0.99) == 3
    assert score_nh3n(1.00) == 6
    assert score_nh3n(3.00) == 6
    assert score_nh3n(3.01) == 10


def test_compute_rpi_from_items_averages_scores_when_complete():
    rpi, scores, complete = compute_rpi_from_items(do=7.0, bod5=2.0, ss=10, nh3n=0.4)
    assert complete is True
    assert rpi == 1.0
    assert scores == {
        "do_score": 1,
        "bod5_score": 1,
        "ss_score": 1,
        "nh3n_score": 1,
    }


def test_compute_rpi_from_items_marks_incomplete_when_any_missing():
    rpi, scores, complete = compute_rpi_from_items(do=None, bod5=2.0, ss=10, nh3n=0.4)
    assert complete is False
    assert rpi is None
    assert scores["do_score"] is None
    assert scores["bod5_score"] == 1


def test_map_rpi_to_risk_level_thresholds():
    assert map_rpi_to_risk_level(None) == (None, None)
    assert map_rpi_to_risk_level(2.0) == ("unpolluted", 1)
    assert map_rpi_to_risk_level(2.01) == ("mild", 2)
    assert map_rpi_to_risk_level(3.0) == ("mild", 2)
    assert map_rpi_to_risk_level(3.01) == ("moderate", 3)
    assert map_rpi_to_risk_level(6.0) == ("moderate", 3)
    assert map_rpi_to_risk_level(6.01) == ("severe", 4)


def _ext_record(**overrides):
    base = {
        "SiteID": 1,
        "ChtName": "靈山宮",
        "EngName": "",
        "SiteMgt_ID": 25,
        "New_County_Cname": TARGET_CITIES[1],
        "Unit_Cname": "新北市政府環境保護局",
        "Basin_Name": "水仙溪",
        "Coord_Type": "WGS84",
        "Gis_X": 121.394500,
        "Gis_Y": 25.083611,
        "MonthDate_Dec": "2026 年 3 月",
        "Id_204": "7.0",
        "Id_206": "2.0",
        "Id_202": "10",
        "Id_209": "0.4",
        "Id_107": "301",
    }
    base.update(overrides)
    return base


def test_normalize_ext_records_filters_target_cities_and_prefixes_ids():
    records = [
        _ext_record(),
        _ext_record(
            SiteID=42,
            SiteMgt_ID=99,
            New_County_Cname="桃園市",
        ),
    ]

    sites_df, latest_df = normalize_ext_records(records, "2026-04-01 00:00:00+08")

    assert sites_df["site_id"].tolist() == ["ext:25:1"]
    assert sites_df["source_label"].iloc[0] == SOURCE_LABEL_MOENV_EXT_RIVER
    assert sites_df["river"].iloc[0] == "水仙溪"

    latest = latest_df.iloc[0]
    assert latest["site_id"] == "ext:25:1"
    assert latest["rpi_method"] == RPI_METHOD_CALCULATED_FROM_ITEMS
    assert latest["do_value"] == 7.0
    assert latest["bod5_value"] == 2.0
    assert latest["ss_value"] == 10
    assert latest["nh3n_value"] == 0.4
    assert latest["conductivity_value"] == 301
    assert latest["do_score"] == 1
    assert latest["rpi_value"] == 1.0
    assert latest["risk_level"] == "unpolluted"
    assert latest["rpi_flag"] == RPI_FLAG_COMPLETE
    assert latest["sample_month"] == pd.Timestamp("2026-03-01").date()


def test_normalize_ext_records_marks_incomplete_when_indicator_missing():
    records = [
        _ext_record(SiteID=2, Id_204="－"),
    ]
    sites_df, latest_df = normalize_ext_records(records, "2026-04-01 00:00:00+08")

    latest = latest_df.iloc[0]
    assert latest["rpi_flag"] == RPI_FLAG_INCOMPLETE
    assert pd.isna(latest["rpi_value"]) or latest["rpi_value"] is None
    assert latest["risk_level"] is None
    assert pd.isna(latest["risk_level_order"])
    assert latest["do_value"] is None
    assert latest["do_score"] is None
    assert latest["bod5_value"] == 2.0
    assert latest["bod5_score"] == 1


def test_normalize_ext_records_treats_lt_values_as_zero_in_rpi():
    records = [
        _ext_record(SiteID=3, Id_209="<0.02"),
    ]
    _, latest_df = normalize_ext_records(records, "2026-04-01 00:00:00+08")

    latest = latest_df.iloc[0]
    assert latest["nh3n_value"] == 0.0
    assert latest["nh3n_score"] == 1
    assert latest["rpi_flag"] == RPI_FLAG_COMPLETE


def test_normalize_ext_records_skips_non_wgs84_coords():
    records = [
        _ext_record(SiteID=4, Coord_Type="TWD97", Gis_X=300000, Gis_Y=2700000),
        _ext_record(SiteID=5, Coord_Type="WGS84"),
    ]
    sites_df, _ = normalize_ext_records(records, "2026-04-01 00:00:00+08")

    assert sites_df["site_id"].tolist() == ["ext:25:5"]


def test_normalize_ext_records_handles_empty_input():
    sites_df, latest_df = normalize_ext_records([], "2026-04-01 00:00:00+08")
    assert sites_df.empty
    assert latest_df.empty
    assert "site_id" in sites_df.columns
    assert "do_value" in latest_df.columns


def test_merge_normalized_frames_avoids_id_collisions_between_sources():
    moenv_records = [
        _moenv_record(Station_ID="1"),
    ]
    ext_records = [
        _ext_record(SiteID=1, SiteMgt_ID=25),
    ]
    o_sites, o_latest = normalize_records(moenv_records, "2026-04-01 00:00:00+08")
    e_sites, e_latest = normalize_ext_records(ext_records, "2026-04-01 00:00:00+08")

    sites, latest = merge_normalized_frames([o_sites, e_sites], [o_latest, e_latest])

    assert set(sites["site_id"]) == {"1", "ext:25:1"}
    assert set(latest["site_id"]) == {"1", "ext:25:1"}
    assert set(sites["source_label"]) == {
        SOURCE_LABEL_MOENV_RIVER,
        SOURCE_LABEL_MOENV_EXT_RIVER,
    }


def test_export_geojson_omits_ext_sites_without_segments(tmp_path):
    latest_gdf = gpd.GeoDataFrame(
        [
            {
                "site_id": "ext:25:1",
                "site_name": "Ext station",
                "city": TARGET_CITIES[0],
                "district": None,
                "basin": "Test basin",
                "river": "Test river",
                "wq_std_grade": None,
                "sample_month": pd.Timestamp("2026-03-01").date(),
                "rpi_value": 2.5,
                "risk_level": "mild",
                "rpi_flag": RPI_FLAG_COMPLETE,
                "source_name": SOURCE_NAME,
                "source_label": SOURCE_LABEL_MOENV_EXT_RIVER,
                "rpi_method": RPI_METHOD_CALCULATED_FROM_ITEMS,
                "data_time": "2026-04-01 00:00:00+08",
                "do_value": 7.0,
                "bod5_value": 2.0,
                "ss_value": 10,
                "nh3n_value": 0.4,
                "conductivity_value": 301,
                "do_score": 1,
                "bod5_score": 1,
                "ss_score": 1,
                "nh3n_score": 1,
                "wkb_geometry": Point(121.50, 25.00),
            }
        ],
        geometry="wkb_geometry",
        crs="EPSG:4326",
    )

    export_geojson_layers(latest_gdf, segments_gdf=None, out_dir=str(tmp_path))

    sites = gpd.read_file(tmp_path / "env_river_sites_taipei.geojson")
    assert sites.empty


def _detail_html(
    *,
    year="2026",
    month="03",
    electrode=None,
    titration=None,
):
    """Build a minimal HTML stub mirroring the MOENV detail-page structure."""
    import html as _html

    cards = []
    if electrode is not None:
        cards.append(
            f'<dl class="dataCardWrap"><dt>溶氧(電極法)<span>mg/L</span></dt>'
            f'<dd>{_html.escape(str(electrode))}</dd></dl>'
        )
    if titration is not None:
        cards.append(
            f'<dl class="dataCardWrap"><dt>溶氧(滴定法)<span>mg/L</span></dt>'
            f'<dd>{_html.escape(str(titration))}</dd></dl>'
        )
    cards_html = "".join(cards)
    year_options = "".join(
        f'<option value="{y}"{" selected" if y == year else ""}>{y}</option>'
        for y in ("2024", "2025", "2026")
    )
    month_options = "".join(
        f'<option value="{m:02d}"{" selected" if f"{m:02d}" == month else ""}>{m:02d}</option>'
        for m in range(1, 13)
    )
    return (
        '<html><body>'
        '<form>'
        f'<select name="ctl00$CPH1$ddl_Year">{year_options}</select>'
        f'<select name="ctl00$CPH1$ddl_Month">{month_options}</select>'
        '</form>'
        f'<div class="dataCards clearfix">{cards_html}</div>'
        '</body></html>'
    )


def test_parse_do_from_detail_html_prefers_electrode():
    html_text = _detail_html(electrode="8.2", titration="7.4")
    value, method = parse_do_from_detail_html(html_text)
    assert value == 8.2
    assert method == DO_METHOD_DETAIL_ELECTRODE


def test_parse_do_from_detail_html_falls_back_to_titration():
    html_text = _detail_html(electrode=None, titration="7.4")
    value, method = parse_do_from_detail_html(html_text)
    assert value == 7.4
    assert method == DO_METHOD_DETAIL_TITRATION


def test_parse_do_from_detail_html_handles_missing_or_dash():
    html_text = _detail_html(electrode="－", titration="")
    value, method = parse_do_from_detail_html(html_text)
    assert value is None
    assert method is None


def test_parse_do_from_detail_html_treats_lt_as_zero():
    html_text = _detail_html(electrode=None, titration="<0.5")
    value, method = parse_do_from_detail_html(html_text)
    assert value == 0.0
    assert method == DO_METHOD_DETAIL_TITRATION


def test_parse_detail_page_year_month_reads_selected_dropdown():
    html_text = _detail_html(year="2026", month="03")
    assert parse_detail_page_year_month(html_text) == (2026, 3)


def test_normalize_ext_records_sets_do_method_ext_endpoint_when_present():
    sites_df, latest_df = normalize_ext_records(
        [_ext_record()], "2026-04-01 00:00:00+08"
    )
    assert latest_df.iloc[0]["do_method"] == DO_METHOD_EXT_ENDPOINT


def test_normalize_ext_records_leaves_do_method_null_when_id_204_missing():
    _, latest_df = normalize_ext_records(
        [_ext_record(SiteID=2, Id_204="－")], "2026-04-01 00:00:00+08"
    )
    assert latest_df.iloc[0]["do_method"] is None


def test_enrich_ext_do_from_detail_pages_fills_missing_do():
    incomplete = _ext_record(
        SiteID=99,
        SiteMgt_ID=25,
        Id_204="－",
        Id_206="2.0",
        Id_202="10",
        Id_209="0.4",
    )
    _, latest_df = normalize_ext_records([incomplete], "2026-04-01 00:00:00+08")
    assert latest_df.iloc[0]["rpi_flag"] == RPI_FLAG_INCOMPLETE
    assert pd.isna(latest_df.iloc[0]["rpi_value"]) or latest_df.iloc[0]["rpi_value"] is None

    calls = []

    def fake_fetch(site_id, mgmt_id):
        calls.append((site_id, mgmt_id))
        return _detail_html(year="2026", month="03", electrode="7.0", titration="6.5")

    enriched = enrich_ext_do_from_detail_pages(latest_df, fetch_fn=fake_fetch)

    assert calls == [("99", "25")]
    row = enriched.iloc[0]
    assert row["do_value"] == 7.0
    assert row["do_method"] == DO_METHOD_DETAIL_ELECTRODE
    assert row["do_score"] == 1
    assert row["rpi_value"] == 1.0
    assert row["risk_level"] == "unpolluted"
    assert row["rpi_flag"] == RPI_FLAG_COMPLETE


def test_enrich_ext_do_skips_when_page_month_does_not_match_sample():
    incomplete = _ext_record(SiteID=99, SiteMgt_ID=25, Id_204="－")
    _, latest_df = normalize_ext_records([incomplete], "2026-04-01 00:00:00+08")

    def fake_fetch(site_id, mgmt_id):
        return _detail_html(year="2002", month="02", electrode="9.0")

    enriched = enrich_ext_do_from_detail_pages(latest_df, fetch_fn=fake_fetch)
    row = enriched.iloc[0]
    assert pd.isna(row["do_value"]) or row["do_value"] is None
    assert row["do_method"] is None
    assert row["rpi_flag"] == RPI_FLAG_INCOMPLETE


def test_enrich_ext_do_skips_rows_with_all_indicators_missing():
    barren = {
        "SiteID": 686,
        "ChtName": "全空站",
        "EngName": None,
        "SiteMgt_ID": 25,
        "New_County_Cname": TARGET_CITIES[1],
        "Unit_Cname": "新北市政府環境保護局",
        "Basin_Name": "基隆河",
        "Coord_Type": "WGS84",
        "Gis_X": 121.5,
        "Gis_Y": 25.1,
        "MonthDate_Dec": "近期無檢測資料",
        "Id_204": None,
        "Id_206": None,
        "Id_202": None,
        "Id_209": None,
        "Id_107": None,
    }
    _, latest_df = normalize_ext_records([barren], "2026-04-01 00:00:00+08")

    calls = []

    def fake_fetch(site_id, mgmt_id):
        calls.append((site_id, mgmt_id))
        return _detail_html(electrode="8.0")

    enriched = enrich_ext_do_from_detail_pages(latest_df, fetch_fn=fake_fetch)

    assert calls == []
    assert enriched.iloc[0]["rpi_flag"] == RPI_FLAG_INCOMPLETE


def test_enrich_ext_do_keeps_row_unchanged_on_fetch_error():
    import requests

    incomplete = _ext_record(SiteID=99, SiteMgt_ID=25, Id_204="－")
    _, latest_df = normalize_ext_records([incomplete], "2026-04-01 00:00:00+08")

    def boom(site_id, mgmt_id):
        raise requests.RequestException("boom")

    enriched = enrich_ext_do_from_detail_pages(latest_df, fetch_fn=boom)
    row = enriched.iloc[0]
    assert pd.isna(row["do_value"]) or row["do_value"] is None
    assert row["do_method"] is None
    assert row["rpi_flag"] == RPI_FLAG_INCOMPLETE


def _ext_latest_row(*, site_id, basin, longitude, latitude, rpi_value=2.0, **overrides):
    """Build a synthetic Ext-source latest row for segment-builder tests."""
    base = {
        "source_name": SOURCE_NAME,
        "source_label": SOURCE_LABEL_MOENV_EXT_RIVER,
        "rpi_method": RPI_METHOD_CALCULATED_FROM_ITEMS,
        "city": TARGET_CITIES[0],
        "district": None,
        "basin": basin,
        "river": basin,
        "river_id": None,
        "station_order": pd.NA,
        "site_id": site_id,
        "site_name": site_id,
        "wq_std_grade": None,
        "sample_month": pd.Timestamp("2026-03-01").date(),
        "rpi_value": rpi_value,
        "risk_level": "mild",
        "risk_level_order": 2,
        "rpi_flag": RPI_FLAG_COMPLETE,
        "do_value": 7.0,
        "bod5_value": 2.0,
        "ss_value": 10,
        "nh3n_value": 0.4,
        "conductivity_value": 300,
        "do_score": 1,
        "bod5_score": 1,
        "ss_score": 1,
        "nh3n_score": 1,
        "do_method": DO_METHOD_EXT_ENDPOINT,
        "data_time": "2026-04-01 00:00:00+08",
        "longitude": longitude,
        "latitude": latitude,
    }
    base.update(overrides)
    return base


def test_build_river_segments_generates_segments_for_ext_stations_along_wra():
    latest_df = pd.DataFrame(
        [
            _ext_latest_row(
                site_id="ext:25:1", basin="北勢溪",
                longitude=121.700, latitude=24.910, rpi_value=2.0,
            ),
            _ext_latest_row(
                site_id="ext:25:2", basin="北勢溪",
                longitude=121.710, latitude=24.913, rpi_value=4.0,
            ),
            _ext_latest_row(
                site_id="ext:25:3", basin="北勢溪",
                longitude=121.720, latitude=24.915, rpi_value=6.0,
            ),
        ]
    )
    river_line = LineString(
        [
            (121.700, 24.910),
            (121.705, 24.911),
            (121.710, 24.913),
            (121.715, 24.914),
            (121.720, 24.915),
        ]
    )
    wra_gdf = gpd.GeoDataFrame(
        {"NAME": ["北勢溪"]}, geometry=[river_line], crs="EPSG:4326"
    )

    segments = build_river_segments(latest_df, wra_gdf)

    assert len(segments) == 2
    seg_ids = sorted(segments["segment_id"].tolist())
    assert seg_ids == [
        "ext-river:北勢溪-ext:25:1-ext:25:2",
        "ext-river:北勢溪-ext:25:2-ext:25:3",
    ]
    real = segments[segments["geometry_source"] == GEOMETRY_SOURCE_REAL_RIVER]
    assert len(real) == 2
    first = segments[
        segments["segment_id"].str.endswith("ext:25:1-ext:25:2")
    ].iloc[0]
    assert first["upstream_rpi"] == 2.0
    assert first["downstream_rpi"] == 4.0


def test_build_river_segments_falls_back_to_straight_lines_for_ext_basins_without_wra_match():
    latest_df = pd.DataFrame(
        [
            _ext_latest_row(
                site_id="ext:25:1947", site_name="老梅溪取水口", basin="老梅溪",
                longitude=121.552919444444441, latitude=25.261388888888888,
            ),
            _ext_latest_row(
                site_id="ext:25:30", site_name="大溪墘橋", basin="老梅溪",
                longitude=121.550638888888884, latitude=25.275061111111111,
            ),
            _ext_latest_row(
                site_id="ext:25:31", site_name="二十三號橋", basin="老梅溪",
                longitude=121.547169444444449, latitude=25.289219444444445,
            ),
        ]
    )
    wra_gdf = gpd.GeoDataFrame(
        {"NAME": ["不相干河"]},
        geometry=[LineString([(120.0, 24.0), (120.1, 24.1)])],
        crs="EPSG:4326",
    )

    segments = build_river_segments(latest_df, wra_gdf)
    assert len(segments) == 2
    assert segments["segment_id"].tolist() == [
        "ext-river:老梅溪-ext:25:1947-ext:25:30",
        "ext-river:老梅溪-ext:25:30-ext:25:31",
    ]
    assert segments["geometry_source"].tolist() == [
        GEOMETRY_SOURCE_STRAIGHT_LINE,
        GEOMETRY_SOURCE_STRAIGHT_LINE,
    ]


def test_build_river_segments_orders_ext_stations_by_projection_position():
    latest_df = pd.DataFrame(
        [
            _ext_latest_row(
                site_id="ext:25:DOWN", basin="新店溪",
                longitude=121.520, latitude=25.000, rpi_value=6.0,
            ),
            _ext_latest_row(
                site_id="ext:25:UP", basin="新店溪",
                longitude=121.500, latitude=25.000, rpi_value=2.0,
            ),
        ]
    )
    river_line = LineString(
        [
            (121.500, 25.000),
            (121.510, 25.000),
            (121.520, 25.000),
        ]
    )
    wra_gdf = gpd.GeoDataFrame(
        {"NAME": ["新店溪"]}, geometry=[river_line], crs="EPSG:4326"
    )

    segments = build_river_segments(latest_df, wra_gdf)
    assert len(segments) == 1
    row = segments.iloc[0]
    assert row["upstream_site_id"] == "ext:25:UP"
    assert row["downstream_site_id"] == "ext:25:DOWN"
    assert row["upstream_rpi"] == 2.0
    assert row["downstream_rpi"] == 6.0


def test_synthesize_ext_station_ordering_uses_basin_to_match_osm_name():
    latest_df = pd.DataFrame(
        [
            _ext_latest_row(
                site_id="ext:25:DOWN", basin="北勢溪",
                longitude=121.720, latitude=24.915,
            ),
            _ext_latest_row(
                site_id="ext:25:UP", basin="北勢溪",
                longitude=121.700, latitude=24.910,
            ),
        ]
    )
    waterways = gpd.GeoDataFrame(
        {"name": ["北勢溪"]},
        geometry=[
            LineString(
                [
                    (121.700, 24.910),
                    (121.710, 24.913),
                    (121.720, 24.915),
                ]
            )
        ],
        crs="EPSG:4326",
    )

    out = synthesize_ext_station_ordering(latest_df, waterways)

    rows = out.set_index("site_id")
    assert rows.loc["ext:25:UP", "river_id"] == "ext-river:北勢溪"
    assert rows.loc["ext:25:DOWN", "river_id"] == "ext-river:北勢溪"
    assert int(rows.loc["ext:25:UP", "station_order"]) == 1
    assert int(rows.loc["ext:25:DOWN", "station_order"]) == 2


def test_synthesize_ext_station_ordering_skips_basins_without_osm_match():
    latest_df = pd.DataFrame(
        [
            _ext_latest_row(
                site_id="ext:25:11", basin="水仙溪",
                longitude=121.394, latitude=25.083,
            ),
            _ext_latest_row(
                site_id="ext:25:12", basin="水仙溪",
                longitude=121.398, latitude=25.086,
            ),
        ]
    )
    waterways = gpd.GeoDataFrame(
        {"name": ["其他河"]},
        geometry=[LineString([(120.0, 24.0), (120.1, 24.1)])],
        crs="EPSG:4326",
    )

    out = synthesize_ext_station_ordering(latest_df, waterways)
    assert out["river_id"].isna().all()
    assert out["station_order"].isna().all()


def test_build_river_segments_does_not_disturb_official_rows_when_ext_present():
    latest_df = pd.DataFrame(
        [
            _make_latest_row(
                site_id="OFF1", station_order=1,
                longitude=121.500, latitude=25.000, rpi_value=2.0, river="新店溪",
            ),
            _make_latest_row(
                site_id="OFF2", station_order=2,
                longitude=121.510, latitude=25.005, rpi_value=4.0, river="新店溪",
            ),
            _ext_latest_row(
                site_id="ext:25:1", basin="北勢溪",
                longitude=121.700, latitude=24.910,
            ),
        ]
    )
    river_line_off = LineString(
        [(121.500, 25.000), (121.510, 25.005)]
    )
    wra_gdf = gpd.GeoDataFrame(
        {"NAME": ["新店溪"]},
        geometry=[river_line_off],
        crs="EPSG:4326",
    )

    segments = build_river_segments(latest_df, wra_gdf)
    assert "RID-A-OFF1-OFF2" in segments["segment_id"].tolist()


def test_enrich_ext_do_ignores_official_rows():
    _, latest_df = normalize_records(
        [_moenv_record()], "2026-04-01 00:00:00+08"
    )

    def fake_fetch(site_id, mgmt_id):  # pragma: no cover - should not run
        raise AssertionError("official rows must not trigger detail fetches")

    enriched = enrich_ext_do_from_detail_pages(latest_df, fetch_fn=fake_fetch)
    assert enriched.iloc[0]["do_method"] is None
    assert enriched.iloc[0]["source_label"] == SOURCE_LABEL_MOENV_RIVER
