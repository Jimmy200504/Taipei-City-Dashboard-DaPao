import html as html_module
import json
import logging
import math
import os
import re
import time
from typing import Dict, List, NamedTuple, Optional, Tuple

import geopandas as gpd
import pandas as pd
import requests
from shapely.geometry import LineString, Point
from shapely.ops import substring

logger = logging.getLogger(__name__)

MOENV_RIVER_STATIONS_URL = (
    "https://wq.moenv.gov.tw/EWQP_GIS/dataFile/AJAX_Main.aspx"
    "?Type=Get_point_WQStation_River"
)
MOENV_RIVER_EXT_STATIONS_URL = (
    "https://wq.moenv.gov.tw/EWQP_GIS/dataFile/AJAX_Main.aspx"
    "?Type=Get_point_WQStation_Ext_River"
)
MOENV_RIVER_DETAIL_URL_TEMPLATE = (
    "https://wq.moenv.gov.tw/EWQP/zh/EnvWaterMonitoring/RiverWaterQuality.aspx"
    "?Func=FromGIS&Qry={site_id}&Parent1={mgmt_id}&Parent2="
)
MOENV_DETAIL_USER_AGENT = (
    "Mozilla/5.0 (compatible; TaipeiCityDashboard/1.0; "
    "+https://citydashboard.taipei)"
)

WRA_RIVER_SHAPEFILE_URL = (
    "https://gic.wra.gov.tw/gis/gic/API/Google/DownLoad.aspx"
    "?fname=RIVER&filetype=SHP"
)
WRA_RIVER_CRS = "EPSG:3826"

RIVER_NAME_ALIAS = {
    "淡水河本流": "淡水河",
    "三峽河": "三峽溪",
}

SOURCE_NAME = "環境部"
SOURCE_LABEL_MOENV_RIVER = "moenv_river"
SOURCE_LABEL_MOENV_EXT_RIVER = "moenv_ext_river"
RPI_METHOD_SOURCE_WQ_INDEX = "source_wq_index"
RPI_METHOD_CALCULATED_FROM_ITEMS = "calculated_from_items"
DO_METHOD_EXT_ENDPOINT = "ext_endpoint"
DO_METHOD_DETAIL_ELECTRODE = "detail_electrode"
DO_METHOD_DETAIL_TITRATION = "detail_titration"
EXT_SITE_ID_PREFIX = "ext"
TARGET_CITIES = ("臺北市", "新北市")

RPI_FLAG_COMPLETE = "complete"
RPI_FLAG_INCOMPLETE = "incomplete"
GEOMETRY_SOURCE_REAL_RIVER = "real_river"
GEOMETRY_SOURCE_STRAIGHT_LINE = "straight_line"
GEOMETRY_SOURCE_CURATED_ROUTE = "curated_route"

RISK_LEVEL_MAP = {
    "未（稍）受污染": ("unpolluted", 1),
    "未(稍)受污染": ("unpolluted", 1),
    "輕度污染": ("mild", 2),
    "中度污染": ("moderate", 3),
    "嚴重污染": ("severe", 4),
}

INCOMPLETE_LABEL = "無檢測資料"
EXT_INCOMPLETE_LABEL = "近期無檢測資料"
EXT_MISSING_VALUE_TOKENS = {"－", "-", "—", "N/A", "NA"}

STATION_OFF_RIVER_TOLERANCE_M = 1500.0
ROUTE_ENDPOINT_SNAP_TOLERANCE_M = 750.0
SITE_ENDPOINT_EXPORT_TOLERANCE_M = 75.0

_MONTH_PATTERN = re.compile(r"(\d{3,4})\s*年\s*(\d{1,2})\s*月")

_SITE_COLUMNS = [
    "source_name",
    "source_label",
    "city",
    "district",
    "basin",
    "river",
    "site_id",
    "site_name",
    "site_name_en",
    "site_address",
    "status_of_use",
    "wq_std_grade",
    "longitude",
    "latitude",
    "data_time",
]

_LATEST_COLUMNS = [
    "source_name",
    "source_label",
    "rpi_method",
    "city",
    "district",
    "basin",
    "river",
    "river_id",
    "station_order",
    "site_id",
    "site_name",
    "wq_std_grade",
    "sample_month",
    "rpi_value",
    "risk_level",
    "risk_level_order",
    "rpi_flag",
    "do_value",
    "bod5_value",
    "ss_value",
    "nh3n_value",
    "conductivity_value",
    "do_score",
    "bod5_score",
    "ss_score",
    "nh3n_score",
    "do_method",
    "data_time",
    "longitude",
    "latitude",
]

_INDICATOR_COLUMNS = (
    "do_value",
    "bod5_value",
    "ss_value",
    "nh3n_value",
    "conductivity_value",
    "do_score",
    "bod5_score",
    "ss_score",
    "nh3n_score",
    "do_method",
)

_SEGMENT_COLUMNS = [
    "segment_id",
    "river_id",
    "river",
    "basin",
    "upstream_site_id",
    "upstream_site_name",
    "upstream_city",
    "upstream_rpi",
    "downstream_site_id",
    "downstream_site_name",
    "downstream_city",
    "downstream_rpi",
    "sample_month",
    "geometry_source",
    "data_time",
    "wkb_geometry",
]


class _Projection(NamedTuple):
    feature_idx: int
    t_along: float
    dist_m: float
    nearest_pt: Point


def fetch_river_station_records(
    session: Optional[requests.Session] = None,
    timeout: int = 30,
) -> list:
    return _fetch_moenv_records(MOENV_RIVER_STATIONS_URL, session, timeout)


def fetch_river_ext_station_records(
    session: Optional[requests.Session] = None,
    timeout: int = 30,
) -> list:
    return _fetch_moenv_records(MOENV_RIVER_EXT_STATIONS_URL, session, timeout)


def _fetch_moenv_records(
    url: str,
    session: Optional[requests.Session],
    timeout: int,
) -> list:
    sess = session or requests.Session()
    response = sess.get(url, timeout=timeout)
    response.raise_for_status()
    payload = response.json()
    if not isinstance(payload, list):
        raise ValueError(f"MOENV endpoint {url!r} returned non-list payload.")
    return payload


def parse_month_date(value):
    if value is None:
        return None
    text = str(value).strip()
    if not text:
        return None
    match = _MONTH_PATTERN.search(text)
    if not match:
        return None
    year = int(match.group(1))
    month = int(match.group(2))
    if year < 1900:
        year += 1911
    if not 1 <= month <= 12:
        return None
    return pd.Timestamp(year=year, month=month, day=1).date()


def map_risk_level(value) -> Tuple[Optional[str], Optional[int], str]:
    if value is None:
        return None, None, RPI_FLAG_INCOMPLETE
    text = str(value).strip()
    if not text or text == INCOMPLETE_LABEL:
        return None, None, RPI_FLAG_INCOMPLETE
    if text in RISK_LEVEL_MAP:
        level, order = RISK_LEVEL_MAP[text]
        return level, order, RPI_FLAG_COMPLETE
    return None, None, RPI_FLAG_INCOMPLETE


def _to_numeric_or_none(value):
    result = pd.to_numeric(value, errors="coerce")
    if pd.isna(result):
        return None
    return float(result)


def _to_str_or_none(value):
    if value is None:
        return None
    text = str(value).strip()
    return text or None


def normalize_records(records: list, data_time: str) -> Tuple[pd.DataFrame, pd.DataFrame]:
    if not records:
        return pd.DataFrame(columns=_SITE_COLUMNS), pd.DataFrame(columns=_LATEST_COLUMNS)

    df = pd.DataFrame(records)
    df = df[df["County_Name"].isin(TARGET_CITIES)].copy()
    if df.empty:
        return pd.DataFrame(columns=_SITE_COLUMNS), pd.DataFrame(columns=_LATEST_COLUMNS)

    df["site_id"] = df["Station_ID"].astype(str).str.strip()
    df = df[df["site_id"] != ""].drop_duplicates(subset=["site_id"], keep="last")

    df["source_name"] = SOURCE_NAME
    df["source_label"] = SOURCE_LABEL_MOENV_RIVER
    df["rpi_method"] = RPI_METHOD_SOURCE_WQ_INDEX
    df["city"] = df["County_Name"]
    df["district"] = df["Town_Cname"]
    df["basin"] = df["Basin_Name"]
    df["river"] = df["River_Name"]
    df["river_id"] = df["River_ID"].map(_to_str_or_none)
    df["station_order"] = pd.to_numeric(df["Station_Order"], errors="coerce").astype("Int64")
    df["site_name"] = df["Station_Name"]
    df["site_name_en"] = df["Station_EName"]
    df["site_address"] = df["Station_Address"]
    df["status_of_use"] = df["測站使用狀態"]
    df["wq_std_grade"] = df["Wqstd_Name"]
    df["longitude"] = df["Gis_X"].map(_to_numeric_or_none)
    df["latitude"] = df["Gis_Y"].map(_to_numeric_or_none)
    df["data_time"] = data_time

    df["sample_month"] = df["MonthDate_Dec"].map(parse_month_date)

    df["rpi_value"] = df["WQ_Index"].map(_to_numeric_or_none)
    risk_mapping = df["WQ_Index_Dec"].map(map_risk_level)
    df["risk_level"] = risk_mapping.map(lambda triple: triple[0])
    df["risk_level_order"] = risk_mapping.map(lambda triple: triple[1]).astype("Int64")
    df["rpi_flag"] = risk_mapping.map(lambda triple: triple[2])
    rpi_missing = df["rpi_value"].isna()
    df.loc[rpi_missing, "rpi_flag"] = RPI_FLAG_INCOMPLETE
    df.loc[rpi_missing, "risk_level"] = None
    df.loc[rpi_missing, "risk_level_order"] = pd.NA

    for col in _INDICATOR_COLUMNS:
        df[col] = None

    return df[_SITE_COLUMNS].copy(), df[_LATEST_COLUMNS].copy()


def _strip_ext_site_id(site_id: str) -> Optional[Tuple[str, str]]:
    """Reverse the ``ext:{SiteMgt_ID}:{SiteID}`` prefix back to its parts."""
    if not isinstance(site_id, str):
        return None
    parts = site_id.split(":", 2)
    if len(parts) != 3 or parts[0] != EXT_SITE_ID_PREFIX:
        return None
    if not parts[1] or not parts[2]:
        return None
    return parts[1], parts[2]


_DETAIL_DO_PATTERN = re.compile(
    r">\s*溶氧\s*\(\s*(電極法|滴定法)\s*\)\s*<.*?<dd[^>]*>(.*?)</dd>",
    re.DOTALL,
)
_DETAIL_DDL_PATTERN_TEMPLATE = (
    r"name=\"ctl00\$CPH1\${field}\"[^>]*>(.*?)</select>"
)
_DETAIL_SELECTED_OPTION_PATTERN = re.compile(
    r'<option\b(?=[^>]*\bselected\b)[^>]*\bvalue="([^"]+)"',
    re.IGNORECASE,
)


def fetch_river_detail_page(
    site_id: str,
    mgmt_id: str,
    session: Optional[requests.Session] = None,
    timeout: int = 20,
) -> str:
    """GET the per-site MOENV detail page and return the HTML body.

    The page defaults to the latest available month for the requested site.
    A custom User-Agent is sent because the upstream rejects empty UA strings.
    """
    if not site_id or not mgmt_id:
        raise ValueError("site_id and mgmt_id are required.")
    sess = session or requests.Session()
    url = MOENV_RIVER_DETAIL_URL_TEMPLATE.format(
        site_id=str(site_id), mgmt_id=str(mgmt_id)
    )
    response = sess.get(
        url, timeout=timeout, headers={"User-Agent": MOENV_DETAIL_USER_AGENT}
    )
    response.raise_for_status()
    return response.text


def parse_detail_page_year_month(html_text: str) -> Tuple[Optional[int], Optional[int]]:
    """Read the currently selected year/month from the detail page dropdowns."""
    if not html_text:
        return None, None
    year_year = _read_selected_dropdown(html_text, "ddl_Year")
    month_month = _read_selected_dropdown(html_text, "ddl_Month")
    year_int = _safe_int(year_year)
    month_int = _safe_int(month_month)
    return year_int, month_int


def _read_selected_dropdown(html_text: str, field: str) -> Optional[str]:
    pattern = re.compile(
        _DETAIL_DDL_PATTERN_TEMPLATE.format(field=re.escape(field)), re.DOTALL
    )
    block = pattern.search(html_text)
    if not block:
        return None
    sel = _DETAIL_SELECTED_OPTION_PATTERN.search(block.group(1))
    return sel.group(1) if sel else None


def _safe_int(value: Optional[str]) -> Optional[int]:
    if value is None:
        return None
    try:
        return int(str(value).strip())
    except (TypeError, ValueError):
        return None


def parse_do_from_detail_html(
    html_text: str,
) -> Tuple[Optional[float], Optional[str]]:
    """Extract DO from the detail-page data cards.

    Returns ``(value, method)`` where ``method`` is
    ``DO_METHOD_DETAIL_ELECTRODE`` or ``DO_METHOD_DETAIL_TITRATION``.
    Electrode (電極法) is preferred and returned first when available;
    titration (滴定法) is the fallback. ``(None, None)`` if neither method
    has a usable numeric value.
    """
    if not html_text:
        return None, None

    found: Dict[str, Optional[float]] = {
        DO_METHOD_DETAIL_ELECTRODE: None,
        DO_METHOD_DETAIL_TITRATION: None,
    }
    for method_label, raw_value in _DETAIL_DO_PATTERN.findall(html_text):
        method_key = (
            DO_METHOD_DETAIL_ELECTRODE
            if "電極" in method_label
            else DO_METHOD_DETAIL_TITRATION
        )
        if found[method_key] is not None:
            continue
        parsed = parse_indicator_value(html_module.unescape(raw_value).strip())
        if parsed is not None:
            found[method_key] = parsed

    if found[DO_METHOD_DETAIL_ELECTRODE] is not None:
        return found[DO_METHOD_DETAIL_ELECTRODE], DO_METHOD_DETAIL_ELECTRODE
    if found[DO_METHOD_DETAIL_TITRATION] is not None:
        return found[DO_METHOD_DETAIL_TITRATION], DO_METHOD_DETAIL_TITRATION
    return None, None


def enrich_ext_do_from_detail_pages(
    latest_df: pd.DataFrame,
    session: Optional[requests.Session] = None,
    fetch_fn=None,
) -> pd.DataFrame:
    """Fill missing DO on Ext rows by scraping the per-site MOENV detail page.

    Only rows that satisfy ALL of these are touched:

    - ``source_label == 'moenv_ext_river'``
    - ``do_value`` is missing
    - ``sample_month`` is set (skip stations with no recent data)
    - At least one of BOD5/SS/NH3-N is present (no point burning HTTP for
      stations whose other indicators are also missing)

    For each touched row, the page's currently selected year/month must
    match the row's ``sample_month``; otherwise the page is showing stale
    data and we leave the row alone.

    On success, ``do_value`` / ``do_score`` / ``do_method`` are set, and
    ``rpi_value`` / ``risk_level`` / ``risk_level_order`` / ``rpi_flag``
    are recomputed from the four updated indicator scores.

    HTTP failures are logged and the row is left unchanged; the DAG does
    not fail because of detail-page issues.

    ``fetch_fn`` is an injection point for tests (default uses
    :func:`fetch_river_detail_page`).
    """
    if latest_df is None or latest_df.empty:
        return latest_df

    if "source_label" not in latest_df.columns:
        return latest_df

    if fetch_fn is None:
        sess = session or requests.Session()

        def fetch_fn(site_id, mgmt_id):
            return fetch_river_detail_page(site_id, mgmt_id, session=sess)

    df = latest_df.copy()
    target_mask = (
        (df["source_label"] == SOURCE_LABEL_MOENV_EXT_RIVER)
        & df["do_value"].isna()
        & df["sample_month"].notna()
        & (
            df["bod5_value"].notna()
            | df["ss_value"].notna()
            | df["nh3n_value"].notna()
        )
    )
    target_indexes = df.index[target_mask].tolist()
    if not target_indexes:
        return df

    logger.info(
        "Attempting DO enrichment from MOENV detail pages for %d Ext rows.",
        len(target_indexes),
    )

    recovered = 0
    for idx in target_indexes:
        row = df.loc[idx]
        ids = _strip_ext_site_id(row["site_id"])
        if ids is None:
            continue
        mgmt_id, raw_site_id = ids

        try:
            html_text = fetch_fn(raw_site_id, mgmt_id)
        except requests.RequestException as exc:
            logger.warning(
                "Detail-page fetch failed for %s: %s", row["site_id"], exc
            )
            continue
        except Exception as exc:
            logger.warning(
                "Detail-page fetch raised unexpectedly for %s: %s",
                row["site_id"],
                exc,
            )
            continue

        page_year, page_month = parse_detail_page_year_month(html_text)
        sample = row["sample_month"]
        sample_year = getattr(sample, "year", None)
        sample_month_int = getattr(sample, "month", None)
        if (
            page_year is None
            or page_month is None
            or page_year != sample_year
            or page_month != sample_month_int
        ):
            logger.info(
                "Detail page month mismatch for %s: page=%s-%s sample=%s-%s",
                row["site_id"],
                page_year,
                page_month,
                sample_year,
                sample_month_int,
            )
            continue

        do_value, do_method = parse_do_from_detail_html(html_text)
        if do_value is None:
            continue

        df.at[idx, "do_value"] = do_value
        df.at[idx, "do_method"] = do_method
        df.at[idx, "do_score"] = score_do(do_value)

        new_rpi, new_scores, complete = compute_rpi_from_items(
            do_value,
            row["bod5_value"],
            row["ss_value"],
            row["nh3n_value"],
        )
        df.at[idx, "bod5_score"] = new_scores["bod5_score"]
        df.at[idx, "ss_score"] = new_scores["ss_score"]
        df.at[idx, "nh3n_score"] = new_scores["nh3n_score"]
        df.at[idx, "rpi_value"] = new_rpi
        risk_level, risk_order = map_rpi_to_risk_level(new_rpi)
        df.at[idx, "risk_level"] = risk_level
        df.at[idx, "risk_level_order"] = (
            risk_order if risk_order is not None else pd.NA
        )
        df.at[idx, "rpi_flag"] = (
            RPI_FLAG_COMPLETE if complete else RPI_FLAG_INCOMPLETE
        )
        recovered += 1

    logger.info(
        "DO enrichment recovered %d / %d Ext rows.", recovered, len(target_indexes)
    )
    return df


def parse_indicator_value(value):
    """Parse a raw MOENV indicator string.

    `<X` (below detection limit) maps to 0 per user preference; full-width
    dashes, empty strings, NaN and None map to ``None``.
    """
    if value is None:
        return None
    try:
        if pd.isna(value):
            return None
    except (TypeError, ValueError):
        pass
    text = str(value).strip()
    if not text or text in EXT_MISSING_VALUE_TOKENS:
        return None
    if text.startswith("<"):
        return 0.0
    try:
        return float(text)
    except ValueError:
        return None


def _is_missing_number(value) -> bool:
    if value is None:
        return True
    try:
        return bool(pd.isna(value))
    except (TypeError, ValueError):
        return False


def score_do(value: Optional[float]) -> Optional[int]:
    if _is_missing_number(value):
        return None
    if value >= 6.5:
        return 1
    if value >= 4.6:
        return 3
    if value >= 2.0:
        return 6
    return 10


def score_bod5(value: Optional[float]) -> Optional[int]:
    if _is_missing_number(value):
        return None
    if value <= 3.0:
        return 1
    if value < 5.0:
        return 3
    if value <= 15.0:
        return 6
    return 10


def score_ss(value: Optional[float]) -> Optional[int]:
    if _is_missing_number(value):
        return None
    if value <= 20:
        return 1
    if value < 50:
        return 3
    if value <= 100:
        return 6
    return 10


def score_nh3n(value: Optional[float]) -> Optional[int]:
    if _is_missing_number(value):
        return None
    if value <= 0.50:
        return 1
    if value < 1.00:
        return 3
    if value <= 3.00:
        return 6
    return 10


def compute_rpi_from_items(
    do: Optional[float],
    bod5: Optional[float],
    ss: Optional[float],
    nh3n: Optional[float],
) -> Tuple[Optional[float], Dict[str, Optional[int]], bool]:
    """Compute average RPI from the four sub-indicators.

    Returns ``(rpi, scores, complete)``. ``complete`` is False when any of
    DO/BOD5/SS/NH3-N is missing; in that case ``rpi`` is None.
    """
    scores = {
        "do_score": score_do(do),
        "bod5_score": score_bod5(bod5),
        "ss_score": score_ss(ss),
        "nh3n_score": score_nh3n(nh3n),
    }
    if any(v is None for v in scores.values()):
        return None, scores, False
    rpi = sum(scores.values()) / 4.0
    return rpi, scores, True


def map_rpi_to_risk_level(rpi: Optional[float]) -> Tuple[Optional[str], Optional[int]]:
    """Map a numeric RPI value to (risk_level, risk_level_order).

    Thresholds: ``<=2`` unpolluted, ``>2..<=3`` mild, ``>3..<=6`` moderate,
    ``>6`` severe.
    """
    if _is_missing_number(rpi):
        return None, None
    if rpi <= 2:
        return "unpolluted", 1
    if rpi <= 3:
        return "mild", 2
    if rpi <= 6:
        return "moderate", 3
    return "severe", 4


def normalize_ext_records(
    records: list,
    data_time: str,
) -> Tuple[pd.DataFrame, pd.DataFrame]:
    """Normalize records from the Ext_River endpoint into the shared schema.

    Other-agency stations lack `River_ID`/`Station_Order`, so segment
    generation is not attempted for them. RPI is calculated from the four
    sub-indicator scores; conductivity is preserved for popup context only.
    Site IDs are prefixed with ``ext:{SiteMgt_ID}:{SiteID}`` to avoid
    collisions with official MOENV `Station_ID` values.
    """
    if not records:
        return pd.DataFrame(columns=_SITE_COLUMNS), pd.DataFrame(columns=_LATEST_COLUMNS)

    df = pd.DataFrame(records)
    if "New_County_Cname" not in df.columns:
        return pd.DataFrame(columns=_SITE_COLUMNS), pd.DataFrame(columns=_LATEST_COLUMNS)

    df = df[df["New_County_Cname"].isin(TARGET_CITIES)].copy()
    if df.empty:
        return pd.DataFrame(columns=_SITE_COLUMNS), pd.DataFrame(columns=_LATEST_COLUMNS)

    if "Coord_Type" in df.columns:
        coord_known = df["Coord_Type"].astype(str).str.strip()
        non_wgs84 = (coord_known != "") & (coord_known != "WGS84")
        if non_wgs84.any():
            logger.warning(
                "Skipping %d Ext_River records with Coord_Type != WGS84.",
                int(non_wgs84.sum()),
            )
            df = df[~non_wgs84].copy()
        if df.empty:
            return pd.DataFrame(columns=_SITE_COLUMNS), pd.DataFrame(columns=_LATEST_COLUMNS)

    df["raw_site_id"] = df["SiteID"].map(_to_str_or_none)
    df["site_mgt_id"] = df["SiteMgt_ID"].map(_to_str_or_none)
    df = df[df["raw_site_id"].notna() & df["site_mgt_id"].notna()].copy()
    if df.empty:
        return pd.DataFrame(columns=_SITE_COLUMNS), pd.DataFrame(columns=_LATEST_COLUMNS)

    df["site_id"] = (
        EXT_SITE_ID_PREFIX
        + ":"
        + df["site_mgt_id"].astype(str)
        + ":"
        + df["raw_site_id"].astype(str)
    )
    df = df.drop_duplicates(subset=["site_id"], keep="last")

    df["source_name"] = SOURCE_NAME
    df["source_label"] = SOURCE_LABEL_MOENV_EXT_RIVER
    df["rpi_method"] = RPI_METHOD_CALCULATED_FROM_ITEMS
    df["city"] = df["New_County_Cname"]
    df["district"] = None
    basin_series = df["Basin_Name"].map(_to_str_or_none) if "Basin_Name" in df.columns else None
    df["basin"] = basin_series
    df["river"] = basin_series
    df["river_id"] = None
    df["station_order"] = pd.array([pd.NA] * len(df), dtype="Int64")
    df["site_name"] = df["ChtName"].map(_to_str_or_none) if "ChtName" in df.columns else None
    df["site_name_en"] = (
        df["EngName"].map(_to_str_or_none) if "EngName" in df.columns else None
    )
    df["site_address"] = (
        df["Unit_Cname"].map(_to_str_or_none) if "Unit_Cname" in df.columns else None
    )
    df["status_of_use"] = None
    df["wq_std_grade"] = None
    df["longitude"] = df["Gis_X"].map(_to_numeric_or_none) if "Gis_X" in df.columns else None
    df["latitude"] = df["Gis_Y"].map(_to_numeric_or_none) if "Gis_Y" in df.columns else None
    df["data_time"] = data_time

    df["sample_month"] = df["MonthDate_Dec"].map(parse_month_date)

    df["do_value"] = df["Id_204"].map(parse_indicator_value)
    df["bod5_value"] = df["Id_206"].map(parse_indicator_value)
    df["ss_value"] = df["Id_202"].map(parse_indicator_value)
    df["nh3n_value"] = df["Id_209"].map(parse_indicator_value)
    df["conductivity_value"] = df["Id_107"].map(parse_indicator_value)

    rpi_results = [
        compute_rpi_from_items(do, bod5, ss, nh3n)
        for do, bod5, ss, nh3n in zip(
            df["do_value"], df["bod5_value"], df["ss_value"], df["nh3n_value"]
        )
    ]
    df["rpi_value"] = [r[0] for r in rpi_results]
    df["do_score"] = [r[1]["do_score"] for r in rpi_results]
    df["bod5_score"] = [r[1]["bod5_score"] for r in rpi_results]
    df["ss_score"] = [r[1]["ss_score"] for r in rpi_results]
    df["nh3n_score"] = [r[1]["nh3n_score"] for r in rpi_results]
    risk_mapping = df["rpi_value"].map(map_rpi_to_risk_level)
    df["risk_level"] = risk_mapping.map(lambda pair: pair[0])
    df["risk_level_order"] = risk_mapping.map(lambda pair: pair[1]).astype("Int64")
    df["rpi_flag"] = [
        RPI_FLAG_COMPLETE if r[2] else RPI_FLAG_INCOMPLETE for r in rpi_results
    ]
    df["do_method"] = [
        DO_METHOD_EXT_ENDPOINT if pd.notna(v) else None for v in df["do_value"]
    ]

    return df[_SITE_COLUMNS].copy(), df[_LATEST_COLUMNS].copy()


def merge_normalized_frames(
    frames_sites: List[pd.DataFrame],
    frames_latest: List[pd.DataFrame],
) -> Tuple[pd.DataFrame, pd.DataFrame]:
    sites = (
        pd.concat(frames_sites, ignore_index=True)
        if frames_sites
        else pd.DataFrame(columns=_SITE_COLUMNS)
    )
    latest = (
        pd.concat(frames_latest, ignore_index=True)
        if frames_latest
        else pd.DataFrame(columns=_LATEST_COLUMNS)
    )
    if not sites.empty:
        sites = sites.drop_duplicates(subset=["site_id"], keep="first")
    if not latest.empty:
        latest = latest.drop_duplicates(subset=["site_id"], keep="first")
    return sites, latest


def fetch_wra_river_geodataframe(
    cache_dir: str,
    ttl_days: int = 7,
    timeout: int = 120,
    session: Optional[requests.Session] = None,
) -> gpd.GeoDataFrame:
    os.makedirs(cache_dir, exist_ok=True)
    cache_path = os.path.join(cache_dir, "wra_river.zip")
    needs_download = True
    if os.path.exists(cache_path):
        age_days = (time.time() - os.path.getmtime(cache_path)) / 86400.0
        if age_days < ttl_days and os.path.getsize(cache_path) > 0:
            needs_download = False

    if needs_download:
        sess = session or requests.Session()
        tmp_path = cache_path + ".tmp"
        with sess.get(WRA_RIVER_SHAPEFILE_URL, stream=True, timeout=timeout) as resp:
            resp.raise_for_status()
            with open(tmp_path, "wb") as fh:
                for chunk in resp.iter_content(chunk_size=1 << 16):
                    if chunk:
                        fh.write(chunk)
        os.replace(tmp_path, cache_path)

    return gpd.read_file(f"zip://{cache_path}!river/river.shp")


def load_curated_route_geodataframe(path: str) -> Optional[gpd.GeoDataFrame]:
    if not path or not os.path.exists(path):
        return None
    return gpd.read_file(path)


def _straight_line_segment(upstream_row, downstream_row) -> LineString:
    return LineString(
        [
            (float(upstream_row["longitude"]), float(upstream_row["latitude"])),
            (float(downstream_row["longitude"]), float(downstream_row["latitude"])),
        ]
    )


def _station_point(station_row) -> Point:
    return Point(float(station_row["longitude"]), float(station_row["latitude"]))


def _haversine_meters(p1: Point, p2: Point) -> float:
    lat_mean = math.radians((p1.y + p2.y) / 2.0)
    dx = (p2.x - p1.x) * 111320.0 * math.cos(lat_mean)
    dy = (p2.y - p1.y) * 110540.0
    return math.hypot(dx, dy)


def _project_to_nearest_feature(point: Point, features: List[LineString]) -> _Projection:
    best: Optional[_Projection] = None
    for idx, line in enumerate(features):
        t = line.project(point)
        np_ = line.interpolate(t)
        d = _haversine_meters(point, np_)
        if best is None or d < best.dist_m:
            best = _Projection(idx, t, d, np_)
    return best


def _safe_substring(line: LineString, t_a: float, t_b: float) -> Optional[LineString]:
    if line is None or line.is_empty or line.length <= 0:
        return None
    a, b = sorted((t_a, t_b))
    a = max(0.0, min(a, line.length))
    b = max(0.0, min(b, line.length))
    if b - a < 1e-9:
        return None
    seg = substring(line, a, b)
    if seg is None or seg.is_empty:
        return None
    return seg


def _bridge_two_features(
    line_a: LineString, t_a: float, line_b: LineString, t_b: float
) -> Optional[LineString]:
    a_start = Point(line_a.coords[0])
    a_end = Point(line_a.coords[-1])
    b_start = Point(line_b.coords[0])
    b_end = Point(line_b.coords[-1])

    use_a_end = a_end.distance(line_b) <= a_start.distance(line_b)
    use_b_start = b_start.distance(line_a) <= b_end.distance(line_a)

    upstream_part = _safe_substring(line_a, t_a, line_a.length if use_a_end else 0.0)
    downstream_part = _safe_substring(
        line_b, 0.0 if use_b_start else line_b.length, t_b
    )

    coords: List[tuple] = []
    if upstream_part is not None:
        coords.extend(upstream_part.coords)
    if downstream_part is not None:
        for c in downstream_part.coords:
            if not coords or coords[-1] != c:
                coords.append(c)
    if len(coords) < 2:
        return None
    return LineString(coords)


def _real_river_geometry(
    features: List[LineString], proj_a: _Projection, proj_b: _Projection
) -> Optional[LineString]:
    if proj_a.feature_idx == proj_b.feature_idx:
        geom = _safe_substring(features[proj_a.feature_idx], proj_a.t_along, proj_b.t_along)
    else:
        geom = _bridge_two_features(
            features[proj_a.feature_idx], proj_a.t_along,
            features[proj_b.feature_idx], proj_b.t_along,
        )
    if geom is None or geom.is_empty:
        return None
    return geom


def _segment_id(river_id, upstream_site_id, downstream_site_id) -> str:
    return f"{river_id}-{upstream_site_id}-{downstream_site_id}"


def _replace_endpoint_if_close(
    coords: List[tuple],
    station_point: Point,
    endpoint_index: int,
) -> None:
    endpoint = Point(coords[endpoint_index])
    if _haversine_meters(station_point, endpoint) <= ROUTE_ENDPOINT_SNAP_TOLERANCE_M:
        coords[endpoint_index] = (station_point.x, station_point.y)


def _snap_segment_geometry_to_stations(
    geom: LineString,
    upstream_row,
    downstream_row,
) -> LineString:
    if geom is None or geom.is_empty or geom.geom_type != "LineString":
        return geom

    coords = list(geom.coords)
    if len(coords) < 2:
        return geom

    _replace_endpoint_if_close(coords, _station_point(upstream_row), 0)
    _replace_endpoint_if_close(coords, _station_point(downstream_row), -1)
    return LineString(coords)


def _index_curated_routes(
    route_gdf: Optional[gpd.GeoDataFrame],
) -> Dict[str, LineString]:
    if route_gdf is None or len(route_gdf) == 0:
        return {}
    routes = route_gdf.copy()
    if routes.crs is not None and str(routes.crs).upper() != "EPSG:4326":
        routes = routes.to_crs("EPSG:4326")

    out: Dict[str, LineString] = {}
    for _, row in routes.iterrows():
        geom = row.geometry
        if (
            geom is None
            or geom.is_empty
            or geom.geom_type not in ("LineString", "MultiLineString")
        ):
            continue

        segment_id = _to_str_or_none(row.get("segment_id"))
        if not segment_id:
            river_id = _to_str_or_none(row.get("river_id"))
            upstream_site_id = _to_str_or_none(row.get("upstream_site_id"))
            downstream_site_id = _to_str_or_none(row.get("downstream_site_id"))
            if not river_id or not upstream_site_id or not downstream_site_id:
                continue
            segment_id = _segment_id(river_id, upstream_site_id, downstream_site_id)

        out[segment_id] = geom
    return out


def _index_river_features(
    wra_gdf: gpd.GeoDataFrame, moenv_river_names
) -> Dict[str, List[LineString]]:
    if wra_gdf is None or len(wra_gdf) == 0:
        return {}
    wanted = {RIVER_NAME_ALIAS.get(name, name): name for name in moenv_river_names}
    wra_filtered = wra_gdf[wra_gdf["NAME"].isin(wanted.keys())]
    if wra_filtered.empty:
        return {}
    if wra_filtered.crs is not None and str(wra_filtered.crs).upper() != "EPSG:4326":
        wra_filtered = wra_filtered.to_crs("EPSG:4326")
    out: Dict[str, List[LineString]] = {}
    for wra_name, group in wra_filtered.groupby("NAME"):
        feats = [
            g
            for g in group.geometry.values
            if g is not None and not g.is_empty and g.geom_type == "LineString"
        ]
        if feats:
            out[wanted[wra_name]] = feats
    return out


EXT_RIVER_ID_PREFIX = "ext-river"


def _synthesize_ext_segment_ordering(
    latest_df: pd.DataFrame,
    wra_gdf: Optional[gpd.GeoDataFrame],
) -> pd.DataFrame:
    """Derive river_id / station_order for Ext stations by WRA projection.

    Ext_River rows arrive without `River_ID` / `Station_Order`, so the
    existing segment builder skips them. For Ext rows whose ``basin``
    matches a WRA river name (after :data:`RIVER_NAME_ALIAS`), project the
    station onto the matched centerline; sort by ``(feature_idx, t_along)``
    within each basin to derive a synthetic ``station_order``; and stamp
    ``river_id = "ext-river:{basin}"`` so the basin's stations group
    together when the segment builder iterates.

    Stations whose basin does not match WRA, or whose projection distance
    exceeds :data:`STATION_OFF_RIVER_TOLERANCE_M`, retain their NA values
    and remain points-only.
    """
    if (
        latest_df is None
        or latest_df.empty
        or wra_gdf is None
        or len(wra_gdf) == 0
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

    basins = latest_df.loc[ext_mask, "basin"].unique().tolist()
    river_features = _index_river_features(wra_gdf, basins)
    if not river_features:
        return latest_df

    df = latest_df.copy()
    if "river_id" in df.columns and df["river_id"].dtype != object:
        df["river_id"] = df["river_id"].astype(object)

    for basin_name, features in river_features.items():
        basin_mask = ext_mask & (latest_df["basin"] == basin_name)
        basin_indexes = latest_df.index[basin_mask].tolist()
        if len(basin_indexes) < 2:
            continue

        projections: List[Tuple[int, _Projection]] = []
        for idx in basin_indexes:
            row = latest_df.loc[idx]
            pt = Point(float(row["longitude"]), float(row["latitude"]))
            proj = _project_to_nearest_feature(pt, features)
            if proj is None or proj.dist_m > STATION_OFF_RIVER_TOLERANCE_M:
                continue
            projections.append((idx, proj))

        if len(projections) < 2:
            continue

        projections.sort(key=lambda x: (x[1].feature_idx, x[1].t_along))
        synthetic_river_id = f"{EXT_RIVER_ID_PREFIX}:{basin_name}"
        for order, (idx, _) in enumerate(projections, 1):
            df.at[idx, "river_id"] = synthetic_river_id
            df.at[idx, "station_order"] = order

    return df


def build_river_segments(
    latest_df: pd.DataFrame,
    wra_gdf: Optional[gpd.GeoDataFrame] = None,
    route_gdf: Optional[gpd.GeoDataFrame] = None,
) -> pd.DataFrame:
    empty = pd.DataFrame(columns=_SEGMENT_COLUMNS)
    if latest_df is None or latest_df.empty:
        return empty

    latest_df = _synthesize_ext_segment_ordering(latest_df, wra_gdf)

    df = latest_df.dropna(
        subset=["river_id", "station_order", "longitude", "latitude", "rpi_value"]
    ).copy()
    if df.empty:
        return empty

    df["river"] = df["river"].fillna("")
    df["station_order"] = df["station_order"].astype(int)

    river_features = _index_river_features(wra_gdf, df["river"].unique().tolist())
    curated_routes = _index_curated_routes(route_gdf)

    rows: List[dict] = []
    for (river_id, river_name), group in df.groupby(["river_id", "river"], dropna=False):
        if not river_id:
            continue
        features = river_features.get(river_name)
        ordered = group.sort_values("station_order").to_dict(orient="records")

        projections: List[Optional[_Projection]] = [None] * len(ordered)
        if features:
            for i, station in enumerate(ordered):
                pt = Point(float(station["longitude"]), float(station["latitude"]))
                proj = _project_to_nearest_feature(pt, features)
                if proj.dist_m <= STATION_OFF_RIVER_TOLERANCE_M:
                    projections[i] = proj

        if not features or all(p is None for p in projections):
            logger.warning(
                (
                    "River %r: no WRA features matched within tolerance; "
                    "%d segments use straight_line."
                ),
                river_name,
                max(0, len(ordered) - 1),
            )

        for i in range(len(ordered) - 1):
            s_a, s_b = ordered[i], ordered[i + 1]
            segment_id = _segment_id(river_id, s_a["site_id"], s_b["site_id"])
            curated_geom = curated_routes.get(segment_id)
            if curated_geom is not None:
                curated_geom = _snap_segment_geometry_to_stations(
                    curated_geom,
                    s_a,
                    s_b,
                )
                rows.append(
                    _segment_row(
                        river_id,
                        river_name,
                        s_a,
                        s_b,
                        curated_geom,
                        GEOMETRY_SOURCE_CURATED_ROUTE,
                    )
                )
                continue

            proj_a, proj_b = projections[i], projections[i + 1]
            geom = None
            if features and proj_a is not None and proj_b is not None:
                geom = _real_river_geometry(features, proj_a, proj_b)
            if geom is not None:
                geom = _snap_segment_geometry_to_stations(geom, s_a, s_b)
                source = GEOMETRY_SOURCE_REAL_RIVER
            else:
                geom = _straight_line_segment(s_a, s_b)
                source = GEOMETRY_SOURCE_STRAIGHT_LINE
            rows.append(_segment_row(river_id, river_name, s_a, s_b, geom, source))

    if not rows:
        return empty
    return pd.DataFrame(rows, columns=_SEGMENT_COLUMNS).drop_duplicates(
        subset=["segment_id"], keep="first"
    )


_SITE_GEOJSON_PROPS = [
    "site_id",
    "site_name",
    "city",
    "district",
    "basin",
    "river",
    "wq_std_grade",
    "sample_month",
    "rpi_value",
    "risk_level",
    "rpi_flag",
    "source_name",
    "source_label",
    "rpi_method",
    "do_value",
    "bod5_value",
    "ss_value",
    "nh3n_value",
    "conductivity_value",
    "do_score",
    "bod5_score",
    "ss_score",
    "nh3n_score",
    "do_method",
    "data_time",
]

_SEGMENT_GEOJSON_PROPS = [
    "segment_id",
    "river_id",
    "river",
    "basin",
    "upstream_site_id",
    "upstream_site_name",
    "upstream_city",
    "upstream_rpi",
    "downstream_site_id",
    "downstream_site_name",
    "downstream_city",
    "downstream_rpi",
    "sample_month",
    "geometry_source",
    "data_time",
]


def export_geojson_layers(
    latest_gdf: gpd.GeoDataFrame,
    segments_gdf: Optional[gpd.GeoDataFrame],
    out_dir: str = "/opt/airflow/fe_mapData",
) -> None:
    os.makedirs(out_dir, exist_ok=True)
    taipei = TARGET_CITIES[0]

    sites = latest_gdf[latest_gdf["wkb_geometry"].notna()].copy()
    sites["sample_month"] = sites["sample_month"].map(_iso_or_none)

    segs_taipei_path = os.path.join(out_dir, "env_river_segments_taipei.geojson")
    segs_metro_path = os.path.join(out_dir, "env_river_segments_metrotaipei.geojson")

    if segments_gdf is None or segments_gdf.empty:
        segs_taipei = None
        segs_metro = None
    else:
        segs_metro = segments_gdf[segments_gdf["wkb_geometry"].notna()].copy()
        segs_metro["sample_month"] = segs_metro["sample_month"].map(_iso_or_none)
        segs_metro = _segments_connected_to_sites(segs_metro, sites)
        segs_taipei = segs_metro[
            (segs_metro["upstream_city"] == taipei)
            & (segs_metro["downstream_city"] == taipei)
        ]

    if segs_taipei is None or segs_taipei.empty:
        taipei_segment_site_ids = set()
    else:
        taipei_segment_site_ids = _connected_site_ids_from_segments(segs_taipei, sites)
    if segs_metro is None or segs_metro.empty:
        metro_segment_site_ids = set()
    else:
        metro_segment_site_ids = _connected_site_ids_from_segments(segs_metro, sites)

    extra_site_ids = _ext_source_visible_site_ids(sites)
    taipei_site_ids = taipei_segment_site_ids | extra_site_ids
    metro_site_ids = metro_segment_site_ids | extra_site_ids

    _write_geojson(
        sites[(sites["city"] == taipei) & (sites["site_id"].isin(taipei_site_ids))],
        _SITE_GEOJSON_PROPS,
        os.path.join(out_dir, "env_river_sites_taipei.geojson"),
    )
    _write_geojson(
        sites[sites["site_id"].isin(metro_site_ids)],
        _SITE_GEOJSON_PROPS,
        os.path.join(out_dir, "env_river_sites_metrotaipei.geojson"),
    )

    if segs_taipei is None:
        _write_empty_collection(segs_taipei_path)
    else:
        _write_geojson(segs_taipei, _SEGMENT_GEOJSON_PROPS, segs_taipei_path)
    if segs_metro is None:
        _write_empty_collection(segs_metro_path)
    else:
        _write_geojson(segs_metro, _SEGMENT_GEOJSON_PROPS, segs_metro_path)


def _ext_source_visible_site_ids(sites: gpd.GeoDataFrame) -> set:
    if sites is None or sites.empty or "source_label" not in sites.columns:
        return set()
    mask = sites["source_label"] == SOURCE_LABEL_MOENV_EXT_RIVER
    if "rpi_flag" in sites.columns:
        mask &= sites["rpi_flag"] == RPI_FLAG_COMPLETE
    return set(sites.loc[mask, "site_id"].astype(str))


def _site_ids_from_segments(segs: gpd.GeoDataFrame) -> set:
    if segs is None or segs.empty:
        return set()
    upstream = set(segs["upstream_site_id"].dropna().astype(str))
    downstream = set(segs["downstream_site_id"].dropna().astype(str))
    return upstream | downstream


def _connected_site_ids_from_segments(
    segs: gpd.GeoDataFrame,
    sites: gpd.GeoDataFrame,
) -> set:
    if segs is None or segs.empty or sites is None or sites.empty:
        return set()

    site_points = {
        str(row.site_id): row.wkb_geometry
        for row in sites[["site_id", "wkb_geometry"]].itertuples()
        if row.wkb_geometry is not None and not row.wkb_geometry.is_empty
    }

    connected = set()
    for row in segs.itertuples():
        geom = row.wkb_geometry
        if geom is None or geom.is_empty or geom.geom_type != "LineString":
            continue
        endpoints = (
            (str(row.upstream_site_id), Point(geom.coords[0])),
            (str(row.downstream_site_id), Point(geom.coords[-1])),
        )
        for site_id, endpoint in endpoints:
            site_point = site_points.get(site_id)
            if site_point is None:
                continue
            if (
                _endpoint_is_connected_to_site(site_point, endpoint)
            ):
                connected.add(site_id)
    return connected


def _segments_connected_to_sites(
    segs: gpd.GeoDataFrame,
    sites: gpd.GeoDataFrame,
) -> gpd.GeoDataFrame:
    if segs is None or segs.empty or sites is None or sites.empty:
        return segs

    site_points = {
        str(row.site_id): row.wkb_geometry
        for row in sites[["site_id", "wkb_geometry"]].itertuples()
        if row.wkb_geometry is not None and not row.wkb_geometry.is_empty
    }
    keep_indexes = []
    for idx, row in segs.iterrows():
        geom = row["wkb_geometry"]
        if geom is None or geom.is_empty or geom.geom_type != "LineString":
            continue
        upstream = site_points.get(str(row["upstream_site_id"]))
        downstream = site_points.get(str(row["downstream_site_id"]))
        if upstream is None or downstream is None:
            continue
        if _endpoint_is_connected_to_site(upstream, Point(geom.coords[0])) and (
            _endpoint_is_connected_to_site(downstream, Point(geom.coords[-1]))
        ):
            keep_indexes.append(idx)

    return segs.loc[keep_indexes].copy()


def _endpoint_is_connected_to_site(site_point: Point, endpoint: Point) -> bool:
    return _haversine_meters(site_point, endpoint) <= SITE_ENDPOINT_EXPORT_TOLERANCE_M


def _iso_or_none(value):
    if pd.isna(value):
        return None
    if hasattr(value, "isoformat"):
        return value.isoformat()
    return str(value)


def _write_geojson(gdf: gpd.GeoDataFrame, props: List[str], path: str) -> None:
    if gdf is None or gdf.empty:
        _write_empty_collection(path)
        return
    cols = [c for c in props if c in gdf.columns]
    out = gpd.GeoDataFrame(
        gdf[cols + ["wkb_geometry"]].rename(columns={"wkb_geometry": "geometry"}),
        geometry="geometry",
        crs="EPSG:4326",
    )
    out.to_file(path, driver="GeoJSON")


def _write_empty_collection(path: str) -> None:
    with open(path, "w", encoding="utf-8") as fh:
        json.dump({"type": "FeatureCollection", "features": []}, fh, ensure_ascii=False)


def _segment_row(river_id, river_name, upstream, downstream, geom, source) -> dict:
    return {
        "segment_id": _segment_id(river_id, upstream["site_id"], downstream["site_id"]),
        "river_id": river_id,
        "river": river_name,
        "basin": upstream["basin"],
        "upstream_site_id": upstream["site_id"],
        "upstream_site_name": upstream["site_name"],
        "upstream_city": upstream["city"],
        "upstream_rpi": float(upstream["rpi_value"]) if pd.notna(upstream["rpi_value"]) else None,
        "downstream_site_id": downstream["site_id"],
        "downstream_site_name": downstream["site_name"],
        "downstream_city": downstream["city"],
        "downstream_rpi": (
            float(downstream["rpi_value"])
            if pd.notna(downstream["rpi_value"])
            else None
        ),
        "sample_month": upstream["sample_month"],
        "geometry_source": source,
        "data_time": upstream["data_time"],
        "wkb_geometry": geom,
    }
