#!/usr/bin/env python3
"""
JSON → PostgreSQL loader for EV charging data.

Source files (this directory):
  Station_Taipei.json, Station_NewTaipei.json
  ChargingPoint_Taipei.json, ChargingPoint_NewTaipei.json
  Connector_Taipei.json, Connector_NewTaipei.json

Target tables (dashboard DB):
  env_ev_charging_stations          — map layer + popup
  env_ev_charging_district_summary  — DistrictChart (station / point counts)
  env_ev_charging_connector_power_district — BarPercentChart (power ratio)

Run via Docker (recommended):
  docker compose --env-file docker/.env -f docker/docker-compose-ev-charging.yaml up --build

Run locally (requires psycopg2-binary shapely and a reachable DB):
  pip install psycopg2-binary shapely
  python db-sample-data/car/load_ev_charging.py
"""

import json
import os
import re
from collections import defaultdict
from pathlib import Path

import psycopg2
from psycopg2.extras import execute_values
from shapely.geometry import Point, shape

# ── Paths ──────────────────────────────────────────────────────────────────────
SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent.parent
ENV_FILE = PROJECT_ROOT / "docker" / ".env"

# ── DB connection ──────────────────────────────────────────────────────────────

def _parse_dotenv(path: Path) -> dict:
    env = {}
    if not path.exists():
        return env
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        k, _, v = line.partition("=")
        v = v.split("#")[0].strip().strip('"').strip("'")
        env[k.strip()] = v
    return env

def get_conn():
    file_env = _parse_dotenv(ENV_FILE)

    def get(key, default=""):
        return os.environ.get(key) or file_env.get(key) or default

    host   = get("DB_DASHBOARD_HOST", "localhost")
    user   = get("DB_DASHBOARD_USER", "postgres")
    pw     = get("DB_DASHBOARD_PASSWORD", "")
    dbname = get("DB_DASHBOARD_DBNAME", "dashboard")
    port   = int(get("DB_DASHBOARD_PORT", "5432"))

    print(f"[DB] {user}@{host}:{port}/{dbname}")
    return psycopg2.connect(host=host, user=user, password=pw, dbname=dbname, port=port)

# ── Constants ──────────────────────────────────────────────────────────────────

CITIES = [
    {"suffix": "Taipei",    "city_zh": "臺北市"},
    {"suffix": "NewTaipei", "city_zh": "新北市"},
]

ALL_BUCKETS = [
    ("slow_ac",      1),
    ("medium_dc",    2),
    ("fast_dc",      3),
    ("ultra_fast_dc",4),
    ("unknown",      5),
]
BUCKET_PRIORITY = {b: o for b, o in ALL_BUCKETS}

# ── District lookup (in-Python spatial join) ───────────────────────────────────

def build_district_lookup(geojson_path: Path):
    """Returns list of (shapely_polygon, city, district) from metrotaipei_town.geojson."""
    with open(geojson_path, encoding="utf-8") as f:
        fc = json.load(f)
    entries = []
    for feat in fc["features"]:
        props = feat["properties"]
        entries.append((shape(feat["geometry"]), props["PNAME"], props["TNAME"]))
    return entries

def lookup_district(lon, lat, entries):
    """Return (city, district) for a point, or (None, '未分類') if not found."""
    if lon is None or lat is None:
        return None, "未分類"
    pt = Point(lon, lat)
    for poly, city, district in entries:
        if poly.contains(pt):
            return city, district
    return None, "未分類"

# ── Helpers ────────────────────────────────────────────────────────────────────

def read_json(path: Path) -> dict:
    with open(path, encoding="utf-8") as f:
        return json.load(f)

def parse_power_kw(raw: str):
    if not raw:
        return None
    cleaned = re.sub(r"[kKwW\s]", "", raw)
    try:
        return float(cleaned)
    except ValueError:
        return None

def classify_bucket(power_type, power_kw) -> str:
    if power_type == 1:
        return "slow_ac"
    if power_type == 2:
        if power_kw is None:
            return "unknown"
        if power_kw < 22:
            return "slow_ac"
        if power_kw < 50:
            return "medium_dc"
        if power_kw < 150:
            return "fast_dc"
        return "ultra_fast_dc"
    return "unknown"

def best_bucket(bucket_set) -> str:
    return max(bucket_set, key=lambda b: BUCKET_PRIORITY.get(b, 0), default="unknown")

def extract_name(obj) -> str:
    if isinstance(obj, str):
        return obj
    if isinstance(obj, dict):
        return obj.get("Zh_tw") or obj.get("En") or ""
    return ""

def extract_district(loc: dict) -> str:
    if not isinstance(loc, dict):
        return "未分類"
    addr = loc.get("Address", {})
    if not isinstance(addr, dict):
        return "未分類"
    town = (addr.get("Town") or "").strip()
    if not town:
        return "未分類"
    if not town.endswith(("區", "鄉", "鎮", "市")):
        town += "區"
    return town

def build_address(loc: dict) -> str:
    if not isinstance(loc, dict):
        return ""
    addr = loc.get("Address", {})
    if isinstance(addr, dict):
        return "".join(filter(None, [
            addr.get("City", ""), addr.get("Town", ""), addr.get("Road", ""),
            addr.get("Lane", ""), addr.get("Alley", ""), addr.get("No", ""),
        ]))
    place = loc.get("Place", {})
    if isinstance(place, dict):
        return place.get("POI", "")
    return ""

# ── Transform ──────────────────────────────────────────────────────────────────

def transform(data_dir: Path):
    district_entries = build_district_lookup(data_dir / "metrotaipei_town.geojson")
    print(f"[parse] loaded {len(district_entries)} district polygons")

    raw_stations, raw_points, raw_connectors = [], [], []

    for city in CITIES:
        sfx, zh = city["suffix"], city["city_zh"]
        st  = read_json(data_dir / f"Station_{sfx}.json")
        cp  = read_json(data_dir / f"ChargingPoint_{sfx}.json")
        cn  = read_json(data_dir / f"Connector_{sfx}.json")

        ts = st.get("UpdateTime") or st.get("SrcUpdateTime")
        tc = cn.get("UpdateTime") or cn.get("SrcUpdateTime")

        for r in st.get("Stations", []):
            r["_city"] = zh; r["_ts"] = ts
            raw_stations.append(r)
        for r in cp.get("ChargingPoints", []):
            r["_city"] = zh
            raw_points.append(r)
        for r in cn.get("Connectors", []):
            r["_city"] = zh; r["_ts"] = tc
            raw_connectors.append(r)

    print(f"[parse] stations={len(raw_stations)}, points={len(raw_points)}, connectors={len(raw_connectors)}")

    # Per-station connector aggregations
    bucket_cnt   = defaultdict(lambda: defaultdict(int))  # sid → {bucket: n}
    kw_cnt       = defaultdict(lambda: defaultdict(int))  # sid → {kw: n}
    conn_cnt     = defaultdict(int)
    point_cnt    = defaultdict(int)

    for cn in raw_connectors:
        sid        = cn.get("StationID", "")
        power_type = cn.get("Power")
        power_kw   = parse_power_kw(str(cn.get("PowerRating") or ""))
        bucket     = classify_bucket(power_type, power_kw)
        bucket_cnt[sid][bucket] += 1
        conn_cnt[sid] += 1
        if power_kw is not None:
            kw_cnt[sid][power_kw] += 1

    for cp in raw_points:
        point_cnt[cp.get("StationID", "")] += 1

    # Build station rows
    station_rows = []
    for s in raw_stations:
        sid = s.get("StationID", "")
        loc = s.get("Location", {}) or {}

        buckets       = bucket_cnt.get(sid, {})
        power_summary = json.dumps(dict(buckets), ensure_ascii=False) if buckets else "{}"
        kw_map        = kw_cnt.get(sid, {})
        power_detail  = json.dumps(
            sorted([{"kw": k, "count": v} for k, v in kw_map.items()], key=lambda x: x["kw"]),
            ensure_ascii=False,
        )
        max_power_kw     = max(kw_map.keys()) if kw_map else None
        max_power_bucket = best_bucket(buckets.keys()) if buckets else "unknown"

        try:
            lon = float(s.get("PositionLon") or 0) or None
            lat = float(s.get("PositionLat") or 0) or None
        except (TypeError, ValueError):
            lon = lat = None

        if lon is None or lat is None:
            continue  # no usable coordinates → skip entirely

        # District: structured address first, then spatial join via GeoJSON
        district = extract_district(loc)
        if district == "未分類":
            _, district = lookup_district(lon, lat, district_entries)

        station_rows.append((
            sid,
            extract_name(s.get("StationName", "")),
            s["_city"],
            district,
            build_address(loc),
            s.get("OperatorID", ""),
            s.get("OperationType"),
            s.get("Spaces"),
            point_cnt.get(sid) or s.get("ChargingPoints") or 0,
            conn_cnt.get(sid)  or 0,
            max_power_kw,
            max_power_bucket,
            power_summary,
            power_detail,
            s.get("ServiceTime", ""),
            s.get("ParkingRate", ""),
            s.get("ChargingRate", ""),
            s.get("Floors", ""),
            s.get("Telephone", ""),
            lon,
            lat,
            "TDX CityEVCharging",
            s.get("_ts"),
        ))

    return station_rows

# ── SQL ────────────────────────────────────────────────────────────────────────

DDL = """
DROP TABLE IF EXISTS public.env_ev_charging_connector_power_district;
DROP TABLE IF EXISTS public.env_ev_charging_district_summary;
DROP TABLE IF EXISTS public.env_ev_charging_stations;

CREATE TABLE public.env_ev_charging_stations (
    station_id            text PRIMARY KEY,
    station_name          text,
    city                  text,
    district              text,
    address               text,
    operator_id           text,
    operation_type        integer,
    spaces                integer,
    charging_point_count  integer,
    connector_count       integer,
    max_power_kw          numeric,
    max_power_bucket      text,
    power_summary         jsonb,
    power_detail          jsonb,
    service_time          text,
    parking_rate          text,
    charging_rate         text,
    floors                text,
    telephone             text,
    longitude             numeric,
    latitude              numeric,
    source_name           text,
    data_time             timestamptz,
    wkb_geometry          geometry(Point, 4326)
);
CREATE INDEX ON public.env_ev_charging_stations (city);
CREATE INDEX ON public.env_ev_charging_stations (district);
CREATE INDEX ON public.env_ev_charging_stations (max_power_bucket);
CREATE INDEX ON public.env_ev_charging_stations USING GIST (wkb_geometry);

CREATE TABLE public.env_ev_charging_district_summary (
    city_scope            text NOT NULL,
    city                  text NOT NULL,
    district              text NOT NULL,
    station_count         integer,
    charging_point_count  integer,
    connector_count       integer,
    data_time             timestamptz,
    PRIMARY KEY (city_scope, city, district)
);

CREATE TABLE public.env_ev_charging_connector_power_district (
    city_scope            text NOT NULL,
    city                  text NOT NULL,
    district              text NOT NULL,
    power_bucket          text NOT NULL,
    power_bucket_order    integer,
    connector_count       integer,
    connector_ratio       numeric,
    data_time             timestamptz,
    PRIMARY KEY (city_scope, city, district, power_bucket)
);
"""

INSERT_STATIONS = """
INSERT INTO public.env_ev_charging_stations (
    station_id, station_name, city, district, address,
    operator_id, operation_type, spaces,
    charging_point_count, connector_count,
    max_power_kw, max_power_bucket, power_summary, power_detail,
    service_time, parking_rate, charging_rate, floors, telephone,
    longitude, latitude, source_name, data_time, wkb_geometry
) VALUES %s
"""

INSERT_STATIONS_TEMPLATE = """(
    %s, %s, %s, %s, %s,
    %s, %s, %s,
    %s, %s,
    %s, %s, %s::jsonb, %s::jsonb,
    %s, %s, %s, %s, %s,
    %s, %s, %s, %s,
    CASE WHEN %s IS NOT NULL AND %s IS NOT NULL
         THEN ST_SetSRID(ST_MakePoint(%s, %s), 4326) END
)"""

# Note: lon/lat appears 3 times in template (once for IS NOT NULL check, twice for MakePoint)
# We'll handle by expanding the tuple

AGGREGATE_SQL = """
-- District summary: taipei scope
INSERT INTO public.env_ev_charging_district_summary
    (city_scope, city, district, station_count, charging_point_count, connector_count, data_time)
SELECT 'taipei', city, district,
    COUNT(DISTINCT station_id),
    SUM(COALESCE(charging_point_count, 0)),
    SUM(COALESCE(connector_count, 0)),
    MAX(data_time)
FROM public.env_ev_charging_stations
WHERE city = '臺北市'GROUP BY city, district;

-- District summary: twin_city scope
INSERT INTO public.env_ev_charging_district_summary
    (city_scope, city, district, station_count, charging_point_count, connector_count, data_time)
SELECT 'twin_city', city, district,
    COUNT(DISTINCT station_id),
    SUM(COALESCE(charging_point_count, 0)),
    SUM(COALESCE(connector_count, 0)),
    MAX(data_time)
FROM public.env_ev_charging_stations
WHERE city IN ('臺北市', '新北市')GROUP BY city, district;

-- Power bucket by district: both scopes
WITH buckets(power_bucket, power_bucket_order) AS (
    VALUES ('slow_ac',1),('medium_dc',2),('fast_dc',3),('ultra_fast_dc',4),('unknown',5)
),
raw AS (
    SELECT city, district, kv.key AS power_bucket, SUM(kv.value::int) AS cnt
    FROM public.env_ev_charging_stations s,
         LATERAL jsonb_each_text(COALESCE(s.power_summary, '{}')) kv
    WHERE district != '未分類'
    GROUP BY city, district, kv.key
),
districts AS (
    SELECT DISTINCT city, district FROM public.env_ev_charging_stations
    WHERE district != '未分類'
),
grid AS (
    SELECT d.city, d.district, b.power_bucket, b.power_bucket_order
    FROM districts d CROSS JOIN buckets b
),
with_total AS (
    SELECT g.city, g.district, g.power_bucket, g.power_bucket_order,
           COALESCE(r.cnt, 0) AS connector_count,
           SUM(COALESCE(r.cnt, 0)) OVER (PARTITION BY g.city, g.district) AS total
    FROM grid g
    LEFT JOIN raw r ON g.city=r.city AND g.district=r.district AND g.power_bucket=r.power_bucket
)
INSERT INTO public.env_ev_charging_connector_power_district
    (city_scope, city, district, power_bucket, power_bucket_order, connector_count, connector_ratio, data_time)
SELECT scope.s, wt.city, wt.district, wt.power_bucket, wt.power_bucket_order,
       wt.connector_count,
       CASE WHEN wt.total > 0 THEN ROUND(wt.connector_count::numeric / wt.total, 4) ELSE 0 END,
       NOW()
FROM with_total wt
CROSS JOIN (VALUES ('taipei'), ('twin_city')) AS scope(s)
WHERE (scope.s = 'taipei'    AND wt.city = '臺北市')
   OR (scope.s = 'twin_city' AND wt.city IN ('臺北市', '新北市'));
"""

# ── Load ───────────────────────────────────────────────────────────────────────

def load(conn, station_rows):
    with conn.cursor() as cur:
        print("[DB] creating tables...")
        cur.execute(DDL)

        print(f"[DB] inserting {len(station_rows)} stations...")
        # Expand each row: lon/lat repeated for the geometry CASE expression
        expanded = []
        for r in station_rows:
            # r: (sid, name, city, district, address, op_id, op_type, spaces,
            #     cp_count, cn_count, max_kw, max_bucket, power_summary, power_detail,
            #     svc_time, park_rate, chg_rate, floors, tel,
            #     lon, lat, source, ts)
            lon, lat = r[19], r[20]
            expanded.append(r + (lon, lat, lon, lat))  # append lon,lat twice for MakePoint

        execute_values(cur, INSERT_STATIONS, expanded, template=INSERT_STATIONS_TEMPLATE, page_size=200)

        print("[DB] aggregating district summaries...")
        cur.execute(AGGREGATE_SQL)

    conn.commit()

# ── Verify ─────────────────────────────────────────────────────────────────────

def verify(conn):
    with conn.cursor() as cur:
        print("\n[verify] row counts:")
        for tbl in [
            "env_ev_charging_stations",
            "env_ev_charging_district_summary",
            "env_ev_charging_connector_power_district",
        ]:
            cur.execute(f"SELECT COUNT(*) FROM public.{tbl}")
            print(f"  {tbl}: {cur.fetchone()[0]}")

        cur.execute("""
            SELECT district, COUNT(*) AS n
            FROM public.env_ev_charging_stations
            WHERE city='臺北市'
            GROUP BY district ORDER BY n DESC LIMIT 5
        """)
        print("\n[verify] top 5 Taipei districts (after spatial join):")
        for row in cur.fetchall():
            print(f"  {row[0]}: {row[1]} stations")

        cur.execute("""
            SELECT max_power_bucket, COUNT(*) AS n
            FROM public.env_ev_charging_stations
            GROUP BY max_power_bucket ORDER BY n DESC
        """)
        print("\n[verify] stations by max_power_bucket (map color):")
        for row in cur.fetchall():
            print(f"  {row[0]}: {row[1]}")

# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    data_dir = SCRIPT_DIR
    print(f"[start] reading JSON from {data_dir}")

    station_rows = transform(data_dir)

    conn = get_conn()
    try:
        load(conn, station_rows)
        verify(conn)
    finally:
        conn.close()

    print("\n[done] EV charging data loaded successfully.")

if __name__ == "__main__":
    main()
