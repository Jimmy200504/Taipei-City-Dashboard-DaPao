from airflow import DAG
from operators.common_pipeline import CommonDag


NOISE_STANDARDS = {
    ("traffic", "一"): (71, 69, 63),
    ("traffic", "二"): (71, 69, 63),
    ("traffic", "三"): (74, 70, 67),
    ("traffic", "四"): (76, 75, 72),
    ("environmental", "一"): (55, 50, 45),
    ("environmental", "二"): (55, 50, 45),
    ("environmental", "三"): (60, 55, 50),
    ("environmental", "四"): (65, 60, 55),
    ("environmental", "五"): (75, 70, 65),
}

NEW_TAIPEI_DISTRICT_CENTROIDS = {
    "板橋區": (121.4592, 25.0127), "三重區": (121.4882, 25.0615),
    "中和區": (121.4987, 24.9965), "永和區": (121.5166, 25.0086),
    "新莊區": (121.4494, 25.0350), "新店區": (121.5389, 24.9718),
    "樹林區": (121.4165, 24.9896), "鶯歌區": (121.3449, 24.9530),
    "三峽區": (121.3712, 24.9364), "淡水區": (121.4498, 25.1699),
    "汐止區": (121.6584, 25.0669), "瑞芳區": (121.8025, 25.1084),
    "土城區": (121.4387, 24.9736), "蘆洲區": (121.4720, 25.0840),
    "五股區": (121.4376, 25.0780), "泰山區": (121.4275, 25.0523),
    "林口區": (121.3875, 25.0784), "深坑區": (121.6138, 24.9943),
    "石碇區": (121.6619, 24.9768), "坪林區": (121.7136, 24.9326),
    "三芝區": (121.4988, 25.2528), "石門區": (121.5686, 25.2930),
    "八里區": (121.4007, 25.1477), "平溪區": (121.7375, 25.0218),
    "雙溪區": (121.8685, 25.0304), "貢寮區": (121.9040, 25.0272),
    "金山區": (121.6344, 25.2205), "萬里區": (121.6829, 25.1786),
    "烏來區": (121.5516, 24.8637),
}

_ROC_OFFSET = 1911


def _D990102(**kwargs):
    import io, re
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

    try:
        import pdfplumber
    except ImportError:
        raise ImportError("pip install pdfplumber required for D990102")

    HEADERS = {"User-Agent": "Mozilla/5.0 (compatible; TaipeiDashboard/1.0)"}
    LIST_URL = (
        "https://www.epd.ntpc.gov.tw/IntegratedContentCenter/noisestats"
        "?categoryId=6ca80917-078a-4bd6-8a54-f67cb75d8d80"
    )
    MANUAL_URL = "https://www.epd.ntpc.gov.tw/StaticPage/manual-stations"
    AUTO_URL   = "https://www.epd.ntpc.gov.tw/StaticPage/auto-stations"

    # ── helpers ──────────────────────────────────────────────────────────────

    def parse_cell(raw):
        if not raw:
            return None, False
        s = str(raw).strip()
        if s in ("-", "---", "–", ""):
            return None, False
        exceeded = "*" in s
        try:
            return float(s.replace("*", "").strip()), exceeded
        except ValueError:
            return None, False

    def quarterly_avg(month_vals):
        """Average non-None values per quarter from a 12-element list."""
        result = []
        for q in range(4):
            vals = [v for v in month_vals[q*3:(q+1)*3] if v is not None]
            result.append(round(sum(vals)/len(vals), 1) if vals else None)
        return result

    def fetch_pdfs(session):
        """
        Visit the listing page, then collect all noise PDFs grouped by CE year.
        Handles two formats:
          - Annual report:  noisedata_YYY.pdf   (ROC year YYY)
          - Monthly upload: YYY.MM噪音量上傳表格.pdf (ROC year YYY, month MM)
        For each CE year, prefers the monthly upload with the highest month
        (more complete), falling back to the annual report.
        Returns list of (ce_year, pdf_bytes, pdf_url) sorted by year ascending.
        """
        resp = session.get(LIST_URL, headers=HEADERS, timeout=30)
        resp.raise_for_status()
        soup = BeautifulSoup(resp.text, "html.parser")

        # Collect all noise PDF candidates: {ce_year: [(priority, href), ...]}
        year_candidates = {}

        seen_hrefs = set()
        for a in soup.find_all("a", href=True):
            text = a.get_text(strip=True)
            href = a["href"]
            if href in seen_hrefs:
                continue
            seen_hrefs.add(href)

            # Annual report: noisedata_YYY.pdf  (priority 0 = lower)
            m = re.search(r"noisedata_(\d+)\.pdf", href, re.IGNORECASE)
            if m:
                ce_year = int(m.group(1)) + _ROC_OFFSET
                year_candidates.setdefault(ce_year, []).append((0, href))
                continue

            # Monthly upload: YYY.MM噪音量... (priority = month number = higher is better)
            m2 = re.match(r"(\d{3})\.(\d{2})", text)
            if m2 and "噪音量" in text:
                ce_year = int(m2.group(1)) + _ROC_OFFSET
                month = int(m2.group(2))
                year_candidates.setdefault(ce_year, []).append((month, href))

        if not year_candidates:
            raise ValueError("No noise PDFs found on New Taipei noise stats page.")

        # For each year pick the best candidate (highest priority = most recent month)
        results = []
        current_year = datetime.datetime.now().year
        for ce_year in sorted(year_candidates):
            if ce_year < current_year - 2:   # keep only last 3 years
                continue
            best_priority, best_href = sorted(year_candidates[ce_year], reverse=True)[0]
            full_url = "https://www.epd.ntpc.gov.tw" + best_href
            print(f"Downloading year {ce_year} (priority={best_priority}) ...")
            r = session.get(full_url, headers={**HEADERS, "Referer": LIST_URL}, timeout=120)
            r.raise_for_status()
            if not r.content.startswith(b"%PDF"):
                print(f"  Warning: not a PDF, skipping year {ce_year}")
                continue
            results.append((ce_year, io.BytesIO(r.content), full_url))
            print(f"  OK ({len(r.content)//1024} KB)")

        if not results:
            raise ValueError("No valid PDFs downloaded.")
        return results

    def parse_pdf(pdf_bytes, report_year):
        """
        Parse the New Taipei annual noise PDF.

        PDF layout (confirmed from noisedata_113.pdf):
        - Single landscape page, 6 tables, each 18 rows × 20 cols
        - Each table: 5 station groups, each occupying 4 columns
          col i*4+0: row label  (測站名稱/測站編號/管制區別/時段/1月…12月/標準)
          col i*4+1: 日 values  (or station name / id / zone)
          col i*4+2: 晚 values
          col i*4+3: 夜 values
        - Row 0:  title (contains 交通 or 環境)
        - Row 1:  測站名稱
        - Row 2:  測站編號
        - Row 3:  管制區別
        - Row 4:  時段/日/晚/夜 header
        - Rows 5-16: months 1月–12月
        - Row 17: noise standards
        - Tables 0-2: traffic noise (TN), Tables 3-5: environmental noise (EN)
        """
        records = []
        stations = {}

        with pdfplumber.open(pdf_bytes) as pdf:
            for page in pdf.pages:
                for ti, table in enumerate(page.extract_tables() or []):
                    if len(table) < 16 or not table[0]:
                        continue

                    # Determine noise category from title row.
                    # PDF text has spaces between Chinese chars (e.g. '交 通'), so strip them.
                    title = "".join(str(c) for c in table[0] if c).replace(" ", "")
                    if "交通" in title:
                        noise_category = "traffic"
                    elif "環境" in title:
                        noise_category = "environmental"
                    else:
                        continue

                    n_cols = len(table[0])
                    # Each station group is 4 columns wide
                    n_stations = n_cols // 4

                    for si in range(n_stations):
                        lc = si * 4      # label column
                        dc = si * 4 + 1  # 日 column
                        ec = si * 4 + 2  # 晚 column
                        nc = si * 4 + 3  # 夜 column

                        def cell(ri, ci):
                            try:
                                v = table[ri][ci]
                                return str(v).strip() if v else ""
                            except IndexError:
                                return ""

                        station_name = cell(1, dc)
                        station_id   = cell(2, dc)
                        control_zone = cell(3, dc)

                        # Skip placeholder / empty slots
                        if not station_id or station_id in ("※", "-", ""):
                            continue
                        if not station_name or station_name in ("※", "-"):
                            continue

                        # Collect 12 months of day/evening/night values
                        day_monthly = []
                        eve_monthly = []
                        ngt_monthly = []
                        for month_idx in range(12):
                            ri = 5 + month_idx  # rows 5-16 = months 1-12
                            d, _ = parse_cell(cell(ri, dc))
                            e, _ = parse_cell(cell(ri, ec))
                            n, _ = parse_cell(cell(ri, nc))
                            day_monthly.append(d)
                            eve_monthly.append(e)
                            ngt_monthly.append(n)

                        day_q = quarterly_avg(day_monthly)
                        eve_q = quarterly_avg(eve_monthly)
                        ngt_q = quarterly_avg(ngt_monthly)

                        std = NOISE_STANDARDS.get((noise_category, control_zone), (None, None, None))

                        if station_id not in stations:
                            stations[station_id] = {
                                "station_id":          station_id,
                                "station_name":        station_name,
                                "city":                "新北市",
                                "noise_category":      noise_category,
                                "control_zone":        control_zone,
                                "monitoring_type":     "manual",
                                "standard_day_db":     std[0],
                                "standard_evening_db": std[1],
                                "standard_night_db":   std[2],
                                "source_name": "新北市環境保護局",
                            }

                        for qi in range(4):
                            for period, qvals in (("day", day_q), ("evening", eve_q), ("night", ngt_q)):
                                if qvals[qi] is None:
                                    continue
                                records.append({
                                    "station_name":   station_name,
                                    "noise_category": noise_category,
                                    "year":           report_year,
                                    "quarter":        qi + 1,
                                    "quarter_label":  f"{report_year}Q{qi+1}",
                                    "period":         period,
                                    "avg_db":         qvals[qi],
                                })

        return records, stations

    def scrape_station_addresses(session):
        addresses = {}
        for url in (MANUAL_URL, AUTO_URL):
            try:
                resp = session.get(url, headers=HEADERS, timeout=30)
                resp.raise_for_status()
                soup = BeautifulSoup(resp.text, "html.parser")
                for table in soup.find_all("table"):
                    for tr in table.find_all("tr")[1:]:
                        cells = [td.get_text(strip=True) for td in tr.find_all("td")]
                        if len(cells) >= 2:
                            addresses[cells[0]] = cells[1]
            except Exception as e:
                print(f"Warning: could not scrape station addresses from {url}: {e}")
        return addresses

    # ── Setup ─────────────────────────────────────────────────────────────────
    ready_data_db_uri = kwargs.get("ready_data_db_uri")
    dag_infos = kwargs.get("dag_infos")
    dag_id = dag_infos.get("dag_id")
    default_table = dag_infos.get("ready_data_default_table")

    engine = create_engine(ready_data_db_uri)
    session = requests.Session()

    # ── Extract: all available years (2024, 2025, 2026 Q1) ───────────────────
    pdf_list = fetch_pdfs(session)   # [(ce_year, pdf_bytes, pdf_url), ...]
    station_addresses = scrape_station_addresses(session)
    now_ts = pd.Timestamp.now(tz="Asia/Taipei")

    all_records = []
    all_raw_stations = {}
    latest_source_url = {}  # station_id -> most recent pdf_url

    for report_year, pdf_bytes, pdf_url in pdf_list:
        raw_records, raw_stations = parse_pdf(pdf_bytes, report_year)
        print(f"  year {report_year}: {len(raw_records)} records, {len(raw_stations)} stations")
        all_records.extend(raw_records)
        for sid, s in raw_stations.items():
            if sid not in all_raw_stations or report_year >= all_raw_stations[sid].get("_yr", 0):
                all_raw_stations[sid] = {**s, "_yr": report_year}
                latest_source_url[sid] = pdf_url

    if not all_records:
        print("No records parsed from any PDF; aborting.")
        return

    # ── Transform ─────────────────────────────────────────────────────────────
    quarterly_df = (
        pd.DataFrame(all_records)
        .drop_duplicates(
            subset=["station_name", "noise_category", "year", "quarter", "period"],
            keep="last",
        )
    )
    quarterly_df["data_time"] = now_ts

    station_df = pd.DataFrame([
        {**{k: v for k, v in s.items() if k != "_yr"},
         "source_url": latest_source_url.get(s["station_id"], ""),
         "address":    station_addresses.get(s["station_name"])}
        for s in all_raw_stations.values()
    ])

    # Compute latest_year and latest_month per station
    latest = (
        quarterly_df.groupby("station_name")
        .apply(lambda g: g.nlargest(1, ["year", "quarter"])[["year", "quarter"]].iloc[0])
        .reset_index()
    )
    station_df = station_df.merge(
        latest.rename(columns={"year": "latest_year", "quarter": "latest_quarter"}),
        on="station_name", how="left"
    )
    station_df["latest_year"]  = station_df["latest_year"].fillna(now_ts.year - 1).astype(int)
    station_df["latest_month"] = (station_df["latest_quarter"].fillna(4).astype(int) * 3)
    station_df["data_time"] = now_ts

    # ── Load: quarterly stats ─────────────────────────────────────────────────
    affected_years = sorted(quarterly_df["year"].unique().tolist())
    with engine.connect() as conn:
        for yr in affected_years:
            conn.execute(sa_text(
                f"DELETE FROM {default_table} WHERE year = {yr}"
            ).execution_options(autocommit=True))

    save_dataframe_to_postgresql(
        engine, data=quarterly_df, load_behavior="append",
        default_table=default_table
    )
    print(f"Saved {len(quarterly_df)} quarterly rows for years {affected_years}.")

    # ── Load: station master ──────────────────────────────────────────────────
    station_upsert = (
        station_df
        .drop(columns=["address", "latest_quarter"], errors="ignore")
        .drop_duplicates(subset=["station_id"], keep="last")
    )
    with engine.connect() as conn:
        station_upsert.to_sql(
            "_tmp_noise_stations_d990102", conn,
            if_exists="replace", index=False, schema="public"
        )
        conn.execute(sa_text("""
            INSERT INTO env_noise_stations
                (station_id, station_name, city, district, noise_category,
                 monitoring_type, control_zone, standard_day_db, standard_evening_db,
                 standard_night_db, total_exceed_count, latest_year, latest_month,
                 source_name, source_url, data_time)
            SELECT
                station_id, station_name, city, NULL, noise_category,
                monitoring_type, control_zone, standard_day_db, standard_evening_db,
                standard_night_db, 0, latest_year, latest_month,
                source_name, source_url, data_time
            FROM _tmp_noise_stations_d990102
            ON CONFLICT (station_id) DO UPDATE SET
                latest_year  = EXCLUDED.latest_year,
                latest_month = EXCLUDED.latest_month,
                data_time    = EXCLUDED.data_time
        """).execution_options(autocommit=True))
        conn.execute(sa_text(
            "DROP TABLE IF EXISTS _tmp_noise_stations_d990102"
        ).execution_options(autocommit=True))

    # ── Coordinate update ─────────────────────────────────────────────────────
    coord_map = {}    # station_id -> (lng, lat, quality)
    district_map = {}  # station_id -> district (from MOENV address field)

    def extract_district_from_address(address):
        """Extract district from MOENV address string.
        Handles: '新北市永和區...' → '永和區'
                 '板橋市...' (old format) → '板橋區'
        """
        if not address:
            return None
        import re as _re
        # Modern format: 新北市XXX區/鄉/鎮/市
        m = _re.search(r"新北[縣市](\S+?[區鄉鎮市])", address)
        if m:
            name = m.group(1)
            # Normalize 鄉/鎮/市 → 區 for New Taipei administrative districts
            if not name.endswith("區"):
                name = name[:-1] + "區"
            return name
        # Old format without city prefix: 'XXX市...' or 'XXX鄉...'
        m2 = _re.match(r"^(\S+?[市鄉鎮])(.)", address)
        if m2:
            name = m2.group(1)
            if not name.endswith("區"):
                name = name[:-1] + "區"
            return name
        return None

    try:
        from airflow.models import Variable
        moenv_key = Variable.get("MOENV_API_KEY", default_var=None)
        if moenv_key:
            for dataset_id in ("GISEPA_P_18", "GISEPA_P_19"):
                url = (f"https://data.moenv.gov.tw/api/v2/{dataset_id}"
                       f"?api_key={moenv_key}&format=json&limit=1000")
                r = session.get(url, headers=HEADERS, timeout=30)
                r.raise_for_status()
                body = r.json()
                recs = body.get("records", []) if isinstance(body, dict) else body
                for rec in recs:
                    if "新北" not in str(rec.get("city", "")):
                        continue
                    sid = str(rec.get("no", "")).strip()
                    if not sid:
                        continue
                    try:
                        coord_map[sid] = (float(rec["longitude"]), float(rec["latitude"]), "open_data")
                    except (KeyError, TypeError, ValueError):
                        pass
                    district = extract_district_from_address(rec.get("address", ""))
                    if district:
                        district_map[sid] = district
            print(f"Fetched {len(coord_map)} coords, {len(district_map)} districts from MOENV API.")
    except Exception as e:
        print(f"Warning: MOENV coord fetch skipped: {e}")

    with engine.connect() as conn:
        missing = pd.read_sql(
            "SELECT station_id, district FROM env_noise_stations "
            "WHERE city = '新北市' AND wkb_geometry IS NULL",
            conn,
        )

    geo_rows = []
    for _, row in missing.iterrows():
        sid = row["station_id"]
        if sid in coord_map:
            lng, lat, quality = coord_map[sid]
        else:
            centroid = NEW_TAIPEI_DISTRICT_CENTROIDS.get(row["district"])
            if not centroid:
                continue
            lng, lat = centroid
            quality = "district_centroid"
        geo_rows.append({"station_id": sid, "longitude": lng,
                          "latitude": lat, "geocode_quality": quality})

    if geo_rows:
        with engine.connect() as conn:
            for row in geo_rows:
                conn.execute(sa_text(
                    "UPDATE env_noise_stations "
                    "SET wkb_geometry = ST_SetSRID(ST_MakePoint(:lng, :lat), 4326), "
                    "    geocode_quality = :quality "
                    "WHERE station_id = :sid AND wkb_geometry IS NULL"
                ).execution_options(autocommit=True),
                    lng=float(row["longitude"]), lat=float(row["latitude"]),
                    quality=row["geocode_quality"], sid=str(row["station_id"]),
                )
        print(f"Updated geometry for {len(geo_rows)} New Taipei stations.")

    # Update district for New Taipei stations from MOENV address field
    if district_map:
        with engine.connect() as conn:
            updated = 0
            for sid, district in district_map.items():
                result = conn.execute(sa_text(
                    "UPDATE env_noise_stations SET district = :d "
                    "WHERE station_id = :sid AND (district IS NULL OR district = '')"
                ).execution_options(autocommit=True),
                    d=district, sid=sid,
                )
                updated += result.rowcount
        print(f"Updated district for {updated} New Taipei stations from MOENV addresses.")

    try:
        update_lasttime_in_data_to_dataset_info(engine, dag_id, str(now_ts))
    except Exception as e:
        print(f"Warning: could not update dataset_info (expected in test env): {e}")

    print(f"D990102 done: {len(quarterly_df)} quarterly rows, "
          f"{len(station_df)} stations, years={affected_years}.")


dag = CommonDag(proj_folder="proj_city_dashboard", dag_folder="D990102")
dag.create_dag(etl_func=_D990102)
