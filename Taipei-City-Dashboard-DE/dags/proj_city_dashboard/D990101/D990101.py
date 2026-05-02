from airflow import DAG
from operators.common_pipeline import CommonDag


NOISE_STANDARDS = {
    ("traffic", "一"): (None, None, None),
    ("traffic", "二"): (71, 69, 63),
    ("traffic", "三"): (74, 70, 67),
    ("traffic", "四"): (76, 75, 72),
    ("environmental", "一"): (55, 50, 45),
    ("environmental", "二"): (55, 50, 45),
    ("environmental", "三"): (60, 55, 50),
    ("environmental", "四"): (65, 60, 55),
    ("environmental", "五"): (75, 70, 65),
}

# kind code → noise_category value
KIND_MAP = {"EN": "environmental", "TN": "traffic"}

# control zone Chinese → short label stored in DB
ZONE_MAP = {"一": "一", "二": "二", "三": "三", "四": "四"}


def _D990101(**kwargs):
    import re
    import datetime
    import pandas as pd
    import requests
    from bs4 import BeautifulSoup
    from sqlalchemy import create_engine
    from sqlalchemy.sql import text as sa_text
    from utils.load_stage import (
        save_dataframe_to_postgresql,
        update_lasttime_in_data_to_dataset_info,
    )

    SOURCE_URL = "https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx"
    HEADERS = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
        "Referer": "https://www.tldep.gov.taipei/Public/DetInformation/NoiseQuality.aspx",
        "Content-Type": "application/x-www-form-urlencoded",
    }

    def parse_db_cell(raw):
        """Parse one quarterly dB cell. Returns (float_or_None, exceeded: bool)."""
        if not raw or raw.strip() in ("", "---", "-", "N/A"):
            return None, False
        s = raw.strip()
        exceeded = "*" in s
        s = s.replace("*", "").strip()
        try:
            return float(s), exceeded
        except ValueError:
            return None, False

    def get_viewstate(session):
        """GET the page and extract ASP.NET form hidden fields."""
        resp = session.get(SOURCE_URL, headers=HEADERS, timeout=30)
        resp.raise_for_status()
        soup = BeautifulSoup(resp.text, "html.parser")
        def _val(name):
            tag = soup.find("input", {"name": name})
            return tag["value"] if tag else ""
        return {
            "__VIEWSTATE": _val("__VIEWSTATE"),
            "__VIEWSTATEGENERATOR": _val("__VIEWSTATEGENERATOR"),
            "__EVENTVALIDATION": _val("__EVENTVALIDATION"),
        }

    def query_page(session, viewstate, year_roc, kind, zone):
        """POST form and return BeautifulSoup of response."""
        data = {
            **viewstate,
            "__EVENTTARGET": "",
            "__EVENTARGUMENT": "",
            "ctl00$CPH_Content$ddl_year": str(year_roc),
            "ctl00$CPH_Content$ddl_kind": kind,
            "ctl00$CPH_Content$ddl_class": zone,
            "ctl00$CPH_Content$btn_query": "查詢",
        }
        resp = session.post(SOURCE_URL, data=data, headers=HEADERS, timeout=30)
        resp.raise_for_status()
        return BeautifulSoup(resp.text, "html.parser")

    def parse_quarterly_tables(soup, year_ce, noise_category, control_zone):
        """Parse the three measurement tables (日間/晚間/夜間) from the page.

        Uses <td class='sub-thead'> as station-name anchors to handle the
        malformed HTML in the 夜間 table where <td> elements are not wrapped
        in <tr> tags.
        """
        tables = soup.find_all("table")
        period_names = ["day", "evening", "night"]
        records = []
        for period, tbl in zip(period_names, tables[1:4]):
            # Collect all station-name cells (class='sub-thead')
            station_cells = tbl.find_all("td", class_="sub-thead")
            if not station_cells:
                # Fallback: try normal <tr>-based parsing
                for tr in tbl.find_all("tr")[1:]:
                    cells = [td.get_text(strip=True) for td in tr.find_all("td")]
                    if len(cells) >= 5:
                        station_cells = None
                        break

            if station_cells:
                for sc in station_cells:
                    station_name = sc.get_text(strip=True)
                    if not station_name:
                        continue
                    # Collect the next 4 sibling <td> elements
                    q_cells = []
                    sib = sc.find_next_sibling("td")
                    while sib and len(q_cells) < 4:
                        q_cells.append(sib.get_text(strip=True))
                        sib = sib.find_next_sibling("td")
                    for qi, raw in enumerate(q_cells[:4], start=1):
                        val, exc = parse_db_cell(raw)
                        if val is None:
                            continue
                        records.append({
                            "station_name": station_name,
                            "noise_category": noise_category,
                            "control_zone": control_zone,
                            "year": year_ce,
                            "quarter": qi,
                            "quarter_label": "%dQ%d" % (year_ce, qi),
                            "period": period,
                            "avg_db": val,
                            "exceeded_standard": exc,
                        })
            else:
                # Normal <tr>-based parsing
                for tr in tbl.find_all("tr")[1:]:
                    cells = [td.get_text(strip=True) for td in tr.find_all("td")]
                    if len(cells) < 5:
                        continue
                    station_name = cells[0].strip()
                    for qi, raw in enumerate(cells[1:5], start=1):
                        val, exc = parse_db_cell(raw)
                        if val is None:
                            continue
                        records.append({
                            "station_name": station_name,
                            "noise_category": noise_category,
                            "control_zone": control_zone,
                            "year": year_ce,
                            "quarter": qi,
                            "quarter_label": "%dQ%d" % (year_ce, qi),
                            "period": period,
                            "avg_db": val,
                            "exceeded_standard": exc,
                        })
        return records

    def parse_station_info(soup):
        """Parse Table 0 for station name → address / monitoring type.

        Returns dict: station_name -> {address, monitoring_type}
        """
        info = {}
        tables = soup.find_all("table")
        if not tables:
            return info
        for tr in tables[0].find_all("tr")[1:]:
            cells = [td.get_text(strip=True) for td in tr.find_all("td")]
            if len(cells) >= 4:
                info[cells[0]] = {
                    "address": cells[1],
                    "control_zone_raw": cells[2],
                    "monitoring_type": "automatic" if "自動" in cells[3] else "manual",
                }
        return info

    # ---------- Setup ----------
    ready_data_db_uri = kwargs.get("ready_data_db_uri")
    dag_infos = kwargs.get("dag_infos")
    dag_id = dag_infos.get("dag_id")

    engine = create_engine(ready_data_db_uri)
    session = requests.Session()
    now = datetime.datetime.now()
    current_year_ce = now.year
    # ROC year = CE year - 1911
    current_year_roc = current_year_ce - 1911

    def is_maintenance_page(soup):
        """Return True if the response is the tldep maintenance page."""
        title = soup.find("title")
        return title and "maintenance" in title.get_text().lower()

    # ---------- Extract ----------
    initial_resp = session.get(SOURCE_URL, headers=HEADERS, timeout=30)
    initial_resp.raise_for_status()
    initial_soup = BeautifulSoup(initial_resp.text, "html.parser")

    all_records = []
    station_info = {}

    # 1. Always parse the default GET page (works even during POST maintenance)
    def extract_selected_combo(soup):
        """Read currently selected year/kind/zone from page dropdowns."""
        def sel_val(sid):
            tag = soup.find("select", {"id": sid})
            if not tag:
                return None
            opt = tag.find("option", selected=True)
            return opt["value"] if opt else tag.find("option")["value"]
        year_roc = sel_val("CPH_Content_ddl_year")
        kind_code = sel_val("CPH_Content_ddl_kind")
        zone = sel_val("CPH_Content_ddl_class")
        return year_roc, kind_code, zone

    year_val_str, kind_code, zone = extract_selected_combo(initial_soup)
    if year_val_str and kind_code and zone:
        # The dropdown value is already CE year (e.g. "2026"), not ROC year
        year_ce = int(year_val_str)
        noise_category = KIND_MAP.get(kind_code, kind_code)
        recs = parse_quarterly_tables(initial_soup, year_ce, noise_category, zone)
        all_records.extend(recs)
        station_info.update(parse_station_info(initial_soup))
        print("GET default: year=%d kind=%s zone=%s -> %d records" % (
            year_ce, kind_code, zone, len(recs)))

    # 2. Try POST for all year × kind × zone combinations
    def _get_viewstate(soup):
        def v(name):
            t = soup.find("input", {"name": name})
            return t["value"] if t else ""
        return {
            "__VIEWSTATE": v("__VIEWSTATE"),
            "__VIEWSTATEGENERATOR": v("__VIEWSTATEGENERATOR"),
            "__EVENTVALIDATION": v("__EVENTVALIDATION"),
        }

    viewstate = _get_viewstate(initial_soup)
    post_available = True

    # Dropdown values are CE years (2026, 2025, ...)
    for year_ce in (current_year_ce, current_year_ce - 1):
        if not post_available:
            break
        for kind_code, noise_category in KIND_MAP.items():
            if not post_available:
                break
            for zone in ("一", "二", "三", "四"):
                # Skip combo already captured from default GET
                default_combo = (
                    str(current_year_ce), list(KIND_MAP.keys())[0], "一"
                )
                if (str(year_ce), kind_code, zone) == default_combo and all_records:
                    continue
                try:
                    data = {
                        **viewstate,
                        "__EVENTTARGET": "",
                        "__EVENTARGUMENT": "",
                        "ctl00$CPH_Content$ddl_year": str(year_ce),
                        "ctl00$CPH_Content$ddl_kind": kind_code,
                        "ctl00$CPH_Content$ddl_class": zone,
                        "ctl00$CPH_Content$btn_query": "查詢",
                    }
                    r = session.post(SOURCE_URL, data=data,
                                     headers=HEADERS, timeout=30)
                    r.raise_for_status()
                    resp_soup = BeautifulSoup(r.text, "html.parser")
                    if is_maintenance_page(resp_soup):
                        print("POST blocked by maintenance page; using GET data only.")
                        post_available = False
                        break
                    recs = parse_quarterly_tables(resp_soup, year_ce, noise_category, zone)
                    all_records.extend(recs)
                    station_info.update(parse_station_info(resp_soup))
                    viewstate = _get_viewstate(resp_soup)
                    print("POST year=%d kind=%s zone=%s -> %d records" % (
                        year_ce, kind_code, zone, len(recs)))
                except Exception as e:
                    print("Warning: POST year=%d kind=%s zone=%s: %s" % (
                        year_ce, kind_code, zone, e))

    if not all_records:
        print("No records scraped (site may be under maintenance); aborting.")
        return

    # ---------- Transform ----------
    df = pd.DataFrame(all_records)
    df = df.drop_duplicates(
        subset=["station_name", "noise_category", "control_zone", "year", "quarter", "period"],
        keep="last",
    )
    df["data_time"] = pd.Timestamp.now(tz="Asia/Taipei")

    # ---------- Load: env_noise_quarterly_stats_tpe ----------
    # Delete Taipei rows for the scraped years before replacing
    scraped_years = df["year"].unique().tolist()
    with engine.connect() as conn:
        for yr in scraped_years:
            conn.execute(sa_text(
                "DELETE FROM env_noise_quarterly_stats_tpe WHERE year = %d" % yr
            ).execution_options(autocommit=True))

    quarterly_cols = [
        "station_name", "noise_category", "year", "quarter",
        "quarter_label", "period", "avg_db", "data_time",
    ]
    save_dataframe_to_postgresql(
        engine,
        data=df[quarterly_cols],
        load_behavior="append",
        default_table="env_noise_quarterly_stats_tpe",
    )

    # ---------- Load: env_noise_stations ----------
    # Build station records from scraped station names + data.taipei coords
    # Fetch coordinates from data.taipei open data (no API key needed)
    TAIPEI_COORD_URL = (
        "https://data.taipei/api/v1/dataset/"
        "ac5e1557-5590-4bec-8709-e5f0f8d4bd1e?scope=resourceAquire&limit=1000"
    )
    coord_map = {}  # station_name -> (sid, lng, lat, district)
    try:
        import re as _re
        r = session.get(TAIPEI_COORD_URL, headers=HEADERS, timeout=30)
        r.raise_for_status()
        for row in r.json().get("result", {}).get("results", []):
            name = str(row.get("測點名稱", "")).strip()
            sid = str(row.get("測點編號", "")).strip()
            address = str(row.get("測點地址", "")).strip()
            m = _re.search(r"[一-鿿]+區", address)
            district = m.group(0) if m else None
            try:
                lng = float(row["經度"])
                lat = float(row["緯度"])
                if name:
                    coord_map[name] = (sid, lng, lat, district)
            except (KeyError, TypeError, ValueError):
                continue
        print("Fetched %d Taipei station coords from data.taipei." % len(coord_map))
    except Exception as e:
        print("Warning: data.taipei coord fetch failed: %s" % e)

    # Also try MOENV GISEPA datasets for supplementary Taipei stations
    try:
        from airflow.models import Variable
        moenv_key = Variable.get("MOENV_API_KEY", default_var=None)
        if moenv_key:
            for dataset_id, id_field in (("GISEPA_P_18", "number"), ("GISEPA_P_19", "no")):
                url = (
                    "https://data.moenv.gov.tw/api/v2/%s"
                    "?api_key=%s&format=json&limit=1000" % (dataset_id, moenv_key)
                )
                r = session.get(url, headers=HEADERS, timeout=30)
                r.raise_for_status()
                body = r.json()
                records_list = body.get("records", []) if isinstance(body, dict) else body
                for rec in records_list:
                    city = str(rec.get("city", ""))
                    if "臺北" not in city and "台北" not in city:
                        continue
                    name = str(rec.get("name", "")).strip()
                    sid = str(rec.get(id_field, "")).strip()
                    try:
                        lng = float(rec["longitude"])
                        lat = float(rec["latitude"])
                        if name and name not in coord_map:
                            coord_map[name] = (sid, lng, lat, None)
                    except (KeyError, TypeError, ValueError):
                        continue
    except Exception as e:
        print("Warning: MOENV coord fetch skipped: %s" % e)

    # Collect unique station names from scraped data
    station_names = df["station_name"].unique()
    station_rows = []
    for name in station_names:
        meta = station_info.get(name, {})
        coord = coord_map.get(name)
        # Find the noise category and control zone for this station from records
        sub = df[df["station_name"] == name].iloc[0]
        noise_cat = sub["noise_category"]
        zone = sub["control_zone"]
        std = NOISE_STANDARDS.get((noise_cat, zone), (None, None, None))
        row = {
            "station_name": name,
            "city": "臺北市",
            "district": coord[3] if coord else None,
            "noise_category": noise_cat,
            "monitoring_type": meta.get("monitoring_type", "manual"),
            "control_zone": zone,
            "standard_day_db": std[0],
            "standard_evening_db": std[1],
            "standard_night_db": std[2],
            "latest_year": int(df[df["station_name"] == name]["year"].max()),
            "latest_quarter": int(df[df["station_name"] == name]["quarter"].max()),
            "source_name": "臺北市環境保護局",
            "source_url": SOURCE_URL,
            "data_time": pd.Timestamp.now(tz="Asia/Taipei"),
        }
        if coord:
            sid, lng, lat, district = coord
            row["station_id"] = sid
            row["longitude"] = lng
            row["latitude"] = lat
        else:
            row["station_id"] = name  # use name as fallback ID
            row["longitude"] = None
            row["latitude"] = None
        station_rows.append(row)

    station_df = (
        pd.DataFrame(station_rows)
        .drop_duplicates(subset=["station_id"], keep="last")
    )

    # Upsert stations (no geometry column here; geometry updated separately)
    with engine.connect() as conn:
        station_df.drop(columns=["longitude", "latitude"], errors="ignore").to_sql(
            "_tmp_noise_stations_d990101", conn,
            if_exists="replace", index=False, schema="public"
        )
        conn.execute(sa_text("""
            INSERT INTO env_noise_stations
                (station_id, station_name, city, district, noise_category,
                 monitoring_type, control_zone, standard_day_db, standard_evening_db,
                 standard_night_db, total_exceed_count, latest_year, latest_month,
                 source_name, source_url, data_time)
            SELECT
                station_id, station_name, city, district, noise_category,
                monitoring_type, control_zone, standard_day_db, standard_evening_db,
                standard_night_db, 0, latest_year,
                CASE latest_quarter
                    WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 9 WHEN 4 THEN 12
                END,
                source_name, source_url, data_time
            FROM _tmp_noise_stations_d990101
            ON CONFLICT (station_id) DO UPDATE SET
                latest_year  = EXCLUDED.latest_year,
                latest_month = EXCLUDED.latest_month,
                district     = COALESCE(EXCLUDED.district, env_noise_stations.district),
                data_time    = EXCLUDED.data_time
        """).execution_options(autocommit=True))
        conn.execute(sa_text(
            "DROP TABLE IF EXISTS _tmp_noise_stations_d990101"
        ).execution_options(autocommit=True))

    # Update geometry for stations that have coords but no geometry yet.
    # Use ST_MakePoint directly to avoid WKTElement serialisation issues.
    if coord_map:
        with engine.connect() as conn:
            missing = pd.read_sql(
                "SELECT station_id FROM env_noise_stations "
                "WHERE city = '臺北市' AND wkb_geometry IS NULL",
                conn,
            )
        updated = 0
        with engine.connect() as conn:
            for name, (sid, lng, lat, *_) in coord_map.items():
                if sid not in missing["station_id"].values:
                    continue
                conn.execute(sa_text(
                    "UPDATE env_noise_stations "
                    "SET wkb_geometry = ST_SetSRID(ST_MakePoint(:lng, :lat), 4326), "
                    "    geocode_quality = 'open_data' "
                    "WHERE station_id = :sid AND wkb_geometry IS NULL"
                ).execution_options(autocommit=True),
                    lng=float(lng), lat=float(lat), sid=str(sid),
                )
                updated += 1
        print("Updated geometry for %d Taipei stations." % updated)

    try:
        update_lasttime_in_data_to_dataset_info(
            engine, dag_id, str(df["data_time"].max())
        )
    except Exception as e:
        print("Warning: could not update dataset_info (expected in test env): %s" % e)
    print("D990101: %d quarterly stat rows, %d station upserts." % (
        len(df), len(station_rows)))


dag = CommonDag(proj_folder="proj_city_dashboard", dag_folder="D990101")
dag.create_dag(etl_func=_D990101)
