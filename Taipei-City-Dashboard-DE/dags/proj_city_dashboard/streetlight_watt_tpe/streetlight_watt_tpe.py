import re

import pandas as pd
import requests
from operators.common_pipeline import CommonDag
from sqlalchemy import create_engine
from utils.get_time import get_tpe_now_time_str
from utils.load_stage import (
    save_geodataframe_to_postgresql,
    update_lasttime_in_data_to_dataset_info,
)
from utils.transform_geometry import add_point_wkbgeometry_column_to_df

TAIPEI_URL = "https://tppkl.blob.core.windows.net/blobfs/TaipeiLight.json"
WATT_SLOTS = [1, 2, 3, 4, 5]
GEOMETRY_TYPE = "Point"


def _parse_watt(s):
    if pd.isnull(s):
        return None
    cleaned = re.sub(r"[Ww\s,]", "", str(s))
    try:
        return float(cleaned)
    except ValueError:
        return None


def _classify_light_type(s):
    if pd.isnull(s) or str(s).strip() == "":
        return "unknown"
    s_lower = str(s).lower()
    if "led" in s_lower:
        return "led"
    if "鈉" in s or "hps" in s_lower:
        return "sodium"
    if "複金屬" in s or "metal" in s_lower:
        return "metal_halide"
    if "日光" in s or "fluorescent" in s_lower:
        return "fluorescent"
    return "other"


def _classify_bucket(w):
    if pd.isnull(w):
        return "unknown", 6
    if w <= 30:
        return "ultra_low", 1
    if w <= 80:
        return "low", 2
    if w <= 150:
        return "medium", 3
    if w <= 250:
        return "high", 4
    return "very_high", 5


def _compute_pole_watt(row):
    """
    回傳燈桿總瓦數。
    - 只有 1 種燈具：total = LightWatt1 * Quantity
    - 多種燈具：各 LightWatt 加總（Quantity 因各種數量未知，不乘）
    """
    watts = []
    for i in WATT_SLOTS:
        kind = row.get(f"LightKind{i}")
        watt = row.get(f"LightWatt{i}")
        if pd.notnull(kind) and str(kind).strip():
            w = _parse_watt(watt)
            if w is not None:
                watts.append(w)

    if not watts:
        return None

    qty = _parse_watt(row.get("Quantity"))
    if len(watts) == 1 and qty is not None:
        return watts[0] * qty
    return sum(watts)


def _transfer(**kwargs):
    ready_data_db_uri = kwargs.get("ready_data_db_uri")
    dag_infos = kwargs.get("dag_infos")
    dag_id = dag_infos.get("dag_id")
    load_behavior = dag_infos.get("load_behavior")
    default_table = dag_infos.get("ready_data_default_table")
    history_table = dag_infos.get("ready_data_history_table")

    # Extract
    resp = requests.get(TAIPEI_URL, timeout=120)
    resp.raise_for_status()
    raw_data = pd.DataFrame(resp.json())
    print(f"TPE raw rows: {len(raw_data)}")

    df = raw_data.copy()

    # 計算燈桿總瓦數
    df["watt"] = df.apply(_compute_pole_watt, axis=1)

    # light_type 以 LightKind1 為代表
    df["light_type"] = df["LightKind1"].apply(_classify_light_type)

    # watt_bucket
    bucket_result = df["watt"].apply(_classify_bucket)
    df["watt_bucket"] = bucket_result.apply(lambda x: x[0])
    df["watt_bucket_order"] = bucket_result.apply(lambda x: x[1])

    # 座標轉換 TWD97 → WGS84
    df["TWD97X"] = pd.to_numeric(df["TWD97X"], errors="coerce")
    df["TWD97Y"] = pd.to_numeric(df["TWD97Y"], errors="coerce")
    gdf = add_point_wkbgeometry_column_to_df(df, df["TWD97X"], df["TWD97Y"], from_crs=3826)

    # 欄位整理
    gdf["light_id"] = gdf["SerialNumber"].astype(str)
    gdf["city"] = "臺北市"
    gdf["district"] = gdf["Dist"].astype(str)
    gdf["address"] = None
    gdf["source_name"] = "臺北市路燈位置分布圖"
    gdf["pole_height"] = pd.to_numeric(gdf["LightHeight"], errors="coerce")
    gdf["light_year"] = pd.to_numeric(gdf["LightYear"], errors="coerce").astype("Int64")
    now_str = get_tpe_now_time_str(is_with_tz=True)
    gdf["data_time"] = pd.to_datetime(gdf["UpdDate"].fillna(now_str), errors="coerce")
    # add_point_wkbgeometry_column_to_df 輸出 lng/lat 欄位
    gdf = gdf.rename(columns={"lng": "longitude", "lat": "latitude"})

    final_cols = [
        "light_id", "source_name", "city", "district", "address",
        "light_type", "watt", "watt_bucket", "watt_bucket_order",
        "pole_height", "light_year", "longitude", "latitude",
        "data_time", "wkb_geometry",
    ]
    final_df = gdf[final_cols].copy()

    # 過濾無效座標
    final_df = final_df[final_df["wkb_geometry"].notna()].reset_index(drop=True)
    print(f"TPE ready rows: {len(final_df)}")

    engine = create_engine(ready_data_db_uri)
    save_geodataframe_to_postgresql(
        engine,
        gdata=final_df,
        load_behavior=load_behavior,
        default_table=default_table,
        history_table=history_table,
        geometry_type=GEOMETRY_TYPE,
    )

    lasttime = final_df["data_time"].max()
    update_lasttime_in_data_to_dataset_info(
        engine,
        airflow_dag_id=f"proj_city_dashboard_{dag_id}",
        lasttime_in_data=lasttime,
    )


dag = CommonDag(proj_folder="proj_city_dashboard", dag_folder="streetlight_watt_tpe")
dag.create_dag(etl_func=_transfer)
