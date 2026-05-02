import os

from airflow import DAG
from operators.common_pipeline import CommonDag


def _env_river_water_quality(**kwargs):
    import geopandas as gpd
    import pandas as pd
    import requests
    from shapely.geometry import Point
    from sqlalchemy import create_engine
    from sqlalchemy.sql import text as sa_text
    from utils.get_time import get_tpe_now_time_str
    from utils.load_stage import update_lasttime_in_data_to_dataset_info

    from proj_city_dashboard.env_river_water_quality.river_water_quality_lib import (
        build_river_segments,
        export_geojson_layers,
        fetch_river_station_records,
        fetch_wra_river_geodataframe,
        load_curated_route_geodataframe,
        normalize_records,
    )

    ready_data_db_uri = kwargs.get("ready_data_db_uri")
    data_path = kwargs.get("data_path")
    dag_infos = kwargs.get("dag_infos")
    dag_id = dag_infos.get("dag_id")
    table_names = dag_infos.get("ready_data_default_table")
    if not isinstance(table_names, list):
        raise ValueError("ready_data_default_table must be a list for this DAG.")

    sites_table = "env_river_monitoring_sites"
    latest_table = "env_river_site_rpi_latest"
    segments_table = "env_river_rpi_segments_latest"
    expected_tables = {sites_table, latest_table, segments_table}
    missing_tables = expected_tables - set(table_names)
    if missing_tables:
        raise ValueError(f"job_config missing ready tables: {sorted(missing_tables)}")

    cache_dir = os.path.join(data_path or "/tmp/env_river_water_quality_cache", "wra_cache")

    data_time = get_tpe_now_time_str(is_with_tz=True)
    session = requests.Session()
    records = fetch_river_station_records(session)
    sites_df, latest_df = normalize_records(records, data_time)

    if sites_df.empty:
        raise ValueError("No 臺北市/新北市 river stations were extracted from MOENV.")

    wra_gdf = fetch_wra_river_geodataframe(cache_dir, session=session)
    route_path = os.path.join(
        os.path.dirname(__file__),
        "assets",
        "river_segment_routes.geojson",
    )
    route_gdf = load_curated_route_geodataframe(route_path)
    segments_df = build_river_segments(latest_df, wra_gdf, route_gdf=route_gdf)

    def _to_point(lon, lat):
        if pd.isna(lon) or pd.isna(lat):
            return None
        return Point(lon, lat)

    sites_df["wkb_geometry"] = [
        _to_point(lon, lat)
        for lon, lat in zip(sites_df["longitude"], sites_df["latitude"])
    ]
    sites_gdf = gpd.GeoDataFrame(sites_df, geometry="wkb_geometry", crs="EPSG:4326")

    latest_df["wkb_geometry"] = [
        _to_point(lon, lat)
        for lon, lat in zip(latest_df["longitude"], latest_df["latitude"])
    ]
    latest_gdf = gpd.GeoDataFrame(
        latest_df.drop(columns=["river_id", "station_order", "longitude", "latitude"]),
        geometry="wkb_geometry",
        crs="EPSG:4326",
    )

    segments_gdf = (
        gpd.GeoDataFrame(segments_df, geometry="wkb_geometry", crs="EPSG:4326")
        if not segments_df.empty
        else None
    )

    engine = create_engine(ready_data_db_uri)
    with engine.begin() as conn:
        conn.execute(sa_text(f"TRUNCATE TABLE {segments_table}"))
        conn.execute(sa_text(f"TRUNCATE TABLE {latest_table}"))
        conn.execute(sa_text(f"TRUNCATE TABLE {sites_table}"))
        sites_gdf.to_postgis(sites_table, conn, if_exists="append", index=False)
        latest_gdf.to_postgis(latest_table, conn, if_exists="append", index=False)
        if segments_gdf is not None:
            segments_gdf.to_postgis(segments_table, conn, if_exists="append", index=False)

    export_geojson_layers(latest_gdf, segments_gdf)

    sample_months = pd.to_datetime(latest_df["sample_month"], errors="coerce")
    lasttime_in_data = sample_months.max() if not sample_months.dropna().empty else data_time
    update_lasttime_in_data_to_dataset_info(
        engine,
        f"proj_city_dashboard_{dag_id}",
        lasttime_in_data,
    )


common_dag = CommonDag(
    proj_folder="proj_city_dashboard",
    dag_folder="env_river_water_quality",
)
dag = common_dag.create_dag(etl_func=_env_river_water_quality)
