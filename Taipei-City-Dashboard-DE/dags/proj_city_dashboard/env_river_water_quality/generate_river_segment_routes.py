"""Generate candidate river route geometry from MOENV stations and OSM waterways.

This is a maintenance tool, not a scheduled DAG task. It writes a candidate
GeoJSON and a review report so route changes can be inspected before committing.
"""

import argparse
import json

import pandas as pd
import requests
from utils.get_time import get_tpe_now_time_str

from proj_city_dashboard.env_river_water_quality.river_route_generation import (
    OVERPASS_URL,
    build_overpass_query,
    generate_route_features,
    overpass_waterways_to_gdf,
    synthesize_ext_station_ordering,
    write_route_geojson,
)
from proj_city_dashboard.env_river_water_quality.river_water_quality_lib import (
    enrich_ext_do_from_detail_pages,
    fetch_river_ext_station_records,
    fetch_river_station_records,
    fetch_wra_river_geodataframe,
    normalize_ext_records,
    normalize_records,
)


DEFAULT_BBOX = (24.75, 121.25, 25.35, 122.05)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Generate candidate river_segment_routes.geojson from OSM."
    )
    parser.add_argument(
        "--output",
        default="/tmp/river_segment_routes.candidate.geojson",
        help="Output candidate route GeoJSON path.",
    )
    parser.add_argument(
        "--report",
        default="/tmp/river_segment_routes.report.json",
        help="Output JSON report path.",
    )
    parser.add_argument(
        "--bbox",
        nargs=4,
        type=float,
        metavar=("SOUTH", "WEST", "NORTH", "EAST"),
        default=DEFAULT_BBOX,
        help="Overpass query bbox. Default covers Taipei/New Taipei river scope.",
    )
    parser.add_argument(
        "--max-station-distance-m",
        type=float,
        default=1500.0,
        help="Maximum station-to-waterway distance accepted for auto route matching.",
    )
    parser.add_argument(
        "--include-ext",
        action="store_true",
        default=True,
        help=(
            "Also include other-agency (Ext_River) stations in route generation. "
            "Their river_id and station_order are synthesized by projecting onto "
            "OSM waterways that share each station's basin name. Enabled by default."
        ),
    )
    parser.add_argument(
        "--no-ext",
        dest="include_ext",
        action="store_false",
        help="Disable Ext_River station inclusion (official-only mode).",
    )
    args = parser.parse_args()

    session = requests.Session()
    data_time = get_tpe_now_time_str(is_with_tz=True)

    official_records = fetch_river_station_records(session=session)
    _, official_latest = normalize_records(official_records, data_time)

    if args.include_ext:
        ext_records = fetch_river_ext_station_records(session=session)
        _, ext_latest = normalize_ext_records(ext_records, data_time)
        ext_latest = enrich_ext_do_from_detail_pages(ext_latest, session=session)
        latest_df = pd.concat([official_latest, ext_latest], ignore_index=True)
    else:
        latest_df = official_latest

    overpass_response = session.post(
        OVERPASS_URL,
        data={"data": build_overpass_query(tuple(args.bbox))},
        timeout=240,
        headers={
            "User-Agent": (
                "TaipeiCityDashboard/1.0 (route-asset-maintenance; "
                "+https://citydashboard.taipei)"
            ),
        },
    )
    overpass_response.raise_for_status()
    waterways = overpass_waterways_to_gdf(overpass_response.json())

    if args.include_ext:
        # Order Ext stations using the WRA shapefile so segment IDs match the
        # runtime (which also uses WRA). OSM is used only for the route geometry
        # below, not for ordering.
        wra_gdf = fetch_wra_river_geodataframe("/tmp/wra_cache", session=session)
        latest_df = synthesize_ext_station_ordering(
            latest_df,
            wra_gdf,
            name_col="NAME",
            max_station_distance_m=args.max_station_distance_m,
        )

    route_gdf, report = generate_route_features(
        latest_df,
        waterways,
        max_station_distance_m=args.max_station_distance_m,
    )
    write_route_geojson(route_gdf, args.output)

    with open(args.report, "w", encoding="utf-8") as fh:
        json.dump(report, fh, ensure_ascii=False, indent=2)

    print(
        (
            f"Generated {report['generated']} candidate routes; "
            f"{len(report['missing'])} station pairs need review."
        )
    )
    print(f"Candidate GeoJSON: {args.output}")
    print(f"Review report: {args.report}")


if __name__ == "__main__":
    main()
