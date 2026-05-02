from airflow import DAG
from operators.common_pipeline import CommonDag


def _D990103(**kwargs):
    import pandas as pd
    from sqlalchemy import create_engine
    from sqlalchemy.sql import text as sa_text
    from utils.load_stage import (
        save_dataframe_to_postgresql,
        update_lasttime_in_data_to_dataset_info,
    )

    # ---------- Setup ----------
    ready_data_db_uri = kwargs.get("ready_data_db_uri")
    dag_infos = kwargs.get("dag_infos")
    dag_id = dag_infos.get("dag_id")

    engine = create_engine(ready_data_db_uri)

    import datetime
    current_year = datetime.datetime.now().year
    min_year = current_year - 2  # include last 3 years

    def load_stats(conn, stats_table, city):
        return pd.read_sql(
            f"""
            SELECT q.station_name, q.noise_category, q.year, q.quarter,
                   q.period, q.avg_db, s.district, s.station_id,
                   s.standard_day_db, s.standard_evening_db, s.standard_night_db
            FROM {stats_table} q
            LEFT JOIN env_noise_stations s
              ON s.station_name = q.station_name AND s.city = '{city}'
            WHERE q.year >= {min_year}
            """,
            conn,
        )

    def _row_exceeded(row):
        std = {"day": row.get("standard_day_db"),
               "evening": row.get("standard_evening_db"),
               "night": row.get("standard_night_db")}.get(row["period"])
        if pd.isna(std) or pd.isna(row["avg_db"]):
            return False
        return float(row["avg_db"]) > float(std)

    def build_district_summary(df):
        df = df.copy()
        df["exceeded"] = df.apply(_row_exceeded, axis=1)
        rows = []
        for (noise_cat, year, quarter, district), grp in df.groupby(
            ["noise_category", "year", "quarter", "district"]
        ):
            if pd.isna(district):
                continue
            pivot = grp.pivot_table(
                index=["station_name"], columns="period",
                values="avg_db", aggfunc="first"
            ).reset_index()
            day_v = pivot.get("day",     pd.Series(dtype=float)).dropna()
            eve_v = pivot.get("evening", pd.Series(dtype=float)).dropna()
            ngt_v = pivot.get("night",   pd.Series(dtype=float)).dropna()
            n = int(grp["station_name"].nunique())
            station_exceeded = grp.groupby("station_name")["exceeded"].any()
            exc = int(station_exceeded.sum())
            rows.append({
                "district":        district,
                "noise_category":  noise_cat,
                "year":            int(year),
                "quarter":         int(quarter),
                "avg_day_db":      round(float(day_v.mean()), 2) if not day_v.empty else None,
                "avg_evening_db":  round(float(eve_v.mean()), 2) if not eve_v.empty else None,
                "avg_night_db":    round(float(ngt_v.mean()), 2) if not ngt_v.empty else None,
                "station_count":   n,
                "measurement_count": n,
                "exceed_count":    exc,
                "exceed_rate":     round(exc / n, 4) if n else 0.0,
                "data_time":       pd.Timestamp.now(tz="Asia/Taipei"),
            })
        return pd.DataFrame(rows)

    # ---------- Extract + Transform + Load (Taipei & New Taipei) ----------
    for stats_table, summary_table, city in (
        ("env_noise_quarterly_stats_tpe",     "env_noise_district_summary_tpe",     "臺北市"),
        ("env_noise_quarterly_stats_new_tpe", "env_noise_district_summary_new_tpe", "新北市"),
    ):
        with engine.connect() as conn:
            stats = load_stats(conn, stats_table, city)
        if stats.empty:
            print(f"No data in {stats_table}, skipping {summary_table}.")
            continue
        district_df = build_district_summary(stats)
        save_dataframe_to_postgresql(
            engine, data=district_df, load_behavior="replace",
            default_table=summary_table,
        )
        print(f"{summary_table}: {len(district_df)} rows.")


    try:
        update_lasttime_in_data_to_dataset_info(
            engine, dag_id, str(pd.Timestamp.now(tz="Asia/Taipei"))
        )
    except Exception as e:
        print(f"Warning: could not update dataset_info (expected in test env): {e}")
    print("D990103 done.")


dag = CommonDag(proj_folder="proj_city_dashboard", dag_folder="D990103")
dag.create_dag(etl_func=_D990103)
