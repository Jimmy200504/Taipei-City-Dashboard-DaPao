import heapq
import json
import math
from collections import defaultdict
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Tuple

import geopandas as gpd
import pandas as pd
from shapely.geometry import LineString, Point

from proj_city_dashboard.env_river_water_quality.river_water_quality_lib import (
    EXT_RIVER_ID_PREFIX,
    SOURCE_LABEL_MOENV_EXT_RIVER,
    TARGET_CITIES,
)

Coord = Tuple[float, float]

DEFAULT_MAX_STATION_DISTANCE_M = 1500.0
DEFAULT_NODE_PRECISION = 7
OVERPASS_URL = "https://overpass-api.de/api/interpreter"


def synthesize_ext_station_ordering(
    latest_df: pd.DataFrame,
    waterways_gdf: gpd.GeoDataFrame,
    name_col: str = "name",
    max_station_distance_m: float = DEFAULT_MAX_STATION_DISTANCE_M,
) -> pd.DataFrame:
    """Stamp synthetic ``river_id``/``station_order`` on Ext-source rows.

    Ext stations have no upstream-provided ``River_ID`` or ``Station_Order``,
    so ``generate_route_features`` would skip them. For each Ext row whose
    ``basin`` matches a waterway feature ``name`` in ``waterways_gdf``, this
    helper projects the station onto the nearest matching feature, sorts by
    ``(feature_idx, t_along)`` per basin to derive an order, and stamps
    ``river_id = "ext-river:{basin}"``. Stations whose basin has no
    matching waterway, or whose projection distance exceeds
    ``max_station_distance_m``, retain their NA values.
    """
    if (
        latest_df is None
        or latest_df.empty
        or waterways_gdf is None
        or waterways_gdf.empty
        or "source_label" not in latest_df.columns
    ):
        return latest_df

    ext_mask = (
        (latest_df["source_label"] == SOURCE_LABEL_MOENV_EXT_RIVER)
        & latest_df["rpi_value"].notna()
        & latest_df["basin"].notna()
        & latest_df["longitude"].notna()
        & latest_df["latitude"].notna()
    )
    if not ext_mask.any():
        return latest_df

    df = latest_df.copy()
    if "river_id" in df.columns and df["river_id"].dtype != object:
        df["river_id"] = df["river_id"].astype(object)

    basins = sorted(set(latest_df.loc[ext_mask, "basin"].dropna()))
    waterways = waterways_gdf
    if waterways.crs is not None and str(waterways.crs).upper() != "EPSG:4326":
        waterways = waterways.to_crs("EPSG:4326")

    for basin_name in basins:
        matching = waterways[waterways[name_col] == basin_name]
        if matching.empty:
            continue
        features = [
            geom
            for geom in matching.geometry
            if geom is not None and not geom.is_empty and geom.geom_type == "LineString"
        ]
        if not features:
            continue

        basin_mask = ext_mask & (latest_df["basin"] == basin_name)
        basin_indexes = latest_df.index[basin_mask].tolist()
        if len(basin_indexes) < 2:
            continue

        projections = []
        for idx in basin_indexes:
            row = latest_df.loc[idx]
            pt = Point(float(row["longitude"]), float(row["latitude"]))
            best_d = math.inf
            best_fi = 0
            best_t = 0.0
            for fi, feat in enumerate(features):
                t = feat.project(pt)
                near = feat.interpolate(t)
                d = _haversine_meters(
                    (pt.x, pt.y), (near.x, near.y)
                )
                if d < best_d:
                    best_d, best_fi, best_t = d, fi, t
            if best_d > max_station_distance_m:
                continue
            projections.append((idx, best_fi, best_t))

        if len(projections) < 2:
            continue

        projections.sort(key=lambda x: (x[1], x[2]))
        synthetic_river_id = f"{EXT_RIVER_ID_PREFIX}:{basin_name}"
        for order, (idx, _, _) in enumerate(projections, 1):
            df.at[idx, "river_id"] = synthetic_river_id
            df.at[idx, "station_order"] = order

    return df


def generate_route_features(
    latest_df: pd.DataFrame,
    waterways_gdf: gpd.GeoDataFrame,
    max_station_distance_m: float = DEFAULT_MAX_STATION_DISTANCE_M,
) -> Tuple[gpd.GeoDataFrame, dict]:
    pairs = _station_pairs(latest_df)
    graph = _waterway_graph(waterways_gdf)

    rows = []
    missing = []
    for upstream, downstream in pairs:
        segment_id = _segment_id(
            upstream["river_id"],
            upstream["site_id"],
            downstream["site_id"],
        )
        route, reason, upstream_dist, downstream_dist = _route_between_stations(
            graph,
            _station_coord(upstream),
            _station_coord(downstream),
            max_station_distance_m,
        )
        if route is None:
            missing.append(
                {
                    "segment_id": segment_id,
                    "reason": reason,
                    "upstream_distance_m": round(upstream_dist, 1),
                    "downstream_distance_m": round(downstream_dist, 1),
                }
            )
            continue

        rows.append(
            {
                "segment_id": segment_id,
                "river_id": upstream["river_id"],
                "upstream_site_id": upstream["site_id"],
                "downstream_site_id": downstream["site_id"],
                "geometry": route,
            }
        )

    route_gdf = _route_geodataframe(rows)
    return route_gdf, {"generated": len(route_gdf), "missing": missing}


def write_route_geojson(route_gdf: gpd.GeoDataFrame, output_path) -> None:
    output = Path(output_path)
    output.parent.mkdir(parents=True, exist_ok=True)
    if route_gdf is None or route_gdf.empty:
        output.write_text(
            json.dumps(
                {
                    "type": "FeatureCollection",
                    "name": "env_river_segment_routes",
                    "features": [],
                },
                ensure_ascii=False,
            ),
            encoding="utf-8",
        )
        return

    route_gdf.to_file(output, driver="GeoJSON")


def _route_geodataframe(rows: List[dict]) -> gpd.GeoDataFrame:
    columns = [
        "segment_id",
        "river_id",
        "upstream_site_id",
        "downstream_site_id",
        "geometry",
    ]
    if not rows:
        return gpd.GeoDataFrame(columns=columns, geometry="geometry", crs="EPSG:4326")
    return gpd.GeoDataFrame(rows, columns=columns, geometry="geometry", crs="EPSG:4326")


def build_overpass_query(bbox: Tuple[float, float, float, float]) -> str:
    south, west, north, east = bbox
    return f"""
[out:json][timeout:180];
(
  way["waterway"~"^(river|stream|canal)$"]({south},{west},{north},{east});
);
out geom;
"""


def overpass_waterways_to_gdf(payload: dict) -> gpd.GeoDataFrame:
    rows = []
    for element in payload.get("elements", []):
        geometry = element.get("geometry")
        if element.get("type") != "way" or not geometry or len(geometry) < 2:
            continue
        coords = [(float(pt["lon"]), float(pt["lat"])) for pt in geometry]
        tags = element.get("tags") or {}
        rows.append(
            {
                "osm_id": element.get("id"),
                "name": tags.get("name"),
                "waterway": tags.get("waterway"),
                "geometry": LineString(coords),
            }
        )
    return gpd.GeoDataFrame(rows, geometry="geometry", crs="EPSG:4326")


def _station_pairs(latest_df: pd.DataFrame) -> List[Tuple[dict, dict]]:
    if latest_df is None or latest_df.empty:
        return []
    required = ["river_id", "station_order", "longitude", "latitude", "rpi_value"]
    df = latest_df.dropna(subset=required).copy()
    if df.empty:
        return []

    df = df[df["city"].isin(TARGET_CITIES)]
    df["station_order"] = df["station_order"].astype(int)

    pairs = []
    for (_, _), group in df.groupby(["river_id", "river"], dropna=False):
        ordered = group.sort_values("station_order").to_dict(orient="records")
        pairs.extend(zip(ordered, ordered[1:]))
    return pairs


class _Graph:
    def __init__(self) -> None:
        self.adj: Dict[Coord, List[Tuple[float, Coord]]] = defaultdict(list)

    @property
    def nodes(self) -> Iterable[Coord]:
        return self.adj.keys()

    def add_edge(self, a: Coord, b: Coord) -> None:
        weight = _haversine_meters(a, b)
        self.adj[a].append((weight, b))
        self.adj[b].append((weight, a))


def _waterway_graph(waterways_gdf: gpd.GeoDataFrame) -> _Graph:
    graph = _Graph()
    if waterways_gdf is None or waterways_gdf.empty:
        return graph

    waterways = waterways_gdf
    if waterways.crs is not None and str(waterways.crs).upper() != "EPSG:4326":
        waterways = waterways.to_crs("EPSG:4326")

    for geom in waterways.geometry:
        for coords in _line_coords(geom):
            for a, b in zip(coords, coords[1:]):
                graph.add_edge(_round_coord(a), _round_coord(b))
    return graph


def _line_coords(geom) -> Iterable[List[Coord]]:
    if geom is None or geom.is_empty:
        return
    if geom.geom_type == "LineString":
        yield list(geom.coords)
    elif geom.geom_type == "MultiLineString":
        for line in geom.geoms:
            yield list(line.coords)


def _route_between_stations(
    graph: _Graph,
    upstream: Coord,
    downstream: Coord,
    max_station_distance_m: float,
) -> Tuple[Optional[LineString], str, float, float]:
    upstream_node, upstream_dist = _nearest_node(graph, upstream)
    downstream_node, downstream_dist = _nearest_node(graph, downstream)
    if upstream_node is None or downstream_node is None:
        return None, "no_waterway_nodes", math.inf, math.inf
    if upstream_dist > max_station_distance_m or downstream_dist > max_station_distance_m:
        return (
            None,
            "station_too_far_from_waterway",
            upstream_dist,
            downstream_dist,
        )

    path = _shortest_path(graph, upstream_node, downstream_node)
    if not path:
        return None, "no_connected_route", upstream_dist, downstream_dist

    coords = list(path)
    coords[0] = upstream
    coords[-1] = downstream
    return LineString(coords), "", upstream_dist, downstream_dist


def _nearest_node(graph: _Graph, coord: Coord) -> Tuple[Optional[Coord], float]:
    nearest = None
    nearest_dist = math.inf
    for node in graph.nodes:
        dist = _haversine_meters(coord, node)
        if dist < nearest_dist:
            nearest = node
            nearest_dist = dist
    return nearest, nearest_dist


def _shortest_path(graph: _Graph, start: Coord, end: Coord) -> List[Coord]:
    queue = [(0.0, start)]
    dist = {start: 0.0}
    prev: Dict[Coord, Coord] = {}

    while queue:
        current_dist, node = heapq.heappop(queue)
        if node == end:
            break
        if current_dist > dist[node]:
            continue
        for weight, nxt in graph.adj[node]:
            new_dist = current_dist + weight
            if new_dist < dist.get(nxt, math.inf):
                dist[nxt] = new_dist
                prev[nxt] = node
                heapq.heappush(queue, (new_dist, nxt))

    if end not in dist:
        return []

    path = [end]
    while path[-1] != start:
        path.append(prev[path[-1]])
    return list(reversed(path))


def _station_coord(row) -> Coord:
    return (float(row["longitude"]), float(row["latitude"]))


def _round_coord(coord: Coord) -> Coord:
    return (
        round(float(coord[0]), DEFAULT_NODE_PRECISION),
        round(float(coord[1]), DEFAULT_NODE_PRECISION),
    )


def _haversine_meters(a: Coord, b: Coord) -> float:
    lat_mean = math.radians((a[1] + b[1]) / 2.0)
    dx = (b[0] - a[0]) * 111320.0 * math.cos(lat_mean)
    dy = (b[1] - a[1]) * 110540.0
    return math.hypot(dx, dy)


def _segment_id(river_id, upstream_site_id, downstream_site_id) -> str:
    return f"{river_id}-{upstream_site_id}-{downstream_site_id}"
