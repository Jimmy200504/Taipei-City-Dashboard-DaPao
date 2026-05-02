--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: env_ev_charging_connector_power_district; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.env_ev_charging_connector_power_district (
    city_scope text NOT NULL,
    city text NOT NULL,
    district text NOT NULL,
    power_bucket text NOT NULL,
    power_bucket_order integer,
    connector_count integer,
    connector_ratio numeric,
    data_time timestamp with time zone
);


--
-- Name: env_ev_charging_connectors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.env_ev_charging_connectors (
    city text,
    district text,
    station_id text,
    charging_point_id text,
    connector_id text NOT NULL,
    connector_type integer,
    connector_type_name text,
    power_type integer,
    power_type_name text,
    voltage text,
    current_rating text,
    power_rating text,
    power_kw numeric,
    power_bucket text,
    floor text,
    usage_restriction text,
    data_time timestamp with time zone
);


--
-- Name: env_ev_charging_district_summary; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.env_ev_charging_district_summary (
    city_scope text NOT NULL,
    city text NOT NULL,
    district text NOT NULL,
    station_count integer,
    charging_point_count integer,
    connector_count integer,
    data_time timestamp with time zone
);


--
-- Name: env_ev_charging_points; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.env_ev_charging_points (
    city text,
    district text,
    station_id text,
    charging_point_id text NOT NULL,
    operator_id text,
    floor text,
    charging_rate text,
    usage_restriction text,
    connector_type_summary jsonb,
    data_time timestamp with time zone
);


--
-- Name: env_ev_charging_stations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.env_ev_charging_stations (
    source_name text,
    source_url text,
    city text,
    district text,
    station_id text NOT NULL,
    station_name text,
    operator_id text,
    operation_type integer,
    spaces integer,
    station_reported_charging_points integer,
    charging_point_count integer,
    connector_count integer,
    power_summary jsonb,
    service_time text,
    parking_rate text,
    charging_rate text,
    floors text,
    telephone text,
    address text,
    normalized_address text,
    longitude numeric,
    latitude numeric,
    data_time timestamp with time zone,
    wkb_geometry public.geometry(Point,4326)
);


--
-- Data for Name: env_ev_charging_connector_power_district; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.env_ev_charging_connector_power_district (city_scope, city, district, power_bucket, power_bucket_order, connector_count, connector_ratio, data_time) FROM stdin;
taipei	臺北市	中山區	slow_ac	1	144	1.0	2026-05-02 14:10:16+00
taipei	臺北市	中山區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	中山區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	中山區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	中山區	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	中正區	slow_ac	1	74	1.0	2026-05-02 14:10:16+00
taipei	臺北市	中正區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	中正區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	中正區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	中正區	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	信義區	slow_ac	1	226	0.9826	2026-05-02 14:10:16+00
taipei	臺北市	信義區	medium_dc	2	4	0.0174	2026-05-02 14:10:16+00
taipei	臺北市	信義區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	信義區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	信義區	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	內湖區	slow_ac	1	126	0.9844	2026-05-02 14:10:16+00
taipei	臺北市	內湖區	medium_dc	2	2	0.0156	2026-05-02 14:10:16+00
taipei	臺北市	內湖區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	內湖區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	內湖區	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	北投區	slow_ac	1	124	1.0	2026-05-02 14:10:16+00
taipei	臺北市	北投區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	北投區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	北投區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	北投區	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	南港區	slow_ac	1	119	0.8322	2026-05-02 14:10:16+00
taipei	臺北市	南港區	medium_dc	2	24	0.1678	2026-05-02 14:10:16+00
taipei	臺北市	南港區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	南港區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	南港區	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	士林區	slow_ac	1	110	0.9016	2026-05-02 14:10:16+00
taipei	臺北市	士林區	medium_dc	2	8	0.0656	2026-05-02 14:10:16+00
taipei	臺北市	士林區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	士林區	ultra_fast_dc	4	4	0.0328	2026-05-02 14:10:16+00
taipei	臺北市	士林區	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	大同區	slow_ac	1	83	1.0	2026-05-02 14:10:16+00
taipei	臺北市	大同區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	大同區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	大同區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	大同區	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	大安區	slow_ac	1	204	0.8831	2026-05-02 14:10:16+00
taipei	臺北市	大安區	medium_dc	2	18	0.0779	2026-05-02 14:10:16+00
taipei	臺北市	大安區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	大安區	ultra_fast_dc	4	9	0.039	2026-05-02 14:10:16+00
taipei	臺北市	大安區	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	文山區	slow_ac	1	88	1.0	2026-05-02 14:10:16+00
taipei	臺北市	文山區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	文山區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	文山區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	文山區	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	未分類	slow_ac	1	6	1.0	2026-05-02 14:10:16+00
taipei	臺北市	未分類	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	未分類	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	未分類	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	未分類	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	松山區	slow_ac	1	141	1.0	2026-05-02 14:10:16+00
taipei	臺北市	松山區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	松山區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	松山區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	松山區	unknown	5	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	萬華區	slow_ac	1	111	1.0	2026-05-02 14:10:16+00
taipei	臺北市	萬華區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	萬華區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	萬華區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
taipei	臺北市	萬華區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	三峽區	slow_ac	1	31	0.7045	2026-05-02 14:10:16+00
twin_city	新北市	三峽區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	三峽區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	三峽區	ultra_fast_dc	4	13	0.2955	2026-05-02 14:10:16+00
twin_city	新北市	三峽區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	三芝區	slow_ac	1	13	1.0	2026-05-02 14:10:16+00
twin_city	新北市	三芝區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	三芝區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	三芝區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	三芝區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	三重區	slow_ac	1	112	0.875	2026-05-02 14:10:16+00
twin_city	新北市	三重區	medium_dc	2	8	0.0625	2026-05-02 14:10:16+00
twin_city	新北市	三重區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	三重區	ultra_fast_dc	4	8	0.0625	2026-05-02 14:10:16+00
twin_city	新北市	三重區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	中和區	slow_ac	1	124	0.8378	2026-05-02 14:10:16+00
twin_city	新北市	中和區	medium_dc	2	4	0.027	2026-05-02 14:10:16+00
twin_city	新北市	中和區	fast_dc	3	16	0.1081	2026-05-02 14:10:16+00
twin_city	新北市	中和區	ultra_fast_dc	4	4	0.027	2026-05-02 14:10:16+00
twin_city	新北市	中和區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	五股區	slow_ac	1	7	1.0	2026-05-02 14:10:16+00
twin_city	新北市	五股區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	五股區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	五股區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	五股區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	八里區	slow_ac	1	26	1.0	2026-05-02 14:10:16+00
twin_city	新北市	八里區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	八里區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	八里區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	八里區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	土城區	slow_ac	1	69	0.8118	2026-05-02 14:10:16+00
twin_city	新北市	土城區	medium_dc	2	4	0.0471	2026-05-02 14:10:16+00
twin_city	新北市	土城區	fast_dc	3	4	0.0471	2026-05-02 14:10:16+00
twin_city	新北市	土城區	ultra_fast_dc	4	8	0.0941	2026-05-02 14:10:16+00
twin_city	新北市	土城區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	坪林區	slow_ac	1	4	1.0	2026-05-02 14:10:16+00
twin_city	新北市	坪林區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	坪林區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	坪林區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	坪林區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	新店區	slow_ac	1	75	0.9036	2026-05-02 14:10:16+00
twin_city	新北市	新店區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	新店區	fast_dc	3	8	0.0964	2026-05-02 14:10:16+00
twin_city	新北市	新店區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	新店區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	新莊區	slow_ac	1	127	0.8944	2026-05-02 14:10:16+00
twin_city	新北市	新莊區	medium_dc	2	4	0.0282	2026-05-02 14:10:16+00
twin_city	新北市	新莊區	fast_dc	3	3	0.0211	2026-05-02 14:10:16+00
twin_city	新北市	新莊區	ultra_fast_dc	4	8	0.0563	2026-05-02 14:10:16+00
twin_city	新北市	新莊區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	板橋區	slow_ac	1	153	0.8182	2026-05-02 14:10:16+00
twin_city	新北市	板橋區	medium_dc	2	16	0.0856	2026-05-02 14:10:16+00
twin_city	新北市	板橋區	fast_dc	3	6	0.0321	2026-05-02 14:10:16+00
twin_city	新北市	板橋區	ultra_fast_dc	4	12	0.0642	2026-05-02 14:10:16+00
twin_city	新北市	板橋區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	林口區	slow_ac	1	96	0.8727	2026-05-02 14:10:16+00
twin_city	新北市	林口區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	林口區	fast_dc	3	2	0.0182	2026-05-02 14:10:16+00
twin_city	新北市	林口區	ultra_fast_dc	4	12	0.1091	2026-05-02 14:10:16+00
twin_city	新北市	林口區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	樹林區	slow_ac	1	15	1.0	2026-05-02 14:10:16+00
twin_city	新北市	樹林區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	樹林區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	樹林區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	樹林區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	永和區	slow_ac	1	77	1.0	2026-05-02 14:10:16+00
twin_city	新北市	永和區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	永和區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	永和區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	永和區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	汐止區	slow_ac	1	55	0.8462	2026-05-02 14:10:16+00
twin_city	新北市	汐止區	medium_dc	2	6	0.0923	2026-05-02 14:10:16+00
twin_city	新北市	汐止區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	汐止區	ultra_fast_dc	4	4	0.0615	2026-05-02 14:10:16+00
twin_city	新北市	汐止區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	泰山區	slow_ac	1	21	1.0	2026-05-02 14:10:16+00
twin_city	新北市	泰山區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	泰山區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	泰山區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	泰山區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	淡水區	slow_ac	1	45	0.8491	2026-05-02 14:10:16+00
twin_city	新北市	淡水區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	淡水區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	淡水區	ultra_fast_dc	4	8	0.1509	2026-05-02 14:10:16+00
twin_city	新北市	淡水區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	深坑區	slow_ac	1	3	1.0	2026-05-02 14:10:16+00
twin_city	新北市	深坑區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	深坑區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	深坑區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	深坑區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	烏來區	slow_ac	1	11	1.0	2026-05-02 14:10:16+00
twin_city	新北市	烏來區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	烏來區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	烏來區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	烏來區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	瑞芳區	slow_ac	1	8	1.0	2026-05-02 14:10:16+00
twin_city	新北市	瑞芳區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	瑞芳區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	瑞芳區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	瑞芳區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	石門區	slow_ac	1	3	1.0	2026-05-02 14:10:16+00
twin_city	新北市	石門區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	石門區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	石門區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	石門區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	蘆洲區	slow_ac	1	47	1.0	2026-05-02 14:10:16+00
twin_city	新北市	蘆洲區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	蘆洲區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	蘆洲區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	蘆洲區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	貢寮區	slow_ac	1	2	1.0	2026-05-02 14:10:16+00
twin_city	新北市	貢寮區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	貢寮區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	貢寮區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	貢寮區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	金山區	slow_ac	1	10	1.0	2026-05-02 14:10:16+00
twin_city	新北市	金山區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	金山區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	金山區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	金山區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	鶯歌區	slow_ac	1	5	0.7143	2026-05-02 14:10:16+00
twin_city	新北市	鶯歌區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	鶯歌區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	新北市	鶯歌區	ultra_fast_dc	4	2	0.2857	2026-05-02 14:10:16+00
twin_city	新北市	鶯歌區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	中山區	slow_ac	1	144	1.0	2026-05-02 14:10:16+00
twin_city	臺北市	中山區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	中山區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	中山區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	中山區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	中正區	slow_ac	1	74	1.0	2026-05-02 14:10:16+00
twin_city	臺北市	中正區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	中正區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	中正區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	中正區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	信義區	slow_ac	1	226	0.9826	2026-05-02 14:10:16+00
twin_city	臺北市	信義區	medium_dc	2	4	0.0174	2026-05-02 14:10:16+00
twin_city	臺北市	信義區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	信義區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	信義區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	內湖區	slow_ac	1	126	0.9844	2026-05-02 14:10:16+00
twin_city	臺北市	內湖區	medium_dc	2	2	0.0156	2026-05-02 14:10:16+00
twin_city	臺北市	內湖區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	內湖區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	內湖區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	北投區	slow_ac	1	124	1.0	2026-05-02 14:10:16+00
twin_city	臺北市	北投區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	北投區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	北投區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	北投區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	南港區	slow_ac	1	119	0.8322	2026-05-02 14:10:16+00
twin_city	臺北市	南港區	medium_dc	2	24	0.1678	2026-05-02 14:10:16+00
twin_city	臺北市	南港區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	南港區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	南港區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	士林區	slow_ac	1	110	0.9016	2026-05-02 14:10:16+00
twin_city	臺北市	士林區	medium_dc	2	8	0.0656	2026-05-02 14:10:16+00
twin_city	臺北市	士林區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	士林區	ultra_fast_dc	4	4	0.0328	2026-05-02 14:10:16+00
twin_city	臺北市	士林區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	大同區	slow_ac	1	83	1.0	2026-05-02 14:10:16+00
twin_city	臺北市	大同區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	大同區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	大同區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	大同區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	大安區	slow_ac	1	204	0.8831	2026-05-02 14:10:16+00
twin_city	臺北市	大安區	medium_dc	2	18	0.0779	2026-05-02 14:10:16+00
twin_city	臺北市	大安區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	大安區	ultra_fast_dc	4	9	0.039	2026-05-02 14:10:16+00
twin_city	臺北市	大安區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	文山區	slow_ac	1	88	1.0	2026-05-02 14:10:16+00
twin_city	臺北市	文山區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	文山區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	文山區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	文山區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	未分類	slow_ac	1	6	1.0	2026-05-02 14:10:16+00
twin_city	臺北市	未分類	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	未分類	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	未分類	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	未分類	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	松山區	slow_ac	1	141	1.0	2026-05-02 14:10:16+00
twin_city	臺北市	松山區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	松山區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	松山區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	松山區	unknown	5	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	萬華區	slow_ac	1	111	1.0	2026-05-02 14:10:16+00
twin_city	臺北市	萬華區	medium_dc	2	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	萬華區	fast_dc	3	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	萬華區	ultra_fast_dc	4	0	0.0	2026-05-02 14:10:16+00
twin_city	臺北市	萬華區	unknown	5	0	0.0	2026-05-02 14:10:16+00
\.


--
-- Data for Name: env_ev_charging_connectors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.env_ev_charging_connectors (city, district, station_id, charging_point_id, connector_id, connector_type, connector_type_name, power_type, power_type_name, voltage, current_rating, power_rating, power_kw, power_bucket, floor, usage_restriction, data_time) FROM stdin;
臺北市	\N	TPE1733	94175832-P6f4780b4d88f	94175832-C6f4780b4d88f1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1733	94175832-P807993707462	94175832-C8079937074621	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1733	94175832-Pa68f3c7a198f	94175832-Ca68f3c7a198f1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0058	88237515-CB022301_5	88237515-CB022301_5	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0058	88237515-PB022301_1	88237515-CB022301_1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0058	88237515-PB022301_2	88237515-CB022301_2	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0058	88237515-PB022301_3	88237515-CB022301_3	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0058	88237515-PB022301_4	88237515-CB022301_4	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0117	33029464-PTP6780001	33029464-CTP6780001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0117	33029464-PTP6780002	33029464-CTP6780002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0706	90807408-PCP02901	90807408-CCP02901	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0706	90807408-PCP02902	90807408-CCP02902	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1773	08612854-P0001	08612854-C0001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1773	08612854-P0002	08612854-C0002	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1773	08612854-P0003	08612854-C0003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03229	90807408-CCP03229	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03230	90807408-CCP03230	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03231	90807408-CCP03231	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03232	90807408-CCP03232	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03233	90807408-CCP03233	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03234	90807408-CCP03234	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03235	90807408-CCP03235	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03236	90807408-CCP03236	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03237	90807408-CCP03237	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03238	90807408-CCP03238	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03239	90807408-CCP03239	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03240	90807408-CCP03240	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03241	90807408-CCP03241	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP03242	90807408-CCP03242	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0062	90807408-PCP05101	90807408-CCP05101	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U01	42861108-P318611A	42861108-C318611A-1	4	Tesla_TPC	2	DC	400V	625A	250kW	250.0	ultra_fast_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U01	42861108-P318611B	42861108-C318611B-1	2	CCCS2	2	DC	400V	625A	250kW	250.0	ultra_fast_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U01	42861108-P318611C	42861108-C318611C-1	2	CCCS2	2	DC	400V	625A	250kW	250.0	ultra_fast_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U01	42861108-P318612A	42861108-C318612A-1	4	Tesla_TPC	2	DC	400V	625A	250kW	250.0	ultra_fast_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U01	42861108-P318612B	42861108-C318612B-1	2	CCCS2	2	DC	400V	625A	250kW	250.0	ultra_fast_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U01	42861108-P318612C	42861108-C318612C-1	2	CCCS2	2	DC	400V	625A	250kW	250.0	ultra_fast_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U02	90807408-PCP04139	90807408-CCP04139	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U02	90807408-PCP04140	90807408-CCP04140	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U02	90807408-PCP04141	90807408-CCP04141	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U02	90807408-PCP04142	90807408-CCP04142	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U02	90807408-PCP04143	90807408-CCP04143	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U02	90807408-PCP04144	90807408-CCP04144	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U02	90807408-PCP04145	90807408-CCP04145	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U03	90807408-PCP03576	90807408-CCP03576	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U03	90807408-PCP03577	90807408-CCP03577	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0201U03	90807408-PCP03578	90807408-CCP03578	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U01	28371994-PTP6620001	28371994-CTP6620001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U01	28371994-PTP6620002	28371994-CTP6620002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U02	28371994-PTP6520001	28371994-CTP6520001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U02	28371994-PTP6520002	28371994-CTP6520002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U03	28371994-PTP6530001	28371994-CTP6530001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U03	28371994-PTP6530037	28371994-CTP6530002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U03	28371994-PTP6530038	28371994-CTP6530003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U03	28371994-PTP6530039	28371994-CTP6530004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U03	28371994-PTP6530040	28371994-CTP6530005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U04	28371994-PTP6540001	28371994-CTP6540001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U04	28371994-PTP6540002	28371994-CTP6540002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U04	28371994-PTP6540003	28371994-CTP6540003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U05	28371994-PTP6550001	28371994-CTP6550001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U05	28371994-PTP6550002	28371994-CTP6550002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U05	28371994-PTP6550003	28371994-CTP6550003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U06	28371994-PTP6560001	28371994-CTP6560001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U06	28371994-PTP6560002	28371994-CTP6560002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U06	28371994-PTP6560003	28371994-CTP6560003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U07	28371994-PTP6570001	28371994-CTP6570001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U08	28371994-PTP6580001	28371994-CTP6580001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U08	28371994-PTP6580002	28371994-CTP6580002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U08	28371994-PTP6580003	28371994-CTP6580003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U08	28371994-PTP6580004	28371994-CTP6580004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U08	28371994-PTP6580005	28371994-CTP6580005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U08	28371994-PTP6580006	28371994-CTP6580006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U09	28371994-PTP6590001	28371994-CTP6590001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U09	28371994-PTP6590002	28371994-CTP6590002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U09	28371994-PTP6590003	28371994-CTP6590003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U09	28371994-PTP6590004	28371994-CTP6590004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U09	28371994-PTP6590005	28371994-CTP6590005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U09	28371994-PTP6590006	28371994-CTP6590006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U10	28371994-PTP3930001	28371994-CTP3930001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U11	28371994-PTP6600001	28371994-CTP6600001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0228U12	28371994-PTP6610002	28371994-CTP6610001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0169	90807408-PCP03329	90807408-CCP03329	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0169	90807408-PCP03330	90807408-CCP03330	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0169	90807408-PCP03331	90807408-CCP03331	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0169	90807408-PCP03332	90807408-CCP03332	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0169	90807408-PCP03333	90807408-CCP03333	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0169	90807408-PCP03334	90807408-CCP03334	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0537	89132567-P0227	89132567-C0268	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0537	89132567-P0228	89132567-C0269	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0537	89132567-P0229	89132567-C0270	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0537	89132567-P0230	89132567-C0271	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0537	89132567-P0231	89132567-C0272	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0537	89132567-P0232	89132567-C0273	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0537	89132567-P0233	89132567-C0274	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0537	89132567-P0234	89132567-C0275	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0537	89132567-P0235	89132567-C0276	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0537	89132567-P0236	89132567-C0277	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0787	90807408-PCP03371	90807408-CCP03371	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0787	90807408-PCP03372	90807408-CCP03372	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0787	90807408-PCP03373	90807408-CCP03373	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0787	90807408-PCP03374	90807408-CCP03374	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-P009e5f46d144	94175832-C009e5f46d1441	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-P0a139d274100	94175832-C0a139d2741001	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-P1ac9cfcebe25	94175832-C1ac9cfcebe251	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-P58c068b9f4fe	94175832-C58c068b9f4fe1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-P66d33b412303	94175832-C66d33b4123031	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-P8abcbc6f4cce	94175832-C8abcbc6f4cce1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-P8b3ccbaad9cc	94175832-C8b3ccbaad9cc1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-P92fd40202d91	94175832-C92fd40202d911	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-P9ee68ef0bf50	94175832-C9ee68ef0bf501	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-Pa234c47d45b7	94175832-Ca234c47d45b71	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-Pcf275ae398fc	94175832-Ccf275ae398fc1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-Pd6d09cc46ef5	94175832-Cd6d09cc46ef51	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-Pd788d941b166	94175832-Cd788d941b1661	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0992	94175832-Pf3f429355d71	94175832-Cf3f429355d711	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0102	33029464-PTP6770001	33029464-CTP6770001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0103	33029464-PTP6810001	33029464-CTP6810001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0103	33029464-PTP6810002	33029464-CTP6810002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0104	33029464-PTP6800001	33029464-CTP6800001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0114	33029464-PTP6750001	33029464-CTP6750001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0280	50965513-PA0323TYTW00069	50965513-CA0323TYTW000691	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0316	90807408-PCP05441	90807408-CCP05441	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0316	90807408-PCP05442	90807408-CCP05442	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0316	90807408-PCP05443	90807408-CCP05443	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0316	90807408-PCP05444	90807408-CCP05444	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0607	52883637-CIN27-OCPP-ECS--496AD	52883637-CIN27-OCPP-ECS--496AD|01	1	CCS1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0611	90807408-PCP05198	90807408-CCP05198	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0648	90807408-PCP05009	90807408-CCP05009	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0892	90807408-PCP05122	90807408-CCP05122	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0892	90807408-PCP05123	90807408-CCP05123	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1160	90807408-PCP03409	90807408-CCP03409	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1160	90807408-PCP03410	90807408-CCP03410	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0852	90807408-PCP03243	90807408-CCP03243	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0852	90807408-PCP03244	90807408-CCP03244	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0852	90807408-PCP03245	90807408-CCP03245	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0852	90807408-PCP03246	90807408-CCP03246	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0852	90807408-PCP03247	90807408-CCP03247	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0852	90807408-PCP03248	90807408-CCP03248	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1544	88395963-PC009601_1	88395963-CC009601_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1544	88395963-PC009601_2	88395963-CC009601_2	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1544	88395963-PC009601_3	88395963-CC009601_3	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1674	90807408-PCP06163	90807408-CCP06163	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1674	90807408-PCP06164	90807408-CCP06164	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0819	90807408-PCP03288	90807408-CCP03288	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0819	90807408-PCP03289	90807408-CCP03289	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0819	90807408-PCP03290	90807408-CCP03290	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0819	90807408-PCP03291	90807408-CCP03291	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1792	94175832-P17d18857f7e6	94175832-C17d18857f7e61	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1792	94175832-P31593f1fe67d	94175832-C31593f1fe67d1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1792	94175832-Pb204de6253d0	94175832-Cb204de6253d01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1792	94175832-Pb42d0770a810	94175832-Cb42d0770a8101	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1792	94175832-Pc3727fb965ab	94175832-Cc3727fb965ab1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1792	94175832-Pedf5df40d73b	94175832-Cedf5df40d73b1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1793	28114216-PJEN212800340W0	28114216-CJEN212800340W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1793	28114216-PJEN212800342W0	28114216-CJEN212800342W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1793	28114216-PJEN212800364W0	28114216-CJEN212800364W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1793	28114216-PJEN212800384W0	28114216-CJEN212800384W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1793	28114216-PXP01245100004	28114216-CXP012451000041	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0723	90807408-PCP03335	90807408-CCP03335	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0723	90807408-PCP03336	90807408-CCP03336	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0723	90807408-PCP03337	90807408-CCP03337	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0723	90807408-PCP03338	90807408-CCP03338	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0723	90807408-PCP03339	90807408-CCP03339	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0742	28371994-PTP6010001	28371994-CTP6010001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0742	28371994-PTP6010002	28371994-CTP6010002	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0742	28371994-PTP6010003	28371994-CTP6010003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0742	28371994-PTP6010004	28371994-CTP6010004	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0538	90807408-PCP03063	90807408-CCP03063	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0538	90807408-PCP03064	90807408-CCP03064	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0538	90807408-PCP03065	90807408-CCP03065	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0538	90807408-PCP03066	90807408-CCP03066	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0453	28007736-PAPAL014001	28007736-CAPAL014001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0667	97179430-P00127	97179430-C00127-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0667	97179430-P00127	97179430-C00127-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0667	97179430-P00128	97179430-C00128-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0667	97179430-P00128	97179430-C00128-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0667	97179430-P00129	97179430-C00129-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0667	97179430-P00129	97179430-C00129-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0667	97179430-P00130	97179430-C00130-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0667	97179430-P00130	97179430-C00130-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0359	73682707-PB012101_1	73682707-CB012101_1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0359	73682707-PB012101_2	73682707-CB012101_2	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0359	73682707-PB012101_3	73682707-CB012101_3	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0734	89132567-P0217	89132567-C0258	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0734	89132567-P0218	89132567-C0259	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0734	89132567-P0219	89132567-C0260	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0734	89132567-P0220	89132567-C0261	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0734	89132567-P0221	89132567-C0262	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0734	89132567-P0222	89132567-C0263	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0734	89132567-P0223	89132567-C0264	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0734	89132567-P0224	89132567-C0265	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0734	89132567-P0225	89132567-C0266	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0734	89132567-P0226	89132567-C0267	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0040	94175832-P1b2967474b88	94175832-C1b2967474b881	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0040	94175832-Pd8778b6ce2e9	94175832-Cd8778b6ce2e91	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0040	94175832-Pf60cd1a0e55c	94175832-Cf60cd1a0e55c1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0237	90807408-PCP03365	90807408-CCP03365	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0237	90807408-PCP03366	90807408-CCP03366	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0514	90505425-P3867801	90505425-C3867801-1	1	CCS1	2	DC	400V	500A	200kW	200.0	ultra_fast_dc	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0514	90505425-P3867802	90505425-C3867802-1	1	CCS1	2	DC	400V	500A	200kW	200.0	ultra_fast_dc	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0514	90505425-P3867803	90505425-C3867803-1	2	CCCS2	2	DC	400V	500A	200kW	200.0	ultra_fast_dc	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0514	90505425-P3867804	90505425-C3867804-1	2	CCCS2	2	DC	400V	500A	200kW	200.0	ultra_fast_dc	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0735	90807408-PCP03359	90807408-CCP03359	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0735	90807408-PCP03360	90807408-CCP03360	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0818	12981268-PJEN243101045W0	12981268-CJEN243101045W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1180	42649057-PAWSC770001E2P1C2323A016A0	42649057-C0001	1	CCS1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1767	50965513-PA0324TYTW00109	50965513-CA0324TYTW001091	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1767	50965513-PA0324TYTW00110	50965513-CA0324TYTW001101	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1767	50965513-PA0324TYTW00111	50965513-CA0324TYTW001111	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1769	50965513-PA0323TYTW00086	50965513-CA0323TYTW000861	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1769	50965513-PA0323TYTW00094	50965513-CA0323TYTW000941	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1769	50965513-PA0323TYTW00095	50965513-CA0323TYTW000951	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1769	50965513-PA0323TYTW00098	50965513-CA0323TYTW000981	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1769	50965513-PA0324TYTW00112	50965513-CA0324TYTW001121	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1769	50965513-PA0324TYTW00113	50965513-CA0324TYTW001131	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1785	50965513-PA0323TYTW00083	50965513-CA0323TYTW000831	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1785	50965513-PA0323TYTW00084	50965513-CA0323TYTW000841	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1785	50965513-PA0323TYTW00088	50965513-CA0323TYTW000881	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1785	50965513-PA0323TYTW00090	50965513-CA0323TYTW000901	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1785	50965513-PA0323TYTW00100	50965513-CA0323TYTW001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1785	50965513-PA0324TYTW00106	50965513-CA0324TYTW001061	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1795	83058885-P510	83058885-C498	5	J1772_Type1	1	AC	220V	60A	3kW	3.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1807	52693448-P0017	52693448-C0017	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1807	52693448-P0018	52693448-C0018	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1807	52693448-P0019	52693448-C0019	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1807	52693448-P0020	52693448-C0020	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1807	52693448-P0021	52693448-C0021	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1809	53703514-P500134	53703514-C500134-1	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1809	53703514-P500135	53703514-C500135-1	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1820	52883637-CIN27-OCPP-TYC--00296	52883637-CIN27-OCPP-TYC--00296|01	1	CCS1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN384	28652185-CZHEN384	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN385	28652185-CZHEN385	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN386	28652185-CZHEN386	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN387	28652185-CZHEN387	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN388	28652185-CZHEN388	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN389	28652185-CZHEN389	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN390	28652185-CZHEN390	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN391	28652185-CZHEN391	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN392	28652185-CZHEN392	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN393	28652185-CZHEN393	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN394	28652185-CZHEN394	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN395	28652185-CZHEN395	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1864	28652185-PZHEN396	28652185-CZHEN396	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1868	83058885-P309	83058885-C274	5	J1772_Type1	1	AC	220V	60A	3kW	3.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1875	28652185-PLZLI0003	28652185-CLZLI0003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1875	28652185-PLZLI0013	28652185-CLZLI0013	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1875	28652185-PLZLI0014	28652185-CLZLI0014	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1875	28652185-PLZLI0015	28652185-CLZLI0015	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1875	28652185-PLZLI0016	28652185-CLZLI0016	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1876	28652185-PLZLI2011	28652185-CLZLI2011	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1876	28652185-PLZLI2012	28652185-CLZLI2012	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1876	28652185-PLZLI2014	28652185-CLZLI2014	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1876	28652185-PLZLI2015	28652185-CLZLI2015	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1876	28652185-PLZLI2016	28652185-CLZLI2016	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1876	28652185-PLZLI2017	28652185-CLZLI2017	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1876	28652185-PLZLI2018	28652185-CLZLI2018	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1883	89132567-P0389	89132567-C0428	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1884	00641938-PB0446011_1	00641938-CB0446011_1	5	J1772_Type1	1	AC	110V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1884	00641938-PB0446011_2	00641938-CB0446011_2	5	J1772_Type1	1	AC	110V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1884	00641938-PB0446011_3	00641938-CB0446011_3	5	J1772_Type1	1	AC	110V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1884	00641938-PB0446011_4	00641938-CB0446011_4	5	J1772_Type1	1	AC	110V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1884	00641938-PB0446011_5	00641938-CB0446011_5	5	J1772_Type1	1	AC	110V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1622	28007736-PAPAL002001	28007736-CAPAL002001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE1622	28007736-PAPAL002002	28007736-CAPAL002002001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0183	12981268-PJEN243100928W0	12981268-CJEN243100928W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0091	33029464-PTP6650001	33029464-CTP6650001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0091	33029464-PTP6650002	33029464-CTP6650002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0091	33029464-PTP6650003	33029464-CTP6650003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0091	33029464-PTP6650004	33029464-CTP6650004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0091	33029464-PTP6650005	33029464-CTP6650005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0140	33029464-PTP6660001	33029464-CTP6660001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0140	33029464-PTP6660002	33029464-CTP6660002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0928	42441649-PB0050_10	42441649-CB0050_9	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0928	42441649-PB0050_11	42441649-CB0050_10	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0928	42441649-PB0050_12	42441649-CB0050_11	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0928	42441649-PB0050_14	42441649-CB0050_13	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0928	42441649-PB0050_5	42441649-CB0050_5	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0928	42441649-PB0050_6	42441649-CB0050_4	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0928	42441649-PB0050_7	42441649-CB0050_6	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0928	42441649-PB0050_8	42441649-CB0050_7	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0928	42441649-PB0050_9	42441649-CB0050_8	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0118	90807408-PCP04693	90807408-CCP04693	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0444	85051710-P1630	85051710-C4212	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0444	85051710-P1631	85051710-C4213	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_10	88177523-CA028301_1_6	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_11	88177523-CA028301_1_11	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_12	88177523-CA028301_1_12	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_13	88177523-CA028301_1_8	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_14	88177523-CA028301_1_13	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_16	88177523-CA028301_1_14	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_17	88177523-CA028301_1_15	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_2	88177523-CA028301_1_1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_3	88177523-CA028301_1_2	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_5	88177523-CA028301_1_9	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_6	88177523-CA028301_1_3	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_7	88177523-CA028301_1_10	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_8	88177523-CA028301_1_4	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0709	88177523-PA028301_1_9	88177523-CA028301_1_5	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0935	88177523-PA028301_2_1	88177523-CA028301_2_2	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0935	88177523-PA028301_2_2	88177523-CA028301_2_1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1675	80158495-PB11CE2508011	80158495-CB11CE2508011_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0536	90807408-PCP03379	90807408-CCP03379	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0536	90807408-PCP03380	90807408-CCP03380	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0536	90807408-PCP03381	90807408-CCP03381	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0536	90807408-PCP03382	90807408-CCP03382	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0315	90807408-PCP03367	90807408-CCP03367	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0315	90807408-PCP03368	90807408-CCP03368	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0170	90807408-PCP03402	90807408-CCP03402	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0170	90807408-PCP03403	90807408-CCP03403	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0630	90807408-PCP03415	90807408-CCP03415	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0630	90807408-PCP03416	90807408-CCP03416	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0963	90807408-PCP03404	90807408-CCP03404	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0963	90807408-PCP03405	90807408-CCP03405	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1049	90807408-PCP03413	90807408-CCP03413	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1049	90807408-PCP03414	90807408-CCP03414	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0399	90807408-PCP03387	90807408-CCP03387	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0399	90807408-PCP03388	90807408-CCP03388	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0399	90807408-PCP03389	90807408-CCP03389	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0399	90807408-PCP03390	90807408-CCP03390	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0399	90807408-PCP03391	90807408-CCP03391	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0399	90807408-PCP03392	90807408-CCP03392	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0399	90807408-PCP03393	90807408-CCP03393	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0399	90807408-PCP03394	90807408-CCP03394	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0399	90807408-PCP03395	90807408-CCP03395	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0160	90807408-PCP03396	90807408-CCP03396	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0160	90807408-PCP03397	90807408-CCP03397	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0160	90807408-PCP03398	90807408-CCP03398	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0160	90807408-PCP03399	90807408-CCP03399	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0160	90807408-PCP03400	90807408-CCP03400	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0160	90807408-PCP03401	90807408-CCP03401	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1346	90807408-PCP03375	90807408-CCP03375	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1346	90807408-PCP03376	90807408-CCP03376	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1346	90807408-PCP03377	90807408-CCP03377	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1346	90807408-PCP03378	90807408-CCP03378	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0383	90807408-PCP03406	90807408-CCP03406	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0383	90807408-PCP03407	90807408-CCP03407	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0383	90807408-PCP03408	90807408-CCP03408	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0204	90807408-PCP03369	90807408-CCP03369	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0204	90807408-PCP03370	90807408-CCP03370	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0382	90807408-PCP03411	90807408-CCP03411	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0382	90807408-PCP03412	90807408-CCP03412	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0207	90807408-PCP03417	90807408-CCP03417	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0207	90807408-PCP03418	90807408-CCP03418	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0971	90807408-PCP03419	90807408-CCP03419	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0971	90807408-PCP03420	90807408-CCP03420	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1423	90807408-PCP03423	90807408-CCP03423	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1423	90807408-PCP03424	90807408-CCP03424	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0680	28371994-PTP3570001	28371994-CTP3570001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0680	28371994-PTP3570002	28371994-CTP3570002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0680	28371994-PTP3570003	28371994-CTP3570003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0680	28371994-PTP3570004	28371994-CTP3570004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0680	28371994-PTP3570005	28371994-CTP3570005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0680	28371994-PTP3570006	28371994-CTP3570006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1027	80682490-P0001	80682490-C0001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1027	80682490-P0002	80682490-C0002	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1027	80682490-P0003	80682490-C0003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1027	80682490-P0004	80682490-C0004	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1027	80682490-P0005	80682490-C0005	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1027	80682490-P0006	80682490-C0006	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0828	90807408-PCP03101	90807408-CCP03101	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0828	90807408-PCP03102	90807408-CCP03102	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0828	90807408-PCP03103	90807408-CCP03103	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0828	90807408-PCP03104	90807408-CCP03104	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0828	90807408-PCP03105	90807408-CCP03105	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0828	90807408-PCP03106	90807408-CCP03106	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0828	90807408-PCP03107	90807408-CCP03107	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0721	85012273-P332	85012273-C303	5	J1772_Type1	1	AC	220V	32A	1kW	1.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE1562	93519232-P109801	93519232-C109801	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0231	28371994-PTP6000001	28371994-CTP6000001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0231	28371994-PTP6000002	28371994-CTP6000002	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0231	28371994-PTP6000003	28371994-CTP6000003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0231	28371994-PTP6000004	28371994-CTP6000004	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0231	28371994-PTP6000005	28371994-CTP6000005	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0231	28371994-PTP6000006	28371994-CTP6000006	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0231	28371994-PTP6000007	28371994-CTP6000007	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0231	28371994-PTP6000008	28371994-CTP6000008	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0402	90807408-PCP04694	90807408-CCP04694	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0402	90807408-PCP04695	90807408-CCP04695	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0156	90807408-PCP03021	90807408-CCP03021	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0156	90807408-PCP03022	90807408-CCP03022	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0156	90807408-PCP03023	90807408-CCP03023	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0156	90807408-PCP03024	90807408-CCP03024	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0156	90807408-PCP03025	90807408-CCP03025	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0156	90807408-PCP03026	90807408-CCP03026	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0156	90807408-PCP03027	90807408-CCP03027	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0156	90807408-PCP03028	90807408-CCP03028	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0122	90807408-PCP05136	90807408-CCP05136	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0122	90807408-PCP05137	90807408-CCP05137	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0122	90807408-PCP05138	90807408-CCP05138	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0122	90807408-PCP05139	90807408-CCP05139	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0725	52883637-CIN27-OCPP-ECS--C8CA9	52883637-CIN27-OCPP-ECS--C8CA9|01	1	CCS1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1648	90807408-PCP04978	90807408-CCP04978	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0601	52883637-CIN27-OCPP-ECS--E1CDE	52883637-CIN27-OCPP-ECS--E1CDE|01	1	CCS1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0754	85111787-P018	85111787-C018	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	4		2026-05-01 01:00:08+00
臺北市	\N	TPE0754	85111787-P019	85111787-C019	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	4		2026-05-01 01:00:08+00
臺北市	\N	TPE0754	85111787-P020	85111787-C020	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	4		2026-05-01 01:00:08+00
臺北市	\N	TPE0754	85111787-P043	85111787-C043	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	4		2026-05-01 01:00:08+00
臺北市	\N	TPE1550	93100784-P0101	93100784-C0101	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1550	93100784-P0102	93100784-C0102	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1550	93100784-P0103	93100784-C0103	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1550	93101587-P0104	93100784-C0104	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1401	94175832-P3b2c7afa9692	94175832-C3b2c7afa96921	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1401	94175832-P852302008d69	94175832-C852302008d691	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1401	94175832-Pc1decdfd68ed	94175832-Cc1decdfd68ed1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0178	90807408-PCP03352	90807408-CCP03352	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0178	90807408-PCP03353	90807408-CCP03353	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0178	90807408-PCP03354	90807408-CCP03354	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0178	90807408-PCP03355	90807408-CCP03355	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0178	90807408-PCP03356	90807408-CCP03356	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0930	90807408-PCP03033	90807408-CCP03033	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0930	90807408-PCP03034	90807408-CCP03034	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0930	90807408-PCP03035	90807408-CCP03035	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0930	90807408-PCP03036	90807408-CCP03036	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0758	28007736-PGOWN001001	28007736-CGOWN001001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0758	28007736-PGOWN001002	28007736-CGOWN001002001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0758	28007736-PGOWN001003	28007736-CGOWN001003001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0758	28007736-PGOWN001004	28007736-CGOWN001004001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0758	28007736-PGOWN001005	28007736-CGOWN001005001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0758	28007736-PGOWN001006	28007736-CGOWN001006001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0636	12981268-PJEN243101139W0	12981268-CJEN243101139W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0006	28114216-PXP01240100065	28114216-CXP012401000651	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0006	28114216-PXP01242000071	28114216-CXP012420000711	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0006	28114216-PXP01242000072	28114216-CXP012420000721	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0006	28114216-PXP01242000073	28114216-CXP012420000731	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0006	28114216-PXP01242000079	28114216-CXP012420000791	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	4		2026-05-01 01:00:08+00
臺北市	\N	TPE0006	28114216-PXP01242000080	28114216-CXP012420000801	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	4		2026-05-01 01:00:08+00
臺北市	\N	TPE0006	28114216-PXP01242000081	28114216-CXP012420000811	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	4		2026-05-01 01:00:08+00
臺北市	\N	TPE0006	28114216-PXP01242000082	28114216-CXP012420000821	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	4		2026-05-01 01:00:08+00
臺北市	\N	TPE0006	28114216-PXP01242000083	28114216-CXP012420000831	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	4		2026-05-01 01:00:08+00
臺北市	\N	TPE0006	28114216-PXP01242000084	28114216-CXP012420000841	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	4		2026-05-01 01:00:08+00
臺北市	\N	TPE1726	00505188-P0001	00505188-C0001	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1726	00505188-P0002	00505188-C0002	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1726	00505188-P0003	00505188-C0003	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1726	00505188-P0004	00505188-C0004	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0288	90807408-PCP03221	90807408-CCP03221	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0288	90807408-PCP03222	90807408-CCP03222	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0288	90807408-PCP03223	90807408-CCP03223	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0288	90807408-PCP03224	90807408-CCP03224	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0288	90807408-PCP03225	90807408-CCP03225	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0288	90807408-PCP03226	90807408-CCP03226	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0288	90807408-PCP03227	90807408-CCP03227	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0288	90807408-PCP03228	90807408-CCP03228	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03170	90807408-CCP03170	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03171	90807408-CCP03171	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03172	90807408-CCP03172	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03173	90807408-CCP03173	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03174	90807408-CCP03174	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03175	90807408-CCP03175	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03176	90807408-CCP03176	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03177	90807408-CCP03177	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03178	90807408-CCP03178	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03179	90807408-CCP03179	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03180	90807408-CCP03180	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03181	90807408-CCP03181	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0690	90807408-PCP03182	90807408-CCP03182	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1258	28007736-PFUSN001001	28007736-CFUSN001001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1258	28007736-PFUSN001002	28007736-CFUSN001002001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1258	28007736-PFUSN001003	28007736-CFUSN001003001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1258	28007736-PFUSN001004	28007736-CFUSN001004001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0182	12981268-PJEN243101071W0	12981268-CJEN243101071W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0896	80158495-PB11CE2409046	80158495-CB11CE2409046_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0401	42649057-PCBDAX50A-24F-XX-B147	42649057-C0204-B2029	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0401	42649057-PCBDAX50A-24F-XX-B224	42649057-C0202-B2027	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0401	42649057-PCBDAX50A-24F-XX-B423	42649057-C0201-B2026	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0401	42649057-PCBDAX50A-24F-XX-B431	42649057-C0203-B2028	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1267	97329493-PB11CB2501002	97329493-CB11CB2501002_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0126	90807408-PCP03343	90807408-CCP03343	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0126	90807408-PCP03344	90807408-CCP03344	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0539	90807408-PCP03345	90807408-CCP03345	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0539	90807408-PCP03346	90807408-CCP03346	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0161	90807408-PCP03347	90807408-CCP03347	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0161	90807408-PCP03348	90807408-CCP03348	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0354	52693448-P0092	52693448-C0092	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0354	52693448-P0093	52693448-C0093	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0354	52693448-P0094	52693448-C0094	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0354	52693448-P0095	52693448-C0095	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1334	90807408-PCP04770	90807408-CCP04770	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1334	90807408-PCP04771	90807408-CCP04771	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1334	90807408-PCP04772	90807408-CCP04772	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1334	90807408-PCP04773	90807408-CCP04773	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1334	90807408-PCP04774	90807408-CCP04774	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1334	90807408-PCP04775	90807408-CCP04775	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1435	90807408-PCP03349	90807408-CCP03349	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1435	90807408-PCP03350	90807408-CCP03350	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1435	90807408-PCP03351	90807408-CCP03351	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0450	28114216-PXP01243100063	28114216-CXP012431000631	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0450	28114216-PXP01243100064	28114216-CXP012431000641	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0450	28114216-PXP01243100065	28114216-CXP012431000651	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0450	28114216-PXP01243100066	28114216-CXP012431000661	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0450	28114216-PXP01243100067	28114216-CXP012431000671	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0450	28114216-PXP01243100068	28114216-CXP012431000681	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0450	28114216-PXP01243100069	28114216-CXP012431000691	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0450	28114216-PXP01243100070	28114216-CXP012431000701	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0450	28114216-PXP01243100071	28114216-CXP012431000711	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0450	28114216-PXP01243100072	28114216-CXP012431000721	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0575	90807408-PCP03453	90807408-CCP03453	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0575	90807408-PCP03454	90807408-CCP03454	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0575	90807408-PCP03455	90807408-CCP03455	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0575	90807408-PCP03456	90807408-CCP03456	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0575	90807408-PCP03457	90807408-CCP03457	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0575	90807408-PCP03458	90807408-CCP03458	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1602	28114216-PJEN233901528W0	28114216-CJEN233901528W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1602	28114216-PJEN233901532W0	28114216-CJEN233901532W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1602	28114216-PJEN233901601W0	28114216-CJEN233901601W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1602	28114216-PJEN233901612W0	28114216-CJEN233901612W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1602	28114216-PJEN233901620W0	28114216-CJEN233901620W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1602	28114216-PJEN233901637W0	28114216-CJEN233901637W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03293	90807408-CCP03293	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03294	90807408-CCP03294	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03295	90807408-CCP03295	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03296	90807408-CCP03296	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03297	90807408-CCP03297	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03298	90807408-CCP03298	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03299	90807408-CCP03299	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03300	90807408-CCP03300	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03301	90807408-CCP03301	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03302	90807408-CCP03302	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03303	90807408-CCP03303	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03304	90807408-CCP03304	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03305	90807408-CCP03305	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03306	90807408-CCP03306	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03307	90807408-CCP03307	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0229	90807408-PCP03308	90807408-CCP03308	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0678	33029464-PTP6720001	33029464-CTP6720001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0678	33029464-PTP6720002	33029464-CTP6720002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0678	33029464-PTP6720003	33029464-CTP6720003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0678	33029464-PTP6720004	33029464-CTP6720004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0678	33029464-PTP6720005	33029464-CTP6720005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0678	33029464-PTP6720006	33029464-CTP6720006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0678	33029464-PTP6720007	33029464-CTP6720007	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0678	33029464-PTP6720008	33029464-CTP6720008	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0360	90807408-PCP03319	90807408-CCP03319	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0360	90807408-PCP03320	90807408-CCP03320	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0360	90807408-PCP03321	90807408-CCP03321	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0360	90807408-PCP03322	90807408-CCP03322	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0360	90807408-PCP03323	90807408-CCP03323	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0360	90807408-PCP03324	90807408-CCP03324	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0360	90807408-PCP03325	90807408-CCP03325	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0360	90807408-PCP03326	90807408-CCP03326	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0360	90807408-PCP03327	90807408-CCP03327	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0360	90807408-PCP03328	90807408-CCP03328	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0760	90807408-PCP05980	90807408-CCP05980	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0760	90807408-PCP05981	90807408-CCP05981	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0760	90807408-PCP05982	90807408-CCP05982	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0760	90807408-PCP05983	90807408-CCP05983	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0760	90807408-PCP05984	90807408-CCP05984	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06043	90807408-CCP06043	1	CCS1	2	DC	220V	30A	30kW	30.0	medium_dc	2		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06044	90807408-CCP06044	2	CCCS2	2	DC	220V	30A	30kW	30.0	medium_dc	2		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06045	90807408-CCP06045	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06046	90807408-CCP06046	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06047	90807408-CCP06047	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06048	90807408-CCP06048	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06049	90807408-CCP06049	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06050	90807408-CCP06050	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06051	90807408-CCP06051	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06052	90807408-CCP06052	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06053	90807408-CCP06053	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06054	90807408-CCP06054	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1032	90807408-PCP06055	90807408-CCP06055	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1084	94175832-P066ea39a49a2	94175832-C066ea39a49a21	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1084	94175832-P560fae7929c5	94175832-C560fae7929c51	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1084	94175832-Pa8db828ac3f3	94175832-Ca8db828ac3f31	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1084	94175832-Pcab349a6ee33	94175832-Ccab349a6ee331	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1084	94175832-Pd03bf6dfee46	94175832-Cd03bf6dfee461	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1084	94175832-Pe53a24a5f60b	94175832-Ce53a24a5f60b1	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1102	90807408-PCP05331	90807408-CCP05331	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-P18bdad1600ea	94175832-C18bdad1600ea1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-P19bb95bd3ff8	94175832-C19bb95bd3ff81	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-P37ad829ab6f5	94175832-C37ad829ab6f51	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-P39b9a19f6de5	94175832-C39b9a19f6de51	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-P49cb41584fd9	94175832-C49cb41584fd91	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-P4ec83372b9c6	94175832-C4ec83372b9c61	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-P52dedf648e39	94175832-C52dedf648e391	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-P5b0d88981446	94175832-C5b0d889814461	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-P6543729a1556	94175832-C6543729a15561	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-P6961d9e79f14	94175832-C6961d9e79f141	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-Pae2d65ee4105	94175832-Cae2d65ee41051	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-Pba075ac556f1	94175832-Cba075ac556f11	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-Pdfbf620f6916	94175832-Cdfbf620f69161	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1354	94175832-Pf4f51afb8e9d	94175832-Cf4f51afb8e9d1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0300	85051710-P1316	85051710-C3853	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0300	85051710-P1457	85051710-C3994	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0358	42311786-P345	42311786-C316	5	J1772_Type1	1	AC	220V	32A	1kW	1.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0407	85051710-P1277	85051710-C3814	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0407	85051710-P1278	85051710-C3815	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0407	85051710-P1423	85051710-C3960	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0752	90807408-PCP03259	90807408-CCP03259	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0752	90807408-PCP03260	90807408-CCP03260	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0752	90807408-PCP03261	90807408-CCP03261	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0752	90807408-PCP03262	90807408-CCP03262	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0752	90807408-PCP03263	90807408-CCP03263	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0752	90807408-PCP03264	90807408-CCP03264	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0752	90807408-PCP03265	90807408-CCP03265	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0752	90807408-PCP03266	90807408-CCP03266	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0751	00570949-P0001	00570949-C0001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0751	00570949-P0002	00570949-C0002	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0751	00570949-P0003	00570949-C0003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0751	00570949-P0004	00570949-C0004	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0751	00570949-P0005	00570949-C0005	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0843	52883637-CIN27-OCPP-ECS--C70E9	52883637-CIN27-OCPP-ECS--C70E9|01	1	CCS1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0722	28371994-PTP6510001	28371994-CTP6510001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0722	28371994-PTP6510002	28371994-CTP6510002	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0722	28371994-PTP6510003	28371994-CTP6510003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0722	28371994-PTP6510004	28371994-CTP6510004	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0722	28371994-PTP6510005	28371994-CTP6510005	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0722	28371994-PTP6510006	28371994-CTP6510006	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1056	94175832-P47c377db7fc5	94175832-C47c377db7fc51	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1056	94175832-Pf0d5e5e29e97	94175832-Cf0d5e5e29e971	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1108	12981268-PJEN243701159W0	12981268-CJEN243701159W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1108	12981268-PJEN243701165W0	12981268-CJEN243701165W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0775	90807408-PCP03249	90807408-CCP03249	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0775	90807408-PCP03250	90807408-CCP03250	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0775	90807408-PCP03251	90807408-CCP03251	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0775	90807408-PCP03252	90807408-CCP03252	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0775	90807408-PCP03253	90807408-CCP03253	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0775	90807408-PCP03254	90807408-CCP03254	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0775	90807408-PCP03255	90807408-CCP03255	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0775	90807408-PCP03256	90807408-CCP03256	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0775	90807408-PCP03257	90807408-CCP03257	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0775	90807408-PCP03258	90807408-CCP03258	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03267	90807408-CCP03267	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03268	90807408-CCP03268	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03269	90807408-CCP03269	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03270	90807408-CCP03270	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03278	90807408-CCP03278	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03279	90807408-CCP03279	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03280	90807408-CCP03280	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03281	90807408-CCP03281	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03282	90807408-CCP03282	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03283	90807408-CCP03283	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03284	90807408-CCP03284	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03285	90807408-CCP03285	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03286	90807408-CCP03286	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0827	90807408-PCP03287	90807408-CCP03287	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1537	12981268-PJEN243101081W0	12981268-CJEN243101081W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0654	90807408-PCP03309	90807408-CCP03309	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0654	90807408-PCP03310	90807408-CCP03310	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0654	90807408-PCP03311	90807408-CCP03311	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0654	90807408-PCP03312	90807408-CCP03312	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0654	90807408-PCP03313	90807408-CCP03313	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0654	90807408-PCP03314	90807408-CCP03314	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0654	90807408-PCP03315	90807408-CCP03315	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0654	90807408-PCP03316	90807408-CCP03316	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0654	90807408-PCP03317	90807408-CCP03317	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0654	90807408-PCP03318	90807408-CCP03318	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE1634	28114216-PXP01250300026	28114216-CXP012503000261	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0530	90807408-PCP05410	90807408-CCP05410	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0530	90807408-PCP05411	90807408-CCP05411	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0530	90807408-PCP05412	90807408-CCP05412	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0763	26262936-P589	26262936-C581	5	J1772_Type1	1	AC	220V	32A	1kW	1.0	slow_ac	B一		2026-05-01 01:00:08+00
臺北市	\N	TPE0384	85051710-P1275	85051710-C3812	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0384	85051710-P1421	85051710-C3958	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0596	53919205-P0001	53919205-C001	1	CCS1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0639	80158495-PB11CE2409064	80158495-CB11CE2409064_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0800	94175832-P1941f39c1d82	94175832-C1941f39c1d821	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0800	94175832-P20cc8dc4fef8	94175832-C20cc8dc4fef81	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0800	94175832-Pa72c3e0efaf1	94175832-Ca72c3e0efaf11	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0800	94175832-Pc1fe2ba3ec96	94175832-Cc1fe2ba3ec961	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0800	94175832-Pe40dab7ed94f	94175832-Ce40dab7ed94f1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0800	94175832-Pedb17de3f491	94175832-Cedb17de3f4911	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0952	12981268-PJEN242000747W0	12981268-CJEN242000747W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1048	94175832-P29801df24c26	94175832-C29801df24c261	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1048	94175832-P3ae0227af3d1	94175832-C3ae0227af3d11	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1048	94175832-P6cf5f96e1cae	94175832-C6cf5f96e1cae1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1048	94175832-Pcfde1660d322	94175832-Ccfde1660d3221	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1048	94175832-Pebd6439036d5	94175832-Cebd6439036d51	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1048	94175832-Pfa741efe5520	94175832-Cfa741efe55201	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1599	12981268-PJEN243701175W0	12981268-CJEN243701175W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1599	12981268-PJEN243701258W0	12981268-CJEN243701258W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0901	22957668-P0001	22957668-C0001	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0901	22957668-P0002	22957668-C0002	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0901	22957668-P0003	22957668-C0003	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0901	22957668-P0004	22957668-C0004	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0901	22957668-P0005	22957668-C0005	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0901	22957668-P0006	22957668-C0006	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0901	22957668-P0007	22957668-C0007	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0901	22957668-P0008	22957668-C0008	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0901	22957668-P0009	22957668-C0009	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE0902	22957668-P0010	22957668-C0010	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0902	22957668-P0011	22957668-C0011	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	2		2026-05-01 01:00:08+00
臺北市	\N	TPE0184	12981268-PJEN243100964W0	12981268-CJEN243100964W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1315	52883637-CIN27-OCPP-TYC--00132	52883637-CIN27-OCPP-TYC--00132|01	1	CCS1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1315	52883637-CIN27-OCPP-TYC--00133	52883637-CIN27-OCPP-TYC--00133|01	1	CCS1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0348	50965513-PA0324TYTW00132	50965513-CA0324TYTW001321	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0348	50965513-PA0324TYTW00133	50965513-CA0324TYTW001331	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1399	88260590-PB026001_1	88260590-CB026001_1	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1400	88260607-PB026101_1	88260607-CB026101_1	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1400	88260607-PB026101_2	88260607-CB026101_2	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1400	88260607-PB026101_3	88260607-CB026101_3	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1400	88260607-PB026101_4	88260607-CB026101_4	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1400	88260607-PB026101_5	88260607-CB026101_5	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1400	88260607-PB026101_6	88260607-CB026101_6	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-CNGTS366	28652185-CNGTS366	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS334	28652185-CNGTS334	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS335	28652185-CNGTS335	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS336	28652185-CNGTS336	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS337	28652185-CNGTS337	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS338	28652185-CNGTS338	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS339	28652185-CNGTS339	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS340	28652185-CNGTS340	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS341	28652185-CNGTS341	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS342	28652185-CNGTS342	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS343	28652185-CNGTS343-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS343	28652185-CNGTS343-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS344	28652185-CNGTS344-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS344	28652185-CNGTS344-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS345	28652185-CNGTS345-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS345	28652185-CNGTS345-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS346	28652185-CNGTS346-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS346	28652185-CNGTS346-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS347	28652185-CNGTS347-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS347	28652185-CNGTS347-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS348	28652185-CNGTS348-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS348	28652185-CNGTS348-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS359	28652185-CNGTS359	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS360	28652185-CNGTS360	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS361	28652185-CNGTS361	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS362	28652185-CNGTS362	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS363	28652185-CNGTS363	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS364	28652185-CNGTS364	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS365	28652185-CNGTS365	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS367	28652185-CNGTS367	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS368	28652185-CNGTS368	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS369	28652185-CNGTS369	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS370	28652185-CNGTS370-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS370	28652185-CNGTS370-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS371	28652185-CNGTS371-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS371	28652185-CNGTS371-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS372	28652185-CNGTS372-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS372	28652185-CNGTS372-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS373	28652185-CNGTS373-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS373	28652185-CNGTS373-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS374	28652185-CNGTS374-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS374	28652185-CNGTS374-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS375	28652185-CNGTS375-1	1	CCS1	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0959	28652185-PNGTS375	28652185-CNGTS375-2	2	CCCS2	2	DC	380V	60A	30kW	30.0	medium_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0724	85051710-P1270	85051710-C3807	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0724	85051710-P1271	85051710-C3808	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0724	85051710-P1417	85051710-C3954	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0215	85051710-P1276	85051710-C3813	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0215	85051710-P1422	85051710-C3959	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0279	85051710-P1269	85051710-C3806	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0279	85051710-P1416	85051710-C3953	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0381	85051710-P1272	85051710-C3809	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0381	85051710-P1418	85051710-C3955	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1388	28114216-PJEN211600131W0	28114216-CJEN211600131W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1388	28114216-PJEN211600166W0	28114216-CJEN211600166W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1388	28114216-PJEN211600208W0	28114216-CJEN211600208W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1388	28114216-PJEN212800379W0	28114216-CJEN212800379W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1388	28114216-PJEN223200639W0	28114216-CJEN223200639W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1388	28114216-PXP01244300003	28114216-CXP012443000031	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN231900730W0	28114216-CJEN231900730W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901438W0	28114216-CJEN233901438W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901444W0	28114216-CJEN233901444W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901449W0	28114216-CJEN233901449W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901450W0	28114216-CJEN233901450W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901455W0	28114216-CJEN233901455W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901456W0	28114216-CJEN233901456W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901460W0	28114216-CJEN233901460W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901461W0	28114216-CJEN233901461W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901478W0	28114216-CJEN233901478W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901491W0	28114216-CJEN233901491W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901542W0	28114216-CJEN233901542W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901564W0	28114216-CJEN233901564W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN233901590W0	28114216-CJEN233901590W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1604	28114216-PJEN241200554W0	28114216-CJEN241200554W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0824	90807408-PCP03067	90807408-CCP03067	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0824	90807408-PCP03068	90807408-CCP03068	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0824	90807408-PCP03069	90807408-CCP03069	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0824	90807408-PCP03070	90807408-CCP03070	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0824	90807408-PCP03071	90807408-CCP03071	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0824	90807408-PCP03072	90807408-CCP03072	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0239	90807408-PCP03073	90807408-CCP03073	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0239	90807408-PCP03074	90807408-CCP03074	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0239	90807408-PCP03075	90807408-CCP03075	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0239	90807408-PCP03076	90807408-CCP03076	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0239	90807408-PCP03077	90807408-CCP03077	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0239	90807408-PCP03078	90807408-CCP03078	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0239	90807408-PCP03079	90807408-CCP03079	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0239	90807408-PCP03080	90807408-CCP03080	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	 B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0425	85051710-P1001	85051710-C3538	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0425	85051710-P1002	85051710-C3539	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0425	85051710-P1159	85051710-C3696	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0425	85051710-P1160	85051710-C3697	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0425	85051710-P1319	85051710-C3856	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0425	85051710-P1320	85051710-C3857	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410001	33029464-CTP6410001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410002	33029464-CTP6410002	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410003	33029464-CTP6410003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410004	33029464-CTP6410004	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410005	33029464-CTP6410005	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410006	33029464-CTP6410006	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410007	33029464-CTP6410007	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410008	33029464-CTP6410008	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410009	33029464-CTP6410009	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410010	33029464-CTP6410010	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410011	33029464-CTP6410011	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410012	33029464-CTP6410012	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410013	33029464-CTP6410013	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410014	33029464-CTP6410014	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410015	33029464-CTP6410015	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410016	33029464-CTP6410016	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0330	33029464-PTP6410017	33029464-CTP6410017	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0441	90807408-PCP03361	90807408-CCP03361	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0441	90807408-PCP03362	90807408-CCP03362	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0099	28371994-PTP5990001	28371994-CTP5990001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0099	28371994-PTP5990002	28371994-CTP5990002	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0099	28371994-PTP5990003	28371994-CTP5990003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0099	28371994-PTP5990004	28371994-CTP5990004	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0099	28371994-PTP5990005	28371994-CTP5990005	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0099	28371994-PTP5990006	28371994-CTP5990006	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0099	28371994-PTP5990007	28371994-CTP5990007	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0099	28371994-PTP5990008	28371994-CTP5990008	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0109	28114216-PJEN233901604W0	28114216-CJEN233901604W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0109	28114216-PJEN233901734W0	28114216-CJEN233901734W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0109	28114216-PJEN233901822W0	28114216-CJEN233901822W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0109	28114216-PXP01244300002	28114216-CXP012443000021	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1206	94128120-P260145	94128120-C235786	5	J1772_Type1	1	AC	0V	0A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1206	94128120-P690893	94128120-C156636	6	Mennekes_Type2	1	AC	0V	0A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0389	01176272-P0013	01176272-C0003	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0389	01176272-P0014	01176272-C0004	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0389	01176272-P0015	01176272-C0005	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0389	01176272-P0016	01176272-C0006	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0389	01176272-P0017	01176272-C0007	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0389	01176272-P0018	01176272-C0008	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0389	01176272-P0019	01176272-C0009	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0100	28371994-PTP5490001	28371994-CTP5490001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0100	28371994-PTP5490002	28371994-CTP5490002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0100	28371994-PTP5490003	28371994-CTP5490003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0100	28371994-PTP5490004	28371994-CTP5490004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0100	28371994-PTP5490005	28371994-CTP5490005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0100	28371994-PTP5490006	28371994-CTP5490006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0100	28371994-PTP5490007	28371994-CTP5490007	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0100	28371994-PTP5490008	28371994-CTP5490008	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0100	28371994-PTP5490009	28371994-CTP5490009	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0100	28371994-PTP5490010	28371994-CTP5490010	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500001	28371994-CTP5500001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500002	28371994-CTP5500002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500003	28371994-CTP5500003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500004	28371994-CTP5500004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500005	28371994-CTP5500005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500006	28371994-CTP5500006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500007	28371994-CTP5500007	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500008	28371994-CTP5500008	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500009	28371994-CTP5500009	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500010	28371994-CTP5500010	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500011	28371994-CTP5500011	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500012	28371994-CTP5500012	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500013	28371994-CTP5500013	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500014	28371994-CTP5500014	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500015	28371994-CTP5500015	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500016	28371994-CTP5500016	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500017	28371994-CTP5500017	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500018	28371994-CTP5500018	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0110	28371994-PTP5500019	28371994-CTP5500019	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0120	89132567-P0156	89132567-C0183	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0120	89132567-P0157	89132567-C0184	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0120	89132567-P0158	89132567-C0185	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0176	12981268-PJEN253001086W0	12981268-CJEN253001086W0-1	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0977	89132567-P0319	89132567-C0356	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0015	85051710-P1273	85051710-C3810	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0015	85051710-P1419	85051710-C3956	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0014	94175832-P00b1aecbf982	94175832-C00b1aecbf9821	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0014	94175832-P58683ed03f47	94175832-C58683ed03f471	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0014	94175832-Pbc0b18de078d	94175832-Cbc0b18de078d1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0014	94175832-Pde64bbc7bf6a	94175832-Cde64bbc7bf6a1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0014	94175832-Pe3772f2bc6e8	94175832-Ce3772f2bc6e81	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0014	94175832-Pf8edcc893c93	94175832-Cf8edcc893c931	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0123	85051710-P1292	85051710-C3829	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0123	85051710-P1435	85051710-C3972	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0534	85051710-P1161	85051710-C3698	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0534	85051710-P1162	85051710-C3699	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0534	85051710-P1163	85051710-C3700	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0534	85051710-P1164	85051710-C3701	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0534	85051710-P1165	85051710-C3702	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0534	85051710-P1321	85051710-C3858	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0534	85051710-P1322	85051710-C3859	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0534	85051710-P1323	85051710-C3860	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0534	85051710-P1324	85051710-C3861	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0606	85051710-P1166	85051710-C3703	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0606	85051710-P1167	85051710-C3704	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0606	85051710-P1168	85051710-C3705	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0606	85051710-P1169	85051710-C3706	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0606	85051710-P1325	85051710-C3862	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0606	85051710-P1326	85051710-C3863	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0606	85051710-P1327	85051710-C3864	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-P10cbb6d67864	94175832-C10cbb6d678641	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-P33a3dab160d7	94175832-C33a3dab160d71	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-P57b2ea4389b5	94175832-C57b2ea4389b51	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-P70cd1e346c8d	94175832-C70cd1e346c8d1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-P80f63c72f5f2	94175832-C80f63c72f5f21	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-P88bed96cf5e4	94175832-C88bed96cf5e41	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-P936a7dfc6c39	94175832-C936a7dfc6c391	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-Pa7a2f685e94f	94175832-Ca7a2f685e94f1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-Pdd1e8de6a913	94175832-Cdd1e8de6a9131	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-Pf0d57316dd87	94175832-Cf0d57316dd871	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-Pf3c0b0142557	94175832-Cf3c0b01425571	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0447	94175832-Pf71c826dcfae	94175832-Cf71c826dcfae1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0493	94175832-P717185806f4b	94175832-C717185806f4b1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0493	94175832-Pd37b30aad078	94175832-Cd37b30aad0781	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0997	90807408-PCP05547	90807408-CCP05547	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0997	90807408-PCP05548	90807408-CCP05548	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0997	90807408-PCP05549	90807408-CCP05549	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0997	90807408-PCP05550	90807408-CCP05550	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0997	90807408-PCP05551	90807408-CCP05551	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0997	90807408-PCP05552	90807408-CCP05552	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0001	01176272-C0001	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0002	01176272-C0002	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0003	01176272-C0010	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0004	01176272-C0011	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0005	01176272-C0012	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0006	01176272-C0013	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0007	01176272-C0014	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0008	01176272-C0017	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0009	01176272-C0018	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0010	01176272-C0016	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0011	01176272-C0019	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0738	01176272-P0012	01176272-C0015	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0154	85051710-P1300	85051710-C3837	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0154	85051710-P1442	85051710-C3979	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0220	90807408-PCP06149	90807408-CCP06149	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0220	90807408-PCP06150	90807408-CCP06150	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0220	90807408-PCP06151	90807408-CCP06151	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0220	90807408-PCP06152	90807408-CCP06152	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0220	90807408-PCP06153	90807408-CCP06153	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0220	90807408-PCP06154	90807408-CCP06154	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0220	90807408-PCP06155	90807408-CCP06155	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0220	90807408-PCP06156	90807408-CCP06156	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0251	90505425-P537381	90505425-C537381-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0251	90505425-P537382	90505425-C537382-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0251	90505425-P537383	90505425-C537383-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1323	90505425-P537391	90505425-C537391-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0007	93158315-PA053001_4	93158315-CA053001_4	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0007	93158315-PA053001_5	93158315-CA053001_5	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0134	85051710-P1315	85051710-C3852	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0134	85051710-P1456	85051710-C3993	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0665	90807408-PCP04692	90807408-CCP04692	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0666	90807408-PCP04689	90807408-CCP04689	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0762	90807408-PCP03572	90807408-CCP03572	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0762	90807408-PCP03573	90807408-CCP03573	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0762	90807408-PCP03574	90807408-CCP03574	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0762	90807408-PCP03575	90807408-CCP03575	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1142	42649057-PCBDAX50A-24F-XX-B018	42649057-C0101	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0529	85012273-P561	85012273-C553	5	J1772_Type1	1	AC	220V	32A	1kW	1.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0011	28371994-PTP4340001	28371994-CTP4340001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0011	28371994-PTP4340002	28371994-CTP4340002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0011	28371994-PTP4340003	28371994-CTP4340003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0011	28371994-PTP4340004	28371994-CTP4340004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0011	28371994-PTP4340005	28371994-CTP4340005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0011	28371994-PTP4340006	28371994-CTP4340006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0011	28371994-PTP4340007	28371994-CTP4340007	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0011	28371994-PTP4340008	28371994-CTP4340008	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0011	28371994-PTP4340009	28371994-CTP4340009	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0247	28007736-PAPAL015001	28007736-CAPAL015001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B5		2026-05-01 01:00:08+00
臺北市	\N	TPE0125	85051710-P1290	85051710-C3827	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0125	85051710-P1291	85051710-C3828	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0125	85051710-P1434	85051710-C3971	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1150	85051710-P1293	85051710-C3830	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1150	85051710-P1436	85051710-C3973	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1128	85051710-P1294	85051710-C3831	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1128	85051710-P1437	85051710-C3974	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0535	89132567-P0216	89132567-C0253	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0535	89132567-P0253	89132567-C0254	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0535	89132567-P0254	89132567-C0255	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0535	89132567-P0255	89132567-C0256	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0535	89132567-P0256	89132567-C0257	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0615	89132567-P0213	89132567-C0242	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0615	89132567-P0213	89132567-C0245	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0615	89132567-P0213	89132567-C0244	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0615	89132567-P0213	89132567-C0243	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0615	89132567-P0213	89132567-C0246	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1227	53703514-P500136	53703514-C500136-1	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1476	88324010-PB11CB2501007	88324010-CB11CB2501007_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1476	88324010-PB11CE2409050	88324010-CB11CE2409050_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1585	42477884-P583	42477884-C575	5	J1772_Type1	1	AC	220V	32A	1kW	1.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1624	73981000-P0001	73981000-C0001	5	J1772_Type1	1	AC	220V	0A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0244	89132567-C0286	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0246	89132567-C0287	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0247	89132567-C0288	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0248	89132567-C0289	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0257	89132567-C0292	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0258	89132567-C0293	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0259	89132567-C0294	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0260	89132567-C0295	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0261	89132567-C0296	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0262	89132567-C0297	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0263	89132567-C0298	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0264	89132567-C0299	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0265	89132567-C0300	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0082	89132567-P0266	89132567-C0301	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1170	85051710-C3707	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1171	85051710-C3708	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1172	85051710-C3709	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1173	85051710-C3710	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1174	85051710-C3711	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1175	85051710-C3712	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1328	85051710-C3865	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1329	85051710-C3866	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1330	85051710-C3867	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1331	85051710-C3868	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1332	85051710-C3869	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0003	85051710-P1333	85051710-C3870	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0177	28371994-PTP7430001	28371994-CTP7430001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0177	28371994-PTP7430002	28371994-CTP7430002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0177	28371994-PTP7430003	28371994-CTP7430003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0177	28371994-PTP7430004	28371994-CTP7430004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0832	85051710-P1176	85051710-C3713	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0832	85051710-P1177	85051710-C3714	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0832	85051710-P1178	85051710-C3715	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0832	85051710-P1179	85051710-C3716	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0832	85051710-P1334	85051710-C3871	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0832	85051710-P1335	85051710-C3872	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0832	85051710-P1336	85051710-C3873	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0832	85051710-P1337	85051710-C3874	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0155	28114216-PJEN233901594W0	28114216-CJEN233901594W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0155	28114216-PJEN233901619W0	28114216-CJEN233901619W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0155	28114216-PJEN233901688W0	28114216-CJEN233901688W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0155	28114216-PJEN233901870W0	28114216-CJEN233901870W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0163	28114216-PJEN233901538W0	28114216-CJEN233901538W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0163	28114216-PJEN233901561W0	28114216-CJEN233901561W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0163	28114216-PJEN233901611W0	28114216-CJEN233901611W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0163	28114216-PJEN233901657W0	28114216-CJEN233901657W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0164	28114216-PJEN223200633W0	28114216-CJEN223200633W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0164	28114216-PJEN233901487W0	28114216-CJEN233901487W01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1402	94175832-P055943291dce	94175832-C055943291dce1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1402	94175832-P119317117771	94175832-C1193171177711	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1402	94175832-P16632b307c99	94175832-C16632b307c991	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1402	94175832-P4100d7a674e5	94175832-C4100d7a674e51	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1403	94175832-P01381377ae53	94175832-C01381377ae531	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1403	94175832-P0f7b694c6e58	94175832-C0f7b694c6e581	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1403	94175832-P95864b55d24d	94175832-C95864b55d24d1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1403	94175832-Pb0d7bf55a3f9	94175832-Cb0d7bf55a3f91	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1403	94175832-Pd68fda6556f6	94175832-Cd68fda6556f61	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0355	28371994-PTP4180001	28371994-CTP4180001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0355	28371994-PTP4180002	28371994-CTP4180002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0355	28371994-PTP4180003	28371994-CTP4180003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0355	28371994-PTP4180004	28371994-CTP4180004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0355	28371994-PTP4180005	28371994-CTP4180005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0355	28371994-PTP4180006	28371994-CTP4180006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0355	28371994-PTP4180007	28371994-CTP4180007	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0356	28371994-PTP4170001	28371994-CTP4170001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0356	28371994-PTP4170002	28371994-CTP4170002	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0054	90807408-PCP05910	90807408-CCP05910	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0054	90807408-PCP05911	90807408-CCP05911	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0054	90807408-PCP05912	90807408-CCP05912	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0068	28007736-PAPAL016001	28007736-CAPAL016001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0068	28007736-PAPAL016002	28007736-CAPAL016002001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0009	85051710-P1317	85051710-C3854	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0009	85051710-P1318	85051710-C3855	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0009	85051710-P1458	85051710-C3995	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0038	94175832-P04ede7b15962	94175832-C04ede7b159621	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0038	94175832-P0862b4a0fef4	94175832-C0862b4a0fef41	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0038	94175832-P337f8d6d0c5b	94175832-C337f8d6d0c5b1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0038	94175832-P3a5e3063941e	94175832-C3a5e3063941e1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0038	94175832-P4cf7ea5a0793	94175832-C4cf7ea5a07931	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0038	94175832-P602883761f97	94175832-C602883761f971	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0038	94175832-P644f3eb815b9	94175832-C644f3eb815b91	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0038	94175832-P7370cd9c5c78	94175832-C7370cd9c5c781	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0038	94175832-Pbc598842337c	94175832-Cbc598842337c1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0038	94175832-Pe82c5e467070	94175832-Ce82c5e4670701	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0075	85051710-P1223	85051710-C3760	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0075	85051710-P1224	85051710-C3761	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0075	85051710-P1225	85051710-C3762	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0075	85051710-P1376	85051710-C3913	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0075	85051710-P1377	85051710-C3914	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0072	85051710-P1226	85051710-C3763	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0072	85051710-P1227	85051710-C3764	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0072	85051710-P1228	85051710-C3765	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0072	85051710-P1378	85051710-C3915	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0072	85051710-P1379	85051710-C3916	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0072	85051710-P1380	85051710-C3917	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0656	94175832-P22e7fb6338ac	94175832-C22e7fb6338ac1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0656	94175832-P29224691b9f2	94175832-C29224691b9f21	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0656	94175832-P62934ad914af	94175832-C62934ad914af1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0656	94175832-P784f797bf77a	94175832-C784f797bf77a1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0656	94175832-P98a1eb6550b2	94175832-C98a1eb6550b21	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0656	94175832-P99731018b21e	94175832-C99731018b21e1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0656	94175832-Pbd35dfea7c77	94175832-Cbd35dfea7c771	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0656	94175832-Pcbc1561fcf1c	94175832-Ccbc1561fcf1c1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0792	94175832-P93e66eec8081	94175832-C93e66eec80811	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0792	94175832-Pd99c383b4298	94175832-Cd99c383b42981	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0884	85051710-P1229	85051710-C3766	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0884	85051710-P1230	85051710-C3767	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0884	85051710-P1231	85051710-C3768	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0884	85051710-P1232	85051710-C3769	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0884	85051710-P1381	85051710-C3918	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0884	85051710-P1382	85051710-C3919	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0884	85051710-P1383	85051710-C3920	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0851	85051710-P1233	85051710-C3770	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0851	85051710-P1234	85051710-C3771	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0851	85051710-P1235	85051710-C3772	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0851	85051710-P1236	85051710-C3773	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0851	85051710-P1237	85051710-C3774	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0851	85051710-P1238	85051710-C3775	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0851	85051710-P1384	85051710-C3921	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0851	85051710-P1385	85051710-C3922	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0851	85051710-P1386	85051710-C3923	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0851	85051710-P1387	85051710-C3924	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0851	85051710-P1388	85051710-C3925	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1598	94175832-Pa710c03e1ba0	94175832-Ca710c03e1ba01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1598	94175832-Pbd4b76bbfed2	94175832-Cbd4b76bbfed21	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1598	94175832-Pd3a6ac100229	94175832-Cd3a6ac1002291	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0766	90807408-PCP05384	90807408-CCP05384	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0766	90807408-PCP05385	90807408-CCP05385	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0766	90807408-PCP05386	90807408-CCP05386	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0766	90807408-PCP05387	90807408-CCP05387	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0766	90807408-PCP05388	90807408-CCP05388	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0766	90807408-PCP05389	90807408-CCP05389	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0766	90807408-PCP05390	90807408-CCP05390	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0766	90807408-PCP05391	90807408-CCP05391	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0766	90807408-PCP05392	90807408-CCP05392	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0766	90807408-PCP05393	90807408-CCP05393	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0874	94175832-P38a3207892e6	94175832-C38a3207892e61	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0874	94175832-P39f0592aba82	94175832-C39f0592aba821	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0874	94175832-P3a012906d1e2	94175832-C3a012906d1e21	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0874	94175832-P91fd292c29da	94175832-C91fd292c29da1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0874	94175832-Pac15ffe27661	94175832-Cac15ffe276611	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1238	97179430-P00015	97179430-C00015-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE1238	97179430-P00015	97179430-C00015-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE1238	97179430-P00016	97179430-C00016-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE1238	97179430-P00016	97179430-C00016-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE1265	90807408-PCP04691	90807408-CCP04691	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1472	89132567-P0341	89132567-C0378	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1472	89132567-P0342	89132567-C0379	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1472	89132567-P0343	89132567-C0380	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1472	89132567-P0344	89132567-C0381	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1472	89132567-P0345	89132567-C0382	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1472	89132567-P0346	89132567-C0383	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1472	89132567-P0347	89132567-C0384	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1472	89132567-P0348	89132567-C0385	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1488	89132567-P0349	89132567-C0386	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1488	89132567-P0350	89132567-C0387	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1488	89132567-P0351	89132567-C0388	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1488	89132567-P0352	89132567-C0389	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1488	89132567-P0353	89132567-C0390	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1488	89132567-P0354	89132567-C0391	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0409	85051710-P1308	85051710-C3845	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0409	85051710-P1450	85051710-C3987	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0022	94175832-P04ab0f01262f	94175832-C04ab0f01262f1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0022	94175832-P35b5b29a8974	94175832-C35b5b29a89741	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0022	94175832-Pa91ee5e72ed4	94175832-Ca91ee5e72ed41	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0022	94175832-Paf18932580b8	94175832-Caf18932580b81	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0022	94175832-Pfae0659b03cc	94175832-Cfae0659b03cc1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0253	85051710-P1681	85051710-C4280	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0253	85051710-P1682	85051710-C4281	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0253	85051710-P1683	85051710-C4282	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0253	85051710-P1684	85051710-C4283	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0253	85051710-P1685	85051710-C4284	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0253	85051710-P1686	85051710-C4285	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0253	85051710-P1687	85051710-C4286	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0253	85051710-P1688	85051710-C4287	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0343	94175832-P34312886af1b	94175832-C34312886af1b1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0343	94175832-P42445706f0ad	94175832-C42445706f0ad1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0343	94175832-P9b8ce676c780	94175832-C9b8ce676c7801	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0343	94175832-P9dc31b43781c	94175832-C9dc31b43781c1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0343	94175832-Pc494166ab301	94175832-Cc494166ab3011	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0343	94175832-Pe8cf05922625	94175832-Ce8cf059226251	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1053	94175832-P0e86183565d2	94175832-C0e86183565d21	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1053	94175832-P5de4f51566e3	94175832-C5de4f51566e31	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1053	94175832-P9d31af3a383c	94175832-C9d31af3a383c1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1053	94175832-Pd6279f5a8a8c	94175832-Cd6279f5a8a8c1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1053	94175832-Pe810c19c1b78	94175832-Ce810c19c1b781	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1053	94175832-Pee2b920d83f7	94175832-Cee2b920d83f71	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1054	94175832-P5ef4a27e014f	94175832-C5ef4a27e014f1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1054	94175832-P6b44903dc9d6	94175832-C6b44903dc9d61	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1054	94175832-P80662813b97d	94175832-C80662813b97d1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1054	94175832-P8be130de9670	94175832-C8be130de96701	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1054	94175832-P917c81772ca9	94175832-C917c81772ca91	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1123	90807408-PCP00407	90807408-CCP00407	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1667	90482725-P00186	90482725-C00186	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1667	90482725-P00188	90482725-C00188	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0571	90505425-P5837801	90505425-C5837801-1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0571	90505425-P5837802	90505425-C5837802-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE0571	90505425-P5837803	90505425-C5837803-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	5		2026-05-01 01:00:08+00
臺北市	\N	TPE1004	85051710-P1764	85051710-C4399	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1004	85051710-P792	85051710-C3189	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0707	52883637-CIN27-OCPP-TYC--00198	52883637-CIN27-OCPP-TYC--00198|01	1	CCS1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0712	88258237-PB022401_1	88258237-CB022401_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0712	88258237-PB022401_2	88258237-CB022401_2	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0712	88258237-PB022401_3	88258237-CB022401_3	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0712	88258237-PB022401_4	88258237-CB022401_4	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0712	88258237-PB022401_5	88258237-CB022401_5	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0712	88258237-PB022401_6	88258237-CB022401_6	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0151	88258243-PB024301_1	88258243-CB024301_3	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0151	88258243-PB024301_2	88258243-CB024301_2	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0151	88258243-PB024301_3	88258243-CB024301_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0234	85051710-P1279	85051710-C3816	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0234	85051710-P1424	85051710-C3961	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0051	28371994-PTP5410001	28371994-CTP5410001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0051	28371994-PTP5410002	28371994-CTP5410002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0051	28371994-PTP5410003	28371994-CTP5410003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0051	28371994-PTP5410004	28371994-CTP5410004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0051	28371994-PTP5410005	28371994-CTP5410005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0051	28371994-PTP5410006	28371994-CTP5410006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0051	28371994-PTP5410007	28371994-CTP5410007	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1578	33029464-PTP6360001	33029464-CTP6360001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1578	33029464-PTP6360002	33029464-CTP6360002	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1578	33029464-PTP6360003	33029464-CTP6360003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1578	33029464-PTP6360004	33029464-CTP6360004	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1578	33029464-PTP6360005	33029464-CTP6360005	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1578	33029464-PTP6360006	33029464-CTP6360006	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0238	85051710-P1298	85051710-C3835	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0238	85051710-P1441	85051710-C3978	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1149	85051710-P1280	85051710-C3817	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1149	85051710-P1425	85051710-C3962	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1110	85051710-P1309	85051710-C3846	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1110	85051710-P1451	85051710-C3988	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0070	28371994-PTP6910001	28371994-CTP6910001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0070	28371994-PTP6910002	28371994-CTP6910002	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0070	28371994-PTP6910003	28371994-CTP6910003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0070	28371994-PTP6910004	28371994-CTP6910004	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0070	28371994-PTP6910005	28371994-CTP6910005	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0070	28371994-PTP6910006	28371994-CTP6910006	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0070	28371994-PTP6910007	28371994-CTP6910007	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0070	28371994-PTP6910008	28371994-CTP6910008	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900001	28371994-CTP6900001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900002	28371994-CTP6900004	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900003	28371994-CTP6900005	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900004	28371994-CTP6900007	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900005	28371994-CTP6900008	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900006	28371994-CTP6900010	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900007	28371994-CTP6900012	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900008	28371994-CTP6900013	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900009	28371994-CTP6900014	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900010	28371994-CTP6900045	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900011	28371994-CTP6900015	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900012	28371994-CTP6900016	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900013	28371994-CTP6900017	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900014	28371994-CTP6900018	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900015	28371994-CTP6900020	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900016	28371994-CTP6900021	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900017	28371994-CTP6900022	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900018	28371994-CTP6900023	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900019	28371994-CTP6900024	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900020	28371994-CTP6900025	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900021	28371994-CTP6900026	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900022	28371994-CTP6900027	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900023	28371994-CTP6900028	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900024	28371994-CTP6900029	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900025	28371994-CTP6900030	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900026	28371994-CTP6900031	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900027	28371994-CTP6900033	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900028	28371994-CTP6900034	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900029	28371994-CTP6900035	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900030	28371994-CTP6900036	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900031	28371994-CTP6900037	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900032	28371994-CTP6900038	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900033	28371994-CTP6900040	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900034	28371994-CTP6900041	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900035	28371994-CTP6900042	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900036	28371994-CTP6900043	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900037	28371994-CTP6900044	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900038	28371994-CTP6900046	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900039	28371994-CTP6900047	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0096	28371994-PTP6900040	28371994-CTP6900048	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1243	76888870-P0101	76888870-C0101	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1243	76888870-P0102	76888870-C0102	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1243	76888870-P0103	76888870-C0103	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1243	76888870-P0104	76888870-C0104	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1243	76888870-P0105	76888870-C0105	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0421	93101587-P0101	93101587-C0101	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0421	93101587-P0102	93101587-C0102	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0421	93101587-P0103	93101587-C0103	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0421	93101587-P0104	93101587-C0104	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0421	93101587-P0105	93101587-C0105	5	J1772_Type1	2	DC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0505	28007736-PGOWN003001	28007736-CGOWN003001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0505	28007736-PGOWN003002	28007736-CGOWN003002001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0505	28007736-PGOWN003003	28007736-CGOWN003003001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0505	28007736-PGOWN003004	28007736-CGOWN003004001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0505	28007736-PGOWN003005	28007736-CGOWN003005001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0505	28007736-PGOWN003006	28007736-CGOWN003006001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0505	28007736-PGOWN003007	28007736-CGOWN003007001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0505	28007736-PGOWN003008	28007736-CGOWN003008001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0505	28007736-PGOWN003009	28007736-CGOWN003009001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0505	28007736-PGOWN003010	28007736-CGOWN003010001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0106	28371994-PTP7600001	28371994-CTP7600001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0106	28371994-PTP7600002	28371994-CTP7600002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0459	80158495-PB11CB2501006	80158495-CB11CB2501006_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0542	97179430-P00123	97179430-C00123-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0542	97179430-P00123	97179430-C00123-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0542	97179430-P00124	97179430-C00124-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0542	97179430-P00124	97179430-C00124-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0542	97179430-P00125	97179430-C00125-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0542	97179430-P00125	97179430-C00125-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0542	97179430-P00126	97179430-C00126-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0542	97179430-P00126	97179430-C00126-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0741	94175832-P0145e0dbe496	94175832-C0145e0dbe4961	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0741	94175832-P1b02e1e60402	94175832-C1b02e1e604021	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1181	85051710-C3718	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1182	85051710-C3719	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1183	85051710-C3720	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1184	85051710-C3721	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1185	85051710-C3722	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1186	85051710-C3723	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1187	85051710-C3724	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1338	85051710-C3875	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1339	85051710-C3876	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1340	85051710-C3877	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1341	85051710-C3878	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1342	85051710-C3879	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1343	85051710-C3880	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0098	85051710-P1344	85051710-C3881	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0880	42861108-P133851A	42861108-C133851A-1	2	CCCS2	2	DC	400V	625A	250kW	250.0	ultra_fast_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0880	42861108-P133851B	42861108-C133851B-1	4	Tesla_TPC	2	DC	400V	625A	250kW	250.0	ultra_fast_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0880	42861108-P133851C	42861108-C133851C-1	4	Tesla_TPC	2	DC	400V	625A	250kW	250.0	ultra_fast_dc	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1012	90807408-PCP03569	90807408-CCP03569	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1012	90807408-PCP03570	90807408-CCP03570	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1012	90807408-PCP03571	90807408-CCP03571	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1188	85051710-C3725	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1189	85051710-C3726	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1190	85051710-C3727	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1191	85051710-C3728	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1192	85051710-C3729	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1193	85051710-C3730	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1194	85051710-C3731	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1195	85051710-C3732	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1196	85051710-C3733	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1197	85051710-C3734	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1198	85051710-C3735	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1199	85051710-C3736	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1200	85051710-C3737	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1201	85051710-C3738	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1202	85051710-C3739	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1203	85051710-C3740	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1204	85051710-C3741	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1205	85051710-C3742	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1206	85051710-C3743	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1345	85051710-C3882	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1346	85051710-C3883	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1347	85051710-C3884	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1348	85051710-C3885	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1349	85051710-C3886	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1350	85051710-C3887	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1351	85051710-C3888	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1352	85051710-C3889	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1353	85051710-C3890	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1354	85051710-C3891	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1355	85051710-C3892	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1356	85051710-C3893	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1357	85051710-C3894	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1358	85051710-C3895	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1359	85051710-C3896	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1360	85051710-C3897	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1361	85051710-C3898	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0095	85051710-P1362	85051710-C3899	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1292	94175832-P0587b7b1df1a	94175832-C0587b7b1df1a1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1292	94175832-Pd3313a91b309	94175832-Cd3313a91b3091	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1292	94175832-Pec7aeba08048	94175832-Cec7aeba080481	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1505	88339626-P626	88339626-C618	5	J1772_Type1	1	AC	220V	32A	1kW	1.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0127	85051710-P1288	85051710-C3825	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0127	85051710-P1289	85051710-C3826	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0127	85051710-P1433	85051710-C3970	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0129	90807408-PCP04688	90807408-CCP04688	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1593	90807408-PCP00093	90807408-CCP00093	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0135	97179430-P00027	97179430-C00027-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0135	97179430-P00027	97179430-C00027-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0135	97179430-P00028	97179430-C00028-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0135	97179430-P00028	97179430-C00028-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0255	89132567-P0159	89132567-C0186	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0255	89132567-P0160	89132567-C0187	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0255	89132567-P0161	89132567-C0188	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0255	89132567-P0162	89132567-C0189	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0255	89132567-P0163	89132567-C0190	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0255	89132567-P0164	89132567-C0191	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0255	89132567-P0165	89132567-C0192	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1207	85051710-C3744	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1208	85051710-C3745	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1209	85051710-C3746	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1210	85051710-C3747	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1211	85051710-C3748	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1212	85051710-C3749	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1213	85051710-C3750	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1214	85051710-C3751	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1215	85051710-C3752	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1216	85051710-C3753	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1363	85051710-C3900	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1364	85051710-C3901	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1365	85051710-C3902	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1366	85051710-C3903	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1367	85051710-C3904	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1368	85051710-C3905	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1369	85051710-C3906	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1370	85051710-C3907	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0449	85051710-P1371	85051710-C3908	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0086	85051710-P1217	85051710-C3754	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0086	85051710-P1218	85051710-C3755	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0086	85051710-P1219	85051710-C3756	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0086	85051710-P1372	85051710-C3909	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0086	85051710-P1373	85051710-C3910	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0645	28371994-PTP5850001	28371994-CTP5850001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0645	28371994-PTP5850002	28371994-CTP5850002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0645	28371994-PTP5850003	28371994-CTP5850003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0645	28371994-PTP5850004	28371994-CTP5850004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0645	28371994-PTP5850005	28371994-CTP5850005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0645	28371994-PTP5850006	28371994-CTP5850006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0645	28371994-PTP5850007	28371994-CTP5850007	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0645	28371994-PTP5850008	28371994-CTP5850008	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1011	90807408-PCP03568	90807408-CCP03568	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0066	97179430-P00091	97179430-C00091-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0066	97179430-PT0363	97179430-CT0363-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0066	97179430-PT0365	97179430-CT0365-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0066	97179430-PT0366	97179430-CT0366-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0066	97179430-PT0367	97179430-CT0367-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0066	97179430-PT0368	97179430-CT0368-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0066	97179430-PT0370	97179430-CT0370-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0066	97179430-PT0371	97179430-CT0371-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0066	97179430-PT0375	97179430-CT0375-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0067	97179430-PT0637	97179430-CT0637-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0067	97179430-PT0637	97179430-CT0637-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0067	97179430-PT0638	97179430-CT0638-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0067	97179430-PT0638	97179430-CT0638-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0067	97179430-PT0639	97179430-CT0639-1	1	CCS1	2	DC	0V	32A	30kW	30.0	medium_dc	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0067	97179430-PT0639	97179430-CT0639-2	2	CCCS2	2	DC	0V	32A	30kW	30.0	medium_dc	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0069	97179430-P00087	97179430-C00087-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0069	97179430-P00088	97179430-C00088-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0069	97179430-P00089	97179430-C00089-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0069	97179430-P00090	97179430-C00090-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0069	97179430-P00092	97179430-C00092-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0069	97179430-P00093	97179430-C00093-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0069	97179430-P00131	97179430-C00131-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-01 01:00:08+00
臺北市	\N	TPE0313	52492792-P25543db6711e	52492792-C25543db6711e1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0716	90807408-PCP06165	90807408-CCP06165	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0716	90807408-PCP06166	90807408-CCP06166	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0716	90807408-PCP06167	90807408-CCP06167	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0716	90807408-PCP06168	90807408-CCP06168	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0716	90807408-PCP06169	90807408-CCP06169	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0468	94175832-P0028dc4e1f7e	94175832-C0028dc4e1f7e1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0468	94175832-P484402a614da	94175832-C484402a614da1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0468	94175832-P6130ba7a44cf	94175832-C6130ba7a44cf1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0468	94175832-Pa2e9b597dbad	94175832-Ca2e9b597dbad1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0468	94175832-Pde77ff2a88f8	94175832-Cde77ff2a88f81	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0468	94175832-Pf10872730c28	94175832-Cf10872730c281	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0502	94175832-P23c4914ad7d5	94175832-C23c4914ad7d51	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0502	94175832-P8c37e0b9f74b	94175832-C8c37e0b9f74b1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0502	94175832-P912946218bb2	94175832-C912946218bb21	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0502	94175832-Pa3006f613c14	94175832-Ca3006f613c141	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0502	94175832-Pf6e79aaf5403	94175832-Cf6e79aaf54031	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0502	94175832-Pfc6e730d4093	94175832-Cfc6e730d40931	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0715	85051710-P1262	85051710-C3799	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0715	85051710-P1263	85051710-C3800	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0715	85051710-P1264	85051710-C3801	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0715	85051710-P1265	85051710-C3802	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0715	85051710-P1410	85051710-C3947	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0715	85051710-P1411	85051710-C3948	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0715	85051710-P1412	85051710-C3949	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0593	83578534-FH19	83578534-FH19-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0593	83578534-FH20	83578534-FH20-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0593	83578534-FH21	83578534-FH21-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0593	83578534-FH22	83578534-FH22-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0593	83578534-FH23	83578534-FH23-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0092	90807408-PCP03199	90807408-CCP03199	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0092	90807408-PCP03200	90807408-CCP03200	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0092	90807408-PCP03201	90807408-CCP03201	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0092	90807408-PCP03202	90807408-CCP03202	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0092	90807408-PCP03203	90807408-CCP03203	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0092	90807408-PCP03204	90807408-CCP03204	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0092	90807408-PCP03205	90807408-CCP03205	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0702	28007736-PAPAL013001	28007736-CAPAL013001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0305	90807408-PCP03206	90807408-CCP03206	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0305	90807408-PCP03207	90807408-CCP03207	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0305	90807408-PCP03208	90807408-CCP03208	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0305	90807408-PCP03209	90807408-CCP03209	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0305	90807408-PCP03210	90807408-CCP03210	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0305	90807408-PCP03211	90807408-CCP03211	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0305	90807408-PCP03212	90807408-CCP03212	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0305	90807408-PCP03213	90807408-CCP03213	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0318	90807408-PCP03214	90807408-CCP03214	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0318	90807408-PCP03215	90807408-CCP03215	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0318	90807408-PCP03216	90807408-CCP03216	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0318	90807408-PCP03217	90807408-CCP03217	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0318	90807408-PCP03218	90807408-CCP03218	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0318	90807408-PCP03219	90807408-CCP03219	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0318	90807408-PCP03220	90807408-CCP03220	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1099	94175832-P5259244caf19	94175832-C5259244caf191	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1099	94175832-P572c70e1a22d	94175832-C572c70e1a22d1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1099	94175832-P9aadad028673	94175832-C9aadad0286731	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1099	94175832-Pacd82942716b	94175832-Cacd82942716b1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1099	94175832-Pb32a49b80bc4	94175832-Cb32a49b80bc41	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1099	94175832-Pf15e2af7958c	94175832-Cf15e2af7958c1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1195	90807408-PCP05360	90807408-CCP05360	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1195	90807408-PCP05361	90807408-CCP05361	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1195	90807408-PCP05362	90807408-CCP05362	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1195	90807408-PCP05363	90807408-CCP05363	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1195	90807408-PCP05364	90807408-CCP05364	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1195	90807408-PCP05365	90807408-CCP05365	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1195	90807408-PCP05366	90807408-CCP05366	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1195	90807408-PCP05367	90807408-CCP05367	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1715	28007736-PFUSN004001	28007736-CFUSN004001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0311	94175832-P22fbd5d4fe02	94175832-C22fbd5d4fe021	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0311	94175832-Pa2a97c8ff62e	94175832-Ca2a97c8ff62e1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0270	76303216-P0078	76303216-C0078	5	J1772_Type1	1	AC	200V	48A	11.5kw	11.5	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0270	76303216-P0079	76303216-C0079	5	J1772_Type1	1	AC	200V	48A	11.5kw	11.5	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0270	76303216-P0080	76303216-C0080	5	J1772_Type1	1	AC	200V	48A	11.5kw	11.5	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0270	76303216-P0081	76303216-C0081	5	J1772_Type1	1	AC	200V	48A	11.5kw	11.5	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0270	76303216-P0082	76303216-C0082	5	J1772_Type1	1	AC	200V	48A	11.5kw	11.5	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0270	76303216-P0083	76303216-C0083	5	J1772_Type1	1	AC	200V	48A	11.5kw	11.5	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1081	94175832-P519f718134a2	94175832-C519f718134a21	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1081	94175832-P8a311ddd886c	94175832-C8a311ddd886c1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1081	94175832-Pae0d47b8e5dd	94175832-Cae0d47b8e5dd1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1081	94175832-Pd5b53dc52da9	94175832-Cd5b53dc52da91	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1650	93161281-PB11CB2501001	93161281-CB11CB2501001_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1650	93161281-PB11CE2409047	93161281-CB11CE2409047_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1650	93161281-PB11CE2409054	93161281-CB11CE2409054_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0944	94175832-P49c79cb1adac	94175832-C49c79cb1adac1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0944	94175832-Pcf89bf1a6934	94175832-Ccf89bf1a69341	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0097	85051710-P1301	85051710-C3838	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0097	85051710-P1443	85051710-C3980	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0206	85051710-P1303	85051710-C3840	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0206	85051710-P1445	85051710-C3982	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0726	85051710-P1304	85051710-C3841	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0726	85051710-P1446	85051710-C3983	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0591	85051710-P1305	85051710-C3842	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0591	85051710-P1447	85051710-C3984	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0610	85051710-P1306	85051710-C3843	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0610	85051710-P1448	85051710-C3985	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0479	85051710-P1310	85051710-C3847	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0479	85051710-P1311	85051710-C3848	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0479	85051710-P1452	85051710-C3989	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0121	85051710-P1312	85051710-C3849	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0121	85051710-P1453	85051710-C3990	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0128	28007736-PGOWN002001	28007736-CGOWN002001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0128	28007736-PGOWN002002	28007736-CGOWN002002001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0128	28007736-PGOWN002003	28007736-CGOWN002003001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1589	52693448-P0143	52693448-C0143	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1589	52693448-P0144	52693448-C0144	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1589	52693448-P0145	52693448-C0145	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1589	52693448-P0146	52693448-C0146	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1589	52693448-P0147	52693448-C0147	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1589	52693448-P0148	52693448-C0148	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0840	90807408-PCP03528	90807408-CCP03528	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0840	90807408-PCP03529	90807408-CCP03529	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0840	90807408-PCP03530	90807408-CCP03530	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1148	52693448-P0041	52693448-C0041	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1148	52693448-P0042	52693448-C0042	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1148	52693448-P0043	52693448-C0043	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1148	52693448-P0044	52693448-C0044	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1411	52693448-P0123	52693448-C0123	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1411	52693448-P0124	52693448-C0124	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1411	52693448-P0125	52693448-C0125	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0153	53953738-P651	53953738-C647	5	J1772_Type1	1	AC	220V	32A	1kW	1.0	slow_ac	3		2026-05-01 01:00:08+00
臺北市	\N	TPE1164	52693448-P0126	52693448-C0126	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1164	52693448-P0127	52693448-C0127	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1164	52693448-P0128	52693448-C0128	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1164	52693448-P0129	52693448-C0129	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1164	52693448-P0130	52693448-C0130	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1164	52693448-P0131	52693448-C0131	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1164	52693448-P0132	52693448-C0132	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE0232	85051710-P1302	85051710-C3839	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0232	85051710-P1444	85051710-C3981	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0080	85051710-P1307	85051710-C3844	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0080	85051710-P1449	85051710-C3986	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0379	85051710-P1313	85051710-C3850	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0379	85051710-P1314	85051710-C3851	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0379	85051710-P1454	85051710-C3991	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE0379	85051710-P1455	85051710-C3992	6	Mennekes_Type2	1	AC	220V	50A	7kW	7.0	slow_ac	1		2026-05-01 01:00:08+00
臺北市	\N	TPE1463	50965513-PA0323TYTW00034	50965513-CA0323TYTW000341	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1676	90807408-PCP02977	90807408-CCP02977	5	J1772_Type1	1	AC	220V	50A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1676	90807408-PCP02978	90807408-CCP02978	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0230	85051710-P1239	85051710-C3776	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0230	85051710-P1240	85051710-C3777	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0230	85051710-P1241	85051710-C3778	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0230	85051710-P1242	85051710-C3779	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0230	85051710-P1389	85051710-C3926	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0230	85051710-P1390	85051710-C3927	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0230	85051710-P1391	85051710-C3928	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0230	85051710-P1392	85051710-C3929	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0108	85051710-P1243	85051710-C3780	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0108	85051710-P1244	85051710-C3781	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0108	85051710-P1245	85051710-C3782	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0108	85051710-P1246	85051710-C3783	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0108	85051710-P1247	85051710-C3784	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0108	85051710-P1248	85051710-C3785	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0108	85051710-P1393	85051710-C3930	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0108	85051710-P1394	85051710-C3931	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0108	85051710-P1395	85051710-C3932	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0108	85051710-P1396	85051710-C3933	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0108	85051710-P1397	85051710-C3934	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0334	85051710-P1249	85051710-C3786	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0334	85051710-P1250	85051710-C3787	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0334	85051710-P1251	85051710-C3788	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0334	85051710-P1252	85051710-C3789	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0334	85051710-P1253	85051710-C3790	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0334	85051710-P1398	85051710-C3935	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0334	85051710-P1399	85051710-C3936	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0334	85051710-P1400	85051710-C3937	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0334	85051710-P1401	85051710-C3938	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0835	85051710-P1266	85051710-C3803	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0835	85051710-P1267	85051710-C3804	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0835	85051710-P1268	85051710-C3805	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0835	85051710-P1413	85051710-C3950	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0835	85051710-P1414	85051710-C3951	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0835	85051710-P1415	85051710-C3952	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0816	85051710-P1254	85051710-C3791	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0816	85051710-P1255	85051710-C3792	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0816	85051710-P1256	85051710-C3793	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0816	85051710-P1402	85051710-C3939	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0816	85051710-P1403	85051710-C3940	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0816	85051710-P1404	85051710-C3941	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0848	85051710-P1257	85051710-C3794	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0848	85051710-P1258	85051710-C3795	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0848	85051710-P1259	85051710-C3796	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0848	85051710-P1405	85051710-C3942	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0848	85051710-P1406	85051710-C3943	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0848	85051710-P1407	85051710-C3944	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0567	85051710-P1260	85051710-C3797	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0567	85051710-P1261	85051710-C3798	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0567	85051710-P1408	85051710-C3945	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0567	85051710-P1409	85051710-C3946	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0926	85051710-P1220	85051710-C3757	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0926	85051710-P1221	85051710-C3758	6	Mennekes_Type2	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0926	85051710-P1222	85051710-C3759	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0926	85051710-P1374	85051710-C3911	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE0926	85051710-P1375	85051710-C3912	5	J1772_Type1	1	AC	220V	48A	7kW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	TPE1888	28652185-PTECH87	28652185-CTECH87	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1888	28652185-PTECH88	28652185-CTECH88	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1888	28652185-PTECH89	28652185-CTECH89	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	TPE1888	28652185-PTECH90	28652185-CTECH90	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B2		2026-05-01 01:00:08+00
臺北市	\N	28371994-STP4900001	28371994-PTP4900001	28371994-CTP4900001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	28371994-STP4900001	28371994-PTP4900002	28371994-CTP4900002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	28371994-STP4900001	28371994-PTP4900003	28371994-CTP4900003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	28371994-STP4900001	28371994-PTP4900004	28371994-CTP4900004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	28371994-STP4900001	28371994-PTP4900005	28371994-CTP4900005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	28371994-STP4900001	28371994-PTP4900006	28371994-CTP4900006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	28371994-STP4900001	28371994-PTP4900007	28371994-CTP4900007	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	28371994-STP4900001	28371994-PTP4900009	28371994-CTP4900009	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
臺北市	\N	28371994-STP4900001	28371994-PTP4900008	28371994-CTP4900008	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-01 01:00:08+00
新北市	\N	34104124-S01	34104124-PTHPS01	34104124-CTHPS01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	34104124-S01	34104124-PTHPS02	34104124-CTHPS02	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	42861108-S17090	42861108-PAC17090001	42861108-CAC17090001	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	42861108-S17090	42861108-PAC17090002	42861108-CAC17090002	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	42861108-S17090	42861108-PAC17090003	42861108-CAC17090003	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	42861108-S17090	42861108-PAC17090004	42861108-CAC17090004	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	42861108-S17090	42861108-PAC17090005	42861108-CAC17090005	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	42861108-S17090	42861108-PAC17090006	42861108-CAC17090006	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	54363149-Ss1n0	54363149-P3336011	54363149-C333601100	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	54363149-Ss1n0	54363149-P3336012	54363149-C333601200	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	70553757-S0001	70553757-P0001	55762636-C0001	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	70553757-S0001	55762636-PTQNP001	55762636-CTQNP001	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	54710871-S0001	54710871-P0001	54710871-P0001-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	54710871-S0001	54710871-P0002	54710871-P0002-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	54710871-S0001	54710871-P0003	54710871-P0003-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	54710871-S0001	54710871-P0004	54710871-P0004-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	54710871-S0001	54710871-P0005	54710871-P0005-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	54710871-S0001	54710871-P0006	54710871-P0006-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	54710871-S0001	54710871-P0007	54710871-P0007-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	54710871-S0001	54710871-P0008	54710871-P0008-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	54710871-S0001	54710871-P0009	54710871-P0009-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	54710871-S0001	54710871-P0010	54710871-P0010-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90016138-SF001	90016138-PFA01	90016138-CFA01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	充電椿為J1772慢充椿 AC 7 kW，CCS2/TYPE2/TPC車款，可自行使用轉經UL/CE認證轉接頭使用。	2026-05-02 14:10:16+00
新北市	\N	90016138-SF001	90016138-PFA01	90016138-CFA02	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	充電椿為J1772慢充椿 AC 7 kW，CCS2/TYPE2/TPC車款，可自行使用轉經UL/CE認證轉接頭使用。	2026-05-02 14:10:16+00
新北市	\N	90016138-S643927b1	90016138-PMSIXP01232300022	90016138-PMSIXP01232300022_1	5	J1772_Type1	1	AC	220V	32A	13kW	13.0	slow_ac	B1	充電椿為一椿AC 13 kW單槍J1772，只可為一台車充電，不同槍頭可利用轉接頭充電使用。	2026-05-02 14:10:16+00
新北市	\N	90016138-S643927b1	90016138-PMSIXP01232300023	90016138-PMSIXP01232300023_1	5	J1772_Type1	1	AC	220V	32A	13kW	13.0	slow_ac	B1	充電椿為一椿AC 13 kW單槍J1772，只可為一台車充電，不同槍頭可利用轉接頭充電使用。	2026-05-02 14:10:16+00
新北市	\N	90016138-S643927b1	90016138-PMSIXP01232300024	90016138-PMSIXP01232300024_1	5	J1772_Type1	1	AC	220V	32A	13kW	13.0	slow_ac	B1	充電椿為一椿AC 13 kW單槍J1772，只可為一台車充電，不同槍頭可利用轉接頭充電使用。	2026-05-02 14:10:16+00
新北市	\N	94128120-S0004120	94128120-P271205	94128120-C180237	5	J1772_Type1	1	AC	220V	48A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004120	94128120-P892730	94128120-C143792	5	J1772_Type1	1	AC	220V	48A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P111269	94128120-C586270	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P206044	94128120-C641327	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P277833	94128120-C551029	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P318646	94128120-C846509	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P331762	94128120-C378307	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P341423	94128120-C741017	2	CCCS2	2	DC	0V	0A	60kW	60.0	fast_dc	B4		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P387868	94128120-C760544	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P445826	94128120-C446929	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P497530	94128120-C152246	1	CCS1	2	DC	95V	60A	30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P497530	94128120-C553358	2	CCCS2	2	DC	95V	60A	30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P528544	94128120-C919624	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P627317	94128120-C792018	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P885026	94128120-C156177	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P933995	94128120-C398432	1	CCS1	2	DC	950V	60A	30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P933995	94128120-C521146	2	CCCS2	2	DC	950V	60A	30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	94128120-S0004121	94128120-P994823	94128120-C103180	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	94273051-S2gpG2Tp	94273051-P01nQttw	94273051-C2JIFsEg	5	J1772_Type1	1	AC	220V	32A	7.04kW	7.04	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94273051-S2gpG2Tp	94273051-P3nuAkas	94273051-C37rpeUd	6	Mennekes_Type2	1	AC	220V	32A	7.04kW	7.04	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94273051-S2gpG2Tp	94273051-P4KDJsFZ	94273051-C4bWyntm	6	Mennekes_Type2	1	AC	220V	32A	7.04kW	7.04	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	93519232-S0010	93519232-P0010	93519232-C00010	5	J1772_Type1	1	AC	220V	36A	7kW	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	37759379-SB0021	37759379-PB0021_1	37759379-CB0021_1	5	J1772_Type1	1	AC	220V	50A	11KW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	37759379-SB0021	37759379-PB0021_2	37759379-CB0021_2	5	J1772_Type1	1	AC	220V	50A	11KW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	60225577-SA0694011	60225577-PA0694011_1	60225577-CA0694011_1	5	J1772_Type1	1	AC	7V	7A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	91887251-SA040601	91887251-PA040601_4	91887251-CA040601_1	5	J1772_Type1	1	AC	110V	32A	7KW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	91887251-SA040601	91887251-PA040601_5	91887251-CA040601_2	5	J1772_Type1	1	AC	110V	32A	7KW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	91887251-SA040601	91887251-PA040601_6	91887251-CA040601_3	5	J1772_Type1	1	AC	110V	32A	7KW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	91887251-SA040601	91887251-PA040601_9	91887251-CA040601_5	5	J1772_Type1	1	AC	110V	32A	7KW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	91887251-SA040601	91887251-PA040601_8	91887251-CA040601_6	5	J1772_Type1	1	AC	110V	32A	7KW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	91887251-SA040601	91887251-PA040601_10	91887251-CA040601_7	5	J1772_Type1	1	AC	110V	32A	7KW	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	91903689-SA040701	91903689-PA040701_1	91903689-CA040701_1	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	91903689-SA040701	91903689-PA040701_2	91903689-CA040701_2	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	91903689-SA040701	91903689-PA040701_3	91903689-CA040701_3	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	91903689-SA040701	91903689-PA040701_4	91903689-CA040701_4	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	91903689-SA040701	91903689-PA040701_6	91903689-CA040701_5	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	91903689-SA040701	91903689-PA040701_7	91903689-CA040701_7	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-PT0655	97179430-CT0655-1	1	CCS1	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-PT0655	97179430-CT0655-2	2	CCCS2	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-PT0627	97179430-CT0627-1	1	CCS1	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-PT0627	97179430-CT0627-2	2	CCCS2	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-PT0626	97179430-CT0626-1	1	CCS1	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-PT0626	97179430-CT0626-2	2	CCCS2	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-PT0628	97179430-CT0628-1	1	CCS1	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-PT0628	97179430-CT0628-2	2	CCCS2	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-P00029	97179430-C00029-1	1	CCS1	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-P00029	97179430-C00029-2	2	CCCS2	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-PT0364	97179430-CT0364-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-P00030	97179430-C00030-1	1	CCS1	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-P00030	97179430-C00030-2	2	CCCS2	2	DC			30kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S162	97179430-PT0376	97179430-CT0376-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	97179430-S161	97179430-PT0545	97179430-CT0545-1	1	CCS1	2	DC			30kW	30.0	medium_dc	B1F		2026-05-02 14:10:16+00
新北市	\N	97179430-S161	97179430-PT0545	97179430-CT0545-2	2	CCCS2	2	DC			30kW	30.0	medium_dc	B1F		2026-05-02 14:10:16+00
新北市	\N	97179430-S161	97179430-PT0544	97179430-CT0544-1	1	CCS1	2	DC			30kW	30.0	medium_dc	B1F		2026-05-02 14:10:16+00
新北市	\N	97179430-S161	97179430-PT0544	97179430-CT0544-2	2	CCCS2	2	DC			30kW	30.0	medium_dc	B1F		2026-05-02 14:10:16+00
新北市	\N	28114216-S124	28114216-PC2450A001A0	28114216-CC2450A001A01	1	CCS1	2	DC			30kw	30.0	medium_dc	B1		2026-05-02 14:10:16+00
新北市	\N	28114216-S124	28114216-PC2450A001A0	28114216-CC2450A001A02	2	CCCS2	2	DC			30kw	30.0	medium_dc	B1		2026-05-02 14:10:16+00
新北市	\N	28114216-S124	28114216-PC2450A002A0	28114216-CC2450A002A01	1	CCS1	2	DC			30kw	30.0	medium_dc	B1		2026-05-02 14:10:16+00
新北市	\N	28114216-S124	28114216-PC2450A002A0	28114216-CC2450A002A02	2	CCCS2	2	DC			30kw	30.0	medium_dc	B1		2026-05-02 14:10:16+00
新北市	\N	28114216-S184	28114216-PC2538A009A1	28114216-CC2538A009A11	1	CCS1	2	DC			30kw	30.0	medium_dc	B2		2026-05-02 14:10:16+00
新北市	\N	28114216-S184	28114216-PC2538A009A1	28114216-CC2538A009A12	2	CCCS2	2	DC			30kw	30.0	medium_dc	B2		2026-05-02 14:10:16+00
新北市	\N	28114216-S184	28114216-PC2538A010A1	28114216-CC2538A010A11	1	CCS1	2	DC			30kw	30.0	medium_dc	B2		2026-05-02 14:10:16+00
新北市	\N	28114216-S184	28114216-PC2538A010A1	28114216-CC2538A010A12	2	CCCS2	2	DC			30kw	30.0	medium_dc	B2		2026-05-02 14:10:16+00
新北市	\N	85051710-S471	85051710-P751	85051710-C3143	6	Mennekes_Type2	1	AC	220V	32A	7.0kW	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	85051710-S471	85051710-P752	85051710-C3144	6	Mennekes_Type2	1	AC	220V	32A	7.0kW	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	85051710-S471	85051710-P753	85051710-C3145	6	Mennekes_Type2	1	AC	220V	32A	7.0kW	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	85051710-S471	85051710-P754	85051710-C3146	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	85051710-S471	85051710-P755	85051710-C3147	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	85051710-S471	85051710-P756	85051710-C3148	5	J1772_Type1	1	AC	220V	32A	7.0kW	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	85051710-S639	85051710-P1874	85051710-C4551	2	CCCS2	2	DC			180kW	180.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	85051710-S639	85051710-P1874	85051710-C4552	1	CCS1	2	DC			180kW	180.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	85051710-S639	85051710-P1875	85051710-C4553	2	CCCS2	2	DC			180kW	180.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	85051710-S639	85051710-P1875	85051710-C4554	1	CCS1	2	DC			180kW	180.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	33029464-STP6820001	33029464-PTP6820001	33029464-CTP6820001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	33029464-STP6820001	33029464-PTP6820002	33029464-CTP6820002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	33029464-STP6640001	33029464-PTP6640001	33029464-CTP6640001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	33029464-STP6640001	33029464-PTP6640002	33029464-CTP6640002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	33029464-STP6640001	33029464-PTP6640003	33029464-CTP6640003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	33029464-STP6640001	33029464-PTP6640004	33029464-CTP6640004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	33029464-STP6640001	33029464-PTP6640005	33029464-CTP6640005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	33029464-STP6640001	33029464-PTP6640006	33029464-CTP6640006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630001	28371994-CTP7630001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630002	28371994-CTP7630002	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630003	28371994-CTP7630003	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630004	28371994-CTP7630004	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630005	28371994-CTP7630005	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630006	28371994-CTP7630006	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630007	28371994-CTP7630007	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630008	28371994-CTP7630008	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630009	28371994-CTP7630009	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630010	28371994-CTP7630010	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630012	28371994-CTP7630011	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP7630001	28371994-PTP7630011	28371994-CTP7630012	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28371994-STP4370001	28371994-PTP4370001	28371994-CTP4370001	5	J1772_Type1	1	AC	220V	32A	7KW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28007736-S049	28007736-PAPAL009001	28007736-CAPAL009001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	使用APP確認按壓開始充電功能鈕後再插上充電槍	2026-05-02 14:10:16+00
新北市	\N	28007736-S051	28007736-PAPAL010001	28007736-CAPAL010001001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	使用APP確認按壓開始充電功能鈕後再插上充電槍	2026-05-02 14:10:16+00
新北市	\N	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-Pd413636d-be65-44cc-84c5-ccf2e25583c6	42861108-Ca1f8d168-afee-479b-b2b9-a6855e46f0eb	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	P1		2026-05-02 14:10:16+00
新北市	\N	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P021b25e8-b1c9-440a-b3a4-bbc39493c2f6	42861108-Cedf59e14-4708-45c1-b210-49ae3900bcd1	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	P1		2026-05-02 14:10:16+00
新北市	\N	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-Pfeddeb9f-e740-490b-a205-af42e8a5fdfe	42861108-Cefab80e6-ce01-4df0-84eb-85f221b34045	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	P1		2026-05-02 14:10:16+00
新北市	\N	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P92aa231f-d530-42ef-abde-81924a536691	42861108-Ccd4336b6-a244-4951-bd05-a338422bf182	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	P1		2026-05-02 14:10:16+00
新北市	\N	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P60f80946-5deb-44fc-bab9-1011c996235f	42861108-C60f80946-5deb-44fc-bab9-1011c996235f	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	P1		2026-05-02 14:10:16+00
新北市	\N	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P94d68dcd-0b8e-428c-9140-dd0abde6ee4a	42861108-C94d68dcd-0b8e-428c-9140-dd0abde6ee4a	6	Mennekes_Type2	1	AC	220V	32A	8kW	8.0	slow_ac	P1		2026-05-02 14:10:16+00
新北市	\N	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P13706e1b-c862-4d71-b7cd-286452c8d953	42861108-C13706e1b-c862-4d71-b7cd-286452c8d953	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	P1		2026-05-02 14:10:16+00
新北市	\N	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-Pf0d991a6-f3d1-4a5f-8079-0f4a768f2669	42861108-Cf0d991a6-f3d1-4a5f-8079-0f4a768f2669	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	P1		2026-05-02 14:10:16+00
新北市	\N	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P47e8bfd6-ef86-4d7e-83ed-1e0e5576e936	42861108-C47e8bfd6-ef86-4d7e-83ed-1e0e5576e936	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	P1		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P8866fe95-3bdb-460c-a235-3f9fcba65590	42861108-C486c48c3-1a78-4cbb-b513-364214a5b3f7	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P8866fe95-3bdb-460c-a235-3f9fcba65590	42861108-Cfd44d3bb-fed2-4376-a84d-610c711fc77f	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P563a554c-22f2-46b0-bb15-f28ec1bdb83d	42861108-C9cb4c565-1829-48d2-a8af-7df9384eafda	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P563a554c-22f2-46b0-bb15-f28ec1bdb83d	42861108-Cfb15458d-11ab-423f-9122-5ff6c6f91783	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-Pbbfd1ab7-30a0-4ed9-9cc5-d2cc4f249993	42861108-C00c90dc3-3102-468a-b8c6-a5307585395a	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-Pbbfd1ab7-30a0-4ed9-9cc5-d2cc4f249993	42861108-Cac5f28ba-d896-471e-9704-5cc049c0764f	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-Pad86a9ec-9a3a-4d3e-b919-933a54af7e7c	42861108-C1804a930-3de9-4f31-803d-c95c27b358ff	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-Pad86a9ec-9a3a-4d3e-b919-933a54af7e7c	42861108-Cd6d82ea8-cbca-4b9b-a65c-353ccc0fe6ac	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P54b93bd8-c22a-4239-b000-069551589620	42861108-Ceb31832f-fe8d-48c3-96c6-a1f1188d4638	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P54b93bd8-c22a-4239-b000-069551589620	42861108-C65b8680d-ded2-4c68-ac39-ff80bdd1c1b7	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P4f9e5796-a4cd-4d3d-9c78-a6b32aedca93	42861108-Ca223c0a4-8c00-4a3f-bebe-826018462510	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P4f9e5796-a4cd-4d3d-9c78-a6b32aedca93	42861108-Cc929f9db-46c5-4a5c-9b23-2c0fcd203e07	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-Pec1b6a70-e1ba-4864-b81e-70642a42fdbb	42861108-C843d9126-0f82-4068-8c84-830766570e2c	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-Pec1b6a70-e1ba-4864-b81e-70642a42fdbb	42861108-Ce00e2081-2bd7-4c71-ab04-ce8abfdf5cb4	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P6ee524a7-49a6-4d86-8372-25c80bd3319c	42861108-Ce3ac41a2-8274-4940-9d18-23ebbc5783cf	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P6ee524a7-49a6-4d86-8372-25c80bd3319c	42861108-Ce37914db-f686-4821-b191-ff2b0f1640c5	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	6		2026-05-02 14:10:16+00
新北市	\N	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P319f8be0-44d4-44d9-8a2f-a65294690113	42861108-Cfbf32121-5305-464e-88bd-a499a3465099	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P319f8be0-44d4-44d9-8a2f-a65294690113	42861108-C139b5dc5-b179-460f-b536-cacb3a082a5d	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P372aac2f-ec4e-47ff-8cdf-07a3f5341f5c	42861108-C8569da84-4713-4c2d-b934-74b3e17b58d6	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P372aac2f-ec4e-47ff-8cdf-07a3f5341f5c	42861108-C48c2467f-982f-4d21-bf5b-c0d52e1aa33d	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P14c97ecf-6821-442e-af63-3c7b44eb88c2	42861108-C3feab994-7398-4297-98a1-46d07b6ea1b5	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P14c97ecf-6821-442e-af63-3c7b44eb88c2	42861108-C4f1aa8a4-3b41-4726-a83c-cccc5195ea90	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P29723d46-e090-4ab5-877e-47b05b38d441	42861108-C55a1ed1e-ca8c-4dd5-a41f-48ef8372eced	4	Tesla_TPC	2	DC	464V	400A	72kW	72.0	fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P29723d46-e090-4ab5-877e-47b05b38d441	42861108-C7d66cf0e-c6b4-4bab-bb6e-7ef9d748ac08	2	CCCS2	2	DC	464V	400A	72kW	72.0	fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-Sbe38b430-6d41-40e7-bc9d-d0f913b1f36a	42861108-P389453be-0c9c-4c5a-ab7d-01decfa3bc16	42861108-C1be18963-8246-4711-8a68-0ab68ba432e4	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B3		2026-05-02 14:10:16+00
新北市	\N	42861108-Sbe38b430-6d41-40e7-bc9d-d0f913b1f36a	42861108-Pf80bf745-e0be-4c51-b647-77d0b511df7e	42861108-C6435267c-4ab5-4198-b68d-07c19a4e1008	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B3		2026-05-02 14:10:16+00
新北市	\N	42861108-Sbe38b430-6d41-40e7-bc9d-d0f913b1f36a	42861108-P49e5c042-7ece-4c34-9cef-889774b7a315	42861108-Cb5d824f0-6316-4739-81aa-6545d54869c2	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B3		2026-05-02 14:10:16+00
新北市	\N	42861108-Sbe38b430-6d41-40e7-bc9d-d0f913b1f36a	42861108-P1b326536-20b8-40be-8088-948ca9e0f15d	42861108-C05b6d76f-7991-4c61-819a-302a611e5e00	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B3		2026-05-02 14:10:16+00
新北市	\N	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-Pcb281b35-0680-4a29-82e1-0230c1461f86	42861108-Ce7b21740-e4cb-4fb4-9faf-995c495350fa	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-Pc26555c9-0bbe-43ae-af6b-2e0cb68b001d	42861108-C07180f59-b560-4d5f-9090-ef8053dc9359	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-Pc1164e2a-eb23-45e9-8fa3-c09b52d3a1e0	42861108-C02de0234-6df5-4fd5-a557-e975be2feebf	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-P80e510be-1f0a-4021-8bc7-e0704469fef0	42861108-C0cb4bbc3-efe5-44d9-8a9d-1a04c7948d08	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-P76b2db19-ca36-44c2-a688-7b3dcb3f8551	42861108-C1ccc38f8-ab40-43a1-8c94-eb536d8d54e0	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-P0d0a8c8d-983f-4290-8902-0da867769a09	42861108-Ccb03fd22-dd8c-44be-95bf-77fdaf98ba58	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-Pd7f4a81f-7866-4ec9-b390-d92dc47b7be8	42861108-C03ddb92b-9eed-4aa8-bdcd-2ceb8e515e06	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B1		2026-05-02 14:10:16+00
新北市	\N	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-Pec216c53-6306-419d-88ab-11b99a42d8f2	42861108-C20b21821-e899-429e-9037-5d4838bcfaa5	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B1		2026-05-02 14:10:16+00
新北市	\N	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P9b6abcf0-6ad1-4abf-8512-c9c626f7a5c7	42861108-C1dd020fe-d59f-4407-a32b-e359aa4ff5af	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B1		2026-05-02 14:10:16+00
新北市	\N	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P4d7a2b81-2ec3-424e-b650-c0a06d2d9e77	42861108-C70d71faf-9512-4d23-a723-6933813d913d	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B1		2026-05-02 14:10:16+00
新北市	\N	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P88a37fe6-90bd-4724-a936-8166fe3aa870	42861108-C8d6d5ad9-93c6-4e53-ac46-11cd02e31d47	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B1		2026-05-02 14:10:16+00
新北市	\N	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P92ce0825-b0b7-4d7a-8b1d-0608e12b49a9	42861108-C517b4d16-df8f-41d9-a46b-0db4276f3615	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B1		2026-05-02 14:10:16+00
新北市	\N	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P8fd124d1-3495-4515-92e9-1748a5accb2b	42861108-C8fd124d1-3495-4515-92e9-1748a5accb2b	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P428aba14-f7b5-4597-8e12-94f35fa5af38	42861108-C428aba14-f7b5-4597-8e12-94f35fa5af38	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-Pbda10cb6-04fe-4f8d-8d40-3ccb22b6376f	42861108-Cbda10cb6-04fe-4f8d-8d40-3ccb22b6376f	4	Tesla_TPC	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P5cdff24b-b160-45ae-96ba-41f4689ded0e	42861108-C5cdff24b-b160-45ae-96ba-41f4689ded0e	4	Tesla_TPC	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P08d67c7e-4d37-4fea-8c6d-d2dfa9f5e08d	42861108-C5044da29-56f4-4bdb-8f3f-91128ce9d5a8	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P32c58ea8-6561-432a-a9d0-ceed3b69f752	42861108-C1fba5f00-db92-4edc-9638-b1aca3102269	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P21eb155b-34aa-4300-b325-697a52486a33	42861108-C8b00d7d8-b3e3-4a96-8256-75acfc0d227b	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P924026a9-e2a5-42e9-873a-0ff6dc04d18f	42861108-Cd6b811fc-2313-432c-8a09-372bd3381e3d	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P5d2f77a5-e1e7-458f-bb12-a6b1598e2b51	42861108-C43e4f23b-f466-40e9-a86d-48fc110ce32e	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P4fa2e589-212f-4b46-be12-58a9d06dd9c4	42861108-C64bfefb4-4d94-4101-8097-c062256fc709	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Paeb44428-c399-4827-ad77-18cb09d2caf9	42861108-Caeb44428-c399-4827-ad77-18cb09d2caf9	6	Mennekes_Type2	1	AC	220V	32A	5kW	5.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Pd6c621db-0335-4305-9013-4cccde695983	42861108-Cd6c621db-0335-4305-9013-4cccde695983	6	Mennekes_Type2	1	AC	220V	32A	5kW	5.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Pd3ea0f21-1476-4087-9967-abcbe64e1bd0	42861108-Cd3ea0f21-1476-4087-9967-abcbe64e1bd0	6	Mennekes_Type2	1	AC	220V	32A	5kW	5.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Pbb325273-1757-4122-8846-7013ff99a196	42861108-Cbb325273-1757-4122-8846-7013ff99a196	6	Mennekes_Type2	1	AC	220V	32A	5kW	5.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-P504ccc86-8f1b-45d4-914b-c1730e23328d	42861108-C504ccc86-8f1b-45d4-914b-c1730e23328d	6	Mennekes_Type2	1	AC	220V	32A	5kW	5.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Pc597b5e3-7a0a-4c4b-bf3d-49d0b11951dd	42861108-Cc597b5e3-7a0a-4c4b-bf3d-49d0b11951dd	6	Mennekes_Type2	1	AC	220V	32A	5kW	5.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-P4be4a53c-bd26-468a-8fed-f4efac313c6d	42861108-C4be4a53c-bd26-468a-8fed-f4efac313c6d	6	Mennekes_Type2	1	AC	220V	32A	5kW	5.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-P44dd1450-4086-4572-85d7-99d3d616797d	42861108-C44dd1450-4086-4572-85d7-99d3d616797d	6	Mennekes_Type2	1	AC	220V	32A	5kW	5.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Pb7bb5e80-c2ad-4125-a7d6-0329b7ef49ab	42861108-Cb7bb5e80-c2ad-4125-a7d6-0329b7ef49ab	6	Mennekes_Type2	1	AC	220V	32A	5kW	5.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S90b04491-49d2-4010-b5f5-30dd08d88254	42861108-P00efc985-2d8e-4c23-bb97-323ba11708aa	42861108-C00efc985-2d8e-4c23-bb97-323ba11708aa	6	Mennekes_Type2	1	AC	220V	32A	9kW	9.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S90b04491-49d2-4010-b5f5-30dd08d88254	42861108-P913e8708-3bb3-4c85-a22d-9c0a25e8adad	42861108-C913e8708-3bb3-4c85-a22d-9c0a25e8adad	4	Tesla_TPC	1	AC	220V	32A	9kW	9.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S90b04491-49d2-4010-b5f5-30dd08d88254	42861108-P62c5b17d-1e84-484b-9b37-e12f66137b31	42861108-C62c5b17d-1e84-484b-9b37-e12f66137b31	4	Tesla_TPC	1	AC	220V	32A	9kW	9.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S7cb16f34-2913-4db7-bc2f-a6ba16f52005	42861108-Pf1d69031-6c55-4bb7-b70a-5a95da319916	42861108-Cf1d69031-6c55-4bb7-b70a-5a95da319916	6	Mennekes_Type2	1	AC	220V	32A	6kW	6.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S7cb16f34-2913-4db7-bc2f-a6ba16f52005	42861108-P4f15f017-4241-4224-8e26-4cb6f3c40fe0	42861108-C4f15f017-4241-4224-8e26-4cb6f3c40fe0	6	Mennekes_Type2	1	AC	220V	32A	6kW	6.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S7cb16f34-2913-4db7-bc2f-a6ba16f52005	42861108-P0531c9f1-bbba-4dcc-9ff0-343f4775bec2	42861108-C0531c9f1-bbba-4dcc-9ff0-343f4775bec2	6	Mennekes_Type2	1	AC	220V	32A	6kW	6.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S01342a10-aa64-4f90-ae30-1b8d7d3fcc86	42861108-Pc3e22455-10a6-4734-b926-740ec56537f4	42861108-Cc3e22455-10a6-4734-b926-740ec56537f4	4	Tesla_TPC	1	AC	220V	32A	9kW	9.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S01342a10-aa64-4f90-ae30-1b8d7d3fcc86	42861108-P9fd24641-b97e-4274-99ee-9970865a596d	42861108-C9fd24641-b97e-4274-99ee-9970865a596d	6	Mennekes_Type2	1	AC	220V	32A	9kW	9.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S01342a10-aa64-4f90-ae30-1b8d7d3fcc86	42861108-Pcab4f7cf-74a8-4d88-af35-279432ffa627	42861108-Ccab4f7cf-74a8-4d88-af35-279432ffa627	4	Tesla_TPC	1	AC	220V	32A	9kW	9.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S852a2236-52bc-4366-aa9e-1552330789ac	42861108-Pd3b5ae35-b8fc-439b-9ff0-1c3a54224af0	42861108-Cd3b5ae35-b8fc-439b-9ff0-1c3a54224af0	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S852a2236-52bc-4366-aa9e-1552330789ac	42861108-P6e5f55a5-8adf-40d9-8039-86dc02224694	42861108-C6e5f55a5-8adf-40d9-8039-86dc02224694	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S852a2236-52bc-4366-aa9e-1552330789ac	42861108-Pb1a02e92-1538-4586-978a-ac77912a7ef4	42861108-Cb1a02e92-1538-4586-978a-ac77912a7ef4	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S852a2236-52bc-4366-aa9e-1552330789ac	42861108-P634bb11a-37c0-4df3-97c4-356dc1aa5bec	42861108-C634bb11a-37c0-4df3-97c4-356dc1aa5bec	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P09b4777a-a84a-4cb1-878b-d2a027ae768e	42861108-C518a7b5d-b2f7-4cfe-9d38-23518a5f11b7	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-Pc7b4eab2-1474-4b67-b98d-1c6a2e63aff3	42861108-C05f186d4-3503-4fbb-9436-b943f35f921f	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P5fc77dcc-c690-4398-8f2b-318964d0ced8	42861108-C7052735f-3de4-4c19-b51e-0e479fb42bab	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P12fc9180-5c55-4c49-9753-5570d5f5c7dd	42861108-Caa9f51aa-395a-45f8-93f4-ba08445b7b35	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P34bf43ad-60ae-4369-8b12-c2b72988b191	42861108-C867ea515-6120-444b-9bce-51cd3b457a6c	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P8c93b373-6cf9-4cc4-b512-53cc7ccb8889	42861108-Ca0de42b4-f450-4de2-a30b-34f18391ea1f	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P68aeea36-7699-40b2-829c-7140f0dea995	42861108-C71fa4e0b-0fa2-4b04-a3ff-f0ce9164bbaf	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P080621bd-2325-429c-868c-529ef52fa0e0	42861108-C54ea6c8b-d9bf-47a9-b3e4-cf7c0dfdd1d8	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-Pb13ca4f2-6234-4b49-96d7-9da7e38fa823	42861108-Cb0eb089c-60bd-47f8-8515-3b2fda9d257d	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S663cbaf2-0ad2-43cf-89de-d05bfe391308	42861108-P167b3a34-39d8-419c-8c61-f4f1be0654ad	42861108-C167b3a34-39d8-419c-8c61-f4f1be0654ad	6	Mennekes_Type2	1	AC	220V	32A	3kW	3.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S663cbaf2-0ad2-43cf-89de-d05bfe391308	42861108-Pc4e6df70-44b5-4896-aacd-bdb2005ea1f7	42861108-Cc4e6df70-44b5-4896-aacd-bdb2005ea1f7	6	Mennekes_Type2	1	AC	220V	32A	3kW	3.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S663cbaf2-0ad2-43cf-89de-d05bfe391308	42861108-Pbe922fa5-de73-4a93-8c7c-c4eb0a4db117	42861108-Cbe922fa5-de73-4a93-8c7c-c4eb0a4db117	4	Tesla_TPC	1	AC	220V	32A	3kW	3.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S663cbaf2-0ad2-43cf-89de-d05bfe391308	42861108-P03ed4f2c-4e7f-4eb1-b6a8-d48cca1ce9f5	42861108-C03ed4f2c-4e7f-4eb1-b6a8-d48cca1ce9f5	4	Tesla_TPC	1	AC	220V	32A	3kW	3.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S554815bb-24da-4ed1-8e6d-5aeb04c584c6	42861108-P032fa7af-4d3a-4da9-8b94-547d89fa15c4	42861108-C95bfe465-5f9b-49ea-8749-89c77813b568	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S554815bb-24da-4ed1-8e6d-5aeb04c584c6	42861108-P43fd0b27-4fe7-43f2-abd2-b5de724398b4	42861108-Ceb0d0bad-da2a-48b4-859a-402af1c5baa8	4	Tesla_TPC	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S554815bb-24da-4ed1-8e6d-5aeb04c584c6	42861108-P0728e216-3072-43d4-a29b-40055ef45040	42861108-Ced1b18ce-84e9-4abf-ae13-bf9afa5b8af9	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S554815bb-24da-4ed1-8e6d-5aeb04c584c6	42861108-P53c134e9-4443-471d-b34d-19509470ab57	42861108-Cf1ea9349-957b-4061-9f52-1dcc4c1c185e	2	CCCS2	2	DC	470V	780A	250kW	250.0	ultra_fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-Se3f94cf3-0acd-4ed4-a383-7d095af4e934	42861108-P80f6dc2d-cddd-40f7-888f-b44431a0e194	42861108-C80f6dc2d-cddd-40f7-888f-b44431a0e194	6	Mennekes_Type2	1	AC	220V	32A	4kW	4.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-Se3f94cf3-0acd-4ed4-a383-7d095af4e934	42861108-P098633ab-4a7a-4624-bbb5-73646a190995	42861108-C098633ab-4a7a-4624-bbb5-73646a190995	6	Mennekes_Type2	1	AC	220V	32A	4kW	4.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-Se3f94cf3-0acd-4ed4-a383-7d095af4e934	42861108-P4edf898f-c5d7-48e9-8fce-dd84d1a5e2e0	42861108-C4edf898f-c5d7-48e9-8fce-dd84d1a5e2e0	6	Mennekes_Type2	1	AC	220V	32A	4kW	4.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-Se3f94cf3-0acd-4ed4-a383-7d095af4e934	42861108-P203c19bb-e683-485c-a696-d516070dd988	42861108-C203c19bb-e683-485c-a696-d516070dd988	6	Mennekes_Type2	1	AC	220V	32A	4kW	4.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S5a4c664d-b9f1-4b87-b33a-51295d34979a	42861108-P422ac2a3-3f5c-4333-907f-1353625da413	42861108-C422ac2a3-3f5c-4333-907f-1353625da413	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	42861108-S5a4c664d-b9f1-4b87-b33a-51295d34979a	42861108-Pa65c0c5c-ad58-414f-9186-421e3e8898d8	42861108-Ca65c0c5c-ad58-414f-9186-421e3e8898d8	4	Tesla_TPC	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	28652185-SJIA001	28652185-PJIA001	28652185-CJIA001	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU001	28652185-PLINKOU228	28652185-CLINKOU228	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU001	28652185-PLINKOU229	28652185-CLINKOU229	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU001	28652185-PLINKOU230	28652185-CLINKOU230	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU001	28652185-PLINKOU231	28652185-CLINKOU231	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU001	28652185-PLINKOU232	28652185-CLINKOU232	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU001	28652185-PLINKOU233	28652185-CLINKOU233	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU001	28652185-PLINKOU234	28652185-CLINKOU234	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU002	28652185-PLINKOU187	28652185-CLINKOU187	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU002	28652185-PLINKOU188	28652185-CLINKOU188	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU002	28652185-PLINKOU189	28652185-CLINKOU189	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU002	28652185-PLINKOU190	28652185-CLINKOU190	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU002	28652185-PLINKOU191	28652185-CLINKOU191	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU002	28652185-PLINKOU192	28652185-CLINKOU192	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU003	28652185-PLINKOU116	28652185-CLINKOU116	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU003	28652185-PLINKOU117	28652185-CLINKOU117	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU003	28652185-PLINKOU118	28652185-CLINKOU118	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU003	28652185-PLINKOU195	28652185-CLINKOU195	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU003	28652185-PLINKOU196	28652185-CLINKOU196	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU003	28652185-PLINKOU197	28652185-CLINKOU197	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU003	28652185-PLINKOU198	28652185-CLINKOU198	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU004	28652185-PLINKOU274	28652185-CLINKOU274	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU004	28652185-PLINKOU277	28652185-CLINKOU277	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU004	28652185-PLINKOU278	28652185-CLINKOU278	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU004	28652185-PLINKOU279	28652185-CLINKOU279	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU004	28652185-PLINKOU280	28652185-CLINKOU280	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU004	28652185-PLINKOU281	28652185-CLINKOU281	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU004	28652185-PLINKOU282	28652185-CLINKOU282	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SLINKOU004	28652185-PLINKOU283	28652185-CLINKOU283	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP137	28652185-CXZPEP137	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP138	28652185-CXZPEP138	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP139	28652185-CXZPEP139	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP140	28652185-CXZPEP140	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP141	28652185-CXZPEP141	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP142	28652185-CXZPEP142	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP143	28652185-CXZPEP143	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP144	28652185-CXZPEP144	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP145	28652185-CXZPEP145	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP146	28652185-CXZPEP146	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP156	28652185-CXZPEP156	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP157	28652185-CXZPEP157	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP158	28652185-CXZPEP158	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SXZPEP0001	28652185-PXZPEP159	28652185-CXZPEP159	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTHL0001	28652185-PMRTHL01	28652185-CMRTHL01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTHL0001	28652185-PMRTHL02	28652185-CMRTHL02	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTHL0001	28652185-PMRTHL03	28652185-CMRTHL03	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTHL0001	28652185-PMRTHL04	28652185-CMRTHL04	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTHL0001	28652185-PMRTHL05	28652185-CMRTHL05	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	28652185-SBQTS0001	28652185-PBQTS2568	28652185-CBQTS2568	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	28652185-SBQTS0001	28652185-PBQTS2569	28652185-CBQTS2569	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTHS0001	28652185-PMRTHS61	28652185-CMRTHS61	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTHS0001	28652185-PMRTHS62	28652185-CMRTHS62	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTYN0001	28652185-PMRTYN01	28652185-CMRTYN01	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTYN0001	28652185-PMRTYN02	28652185-CMRTYN02	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTYN0001	28652185-PMRTYN03	28652185-CMRTYN03	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTYN0001	28652185-PMRTYN04	28652185-CMRTYN04	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTYN0001	28652185-PMRTYN05	28652185-CMRTYN05	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTDP0001	28652185-PMRTDP15	28652185-CMRTDP15	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	28652185-SMRTDP0001	28652185-PMRTDP16	28652185-CMRTDP16	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	83284334-S00001	83284334-P00001	83284334-C00001	5	J1772_Type1	1	AC	220V	32A	240kW	240.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	83284334-S00001	83284334-P00002	83284334-C00002	5	J1772_Type1	1	AC	220V	32A	240kW	240.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-P0ffa603de0f2	94175832-C0ffa603de0f21	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-P410694a88d16	94175832-C410694a88d161	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-P4149d79f9c33	94175832-C4149d79f9c331	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-P545c362bddd4	94175832-C545c362bddd41	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-P5845cd057279	94175832-C5845cd0572791	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-P69c2e0719742	94175832-C69c2e07197421	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-P8c59729dc965	94175832-C8c59729dc9651	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-P9044874c5e97	94175832-C9044874c5e971	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-Pa10598be79fe	94175832-Ca10598be79fe1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-Pa1ba5b242f54	94175832-Ca1ba5b242f541	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-Pdad46d9f7732	94175832-Cdad46d9f77321	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-Pdcffe3b62782	94175832-Cdcffe3b627821	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-Pec337ba301bd	94175832-Cec337ba301bd1	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0279F048	94175832-Pf3d9fd86eb51	94175832-Cf3d9fd86eb511	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-P03f44245dd31	94175832-C03f44245dd311	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-P14b44f060d71	94175832-C14b44f060d711	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-P15278b17b1cc	94175832-C15278b17b1cc1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-P2b1b165472ca	94175832-C2b1b165472ca1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-P31b6ad99f72b	94175832-C31b6ad99f72b1	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-P385f2956b781	94175832-C385f2956b7811	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-P4eef2dc14411	94175832-C4eef2dc144111	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-P55d932d67aeb	94175832-C55d932d67aeb1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-P713f311b08f7	94175832-C713f311b08f71	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-P872f484c8824	94175832-C872f484c88241	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-Pd5bf751af9b5	94175832-Cd5bf751af9b51	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-Pdefafef6604c	94175832-Cdefafef6604c1	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-Pf5b44c645f9c	94175832-Cf5b44c645f9c1	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0233F039	94175832-Pff7ac2665694	94175832-Cff7ac26656941	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCG0178G001	94175832-P6fc713016ae7	94175832-C6fc713016ae71	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCG0178G001	94175832-Pa4a875a144af	94175832-Ca4a875a144af1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCG0178G001	94175832-Pd7564b71e918	94175832-Cd7564b71e9181	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCG0178G001	94175832-Pdc88c3561e5a	94175832-Cdc88c3561e5a1	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCG0178G001	94175832-Pdcacb44383ca	94175832-Cdcacb44383ca1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-P119d346709e5	94175832-C119d346709e51	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-P24b692508de2	94175832-C24b692508de21	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-P2aea3155e72d	94175832-C2aea3155e72d1	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-P589649f3facd	94175832-C589649f3facd1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-P5af2c94b32f7	94175832-C5af2c94b32f71	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-P895e34dbae21	94175832-C895e34dbae211	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-P8ef1c99577f2	94175832-C8ef1c99577f21	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-P900d1d60444c	94175832-C900d1d60444c1	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-P914e8afb908e	94175832-C914e8afb908e1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-P9b48ae74ba8a	94175832-C9b48ae74ba8a1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-Pbc274f160fa7	94175832-Cbc274f160fa71	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-Pd9b5cc03628c	94175832-Cd9b5cc03628c1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-Pf4b994897e3f	94175832-Cf4b994897e3f1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCF0259F040	94175832-Pfc2557a5b741	94175832-Cfc2557a5b7411	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	4		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0078G002	94175832-P2f546f502467	94175832-C2f546f5024671	5	J1772_Type1	1	AC	220V	31.82A	7kW	7.0	slow_ac	6		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0078G002	94175832-P6e8dbed1b096	94175832-C6e8dbed1b0961	5	J1772_Type1	1	AC	220V	31.82A	7kW	7.0	slow_ac	6		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0078G002	94175832-P7ebb65985f09	94175832-C7ebb65985f091	5	J1772_Type1	1	AC	220V	31.82A	7kW	7.0	slow_ac	6		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0078G002	94175832-Pbb8c2b67c543	94175832-Cbb8c2b67c5431	5	J1772_Type1	1	AC	220V	31.82A	7kW	7.0	slow_ac	6		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0078G002	94175832-Pc99db7f915c9	94175832-Cc99db7f915c91	5	J1772_Type1	1	AC	220V	31.82A	7kW	7.0	slow_ac	6		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0078G002	94175832-Pe39fa92e90f4	94175832-Ce39fa92e90f41	5	J1772_Type1	1	AC	220V	31.82A	7kW	7.0	slow_ac	6		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0233G002	94175832-P9005ed6b0449	94175832-C9005ed6b04491	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0233G002	94175832-P956198aaf71b	94175832-C956198aaf71b1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0233G002	94175832-Pacdf04e0765c	94175832-Cacdf04e0765c1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0233G002	94175832-Pb22f26cabfeb	94175832-Cb22f26cabfeb1	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0233G002	94175832-Pb4a1311eca79	94175832-Cb4a1311eca791	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCB0233G002	94175832-Pdd38ec619597	94175832-Cdd38ec6195971	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCG0015G001	94175832-Pa14cc67cc556	94175832-Ca14cc67cc5561	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	94175832-SUCG0015G001	94175832-Peb0c8feed88e	94175832-Ceb0c8feed88e1	6	Mennekes_Type2	1	AC	220V	50A	11kW	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SACSD00069	90807408-PCP00485	90807408-CCP00485	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SACSD00069	90807408-PCP00486	90807408-CCP00486	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD00077	90807408-PCP01560	90807408-CCP01560	5	J1772_Type1	1	AC	220V	32A	15.4kw	15.4	slow_ac	B5		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD00077	90807408-PCP01561	90807408-CCP01561	5	J1772_Type1	1	AC	220V	32A	15.4kw	15.4	slow_ac	B5		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02403	90807408-CCP02403	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02404	90807408-CCP02404	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02405	90807408-CCP02405	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02406	90807408-CCP02406	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02407	90807408-CCP02407	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02408	90807408-CCP02408	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02409	90807408-CCP02409	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02410	90807408-CCP02410	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02411	90807408-CCP02411	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02412	90807408-CCP02412	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02413	90807408-CCP02413	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02414	90807408-CCP02414	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02415	90807408-CCP02415	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP02416	90807408-CCP02416	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP06086	90807408-CCP06086	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP06087	90807408-CCP06087	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP06088	90807408-CCP06088	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP06089	90807408-CCP06089	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP06090	90807408-CCP06090	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02391	90807408-PCP06091	90807408-CCP06091	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02634	90807408-PCP03195	90807408-CCP03195	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02634	90807408-PCP03196	90807408-CCP03196	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02635	90807408-PCP03197	90807408-CCP03197	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02635	90807408-PCP03198	90807408-CCP03198	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02645	90807408-PCP03271	90807408-CCP03271	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02645	90807408-PCP03272	90807408-CCP03272	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02645	90807408-PCP03273	90807408-CCP03273	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02645	90807408-PCP03274	90807408-CCP03274	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02645	90807408-PCP03275	90807408-CCP03275	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02645	90807408-PCP03276	90807408-CCP03276	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02645	90807408-PCP03277	90807408-CCP03277	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02685	90807408-PCP03427	90807408-CCP03427	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02685	90807408-PCP03428	90807408-CCP03428	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02686	90807408-PCP03429	90807408-CCP03429	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02686	90807408-PCP03430	90807408-CCP03430	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02687	90807408-PCP03431	90807408-CCP03431	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02687	90807408-PCP03432	90807408-CCP03432	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02693	90807408-PCP03444	90807408-CCP03444	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02693	90807408-PCP03445	90807408-CCP03445	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02693	90807408-PCP03446	90807408-CCP03446	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03598	90807408-CCP03598	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03599	90807408-CCP03599	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03600	90807408-CCP03600	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03601	90807408-CCP03601	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03602	90807408-CCP03602	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03603	90807408-CCP03603	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03604	90807408-CCP03604	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03605	90807408-CCP03605	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03606	90807408-CCP03606	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03607	90807408-CCP03607	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03608	90807408-CCP03608	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03609	90807408-CCP03609	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03610	90807408-CCP03610	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03611	90807408-CCP03611	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03612	90807408-CCP03612	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03613	90807408-CCP03613	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03614	90807408-CCP03614	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03615	90807408-CCP03615	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03616	90807408-CCP03616	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03617	90807408-CCP03617	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03618	90807408-CCP03618	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03619	90807408-CCP03619	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02763	90807408-PCP03620	90807408-CCP03620	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02779	90807408-PCP03704	90807408-CCP03704	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02779	90807408-PCP03705	90807408-CCP03705	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02779	90807408-PCP04622	90807408-CCP04622	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02779	90807408-PCP04623	90807408-CCP04623	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02780	90807408-PCP03706	90807408-CCP03706	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02780	90807408-PCP03707	90807408-CCP03707	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02781	90807408-PCP03708	90807408-CCP03708	5	J1772_Type1	1	AC	220V	32A	3.5kw	3.5	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02781	90807408-PCP03709	90807408-CCP03709	5	J1772_Type1	1	AC	220V	32A	3.5kw	3.5	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02781	90807408-PCP03710	90807408-CCP03710	6	Mennekes_Type2	1	AC	220V	32A	3.5kw	3.5	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02781	90807408-PCP03711	90807408-CCP03711	6	Mennekes_Type2	1	AC	220V	32A	3.5kw	3.5	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02782	90807408-PCP03712	90807408-CCP03712	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02782	90807408-PCP03713	90807408-CCP03713	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02783	90807408-PCP03714	90807408-CCP03714	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02783	90807408-PCP03715	90807408-CCP03715	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02787	90807408-PCP03722	90807408-CCP03722	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02787	90807408-PCP03723	90807408-CCP03723	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02787	90807408-PCP05497	90807408-CCP05497	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02787	90807408-PCP05498	90807408-CCP05498	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02788	90807408-PCP03724	90807408-CCP03724	5	J1772_Type1	1	AC	220V	32A	3.5kw	3.5	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02788	90807408-PCP03725	90807408-CCP03725	6	Mennekes_Type2	1	AC	220V	32A	3.5kw	3.5	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02788	90807408-PCP05499	90807408-CCP05499	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02788	90807408-PCP05500	90807408-CCP05500	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02789	90807408-PCP03726	90807408-CCP03726	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02789	90807408-PCP03727	90807408-CCP03727	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02789	90807408-PCP05501	90807408-CCP05501	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02789	90807408-PCP05502	90807408-CCP05502	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02789	90807408-PCP05503	90807408-CCP05503	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02789	90807408-PCP05504	90807408-CCP05504	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02789	90807408-PCP05505	90807408-CCP05505	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02790	90807408-PCP03728	90807408-CCP03728	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02790	90807408-PCP03729	90807408-CCP03729	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02790	90807408-PCP03730	90807408-CCP03730	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02790	90807408-PCP03731	90807408-CCP03731	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02790	90807408-PCP05457	90807408-CCP05457	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02790	90807408-PCP05458	90807408-CCP05458	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02790	90807408-PCP05459	90807408-CCP05459	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02790	90807408-PCP05460	90807408-CCP05460	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02790	90807408-PCP05461	90807408-CCP05461	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02790	90807408-PCP05462	90807408-CCP05462	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02790	90807408-PCP05463	90807408-CCP05463	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02791	90807408-PCP03732	90807408-CCP03732	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02791	90807408-PCP03733	90807408-CCP03733	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02791	90807408-PCP03734	90807408-CCP03734	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02791	90807408-PCP03735	90807408-CCP03735	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02791	90807408-PCP05473	90807408-CCP05473	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02791	90807408-PCP05474	90807408-CCP05474	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02792	90807408-PCP03736	90807408-CCP03736	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02792	90807408-PCP03737	90807408-CCP03737	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02792	90807408-PCP03738	90807408-CCP03738	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02792	90807408-PCP03739	90807408-CCP03739	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02792	90807408-PCP05657	90807408-CCP05657	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02792	90807408-PCP05658	90807408-CCP05658	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02792	90807408-PCP05659	90807408-CCP05659	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02792	90807408-PCP05660	90807408-CCP05660	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02793	90807408-PCP03740	90807408-CCP03740	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02793	90807408-PCP03741	90807408-CCP03741	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02793	90807408-PCP05664	90807408-CCP05664	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02793	90807408-PCP05665	90807408-CCP05665	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02793	90807408-PCP05666	90807408-CCP05666	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02793	90807408-PCP05667	90807408-CCP05667	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02793	90807408-PCP05668	90807408-CCP05668	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02793	90807408-PCP05669	90807408-CCP05669	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02794	90807408-PCP03765	90807408-CCP03765	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02794	90807408-PCP03785	90807408-CCP03785	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02794	90807408-PCP05674	90807408-CCP05674	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02794	90807408-PCP05675	90807408-CCP05675	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02794	90807408-PCP05676	90807408-CCP05676	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02794	90807408-PCP05677	90807408-CCP05677	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02794	90807408-PCP05678	90807408-CCP05678	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02794	90807408-PCP05679	90807408-CCP05679	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02794	90807408-PCP05680	90807408-CCP05680	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02794	90807408-PCP05681	90807408-CCP05681	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02794	90807408-PCP05682	90807408-CCP05682	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02802	90807408-PCP03804	90807408-CCP03804	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02802	90807408-PCP03805	90807408-CCP03805	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02803	90807408-PCP03806	90807408-CCP03806	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02803	90807408-PCP03807	90807408-CCP03807	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02803	90807408-PCP05683	90807408-CCP05683	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02803	90807408-PCP05684	90807408-CCP05684	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02803	90807408-PCP05685	90807408-CCP05685	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02804	90807408-PCP03808	90807408-CCP03808	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02804	90807408-PCP03809	90807408-CCP03809	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02804	90807408-PCP03810	90807408-CCP03810	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02804	90807408-PCP03811	90807408-CCP03811	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02804	90807408-PCP05705	90807408-CCP05705	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02804	90807408-PCP05706	90807408-CCP05706	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02804	90807408-PCP05707	90807408-CCP05707	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02804	90807408-PCP05708	90807408-CCP05708	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02804	90807408-PCP05709	90807408-CCP05709	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02804	90807408-PCP05710	90807408-CCP05710	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02804	90807408-PCP05711	90807408-CCP05711	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02809	90807408-PCP03822	90807408-CCP03822	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02809	90807408-PCP03823	90807408-CCP03823	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02810	90807408-PCP03824	90807408-CCP03824	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02810	90807408-PCP03825	90807408-CCP03825	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02810	90807408-PCP05506	90807408-CCP05506	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02810	90807408-PCP05507	90807408-CCP05507	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02810	90807408-PCP05508	90807408-CCP05508	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02810	90807408-PCP05509	90807408-CCP05509	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02811	90807408-PCP03826	90807408-CCP03826	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02811	90807408-PCP03827	90807408-CCP03827	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02811	90807408-PCP05510	90807408-CCP05510	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02811	90807408-PCP05511	90807408-CCP05511	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02811	90807408-PCP05512	90807408-CCP05512	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02812	90807408-PCP03828	90807408-CCP03828	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02812	90807408-PCP03829	90807408-CCP03829	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02812	90807408-PCP03830	90807408-CCP03830	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02812	90807408-PCP03831	90807408-CCP03831	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02812	90807408-PCP03832	90807408-CCP03832	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02812	90807408-PCP03833	90807408-CCP03833	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02812	90807408-PCP05475	90807408-CCP05475	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02812	90807408-PCP05476	90807408-CCP05476	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02812	90807408-PCP05477	90807408-CCP05477	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02812	90807408-PCP05478	90807408-CCP05478	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02812	90807408-PCP05479	90807408-CCP05479	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02813	90807408-PCP03834	90807408-CCP03834	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02813	90807408-PCP03835	90807408-CCP03835	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02814	90807408-PCP03836	90807408-CCP03836	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02814	90807408-PCP03837	90807408-CCP03837	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02814	90807408-PCP05841	90807408-CCP05841	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02815	90807408-PCP03838	90807408-CCP03838	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02815	90807408-PCP03839	90807408-CCP03839	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02815	90807408-PCP03840	90807408-CCP03840	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02815	90807408-PCP03841	90807408-CCP03841	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02815	90807408-PCP05723	90807408-CCP05723	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02815	90807408-PCP05724	90807408-CCP05724	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02815	90807408-PCP05725	90807408-CCP05725	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02815	90807408-PCP05726	90807408-CCP05726	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02815	90807408-PCP05727	90807408-CCP05727	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02816	90807408-PCP03842	90807408-CCP03842	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02816	90807408-PCP03843	90807408-CCP03843	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02816	90807408-PCP05728	90807408-CCP05728	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	3F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02817	90807408-PCP03844	90807408-CCP03844	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02817	90807408-PCP03845	90807408-CCP03845	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02817	90807408-PCP03846	90807408-CCP03846	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02817	90807408-PCP03847	90807408-CCP03847	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02817	90807408-PCP03848	90807408-CCP03848	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02817	90807408-PCP03849	90807408-CCP03849	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02878	90807408-PCP04152	90807408-CCP04152	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02878	90807408-PCP04153	90807408-CCP04153	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02878	90807408-PCP05712	90807408-CCP05712	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02878	90807408-PCP05713	90807408-CCP05713	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02878	90807408-PCP05714	90807408-CCP05714	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02878	90807408-PCP05715	90807408-CCP05715	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02878	90807408-PCP05716	90807408-CCP05716	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02878	90807408-PCP05717	90807408-CCP05717	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02878	90807408-PCP05718	90807408-CCP05718	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02879	90807408-PCP04154	90807408-CCP04154	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02879	90807408-PCP04155	90807408-CCP04155	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02879	90807408-PCP05839	90807408-CCP05839	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02879	90807408-PCP05840	90807408-CCP05840	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02880	90807408-PCP04156	90807408-CCP04156	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02880	90807408-PCP04157	90807408-CCP04157	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02880	90807408-PCP05720	90807408-CCP05720	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02880	90807408-PCP05795	90807408-CCP05795	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02881	90807408-PCP04158	90807408-CCP04158	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02881	90807408-PCP04159	90807408-CCP04159	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02881	90807408-PCP05721	90807408-CCP05721	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02881	90807408-PCP05722	90807408-CCP05722	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02882	90807408-PCP04160	90807408-CCP04160	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02882	90807408-PCP04161	90807408-CCP04161	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02883	90807408-PCP04162	90807408-CCP04162	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02883	90807408-PCP04163	90807408-CCP04163	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02883	90807408-PCP04164	90807408-CCP04164	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02883	90807408-PCP04165	90807408-CCP04165	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02883	90807408-PCP04166	90807408-CCP04166	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02883	90807408-PCP04167	90807408-CCP04167	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02883	90807408-PCP05741	90807408-CCP05741	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02884	90807408-PCP04168	90807408-CCP04168	5	J1772_Type1	1	AC	220V	32A	3.5kw	3.5	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02884	90807408-PCP04169	90807408-CCP04169	6	Mennekes_Type2	1	AC	220V	32A	3.5kw	3.5	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02884	90807408-PCP05729	90807408-CCP05729	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02884	90807408-PCP05730	90807408-CCP05730	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02884	90807408-PCP05731	90807408-CCP05731	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02884	90807408-PCP05732	90807408-CCP05732	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02884	90807408-PCP05733	90807408-CCP05733	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02885	90807408-PCP04170	90807408-CCP04170	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02885	90807408-PCP04171	90807408-CCP04171	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02885	90807408-PCP05734	90807408-CCP05734	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02885	90807408-PCP05735	90807408-CCP05735	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02885	90807408-PCP05736	90807408-CCP05736	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02886	90807408-PCP04172	90807408-CCP04172	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02886	90807408-PCP04173	90807408-CCP04173	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02886	90807408-PCP04174	90807408-CCP04174	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02886	90807408-PCP04175	90807408-CCP04175	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02886	90807408-PCP05700	90807408-CCP05700	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02886	90807408-PCP05701	90807408-CCP05701	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02886	90807408-PCP05702	90807408-CCP05702	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02886	90807408-PCP05703	90807408-CCP05703	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02886	90807408-PCP05704	90807408-CCP05704	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02887	90807408-PCP04176	90807408-CCP04176	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02887	90807408-PCP04177	90807408-CCP04177	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02887	90807408-PCP05737	90807408-CCP05737	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02888	90807408-PCP04178	90807408-CCP04178	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02888	90807408-PCP04179	90807408-CCP04179	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02888	90807408-PCP05740	90807408-CCP05740	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02889	90807408-PCP04180	90807408-CCP04180	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02889	90807408-PCP04181	90807408-CCP04181	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02889	90807408-PCP05744	90807408-CCP05744	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02889	90807408-PCP05745	90807408-CCP05745	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02889	90807408-PCP05746	90807408-CCP05746	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02889	90807408-PCP05747	90807408-CCP05747	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02889	90807408-PCP05748	90807408-CCP05748	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02889	90807408-PCP05749	90807408-CCP05749	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02889	90807408-PCP05750	90807408-CCP05750	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02890	90807408-PCP04182	90807408-CCP04182	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02890	90807408-PCP04183	90807408-CCP04183	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02890	90807408-PCP04184	90807408-CCP04184	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02890	90807408-PCP04185	90807408-CCP04185	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02890	90807408-PCP04186	90807408-CCP04186	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02890	90807408-PCP04187	90807408-CCP04187	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02890	90807408-PCP05485	90807408-CCP05485	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02890	90807408-PCP05486	90807408-CCP05486	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02890	90807408-PCP05487	90807408-CCP05487	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02890	90807408-PCP05488	90807408-CCP05488	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02891	90807408-PCP04188	90807408-CCP04188	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02891	90807408-PCP04189	90807408-CCP04189	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02891	90807408-PCP05764	90807408-CCP05764	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02891	90807408-PCP05765	90807408-CCP05765	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02891	90807408-PCP05766	90807408-CCP05766	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02892	90807408-PCP04190	90807408-CCP04190	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02892	90807408-PCP04191	90807408-CCP04191	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02892	90807408-PCP04192	90807408-CCP04192	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02892	90807408-PCP04193	90807408-CCP04193	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02893	90807408-PCP04194	90807408-CCP04194	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02893	90807408-PCP04195	90807408-CCP04195	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02893	90807408-PCP05770	90807408-CCP05770	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02893	90807408-PCP05771	90807408-CCP05771	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02893	90807408-PCP05772	90807408-CCP05772	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02894	90807408-PCP04196	90807408-CCP04196	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02894	90807408-PCP04197	90807408-CCP04197	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02894	90807408-PCP04198	90807408-CCP04198	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02894	90807408-PCP04199	90807408-CCP04199	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02895	90807408-PCP04200	90807408-CCP04200	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02895	90807408-PCP04201	90807408-CCP04201	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02895	90807408-PCP05653	90807408-CCP05653	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02895	90807408-PCP05654	90807408-CCP05654	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02895	90807408-PCP05655	90807408-CCP05655	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02895	90807408-PCP05656	90807408-CCP05656	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02896	90807408-PCP04202	90807408-CCP04202	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02896	90807408-PCP04203	90807408-CCP04203	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02896	90807408-PCP05524	90807408-CCP05524	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02896	90807408-PCP05525	90807408-CCP05525	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02896	90807408-PCP05526	90807408-CCP05526	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02897	90807408-PCP04219	90807408-CCP04219	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02897	90807408-PCP04220	90807408-CCP04220	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02898	90807408-PCP04204	90807408-CCP04204	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02898	90807408-PCP04205	90807408-CCP04205	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02898	90807408-PCP04206	90807408-CCP04206	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02898	90807408-PCP04207	90807408-CCP04207	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02898	90807408-PCP05645	90807408-CCP05645	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02898	90807408-PCP05646	90807408-CCP05646	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02898	90807408-PCP05647	90807408-CCP05647	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02898	90807408-PCP05648	90807408-CCP05648	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP04208	90807408-CCP04208	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP04209	90807408-CCP04209	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP04210	90807408-CCP04210	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP04211	90807408-CCP04211	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP04212	90807408-CCP04212	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP04213	90807408-CCP04213	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP04214	90807408-CCP04214	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP04215	90807408-CCP04215	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP04216	90807408-CCP04216	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP04217	90807408-CCP04217	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP04218	90807408-CCP04218	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP05636	90807408-CCP05636	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP05637	90807408-CCP05637	2	CCCS2	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP05638	90807408-CCP05638	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP05639	90807408-CCP05639	2	CCCS2	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02899	90807408-PCP05780	90807408-CCP05780	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02900	90807408-PCP04222	90807408-CCP04222	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02900	90807408-PCP04223	90807408-CCP04223	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02900	90807408-PCP05652	90807408-CCP05652	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02900	90807408-PCP05661	90807408-CCP05661	2	CCCS2	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02900	90807408-PCP05662	90807408-CCP05662	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02900	90807408-PCP05663	90807408-CCP05663	2	CCCS2	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02901	90807408-PCP04224	90807408-CCP04224	5	J1772_Type1	1	AC	220V	32A	3.5kw	3.5	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02901	90807408-PCP05798	90807408-CCP05798	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02901	90807408-PCP05799	90807408-CCP05799	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02901	90807408-PCP05800	90807408-CCP05800	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02902	90807408-PCP04225	90807408-CCP04225	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02902	90807408-PCP04226	90807408-CCP04226	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02902	90807408-PCP05644	90807408-CCP05644	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02902	90807408-PCP05649	90807408-CCP05649	2	CCCS2	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02902	90807408-PCP05650	90807408-CCP05650	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02902	90807408-PCP05651	90807408-CCP05651	2	CCCS2	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02903	90807408-PCP04227	90807408-CCP04227	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02903	90807408-PCP04228	90807408-CCP04228	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02904	90807408-PCP04229	90807408-CCP04229	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02904	90807408-PCP05634	90807408-CCP05634	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02904	90807408-PCP05635	90807408-CCP05635	2	CCCS2	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02905	90807408-PCP04230	90807408-CCP04230	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02905	90807408-PCP04231	90807408-CCP04231	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02905	90807408-PCP05630	90807408-CCP05630	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02905	90807408-PCP05631	90807408-CCP05631	2	CCCS2	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02905	90807408-PCP05632	90807408-CCP05632	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02905	90807408-PCP05633	90807408-CCP05633	2	CCCS2	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02906	90807408-PCP04232	90807408-CCP04232	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02906	90807408-PCP05797	90807408-CCP05797	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02907	90807408-PCP04233	90807408-CCP04233	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02908	90807408-PCP04234	90807408-CCP04234	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02908	90807408-PCP04235	90807408-CCP04235	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02909	90807408-PCP04236	90807408-CCP04236	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02909	90807408-PCP04237	90807408-CCP04237	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02910	90807408-PCP04238	90807408-CCP04238	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	平面(北側)		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02910	90807408-PCP04239	90807408-CCP04239	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	平面(南側)		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02910	90807408-PCP05513	90807408-CCP05513	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02910	90807408-PCP05514	90807408-CCP05514	2	CCCS2	2	DC			180kw	180.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02911	90807408-PCP04240	90807408-CCP04240	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02911	90807408-PCP04241	90807408-CCP04241	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02911	90807408-PCP04242	90807408-CCP04242	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02911	90807408-PCP05628	90807408-CCP05628	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02912	90807408-PCP04243	90807408-CCP04243	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02912	90807408-PCP04244	90807408-CCP04244	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02912	90807408-PCP04246	90807408-CCP04246	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02912	90807408-PCP04247	90807408-CCP04247	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02912	90807408-PCP04248	90807408-CCP04248	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02912	90807408-PCP04249	90807408-CCP04249	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02912	90807408-PCP04250	90807408-CCP04250	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02912	90807408-PCP04251	90807408-CCP04251	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02912	90807408-PCP04252	90807408-CCP04252	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02912	90807408-PCP04253	90807408-CCP04253	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02913	90807408-PCP04254	90807408-CCP04254	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02913	90807408-PCP04255	90807408-CCP04255	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02913	90807408-PCP04256	90807408-CCP04256	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02913	90807408-PCP05527	90807408-CCP05527	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02913	90807408-PCP05528	90807408-CCP05528	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02913	90807408-PCP05529	90807408-CCP05529	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02913	90807408-PCP05530	90807408-CCP05530	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02913	90807408-PCP05555	90807408-CCP05555	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02913	90807408-PCP05558	90807408-CCP05558	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02913	90807408-PCP05561	90807408-CCP05561	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02914	90807408-PCP04257	90807408-CCP04257	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02914	90807408-PCP04258	90807408-CCP04258	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02914	90807408-PCP05738	90807408-CCP05738	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02914	90807408-PCP05739	90807408-CCP05739	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02915	90807408-PCP04259	90807408-CCP04259	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02915	90807408-PCP04260	90807408-CCP04260	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02915	90807408-PCP04261	90807408-CCP04261	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02915	90807408-PCP04262	90807408-CCP04262	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02915	90807408-PCP05820	90807408-CCP05820	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02915	90807408-PCP05821	90807408-CCP05821	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02916	90807408-PCP04263	90807408-CCP04263	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02916	90807408-PCP04264	90807408-CCP04264	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02916	90807408-PCP05743	90807408-CCP05743	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02917	90807408-PCP04265	90807408-CCP04265	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02917	90807408-PCP04266	90807408-CCP04266	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02917	90807408-PCP04267	90807408-CCP04267	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02917	90807408-PCP04268	90807408-CCP04268	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02918	90807408-PCP04269	90807408-CCP04269	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02918	90807408-PCP04270	90807408-CCP04270	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02918	90807408-PCP04271	90807408-CCP04271	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02918	90807408-PCP04272	90807408-CCP04272	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02918	90807408-PCP04273	90807408-CCP04273	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02918	90807408-PCP04274	90807408-CCP04274	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02918	90807408-PCP05827	90807408-CCP05827	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02918	90807408-PCP05828	90807408-CCP05828	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02919	90807408-PCP04275	90807408-CCP04275	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02919	90807408-PCP04276	90807408-CCP04276	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02919	90807408-PCP05792	90807408-CCP05792	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02920	90807408-PCP04277	90807408-CCP04277	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02920	90807408-PCP04278	90807408-CCP04278	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02920	90807408-PCP04279	90807408-CCP04279	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02920	90807408-PCP04280	90807408-CCP04280	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02920	90807408-PCP05865	90807408-CCP05865	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02920	90807408-PCP05866	90807408-CCP05866	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02921	90807408-PCP04281	90807408-CCP04281	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02921	90807408-PCP04282	90807408-CCP04282	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02921	90807408-PCP04283	90807408-CCP04283	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02921	90807408-PCP04284	90807408-CCP04284	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02922	90807408-PCP04285	90807408-CCP04285	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02922	90807408-PCP04286	90807408-CCP04286	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02922	90807408-PCP05531	90807408-CCP05531	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02922	90807408-PCP05591	90807408-CCP05591	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02922	90807408-PCP05594	90807408-CCP05594	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02922	90807408-PCP05600	90807408-CCP05600	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02922	90807408-PCP05602	90807408-CCP05602	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP04287	90807408-CCP04287	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP04288	90807408-CCP04288	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP04289	90807408-CCP04289	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP04290	90807408-CCP04290	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05562	90807408-CCP05562	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05563	90807408-CCP05563	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05564	90807408-CCP05564	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05569	90807408-CCP05569	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05570	90807408-CCP05570	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05571	90807408-CCP05571	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05574	90807408-CCP05574	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05575	90807408-CCP05575	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05578	90807408-CCP05578	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05579	90807408-CCP05579	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05582	90807408-CCP05582	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05583	90807408-CCP05583	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02923	90807408-PCP05584	90807408-CCP05584	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02924	90807408-PCP04291	90807408-CCP04291	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02924	90807408-PCP04292	90807408-CCP04292	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02924	90807408-PCP04293	90807408-CCP04293	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02925	90807408-PCP04294	90807408-CCP04294	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02925	90807408-PCP04295	90807408-CCP04295	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02925	90807408-PCP04296	90807408-CCP04296	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02926	90807408-PCP04297	90807408-CCP04297	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02926	90807408-PCP04298	90807408-CCP04298	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02926	90807408-PCP05603	90807408-CCP05603	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02926	90807408-PCP05608	90807408-CCP05608	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02927	90807408-PCP04299	90807408-CCP04299	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02927	90807408-PCP04300	90807408-CCP04300	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02927	90807408-PCP05610	90807408-CCP05610	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02928	90807408-PCP04301	90807408-CCP04301	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02928	90807408-PCP04302	90807408-CCP04302	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02928	90807408-PCP05611	90807408-CCP05611	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02928	90807408-PCP05613	90807408-CCP05613	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02928	90807408-PCP05614	90807408-CCP05614	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02930	90807408-PCP04303	90807408-CCP04303	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02930	90807408-PCP04304	90807408-CCP04304	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02930	90807408-PCP05617	90807408-CCP05617	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02930	90807408-PCP05622	90807408-CCP05622	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02930	90807408-PCP05623	90807408-CCP05623	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02931	90807408-PCP04305	90807408-CCP04305	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02931	90807408-PCP04306	90807408-CCP04306	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02931	90807408-PCP04307	90807408-CCP04307	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02931	90807408-PCP04309	90807408-CCP04309	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02931	90807408-PCP05629	90807408-CCP05629	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02932	90807408-PCP04310	90807408-CCP04310	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02932	90807408-PCP04311	90807408-CCP04311	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02932	90807408-PCP04312	90807408-CCP04312	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02932	90807408-PCP04313	90807408-CCP04313	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02932	90807408-PCP05491	90807408-CCP05491	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02932	90807408-PCP05492	90807408-CCP05492	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02932	90807408-PCP05493	90807408-CCP05493	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02932	90807408-PCP05494	90807408-CCP05494	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02932	90807408-PCP05495	90807408-CCP05495	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02932	90807408-PCP05496	90807408-CCP05496	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02933	90807408-PCP04314	90807408-CCP04314	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02933	90807408-PCP04315	90807408-CCP04315	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02933	90807408-PCP04316	90807408-CCP04316	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02933	90807408-PCP04317	90807408-CCP04317	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02933	90807408-PCP04318	90807408-CCP04318	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02933	90807408-PCP04319	90807408-CCP04319	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02933	90807408-PCP04320	90807408-CCP04320	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02934	90807408-PCP04321	90807408-CCP04321	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02934	90807408-PCP04322	90807408-CCP04322	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02934	90807408-PCP04323	90807408-CCP04323	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02934	90807408-PCP04324	90807408-CCP04324	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP04325	90807408-CCP04325	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP04326	90807408-CCP04326	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP04327	90807408-CCP04327	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP04328	90807408-CCP04328	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP05753	90807408-CCP05753	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP05754	90807408-CCP05754	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP05755	90807408-CCP05755	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP05756	90807408-CCP05756	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP05757	90807408-CCP05757	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP05758	90807408-CCP05758	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP05759	90807408-CCP05759	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02935	90807408-PCP05760	90807408-CCP05760	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02936	90807408-PCP04329	90807408-CCP04329	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02936	90807408-PCP04330	90807408-CCP04330	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02936	90807408-PCP05761	90807408-CCP05761	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02936	90807408-PCP05762	90807408-CCP05762	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02936	90807408-PCP05763	90807408-CCP05763	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02937	90807408-PCP04331	90807408-CCP04331	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02937	90807408-PCP04332	90807408-CCP04332	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02937	90807408-PCP05742	90807408-CCP05742	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02938	90807408-PCP04333	90807408-CCP04333	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02938	90807408-PCP04334	90807408-CCP04334	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02938	90807408-PCP04335	90807408-CCP04335	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02938	90807408-PCP04336	90807408-CCP04336	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02938	90807408-PCP05480	90807408-CCP05480	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02938	90807408-PCP05481	90807408-CCP05481	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02938	90807408-PCP05482	90807408-CCP05482	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02938	90807408-PCP05483	90807408-CCP05483	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02938	90807408-PCP05484	90807408-CCP05484	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02939	90807408-PCP04337	90807408-CCP04337	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02939	90807408-PCP04338	90807408-CCP04338	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02939	90807408-PCP04339	90807408-CCP04339	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02940	90807408-PCP04340	90807408-CCP04340	1	CCS1	2	DC			180kw	180.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02940	90807408-PCP04341	90807408-CCP04341	2	CCCS2	2	DC			180kw	180.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02941	90807408-PCP04342	90807408-CCP04342	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02941	90807408-PCP04343	90807408-CCP04343	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02941	90807408-PCP04344	90807408-CCP04344	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02941	90807408-PCP04345	90807408-CCP04345	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02941	90807408-PCP05751	90807408-CCP05751	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02941	90807408-PCP05752	90807408-CCP05752	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02942	90807408-PCP04346	90807408-CCP04346	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02942	90807408-PCP04347	90807408-CCP04347	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02943	90807408-PCP04348	90807408-CCP04348	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02943	90807408-PCP04349	90807408-CCP04349	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02943	90807408-PCP04350	90807408-CCP04350	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02943	90807408-PCP04351	90807408-CCP04351	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02943	90807408-PCP05767	90807408-CCP05767	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02943	90807408-PCP05768	90807408-CCP05768	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02943	90807408-PCP05769	90807408-CCP05769	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP04352	90807408-CCP04352	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP04353	90807408-CCP04353	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP04354	90807408-CCP04354	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP04355	90807408-CCP04355	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP04356	90807408-CCP04356	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP04357	90807408-CCP04357	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP04358	90807408-CCP04358	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP04359	90807408-CCP04359	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP05774	90807408-CCP05774	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP05777	90807408-CCP05777	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP05778	90807408-CCP05778	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02944	90807408-PCP05779	90807408-CCP05779	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP04360	90807408-CCP04360	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP04361	90807408-CCP04361	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP05781	90807408-CCP05781	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP05782	90807408-CCP05782	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP05783	90807408-CCP05783	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP05784	90807408-CCP05784	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP05785	90807408-CCP05785	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP05786	90807408-CCP05786	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP05787	90807408-CCP05787	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP05788	90807408-CCP05788	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP05789	90807408-CCP05789	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP05790	90807408-CCP05790	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02945	90807408-PCP05791	90807408-CCP05791	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02946	90807408-PCP04362	90807408-CCP04362	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02946	90807408-PCP04363	90807408-CCP04363	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02946	90807408-PCP04364	90807408-CCP04364	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02946	90807408-PCP04365	90807408-CCP04365	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02946	90807408-PCP05822	90807408-CCP05822	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02946	90807408-PCP05823	90807408-CCP05823	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP04366	90807408-CCP04366	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP04367	90807408-CCP04367	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP04368	90807408-CCP04368	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP04369	90807408-CCP04369	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP04370	90807408-CCP04370	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP04371	90807408-CCP04371	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP05811	90807408-CCP05811	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP05812	90807408-CCP05812	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP05813	90807408-CCP05813	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP05814	90807408-CCP05814	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP05815	90807408-CCP05815	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP05816	90807408-CCP05816	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP05817	90807408-CCP05817	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP05818	90807408-CCP05818	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02947	90807408-PCP05819	90807408-CCP05819	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02948	90807408-PCP04372	90807408-CCP04372	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02948	90807408-PCP04373	90807408-CCP04373	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02948	90807408-PCP04374	90807408-CCP04374	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02948	90807408-PCP04375	90807408-CCP04375	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02948	90807408-PCP04376	90807408-CCP04376	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02948	90807408-PCP04377	90807408-CCP04377	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02948	90807408-PCP06137	90807408-CCP06137	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02948	90807408-PCP06138	90807408-CCP06138	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02948	90807408-PCP06139	90807408-CCP06139	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02948	90807408-PCP06140	90807408-CCP06140	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02948	90807408-PCP06141	90807408-CCP06141	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP04378	90807408-CCP04378	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP04379	90807408-CCP04379	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP04380	90807408-CCP04380	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP04381	90807408-CCP04381	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP05824	90807408-CCP05824	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP05829	90807408-CCP05829	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP05832	90807408-CCP05832	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP05833	90807408-CCP05833	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP05834	90807408-CCP05834	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP05835	90807408-CCP05835	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP05836	90807408-CCP05836	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP05837	90807408-CCP05837	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02949	90807408-PCP05838	90807408-CCP05838	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02950	90807408-PCP04382	90807408-CCP04382	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02950	90807408-PCP04383	90807408-CCP04383	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02950	90807408-PCP05825	90807408-CCP05825	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02950	90807408-PCP05826	90807408-CCP05826	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02951	90807408-PCP04384	90807408-CCP04384	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02951	90807408-PCP04385	90807408-CCP04385	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02951	90807408-PCP05830	90807408-CCP05830	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02951	90807408-PCP05831	90807408-CCP05831	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	4F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02952	90807408-PCP04386	90807408-CCP04386	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02952	90807408-PCP04387	90807408-CCP04387	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02952	90807408-PCP05860	90807408-CCP05860	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02952	90807408-PCP05861	90807408-CCP05861	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02952	90807408-PCP05862	90807408-CCP05862	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02952	90807408-PCP05863	90807408-CCP05863	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02952	90807408-PCP05864	90807408-CCP05864	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02953	90807408-PCP04388	90807408-CCP04388	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02953	90807408-PCP04389	90807408-CCP04389	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02953	90807408-PCP04390	90807408-CCP04390	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02953	90807408-PCP04391	90807408-CCP04391	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02953	90807408-PCP05842	90807408-CCP05842	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02953	90807408-PCP05843	90807408-CCP05843	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02953	90807408-PCP05844	90807408-CCP05844	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02953	90807408-PCP05845	90807408-CCP05845	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02953	90807408-PCP05846	90807408-CCP05846	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02953	90807408-PCP05847	90807408-CCP05847	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02954	90807408-PCP04392	90807408-CCP04392	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F露天		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02954	90807408-PCP04393	90807408-CCP04393	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F露天		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02955	90807408-PCP04394	90807408-CCP04394	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02955	90807408-PCP04395	90807408-CCP04395	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02955	90807408-PCP04396	90807408-CCP04396	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02955	90807408-PCP05848	90807408-CCP05848	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02955	90807408-PCP05849	90807408-CCP05849	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02956	90807408-PCP04397	90807408-CCP04397	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02956	90807408-PCP04398	90807408-CCP04398	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02956	90807408-PCP05793	90807408-CCP05793	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02956	90807408-PCP05794	90807408-CCP05794	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02957	90807408-PCP04399	90807408-CCP04399	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02957	90807408-PCP04400	90807408-CCP04400	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02957	90807408-PCP04401	90807408-CCP04401	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02957	90807408-PCP04402	90807408-CCP04402	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02957	90807408-PCP05850	90807408-CCP05850	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02957	90807408-PCP05851	90807408-CCP05851	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02957	90807408-PCP05852	90807408-CCP05852	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02957	90807408-PCP05853	90807408-CCP05853	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	2F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02958	90807408-PCP04403	90807408-CCP04403	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02958	90807408-PCP04404	90807408-CCP04404	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02958	90807408-PCP05640	90807408-CCP05640	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02958	90807408-PCP05641	90807408-CCP05641	2	CCCS2	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02958	90807408-PCP05642	90807408-CCP05642	1	CCS1	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02958	90807408-PCP05643	90807408-CCP05643	2	CCCS2	2	DC			160kw	160.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02959	90807408-PCP04405	90807408-CCP04405	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02959	90807408-PCP04406	90807408-CCP04406	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02959	90807408-PCP05854	90807408-CCP05854	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02959	90807408-PCP05855	90807408-CCP05855	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02959	90807408-PCP05856	90807408-CCP05856	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02959	90807408-PCP05857	90807408-CCP05857	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02959	90807408-PCP05858	90807408-CCP05858	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02959	90807408-PCP05859	90807408-CCP05859	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02960	90807408-PCP04425	90807408-CCP04425	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02960	90807408-PCP04426	90807408-CCP04426	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02961	90807408-PCP04407	90807408-CCP04407	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02961	90807408-PCP04408	90807408-CCP04408	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02961	90807408-PCP04409	90807408-CCP04409	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02961	90807408-PCP04410	90807408-CCP04410	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02961	90807408-PCP05807	90807408-CCP05807	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02961	90807408-PCP05808	90807408-CCP05808	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02961	90807408-PCP05809	90807408-CCP05809	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02961	90807408-PCP05810	90807408-CCP05810	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02962	90807408-PCP04411	90807408-CCP04411	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02962	90807408-PCP04412	90807408-CCP04412	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02962	90807408-PCP04413	90807408-CCP04413	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02962	90807408-PCP04414	90807408-CCP04414	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02962	90807408-PCP04415	90807408-CCP04415	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02962	90807408-PCP04416	90807408-CCP04416	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02965	90807408-PCP04423	90807408-CCP04423	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02965	90807408-PCP04424	90807408-CCP04424	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02965	90807408-PCP04427	90807408-CCP04427	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02965	90807408-PCP04428	90807408-CCP04428	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02965	90807408-PCP04429	90807408-CCP04429	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02966	90807408-PCP04430	90807408-CCP04430	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02966	90807408-PCP04431	90807408-CCP04431	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02966	90807408-PCP04432	90807408-CCP04432	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02966	90807408-PCP04433	90807408-CCP04433	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02966	90807408-PCP04434	90807408-CCP04434	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02966	90807408-PCP04435	90807408-CCP04435	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02967	90807408-PCP04436	90807408-CCP04436	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02967	90807408-PCP04437	90807408-CCP04437	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02967	90807408-PCP04438	90807408-CCP04438	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02967	90807408-PCP04439	90807408-CCP04439	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02967	90807408-PCP05801	90807408-CCP05801	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02967	90807408-PCP05802	90807408-CCP05802	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02967	90807408-PCP05803	90807408-CCP05803	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02967	90807408-PCP05805	90807408-CCP05805	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02967	90807408-PCP05806	90807408-CCP05806	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02968	90807408-PCP04440	90807408-CCP04440	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F平面		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD02969	90807408-PCP04441	90807408-CCP04441	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05077	90807408-CCP05077	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05078	90807408-CCP05078	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05079	90807408-CCP05079	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05080	90807408-CCP05080	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05081	90807408-CCP05081	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05082	90807408-CCP05082	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05083	90807408-CCP05083	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05084	90807408-CCP05084	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05085	90807408-CCP05085	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05086	90807408-CCP05086	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	4B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05087	90807408-CCP05087	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05088	90807408-CCP05088	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05089	90807408-CCP05089	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05090	90807408-CCP05090	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	5B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05091	90807408-CCP05091	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	5B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05092	90807408-CCP05092	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	5B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05093	90807408-CCP05093	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	5B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05094	90807408-CCP05094	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	5B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05095	90807408-CCP05095	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	5B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03173	90807408-PCP05096	90807408-CCP05096	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	5B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03192	90807408-PCP05134	90807408-CCP05134	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03192	90807408-PCP05135	90807408-CCP05135	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03203	90807408-PCP05187	90807408-CCP05187	1	CCS1	2	DC			180kw	180.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03203	90807408-PCP05188	90807408-CCP05188	2	CCCS2	2	DC			180kw	180.0	ultra_fast_dc	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03220	90807408-PCP05284	90807408-CCP05284	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03220	90807408-PCP05285	90807408-CCP05285	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03230	90807408-PCP05332	90807408-CCP05332	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03230	90807408-PCP05333	90807408-CCP05333	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03230	90807408-PCP05334	90807408-CCP05334	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03230	90807408-PCP05335	90807408-CCP05335	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03230	90807408-PCP05336	90807408-CCP05336	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03230	90807408-PCP05337	90807408-CCP05337	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03230	90807408-PCP05338	90807408-CCP05338	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03230	90807408-PCP05339	90807408-CCP05339	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03253	90807408-PCP05404	90807408-CCP05404	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03253	90807408-PCP05405	90807408-CCP05405	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03253	90807408-PCP05406	90807408-CCP05406	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03253	90807408-PCP05407	90807408-CCP05407	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03253	90807408-PCP05408	90807408-CCP05408	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03253	90807408-PCP05409	90807408-CCP05409	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03263	90807408-PCP05466	90807408-CCP05466	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03263	90807408-PCP05467	90807408-CCP05467	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03263	90807408-PCP05468	90807408-CCP05468	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03263	90807408-PCP05469	90807408-CCP05469	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03263	90807408-PCP05470	90807408-CCP05470	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03263	90807408-PCP05471	90807408-CCP05471	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03263	90807408-PCP05472	90807408-CCP05472	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03463	90807408-PCP06189	90807408-CCP06189	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03463	90807408-PCP06190	90807408-CCP06190	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03467	90807408-PCP06206	90807408-CCP06206	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03467	90807408-PCP06207	90807408-CCP06207	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03467	90807408-PCP06208	90807408-CCP06208	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03467	90807408-PCP06209	90807408-CCP06209	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03467	90807408-PCP06210	90807408-CCP06210	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03467	90807408-PCP06211	90807408-CCP06211	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03484	90807408-PCP06238	90807408-CCP06238	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03484	90807408-PCP06239	90807408-CCP06239	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	B2		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03505	90807408-PCP06309	90807408-CCP06309	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03541	90807408-PCP06394	90807408-CCP06394	1	CCS1	2	DC			30kw	30.0	medium_dc	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03541	90807408-PCP06395	90807408-CCP06395	2	CCCS2	2	DC			30kw	30.0	medium_dc	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03541	90807408-PCP06396	90807408-CCP06396	1	CCS1	2	DC			30kw	30.0	medium_dc	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03541	90807408-PCP06397	90807408-CCP06397	2	CCCS2	2	DC			30kw	30.0	medium_dc	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03541	90807408-PCP06398	90807408-CCP06398	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03541	90807408-PCP06399	90807408-CCP06399	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03541	90807408-PCP06400	90807408-CCP06400	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03541	90807408-PCP06401	90807408-CCP06401	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03547	90807408-PCP06425	90807408-CCP06425	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03547	90807408-PCP06426	90807408-CCP06426	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03547	90807408-PCP06427	90807408-CCP06427	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03547	90807408-PCP06428	90807408-CCP06428	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03547	90807408-PCP06429	90807408-CCP06429	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03547	90807408-PCP06430	90807408-CCP06430	5	J1772_Type1	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03547	90807408-PCP06431	90807408-CCP06431	6	Mennekes_Type2	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03547	90807408-PCP06432	90807408-CCP06432	6	Mennekes_Type2	1	AC	220V	32A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90807408-SCSD03554	90807408-PCP06460	90807408-CCP06460	6	Mennekes_Type2	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	12681939-SPSS_YA41001	12681939-PB06EL2307043	12681939-CB06EL2307043_01	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	12681939-Shfc_17	12681939-PB06EL2401070	12681939-CB06EL2401070_1	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	12681939-Shfc_17	12681939-PB06EL2401071	12681939-CB06EL2401071_1	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	12681939-Shfc_17	12681939-PB06EL2401072	12681939-CB06EL2401072_1	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	12681939-SPSS_YA41001	12681939-PC01AS2308002	12681939-CC01AS2308002_01	1	CCS1	2	DC	220V	80A	30kw	30.0	medium_dc	1		2026-05-02 14:10:16+00
新北市	\N	12681939-SPSS_YA41001	12681939-PC01AS2308002	12681939-CC01AS2308002_02	2	CCCS2	2	DC	220V	80A	30kw	30.0	medium_dc	1		2026-05-02 14:10:16+00
新北市	\N	12681939-Shfc_17	12681939-PC01AS23B005	12681939-CC01AS23B005_1	1	CCS1	2	DC	220V	80A	30kw	30.0	medium_dc	1F		2026-05-02 14:10:16+00
新北市	\N	12681939-Shfc_17	12681939-PC01AS23B005	12681939-CC01AS23B005_2	2	CCCS2	2	DC	220V	80A	30kw	30.0	medium_dc	1F		2026-05-02 14:10:16+00
新北市	\N	24394433-Ssungreen_20	24394433-PC2530A221A1	24394433-CC2530A221A1_1	5	J1772_Type1	1	AC	220V	50A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	24394433-Ssungreen_20	24394433-PC2530A223A1	24394433-CC2530A223A1_1	5	J1772_Type1	1	AC	220V	50A	11kw	11.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	60219358-S168_8	60219358-PB11CB2501009	60219358-CB11CB2501009_1	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	60219358-S168_8	60219358-PB11DE2503004	60219358-CB11DE2503004_1	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	80390037-S168_7	80390037-PB11CB2501004	80390037-CB11CB2501004_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	80390037-S168_7	80390037-PB11CE2409049	80390037-CB11CE2409049_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	86711789-Sgowin_1	86711789-P32120100091	86711789-C32120100091_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	86711789-Sgowin_1	86711789-P32120100094	86711789-C32120100094_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	87545768-S168_26	87545768-PB11CE2507021	87545768-CB11CE2507021_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	87545768-S168_11	87545768-PB11CE2507022	87545768-CB11CE2507022_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	87545768-S168_11	87545768-PB11CE2507023	87545768-CB11CE2507023_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	87545768-S168_11	87545768-PB11CE2507025	87545768-CB11CE2507025_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	87545768-S168_11	87545768-PB11CE2507026	87545768-CB11CE2507026_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	87545768-S168_11	87545768-PB11CE2507027	87545768-CB11CE2507027_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	87545768-S168_11	87545768-PB11CE2507029	87545768-CB11CE2507029_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	87545768-S168_11	87545768-PB11CE2507030	87545768-CB11CE2507030_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	87545768-S168_11	87545768-PB11CE2507031	87545768-CB11CE2507031_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	87545789-S168_13	87545789-PB11CE2507024	87545789-CB11CE2507024_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	87545789-S168_13	87545789-PB11CE2507028	87545789-CB11CE2507028_1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1F		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5991	90148497-C8181	6	Mennekes_Type2	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5992	90148497-C8182	6	Mennekes_Type2	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5993	90148497-C8183	6	Mennekes_Type2	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5994	90148497-C8184	6	Mennekes_Type2	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5995	90148497-C8185	6	Mennekes_Type2	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5996	90148497-C8186	6	Mennekes_Type2	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5997	90148497-C8187	6	Mennekes_Type2	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1046	90148497-P5430	90148497-C7479	5	J1772_Type1	1	AC	242V	32A	7.0kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90148497-S1171	90148497-P5729	90148497-C7799	5	J1772_Type1	1	AC	242V	32A	7.0kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5984	90148497-C8174	5	J1772_Type1	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5985	90148497-C8175	5	J1772_Type1	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5986	90148497-C8176	5	J1772_Type1	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5987	90148497-C8177	5	J1772_Type1	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5988	90148497-C8178	5	J1772_Type1	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5989	90148497-C8179	5	J1772_Type1	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P5990	90148497-C8180	5	J1772_Type1	1	AC	242V	32A	7.0kW	7.0	slow_ac	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P6009	90148497-C8204	1	CCS1	2	DC	800V	60A	30.0kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P6010	90148497-C8206	1	CCS1	2	DC	800V	60A	30.0kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1240	90148497-P6071	90148497-C8298	1	CCS1	2	DC	800V	60A	30.0kW	30.0	medium_dc	1		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P6009	90148497-C8205	2	CCCS2	2	DC	800V	60A	30.0kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1215	90148497-P6010	90148497-C8207	2	CCCS2	2	DC	800V	60A	30.0kW	30.0	medium_dc	B4		2026-05-02 14:10:16+00
新北市	\N	90148497-S1240	90148497-P6071	90148497-C8299	2	CCCS2	2	DC	800V	60A	30.0kW	30.0	medium_dc	1		2026-05-02 14:10:16+00
新北市	\N	90482725-S0080	90482725-P00004	90482725-C00004	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	90482725-S0080	90482725-P00003	90482725-C00003	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1		2026-05-02 14:10:16+00
新北市	\N	50965513-SPDP3104001	50965513-PA0323TYTW00063	50965513-CA0323TYTW000631	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	限使用車車電充APP	2026-05-02 14:10:16+00
新北市	\N	50965513-SPDP3104001	50965513-PA0323TYTW00077	50965513-CA0323TYTW000771	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	限使用車車電充APP	2026-05-02 14:10:16+00
新北市	\N	90444103-S53	90444103-P149	90444103-C98	1	CCS1	2	DC	220V	60A	120kW	120.0	fast_dc	1		2026-05-02 14:10:16+00
新北市	\N	90444103-S53	90444103-P149	90444103-C99	1	CCS1	2	DC	220V	60A	120kW	120.0	fast_dc	1		2026-05-02 14:10:16+00
新北市	\N	90444103-S53	90444103-P150	90444103-C100	2	CCCS2	2	DC	220V	60A	120kW	120.0	fast_dc	1		2026-05-02 14:10:16+00
新北市	\N	90444103-S53	90444103-P150	90444103-C101	2	CCCS2	2	DC	220V	60A	120kW	120.0	fast_dc	1		2026-05-02 14:10:16+00
新北市	\N	90444103-S53	90444103-P151	90444103-C102	5	J1772_Type1	1	AC	220V	60A	13.2kW	13.2	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	46037888-S59	46037888-P161	46037888-C116	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	46037888-S60	46037888-P160	46037888-C115	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	54991324-S62	54991324-P168	54991324-C126	1	CCS1	2	DC	220V	60A	90kW	90.0	fast_dc	1		2026-05-02 14:10:16+00
新北市	\N	54991324-S62	54991324-P168	54991324-C127	2	CCCS2	2	DC	220V	60A	90kW	90.0	fast_dc	1		2026-05-02 14:10:16+00
新北市	\N	46037888-S64	46037888-P179	46037888-C142	5	J1772_Type1	1	AC	220V	50A	11kW	11.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	46037888-S65	46037888-P180	46037888-C143	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	54991324-S74	54991324-P200	54991324-C165	5	J1772_Type1	1	AC	220V	60A	13.2kW	13.2	slow_ac			2026-05-02 14:10:16+00
新北市	\N	54991324-S74	54991324-P201	54991324-C166	5	J1772_Type1	1	AC	220V	60A	13.2kW	13.2	slow_ac			2026-05-02 14:10:16+00
新北市	\N	54991324-S74	54991324-P202	54991324-C167	5	J1772_Type1	1	AC	220V	60A	13.2kW	13.2	slow_ac			2026-05-02 14:10:16+00
新北市	\N	54991324-S74	54991324-P203	54991324-C168	5	J1772_Type1	1	AC	220V	60A	13.2kW	13.2	slow_ac			2026-05-02 14:10:16+00
新北市	\N	46037888-S122	46037888-P466	46037888-C449	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	53328840-S132	53328840-P485	53328840-C468	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	53328840-S132	53328840-P486	53328840-C469	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	34176631-S179	34176631-P591	34176631-C583	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	地下1		2026-05-02 14:10:16+00
新北市	\N	24788035-S185	24788035-P605	24788035-C597	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	24788035-S185	24788035-P606	24788035-C598	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	24788035-S185	24788035-P607	24788035-C599	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	24788035-S185	24788035-P608	24788035-C600	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	34220432-S238	34220432-P787	34220432-C787	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	地下1		2026-05-02 14:10:16+00
新北市	\N	34220432-S238	34220432-P788	34220432-C788	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	地下1		2026-05-02 14:10:16+00
新北市	\N	89132567-S0067	89132567-P0150	89132567-C0179	5	J1772_Type1	1	AC	220V	32A	7kw	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0069	89132567-P0152	89132567-C0181	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0069	89132567-P0155	89132567-C0182	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0072	89132567-P0169	89132567-C0196	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0080	89132567-P0195	89132567-C0222	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0080	89132567-P0196	89132567-C0223	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0080	89132567-P0197	89132567-C0224	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0080	89132567-P0198	89132567-C0225	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0080	89132567-P0199	89132567-C0226	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0080	89132567-P0200	89132567-C0227	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0080	89132567-P0201	89132567-C0228	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0080	89132567-P0202	89132567-C0229	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0081	89132567-P0203	89132567-C0230	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0081	89132567-P0204	89132567-C0231	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0081	89132567-P0205	89132567-C0232	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0081	89132567-P0206	89132567-C0233	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0081	89132567-P0207	89132567-C0234	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0084	89132567-P0211	89132567-C0238	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0105	89132567-P0274	89132567-C0309	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0105	89132567-P0275	89132567-C0310	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0109	89132567-P0291	89132567-C0326	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0109	89132567-P0292	89132567-C0327	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0109	89132567-P0293	89132567-C0328	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0109	89132567-P0294	89132567-C0329	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0109	89132567-P0295	89132567-C0330	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0109	89132567-P0296	89132567-C0331	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0110	89132567-P0297	89132567-C0332	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0113	89132567-P0305	89132567-C0340	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0114	89132567-P0306	89132567-C0341	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0114	89132567-P0307	89132567-C0342	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0115	89132567-P0308	89132567-C0343	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0115	89132567-P0309	89132567-C0344	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0116	89132567-P0310	89132567-C0345	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0116	89132567-P0311	89132567-C0346	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0121	89132567-P0317	89132567-C0354	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0122	89132567-P0318	89132567-C0355	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0128	89132567-P0327	89132567-C0364	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0128	89132567-P0328	89132567-C0365	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0128	89132567-P0329	89132567-C0366	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0128	89132567-P0330	89132567-C0367	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0128	89132567-P0331	89132567-C0368	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	B1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0134	89132567-P0370	89132567-C0407	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0134	89132567-P0371	89132567-C0408	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0134	89132567-P0372	89132567-C0409	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0134	89132567-P0373	89132567-C0410	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0134	89132567-P0374	89132567-C0411	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0135	89132567-P0375	89132567-C0412	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0135	89132567-P0376	89132567-C0413	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0148	89132567-P0407	89132567-C0448	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0149	89132567-P0408	89132567-C0449	2	CCCS2	2	DC			120kW	120.0	fast_dc	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	89132567-S0149	89132567-P0408	89132567-C0450	1	CCS1	2	DC			120kW	120.0	fast_dc	1	依現場告示	2026-05-02 14:10:16+00
新北市	\N	83039115-S0003	83039115-P0005	83039115-C0007	2	CCCS2	2	DC			180kw	180.0	ultra_fast_dc	B1	本充電站限會員使用	2026-05-02 14:10:16+00
新北市	\N	83039115-S0003	83039115-P0005	83039115-C0008	1	CCS1	2	DC			180kw	180.0	ultra_fast_dc	B1	本充電站限會員使用	2026-05-02 14:10:16+00
新北市	\N	83039115-S0002	83039115-P0003	83039115-C0004	2	CCCS2	2	DC			180kw	180.0	ultra_fast_dc	1F	本充電站限會員使用	2026-05-02 14:10:16+00
新北市	\N	83039115-S0002	83039115-P0003	83039115-C0003	1	CCS1	2	DC			180kw	180.0	ultra_fast_dc	1F	本充電站限會員使用	2026-05-02 14:10:16+00
新北市	\N	53703514-S2209	53703514-P18568	53703514-C185681	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	F1	本充電站限會員使用	2026-05-02 14:10:16+00
新北市	\N	53703514-S2209	53703514-P18569	53703514-C185691	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	F1	本充電站限會員使用	2026-05-02 14:10:16+00
新北市	\N	53703514-S2375	53703514-P500121	53703514-C5001211	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	F1	本充電站限會員使用	2026-05-02 14:10:16+00
新北市	\N	53703514-S1101	53703514-P500150	53703514-C5001501	5	J1772_Type1	1	AC	110V	32A	7kW	7.0	slow_ac	F1	本充電站限會員使用	2026-05-02 14:10:16+00
新北市	\N	42861108-S32202	42861108-P322021	42861108-C322021-1	4	Tesla_TPC	2	DC			250kW	250.0	ultra_fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S32202	42861108-P322022	42861108-C322022-1	2	CCCS2	2	DC			250kW	250.0	ultra_fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S32202	42861108-P322023	42861108-C322023-1	2	CCCS2	2	DC			250kW	250.0	ultra_fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	42861108-S32202	42861108-P322024	42861108-C322024-1	2	CCCS2	2	DC			250kW	250.0	ultra_fast_dc	B2		2026-05-02 14:10:16+00
新北市	\N	90505425-S58665	90505425-P586651	90505425-C586651-1	1	CCS1	2	DC			120kW	120.0	fast_dc	B3		2026-05-02 14:10:16+00
新北市	\N	90505425-S58665	90505425-P586652	90505425-C586652-1	2	CCCS2	2	DC			120kW	120.0	fast_dc	B3		2026-05-02 14:10:16+00
新北市	\N	90505425-S58665	90505425-P586653	90505425-C586653-1	1	CCS1	2	DC			50kW	50.0	fast_dc	B3		2026-05-02 14:10:16+00
新北市	\N	90505425-S58665	90505425-P586654	90505425-C586654-1	2	CCCS2	2	DC			50kW	50.0	fast_dc	B3		2026-05-02 14:10:16+00
新北市	\N	90505425-S58665	90505425-P586655	90505425-C586655-1	1	CCS1	2	DC			50kW	50.0	fast_dc	B3		2026-05-02 14:10:16+00
新北市	\N	90505425-S58665	90505425-P586656	90505425-C586656-1	2	CCCS2	2	DC			50kW	50.0	fast_dc	B3		2026-05-02 14:10:16+00
新北市	\N	90505425-S58665	90505425-P586657	90505425-C586657-1	5	J1772_Type1	1	AC	220V	48A	11kW	11.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	90505425-S58665	90505425-P586658	90505425-C586658-1	5	J1772_Type1	1	AC	220V	48A	11kW	11.0	slow_ac	B3		2026-05-02 14:10:16+00
新北市	\N	85017137-SNWT0001	85017137-P0057	85017137-C0057-1	5	J1772_Type1	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
新北市	\N	85017137-SNWT0001	85017137-P0058	85017137-C0058-1	6	Mennekes_Type2	1	AC	220V	32A	7kW	7.0	slow_ac	1		2026-05-02 14:10:16+00
\.


--
-- Data for Name: env_ev_charging_district_summary; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.env_ev_charging_district_summary (city_scope, city, district, station_count, charging_point_count, connector_count, data_time) FROM stdin;
taipei	臺北市	中山區	51	228	144	2026-05-01 01:00:08+00
taipei	臺北市	中正區	23	92	74	2026-05-01 01:00:08+00
taipei	臺北市	信義區	39	295	230	2026-05-01 01:00:08+00
taipei	臺北市	內湖區	31	129	128	2026-05-01 01:00:08+00
taipei	臺北市	北投區	37	140	124	2026-05-01 01:00:08+00
taipei	臺北市	南港區	23	145	143	2026-05-01 01:00:08+00
taipei	臺北市	士林區	36	136	122	2026-05-01 01:00:08+00
taipei	臺北市	大同區	24	93	83	2026-05-01 01:00:08+00
taipei	臺北市	大安區	49	239	231	2026-05-01 01:00:08+00
taipei	臺北市	文山區	30	110	88	2026-05-01 01:00:08+00
taipei	臺北市	未分類	4	6	6	2026-05-01 01:00:08+00
taipei	臺北市	松山區	32	171	141	2026-05-01 01:00:08+00
taipei	臺北市	萬華區	24	152	111	2026-05-01 01:00:08+00
twin_city	新北市	三峽區	8	42	44	2026-05-02 14:10:16+00
twin_city	新北市	三芝區	3	13	13	2026-05-02 14:10:16+00
twin_city	新北市	三重區	28	123	128	2026-05-02 14:10:16+00
twin_city	新北市	中和區	23	140	148	2026-05-02 14:10:16+00
twin_city	新北市	五股區	2	7	7	2026-05-02 14:10:16+00
twin_city	新北市	八里區	5	26	26	2026-05-02 14:10:16+00
twin_city	新北市	土城區	20	81	85	2026-05-02 14:10:16+00
twin_city	新北市	坪林區	1	4	4	2026-05-02 14:10:16+00
twin_city	新北市	新店區	20	79	83	2026-05-02 14:10:16+00
twin_city	新北市	新莊區	26	139	142	2026-05-02 14:10:16+00
twin_city	新北市	板橋區	36	179	187	2026-05-02 14:10:16+00
twin_city	新北市	林口區	19	108	110	2026-05-02 14:10:16+00
twin_city	新北市	樹林區	5	15	15	2026-05-02 14:10:16+00
twin_city	新北市	永和區	9	77	77	2026-05-02 14:10:16+00
twin_city	新北市	汐止區	10	62	65	2026-05-02 14:10:16+00
twin_city	新北市	泰山區	3	21	21	2026-05-02 14:10:16+00
twin_city	新北市	淡水區	12	53	53	2026-05-02 14:10:16+00
twin_city	新北市	深坑區	1	3	3	2026-05-02 14:10:16+00
twin_city	新北市	烏來區	2	11	11	2026-05-02 14:10:16+00
twin_city	新北市	瑞芳區	2	8	8	2026-05-02 14:10:16+00
twin_city	新北市	石門區	1	3	3	2026-05-02 14:10:16+00
twin_city	新北市	蘆洲區	14	47	47	2026-05-02 14:10:16+00
twin_city	新北市	貢寮區	1	2	2	2026-05-02 14:10:16+00
twin_city	新北市	金山區	3	10	10	2026-05-02 14:10:16+00
twin_city	新北市	鶯歌區	3	7	7	2026-05-02 14:10:16+00
twin_city	臺北市	中山區	51	228	144	2026-05-01 01:00:08+00
twin_city	臺北市	中正區	23	92	74	2026-05-01 01:00:08+00
twin_city	臺北市	信義區	39	295	230	2026-05-01 01:00:08+00
twin_city	臺北市	內湖區	31	129	128	2026-05-01 01:00:08+00
twin_city	臺北市	北投區	37	140	124	2026-05-01 01:00:08+00
twin_city	臺北市	南港區	23	145	143	2026-05-01 01:00:08+00
twin_city	臺北市	士林區	36	136	122	2026-05-01 01:00:08+00
twin_city	臺北市	大同區	24	93	83	2026-05-01 01:00:08+00
twin_city	臺北市	大安區	49	239	231	2026-05-01 01:00:08+00
twin_city	臺北市	文山區	30	110	88	2026-05-01 01:00:08+00
twin_city	臺北市	未分類	4	6	6	2026-05-01 01:00:08+00
twin_city	臺北市	松山區	32	171	141	2026-05-01 01:00:08+00
twin_city	臺北市	萬華區	24	152	111	2026-05-01 01:00:08+00
\.


--
-- Data for Name: env_ev_charging_points; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.env_ev_charging_points (city, district, station_id, charging_point_id, operator_id, floor, charging_rate, usage_restriction, connector_type_summary, data_time) FROM stdin;
臺北市	中山區	TPE1733	94175832-P6f4780b4d88f	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE1733	94175832-P807993707462	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE1733	94175832-Pa68f3c7a198f	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0058	88237515-CB022301_5	88237515	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0058	88237515-PB022301_1	88237515	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0058	88237515-PB022301_2	88237515	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0058	88237515-PB022301_3	88237515	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0058	88237515-PB022301_4	88237515	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0117	33029464-PTP6780001	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0117	33029464-PTP6780002	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0706	90807408-PCP02901	90807408	B1	AC/計度/一般/ 7.000元每度,AC/計度/尖峰/ 7.000元每度,AC/計度/離峰/ 7.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0706	90807408-PCP02902	90807408	B1	AC/計度/一般/ 7.000元每度,AC/計度/尖峰/ 7.000元每度,AC/計度/離峰/ 7.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1773	08612854-P0001	08612854	B1	● 計度 / 固定 / 6 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1773	08612854-P0002	08612854	B1	● 計度 / 固定 / 6 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1773	08612854-P0003	08612854	B1	● 計度 / 固定 / 6 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03229	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03230	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03231	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03232	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03233	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03234	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03235	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03236	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03237	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03238	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03239	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03240	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03241	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP03242	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0062	90807408-PCP05101	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U01	42861108-P318611A	42861108	B2	計度/浮動/8元每度		{"Tesla_TPC": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U01	42861108-P318611B	42861108	B2	計度/浮動/8元每度		{"CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U01	42861108-P318611C	42861108	B2	計度/浮動/8元每度		{"CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U01	42861108-P318612A	42861108	B2	計度/浮動/8元每度		{"Tesla_TPC": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U01	42861108-P318612B	42861108	B2	計度/浮動/8元每度		{"CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U01	42861108-P318612C	42861108	B2	計度/浮動/8元每度		{"CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U02	90807408-PCP04139	90807408	1	AC/計度/一般/ 7.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U02	90807408-PCP04140	90807408	1	AC/計度/一般/ 7.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U02	90807408-PCP04141	90807408	1	AC/計度/一般/ 7.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U02	90807408-PCP04142	90807408	1	AC/計度/一般/ 7.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U02	90807408-PCP04143	90807408	1	AC/計度/一般/ 7.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U02	90807408-PCP04144	90807408	1	AC/計度/一般/ 7.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U02	90807408-PCP04145	90807408	1	AC/計度/一般/ 7.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U03	90807408-PCP03576	90807408	B1	AC/計度/一般/ 7.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U03	90807408-PCP03577	90807408	B1	AC/計度/一般/ 7.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0201U03	90807408-PCP03578	90807408	B1	AC/計度/一般/ 7.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U01	28371994-PTP6620001	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U01	28371994-PTP6620002	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U02	28371994-PTP6520001	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U02	28371994-PTP6520002	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U03	28371994-PTP6530001	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U03	28371994-PTP6530037	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U03	28371994-PTP6530038	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U03	28371994-PTP6530039	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U03	28371994-PTP6530040	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U04	28371994-PTP6540001	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U04	28371994-PTP6540002	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U04	28371994-PTP6540003	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U05	28371994-PTP6550001	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U05	28371994-PTP6550002	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U05	28371994-PTP6550003	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U06	28371994-PTP6560001	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U06	28371994-PTP6560002	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U06	28371994-PTP6560003	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U07	28371994-PTP6570001	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U08	28371994-PTP6580001	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U08	28371994-PTP6580002	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U08	28371994-PTP6580003	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U08	28371994-PTP6580004	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U08	28371994-PTP6580005	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U08	28371994-PTP6580006	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U09	28371994-PTP6590001	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U09	28371994-PTP6590002	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U09	28371994-PTP6590003	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U09	28371994-PTP6590004	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U09	28371994-PTP6590005	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U09	28371994-PTP6590006	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U10	28371994-PTP3930001	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U11	28371994-PTP6600001	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0228U12	28371994-PTP6610002	28371994	1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0169	90807408-PCP03329	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0169	90807408-PCP03330	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0169	90807408-PCP03331	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0169	90807408-PCP03332	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0169	90807408-PCP03333	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0169	90807408-PCP03334	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0537	89132567-P0227	80688966	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0537	89132567-P0228	80688966	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0537	89132567-P0229	80688966	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0537	89132567-P0230	80688966	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0537	89132567-P0231	80688966	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0537	89132567-P0232	80688966	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0537	89132567-P0233	80688966	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0537	89132567-P0234	80688966	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0537	89132567-P0235	80688966	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0537	89132567-P0236	80688966	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0787	90807408-PCP03371	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0787	90807408-PCP03372	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0787	90807408-PCP03373	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0787	90807408-PCP03374	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-P009e5f46d144	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-P0a139d274100	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-P1ac9cfcebe25	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-P58c068b9f4fe	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-P66d33b412303	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-P8abcbc6f4cce	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-P8b3ccbaad9cc	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-P92fd40202d91	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-P9ee68ef0bf50	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-Pa234c47d45b7	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-Pcf275ae398fc	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-Pd6d09cc46ef5	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-Pd788d941b166	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0992	94175832-Pf3f429355d71	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0102	33029464-PTP6770001	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0103	33029464-PTP6810001	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0103	33029464-PTP6810002	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0104	33029464-PTP6800001	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0114	33029464-PTP6750001	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0280	50965513-PA0323TYTW00069	50965513	1	計度/00:00-24:00/每度9元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0316	90807408-PCP05441	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0316	90807408-PCP05442	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0316	90807408-PCP05443	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0316	90807408-PCP05444	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0607	52883637-CIN27-OCPP-ECS--496AD	52883637	1	計分/固定/ 8.5 元每分		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	未分類	TPE0611	90807408-PCP05198	90807408	1	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	未分類	TPE0648	90807408-PCP05009	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	未分類	TPE0892	90807408-PCP05122	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	未分類	TPE0892	90807408-PCP05123	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1160	90807408-PCP03409	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1160	90807408-PCP03410	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0852	90807408-PCP03243	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0852	90807408-PCP03244	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0852	90807408-PCP03245	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0852	90807408-PCP03246	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0852	90807408-PCP03247	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0852	90807408-PCP03248	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1544	88395963-PC009601_1	88395963	B2	目前無收費 		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1544	88395963-PC009601_2	88395963	B2	目前無收費 		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1544	88395963-PC009601_3	88395963	B2	目前無收費 		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1560	42861108-P56744cc2-1	42861108	1F	計時/浮動/0.7元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1560	42861108-P56744cc2-2	42861108	1F	計時/浮動/0.7元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1560	42861108-P56744cc2-3	42861108	1F	計時/浮動/0.7元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1560	42861108-P56744cc2-4	42861108	1F	計時/浮動/0.7元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1674	90807408-PCP06163	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1674	90807408-PCP06164	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0819	90807408-PCP03288	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0819	90807408-PCP03289	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0819	90807408-PCP03290	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0819	90807408-PCP03291	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1792	94175832-P17d18857f7e6	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1792	94175832-P31593f1fe67d	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1792	94175832-Pb204de6253d0	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1792	94175832-Pb42d0770a810	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1792	94175832-Pc3727fb965ab	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1792	94175832-Pedf5df40d73b	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1793	28114216-PJEN212800340W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1793	28114216-PJEN212800342W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1793	28114216-PJEN212800364W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1793	28114216-PJEN212800384W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1793	28114216-PXP01245100004	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0723	90807408-PCP03335	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0723	90807408-PCP03336	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0723	90807408-PCP03337	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0723	90807408-PCP03338	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0723	90807408-PCP03339	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0742	28371994-PTP6010001	28371994	B1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0742	28371994-PTP6010002	28371994	B1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0742	28371994-PTP6010003	28371994	B1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0742	28371994-PTP6010004	28371994	B1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0538	90807408-PCP03063	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0538	90807408-PCP03064	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0538	90807408-PCP03065	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0538	90807408-PCP03066	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0453	28007736-PAPAL014001	28007736	B2	計分/ 0.8元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0667	97179430-P00127	97179430	B3	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0667	97179430-P00128	97179430	B3	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0667	97179430-P00129	97179430	B3	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0667	97179430-P00130	97179430	B3	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0359	73682707-PB012101_1	80304384	B1	每度電費：8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0359	73682707-PB012101_2	80304384	B1	每度電費：8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0359	73682707-PB012101_3	80304384	B1	每度電費：8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0734	89132567-P0217	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0734	89132567-P0218	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0734	89132567-P0219	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0734	89132567-P0220	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0734	89132567-P0221	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0734	89132567-P0222	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0734	89132567-P0223	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0734	89132567-P0224	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0734	89132567-P0225	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0734	89132567-P0226	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0040	94175832-P1b2967474b88	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0040	94175832-Pd8778b6ce2e9	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0040	94175832-Pf60cd1a0e55c	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0237	90807408-PCP03365	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0237	90807408-PCP03366	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0514	90505425-P3867801	90505425	1	計度/尖峰/12.5元每度，計度/離峰/6.5元每度		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0514	90505425-P3867802	90505425	1	計度/尖峰/12.5元每度，計度/離峰/6.5元每度		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0514	90505425-P3867803	90505425	1	計度/尖峰/12.5元每度，計度/離峰/6.5元每度		{"CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0514	90505425-P3867804	90505425	1	計度/尖峰/12.5元每度，計度/離峰/6.5元每度		{"CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0735	90807408-PCP03359	90807408	1	AC/計度/一般/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0735	90807408-PCP03360	90807408	1	AC/計度/一般/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0818	12981268-PJEN243101045W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE1180	42649057-PAWSC770001E2P1C2323A016A0	42649057	1	待確認		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1767	50965513-PA0324TYTW00109	50965513	B2	計度/0:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1767	50965513-PA0324TYTW00110	50965513	B2	計度/0:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1767	50965513-PA0324TYTW00111	50965513	B2	計度/0:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1769	50965513-PA0323TYTW00086	50965513	B1	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1769	50965513-PA0323TYTW00094	50965513	B1	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1769	50965513-PA0323TYTW00095	50965513	B1	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1769	50965513-PA0323TYTW00098	50965513	B1	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1769	50965513-PA0324TYTW00112	50965513	B1	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1769	50965513-PA0324TYTW00113	50965513	B1	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1785	50965513-PA0323TYTW00083	50965513	B2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1785	50965513-PA0323TYTW00084	50965513	B2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1785	50965513-PA0323TYTW00088	50965513	B2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1785	50965513-PA0323TYTW00090	50965513	B2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1785	50965513-PA0323TYTW00100	50965513	B2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1785	50965513-PA0324TYTW00106	50965513	B2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1795	83058885-P510	83058885	1	計度/尖峰/09:00-23:59/5.51 元每度, 計度/尖峰/06:00-11:00/5.42 元每度, 計度/尖峰/14:00-23:59/5.42 元每度, 計度/離峰/23:59-09:00/3.46 元每度, 計度/離峰/23:59-06:00/3.39 元每度, 計度/離峰/11:00-14:00/3.39 元每度, 計度/半尖峰/09:00-23:59/4.14 元每度, 計度/半尖峰/06:00-11:00/4.06 元每度, 計度/半尖峰/14:00-23:59/4.06 元每度, 		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1807	52693448-P0017	52693448	B2	依現場公告		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1807	52693448-P0018	52693448	B2	依現場公告		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1807	52693448-P0019	52693448	B2	依現場公告		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1807	52693448-P0020	52693448	B2	依現場公告		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1807	52693448-P0021	52693448	B2	依現場公告		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE1809	53703514-P500134	53703514	B1	計度/固定/12 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE1809	53703514-P500135	53703514	B1	計度/固定/12 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1820	52883637-CIN27-OCPP-TYC--00296	52883637	1	計度/固定/8.5 元每度		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1861	00655051-PB11CB2506001	00655051	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1861	00655051-PB11CB2506004	00655051	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN384	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN385	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN386	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN387	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN388	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN389	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN390	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN391	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN392	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN393	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN394	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN395	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1864	28652185-PZHEN396	28652185	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1868	83058885-P309	83058885	1	計度/尖峰/09:00-23:59/5.51 元每度, 計度/尖峰/06:00-11:00/5.42 元每度, 計度/尖峰/14:00-23:59/5.42 元每度, 計度/離峰/23:59-09:00/3.46 元每度, 計度/離峰/23:59-06:00/3.39 元每度, 計度/離峰/11:00-14:00/3.39 元每度, 計度/半尖峰/09:00-23:59/4.14 元每度, 計度/半尖峰/06:00-11:00/4.06 元每度, 計度/半尖峰/14:00-23:59/4.06 元每度, 		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1875	28652185-PLZLI0003	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1875	28652185-PLZLI0013	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1875	28652185-PLZLI0014	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1875	28652185-PLZLI0015	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1875	28652185-PLZLI0016	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1876	28652185-PLZLI2011	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1876	28652185-PLZLI2012	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1876	28652185-PLZLI2014	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1876	28652185-PLZLI2015	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1876	28652185-PLZLI2016	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1876	28652185-PLZLI2017	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1876	28652185-PLZLI2018	28652185	B1	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1883	89132567-P0389	89132567	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1884	00641938-PB0446011_1	00641938	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1884	00641938-PB0446011_2	00641938	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1884	00641938-PB0446011_3	00641938	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1884	00641938-PB0446011_4	00641938	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1884	00641938-PB0446011_5	00641938	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1904	28007736-PTNPK006001	28007736	B1	計度/10元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1904	28007736-PTNPK006002	28007736	B1	計度/10元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1905	28007736-PTNPK007001	28007736	B1	計度/10元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1905	28007736-PTNPK007002	28007736	B1	計度/10元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1908	00654927-PB11CB2506010	00654927	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1911	28007736-PTNPK008001	28007736	B1	計度/10元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1911	28007736-PTNPK008002	28007736	B1	計度/10元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE1622	28007736-PAPAL002001	28007736	B3	計分/ 0.9元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE1622	28007736-PAPAL002002	28007736	B3	計分/ 0.9元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0183	12981268-PJEN243100928W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0091	33029464-PTP6650001	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0091	33029464-PTP6650002	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0091	33029464-PTP6650003	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0091	33029464-PTP6650004	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0091	33029464-PTP6650005	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0140	33029464-PTP6660001	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0140	33029464-PTP6660002	33029464	1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0928	42441649-PB0050_10	42441649	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0928	42441649-PB0050_11	42441649	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0928	42441649-PB0050_12	42441649	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0928	42441649-PB0050_14	42441649	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0928	42441649-PB0050_5	42441649	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0928	42441649-PB0050_6	42441649	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0928	42441649-PB0050_7	42441649	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0928	42441649-PB0050_8	42441649	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0928	42441649-PB0050_9	42441649	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0101	03751032-P1C2421A004	03751032	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0101	03751032-P1C2421A010	03751032	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0101	03751032-P1C2421A011	03751032	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0101	03751032-P1C2421A057	03751032	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0101	03751032-P1C2421A058	03751032	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0101	03751032-P1C2421A147	03751032	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0118	90807408-PCP04693	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0444	85051710-P1630	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0444	85051710-P1631	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_10	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_11	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_12	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_13	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_14	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_16	88177523	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_17	88177523	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_2	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_3	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_5	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_6	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_7	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_8	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0709	88177523-PA028301_1_9	88177523	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0935	88177523-PA028301_2_1	88177523	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0935	88177523-PA028301_2_2	88177523	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE1675	80158495-PB11CE2508011	80158495	1	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0536	90807408-PCP03379	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0536	90807408-PCP03380	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0536	90807408-PCP03381	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0536	90807408-PCP03382	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0315	90807408-PCP03367	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0315	90807408-PCP03368	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0170	90807408-PCP03402	90807408	1	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0170	90807408-PCP03403	90807408	1	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0630	90807408-PCP03415	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0630	90807408-PCP03416	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0963	90807408-PCP03404	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE0963	90807408-PCP03405	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE1049	90807408-PCP03413	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE1049	90807408-PCP03414	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0399	90807408-PCP03387	90807408	1	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0399	90807408-PCP03388	90807408	1	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0399	90807408-PCP03389	90807408	1	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0399	90807408-PCP03390	90807408	1	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0399	90807408-PCP03391	90807408	1	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0399	90807408-PCP03392	90807408	1	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0399	90807408-PCP03393	90807408	1	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0399	90807408-PCP03394	90807408	1	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0399	90807408-PCP03395	90807408	1	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0160	90807408-PCP03396	90807408	1	AC/計度/一般/ 0.00元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0160	90807408-PCP03397	90807408	1	AC/計度/一般/ 0.00元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0160	90807408-PCP03398	90807408	1	AC/計度/一般/ 0.00元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0160	90807408-PCP03399	90807408	1	AC/計度/一般/ 0.00元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0160	90807408-PCP03400	90807408	1	AC/計度/一般/ 0.00元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0160	90807408-PCP03401	90807408	1	AC/計度/一般/ 0.00元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1346	90807408-PCP03375	90807408	1	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1346	90807408-PCP03376	90807408	1	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1346	90807408-PCP03377	90807408	1	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1346	90807408-PCP03378	90807408	1	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0383	90807408-PCP03406	90807408	1	AC/計度/一般/ 0.00元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0383	90807408-PCP03407	90807408	1	AC/計度/一般/ 0.00元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0383	90807408-PCP03408	90807408	1	AC/計度/一般/ 0.00元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0204	90807408-PCP03369	90807408	1	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0204	90807408-PCP03370	90807408	1	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0382	90807408-PCP03411	90807408	1	AC/計度/一般/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0382	90807408-PCP03412	90807408	1	AC/計度/一般/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0207	90807408-PCP03417	90807408	1	AC/計度/一般/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0207	90807408-PCP03418	90807408	1	AC/計度/一般/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0971	90807408-PCP03419	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0971	90807408-PCP03420	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1423	90807408-PCP03423	90807408	1	AC/計度/一般/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1423	90807408-PCP03424	90807408	1	AC/計度/一般/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0680	28371994-PTP3570001	28371994	B1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0680	28371994-PTP3570002	28371994	B1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0680	28371994-PTP3570003	28371994	B1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0680	28371994-PTP3570004	28371994	B1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0680	28371994-PTP3570005	28371994	B1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE0680	28371994-PTP3570006	28371994	B1	計時/每日/10元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1027	80682490-P0001	80682490	B1	計時/10 元/每小時(依停車費率加收)		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1027	80682490-P0002	80682490	B1	計時/10 元/每小時(依停車費率加收)		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1027	80682490-P0003	80682490	B1	計時/10 元/每小時(依停車費率加收)		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1027	80682490-P0004	80682490	B1	計時/10 元/每小時(依停車費率加收)		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1027	80682490-P0005	80682490	B1	計時/10 元/每小時(依停車費率加收)		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	北投區	TPE1027	80682490-P0006	80682490	B1	計時/10 元/每小時(依停車費率加收)		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0828	90807408-PCP03101	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0828	90807408-PCP03102	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0828	90807408-PCP03103	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0828	90807408-PCP03104	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0828	90807408-PCP03105	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0828	90807408-PCP03106	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0828	90807408-PCP03107	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0721	85012273-P332	85012273	B3	計度/尖峰/16:00-22:00/7.00 元每度, 計度/半尖峰/09:00-16:00/7.00 元每度, 計度/半尖峰/22:00-23:59/7.00 元每度, 計度/半尖峰/06:00-11:00/7.00 元每度, 計度/半尖峰/14:00-23:59/7.00 元每度, 計度/離峰/23:59-09:00/7.00 元每度, 計度/離峰/23:59-06:00/7.00 元每度, 計度/離峰/11:00-14:00/7.00 元每度, 計度/離峰/23:59-09:00/7.00 元每度,		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1562	93519232-P109801	93519232	B1	計分/固定/0.8 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0231	28371994-PTP6000001	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0231	28371994-PTP6000002	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0231	28371994-PTP6000003	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0231	28371994-PTP6000004	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0231	28371994-PTP6000005	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0231	28371994-PTP6000006	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0231	28371994-PTP6000007	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0231	28371994-PTP6000008	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0402	90807408-PCP04694	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0402	90807408-PCP04695	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0156	90807408-PCP03021	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0156	90807408-PCP03022	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0156	90807408-PCP03023	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0156	90807408-PCP03024	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0156	90807408-PCP03025	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0156	90807408-PCP03026	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0156	90807408-PCP03027	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0156	90807408-PCP03028	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0122	90807408-PCP05136	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0122	90807408-PCP05137	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0122	90807408-PCP05138	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0122	90807408-PCP05139	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0725	52883637-CIN27-OCPP-ECS--C8CA9	52883637	1	計分/固定/ 8.5 元每分		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1648	90807408-PCP04978	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0601	52883637-CIN27-OCPP-ECS--E1CDE	52883637	1	計分/固定/ 8.0 元每分		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0754	85111787-P018	85111787	4	計時/固定/1 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0754	85111787-P019	85111787	4	計時/固定/1 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0754	85111787-P020	85111787	4	計時/固定/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0754	85111787-P043	85111787	4	計時/固定/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_1	00601133	4F	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_10	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_11	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_12	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_13	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_14	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_15	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_16	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_17	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_18	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_19	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_2	00601133	4F	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_20	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_21	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_22	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_23	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_24	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_25	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_26	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_27	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_28	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_29	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_3	00601133	4F	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_30	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_31	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_32	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_33	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_34	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_35	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_36	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_4	00601133	4F	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_5	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_6	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_7	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_8	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1277	00601133-PA0707011_9	00601133	4	充電服務每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1550	93100784-P0101	25077906	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1550	93100784-P0102	25077906	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1550	93100784-P0103	25077906	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1550	93101587-P0104	25077906	B1	計度/固定/8 元每度		{"J1772_Type1": 2}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1401	94175832-P3b2c7afa9692	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1401	94175832-P852302008d69	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1401	94175832-Pc1decdfd68ed	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0178	90807408-PCP03352	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0178	90807408-PCP03353	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0178	90807408-PCP03354	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0178	90807408-PCP03355	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0178	90807408-PCP03356	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0930	90807408-PCP03033	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0930	90807408-PCP03034	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0930	90807408-PCP03035	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0930	90807408-PCP03036	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0758	28007736-PGOWN001001	28007736	B1	計度/5元每度/00:00-09:00,計度/8元每度/09:00-24:00		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0758	28007736-PGOWN001002	28007736	B1	計度/5元每度/00:00-09:00,計度/8元每度/09:00-24:00		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0758	28007736-PGOWN001003	28007736	B1	計度/5元每度/00:00-09:00,計度/8元每度/09:00-24:00		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0758	28007736-PGOWN001004	28007736	B1	計度/5元每度/00:00-09:00,計度/8元每度/09:00-24:00		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0758	28007736-PGOWN001005	28007736	B1	計度/5元每度/00:00-09:00,計度/8元每度/09:00-24:00		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0758	28007736-PGOWN001006	28007736	B1	計度/5元每度/00:00-09:00,計度/8元每度/09:00-24:00		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0636	12981268-PJEN243101139W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0006	28114216-PXP01240100065	28114216	1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0006	28114216-PXP01242000071	28114216	1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0006	28114216-PXP01242000072	28114216	1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0006	28114216-PXP01242000073	28114216	1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0006	28114216-PXP01242000079	28114216	4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0006	28114216-PXP01242000080	28114216	4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0006	28114216-PXP01242000081	28114216	4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0006	28114216-PXP01242000082	28114216	4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0006	28114216-PXP01242000083	28114216	4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0006	28114216-PXP01242000084	28114216	4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1726	00505188-P0001	25077906	B2	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1726	00505188-P0002	25077906	B2	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1726	00505188-P0003	25077906	B2	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1726	00505188-P0004	25077906	B2	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0288	90807408-PCP03221	90807408	B1	AC/計度/一般/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0288	90807408-PCP03222	90807408	B1	AC/計度/一般/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0288	90807408-PCP03223	90807408	B1	AC/計度/一般/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0288	90807408-PCP03224	90807408	B1	AC/計度/一般/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0288	90807408-PCP03225	90807408	B1	AC/計度/一般/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0288	90807408-PCP03226	90807408	B1	AC/計度/一般/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0288	90807408-PCP03227	90807408	B1	AC/計度/一般/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0288	90807408-PCP03228	90807408	B1	AC/計度/一般/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03170	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03171	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03172	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03173	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03174	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03175	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03176	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03177	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03178	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03179	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03180	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03181	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0690	90807408-PCP03182	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1258	28007736-PFUSN001001	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1258	28007736-PFUSN001002	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1258	28007736-PFUSN001003	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1258	28007736-PFUSN001004	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0182	12981268-PJEN243101071W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0896	80158495-PB11CE2409046	80158495	1	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0401	42649057-PCBDAX50A-24F-XX-B147	00997716	B2	計度：8元/度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0401	42649057-PCBDAX50A-24F-XX-B224	00997716	B2	計度：8元/度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0401	42649057-PCBDAX50A-24F-XX-B423	00997716	B2	計度：8元/度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0401	42649057-PCBDAX50A-24F-XX-B431	00997716	B2	計度：8元/度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1267	97329493-PB11CB2501002	97329493	1	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0570	12981268-PJEN242000750W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0126	90807408-PCP03343	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0126	90807408-PCP03344	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0539	90807408-PCP03345	90807408	1	AC/計度/一般/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0539	90807408-PCP03346	90807408	1	AC/計度/一般/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0161	90807408-PCP03347	90807408	1	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0161	90807408-PCP03348	90807408	1	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0354	52693448-P0092	52693448	B1	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0354	52693448-P0093	52693448	B1	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0354	52693448-P0094	52693448	B1	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0354	52693448-P0095	52693448	B1	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1334	90807408-PCP04770	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1334	90807408-PCP04771	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1334	90807408-PCP04772	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1334	90807408-PCP04773	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1334	90807408-PCP04774	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE1334	90807408-PCP04775	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1435	90807408-PCP03349	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1435	90807408-PCP03350	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1435	90807408-PCP03351	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0450	28114216-PXP01243100063	28114216	B4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0450	28114216-PXP01243100064	28114216	B4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0450	28114216-PXP01243100065	28114216	B4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0450	28114216-PXP01243100066	28114216	B4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0450	28114216-PXP01243100067	28114216	B4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0450	28114216-PXP01243100068	28114216	B4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0450	28114216-PXP01243100069	28114216	B4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0450	28114216-PXP01243100070	28114216	B4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0450	28114216-PXP01243100071	28114216	B4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0450	28114216-PXP01243100072	28114216	B4	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0575	90807408-PCP03453	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0575	90807408-PCP03454	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0575	90807408-PCP03455	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0575	90807408-PCP03456	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0575	90807408-PCP03457	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0575	90807408-PCP03458	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1602	28114216-PJEN233901528W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1602	28114216-PJEN233901532W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1602	28114216-PJEN233901601W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1602	28114216-PJEN233901612W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1602	28114216-PJEN233901620W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE1602	28114216-PJEN233901637W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03293	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03294	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03295	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03296	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03297	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0901	22957668-P0006	22957668	3	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03298	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03299	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03300	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03301	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03302	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03303	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03304	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03305	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03306	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03307	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0229	90807408-PCP03308	90807408	2	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0678	33029464-PTP6720001	33029464	3	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0678	33029464-PTP6720002	33029464	3	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0678	33029464-PTP6720003	33029464	3	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0678	33029464-PTP6720004	33029464	3	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0678	33029464-PTP6720005	33029464	3	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0678	33029464-PTP6720006	33029464	3	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0678	33029464-PTP6720007	33029464	3	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0678	33029464-PTP6720008	33029464	3	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0360	90807408-PCP03319	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0360	90807408-PCP03320	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0360	90807408-PCP03321	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0360	90807408-PCP03322	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0360	90807408-PCP03323	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0360	90807408-PCP03324	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0360	90807408-PCP03325	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0360	90807408-PCP03326	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0360	90807408-PCP03327	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0360	90807408-PCP03328	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0760	90807408-PCP05980	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0760	90807408-PCP05981	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0760	90807408-PCP05982	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0760	90807408-PCP05983	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0760	90807408-PCP05984	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06043	90807408	2	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06044	90807408	2	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06045	90807408	5	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06046	90807408	5	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06047	90807408	5	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06048	90807408	5	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06049	90807408	5	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06050	90807408	5	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06051	90807408	5	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06052	90807408	5	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06053	90807408	5	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06054	90807408	5	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1032	90807408-PCP06055	90807408	5	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1084	94175832-P066ea39a49a2	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1084	94175832-P560fae7929c5	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1084	94175832-Pa8db828ac3f3	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1084	94175832-Pcab349a6ee33	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1084	94175832-Pd03bf6dfee46	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1084	94175832-Pe53a24a5f60b	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1102	90807408-PCP05331	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-P18bdad1600ea	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-P19bb95bd3ff8	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-P37ad829ab6f5	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-P39b9a19f6de5	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-P49cb41584fd9	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-P4ec83372b9c6	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-P52dedf648e39	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-P5b0d88981446	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-P6543729a1556	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-P6961d9e79f14	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-Pae2d65ee4105	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-Pba075ac556f1	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-Pdfbf620f6916	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1354	94175832-Pf4f51afb8e9d	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0300	85051710-P1316	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0300	85051710-P1457	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0358	42311786-P345	42311786	B1	計度/尖峰/16:00-22:00/7.00 元每度, 計度/半尖峰/09:00-16:00/7.00 元每度, 計度/半尖峰/22:00-23:59/7.00 元每度, 計度/半尖峰/06:00-11:00/7.00 元每度, 計度/半尖峰/14:00-23:59/7.00 元每度, 計度/離峰/23:59-09:00/7.00 元每度, 計度/離峰/23:59-06:00/7.00 元每度, 計度/離峰/11:00-14:00/7.00 元每度, 計度/半尖峰/09:00-23:59/7.00 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0407	85051710-P1277	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0407	85051710-P1278	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0407	85051710-P1423	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0752	90807408-PCP03259	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0752	90807408-PCP03260	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0752	90807408-PCP03261	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0752	90807408-PCP03262	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0752	90807408-PCP03263	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0752	90807408-PCP03264	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0752	90807408-PCP03265	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0752	90807408-PCP03266	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0751	00570949-P0001	00570949	1	依現場公告		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0751	00570949-P0002	00570949	1	依現場公告		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0751	00570949-P0003	00570949	1	依現場公告		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0751	00570949-P0004	00570949	1	依現場公告		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0751	00570949-P0005	00570949	1	依現場公告		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0843	52883637-CIN27-OCPP-ECS--C70E9	52883637	1	計分/固定/ 8.5 元每分		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0722	28371994-PTP6510001	28371994	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0722	28371994-PTP6510002	28371994	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0722	28371994-PTP6510003	28371994	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0722	28371994-PTP6510004	28371994	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0722	28371994-PTP6510005	28371994	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0722	28371994-PTP6510006	28371994	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1056	94175832-P47c377db7fc5	94175832	B1	計分/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1056	94175832-Pf0d5e5e29e97	94175832	B1	計分/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1108	12981268-PJEN243701159W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1108	12981268-PJEN243701165W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0775	90807408-PCP03249	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0775	90807408-PCP03250	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0775	90807408-PCP03251	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0775	90807408-PCP03252	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0775	90807408-PCP03253	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0775	90807408-PCP03254	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0775	90807408-PCP03255	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0775	90807408-PCP03256	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0775	90807408-PCP03257	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0775	90807408-PCP03258	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03267	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03268	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03269	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03270	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03278	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03279	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03280	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03281	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03282	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03283	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03284	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03285	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03286	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0827	90807408-PCP03287	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1537	12981268-PJEN243101081W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0654	90807408-PCP03309	90807408	3	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0654	90807408-PCP03310	90807408	3	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0654	90807408-PCP03311	90807408	3	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0654	90807408-PCP03312	90807408	3	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0654	90807408-PCP03313	90807408	3	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0654	90807408-PCP03314	90807408	3	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0654	90807408-PCP03315	90807408	3	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0654	90807408-PCP03316	90807408	3	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0654	90807408-PCP03317	90807408	3	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0654	90807408-PCP03318	90807408	3	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1634	28114216-PXP01250300026	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0530	90807408-PCP05410	90807408	B3	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0530	90807408-PCP05411	90807408	B3	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0530	90807408-PCP05412	90807408	B3	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0763	26262936-P589	26262936	B一	計度/尖峰/09:00-23:59/7.00 元每度, 計度/尖峰/06:00-11:00/7.00 元每度, 計度/尖峰/14:00-23:59/7.00 元每度, 計度/離峰/23:59-09:00/7.00 元每度, 計度/離峰/23:59-06:00/7.00 元每度, 計度/離峰/11:00-14:00/7.00 元每度, 計度/半尖峰/09:00-23:59/7.00 元每度, 計度/半尖峰/06:00-11:00/7.00 元每度, 計度/半尖峰/14:00-23:59/7.00 元每度, 		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0384	85051710-P1275	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0384	85051710-P1421	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0596	53919205-P0001	53919205	1	計度/固定/6.0 元每度		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0639	80158495-PB11CE2409064	80158495	1	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0800	94175832-P1941f39c1d82	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0800	94175832-P20cc8dc4fef8	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0800	94175832-Pa72c3e0efaf1	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0800	94175832-Pc1fe2ba3ec96	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0800	94175832-Pe40dab7ed94f	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0800	94175832-Pedb17de3f491	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0952	12981268-PJEN242000747W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1048	94175832-P29801df24c26	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1048	94175832-P3ae0227af3d1	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1048	94175832-P6cf5f96e1cae	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1048	94175832-Pcfde1660d322	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1048	94175832-Pebd6439036d5	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1048	94175832-Pfa741efe5520	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1599	12981268-PJEN243701175W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1599	12981268-PJEN243701258W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0901	22957668-P0001	22957668	3	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0901	22957668-P0002	22957668	3	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0901	22957668-P0003	22957668	3	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0901	22957668-P0004	22957668	3	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0901	22957668-P0005	22957668	3	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0901	22957668-P0007	22957668	3	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0901	22957668-P0008	22957668	3	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0901	22957668-P0009	22957668	3	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0902	22957668-P0010	22957668	2	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0902	22957668-P0011	22957668	2	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0184	12981268-PJEN243100964W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1315	52883637-CIN27-OCPP-TYC--00132	52883637	1	計分/固定/ 0.0 元每分		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1315	52883637-CIN27-OCPP-TYC--00133	52883637	1	計分/固定/ 0.0 元每分		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0348	50965513-PA0324TYTW00132	50965513	B1	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0348	50965513-PA0324TYTW00133	50965513	B1	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1399	88260590-PB026001_1	88260590	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1400	88260607-PB026101_1	88260607	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1400	88260607-PB026101_2	88260607	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1400	88260607-PB026101_3	88260607	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1400	88260607-PB026101_4	88260607	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1400	88260607-PB026101_5	88260607	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE1400	88260607-PB026101_6	88260607	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-CNGTS366	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS334	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS335	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS336	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS337	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS338	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS339	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS340	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS341	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS342	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS343	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS344	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS345	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS346	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS347	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS348	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS359	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS360	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS361	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS362	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS363	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS364	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS365	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS367	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS368	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS369	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS370	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS371	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS372	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS373	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS374	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	南港區	TPE0959	28652185-PNGTS375	28652185	B2	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0724	85051710-P1270	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0724	85051710-P1271	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0724	85051710-P1417	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0215	85051710-P1276	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0215	85051710-P1422	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0279	85051710-P1269	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0279	85051710-P1416	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0381	85051710-P1272	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE0381	85051710-P1418	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1388	28114216-PJEN211600131W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1388	28114216-PJEN211600166W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1388	28114216-PJEN211600208W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1388	28114216-PJEN212800379W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1388	28114216-PJEN223200639W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1388	28114216-PXP01244300003	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN231900730W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901438W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901444W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901449W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901450W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901455W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901456W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901460W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901461W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901478W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901491W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901542W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901564W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN233901590W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	內湖區	TPE1604	28114216-PJEN241200554W0	28114216	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0824	90807408-PCP03067	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0824	90807408-PCP03068	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0824	90807408-PCP03069	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0824	90807408-PCP03070	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0824	90807408-PCP03071	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0824	90807408-PCP03072	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0239	90807408-PCP03073	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0239	90807408-PCP03074	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0239	90807408-PCP03075	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0239	90807408-PCP03076	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0239	90807408-PCP03077	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0239	90807408-PCP03078	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0239	90807408-PCP03079	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大同區	TPE0239	90807408-PCP03080	90807408	 B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0425	85051710-P1001	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0425	85051710-P1002	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0425	85051710-P1159	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0425	85051710-P1160	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0425	85051710-P1319	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0425	85051710-P1320	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410001	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410002	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410003	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410004	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410005	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410006	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410007	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410008	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410009	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410010	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410011	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410012	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410013	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410014	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410015	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410016	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0330	33029464-PTP6410017	33029464	B2	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	未分類	TPE0441	90807408-PCP03361	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	未分類	TPE0441	90807408-PCP03362	90807408	1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0099	28371994-PTP5990001	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0099	28371994-PTP5990002	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0099	28371994-PTP5990003	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0099	28371994-PTP5990004	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0099	28371994-PTP5990005	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0099	28371994-PTP5990006	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0099	28371994-PTP5990007	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0099	28371994-PTP5990008	28371994	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0109	28114216-PJEN233901604W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0109	28114216-PJEN233901734W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0109	28114216-PJEN233901822W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0109	28114216-PXP01244300002	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE1206	94128120-P260145	94128120	1	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE1206	94128120-P690893	94128120	1	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0389	01176272-P0013	01176272	B3	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0389	01176272-P0014	01176272	B3	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0389	01176272-P0015	01176272	B3	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0389	01176272-P0016	01176272	B3	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0389	01176272-P0017	01176272	B3	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0389	01176272-P0018	01176272	B3	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0389	01176272-P0019	01176272	B3	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0100	28371994-PTP5490001	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0100	28371994-PTP5490002	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0100	28371994-PTP5490003	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0100	28371994-PTP5490004	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0100	28371994-PTP5490005	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0100	28371994-PTP5490006	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0100	28371994-PTP5490007	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0100	28371994-PTP5490008	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0100	28371994-PTP5490009	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0100	28371994-PTP5490010	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500001	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500002	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500003	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500004	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500005	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500006	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500007	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500008	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500009	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500010	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500011	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500012	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500013	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500014	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500015	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500016	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500017	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500018	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0110	28371994-PTP5500019	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0120	89132567-P0156	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0120	89132567-P0157	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0120	89132567-P0158	80688966	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0176	12981268-PJEN253001086W0	12981268	1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0977	89132567-P0319	89132567	1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0015	85051710-P1273	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0015	85051710-P1419	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0014	94175832-P00b1aecbf982	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0014	94175832-P58683ed03f47	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0014	94175832-Pbc0b18de078d	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0014	94175832-Pde64bbc7bf6a	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0014	94175832-Pe3772f2bc6e8	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0014	94175832-Pf8edcc893c93	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0123	85051710-P1292	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0123	85051710-P1435	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0534	85051710-P1161	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0534	85051710-P1162	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0534	85051710-P1163	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0534	85051710-P1164	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0534	85051710-P1165	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0534	85051710-P1321	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0534	85051710-P1322	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0534	85051710-P1323	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0534	85051710-P1324	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0606	85051710-P1166	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0606	85051710-P1167	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0606	85051710-P1168	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0606	85051710-P1169	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0606	85051710-P1325	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0606	85051710-P1326	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0606	85051710-P1327	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-P10cbb6d67864	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-P33a3dab160d7	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-P57b2ea4389b5	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-P70cd1e346c8d	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-P80f63c72f5f2	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-P88bed96cf5e4	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-P936a7dfc6c39	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-Pa7a2f685e94f	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-Pdd1e8de6a913	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-Pf0d57316dd87	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-Pf3c0b0142557	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0447	94175832-Pf71c826dcfae	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0493	94175832-P717185806f4b	94175832	B1	計分/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0493	94175832-Pd37b30aad078	94175832	B1	計分/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0997	90807408-PCP05547	90807408	B4	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0997	90807408-PCP05548	90807408	B4	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0997	90807408-PCP05549	90807408	B4	AC/計度/一般/ 8.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0997	90807408-PCP05550	90807408	B4	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0997	90807408-PCP05551	90807408	B4	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0997	90807408-PCP05552	90807408	B4	AC/計度/一般/ 8.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0001	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0002	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0003	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0004	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0005	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0006	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0007	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0008	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0009	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0010	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0011	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0738	01176272-P0012	01176272	5	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0154	85051710-P1300	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0154	85051710-P1442	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0446	12681939-PPSS_YA270_001	12681939	1	計度 /固定 /10元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0446	12681939-PPSS_YA270_002	12681939	1	計度 /固定 /10元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0220	90807408-PCP06149	90807408	B2	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0220	90807408-PCP06150	90807408	B2	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0220	90807408-PCP06151	90807408	B2	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0220	90807408-PCP06152	90807408	B2	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0220	90807408-PCP06153	90807408	B2	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0220	90807408-PCP06154	90807408	B2	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0220	90807408-PCP06155	90807408	B2	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0220	90807408-PCP06156	90807408	B2	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0646	90505425-P537390752712425479-1	90505425	1F	快充計度/離峰/6.5元每度，計度/尖峰/13.5元每度，尖峰時段為15:00-21:00，慢充計時/固定/1元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0646	90505425-P537390752712425479-2	90505425	1F	快充計度/離峰/6.5元每度，計度/尖峰/13.5元每度，尖峰時段為15:00-21:00，慢充計時/固定/1元每分		{"CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0646	90505425-P537390752712425479-3	90505425	1F	快充計度/離峰/6.5元每度，計度/尖峰/13.5元每度，尖峰時段為15:00-21:00，慢充計時/固定/1元每分		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0251	90505425-P537381	90505425	1	計時/固定/1元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0251	90505425-P537382	90505425	1	計時/固定/1元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0251	90505425-P537383	90505425	1	計時/固定/1元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE1323	90505425-P537391	90505425	1	計時/固定/1元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0007	93158315-PA053001_4	93158315	B1	計分/5元每30分(充電)，10元每30分(佔位未充電)		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0007	93158315-PA053001_5	93158315	B1	計分/5元每30分(充電)，10元每30分(佔位未充電)		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0134	85051710-P1315	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0134	85051710-P1456	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0665	90807408-PCP04692	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0666	90807408-PCP04689	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0762	90807408-PCP03572	90807408	1	AC/計度/一般/ 7.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0762	90807408-PCP03573	90807408	1	AC/計度/一般/ 7.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0762	90807408-PCP03574	90807408	1	AC/計度/一般/ 7.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0762	90807408-PCP03575	90807408	1	AC/計度/一般/ 7.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE1142	42649057-PCBDAX50A-24F-XX-B018	42649057	B2	待確認		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0529	85012273-P561	85012273	1	計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/8.00 元每度, 計度/離峰/23:59-06:00/8.00 元每度, 計度/離峰/11:00-14:00/8.00 元每度, 計度/半尖峰/09:00-23:59/8.00 元每度, 計度/半尖峰/06:00-11:00/8.00 元每度, 計度/半尖峰/14:00-23:59/8.00 元每度, 		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0871	28652185-PTPTSW1	28652185	B1	計度/固定/9.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0871	28652185-PTPTSW2	28652185	B1	計度/固定/9.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0047	28652185-PTPTSE74	28652185	B1	計度/固定/9.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0047	28652185-PTPTSE75	28652185	B1	計度/固定/9.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0011	28371994-PTP4340001	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0011	28371994-PTP4340002	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0011	28371994-PTP4340003	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0011	28371994-PTP4340004	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0011	28371994-PTP4340005	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0011	28371994-PTP4340006	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0011	28371994-PTP4340007	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0011	28371994-PTP4340008	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0011	28371994-PTP4340009	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE0247	28007736-PAPAL015001	28007736	B5	計分/ 0.9元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0125	85051710-P1290	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0125	85051710-P1291	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0125	85051710-P1434	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE1150	85051710-P1293	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE1150	85051710-P1436	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE1128	85051710-P1294	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE1128	85051710-P1437	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0535	89132567-P0216	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0535	89132567-P0253	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0535	89132567-P0254	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0535	89132567-P0255	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0535	89132567-P0256	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中山區	TPE0615	89132567-P0213	16777442	B1	計度/固定/8元每度		{"J1772_Type1": 5}	2026-05-01 01:00:08+00
臺北市	中正區	TPE1227	53703514-P500136	53703514	1	計度/固定/0 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE1476	88324010-PB11CB2501007	88324010	1	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE1476	88324010-PB11CE2409050	88324010	1	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE1585	42477884-P583	42477884	B2	計度/尖峰/09:00-23:59/7.00 元每度, 計度/尖峰/06:00-11:00/7.00 元每度, 計度/尖峰/14:00-23:59/7.00 元每度, 計度/離峰/23:59-09:00/7.00 元每度, 計度/離峰/23:59-06:00/7.00 元每度, 計度/離峰/11:00-14:00/7.00 元每度, 計度/半尖峰/09:00-23:59/7.00 元每度, 計度/半尖峰/06:00-11:00/7.00 元每度, 計度/半尖峰/14:00-23:59/7.00 元每度, 		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	中正區	TPE1624	73981000-P0001	73981000	B1	計分/1元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0244	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0246	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0247	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0248	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0257	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0258	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0259	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0260	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0261	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0262	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0263	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0264	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0265	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0082	89132567-P0266	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1170	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1171	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1172	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1173	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1174	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1175	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1328	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1329	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1330	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1331	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1332	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0003	85051710-P1333	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0177	28371994-PTP7430001	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0177	28371994-PTP7430002	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0177	28371994-PTP7430003	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0177	28371994-PTP7430004	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0832	85051710-P1176	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0832	85051710-P1177	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0832	85051710-P1178	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0832	85051710-P1179	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0832	85051710-P1334	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0832	85051710-P1335	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0832	85051710-P1336	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0832	85051710-P1337	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0008	28652185-PTPBN0030	28652185	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0008	28652185-PTPBN0031	28652185	B2	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0155	28114216-PJEN233901594W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0155	28114216-PJEN233901619W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0155	28114216-PJEN233901688W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0155	28114216-PJEN233901870W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0163	28114216-PJEN233901538W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0163	28114216-PJEN233901561W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0163	28114216-PJEN233901611W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0163	28114216-PJEN233901657W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0164	28114216-PJEN223200633W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0164	28114216-PJEN233901487W0	28114216	B1	計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1402	94175832-P055943291dce	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1402	94175832-P119317117771	94175832	B1	計度/固定/8 元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1402	94175832-P16632b307c99	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1402	94175832-P4100d7a674e5	94175832	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1403	94175832-P01381377ae53	94175832	B1	計分/6.9 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1403	94175832-P0f7b694c6e58	94175832	B1	計分/6.9 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1403	94175832-P95864b55d24d	94175832	B1	計分/6.9 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1403	94175832-Pb0d7bf55a3f9	94175832	B1	計分/6.9 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1403	94175832-Pd68fda6556f6	94175832	B1	計分/6.9 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0355	28371994-PTP4180001	28371994	B2	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0355	28371994-PTP4180002	28371994	B2	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0355	28371994-PTP4180003	28371994	B2	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0355	28371994-PTP4180004	28371994	B2	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0355	28371994-PTP4180005	28371994	B2	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0355	28371994-PTP4180006	28371994	B2	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0355	28371994-PTP4180007	28371994	B2	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0356	28371994-PTP4170001	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0356	28371994-PTP4170002	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0054	90807408-PCP05910	90807408	B3	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0054	90807408-PCP05911	90807408	B3	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0054	90807408-PCP05912	90807408	B3	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0068	28007736-PAPAL016001	28007736	B1	計分/ 0.7元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0068	28007736-PAPAL016002	28007736	B1	計分/ 0.7元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0009	85051710-P1317	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0009	85051710-P1318	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0009	85051710-P1458	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0038	94175832-P04ede7b15962	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0038	94175832-P0862b4a0fef4	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0038	94175832-P337f8d6d0c5b	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0038	94175832-P3a5e3063941e	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0038	94175832-P4cf7ea5a0793	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0038	94175832-P602883761f97	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0038	94175832-P644f3eb815b9	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0038	94175832-P7370cd9c5c78	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0038	94175832-Pbc598842337c	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0038	94175832-Pe82c5e467070	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0075	85051710-P1223	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0075	85051710-P1224	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0075	85051710-P1225	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0075	85051710-P1376	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0075	85051710-P1377	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0072	85051710-P1226	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0072	85051710-P1227	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0072	85051710-P1228	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0072	85051710-P1378	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0072	85051710-P1379	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0072	85051710-P1380	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0656	94175832-P22e7fb6338ac	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0656	94175832-P29224691b9f2	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0656	94175832-P62934ad914af	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0656	94175832-P784f797bf77a	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0656	94175832-P98a1eb6550b2	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0656	94175832-P99731018b21e	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0656	94175832-Pbd35dfea7c77	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0656	94175832-Pcbc1561fcf1c	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0792	94175832-P93e66eec8081	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0792	94175832-Pd99c383b4298	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0884	85051710-P1229	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0884	85051710-P1230	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0884	85051710-P1231	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0884	85051710-P1232	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0884	85051710-P1381	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0884	85051710-P1382	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0884	85051710-P1383	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0851	85051710-P1233	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0851	85051710-P1234	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0851	85051710-P1235	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0851	85051710-P1236	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0851	85051710-P1237	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0851	85051710-P1238	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0851	85051710-P1384	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0851	85051710-P1385	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0851	85051710-P1386	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0851	85051710-P1387	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0851	85051710-P1388	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1598	94175832-Pa710c03e1ba0	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1598	94175832-Pbd4b76bbfed2	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1598	94175832-Pd3a6ac100229	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_258	12681939	1	計度 /固定 /5元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_259	12681939	1	計度 /固定 /5元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_260	12681939	1	計度 /固定 /5元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_261	12681939	1	計度 /固定 /5元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_262	12681939	1	計度 /固定 /5元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_263	12681939	1	計度 /固定 /5元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_264	12681939	1	計度 /固定 /5元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_265	12681939	1	計度 /固定 /5元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_285	12681939	1	計度 /固定 /5元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_286	12681939	1	計度 /固定 /5元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_287	12681939	1	計度 /固定 /5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_288	12681939	1	計度 /固定 /5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_289	12681939	1	計度 /固定 /5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_290	12681939	1	計度 /固定 /5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_291	12681939	1	計度 /固定 /5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_292	12681939	1	計度 /固定 /5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_293	12681939	1	計度 /固定 /5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_294	12681939	1	計度 /固定 /5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_295	12681939	1	計度 /固定 /5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1661	12681939-PPSS_YA449_296	12681939	1	計度 /固定 /5元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0766	90807408-PCP05384	90807408	B4	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0766	90807408-PCP05385	90807408	B4	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0766	90807408-PCP05386	90807408	B4	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0766	90807408-PCP05387	90807408	B4	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0766	90807408-PCP05388	90807408	B4	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0766	90807408-PCP05389	90807408	B4	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0766	90807408-PCP05390	90807408	B4	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0766	90807408-PCP05391	90807408	B4	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0766	90807408-PCP05392	90807408	B4	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0766	90807408-PCP05393	90807408	B4	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0874	94175832-P38a3207892e6	94175832	B1	計分/1.1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0874	94175832-P39f0592aba82	94175832	B1	計分/1.1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0874	94175832-P3a012906d1e2	94175832	B1	計分/1.1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0874	94175832-P91fd292c29da	94175832	B1	計分/1.1 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0874	94175832-Pac15ffe27661	94175832	B1	計分/1.1 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1238	97179430-P00015	97179430	B4	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1238	97179430-P00016	97179430	B4	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1265	90807408-PCP04691	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1472	89132567-P0341	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1472	89132567-P0342	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1472	89132567-P0343	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1472	89132567-P0344	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1472	89132567-P0345	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1472	89132567-P0346	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1472	89132567-P0347	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1472	89132567-P0348	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1488	89132567-P0349	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1488	89132567-P0350	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1488	89132567-P0351	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1488	89132567-P0352	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1488	89132567-P0353	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1488	89132567-P0354	89132567	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0409	85051710-P1308	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0409	85051710-P1450	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0022	94175832-P04ab0f01262f	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0022	94175832-P35b5b29a8974	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0022	94175832-Pa91ee5e72ed4	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0022	94175832-Paf18932580b8	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0022	94175832-Pfae0659b03cc	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0253	85051710-P1681	85051710	B3	計度/每度8.50元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0253	85051710-P1682	85051710	B3	計度/每度8.50元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0253	85051710-P1683	85051710	B3	計度/每度8.50元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0253	85051710-P1684	85051710	B3	計度/每度8.50元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0253	85051710-P1685	85051710	B3	計度/每度8.50元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0253	85051710-P1686	85051710	B3	計度/每度8.50元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0253	85051710-P1687	85051710	B3	計度/每度8.50元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0253	85051710-P1688	85051710	B3	計度/每度8.50元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0343	94175832-P34312886af1b	94175832	B1	計分/1 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0343	94175832-P42445706f0ad	94175832	B1	計分/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0343	94175832-P9b8ce676c780	94175832	B1	計分/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0343	94175832-P9dc31b43781c	94175832	B1	計分/1 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0343	94175832-Pc494166ab301	94175832	B1	計分/1 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0343	94175832-Pe8cf05922625	94175832	B1	計分/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1053	94175832-P0e86183565d2	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1053	94175832-P5de4f51566e3	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1053	94175832-P9d31af3a383c	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1053	94175832-Pd6279f5a8a8c	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1053	94175832-Pe810c19c1b78	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1053	94175832-Pee2b920d83f7	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1054	94175832-P5ef4a27e014f	94175832	B1	計分/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1054	94175832-P6b44903dc9d6	94175832	B1	計分/1 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1054	94175832-P80662813b97d	94175832	B1	計分/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1054	94175832-P8be130de9670	94175832	B1	計分/1 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1054	94175832-P917c81772ca9	94175832	B1	計分/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1123	90807408-PCP00407	90807408	1	AC/計度/一般/ 8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1667	90482725-P00186	90482725	1	充電費率每度 8 元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1667	90482725-P00188	90482725	1	充電費率每度 8 元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0571	90505425-P5837801	90505425	5	計時/固定/1元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0571	90505425-P5837802	90505425	5	計時/固定/1元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0571	90505425-P5837803	90505425	5	計時/固定/1元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1004	85051710-P1764	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1004	85051710-P792	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0707	52883637-CIN27-OCPP-TYC--00198	52883637	1	計分/固定/ 6.7 元每分		{"CCS1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0712	88258237-PB022401_1	88258237	B1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0712	88258237-PB022401_2	88258237	B1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0712	88258237-PB022401_3	88258237	B1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0712	88258237-PB022401_4	88258237	B1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0712	88258237-PB022401_5	88258237	B1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0712	88258237-PB022401_6	88258237	B1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0151	88258243-PB024301_1	88258243	B1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0151	88258243-PB024301_2	88258243	B1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0151	88258243-PB024301_3	88258243	B1	免費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0234	85051710-P1279	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0234	85051710-P1424	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0051	28371994-PTP5410001	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0051	28371994-PTP5410002	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0051	28371994-PTP5410003	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0051	28371994-PTP5410004	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0051	28371994-PTP5410005	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0051	28371994-PTP5410006	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE0051	28371994-PTP5410007	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1578	33029464-PTP6360001	33029464	B1	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1578	33029464-PTP6360002	33029464	B1	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1578	33029464-PTP6360003	33029464	B1	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1578	33029464-PTP6360004	33029464	B1	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1578	33029464-PTP6360005	33029464	B1	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	TPE1578	33029464-PTP6360006	33029464	B1	計時/每日/5元每0.5時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0238	85051710-P1298	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0238	85051710-P1441	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1149	85051710-P1280	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1149	85051710-P1425	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1110	85051710-P1309	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1110	85051710-P1451	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0070	28371994-PTP6910001	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0070	28371994-PTP6910002	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0070	28371994-PTP6910003	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0070	28371994-PTP6910004	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0070	28371994-PTP6910005	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0070	28371994-PTP6910006	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0070	28371994-PTP6910007	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0070	28371994-PTP6910008	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900001	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900002	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900003	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900004	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900005	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900006	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900007	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900008	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900009	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900010	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900011	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900012	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900013	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900014	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900015	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900016	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900017	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900018	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900019	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900020	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900021	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900022	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900023	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900024	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900025	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900026	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900027	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900028	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900029	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900030	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900031	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900032	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900033	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900034	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900035	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900036	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900037	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900038	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900039	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0096	28371994-PTP6900040	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1243	76888870-P0101	25077906	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1243	76888870-P0102	25077906	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1243	76888870-P0103	25077906	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1243	76888870-P0104	25077906	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE1243	76888870-P0105	25077906	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0421	93101587-P0101	93101587	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0421	93101587-P0102	93101587	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0421	93101587-P0103	93101587	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0421	93101587-P0105	93101587	B1	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0505	28007736-PGOWN003001	28007736	B1	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0505	28007736-PGOWN003002	28007736	B1	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0505	28007736-PGOWN003003	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0505	28007736-PGOWN003004	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0505	28007736-PGOWN003005	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0505	28007736-PGOWN003006	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0505	28007736-PGOWN003007	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0505	28007736-PGOWN003008	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0505	28007736-PGOWN003009	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0505	28007736-PGOWN003010	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0106	28371994-PTP7600001	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0106	28371994-PTP7600002	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0459	80158495-PB11CB2501006	80158495	1	慢充每度5元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0542	97179430-P00123	97179430	B4	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0542	97179430-P00124	97179430	B4	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0542	97179430-P00125	97179430	B4	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0542	97179430-P00126	97179430	B4	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0741	94175832-P0145e0dbe496	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0741	94175832-P1b02e1e60402	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1181	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1182	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1183	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1184	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1185	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1186	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1187	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1338	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1339	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1340	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1341	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1342	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1343	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0098	85051710-P1344	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0774	93111038-PB11CB2506060	93111038	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0774	93111038-PB11CB2506064	93111038	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0880	42861108-P133851A	42861108	B2	計度/浮動/8元每度		{"CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0880	42861108-P133851B	42861108	B2	計度/浮動/8元每度		{"Tesla_TPC": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0880	42861108-P133851C	42861108	B2	計度/浮動/8元每度		{"Tesla_TPC": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1012	90807408-PCP03569	90807408	B2	AC/計度/一般/ 7.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1012	90807408-PCP03570	90807408	B2	AC/計度/一般/ 7.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1012	90807408-PCP03571	90807408	B2	AC/計度/一般/ 7.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1188	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1189	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1190	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1191	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1192	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1193	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1194	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1195	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1196	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1197	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1198	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1199	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1200	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1201	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1202	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1203	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1204	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1205	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1206	85051710	B2	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1345	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1346	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1347	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1348	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1349	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1350	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1351	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1352	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1353	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1354	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1355	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1356	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1357	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1358	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1359	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1360	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1361	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0095	85051710-P1362	85051710	B2	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1292	94175832-P0587b7b1df1a	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1292	94175832-Pd3313a91b309	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1292	94175832-Pec7aeba08048	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1505	88339626-P626	88339626	B1	計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/8.00 元每度, 計度/離峰/23:59-06:00/8.00 元每度, 計度/離峰/11:00-14:00/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0127	85051710-P1288	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0127	85051710-P1289	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0127	85051710-P1433	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0129	90807408-PCP04688	90807408	1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1593	90807408-PCP00093	90807408	1	AC/計度/一般/ 0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0135	97179430-P00027	97179430	B3	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0135	97179430-P00028	97179430	B3	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0255	89132567-P0159	89132567	B3	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0255	89132567-P0160	89132567	B3	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0255	89132567-P0161	89132567	B3	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0255	89132567-P0162	89132567	B3	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0255	89132567-P0163	89132567	B3	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0255	89132567-P0164	89132567	B3	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0255	89132567-P0165	89132567	B3	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1207	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1208	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1209	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1210	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1211	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1212	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1213	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1214	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1215	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1216	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1363	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1364	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1365	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1366	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1367	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1368	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1369	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1370	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0449	85051710-P1371	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0086	85051710-P1217	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0086	85051710-P1218	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0086	85051710-P1219	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0086	85051710-P1372	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0086	85051710-P1373	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0645	28371994-PTP5850001	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0645	28371994-PTP5850002	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0645	28371994-PTP5850003	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0645	28371994-PTP5850004	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0645	28371994-PTP5850005	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0645	28371994-PTP5850006	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0645	28371994-PTP5850007	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0645	28371994-PTP5850008	28371994	B1	計時/每日/0元每1時		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1011	90807408-PCP03568	90807408	1	AC/計度/一般/ 7.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0066	97179430-P00091	97179430	B1	計度 /固定 /8.5元 AC 7kW每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0066	97179430-PT0363	97179430	B1	計度 /固定 /8.5元 AC 7kW每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0066	97179430-PT0365	97179430	B1	計度 /固定 /8.5元 AC 7kW每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0066	97179430-PT0366	97179430	B1	計度 /固定 /8.5元 AC 7kW每度		{"J1772_Type1": 2}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0066	97179430-PT0367	97179430	B1	計度 /固定 /8.5元 AC 7kW每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0066	97179430-PT0368	97179430	B1	計度 /固定 /8.5元 AC 7kW每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0066	97179430-PT0370	97179430	B1	計度 /固定 /8.5元 AC 7kW每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0066	97179430-PT0371	97179430	B1	計度 /固定 /8.5元 AC 7kW每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0066	97179430-PT0375	97179430	B1	計度 /固定 /8.5元 AC 7kW每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0067	97179430-PT0637	97179430	B1	計度 /固定 /12元 DC 30kW每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0067	97179430-PT0638	97179430	B1	計度 /固定 /12元 DC 30kW每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0067	97179430-PT0639	97179430	B1	計度 /固定 /12元 DC 30kW每度		{"CCS1": 1, "CCCS2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0069	97179430-P00087	97179430	B4	計度 /固定 /12元 DC每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0069	97179430-P00088	97179430	B4	計度 /固定 /12元 DC每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0069	97179430-P00089	97179430	B4	計度 /固定 /12元 DC每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0069	97179430-P00090	97179430	B4	計度 /固定 /12元 DC每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0069	97179430-P00092	97179430	B4	計度 /固定 /12元 DC每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0069	97179430-P00093	97179430	B4	計度 /固定 /12元 DC每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0069	97179430-P00131	97179430	B4	計度 /固定 /12元 DC每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0116	93111044-PB11CB2506057	93111044	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0116	93111044-PB11CB2506059	93111044	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0116	93111044-PB11CB2506062	93111044	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0313	52492792-P25543db6711e	94175832	B1	計分/1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0716	90807408-PCP06165	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0716	90807408-PCP06166	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0716	90807408-PCP06167	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0716	90807408-PCP06168	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0716	90807408-PCP06169	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0468	94175832-P0028dc4e1f7e	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0468	94175832-P484402a614da	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0468	94175832-P6130ba7a44cf	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0468	94175832-Pa2e9b597dbad	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0468	94175832-Pde77ff2a88f8	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0468	94175832-Pf10872730c28	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0502	94175832-P23c4914ad7d5	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0502	94175832-P8c37e0b9f74b	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0502	94175832-P912946218bb2	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0502	94175832-Pa3006f613c14	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0502	94175832-Pf6e79aaf5403	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0502	94175832-Pfc6e730d4093	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0715	85051710-P1262	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0715	85051710-P1263	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0715	85051710-P1264	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0715	85051710-P1265	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0715	85051710-P1410	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0715	85051710-P1411	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0715	85051710-P1412	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0593	83578534-FH19	83578534	1	測試中，不計費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0593	83578534-FH20	83578534	1	測試中，不計費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0593	83578534-FH21	83578534	1	測試中，不計費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0593	83578534-FH22	83578534	1	測試中，不計費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0593	83578534-FH23	83578534	1	測試中，不計費		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0092	90807408-PCP03199	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0092	90807408-PCP03200	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0092	90807408-PCP03201	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0092	90807408-PCP03202	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0092	90807408-PCP03203	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0092	90807408-PCP03204	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0092	90807408-PCP03205	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0702	28007736-PAPAL013001	28007736	1	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0305	90807408-PCP03206	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0305	90807408-PCP03207	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0305	90807408-PCP03208	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0305	90807408-PCP03209	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0305	90807408-PCP03210	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0305	90807408-PCP03211	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0305	90807408-PCP03212	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0305	90807408-PCP03213	90807408	B1	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0318	90807408-PCP03214	90807408	B1	AC/計度/一般/ 8.0元每度,AC/計度/尖峰/ 0元每度,AC/計度/離峰/ 0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0318	90807408-PCP03215	90807408	B1	AC/計度/一般/ 8.0元每度,AC/計度/尖峰/ 0元每度,AC/計度/離峰/ 0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0318	90807408-PCP03216	90807408	B1	AC/計度/一般/ 8.0元每度,AC/計度/尖峰/ 0元每度,AC/計度/離峰/ 0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0318	90807408-PCP03217	90807408	B1	AC/計度/一般/ 8.0元每度,AC/計度/尖峰/ 0元每度,AC/計度/離峰/ 0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0318	90807408-PCP03218	90807408	B1	AC/計度/一般/ 8.0元每度,AC/計度/尖峰/ 0元每度,AC/計度/離峰/ 0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0318	90807408-PCP03219	90807408	B1	AC/計度/一般/ 8.0元每度,AC/計度/尖峰/ 0元每度,AC/計度/離峰/ 0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	萬華區	TPE0318	90807408-PCP03220	90807408	B1	AC/計度/一般/ 8.0元每度,AC/計度/尖峰/ 0元每度,AC/計度/離峰/ 0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1099	94175832-P5259244caf19	94175832	B1	計分/1.1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1099	94175832-P572c70e1a22d	94175832	B1	計分/1.1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1099	94175832-P9aadad028673	94175832	B1	計分/1.1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1099	94175832-Pacd82942716b	94175832	B1	計分/1.1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1099	94175832-Pb32a49b80bc4	94175832	B1	計分/1.1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1099	94175832-Pf15e2af7958c	94175832	B1	計分/1.1 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1195	90807408-PCP05360	90807408	B2	AC/計度/一般/ 8.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1195	90807408-PCP05361	90807408	B2	AC/計度/一般/ 8.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1195	90807408-PCP05362	90807408	B2	AC/計度/一般/ 8.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1195	90807408-PCP05363	90807408	B2	AC/計度/一般/ 8.8000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1195	90807408-PCP05364	90807408	B2	AC/計度/一般/ 8.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1195	90807408-PCP05365	90807408	B2	AC/計度/一般/ 8.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1195	90807408-PCP05366	90807408	B2	AC/計度/一般/ 8.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1195	90807408-PCP05367	90807408	B2	AC/計度/一般/ 8.8000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1715	28007736-PFUSN004001	28007736	1	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0311	94175832-P22fbd5d4fe02	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0311	94175832-Pa2a97c8ff62e	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0812	97329493-PB11CE2508033	97329493	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0065	12681939-PPSS_IC0308_01	12681939	1	計度 /固定 /10元每度		{"Unknown": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0065	12681939-PPSS_IC0308_02	12681939	1	計度 /固定 /10元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0065	12681939-PPSS_IC0308_03	12681939	1	計度 /固定 /10元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0323TYTW00085	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0323TYTW00087	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0323TYTW00089	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0323TYTW00091	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0323TYTW00092	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0323TYTW00093	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0323TYTW00096	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0323TYTW00097	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0323TYTW00101	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0324TYTW00105	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0324TYTW00115	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0324TYTW00116	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0324TYTW00127	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0139	50965513-PA0324TYTW00130	50965513	2	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0270	76303216-P0078	76303216	B2	計度/固定/7元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0270	76303216-P0079	76303216	B2	計度/固定/7元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0270	76303216-P0080	76303216	B2	計度/固定/7元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0270	76303216-P0081	76303216	B2	計度/固定/7元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0270	76303216-P0082	76303216	B2	計度/固定/7元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0270	76303216-P0083	76303216	B2	計度/固定/7元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1081	94175832-P519f718134a2	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1081	94175832-P8a311ddd886c	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1081	94175832-Pae0d47b8e5dd	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1081	94175832-Pd5b53dc52da9	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1650	93161281-PB11CB2501001	93161281	1	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1650	93161281-PB11CE2409047	93161281	1	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1650	93161281-PB11CE2409054	93161281	1	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0944	94175832-P49c79cb1adac	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0944	94175832-Pcf89bf1a6934	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0097	85051710-P1301	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0097	85051710-P1443	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0206	85051710-P1303	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0206	85051710-P1445	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0726	85051710-P1304	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0726	85051710-P1446	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0591	85051710-P1305	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0591	85051710-P1447	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0610	85051710-P1306	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0610	85051710-P1448	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0479	85051710-P1310	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0479	85051710-P1311	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0479	85051710-P1452	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0121	85051710-P1312	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0121	85051710-P1453	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0128	28007736-PGOWN002001	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0128	28007736-PGOWN002002	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0128	28007736-PGOWN002003	28007736	B2	計度/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1589	52693448-P0143	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1589	52693448-P0144	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1589	52693448-P0145	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1589	52693448-P0146	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1589	52693448-P0147	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1589	52693448-P0148	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1336	88390637-PB11CE2507013	88390637	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1336	88390637-PB11CE2507015	88390637	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0739	50965513-PA0323TYTW00082	50965513	B1	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0739	50965513-PA0324TYTW00102	50965513	B1	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0739	50965513-PA0324TYTW00125	50965513	B1	計度/00:00-24:00/每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0840	90807408-PCP03528	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0840	90807408-PCP03529	90807408	B1	AC/計度/一般/ 8.000元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0840	90807408-PCP03530	90807408	B1	AC/計度/一般/ 8.000元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1148	52693448-P0041	52693448	B1	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1148	52693448-P0042	52693448	B1	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1148	52693448-P0043	52693448	B1	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1148	52693448-P0044	52693448	B1	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1411	52693448-P0123	52693448	B1	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1411	52693448-P0124	52693448	B1	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1411	52693448-P0125	52693448	B1	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0835	85051710-P1268	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0153	53953738-P651	53953738	3	計度/尖峰/09:00-23:59/10.00 元每度, 計度/尖峰/06:00-11:00/10.00 元每度, 計度/尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/8.00 元每度,計度/離峰/23:59-06:00/8.00 元每度, 計度/離峰/11:00-14:00/8.00 元每度, 計度/半尖峰/09:00-23:59/8.00 元每度, 計度/半尖峰/06:00-11:00/8.00 元每度, 計度/半尖峰/14:00-23:59/8.00 元每		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1164	52693448-P0126	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1164	52693448-P0127	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1164	52693448-P0128	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1164	52693448-P0129	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1164	52693448-P0130	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1164	52693448-P0131	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1164	52693448-P0132	52693448	B2	計度/正常/00:00-24:00/8元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0232	85051710-P1302	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0232	85051710-P1444	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0080	85051710-P1307	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0080	85051710-P1449	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0379	85051710-P1313	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0379	85051710-P1314	85051710	1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0379	85051710-P1454	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0379	85051710-P1455	85051710	1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1463	50965513-PA0323TYTW00034	50965513	B1	計度/00:00-24:00/每度10元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1676	90807408-PCP02977	90807408	B1	AC/計度/一般/ 7.0元每度,AC/計度/尖峰/ 7.0元每度,AC/計度/離峰/ 7.0元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE1676	90807408-PCP02978	90807408	B1	AC/計度/一般/ 7.0元每度,AC/計度/尖峰/ 7.0元每度,AC/計度/離峰/ 7.0元每度		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0230	85051710-P1239	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0230	85051710-P1240	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0230	85051710-P1241	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0230	85051710-P1242	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0230	85051710-P1389	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0230	85051710-P1390	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0230	85051710-P1391	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0230	85051710-P1392	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0108	85051710-P1243	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0108	85051710-P1244	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0108	85051710-P1245	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0108	85051710-P1246	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0108	85051710-P1247	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0108	85051710-P1248	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0108	85051710-P1393	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0108	85051710-P1394	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0108	85051710-P1395	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0108	85051710-P1396	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0108	85051710-P1397	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0334	85051710-P1249	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0334	85051710-P1250	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0334	85051710-P1251	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0334	85051710-P1252	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0334	85051710-P1253	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0334	85051710-P1398	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0334	85051710-P1399	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0334	85051710-P1400	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0334	85051710-P1401	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0835	85051710-P1266	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0835	85051710-P1267	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0835	85051710-P1413	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0835	85051710-P1414	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	文山區	TPE0835	85051710-P1415	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0816	85051710-P1254	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0816	85051710-P1255	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0816	85051710-P1256	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0816	85051710-P1402	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0816	85051710-P1403	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0816	85051710-P1404	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0848	85051710-P1257	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0848	85051710-P1258	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0848	85051710-P1259	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0848	85051710-P1405	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0848	85051710-P1406	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0848	85051710-P1407	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0567	85051710-P1260	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0567	85051710-P1261	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0567	85051710-P1408	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	信義區	TPE0567	85051710-P1409	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0926	85051710-P1220	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0926	85051710-P1221	85051710	B1	計度/每度8.00元		{"Mennekes_Type2": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0926	85051710-P1222	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0926	85051710-P1374	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0926	85051710-P1375	85051710	B1	計度/每度8.00元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1888	28652185-PTECH87	28652185	B2	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1888	28652185-PTECH88	28652185	B2	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1888	28652185-PTECH89	28652185	B2	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE1888	28652185-PTECH90	28652185	B2	慢充：計度/固定/8.00元每度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	士林區	TPE1916	00655165-PB11CB2506003	00655165	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	大安區	TPE0976	97329493-PB11CE2508013	97329493	1F	慢充每度8元		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	28371994-STP4900001	28371994-PTP4900001	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	28371994-STP4900001	28371994-PTP4900002	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	28371994-STP4900001	28371994-PTP4900003	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	28371994-STP4900001	28371994-PTP4900004	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	28371994-STP4900001	28371994-PTP4900005	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	28371994-STP4900001	28371994-PTP4900006	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	28371994-STP4900001	28371994-PTP4900007	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	28371994-STP4900001	28371994-PTP4900009	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
臺北市	松山區	28371994-STP4900001	28371994-PTP4900008	28371994	B1	計時/每日/5元每1度		{"J1772_Type1": 1}	2026-05-01 01:00:08+00
新北市	永和區	34104124-S01	34104124-PTHPS01	34104124	B1	每度8元		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	34104124-S01	34104124-PTHPS02	34104124	B1	每度8元		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	42861108-S17090	42861108-PAC17090001	42861108	B3	免費		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	42861108-S17090	42861108-PAC17090002	42861108	B3	0		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	42861108-S17090	42861108-PAC17090003	42861108	B3	0		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	42861108-S17090	42861108-PAC17090004	42861108	B3	0		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	42861108-S17090	42861108-PAC17090005	42861108	B3	0		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	42861108-S17090	42861108-PAC17090006	42861108	B3	0		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	54363149-Ss1n0	54363149-P3336011	54363149	B1	60元每小時		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	54363149-Ss1n0	54363149-P3336012	54363149	B1	60元分小時		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	70553757-S0001	55762636-PTQNP001	55762636	1F	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	70553757-S0001	70553757-P0001	70553757	1	計度/固定/10元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	54710871-S0001	54710871-P0001	54710871	B1	計度固定/7.5元每度		{"J1772_Type1": 10}	2026-05-02 14:10:16+00
新北市	新莊區	54710871-S0001	54710871-P0002	54710871	B1	計度固定/7.5元每度		{"J1772_Type1": 10}	2026-05-02 14:10:16+00
新北市	新莊區	54710871-S0001	54710871-P0003	54710871	B1	計度固定/7.5元每度		{"J1772_Type1": 10}	2026-05-02 14:10:16+00
新北市	新莊區	54710871-S0001	54710871-P0004	54710871	B1	計度固定/7.5元每度		{"J1772_Type1": 10}	2026-05-02 14:10:16+00
新北市	新莊區	54710871-S0001	54710871-P0005	54710871	B1	計度固定/7.5元每度		{"J1772_Type1": 10}	2026-05-02 14:10:16+00
新北市	新莊區	54710871-S0001	54710871-P0006	54710871	B1	計度固定/7.5元每度		{"J1772_Type1": 10}	2026-05-02 14:10:16+00
新北市	新莊區	54710871-S0001	54710871-P0007	54710871	B1	計度固定/7.5元每度		{"J1772_Type1": 10}	2026-05-02 14:10:16+00
新北市	新莊區	54710871-S0001	54710871-P0008	54710871	B1	計度固定/7.5元每度		{"J1772_Type1": 10}	2026-05-02 14:10:16+00
新北市	新莊區	54710871-S0001	54710871-P0009	54710871	B1	計度固定/7.5元每度		{"J1772_Type1": 10}	2026-05-02 14:10:16+00
新北市	新莊區	54710871-S0001	54710871-P0010	54710871	B1	計度固定/7.5元每度		{"J1772_Type1": 10}	2026-05-02 14:10:16+00
新北市	林口區	90016138-SF001	90016138-PFA01	90016138	B1	計度/固定/10元每度	充電椿為J1772慢充椿AC7kW，CCS2/TYPE2/TPC車款，可自行使用轉經UL/CE認證轉接頭使用。	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90016138-SF001	90016138-PFA02	90016138	B1	計度/固定/10元每度	充電椿為J1772慢充椿AC7kW，CCS2/TYPE2/TPC車款，可自行使用轉經UL/CE認證轉接頭使用。	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90016138-S643927b1	90016138-PMSIXP01232300022	90016138	B1	計度/平日/00:00-23:59/8元每度，計度/假日/00:00-23:59/9元每度	充電椿為AC慢充13kW單槍J1772，只可同時為一台車充電，CCS2/TYPE2/TPC車款，可自行使用經UL/CE認證轉接頭使用。	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90016138-S643927b1	90016138-PMSIXP01232300023	90016138	B1	計度/平日/00:00-23:59/8元每度，計度/假日/00:00-23:59/9元每度	充電椿為AC慢充13kW單槍J1772，只可同時為一台車充電，CCS2/TYPE2/TPC車款，可自行使用經UL/CE認證轉接頭使用。	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90016138-S643927b1	90016138-PMSIXP01232300024	90016138	B1	計度/平日/00:00-23:59/8元每度，計度/假日/00:00-23:59/9元每度	充電椿為AC慢充13kW單槍J1772，只可同時為一台車充電，CCS2/TYPE2/TPC車款，可自行使用經UL/CE認證轉接頭使用。	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P497530	94128120	B4	週日/固定/12.5000元(每度),週一/固定/12.5000元(每度),週二/固定/12.5000元(每度),週三/固定/12.5000元(每度),週四/固定/12.5000元(每度),週五/固定/12.5000元(每度),週六/固定/12.5000元(每度)		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P933995	94128120	B4	週日/固定/12.5000元(每度),週一/固定/12.5000元(每度),週二/固定/12.5000元(每度),週三/固定/12.5000元(每度),週四/固定/12.5000元(每度),週五/固定/12.5000元(每度),週六/固定/12.5000元(每度)		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P994823	94128120	B4	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P445826	94128120	B4	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P885026	94128120	B4	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P206044	94128120	B4	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P331762	94128120	B3	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P387868	94128120	B3	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P277833	94128120	B3	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P111269	94128120	B3	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P528544	94128120	B3	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P627317	94128120	B3	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P318646	94128120	B3	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02810	90807408-PCP03824	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94128120-S0004121	94128120-P341423	94128120	B4	週日/固定/7.5000元(每度),週一/固定/7.5000元(每度),週二/固定/7.5000元(每度),週三/固定/7.5000元(每度),週四/固定/7.5000元(每度),週五/固定/7.5000元(每度),週六/固定/7.5000元(每度)		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	中和區	94128120-S0004120	94128120-P271205	94128120	B1	週日/固定/7.0000元(每度),週一/固定/7.0000元(每度),週二/固定/7.0000元(每度),週三/固定/7.0000元(每度),週四/固定/7.0000元(每度),週五/固定/7.0000元(每度),週六/固定/7.0000元(每度)		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94128120-S0004120	94128120-P892730	94128120	B1	週日/固定/7.0000元(每度),週一/固定/7.0000元(每度),週二/固定/7.0000元(每度),週三/固定/7.0000元(每度),週四/固定/7.0000元(每度),週五/固定/7.0000元(每度),週六/固定/7.0000元(每度)		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94273051-S2gpG2Tp	94273051-P01nQttw	94273051	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94273051-S2gpG2Tp	94273051-P3nuAkas	94273051	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94273051-S2gpG2Tp	94273051-P4KDJsFZ	94273051	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	93519232-S0010	93519232-P0010	93519232	B2	計度/固定/10 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	37759379-SB0021	37759379-PB0021_1	37759379	B1	8		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	37759379-SB0021	37759379-PB0021_2	37759379	B1	8		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	瑞芳區	60225577-SA0694011	60225577-PA0694011_1	60225577	1F	0		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91887251-SA040601	91887251-PA040601_4	91887251	B3	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91887251-SA040601	91887251-PA040601_5	91887251	B3	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91887251-SA040601	91887251-PA040601_6	91887251	B3	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91887251-SA040601	91887251-PA040601_9	91887251	B3	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91887251-SA040601	91887251-PA040601_8	91887251	B3	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91887251-SA040601	91887251-PA040601_10	91887251	B3	計度/固定/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91903689-SA040701	91903689-PA040701_1	91903689	1F	計度: 8元/每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91903689-SA040701	91903689-PA040701_2	91903689	1F	計度: 8元/每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91903689-SA040701	91903689-PA040701_3	91903689	1F	計度: 8元/每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91903689-SA040701	91903689-PA040701_4	91903689	1F	計度: 8元/每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91903689-SA040701	91903689-PA040701_6	91903689	1F	計度: 8元/每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	91903689-SA040701	91903689-PA040701_7	91903689	1F	計度: 8元/每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	97179430-S162	97179430-PT0655	97179430	B4	計度 /固定 /12元 DC每度,計度 /固定 /8.5元 AC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	97179430-S162	97179430-PT0627	97179430	B4	計度 /固定 /12元 DC每度,計度 /固定 /8.5元 AC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	97179430-S162	97179430-PT0626	97179430	B4	計度 /固定 /12元 DC每度,計度 /固定 /8.5元 AC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	97179430-S162	97179430-PT0628	97179430	B4	計度 /固定 /12元 DC每度,計度 /固定 /8.5元 AC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	97179430-S162	97179430-P00029	97179430	B4	計度 /固定 /12元 DC每度,計度 /固定 /8.5元 AC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	97179430-S162	97179430-PT0364	97179430	B4	計度 /固定 /12元 DC每度,計度 /固定 /8.5元 AC每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	97179430-S162	97179430-P00030	97179430	B4	計度 /固定 /12元 DC每度,計度 /固定 /8.5元 AC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	97179430-S162	97179430-PT0376	97179430	B4	計度 /固定 /12元 DC每度,計度 /固定 /8.5元 AC每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	97179430-S161	97179430-PT0545	97179430	B1	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	97179430-S161	97179430-PT0544	97179430	B1	計度 /固定 /12元 DC每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	土城區	28114216-S124	28114216-PC2450A001A0	28114216	B1	計度/固定/10.50元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	土城區	28114216-S124	28114216-PC2450A002A0	28114216	B1	計度/固定/10.50元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三重區	28114216-S184	28114216-PC2538A009A1	28114216	B2	計度/固定/10.50元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三重區	28114216-S184	28114216-PC2538A010A1	28114216	B2	計度/固定/10.50元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	林口區	85051710-S471	85051710-P751	85051710	B2	計時/每1分鐘0.93元		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	85051710-S471	85051710-P752	85051710	B2	計時/每1分鐘0.93元		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	85051710-S471	85051710-P753	85051710	B2	計時/每1分鐘0.93元		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	85051710-S471	85051710-P754	85051710	B2	計時/每1分鐘0.93元		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	85051710-S471	85051710-P755	85051710	B2	計時/每1分鐘0.93元		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	85051710-S471	85051710-P756	85051710	B2	計時/每1分鐘0.93元		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SMRTHL0001	28652185-PMRTHL01	28652185	1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	85051710-S639	85051710-P1874	85051710	1F	○星晴電價(非夏季):週一至週五21:00〜隔日14:59、週六00:00〜06:59,每度6.5元○尖峰費率(非夏季):週一至週五15:00〜20:59,每度13.2元<br>○假日費費率(週六週日與國定假日):假日首日00:00〜06:59,適用星晴電價,其餘採假日費率每度8.4元計算<br>○車廠優惠費率方案與上述優惠共享&nbsp;<br><br>「啟動前請確認車輛已到位並完成插槍。若因誤觸啟動導致非本人車輛充電，相關扣費恕不退還。」		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	85051710-S639	85051710-P1875	85051710	1F	○星晴電價(非夏季):週一至週五21:00〜隔日14:59、週六00:00〜06:59,每度6.5元○尖峰費率(非夏季):週一至週五15:00〜20:59,每度13.2元<br>○假日費費率(週六週日與國定假日):假日首日00:00〜06:59,適用星晴電價,其餘採假日費率每度8.4元計算<br>○車廠優惠費率方案與上述優惠共享&nbsp;<br><br>「啟動前請確認車輛已到位並完成插槍。若因誤觸啟動導致非本人車輛充電，相關扣費恕不退還。」		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	33029464-STP6820001	33029464-PTP6820001	33029464	B1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	33029464-STP6820001	33029464-PTP6820002	33029464	B1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	33029464-STP6640001	33029464-PTP6640001	33029464	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	33029464-STP6640001	33029464-PTP6640002	33029464	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	33029464-STP6640001	33029464-PTP6640003	33029464	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	33029464-STP6640001	33029464-PTP6640004	33029464	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	33029464-STP6640001	33029464-PTP6640005	33029464	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	33029464-STP6640001	33029464-PTP6640006	33029464	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630001	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630002	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630003	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630004	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630005	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630006	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630007	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630008	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630009	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630010	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630012	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	28371994-STP7630001	28371994-PTP7630011	28371994	1F	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	28371994-STP4370001	28371994-PTP4370001	28371994	B1	計度/固定/5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	五股區	28007736-S049	28007736-PAPAL009001	28007736	1	計分/0.9元每分	使用APP確認按壓開始充電功能鈕後再插上充電槍	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	28007736-S051	28007736-PAPAL010001	28007736	1	計分/0.9元每分	使用APP確認按壓開始充電功能鈕後再插上充電槍	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-Pd413636d-be65-44cc-84c5-ccf2e25583c6	42861108	P1	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	汐止區	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P021b25e8-b1c9-440a-b3a4-bbc39493c2f6	42861108	P1	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	汐止區	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-Pfeddeb9f-e740-490b-a205-af42e8a5fdfe	42861108	P1	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P92aa231f-d530-42ef-abde-81924a536691	42861108	P1	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P60f80946-5deb-44fc-bab9-1011c996235f	42861108	P1	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P94d68dcd-0b8e-428c-9140-dd0abde6ee4a	42861108	P1	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P13706e1b-c862-4d71-b7cd-286452c8d953	42861108	P1	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-Pf0d991a6-f3d1-4a5f-8079-0f4a768f2669	42861108	P1	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	42861108-P47e8bfd6-ef86-4d7e-83ed-1e0e5576e936	42861108	P1	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P8866fe95-3bdb-460c-a235-3f9fcba65590	42861108	6	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P563a554c-22f2-46b0-bb15-f28ec1bdb83d	42861108	6	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-Pbbfd1ab7-30a0-4ed9-9cc5-d2cc4f249993	42861108	6	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-Pad86a9ec-9a3a-4d3e-b919-933a54af7e7c	42861108	6	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P54b93bd8-c22a-4239-b000-069551589620	42861108	6	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P4f9e5796-a4cd-4d3d-9c78-a6b32aedca93	42861108	6	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-Pec1b6a70-e1ba-4864-b81e-70642a42fdbb	42861108	6	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	42861108-P6ee524a7-49a6-4d86-8372-25c80bd3319c	42861108	6	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	新店區	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P319f8be0-44d4-44d9-8a2f-a65294690113	42861108	B2	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	新店區	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P372aac2f-ec4e-47ff-8cdf-07a3f5341f5c	42861108	B2	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	新店區	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P14c97ecf-6821-442e-af63-3c7b44eb88c2	42861108	B2	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	新店區	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	42861108-P29723d46-e090-4ab5-877e-47b05b38d441	42861108	B2	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分		{"CCCS2": 1, "Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	土城區	42861108-Sbe38b430-6d41-40e7-bc9d-d0f913b1f36a	42861108-P389453be-0c9c-4c5a-ab7d-01decfa3bc16	42861108	B3	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-12:00/8 元每度計度/一般時段/12:00-20:00/10 元每度計度/離峰/20:00-00:00/9 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	土城區	42861108-Sbe38b430-6d41-40e7-bc9d-d0f913b1f36a	42861108-Pf80bf745-e0be-4c51-b647-77d0b511df7e	42861108	B3	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-12:00/8 元每度計度/一般時段/12:00-20:00/10 元每度計度/離峰/20:00-00:00/9 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	土城區	42861108-Sbe38b430-6d41-40e7-bc9d-d0f913b1f36a	42861108-P49e5c042-7ece-4c34-9cef-889774b7a315	42861108	B3	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-12:00/8 元每度計度/一般時段/12:00-20:00/10 元每度計度/離峰/20:00-00:00/9 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	土城區	42861108-Sbe38b430-6d41-40e7-bc9d-d0f913b1f36a	42861108-P1b326536-20b8-40be-8088-948ca9e0f15d	42861108	B3	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-12:00/8 元每度計度/一般時段/12:00-20:00/10 元每度計度/離峰/20:00-00:00/9 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-Pcb281b35-0680-4a29-82e1-0230c1461f86	42861108	1F	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-Pc26555c9-0bbe-43ae-af6b-2e0cb68b001d	42861108	1F	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-Pc1164e2a-eb23-45e9-8fa3-c09b52d3a1e0	42861108	1F	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-P80e510be-1f0a-4021-8bc7-e0704469fef0	42861108	1F	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-P76b2db19-ca36-44c2-a688-7b3dcb3f8551	42861108	1F	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	42861108-P0d0a8c8d-983f-4290-8902-0da867769a09	42861108	1F	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	淡水區	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-Pd7f4a81f-7866-4ec9-b390-d92dc47b7be8	42861108	B1	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-15:00/8 元每度計度/尖峰/15:00-22:00/13 元每度計度/離峰/22:00-00:00/8 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-Pec216c53-6306-419d-88ab-11b99a42d8f2	42861108	B1	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-15:00/8 元每度計度/尖峰/15:00-22:00/13 元每度計度/離峰/22:00-00:00/8 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	淡水區	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P9b6abcf0-6ad1-4abf-8512-c9c626f7a5c7	42861108	B1	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-15:00/8 元每度計度/尖峰/15:00-22:00/13 元每度計度/離峰/22:00-00:00/8 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P4d7a2b81-2ec3-424e-b650-c0a06d2d9e77	42861108	B1	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-15:00/8 元每度計度/尖峰/15:00-22:00/13 元每度計度/離峰/22:00-00:00/8 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	淡水區	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P88a37fe6-90bd-4724-a936-8166fe3aa870	42861108	B1	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-15:00/8 元每度計度/尖峰/15:00-22:00/13 元每度計度/離峰/22:00-00:00/8 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	淡水區	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P92ce0825-b0b7-4d7a-8b1d-0608e12b49a9	42861108	B1	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-15:00/8 元每度計度/尖峰/15:00-22:00/13 元每度計度/離峰/22:00-00:00/8 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P8fd124d1-3495-4515-92e9-1748a5accb2b	42861108	B1	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-15:00/8 元每度計度/尖峰/15:00-22:00/13 元每度計度/離峰/22:00-00:00/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P428aba14-f7b5-4597-8e12-94f35fa5af38	42861108	B1	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-15:00/8 元每度計度/尖峰/15:00-22:00/13 元每度計度/離峰/22:00-00:00/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-Pbda10cb6-04fe-4f8d-8d40-3ccb22b6376f	42861108	B1	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-15:00/8 元每度計度/尖峰/15:00-22:00/13 元每度計度/離峰/22:00-00:00/8 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	淡水區	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	42861108-P5cdff24b-b160-45ae-96ba-41f4689ded0e	42861108	B1	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-15:00/8 元每度計度/尖峰/15:00-22:00/13 元每度計度/離峰/22:00-00:00/8 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	新莊區	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P08d67c7e-4d37-4fea-8c6d-d2dfa9f5e08d	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P32c58ea8-6561-432a-a9d0-ceed3b69f752	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P21eb155b-34aa-4300-b325-697a52486a33	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P924026a9-e2a5-42e9-873a-0ff6dc04d18f	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	新莊區	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P5d2f77a5-e1e7-458f-bb12-a6b1598e2b51	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	42861108-P4fa2e589-212f-4b46-be12-58a9d06dd9c4	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Paeb44428-c399-4827-ad77-18cb09d2caf9	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Pd6c621db-0335-4305-9013-4cccde695983	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Pd3ea0f21-1476-4087-9967-abcbe64e1bd0	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Pbb325273-1757-4122-8846-7013ff99a196	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-P504ccc86-8f1b-45d4-914b-c1730e23328d	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Pc597b5e3-7a0a-4c4b-bf3d-49d0b11951dd	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-P4be4a53c-bd26-468a-8fed-f4efac313c6d	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-P44dd1450-4086-4572-85d7-99d3d616797d	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	42861108-Pb7bb5e80-c2ad-4125-a7d6-0329b7ef49ab	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	42861108-S90b04491-49d2-4010-b5f5-30dd08d88254	42861108-P00efc985-2d8e-4c23-bb97-323ba11708aa	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	42861108-S90b04491-49d2-4010-b5f5-30dd08d88254	42861108-P913e8708-3bb3-4c85-a22d-9c0a25e8adad	42861108	1F	費用詳情請查詢TESLA站點		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	林口區	42861108-S90b04491-49d2-4010-b5f5-30dd08d88254	42861108-P62c5b17d-1e84-484b-9b37-e12f66137b31	42861108	1F	費用詳情請查詢TESLA站點		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	石門區	42861108-S7cb16f34-2913-4db7-bc2f-a6ba16f52005	42861108-Pf1d69031-6c55-4bb7-b70a-5a95da319916	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	石門區	42861108-S7cb16f34-2913-4db7-bc2f-a6ba16f52005	42861108-P4f15f017-4241-4224-8e26-4cb6f3c40fe0	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	石門區	42861108-S7cb16f34-2913-4db7-bc2f-a6ba16f52005	42861108-P0531c9f1-bbba-4dcc-9ff0-343f4775bec2	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	烏來區	42861108-S01342a10-aa64-4f90-ae30-1b8d7d3fcc86	42861108-Pc3e22455-10a6-4734-b926-740ec56537f4	42861108	1F	費用詳情請查詢TESLA站點		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	烏來區	42861108-S01342a10-aa64-4f90-ae30-1b8d7d3fcc86	42861108-P9fd24641-b97e-4274-99ee-9970865a596d	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	烏來區	42861108-S01342a10-aa64-4f90-ae30-1b8d7d3fcc86	42861108-Pcab4f7cf-74a8-4d88-af35-279432ffa627	42861108	1F	費用詳情請查詢TESLA站點		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S852a2236-52bc-4366-aa9e-1552330789ac	42861108-Pd3b5ae35-b8fc-439b-9ff0-1c3a54224af0	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S852a2236-52bc-4366-aa9e-1552330789ac	42861108-P6e5f55a5-8adf-40d9-8039-86dc02224694	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S852a2236-52bc-4366-aa9e-1552330789ac	42861108-Pb1a02e92-1538-4586-978a-ac77912a7ef4	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S852a2236-52bc-4366-aa9e-1552330789ac	42861108-P634bb11a-37c0-4df3-97c4-356dc1aa5bec	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P09b4777a-a84a-4cb1-878b-d2a027ae768e	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-Pc7b4eab2-1474-4b67-b98d-1c6a2e63aff3	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	三峽區	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P5fc77dcc-c690-4398-8f2b-318964d0ced8	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P12fc9180-5c55-4c49-9753-5570d5f5c7dd	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P34bf43ad-60ae-4369-8b12-c2b72988b191	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P8c93b373-6cf9-4cc4-b512-53cc7ccb8889	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P68aeea36-7699-40b2-829c-7140f0dea995	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-P080621bd-2325-429c-868c-529ef52fa0e0	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	三峽區	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	42861108-Pb13ca4f2-6234-4b49-96d7-9da7e38fa823	42861108	1F	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	42861108-S663cbaf2-0ad2-43cf-89de-d05bfe391308	42861108-P167b3a34-39d8-419c-8c61-f4f1be0654ad	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	42861108-S663cbaf2-0ad2-43cf-89de-d05bfe391308	42861108-Pc4e6df70-44b5-4896-aacd-bdb2005ea1f7	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	42861108-S663cbaf2-0ad2-43cf-89de-d05bfe391308	42861108-Pbe922fa5-de73-4a93-8c7c-c4eb0a4db117	42861108	1F	費用詳情請查詢TESLA站點		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	42861108-S663cbaf2-0ad2-43cf-89de-d05bfe391308	42861108-P03ed4f2c-4e7f-4eb1-b6a8-d48cca1ce9f5	42861108	1F	費用詳情請查詢TESLA站點		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	林口區	42861108-S554815bb-24da-4ed1-8e6d-5aeb04c584c6	42861108-P032fa7af-4d3a-4da9-8b94-547d89fa15c4	42861108	B2	計度/一般時段/00:00-24:00/8 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	林口區	42861108-S554815bb-24da-4ed1-8e6d-5aeb04c584c6	42861108-P43fd0b27-4fe7-43f2-abd2-b5de724398b4	42861108	B2	計度/一般時段/00:00-24:00/8 元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	林口區	42861108-S554815bb-24da-4ed1-8e6d-5aeb04c584c6	42861108-P0728e216-3072-43d4-a29b-40055ef45040	42861108	B2	計度/一般時段/00:00-24:00/8 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	林口區	42861108-S554815bb-24da-4ed1-8e6d-5aeb04c584c6	42861108-P53c134e9-4443-471d-b34d-19509470ab57	42861108	B2	計度/一般時段/00:00-24:00/8 元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	八里區	42861108-Se3f94cf3-0acd-4ed4-a383-7d095af4e934	42861108-P80f6dc2d-cddd-40f7-888f-b44431a0e194	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	八里區	42861108-Se3f94cf3-0acd-4ed4-a383-7d095af4e934	42861108-P098633ab-4a7a-4624-bbb5-73646a190995	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	八里區	42861108-Se3f94cf3-0acd-4ed4-a383-7d095af4e934	42861108-P4edf898f-c5d7-48e9-8fce-dd84d1a5e2e0	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	八里區	42861108-Se3f94cf3-0acd-4ed4-a383-7d095af4e934	42861108-P203c19bb-e683-485c-a696-d516070dd988	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S5a4c664d-b9f1-4b87-b33a-51295d34979a	42861108-P422ac2a3-3f5c-4333-907f-1353625da413	42861108	1F	費用詳情請查詢TESLA站點		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	42861108-S5a4c664d-b9f1-4b87-b33a-51295d34979a	42861108-Pa65c0c5c-ad58-414f-9186-421e3e8898d8	42861108	1F	費用詳情請查詢TESLA站點		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	板橋區	28652185-SJIA001	28652185-PJIA001	28652185	1	計度/固定/0元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU001	28652185-PLINKOU228	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU001	28652185-PLINKOU229	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU001	28652185-PLINKOU230	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU001	28652185-PLINKOU231	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU001	28652185-PLINKOU232	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU001	28652185-PLINKOU233	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU001	28652185-PLINKOU234	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU002	28652185-PLINKOU187	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU002	28652185-PLINKOU188	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU002	28652185-PLINKOU189	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU002	28652185-PLINKOU190	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU002	28652185-PLINKOU191	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU002	28652185-PLINKOU192	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU003	28652185-PLINKOU116	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU003	28652185-PLINKOU117	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU003	28652185-PLINKOU118	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU003	28652185-PLINKOU195	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU003	28652185-PLINKOU196	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU003	28652185-PLINKOU197	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU003	28652185-PLINKOU198	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU004	28652185-PLINKOU274	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU004	28652185-PLINKOU277	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU004	28652185-PLINKOU278	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU004	28652185-PLINKOU279	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU004	28652185-PLINKOU280	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU004	28652185-PLINKOU281	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU004	28652185-PLINKOU282	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	28652185-SLINKOU004	28652185-PLINKOU283	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP137	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP138	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP139	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP140	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP141	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP142	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP143	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP144	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP145	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP146	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP156	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP157	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP158	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SXZPEP0001	28652185-PXZPEP159	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SMRTHL0001	28652185-PMRTHL02	28652185	1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SMRTHL0001	28652185-PMRTHL03	28652185	1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SMRTHL0001	28652185-PMRTHL04	28652185	1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SMRTHL0001	28652185-PMRTHL05	28652185	1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SBQTS0001	28652185-PBQTS2568	28652185	B2	計度/固定/9元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	28652185-SBQTS0001	28652185-PBQTS2569	28652185	B2	計度/固定/9元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	28652185-SMRTHS0001	28652185-PMRTHS61	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	28652185-SMRTHS0001	28652185-PMRTHS62	28652185	B1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	28652185-SMRTYN0001	28652185-PMRTYN01	28652185	1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	28652185-SMRTYN0001	28652185-PMRTYN02	28652185	1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	28652185-SMRTYN0001	28652185-PMRTYN03	28652185	1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	28652185-SMRTYN0001	28652185-PMRTYN04	28652185	1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	28652185-SMRTYN0001	28652185-PMRTYN05	28652185	1	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	28652185-SMRTDP0001	28652185-PMRTDP15	28652185	B2	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	28652185-SMRTDP0001	28652185-PMRTDP16	28652185	B2	計度/固定/8元每度 		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	83284334-S00001	83284334-P00001	83284334	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	83284334-S00001	83284334-P00002	83284334	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-P0ffa603de0f2	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-P410694a88d16	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-P4149d79f9c33	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-P545c362bddd4	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-P5845cd057279	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-P69c2e0719742	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-P8c59729dc965	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-P9044874c5e97	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-Pa10598be79fe	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-Pa1ba5b242f54	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-Pdad46d9f7732	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-Pdcffe3b62782	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-Pec337ba301bd	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	94175832-SUCF0279F048	94175832-Pf3d9fd86eb51	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-P03f44245dd31	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-P14b44f060d71	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-P15278b17b1cc	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-P2b1b165472ca	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-P31b6ad99f72b	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-P385f2956b781	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-P4eef2dc14411	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-P55d932d67aeb	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-P713f311b08f7	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-P872f484c8824	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-Pd5bf751af9b5	94175832	B1	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-Pdefafef6604c	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-Pf5b44c645f9c	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCF0233F039	94175832-Pff7ac2665694	94175832	B1	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	94175832-SUCG0178G001	94175832-P6fc713016ae7	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	94175832-SUCG0178G001	94175832-Pa4a875a144af	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	94175832-SUCG0178G001	94175832-Pd7564b71e918	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	94175832-SUCG0178G001	94175832-Pdc88c3561e5a	94175832	B1	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	94175832-SUCG0178G001	94175832-Pdcacb44383ca	94175832	B1	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-P119d346709e5	94175832	4	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-P24b692508de2	94175832	4	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-P2aea3155e72d	94175832	4	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-P589649f3facd	94175832	4	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-P5af2c94b32f7	94175832	4	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-P895e34dbae21	94175832	4	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-P8ef1c99577f2	94175832	4	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-P900d1d60444c	94175832	4	計度/8 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-P914e8afb908e	94175832	4	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-P9b48ae74ba8a	94175832	4	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-Pbc274f160fa7	94175832	4	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-Pd9b5cc03628c	94175832	4	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-Pf4b994897e3f	94175832	4	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCF0259F040	94175832-Pfc2557a5b741	94175832	4	計度/8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0078G002	94175832-P2f546f502467	94175832	6	計分/1 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0078G002	94175832-P6e8dbed1b096	94175832	6	計分/1 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0078G002	94175832-P7ebb65985f09	94175832	6	計分/1 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0078G002	94175832-Pbb8c2b67c543	94175832	6	計分/1 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0078G002	94175832-Pc99db7f915c9	94175832	6	計分/1 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0078G002	94175832-Pe39fa92e90f4	94175832	6	計分/1 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0233G002	94175832-P9005ed6b0449	94175832	B3	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0233G002	94175832-P956198aaf71b	94175832	B3	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0233G002	94175832-Pacdf04e0765c	94175832	B3	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0233G002	94175832-Pb22f26cabfeb	94175832	B3	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0233G002	94175832-Pb4a1311eca79	94175832	B3	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	94175832-SUCB0233G002	94175832-Pdd38ec619597	94175832	B3	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCG0015G001	94175832-Pa14cc67cc556	94175832	B2	計分/1.25 元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	94175832-SUCG0015G001	94175832-Peb0c8feed88e	94175832	B2	計分/1.25 元每分		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SACSD00069	90807408-PCP00485	90807408	B1	計度/固定/10元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SACSD00069	90807408-PCP00486	90807408	B1	計度/固定/10元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD00077	90807408-PCP01560	90807408	B5	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD00077	90807408-PCP01561	90807408	B5	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02403	90807408	3F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02404	90807408	3F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02405	90807408	3F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02406	90807408	3F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02407	90807408	3F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02408	90807408	3F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02409	90807408	3F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02410	90807408	3F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02411	90807408	3F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02412	90807408	3F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02413	90807408	3F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02414	90807408	3F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02415	90807408	3F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP02416	90807408	3F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP06086	90807408	3F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP06087	90807408	3F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP06088	90807408	3F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP06089	90807408	3F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP06090	90807408	3F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02391	90807408-PCP06091	90807408	3F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02634	90807408-PCP03195	90807408	B2	計度/固定/7.5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02634	90807408-PCP03196	90807408	B2	計度/固定/7.5元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02635	90807408-PCP03197	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02635	90807408-PCP03198	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02645	90807408-PCP03271	90807408	4F	計度/固定/7.5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02645	90807408-PCP03272	90807408	4F	計度/固定/7.5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02645	90807408-PCP03273	90807408	4F	計度/固定/7.5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02645	90807408-PCP03274	90807408	4F	計度/固定/7.5元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02645	90807408-PCP03275	90807408	4F	計度/固定/7.5元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02645	90807408-PCP03276	90807408	4F	計度/固定/7.5元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02645	90807408-PCP03277	90807408	4F	計度/固定/7.5元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD02685	90807408-PCP03427	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD02685	90807408-PCP03428	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02686	90807408-PCP03429	90807408	B1	免費		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02686	90807408-PCP03430	90807408	B1	免費		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02687	90807408-PCP03431	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02687	90807408-PCP03432	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02693	90807408-PCP03444	90807408	3F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02693	90807408-PCP03445	90807408	3F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02693	90807408-PCP03446	90807408	3F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03598	90807408	B1	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03599	90807408	B1	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03600	90807408	B1	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03601	90807408	B1	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03602	90807408	B1	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03603	90807408	4F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03604	90807408	4F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03605	90807408	4F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03606	90807408	4F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03607	90807408	4F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03608	90807408	4F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03609	90807408	4F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03610	90807408	4F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03611	90807408	4F	計度/固定/8.8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03612	90807408	4F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03613	90807408	4F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03614	90807408	4F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03615	90807408	4F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03616	90807408	4F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	五股區	90807408-SCSD02791	90807408-PCP05473	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03617	90807408	4F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03618	90807408	4F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03619	90807408	4F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02763	90807408-PCP03620	90807408	4F	計度/固定/8.8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02779	90807408-PCP03704	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02779	90807408-PCP03705	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02779	90807408-PCP04622	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02779	90807408-PCP04623	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02780	90807408-PCP03706	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02780	90807408-PCP03707	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02781	90807408-PCP03708	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02781	90807408-PCP03709	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02781	90807408-PCP03710	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02781	90807408-PCP03711	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02782	90807408-PCP03712	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02782	90807408-PCP03713	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02783	90807408-PCP03714	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02783	90807408-PCP03715	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02787	90807408-PCP03722	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02787	90807408-PCP03723	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02787	90807408-PCP05497	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02787	90807408-PCP05498	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02788	90807408-PCP03724	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02788	90807408-PCP03725	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02788	90807408-PCP05499	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02788	90807408-PCP05500	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02789	90807408-PCP03726	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02789	90807408-PCP03727	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02789	90807408-PCP05501	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02789	90807408-PCP05502	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02789	90807408-PCP05503	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02789	90807408-PCP05504	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02789	90807408-PCP05505	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD02790	90807408-PCP03728	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD02790	90807408-PCP03729	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD02790	90807408-PCP03730	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD02790	90807408-PCP03731	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD02790	90807408-PCP05457	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD02790	90807408-PCP05458	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD02790	90807408-PCP05459	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD02790	90807408-PCP05460	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD02790	90807408-PCP05461	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD02790	90807408-PCP05462	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD02790	90807408-PCP05463	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	五股區	90807408-SCSD02791	90807408-PCP03732	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	五股區	90807408-SCSD02791	90807408-PCP03733	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	五股區	90807408-SCSD02791	90807408-PCP03734	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	五股區	90807408-SCSD02791	90807408-PCP03735	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	五股區	90807408-SCSD02791	90807408-PCP05474	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90807408-SCSD02792	90807408-PCP03736	90807408	3F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90807408-SCSD02792	90807408-PCP03737	90807408	3F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90807408-SCSD02792	90807408-PCP03738	90807408	3F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90807408-SCSD02792	90807408-PCP03739	90807408	3F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90807408-SCSD02792	90807408-PCP05657	90807408	3F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90807408-SCSD02792	90807408-PCP05658	90807408	3F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90807408-SCSD02792	90807408-PCP05659	90807408	3F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90807408-SCSD02792	90807408-PCP05660	90807408	3F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02793	90807408-PCP03740	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02793	90807408-PCP03741	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02793	90807408-PCP05664	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02793	90807408-PCP05665	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02793	90807408-PCP05666	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02793	90807408-PCP05667	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02793	90807408-PCP05668	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02793	90807408-PCP05669	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02794	90807408-PCP03765	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02794	90807408-PCP03785	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02794	90807408-PCP05674	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02794	90807408-PCP05675	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02794	90807408-PCP05676	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02794	90807408-PCP05677	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02794	90807408-PCP05678	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02794	90807408-PCP05679	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02794	90807408-PCP05680	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02794	90807408-PCP05681	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	泰山區	90807408-SCSD02794	90807408-PCP05682	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	貢寮區	90807408-SCSD02802	90807408-PCP03804	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	貢寮區	90807408-SCSD02802	90807408-PCP03805	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD02803	90807408-PCP03806	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD02803	90807408-PCP03807	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD02803	90807408-PCP05683	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD02803	90807408-PCP05684	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD02803	90807408-PCP05685	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02804	90807408-PCP03808	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02804	90807408-PCP03809	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02804	90807408-PCP03810	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02804	90807408-PCP03811	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02804	90807408-PCP05705	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02804	90807408-PCP05706	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02804	90807408-PCP05707	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02804	90807408-PCP05708	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02804	90807408-PCP05709	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02804	90807408-PCP05710	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02804	90807408-PCP05711	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02809	90807408-PCP03822	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02809	90807408-PCP03823	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02810	90807408-PCP03825	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02810	90807408-PCP05506	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02810	90807408-PCP05507	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02810	90807408-PCP05508	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02810	90807408-PCP05509	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02811	90807408-PCP03826	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02811	90807408-PCP03827	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02811	90807408-PCP05510	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02811	90807408-PCP05511	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02811	90807408-PCP05512	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02812	90807408-PCP03828	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02812	90807408-PCP03829	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02812	90807408-PCP03830	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02812	90807408-PCP03831	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02812	90807408-PCP03832	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02812	90807408-PCP03833	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02812	90807408-PCP05475	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02812	90807408-PCP05476	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02812	90807408-PCP05477	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02812	90807408-PCP05478	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02812	90807408-PCP05479	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02813	90807408-PCP03834	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02813	90807408-PCP03835	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02814	90807408-PCP03836	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02814	90807408-PCP03837	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02814	90807408-PCP05841	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02815	90807408-PCP03838	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02815	90807408-PCP03839	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02815	90807408-PCP03840	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02815	90807408-PCP03841	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02815	90807408-PCP05723	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02815	90807408-PCP05724	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02815	90807408-PCP05725	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02815	90807408-PCP05726	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02815	90807408-PCP05727	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02816	90807408-PCP03842	90807408	3F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02816	90807408-PCP03843	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD02816	90807408-PCP05728	90807408	3F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02817	90807408-PCP03844	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02817	90807408-PCP03845	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02817	90807408-PCP03846	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02817	90807408-PCP03847	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02817	90807408-PCP03848	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02817	90807408-PCP03849	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02878	90807408-PCP04152	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02878	90807408-PCP04153	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02878	90807408-PCP05712	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02878	90807408-PCP05713	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02878	90807408-PCP05714	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02878	90807408-PCP05715	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02878	90807408-PCP05716	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02878	90807408-PCP05717	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02878	90807408-PCP05718	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02879	90807408-PCP04154	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02879	90807408-PCP04155	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02879	90807408-PCP05839	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02879	90807408-PCP05840	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02880	90807408-PCP04156	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02880	90807408-PCP04157	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02880	90807408-PCP05720	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02880	90807408-PCP05795	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02881	90807408-PCP04158	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02881	90807408-PCP04159	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02881	90807408-PCP05721	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02881	90807408-PCP05722	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02882	90807408-PCP04160	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02882	90807408-PCP04161	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02883	90807408-PCP04162	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02883	90807408-PCP04163	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02883	90807408-PCP04164	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02883	90807408-PCP04165	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02883	90807408-PCP04166	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02883	90807408-PCP04167	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02883	90807408-PCP05741	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	瑞芳區	90807408-SCSD02884	90807408-PCP04168	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	瑞芳區	90807408-SCSD02884	90807408-PCP04169	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	瑞芳區	90807408-SCSD02884	90807408-PCP05729	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	瑞芳區	90807408-SCSD02884	90807408-PCP05730	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	瑞芳區	90807408-SCSD02884	90807408-PCP05731	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	瑞芳區	90807408-SCSD02884	90807408-PCP05732	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	瑞芳區	90807408-SCSD02884	90807408-PCP05733	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02885	90807408-PCP04170	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02885	90807408-PCP04171	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02885	90807408-PCP05734	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02885	90807408-PCP05735	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02885	90807408-PCP05736	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02886	90807408-PCP04172	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02886	90807408-PCP04173	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02886	90807408-PCP04174	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02886	90807408-PCP04175	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02886	90807408-PCP05700	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02886	90807408-PCP05701	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02886	90807408-PCP05702	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02886	90807408-PCP05703	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02886	90807408-PCP05704	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02887	90807408-PCP04176	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02887	90807408-PCP04177	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02887	90807408-PCP05737	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02888	90807408-PCP04178	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02888	90807408-PCP04179	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02888	90807408-PCP05740	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02889	90807408-PCP04180	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02889	90807408-PCP04181	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02889	90807408-PCP05744	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02889	90807408-PCP05745	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02889	90807408-PCP05746	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02889	90807408-PCP05747	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02889	90807408-PCP05748	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02889	90807408-PCP05749	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02889	90807408-PCP05750	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02890	90807408-PCP04182	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02890	90807408-PCP04183	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02890	90807408-PCP04184	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02890	90807408-PCP04185	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02890	90807408-PCP04186	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02890	90807408-PCP04187	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02890	90807408-PCP05485	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02890	90807408-PCP05486	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02890	90807408-PCP05487	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02890	90807408-PCP05488	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三芝區	90807408-SCSD02891	90807408-PCP04188	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三芝區	90807408-SCSD02891	90807408-PCP04189	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三芝區	90807408-SCSD02891	90807408-PCP05764	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三芝區	90807408-SCSD02891	90807408-PCP05765	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三芝區	90807408-SCSD02891	90807408-PCP05766	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02892	90807408-PCP04190	90807408	B3	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02892	90807408-PCP04191	90807408	B3	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02892	90807408-PCP04192	90807408	B3	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02892	90807408-PCP04193	90807408	B3	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02893	90807408-PCP04194	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02893	90807408-PCP04195	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02893	90807408-PCP05770	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02893	90807408-PCP05771	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02893	90807408-PCP05772	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02894	90807408-PCP04196	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02894	90807408-PCP04197	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02894	90807408-PCP04198	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02894	90807408-PCP04199	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02895	90807408-PCP04200	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02895	90807408-PCP04201	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02895	90807408-PCP05653	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02895	90807408-PCP05654	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02895	90807408-PCP05655	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02895	90807408-PCP05656	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02896	90807408-PCP04202	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02896	90807408-PCP04203	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02896	90807408-PCP05524	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02896	90807408-PCP05525	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02896	90807408-PCP05526	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02897	90807408-PCP04219	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02897	90807408-PCP04220	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02898	90807408-PCP04204	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02898	90807408-PCP04205	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02898	90807408-PCP04206	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02898	90807408-PCP04207	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02898	90807408-PCP05645	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02898	90807408-PCP05646	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02898	90807408-PCP05647	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02898	90807408-PCP05648	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP04208	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP04209	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP04210	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP04211	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP04212	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP04213	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP04214	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP04215	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP04216	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP04217	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP04218	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP05636	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP05637	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP05638	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP05639	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02899	90807408-PCP05780	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02900	90807408-PCP04222	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02900	90807408-PCP04223	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02900	90807408-PCP05652	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02900	90807408-PCP05661	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02900	90807408-PCP05662	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02900	90807408-PCP05663	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02901	90807408-PCP04224	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02901	90807408-PCP05798	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02901	90807408-PCP05799	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02901	90807408-PCP05800	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02902	90807408-PCP04225	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02902	90807408-PCP04226	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02902	90807408-PCP05644	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02902	90807408-PCP05649	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02902	90807408-PCP05650	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02902	90807408-PCP05651	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02903	90807408-PCP04227	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02903	90807408-PCP04228	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02904	90807408-PCP04229	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02904	90807408-PCP05634	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02904	90807408-PCP05635	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02905	90807408-PCP04230	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02905	90807408-PCP04231	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02905	90807408-PCP05630	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02905	90807408-PCP05631	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02905	90807408-PCP05632	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02905	90807408-PCP05633	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02906	90807408-PCP04232	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02906	90807408-PCP05797	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02907	90807408-PCP04233	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02908	90807408-PCP04234	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02908	90807408-PCP04235	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02909	90807408-PCP04236	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02909	90807408-PCP04237	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	鶯歌區	90807408-SCSD02910	90807408-PCP04238	90807408	平面(北側)	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	鶯歌區	90807408-SCSD02910	90807408-PCP04239	90807408	平面(南側)	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	鶯歌區	90807408-SCSD02910	90807408-PCP05513	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	鶯歌區	90807408-SCSD02910	90807408-PCP05514	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02911	90807408-PCP04240	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02911	90807408-PCP04241	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02911	90807408-PCP04242	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02911	90807408-PCP05628	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02912	90807408-PCP04243	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02912	90807408-PCP04244	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02912	90807408-PCP04246	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02912	90807408-PCP04247	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02912	90807408-PCP04248	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02912	90807408-PCP04249	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02912	90807408-PCP04250	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02912	90807408-PCP04251	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02912	90807408-PCP04252	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02912	90807408-PCP04253	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02913	90807408-PCP04254	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02913	90807408-PCP04255	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02913	90807408-PCP04256	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02913	90807408-PCP05527	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02913	90807408-PCP05528	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02913	90807408-PCP05529	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02913	90807408-PCP05530	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02913	90807408-PCP05555	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02913	90807408-PCP05558	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02913	90807408-PCP05561	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02914	90807408-PCP04257	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02914	90807408-PCP04258	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02914	90807408-PCP05738	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02914	90807408-PCP05739	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02915	90807408-PCP04259	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02915	90807408-PCP04260	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02915	90807408-PCP04261	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02915	90807408-PCP04262	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02915	90807408-PCP05820	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02915	90807408-PCP05821	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三芝區	90807408-SCSD02916	90807408-PCP04263	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三芝區	90807408-SCSD02916	90807408-PCP04264	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三芝區	90807408-SCSD02916	90807408-PCP05743	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02917	90807408-PCP04265	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02917	90807408-PCP04266	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02917	90807408-PCP04267	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02917	90807408-PCP04268	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02918	90807408-PCP04269	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02918	90807408-PCP04270	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02918	90807408-PCP04271	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02918	90807408-PCP04272	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02918	90807408-PCP04273	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02918	90807408-PCP04274	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02918	90807408-PCP05827	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02918	90807408-PCP05828	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	深坑區	90807408-SCSD02919	90807408-PCP04275	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	深坑區	90807408-SCSD02919	90807408-PCP04276	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	深坑區	90807408-SCSD02919	90807408-PCP05792	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02920	90807408-PCP04277	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02920	90807408-PCP04278	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02920	90807408-PCP04279	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02920	90807408-PCP04280	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02920	90807408-PCP05865	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02920	90807408-PCP05866	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02921	90807408-PCP04281	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02921	90807408-PCP04282	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02921	90807408-PCP04283	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02921	90807408-PCP04284	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02922	90807408-PCP04285	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02922	90807408-PCP04286	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02922	90807408-PCP05531	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02922	90807408-PCP05591	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02922	90807408-PCP05594	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02922	90807408-PCP05600	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02922	90807408-PCP05602	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP04287	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP04288	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP04289	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP04290	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05562	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05563	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05564	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05569	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05570	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05571	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05574	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05575	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05578	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05579	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05582	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05583	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02923	90807408-PCP05584	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02924	90807408-PCP04291	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02924	90807408-PCP04292	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02924	90807408-PCP04293	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02925	90807408-PCP04294	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02925	90807408-PCP04295	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02925	90807408-PCP04296	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02926	90807408-PCP04297	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02926	90807408-PCP04298	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02926	90807408-PCP05603	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02926	90807408-PCP05608	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02927	90807408-PCP04299	90807408	4F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02927	90807408-PCP04300	90807408	4F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02927	90807408-PCP05610	90807408	4F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02928	90807408-PCP04301	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02928	90807408-PCP04302	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02928	90807408-PCP05611	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02928	90807408-PCP05613	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02928	90807408-PCP05614	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02930	90807408-PCP04303	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02930	90807408-PCP04304	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02930	90807408-PCP05617	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02930	90807408-PCP05622	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02930	90807408-PCP05623	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02931	90807408-PCP04305	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02931	90807408-PCP04306	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02931	90807408-PCP04307	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02931	90807408-PCP04309	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02931	90807408-PCP05629	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02932	90807408-PCP04310	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02932	90807408-PCP04311	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02932	90807408-PCP04312	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02932	90807408-PCP04313	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02932	90807408-PCP05491	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02932	90807408-PCP05492	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02932	90807408-PCP05493	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02932	90807408-PCP05494	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02932	90807408-PCP05495	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02932	90807408-PCP05496	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02933	90807408-PCP04314	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02933	90807408-PCP04315	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02933	90807408-PCP04316	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02933	90807408-PCP04317	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02933	90807408-PCP04318	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02933	90807408-PCP04319	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02933	90807408-PCP04320	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	坪林區	90807408-SCSD02934	90807408-PCP04321	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	坪林區	90807408-SCSD02934	90807408-PCP04322	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	坪林區	90807408-SCSD02934	90807408-PCP04323	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	坪林區	90807408-SCSD02934	90807408-PCP04324	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP04325	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP04326	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP04327	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP04328	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP05753	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP05754	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP05755	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP05756	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP05757	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP05758	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP05759	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02935	90807408-PCP05760	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02936	90807408-PCP04329	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02936	90807408-PCP04330	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02936	90807408-PCP05761	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02936	90807408-PCP05762	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02936	90807408-PCP05763	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02937	90807408-PCP04331	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02937	90807408-PCP04332	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02937	90807408-PCP05742	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02938	90807408-PCP04333	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02938	90807408-PCP04334	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02938	90807408-PCP04335	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02938	90807408-PCP04336	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02938	90807408-PCP05480	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02938	90807408-PCP05481	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02938	90807408-PCP05482	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02938	90807408-PCP05483	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02938	90807408-PCP05484	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02939	90807408-PCP04337	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02939	90807408-PCP04338	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02939	90807408-PCP04339	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02940	90807408-PCP04340	90807408	1F	浮動費率,,計度/離峰/00:00-11:00/8.4元每度,計度/一般/*11:01-23:59/11元每度		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	林口區	90807408-SCSD02940	90807408-PCP04341	90807408	1F	浮動費率,,計度/離峰/00:00-11:00/8.4元每度,計度/一般/*11:01-23:59/11元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02941	90807408-PCP04342	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02941	90807408-PCP04343	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02941	90807408-PCP04344	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02941	90807408-PCP04345	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP05811	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02941	90807408-PCP05751	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02941	90807408-PCP05752	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02942	90807408-PCP04346	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD02942	90807408-PCP04347	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	金山區	90807408-SCSD02943	90807408-PCP04348	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	金山區	90807408-SCSD02943	90807408-PCP04349	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	金山區	90807408-SCSD02943	90807408-PCP04350	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	金山區	90807408-SCSD02943	90807408-PCP04351	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	金山區	90807408-SCSD02943	90807408-PCP05767	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	金山區	90807408-SCSD02943	90807408-PCP05768	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	金山區	90807408-SCSD02943	90807408-PCP05769	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP04352	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP04353	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP04354	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP04355	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP04356	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP04357	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP04358	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP04359	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP05774	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP05777	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP05778	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02944	90807408-PCP05779	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP04360	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP04361	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP05781	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP05782	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP05783	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP05784	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP05785	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP05786	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP05787	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP05788	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP05789	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP05790	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02945	90807408-PCP05791	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02946	90807408-PCP04362	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02946	90807408-PCP04363	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02946	90807408-PCP04364	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02946	90807408-PCP04365	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02946	90807408-PCP05822	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02946	90807408-PCP05823	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP04366	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP04367	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP04368	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP04369	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP04370	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP04371	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP05812	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP05813	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP05814	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP05815	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP05816	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP05817	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP05818	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02947	90807408-PCP05819	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02948	90807408-PCP04372	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02948	90807408-PCP04373	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02948	90807408-PCP04374	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02948	90807408-PCP04375	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02948	90807408-PCP04376	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02948	90807408-PCP04377	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02948	90807408-PCP06137	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02948	90807408-PCP06138	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02948	90807408-PCP06139	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02948	90807408-PCP06140	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02948	90807408-PCP06141	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP04378	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP04379	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP04380	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP04381	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP05824	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP05829	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP05832	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP05833	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP05834	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP05835	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP05836	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP05837	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02949	90807408-PCP05838	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02950	90807408-PCP04382	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02950	90807408-PCP04383	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02950	90807408-PCP05825	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02950	90807408-PCP05826	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02951	90807408-PCP04384	90807408	4F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02951	90807408-PCP04385	90807408	4F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02951	90807408-PCP05830	90807408	4F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02951	90807408-PCP05831	90807408	4F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02952	90807408-PCP04386	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02952	90807408-PCP04387	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02952	90807408-PCP05860	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02952	90807408-PCP05861	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02952	90807408-PCP05862	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02952	90807408-PCP05863	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02952	90807408-PCP05864	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02953	90807408-PCP04388	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02953	90807408-PCP04389	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02953	90807408-PCP04390	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02953	90807408-PCP04391	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02953	90807408-PCP05842	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02953	90807408-PCP05843	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02953	90807408-PCP05844	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02953	90807408-PCP05845	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02953	90807408-PCP05846	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD02953	90807408-PCP05847	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02954	90807408-PCP04392	90807408	2F露天	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02954	90807408-PCP04393	90807408	2F露天	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02955	90807408-PCP04394	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02955	90807408-PCP04395	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02955	90807408-PCP04396	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02955	90807408-PCP05848	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	樹林區	90807408-SCSD02955	90807408-PCP05849	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02956	90807408-PCP04397	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02956	90807408-PCP04398	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02956	90807408-PCP05793	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02956	90807408-PCP05794	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	烏來區	90807408-SCSD02957	90807408-PCP04399	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	烏來區	90807408-SCSD02957	90807408-PCP04400	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	烏來區	90807408-SCSD02957	90807408-PCP04401	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	烏來區	90807408-SCSD02957	90807408-PCP04402	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	烏來區	90807408-SCSD02957	90807408-PCP05850	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	烏來區	90807408-SCSD02957	90807408-PCP05851	90807408	2F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	烏來區	90807408-SCSD02957	90807408-PCP05852	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	烏來區	90807408-SCSD02957	90807408-PCP05853	90807408	2F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02958	90807408-PCP04403	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02958	90807408-PCP04404	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02958	90807408-PCP05640	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02958	90807408-PCP05641	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02958	90807408-PCP05642	90807408	1F	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD02958	90807408-PCP05643	90807408	1F	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02959	90807408-PCP04405	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02959	90807408-PCP04406	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02959	90807408-PCP05854	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02959	90807408-PCP05855	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02959	90807408-PCP05856	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02959	90807408-PCP05857	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02959	90807408-PCP05858	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02959	90807408-PCP05859	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02960	90807408-PCP04425	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02960	90807408-PCP04426	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02961	90807408-PCP04407	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02961	90807408-PCP04408	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02961	90807408-PCP04409	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02961	90807408-PCP04410	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02961	90807408-PCP05807	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02961	90807408-PCP05808	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02961	90807408-PCP05809	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02961	90807408-PCP05810	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02962	90807408-PCP04411	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02962	90807408-PCP04412	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02962	90807408-PCP04413	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02962	90807408-PCP04414	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02962	90807408-PCP04415	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD02962	90807408-PCP04416	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02965	90807408-PCP04423	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02965	90807408-PCP04424	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02965	90807408-PCP04427	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02965	90807408-PCP04428	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	土城區	90807408-SCSD02965	90807408-PCP04429	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02966	90807408-PCP04430	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02966	90807408-PCP04431	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02966	90807408-PCP04432	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02966	90807408-PCP04433	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02966	90807408-PCP04434	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD02966	90807408-PCP04435	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02967	90807408-PCP04436	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02967	90807408-PCP04437	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02967	90807408-PCP04438	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02967	90807408-PCP04439	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02967	90807408-PCP05801	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02967	90807408-PCP05802	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02967	90807408-PCP05803	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02967	90807408-PCP05805	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	永和區	90807408-SCSD02967	90807408-PCP05806	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD02968	90807408-PCP04440	90807408	1F平面	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	鶯歌區	90807408-SCSD02969	90807408-PCP04441	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05077	90807408	4B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05078	90807408	4B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05079	90807408	4B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05080	90807408	4B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05081	90807408	4B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05082	90807408	4B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05083	90807408	4B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05084	90807408	4B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05085	90807408	4B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05086	90807408	4B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05087	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05088	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05089	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05090	90807408	5B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05091	90807408	5B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05092	90807408	5B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05093	90807408	5B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05094	90807408	5B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05095	90807408	5B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三峽區	90807408-SCSD03173	90807408-PCP05096	90807408	5B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD03192	90807408-PCP05134	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90807408-SCSD03192	90807408-PCP05135	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD03203	90807408-PCP05187	90807408	1F	浮動費率,,計度/離峰/00:00-11:00/8.4元每度,計度/一般/*11:01-23:59/9.5元每度		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90807408-SCSD03203	90807408-PCP05188	90807408	1F	浮動費率,,計度/離峰/00:00-11:00/8.4元每度,計度/一般/*11:01-23:59/9.5元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03220	90807408-PCP05284	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03220	90807408-PCP05285	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03230	90807408-PCP05332	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03230	90807408-PCP05333	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03230	90807408-PCP05334	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03230	90807408-PCP05335	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03230	90807408-PCP05336	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03230	90807408-PCP05337	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03230	90807408-PCP05338	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03230	90807408-PCP05339	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03253	90807408-PCP05404	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03253	90807408-PCP05405	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03253	90807408-PCP05406	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03253	90807408-PCP05407	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03253	90807408-PCP05408	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03253	90807408-PCP05409	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03263	90807408-PCP05466	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03263	90807408-PCP05467	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03263	90807408-PCP05468	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03263	90807408-PCP05469	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03263	90807408-PCP05470	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03263	90807408-PCP05471	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90807408-SCSD03263	90807408-PCP05472	90807408	B1	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD03463	90807408-PCP06189	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	90807408-SCSD03463	90807408-PCP06190	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03467	90807408-PCP06206	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03467	90807408-PCP06207	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03467	90807408-PCP06208	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03467	90807408-PCP06209	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03467	90807408-PCP06210	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03467	90807408-PCP06211	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03484	90807408-PCP06238	90807408	B2	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	90807408-SCSD03484	90807408-PCP06239	90807408	B2	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	90807408-SCSD03505	90807408-PCP06309	90807408	B1	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD03541	90807408-PCP06394	90807408	B1	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD03541	90807408-PCP06395	90807408	B1	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD03541	90807408-PCP06396	90807408	B1	免費		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD03541	90807408-PCP06397	90807408	B1	免費		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD03541	90807408-PCP06398	90807408	B1	計度/固定/7元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD03541	90807408-PCP06399	90807408	B1	計度/固定/7元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD03541	90807408-PCP06400	90807408	B1	計度/固定/7元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90807408-SCSD03541	90807408-PCP06401	90807408	B1	計度/固定/7元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD03547	90807408-PCP06425	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD03547	90807408-PCP06426	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD03547	90807408-PCP06427	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD03547	90807408-PCP06428	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD03547	90807408-PCP06429	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD03547	90807408-PCP06430	90807408	1F	計度/固定/8元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD03547	90807408-PCP06431	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	八里區	90807408-SCSD03547	90807408-PCP06432	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	金山區	90807408-SCSD03554	90807408-PCP06460	90807408	1F	計度/固定/8元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	三重區	12681939-SPSS_YA41001	12681939-PB06EL2307043	12681939	1	一度10元		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	12681939-Shfc_17	12681939-PB06EL2401070	12681939	1F	1度8.5元		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	12681939-Shfc_17	12681939-PB06EL2401071	12681939	1F	1度8.5元		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	12681939-Shfc_17	12681939-PB06EL2401072	12681939	1F	1度8.5元		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三重區	12681939-SPSS_YA41001	12681939-PC01AS2308002	12681939	1	一度7元		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	12681939-Shfc_17	12681939-PC01AS23B005	12681939	1F	1度8.5元		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	24394433-Ssungreen_20	24394433-PC2530A221A1	24394433	1F	一度電8元		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	24394433-Ssungreen_20	24394433-PC2530A223A1	24394433	1F	一度電8元		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	60219358-S168_8	60219358-PB11CB2501009	60219358	1F	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	60219358-S168_8	60219358-PB11DE2503004	60219358	1F	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	80390037-S168_7	80390037-PB11CB2501004	80390037	1F	10元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	80390037-S168_7	80390037-PB11CE2409049	80390037	1F	10元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	86711789-Sgowin_1	86711789-P32120100091	86711789	1	9:00-24:00 8元/度，24:00-09:00 5元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	86711789-Sgowin_1	86711789-P32120100094	86711789	1	9:00-24:00 8元/度，24:00-09:00 5元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	87545768-S168_26	87545768-PB11CE2507021	87545768	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	87545768-S168_11	87545768-PB11CE2507022	87545768	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	87545768-S168_11	87545768-PB11CE2507023	87545768	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	87545768-S168_11	87545768-PB11CE2507025	87545768	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	87545768-S168_11	87545768-PB11CE2507026	87545768	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	87545768-S168_11	87545768-PB11CE2507027	87545768	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	87545768-S168_11	87545768-PB11CE2507029	87545768	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	87545768-S168_11	87545768-PB11CE2507030	87545768	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	87545768-S168_11	87545768-PB11CE2507031	87545768	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	87545789-S168_13	87545789-PB11CE2507024	87545789	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	87545789-S168_13	87545789-PB11CE2507028	87545789	1	8元/度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5984	90148497	B4	充電費率依系統公告為準。		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5985	90148497	B4	充電費率依系統公告為準。		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5986	90148497	B4	充電費率依系統公告為準。		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5987	90148497	B4	充電費率依系統公告為準。		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5988	90148497	B4	充電費率依系統公告為準。		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5989	90148497	B4	充電費率依系統公告為準。		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5990	90148497	B4	充電費率依系統公告為準。		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5991	90148497	B4	充電費率依系統公告為準。		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5992	90148497	B4	充電費率依系統公告為準。		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5993	90148497	B4	充電費率依系統公告為準。		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5994	90148497	B4	充電費率依系統公告為準。		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5995	90148497	B4	充電費率依系統公告為準。		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5996	90148497	B4	充電費率依系統公告為準。		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P5997	90148497	B4	充電費率依系統公告為準。		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P6009	90148497	B4	充電費率依系統公告為準。		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1215	90148497-P6010	90148497	B4	充電費率依系統公告為準。		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三重區	90148497-S1240	90148497-P6071	90148497	1	充電費率依系統公告為準。		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	汐止區	90148497-S1046	90148497-P5430	90148497	B1	計度/固定/9 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	90148497-S1171	90148497-P5729	90148497	B1	$9/kWh		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90482725-S0080	90482725-P00004	90482725	1	計度/固定/7.8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	90482725-S0080	90482725-P00003	90482725	1	計度/固定/7.8 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	50965513-SPDP3104001	50965513-PA0323TYTW00063	50965513	1	計度/00:00-24:00/每度7元	限定車車電充使用	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	50965513-SPDP3104001	50965513-PA0323TYTW00077	50965513	1	計度/00:00-24:00/每度7元	限定車車電充使用	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	90444103-S53	90444103-P149	90444103	1	計度/尖峰/16:00-22:00/13.50 元每度, 計度/尖峰/15:00-21:00/13.50 元每度, 計度/離峰/23:59-16:00/6.00 元每度, 計度/離峰/22:00-23:59/6.00 元每度, 計度/離峰/23:59-15:00/6.00 元每度, 計度/離峰/21:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.50 元每度, 計度/離峰/00:00-23:59/6.50 元每度		{"CCS1": 2}	2026-05-02 14:10:16+00
新北市	土城區	90444103-S53	90444103-P150	90444103	1	計度/尖峰/16:00-22:00/13.50 元每度, 計度/尖峰/15:00-21:00/13.50 元每度, 計度/離峰/23:59-16:00/6.00 元每度, 計度/離峰/22:00-23:59/6.00 元每度, 計度/離峰/23:59-15:00/6.00 元每度, 計度/離峰/21:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.50 元每度, 計度/離峰/00:00-23:59/6.50 元每度		{"CCCS2": 2}	2026-05-02 14:10:16+00
新北市	土城區	90444103-S53	90444103-P151	90444103	1	計度/尖峰/16:00-22:00/13.50 元每度, 計度/尖峰/15:00-21:00/13.50 元每度, 計度/離峰/23:59-16:00/6.00 元每度, 計度/離峰/22:00-23:59/6.00 元每度, 計度/離峰/23:59-15:00/6.00 元每度, 計度/離峰/21:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.50 元每度, 計度/離峰/00:00-23:59/6.50 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	46037888-S59	46037888-P161	46037888	1	計度/尖峰/09:00-23:59/10.00 元每度, 計度/尖峰/06:00-11:00/10.00 元每度, 計度/尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/10.00 元每度, 計度/離峰/23:59-06:00/10.00 元每度, 計度/離峰/11:00-14:00/10.00 元每度, 計度/半尖峰/09:00-23:59/10.00 元每度, 計度/半尖峰/06:00-11:00/10.00 元每度, 計度/半尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/10.00 元每度, 計度/離峰/23:59-06:00/10.00 元每度, 計度/離峰/11:00-14:00/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三峽區	46037888-S60	46037888-P160	46037888	1	計度/尖峰/09:00-23:59/10.00 元每度, 計度/尖峰/06:00-11:00/10.00 元每度, 計度/尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/10.00 元每度, 計度/離峰/23:59-06:00/10.00 元每度, 計度/離峰/11:00-14:00/10.00 元每度, 計度/半尖峰/09:00-23:59/10.00 元每度, 計度/半尖峰/06:00-11:00/10.00 元每度, 計度/半尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/10.00 元每度, 計度/離峰/23:59-06:00/10.00 元每度, 計度/離峰/11:00-14:00/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	54991324-S62	54991324-P168	54991324	1	計度/尖峰/09:00-23:59/8.90 元每度, 計度/尖峰/06:00-11:00/8.90 元每度, 計度/尖峰/14:00-23:59/8.90 元每度, 計度/離峰/23:59-09:00/5.90 元每度, 計度/離峰/23:59-06:00/5.90 元每度, 計度/離峰/11:00-14:00/5.90 元每度, 計度/半尖峰/09:00-23:59/5.90 元每度, 計度/半尖峰/06:00-11:00/5.90 元每度, 計度/半尖峰/14:00-23:59/5.90 元每度, 計度/離峰/23:59-09:00/5.90 元每度, 計度/離峰/23:59-06:00/5.90 元每度, 計度/離峰/11:00-14:00/5.90 元每度, 計度/離峰/00:00-23:59/5.90 元每度, 計度/離峰/00:00-23:59/5.90 元每度		{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	樹林區	46037888-S64	46037888-P179	46037888	1	計度/尖峰/09:00-23:59/10.00 元每度, 計度/尖峰/06:00-11:00/10.00 元每度, 計度/尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/10.00 元每度, 計度/離峰/23:59-06:00/10.00 元每度, 計度/離峰/11:00-14:00/10.00 元每度, 計度/半尖峰/09:00-23:59/10.00 元每度, 計度/半尖峰/06:00-11:00/10.00 元每度, 計度/半尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/10.00 元每度, 計度/離峰/23:59-06:00/10.00 元每度, 計度/離峰/11:00-14:00/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	46037888-S65	46037888-P180	46037888	1	計度/尖峰/09:00-23:59/10.00 元每度, 計度/尖峰/06:00-11:00/10.00 元每度, 計度/尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/10.00 元每度, 計度/離峰/23:59-06:00/10.00 元每度, 計度/離峰/11:00-14:00/10.00 元每度, 計度/半尖峰/09:00-23:59/10.00 元每度, 計度/半尖峰/06:00-11:00/10.00 元每度, 計度/半尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/10.00 元每度, 計度/離峰/23:59-06:00/10.00 元每度, 計度/離峰/11:00-14:00/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	54991324-S74	54991324-P200	54991324		計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/半尖峰/09:00-23:59/6.00 元每度, 計度/半尖峰/06:00-11:00/6.00 元每度, 計度/半尖峰/14:00-23:59/6.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	89132567-S0069	89132567-P0152	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	89132567-S0069	89132567-P0155	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	89132567-S0072	89132567-P0169	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	54991324-S74	54991324-P201	54991324		計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/半尖峰/09:00-23:59/6.00 元每度, 計度/半尖峰/06:00-11:00/6.00 元每度, 計度/半尖峰/14:00-23:59/6.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	54991324-S74	54991324-P202	54991324		計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/半尖峰/09:00-23:59/6.00 元每度, 計度/半尖峰/06:00-11:00/6.00 元每度, 計度/半尖峰/14:00-23:59/6.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	中和區	54991324-S74	54991324-P203	54991324		計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/半尖峰/09:00-23:59/6.00 元每度, 計度/半尖峰/06:00-11:00/6.00 元每度, 計度/半尖峰/14:00-23:59/6.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	46037888-S122	46037888-P466	46037888	1	計度/尖峰/09:00-23:59/10.00 元每度, 計度/尖峰/06:00-11:00/10.00 元每度, 計度/尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/10.00 元每度, 計度/離峰/23:59-06:00/10.00 元每度, 計度/離峰/11:00-14:00/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度, 計度/離峰/00:00-23:59/10.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	鶯歌區	53328840-S132	53328840-P485	53328840	1	計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/8.00 元每度, 計度/離峰/23:59-06:00/8.00 元每度, 計度/離峰/11:00-14:00/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	鶯歌區	53328840-S132	53328840-P486	53328840	1	計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/8.00 元每度, 計度/離峰/23:59-06:00/8.00 元每度, 計度/離峰/11:00-14:00/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	34176631-S179	34176631-P591	34176631	地下1	計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/半尖峰/09:00-23:59/6.00 元每度, 計度/半尖峰/06:00-11:00/6.00 元每度, 計度/半尖峰/14:00-23:59/6.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	24788035-S185	24788035-P605	24788035	1	計度/尖峰/09:00-23:59/6.00 元每度, 計度/尖峰/06:00-11:00/6.00 元每度, 計度/尖峰/14:00-23:59/6.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	24788035-S185	24788035-P606	24788035	1	計度/尖峰/09:00-23:59/6.00 元每度, 計度/尖峰/06:00-11:00/6.00 元每度, 計度/尖峰/14:00-23:59/6.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	24788035-S185	24788035-P607	24788035	1	計度/尖峰/09:00-23:59/6.00 元每度, 計度/尖峰/06:00-11:00/6.00 元每度, 計度/尖峰/14:00-23:59/6.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	24788035-S185	24788035-P608	24788035	1	計度/尖峰/09:00-23:59/6.00 元每度, 計度/尖峰/06:00-11:00/6.00 元每度, 計度/尖峰/14:00-23:59/6.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	34220432-S238	34220432-P787	34220432	地下1	計度/尖峰/09:00-23:59/10.00 元每度, 計度/尖峰/06:00-11:00/10.00 元每度, 計度/尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/8.00 元每度, 計度/離峰/23:59-06:00/8.00 元每度, 計度/離峰/11:00-14:00/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	蘆洲區	34220432-S238	34220432-P788	34220432	地下1	計度/尖峰/09:00-23:59/10.00 元每度, 計度/尖峰/06:00-11:00/10.00 元每度, 計度/尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/8.00 元每度, 計度/離峰/23:59-06:00/8.00 元每度, 計度/離峰/11:00-14:00/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0067	89132567-P0150	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0080	89132567-P0195	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0080	89132567-P0196	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0080	89132567-P0197	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0080	89132567-P0198	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0080	89132567-P0199	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0080	89132567-P0200	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0080	89132567-P0201	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0080	89132567-P0202	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	89132567-S0081	89132567-P0203	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	89132567-S0081	89132567-P0204	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	89132567-S0081	89132567-P0205	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	89132567-S0081	89132567-P0206	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	89132567-S0081	89132567-P0207	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	89132567-S0084	89132567-P0211	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	89132567-S0105	89132567-P0274	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新莊區	89132567-S0105	89132567-P0275	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	89132567-S0109	89132567-P0291	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	89132567-S0109	89132567-P0292	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	89132567-S0109	89132567-P0293	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	89132567-S0109	89132567-P0294	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	89132567-S0109	89132567-P0295	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	永和區	89132567-S0109	89132567-P0296	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	89132567-S0110	89132567-P0297	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	89132567-S0113	89132567-P0305	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0114	89132567-P0306	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0114	89132567-P0307	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0115	89132567-P0308	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0115	89132567-P0309	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0116	89132567-P0310	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0116	89132567-P0311	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	汐止區	89132567-S0121	89132567-P0317	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	樹林區	89132567-S0122	89132567-P0318	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	89132567-S0128	89132567-P0327	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	89132567-S0128	89132567-P0328	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	89132567-S0128	89132567-P0329	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	89132567-S0128	89132567-P0330	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	89132567-S0128	89132567-P0331	89132567	B1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三芝區	89132567-S0134	89132567-P0370	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三芝區	89132567-S0134	89132567-P0371	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三芝區	89132567-S0134	89132567-P0372	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三芝區	89132567-S0134	89132567-P0373	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	三芝區	89132567-S0134	89132567-P0374	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	金山區	89132567-S0135	89132567-P0375	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	金山區	89132567-S0135	89132567-P0376	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	新店區	89132567-S0148	89132567-P0407	89132567	1	計度/固定/8元每度	依現場告示	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	89132567-S0149	89132567-P0408	89132567	1	計度/固定/10元每度	依現場告示	{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	林口區	83039115-S0003	83039115-P0005	83039115	B1	計度/尖峰/15:00-20:59（星期一到星期五）/ 13.90 元每度,計度/離峰/其他時段/ 0.00 元每度	本充電站限會員使用	{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	三重區	83039115-S0002	83039115-P0003	83039115	1F	計度/尖峰/15:00-20:59（星期一到星期五）/ 13.90 元每度,計度/離峰/其他時段/ 0.00 元每度	本充電站限會員使用	{"CCS1": 1, "CCCS2": 1}	2026-05-02 14:10:16+00
新北市	八里區	53703514-S2209	53703514-P18568	53703514	F1	計分/1元每分	本充電站限會員使用	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	八里區	53703514-S2209	53703514-P18569	53703514	F1	計分/1元每分	本充電站限會員使用	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	53703514-S2375	53703514-P500121	53703514	F1	免費	本充電站限會員使用	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	土城區	53703514-S1101	53703514-P500150	53703514	F1	計度/固定/8元每度	本充電站限會員使用	{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	林口區	42861108-S32202	42861108-P322021	42861108	B2	計度/浮動/8元每度		{"Tesla_TPC": 1}	2026-05-02 14:10:16+00
新北市	林口區	42861108-S32202	42861108-P322022	42861108	B2	計度/浮動/8元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	林口區	42861108-S32202	42861108-P322023	42861108	B2	計度/浮動/8元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	林口區	42861108-S32202	42861108-P322024	42861108	B2	計度/浮動/8元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90505425-S58665	90505425-P586651	90505425	B3	計度/固定/9.9元每度		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90505425-S58665	90505425-P586652	90505425	B3	計度/固定/9.9元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90505425-S58665	90505425-P586653	90505425	B3	計度/固定/9.9元每度		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90505425-S58665	90505425-P586654	90505425	B3	計度/固定/9.9元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90505425-S58665	90505425-P586655	90505425	B3	計度/固定/9.9元每度		{"CCS1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90505425-S58665	90505425-P586656	90505425	B3	計度/固定/9.9元每度		{"CCCS2": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90505425-S58665	90505425-P586657	90505425	B3	計度/固定/9.9元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	板橋區	90505425-S58665	90505425-P586658	90505425	B3	計度/固定/9.9元每度		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	85017137-SNWT0001	85017137-P0057	85017137	1	計分/1元每分		{"J1772_Type1": 1}	2026-05-02 14:10:16+00
新北市	淡水區	85017137-SNWT0001	85017137-P0058	85017137	1	計分/1元每分		{"Mennekes_Type2": 1}	2026-05-02 14:10:16+00
\.


--
-- Data for Name: env_ev_charging_stations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.env_ev_charging_stations (source_name, source_url, city, district, station_id, station_name, operator_id, operation_type, spaces, station_reported_charging_points, charging_point_count, connector_count, power_summary, service_time, parking_rate, charging_rate, floors, telephone, address, normalized_address, longitude, latitude, data_time, wkb_geometry) FROM stdin;
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0201U03	國立臺灣大學新南地下停車場	90807408	2	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	平日40元/時，假日40元/時	AC/計度/一般/ 7.8000元每度	B1	33663366			121.53387	25.01912	2026-05-01 01:00:08+00	0101000020E6100000319413ED2A625E4014B35E0CE5043940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0383	陽明山第二停車場	90807408	2	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	20元/時(周一~周五)，30元/時(周六~周日)	AC/計度/一般/ 0.00元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度	1	0975-024268或(02)26546264			121.54554	25.15487	2026-05-01 01:00:08+00	0101000020E61000003BAA9A20EA625E40AB21718FA5273940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0126	慶昌橋下停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.000元每度	1	2759-0666			121.51493	25.07649	2026-05-01 01:00:08+00	0101000020E6100000AD6EF59CF4605E40967840D994133940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0852	福林公園地下停車場	90807408	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.000元每度	B1	0228830481			121.53069	25.09596	2026-05-01 01:00:08+00	0101000020E61000001D9430D3F6615E4063B9A5D590183940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0095	大安森林公園地下停車場	85051710	2	37	37	37	37	{"slow_ac": 37}	每日/00:00~24:00	每小時20元	計度/每度8.00元	B2	022709-2940			121.53733	25.03186	2026-05-01 01:00:08+00	0101000020E6100000384A5E9D63625E40F20C1AFA27083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0009	光復北路平面停車場	85051710	2	3	3	3	3	{"slow_ac": 3}	每日/07:00~20:00	每小時50元	計度/每度8.00元	1	0227590666			121.55833	25.04905	2026-05-01 01:00:08+00	0101000020E61000000B98C0ADBB635E406ADE718A8E0C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0722	玉成國小地下停車場	28371994	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	每0.5小時10元	計時/每日/5元每0.5時	B2	022655-0818			121.59294	25.05329	2026-05-01 01:00:08+00	0101000020E6100000601F9DBAF2655E402F34D769A40D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1004	松德大樓地下停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時40元	計度/每度8.00元	B2	0227274168			121.57417	25.03203	2026-05-01 01:00:08+00	0101000020E610000009168733BF645E40AA7D3A1E33083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0086	金華公園地下停車場	85051710	2	5	5	5	5	{"slow_ac": 5}	每日/00:00~24:00	每小時50元	計度/每度8.00元	B1	022357-8564			121.53157	25.02958	2026-05-01 01:00:08+00	0101000020E610000039622D3E05625E409D9D0C8E92073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE1128	五常街臨時平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	周一至周六/09:00~17:00	每小時40元	計度/每度8.00元	1	27590666			121.54232	25.06443	2026-05-01 01:00:08+00	0101000020E6100000DFFDF15EB5625E409CE1067C7E103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0762	國立臺灣大學水源校區平面停車場	90807408	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	平日40元/時，假日40元/時	AC/計度/一般/ 7.8000元每度	1	3366-3366			121.52991	25.01378	2026-05-01 01:00:08+00	0101000020E6100000B2F4A10BEA615E40C156091687033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0160	陽明山立體停車場	90807408	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	30元/時	AC/計度/一般/ 0.00元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度	1	0975-024268或(02)26546264			121.53892	25.15513	2026-05-01 01:00:08+00	0101000020E610000043CA4FAA7D625E40E4A08499B6273940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0358	南湖高中運動中心停車場	42311786	1	4	1	1	1	{"slow_ac": 1}	星期一：00:00～23:59\n星期二：00:00～23:59\n星期三：00:00～23:59\n星期四：00:00～23:59\n星期五：00:00～23:59\n星期六：00:00～23:59\n星期日：00:00～23:59	免費	計度/尖峰/16:00-22:00/7.00 元每度, 計度/半尖峰/09:00-16:00/7.00 元每度, 計度/半尖峰/22:00-23:59/7.00 元每度, 計度/半尖峰/06:00-11:00/7.00 元每度, 計度/半尖峰/14:00-23:59/7.00 元每度, 計度/離峰/23:59-09:00/7.00 元每度, 計度/離峰/23:59-06:00/7.00 元每度, 計度/離峰/11:00-14:00/7.00 元每度, 計度/半尖峰/09:00-23:59/7.00 元每度	B1	0226341717			121.61064	25.0665	2026-05-01 01:00:08+00	0101000020E61000004968CBB914675E401B2FDD2406113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0723	立農公園地下停車場	90807408	2	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	B1	0227233628			121.50309	25.11856	2026-05-01 01:00:08+00	0101000020E6100000753C66A032605E401F9DBAF2591E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0062	前港公園地下停車場	90807408	2	15	15	15	15	{"slow_ac": 15}	每日/00:00-24:00	20元/02:00~19:00，40元/19:00~02:00	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	B1	0228817033			121.52132	25.08603	2026-05-01 01:00:08+00	0101000020E61000000CB08F4E5D615E409279E40F06163940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1123	瑠公國中停車場	90807408	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	AC/計度/一般/ 8元每度	AC/計度/一般/ 8元每度	1	0227261481#401			121.5867	25.03714	2026-05-01 01:00:08+00	0101000020E61000000B24287E8C655E409A5FCD0182093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE1323	水源停車場	90505425	2	1	1	1	1	{"slow_ac": 1}	7x24小時	計時/平日/40元每小時，計時/假日/60元每小時	計時/固定/1元每分	1	83695098			121.5344	25.01274	2026-05-01 01:00:08+00	0101000020E6100000E0BE0E9C33625E40DE59BBED42033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0253	中油大樓停車場	85051710	3	8	8	8	8	{"slow_ac": 8}	每日/07:00~23:00	每小時30元	計度/每度8.50元	B3	0287258847			121.56913	25.03966	2026-05-01 01:00:08+00	0101000020E61000000A4B3CA06C645E4099F56228270A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0567	臺北市災害應變中心地下停車場	85051710	2	4	4	4	4	{"slow_ac": 4}	每日/00:00~24:00	每小時30元	計度/每度8.00元	B1	0223453859			121.5659	25.02885	2026-05-01 01:00:08+00	0101000020E61000009C33A2B437645E40567DAEB662073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0607	北投國中教職員工停車場	52883637	2	1	1	1	1	{"slow_ac": 1}	夜間 19:00-07:00	校園案預設'以分計費'	計分/固定/ 8.5 元每分	1	0228912091			121.50361	25.13494	2026-05-01 01:00:08+00	0101000020E610000011FC6F253B605E4018EC866D8B223940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0096	府前廣場地下停車場	28371994	2	40	40	40	40	{"slow_ac": 40}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	0226550818			121.56212	25.03653	2026-05-01 01:00:08+00	0101000020E61000005C1B2AC6F9635E40A852B3075A093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0015	長春路平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	周一至周六/07:00~20:00	每小時40元	計度/每度8.00元	1	2759-0666			121.53209	25.05535	2026-05-01 01:00:08+00	0101000020E6100000D52137C30D625E4067D5E76A2B0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0072	松山高中地下停車場	85051710	2	6	6	6	6	{"slow_ac": 6}	每日/00:00~24:00	每小時30元	計度/每度8.00元	B1	0227685492			121.56407	25.04407	2026-05-01 01:00:08+00	0101000020E6100000E7A90EB919645E4017BCE82B480B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE1012	國立臺灣大學生醫工程館地下停車場	90807408	2	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	平日40元/時，假日40元/時	AC/計度/一般/ 7.8000元每度	B2	3366-3366			121.547	25.01393	2026-05-01 01:00:08+00	0101000020E61000005EBA490C02635E40EB6E9EEA90033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0169	大豐公園地下停車場	90807408	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	40元/7:00~22:00，10元/22:00~7:00	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	B1	0228921209			121.50421	25.13113	2026-05-01 01:00:08+00	0101000020E61000003C1405FA44605E40448655BC91213940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0288	雙園國中地下停車場	90807408	2	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	30元/8:00~22:00，10元/22:00~8:00	AC/計度/一般/ 0.00元每度	B1	23016115			121.49159	25.02783	2026-05-01 01:00:08+00	0101000020E61000009A42E735765F5E4002D9EBDD1F073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE1593	辛亥水安停車場	90807408	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	AC/計度/一般/ 0元每度	AC/計度/一般/ 0元每度	1	83695104			121.54873	25.0159	2026-05-01 01:00:08+00	0101000020E610000062156F641E635E40A301BC0512043940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0514	USPACE 福林第二停車場	90505425	3	4	4	4	4	{"ultra_fast_dc": 4}	7x24小時	電動汽車充電不收停車費	計度/尖峰/12.5元每度，計度/離峰/6.5元每度	1	0277518097			121.52761	25.09327	2026-05-01 01:00:08+00	0101000020E6100000B9C2BB5CC4615E40ABB2EF8AE0173940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE1726	福星社會住宅地下停車場	25077906	2	6	4	4	4	{"slow_ac": 4}	7x24 小時或 每日/00:00-24:00	計時/每日/20 元每小時	計度/固定/8 元每度	B2	29441489#0			121.50666	25.047	2026-05-01 01:00:08+00	0101000020E61000003F8C101E6D605E4079E92631080C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0120	進安公園地下停車場	80688966	2	3	3	3	3	{"slow_ac": 3}	7x24 小時	計時/每日/30元/每小時	計度/固定/8元每度	B1	2502-3333			121.5377	25.04604	2026-05-01 01:00:08+00	0101000020E6100000CAC342AD69625E40CF4E0647C90B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0070	松壽廣場地下停車場	28371994	2	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	0226550818			121.56641	25.03716	2026-05-01 01:00:08+00	0101000020E61000002788BA0F40645E4028B8585183093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1110	信義路5段150巷臨時平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	0800208333			121.57049	25.02596	2026-05-01 01:00:08+00	0101000020E61000007C2C7DE882645E4011018750A5063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE1861	大龍峒社會住宅地下停車場	00655051	1	1	2	2	0	{}	24H	30	慢充每度8元	1F	0227546661			121.51803	25.07116	2026-05-01 01:00:08+00	0101000020E610000033164D6727615E408AC8B08A37123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE1904	台灣聯通萬華安居A停車場	28007736	1	2	2	2	0	{}	每日/00:00-24:00	計時/每日/100元每小時,全程以半小時計	計度/10元每度	B1	25235000			121.49002	25.03341	2026-05-01 01:00:08+00	0101000020E6100000B398D87C5C5F5E40FF5BC98E8D083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE1905	台灣聯通萬華安居B停車場	28007736	1	2	2	2	0	{}	每日/00:00-24:00	計時/每日/100元每小時,全程以半小時計	計度/10元每度	B1	25235000			121.49071	25.03312	2026-05-01 01:00:08+00	0101000020E61000007E74EACA675F5E40F1D7648D7A083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1908	舊宗社會住宅地下停車場	00654927	1	1	1	1	0	{}	24H	30	慢充每度8元	1F	0227546661			121.57785	25.06257	2026-05-01 01:00:08+00	0101000020E610000097FF907EFB645E40F2B5679604103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0379	水源快速道路高架橋下	85051710	2	4	4	4	4	{"slow_ac": 4}	每日/09:00~17:00	每小時20元	計度/每度8.00元	1	2759-0666			121.53533	25.00382	2026-05-01 01:00:08+00	0101000020E610000055A4C2D842625E401B12F758FA003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0230	忠信廣場地下停車場	85051710	2	8	8	8	8	{"slow_ac": 8}	每日/00:00~24:00	每小時50元	計度/每度8.00元	B1	0223459578			121.56822	25.04027	2026-05-01 01:00:08+00	0101000020E6100000B83B6BB75D645E408A027D224F0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0300	康寧平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	0226550818			121.60553	25.07253	2026-05-01 01:00:08+00	0101000020E6100000CDAFE600C1665E4098FA795391123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0381	環山平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	02-27546661			121.57207	25.08573	2026-05-01 01:00:08+00	0101000020E610000074417DCB9C645E403D49BA66F2153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0593	臺北市芳和實驗中學	83578534	2	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	計月/2500 元每月	測試中，不計費	1	2732-1961#504			121.54997	25.01887	2026-05-01 01:00:08+00	0101000020E6100000FEF15EB532635E4022E010AAD4043940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE1011	國立臺灣大學芳蘭第一平面停車場	90807408	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	平日40元/時，假日40元/時	AC/計度/一般/ 7.8000元每度	1	3366-3366			121.54503	25.01177	2026-05-01 01:00:08+00	0101000020E6100000B05582C5E1625E40EC12D55B03033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0399	關渡水岸自然公園平面停車場	90807408	2	9	9	9	9	{"slow_ac": 9}	每日/00:00-24:00	50元/時	AC/計度/一般/ 8.0元每度	1	(02)27057716			121.46245	25.11868	2026-05-01 01:00:08+00	0101000020E61000004182E2C7985D5E4075B0FECF611E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0360	東湖國小地下停車場	90807408	2	10	10	10	10	{"slow_ac": 10}	每日/00:00-24:00	30元/8:00~18:00，20元/18:00~8:00	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度	B1	0226306731			121.61584	25.06855	2026-05-01 01:00:08+00	0101000020E610000065E42CEC69675E400B24287E8C113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0305	青年公園高爾夫球場地下停車場	90807408	2	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	B1	23379616			121.5073	25.02492	2026-05-01 01:00:08+00	0101000020E6100000B1506B9A77605E402E04392861063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0251	公館停車場	90505425	2	3	3	3	3	{"slow_ac": 3}	7x24小時	計時/平日/40元每小時，計時/假日/50元每小時	計時/固定/1元每分	1	8369-5098			121.53512	25.01092	2026-05-01 01:00:08+00	0101000020E6100000E0DBF4673F625E4050DF32A7CB023940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE1585	臺北市立成功高級中學綜合大樓地下停車場	42477884	1	2	1	1	1	{"slow_ac": 1}	星期一：00:00～23:59\n星期二：00:00～23:59\n星期三：00:00～23:59\n星期四：00:00～23:59\n星期五：00:00～23:59\n星期六：00:00～23:59\n星期日：00:00～23:59	計時/每日/20 元每小時	計度/尖峰/09:00-23:59/7.00 元每度, 計度/尖峰/06:00-11:00/7.00 元每度, 計度/尖峰/14:00-23:59/7.00 元每度, 計度/離峰/23:59-09:00/7.00 元每度, 計度/離峰/23:59-06:00/7.00 元每度, 計度/離峰/11:00-14:00/7.00 元每度, 計度/半尖峰/09:00-23:59/7.00 元每度, 計度/半尖峰/06:00-11:00/7.00 元每度, 計度/半尖峰/14:00-23:59/7.00 元每度, 	B2	2321-8222			121.52322	25.04314	2026-05-01 01:00:08+00	0101000020E61000003D27BD6F7C615E40422619390B0B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1634	洲子站	28114216	3	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	計時/每日/40元每小時	計度/固定/8.00元每度	B1	0227995657			121.56934	25.07935	2026-05-01 01:00:08+00	0101000020E61000007F130A1170645E4007F0164850143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0121	景文平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時30元	計度/每度8.00元	1	2759-0666			121.54052	24.99052	2026-05-01 01:00:08+00	0101000020E61000005FB532E197625E40AF08FEB792FD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0238	松德臨時平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時30元	計度/每度8.00元	1	0800208333			121.57351	25.03148	2026-05-01 01:00:08+00	0101000020E6100000747B4963B4645E40637AC2120F083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0715	興隆公園地下停車場	85051710	2	7	7	7	7	{"slow_ac": 7}	每日/00:00~24:00	每小時20元	計度/每度8.00元	B1	2759-0666			121.55136	25.00071	2026-05-01 01:00:08+00	0101000020E6100000A514747B49635E40B9C7D2872E003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0058	百齡高中地下停車場	88237515	2	34	5	5	5	{"slow_ac": 5}	7*24 小時	計時:週一 ~ 周四 AM 09：00 ~ PM 22：00  40/1H PM 22：00 ~ AM 09：00  10/1H        週五 ~ 周日及國定假日 PM 12：00 ~ AM 01：00   50/1H AM 01：00 ~ PM 12：00   10/1H	計度/固定/8元每度	B1	0800021111			121.52359	25.08583	2026-05-01 01:00:08+00	0101000020E6100000CFA0A17F82615E40040473F4F8153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0204	開勝平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.0元每度	1	(02)25683773			121.50498	25.14065	2026-05-01 01:00:08+00	0101000020E61000009548A29751605E40B22E6EA301243940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0654	洲子立體停車場	90807408	2	10	10	10	10	{"slow_ac": 10}	每日/00:00-24:00	40元/8:00~20:00，10元/20:00~8:00	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	3	0287511380			121.56935	25.07946	2026-05-01 01:00:08+00	0101000020E6100000917EFB3A70645E401557957D57143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0092	古亭國中地下停車場	90807408	2	7	7	7	7	{"slow_ac": 7}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.000元每度	B1	23390684			121.51001	25.02385	2026-05-01 01:00:08+00	0101000020E610000082A8FB00A4605E4075029A081B063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0449	龍門國中地下停車場	85051710	2	19	19	19	19	{"slow_ac": 19}	每日/00:00~24:00	每小時30元	計度/每度8.00元	B1	022732-6469			121.53803	25.02407	2026-05-01 01:00:08+00	0101000020E6100000159161156F625E4091D0967329063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1149	正氣橋下平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時30元	計度/每度8.00元	1				121.5684	25.04773	2026-05-01 01:00:08+00	0101000020E6100000F8C264AA60645E40C0098508380C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0134	龍江平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時30元	計度/每度8.00元	1	2754-6661			121.54189	25.05407	2026-05-01 01:00:08+00	0101000020E6100000E2016553AE625E40D9B11188D70D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0726	政大三街臨時平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	2518-5299			121.58286	24.98622	2026-05-01 01:00:08+00	0101000020E6100000618907944D655E403FA9F6E978FC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0444	洲美運動公園地下停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	B1	0228360050			121.49939	25.10973	2026-05-01 01:00:08+00	0101000020E6100000C47C7901F65F5E40DC63E943171C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0575	萬華車站地下停車場	90807408	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	平日40元/時，假日40元/時	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	B1	22408767			121.50008	25.03363	2026-05-01 01:00:08+00	0101000020E61000008E588B4F01605E401B2AC6F99B083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0315	至誠平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度	1	(02)25573722			121.53135	25.10198	2026-05-01 01:00:08+00	0101000020E6100000B22E6EA301625E4099D87C5C1B1A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0229	興中立體停車場	90807408	2	16	16	16	16	{"slow_ac": 16}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	2	0227832912			121.60679	25.05624	2026-05-01 01:00:08+00	0101000020E61000008D62B9A5D5665E401FBAA0BE650E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0690	萬華國中地下停車場	90807408	2	13	13	13	13	{"slow_ac": 13}	每日/00:00-24:00	20元/小時	AC/計度/一般/ 8.000元每度	B1	23078457			121.49957	25.02919	2026-05-01 01:00:08+00	0101000020E6100000040473F4F85F5E40C85EEFFE78073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE1622	台北市公有士林市場停車場	28007736	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/每日/40元第1小時,計時/每日/50元第2小時,計時/每日/60元第3小時	計分/ 0.9元每分	B3	(02)28815557			121.52424	25.08789	2026-05-01 01:00:08+00	0101000020E610000053D0ED258D615E403CA583F57F163940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0754	環南停車場	85111787	1	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	計時/每日/30元每小時	計時/固定/1 元每分	4	0932237171			121.48937	25.03038	2026-05-01 01:00:08+00	0101000020E61000002F698CD6515F5E40D673D2FBC6073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0534	民有市場地下停車場	85051710	2	9	9	9	9	{"slow_ac": 9}	每日/00:00~24:00	每小時30元	計度/每度8.00元	B1	0287125731			121.54675	25.06083	2026-05-01 01:00:08+00	0101000020E6100000A245B6F3FD625E409D9D0C8E920F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0215	文湖平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	02-27546661			121.56088	25.08647	2026-05-01 01:00:08+00	0101000020E6100000C03E3A75E5635E40CA15DEE522163940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0734	社子國小地下停車場	80688966	2	10	10	10	10	{"slow_ac": 10}	7x24 小時	計時/每日/20元/每小時	計度/固定/8元每度	B1	0228162810			121.50217	25.09135	2026-05-01 01:00:08+00	0101000020E610000012C2A38D23605E40567DAEB662173940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0610	樟新平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	2518-5299			121.55682	24.97964	2026-05-01 01:00:08+00	0101000020E61000008F705AF0A2635E407BDAE1AFC9FA3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0334	信義廣場地下停車場	85051710	2	9	9	9	9	{"slow_ac": 9}	每日/00:00~24:00	每小時50元	計度/每度8.00元	B1				121.56647	25.03307	2026-05-01 01:00:08+00	0101000020E6100000910A630B41645E408D7A884677083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0279	石潭平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時30元	計度/每度8.00元	1	022655-0818			121.59237	25.06865	2026-05-01 01:00:08+00	0101000020E61000006B48DC63E9655E40D3DEE00B93113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0425	永盛公園地下停車場	85051710	2	6	6	6	6	{"slow_ac": 6}	每日/00:00~24:00	每小時50元	計度/每度8.00元	B1	2759-0666			121.52483	25.05926	2026-05-01 01:00:08+00	0101000020E61000006B7D91D096615E4001F6D1A92B0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE1195	臺大癌醫中心分院地下停車場	90807408	1	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	50元/時	AC/計度/一般/ 8.8000元每度	B2	2732-1156			121.54407	25.0144	2026-05-01 01:00:08+00	0101000020E6100000062FFA0AD2625E40F90FE9B7AF033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0207	關渡醫院旁平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	20元/時	AC/計度/一般/ 0.00元每度	1	(02)25683773			121.46572	25.12033	2026-05-01 01:00:08+00	0101000020E6100000F645425BCE5D5E4049BA66F2CD1E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0819	蘭雅公園地下停車場	90807408	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	30元/周一~周五，40元/周六~周日	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	B1	0228318004			121.52925	25.10964	2026-05-01 01:00:08+00	0101000020E61000001D5A643BDF615E405C55F65D111C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0828	大龍國小地下停車場	90807408	2	7	7	7	7	{"slow_ac": 7}	每日/00:00-24:00	30元/小時	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	B1	2759-0666			121.51722	25.07411	2026-05-01 01:00:08+00	0101000020E61000009335EA211A615E407B4E7ADFF8123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0596	南港高中停車場	53919205	2	1	1	1	1	{"slow_ac": 1}	夜間:每日下午六點至翌日上午八點 : 例假日:星期六、日及國定假日全天	季租:以季票(3個月為一期)方式計費，每車3000元/季，以年票方式九折	計度/固定/6.0 元每度	1	0227837863#248			121.59315	25.05281	2026-05-01 01:00:08+00	0101000020E6100000D5E76A2BF6655E40DAE6C6F4840D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE1602	新和國小地下停車場	28114216	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/30元每小時/每日最高/180元每日	計度/固定/8.00元每度	B1	2799-5657			121.50331	25.02601	2026-05-01 01:00:08+00	0101000020E6100000FC6F253B36605E40745E6397A8063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0201U01	國立臺灣大學校總區平面停車場	42861108	2	6	6	6	6	{"ultra_fast_dc": 6}	7x24小時	計時/每日/60元每小時	計度/浮動/8元每度	B2	33663366			121.54025	25.01973	2026-05-01 01:00:08+00	0101000020E61000007F6ABC7493625E4005C078060D053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1315	臺北市內湖區潭美國民小學地下停車場	52883637	2	2	2	2	2	{"slow_ac": 2}	平日/19:00-07:00 假日00:00-24:00	校園案預設'以分計費'	計分/固定/ 0.0 元每分	1	0227917334#231			121.58136	25.05881	2026-05-01 01:00:08+00	0101000020E6100000F7CC920035655E4082AD122C0E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0384	福山平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	(02)24551299			121.61591	25.04547	2026-05-01 01:00:08+00	0101000020E6100000E1D1C6116B675E40FAF202ECA30B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0154	耕莘文教院前平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時30元	計度/每度8.00元	1	0800208333			121.52892	25.01943	2026-05-01 01:00:08+00	0101000020E6100000D28C45D3D9615E40B08F4E5DF9043940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0003	民生立體停車場	85051710	2	12	12	12	12	{"slow_ac": 12}	每日/00:00~24:00	每小時30元	計度/每度8.00元	1	0227608303			121.55958	25.05839	2026-05-01 01:00:08+00	0101000020E6100000B9DFA128D0635E40D769A4A5F20E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0721	臺北市大同運動中心地下平面停車場	85012273	1	1	1	1	1	{"slow_ac": 1}	星期一：00:00～23:59\n星期二：00:00～23:59\n星期三：00:00～23:59\n星期四：00:00～23:59\n星期五：00:00～23:59\n星期六：00:00～23:59\n星期日：00:00～23:59	計時/每日/40 元每小時	計度/尖峰/16:00-22:00/7.00 元每度, 計度/半尖峰/09:00-16:00/7.00 元每度, 計度/半尖峰/22:00-23:59/7.00 元每度, 計度/半尖峰/06:00-11:00/7.00 元每度, 計度/半尖峰/14:00-23:59/7.00 元每度, 計度/離峰/23:59-09:00/7.00 元每度, 計度/離峰/23:59-06:00/7.00 元每度, 計度/離峰/11:00-14:00/7.00 元每度, 計度/離峰/23:59-09:00/7.00 元每度,	B3	2592-0055			121.51621	25.06479	2026-05-01 01:00:08+00	0101000020E610000090F7AA9509615E409B1BD31396103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0816	信義國小地下停車場	85051710	2	6	6	6	6	{"slow_ac": 6}	每日/00:00~24:00	每小時30元	計度/每度8.00元	B1				121.56256	25.03182	2026-05-01 01:00:08+00	0101000020E61000006B82A8FB00645E40D55B035B25083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1102	康樂合署大樓地下停車場	90807408	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	30元/時(當日最高上限200元)	AC/計度/一般/ 8.000元每度	B1	0226337997			121.61922	25.07261	2026-05-01 01:00:08+00	0101000020E6100000DD41EC4CA1675E40D15CA79196123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0630	福港街平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度	1	0225046290			121.51863	25.08719	2026-05-01 01:00:08+00	0101000020E61000005E2EE23B31615E40CA89761552163940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	未分類	TPE0441	中山運動中心旁臨時平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度	1	2518-5299			150163.40664	-24908.75703	2026-05-01 01:00:08+00	0101000020E6100000EA78CC409B54024106F52D733053D8C0
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0827	世貿公園地下停車場	90807408	2	14	14	14	14	{"slow_ac": 14}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	B1	0227886271			121.6151	25.05783	2026-05-01 01:00:08+00	0101000020E610000041F163CC5D675E4049BA66F2CD0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0538	海光公園地下停車場	90807408	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	20元/小時	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	B1	0228137344			121.50842	25.08094	2026-05-01 01:00:08+00	0101000020E610000078280AF489605E4030F0DC7BB8143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0758	蓬萊國小地下停車場	28007736	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/16:00-22:00/40元每小時,計時/每日/22:00-16:00/30元每小時	計度/5元每度/00:00-09:00,計度/8元每度/09:00-24:00	B1	02-25573722			121.5168	25.0565	2026-05-01 01:00:08+00	0101000020E6100000A9A44E4013615E405839B4C8760E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0880	國立臺灣大學辛亥地下停車場	42861108	2	3	3	3	3	{"ultra_fast_dc": 3}	7x24小時	計時/每日/40元每小時	計度/浮動/8元每度	B2	3366-3366			121.54269	25.0208	2026-05-01 01:00:08+00	0101000020E61000007077D66EBB625E40BEC1172653053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0707	臺北市松山家商附設夜間及假日停車場	52883637	2	1	1	1	1	{"slow_ac": 1}	夜間/星期一至星期日晚上19:00至翌日上午07:00 假日/星期六、日及國定假日上午07:00至晚上19:00	不開放臨停，只開放月租車停放	計分/固定/ 6.7 元每分	1	0227261118#415			121.58017	25.03611	2026-05-01 01:00:08+00	0101000020E6100000B3075A8121655E40FE0E45813E093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0848	松山工農地下停車場	85051710	2	6	6	6	6	{"slow_ac": 6}	每日/00:00~24:00	每小時30元	計度/每度8.00元	B1	0223450672			121.57229	25.03958	2026-05-01 01:00:08+00	0101000020E6100000FB743C66A0645E40609335EA210A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0125	新生公園停車場	85051710	2	3	3	3	3	{"slow_ac": 3}	每日/00:00~24:00	每小時30元	計度/每度8.00元	1	0226550818			121.53093	25.06861	2026-05-01 01:00:08+00	0101000020E6100000C79DD2C1FA615E40B62DCA6C90113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0097	三福街平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	8919-3669			121.54289	24.99837	2026-05-01 01:00:08+00	0101000020E6100000D4D4B2B5BE625E40BA4E232D95FF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0976	168停車聯盟-大安場	97329493	3	1	1	1	0	{}	24H	150	慢充每度8元	1F	27546661			121.54534	25.04045	2026-05-01 01:00:08+00	0101000020E6100000D74CBED9E6625E408A1F63EE5A0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0591	景豐臨時平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	8919-3669			121.54467	25.00251	2026-05-01 01:00:08+00	0101000020E610000030478FDFDB625E40B8E9CF7EA4003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0122	大稻埕公園地下停車場	90807408	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	40元/時	AC/計度/一般/ 8.000元每度	B1	2455-1299			121.5105	25.05837	2026-05-01 01:00:08+00	0101000020E6100000E9263108AC605E4049111956F10E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE1049	福國路橋下平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度	1	0227590666			121.51883	25.10192	2026-05-01 01:00:08+00	0101000020E6100000C18BBE8234615E40EECEDA6D171A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0313	便利停車場大安地政事務所一站	94175832	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	計時/半小/35元/半小時(第一小時以一小時計費)，每日最高無上限	計分/1 元每分	B1	2799-1001#166			121.55664	25.03399	2026-05-01 01:00:08+00	0101000020E61000004FE960FD9F635E401B649291B3083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0752	南港國小地下停車場	90807408	2	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	30元/8:00~20:00，20元/20:00~8:00	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 0.00元每度,AC/計度/離峰/ 0.00元每度	B1	0800021111			121.6113	25.0566	2026-05-01 01:00:08+00	0101000020E6100000DE02098A1F675E401FF46C567D0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0930	啟聰學校地下停車場	90807408	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	30元/小時	AC/計度/一般/ 8.000元每度	B1	2759-0666			121.512	25.07425	2026-05-01 01:00:08+00	0101000020E610000054E3A59BC4605E405EBA490C02133940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0356	偶戲博物館地下停車場	28371994	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	0226550818			121.56177	25.04704	2026-05-01 01:00:08+00	0101000020E6100000EE77280AF4635E40959A3DD00A0C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE1423	豐年運動公園平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	30元/時	AC/計度/一般/ 0.00元每度	1	0227590666			121.49506	25.13528	2026-05-01 01:00:08+00	0101000020E6100000B2632310AF5F5E408ACDC7B5A1223940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0843	大湖活動中心暨溫水游泳池停車場	52883637	2	1	1	1	1	{"slow_ac": 1}	24小時	校園案預設'以分計費'	計分/固定/ 8.5 元每分	1	27915870			121.60037	25.0881	2026-05-01 01:00:08+00	0101000020E6100000F8DF4A766C665E4011C7BAB88D163940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0108	興雅國中地下停車場	85051710	2	11	11	11	11	{"slow_ac": 11}	每日/00:00~24:00	每小時30元	計度/每度8.00元	B1	0227585499			121.5728	25.03491	2026-05-01 01:00:08+00	0101000020E610000086C954C1A8645E40A94D9CDCEF083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0884	松山國小地下停車場	85051710	2	7	7	7	7	{"slow_ac": 7}	每日/00:00~24:00	每小時40元	計度/每度8.00元	B1	0227995657			121.57852	25.05037	2026-05-01 01:00:08+00	0101000020E61000003E05C07806655E4014B35E0CE50C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0098	大安高工地下停車場	85051710	2	14	14	14	14	{"slow_ac": 14}	每日/00:00~24:00	每小時30元	計度/每度8.00元	B1	022655-0818			121.54093	25.03258	2026-05-01 01:00:08+00	0101000020E610000038DBDC989E625E40F180B22957083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0206	保儀路平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	2246-1708			121.56599	24.98437	2026-05-01 01:00:08+00	0101000020E61000003CF71E2E39645E40DC291DACFFFB3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0234	吉祥平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時30元	計度/每度8.00元	1	0277518097			121.56122	25.05033	2026-05-01 01:00:08+00	0101000020E61000001D774A07EB635E40F701486DE20C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE1648	臺北市建成綜合大樓停車場	90807408	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度	B1	0225503853			121.5184	25.05457	2026-05-01 01:00:08+00	0101000020E6100000C58F31772D615E40BC57AD4CF80D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0382	陽明山花鐘停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	60元/時	AC/計度/一般/ 0.00元每度	1	0975-024268或(02)26546264			121.53957	25.15764	2026-05-01 01:00:08+00	0101000020E6100000C6F99B5088625E409C8A54185B283940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0161	兒童育樂中心平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.0元每度	1	2504-6290 分機85082鍾先生			121.52168	25.07548	2026-05-01 01:00:08+00	0101000020E61000008CBE823463615E40888043A852133940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0156	成淵高中地下停車場	90807408	2	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	40元/9:00~21:00，30元/21:00~9:00	AC/計度/一般/ 8.000元每度	B1	2799-5657			121.52018	25.06044	2026-05-01 01:00:08+00	0101000020E610000021020EA14A615E40C85EEFFE780F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0128	辛亥國小地下停車場	28007736	2	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	計時/每日/08:00-18:00/20元每小時,計時/每日/18:00-08:00/10元每小時	計度/8元每度	B2	2557-3722#0			121.55845	25.00602	2026-05-01 01:00:08+00	0101000020E6100000E09C11A5BD635E40361FD7868A013940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0450	艋舺公園地下停車場	28114216	2	10	10	10	10	{"slow_ac": 10}	每日/00:00-24:00	計時/平日/30元每小時/每日最高/180元,計時/假日/30元每小時/每日	計度/固定/8.00元每度	B4	2799-5657			121.49992	25.03613	2026-05-01 01:00:08+00	0101000020E610000072A774B0FE5F5E408C67D0D03F093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE1578	中山國中地下停車場	33029464	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	每0.5小時10元	計時/每日/5元每0.5時	B1	2655-0818			121.5456	25.06065	2026-05-01 01:00:08+00	0101000020E6100000A52C431CEB625E409D8026C2860F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0725	臺北市大同區太平國民小學停車場	52883637	2	1	1	1	1	{"slow_ac": 1}	平日/19:00-07:00 假日/24小時	校園案預設'以分計費'	計分/固定/ 8.5 元每分	1	2553-2229#834			121.51154	25.06193	2026-05-01 01:00:08+00	0101000020E610000022A64412BD605E402BA4FCA4DA0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0606	長安國小地下停車場	85051710	2	7	7	7	7	{"slow_ac": 7}	每日/00:00~24:00	每小時40元	計度/每度8.00元	B1	2759-0666			121.53132	25.05034	2026-05-01 01:00:08+00	0101000020E61000007CED992501625E403EAE0D15E30C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0835	萬興國小地下停車場	85051710	2	6	6	6	6	{"slow_ac": 6}	每日/00:00~24:00	每小時30元	計度/每度8.00元	B1	2759-0666			121.57666	24.98945	2026-05-01 01:00:08+00	0101000020E6100000543A58FFE7645E40F7065F984CFD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0832	西松高中地下停車場	85051710	2	8	8	8	8	{"slow_ac": 8}	每日/00:00~24:00	每小時30元	計度/每度8.00元	B1	0225284554			121.56608	25.05582	2026-05-01 01:00:08+00	0101000020E6100000DCBA9BA73A645E40757632384A0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0851	松山車站地下停車場	85051710	2	11	11	11	11	{"slow_ac": 11}	每日/00:00~24:00	每小時40元	計度/每度8.00元	B1	0227676549			121.57846	25.0483	2026-05-01 01:00:08+00	0101000020E6100000D482177D05655E40956588635D0C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE1334	延平國小地下停車場	90807408	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	40元/時，最高上限200元/12小時	AC/計度/一般/ 8.000元每度	B1	2705-7716#0			121.51192	25.06694	2026-05-01 01:00:08+00	0101000020E6100000C68A1A4CC3605E4053CBD6FA22113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0539	臺北大橋橋下停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	30元/時	AC/計度/一般/ 0.00元每度	1	0228233418			121.51015	25.06308	2026-05-01 01:00:08+00	0101000020E61000007B832F4CA6605E401C08C90226103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0775	玉成公園地下停車場	90807408	2	10	10	10	10	{"slow_ac": 10}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度,AC/計度/尖峰/ 8.000元每度,AC/計度/離峰/ 8.000元每度	B1	0226517459			121.58692	25.0418	2026-05-01 01:00:08+00	0101000020E61000009357E71890655E4009F9A067B30A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0421	春光公園地下停車場	93101587	2	6	5	4	5	{"slow_ac": 5}	7x24 小時或 每日/00:00-24:00	計時/每日/30 元每小時	計度/固定/8 元每度	B1	2944-1489			121.58098	25.04248	2026-05-01 01:00:08+00	0101000020E610000053E8BCC62E655E40EDBB22F8DF0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0505	三張里地下停車場	28007736	2	10	10	10	10	{"slow_ac": 10}	每日/00:00-24:00	計時/每日/30元每小時	計度/8元每度	B1,B2	0225573722			121.56694	25.03068	2026-05-01 01:00:08+00	0101000020E6100000D5B2B5BE48645E402BA4FCA4DA073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0109	市民大道建復段停車場	28114216	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	計時/每日/30元每小時	計度/固定/8.00元每度	B1	2799-5657			121.54089	25.04456	2026-05-01 01:00:08+00	0101000020E6100000F12E17F19D625E40B3B5BE48680B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0330	林森公園地下停車場	33029464	2	17	17	17	17	{"slow_ac": 17}	每日/00:00-24:00	每0.5小時10元	計時/每日/5元每0.5時	B2	2655-0818			121.52643	25.05236	2026-05-01 01:00:08+00	0101000020E610000088687407B1615E405A9E0777670D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0601	Times浩瀚運創西門館	52883637	1	1	1	1	1	{"slow_ac": 1}	平日/17:00-07:00 假日/10:00-24:00	校園案預設'以分計費'	計分/固定/ 8.0 元每分	1	0800888924#0			121.50385	25.04303	2026-05-01 01:00:08+00	0101000020E6100000BC0512143F605E4034BF9A03040B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0479	萬芳八號公園停車場	85051710	2	3	3	3	3	{"slow_ac": 3}	周一至周六/09:00~17:00	每小時50元	計度/每度8.00元	1	2759-0666			121.56068	25.00301	2026-05-01 01:00:08+00	0101000020E61000005DE15D2EE2635E409B8F6B43C5003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0926	嘉興公園地下停車場	85051710	2	5	5	5	5	{"slow_ac": 5}	每日/00:00~24:00	每小時30元	計度/每度8.00元	B1	2557-3722#0			121.55193	25.02167	2026-05-01 01:00:08+00	0101000020E61000009AEB34D252635E40E84D452A8C053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0724	金湖臨時平面停車場	85051710	2	3	3	3	3	{"slow_ac": 3}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	(02)24551299			121.59855	25.08132	2026-05-01 01:00:08+00	0101000020E610000055C1A8A44E665E40BF823463D1143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE1150	長春路龍江路臨時平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時40元	計度/每度8.00元	1	7751-8097			121.54007	25.05485	2026-05-01 01:00:08+00	0101000020E61000003FE3C28190625E40832F4CA60A0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0075	五分埔公園地下停車場	85051710	2	5	5	5	5	{"slow_ac": 5}	每日/00:00~24:00	每小時40元	計度/每度8.00元	B1	0227606275			121.58029	25.04677	2026-05-01 01:00:08+00	0101000020E6100000890CAB7823655E40156F641EF90B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0537	石牌國小地下停車場	80688966	2	10	10	10	10	{"slow_ac": 10}	7x24 小時	計時/每日/30元/每小時	計度/固定/8元每度	B2	0228237886			121.51314	25.11452	2026-05-01 01:00:08+00	0101000020E61000003F912749D7605E40E8BCC62E511D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0359	文昌國小地下停車場	80304384	2	4	3	3	3	{"slow_ac": 3}	24小時	20元/時	每度電費：8元	B1	0228318671			121.52195	25.09941	2026-05-01 01:00:08+00	0101000020E61000006C09F9A067615E4036E50AEF72193940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0615	榮星花園地下停車場	16777442	2	5	5	1	5	{"slow_ac": 5}	7x24 小時	計時/每日/40元/每小時	計度/固定/8元每度	B1	2502-3333			121.53826	25.0642	2026-05-01 01:00:08+00	0101000020E6100000AD2F12DA72625E40386744696F103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1243	景勤二號公園地下停車場	25077906	2	5	5	5	5	{"slow_ac": 5}	7x24 小時或 每日/00:00-24:00	計時/每日/30 元每小時	計度/固定/8元每度	B1	2944-1489			121.55867	25.02653	2026-05-01 01:00:08+00	0101000020E610000068D0D03FC1635E40E65C8AABCA063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE1550	莒光社會住宅地下停車場	25077906	2	4	4	4	4	{"slow_ac": 4}	7x24 小時或 每日/00:00-24:00	計時/每日/30 元每小時	計度/固定/8 元每度	B1	2944-1489			121.5004	25.03199	2026-05-01 01:00:08+00	0101000020E6100000C7BAB88D06605E408ECC237F30083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0401	臺北市萬華區行政中心地下停車場	00997716	2	4	4	4	4	{"slow_ac": 4}	24小時	計時：30元/時(08-22)，10元/時(22-08)，全程以半小時計。洽公便民於停車上班時間08至20時止，經驗證後，前30分鐘免費。	計度：8元/度	B2	23064468			121.49985	25.03476	2026-05-01 01:00:08+00	0101000020E6100000F5B9DA8AFD5F5E407E350708E6083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0007	花博公園圓山地下停車場	93158315	1	2	2	2	2	{"slow_ac": 2}	7x24 小時	計時/每日/40元每小時(0800-2200)，20元每小時(2200-0800)	計分/5元每30分(充電)，10元每30分(佔位未充電)	B1	0800-021-111			121.52041	25.06892	2026-05-01 01:00:08+00	0101000020E6100000BAA0BE654E615E40520ABABDA4113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE1733	USPACE三寶大樓地下停車場	94175832	3	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	計時/每日/60元每小時，每日最高/320元 每日	計分/1.25 元每分	B1	7751-8097			121.53652	25.06005	2026-05-01 01:00:08+00	0101000020E61000009869FB5756625E40F31FD26F5F0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0992	好市多北投分公司	94175832	3	14	14	14	14	{"slow_ac": 14}	每日/10:00-21:30	計時/每日/100元每小時，每日最高無上限	計度/固定/8 元每度	B1	0228941838			121.47012	25.12759	2026-05-01 01:00:08+00	0101000020E6100000834C3272165E5E40F14BFDBCA9203940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE1792	USPACE北投晶泉丰旅停車場	94175832	3	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/平日/30元每小時，每日最高無上限；計時/假日/100元每小時，每日最高無上限	計分/1.25 元每分	B1	0277518097			121.50444	25.13805	2026-05-01 01:00:08+00	0101000020E6100000D5B2B5BE48605E407A36AB3E57233940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE1793	大安國中地下停車場	28114216	2	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	計時/每日(08~21)/50元每小時/每日最高/300元每日,計時/每日(21~08)/10元每小時/每日最高/300元每日	計度/固定/8.00元每度	B1	2799-5657			121.54621	25.02974	2026-05-01 01:00:08+00	0101000020E6100000E2AFC91AF5625E400F62670A9D073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0040	USPACE 福林第一停車場	94175832	3	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	計時/平日/50元每小時，每日最高/280元 每日；計時/假日/70元每小時，每日最高無上限	計分/1.25 元每分	B1	0277518097			121.52729	25.09278	2026-05-01 01:00:08+00	0101000020E610000080608E1EBF615E400FB9196EC0173940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1820	臺北市內湖區內湖國民小學孝悌樓地下停車場	52883637	2	1	1	1	1	{"slow_ac": 1}	周一至周五晚間6時30分至翌日早上6時30分及例假日全天	校園案預設以分計費	計度/固定/8.5 元每度	1	0227970237#1313			121.58007	25.08022	2026-05-01 01:00:08+00	0101000020E610000002D9EBDD1F655E40317C444C89143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE1401	青年一期社會住宅地下停車場	94175832	2	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	計時/每日/30元每小時，每12小時最高/150元每12小時	計度/固定/8 元每度	B1	0800076080			121.50347	25.02026	2026-05-01 01:00:08+00	0101000020E610000018213CDA38605E40BE6A65C22F053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0006	峨眉立體停車場	28114216	2	10	10	10	10	{"slow_ac": 10}	每日/00:00-24:00	計時/平日(10~22)/50元每小時,計時/平日(22~10)/10元每小時,計時/假日(10~22)/60元每小時,計時/假日(22~10)/10元每小時	計度/固定/8.00元每度	1,4				121.50531	25.04423	2026-05-01 01:00:08+00	0101000020E6100000DF15C1FF56605E40888043A8520B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE1258	臺北市大龍新城地下停車場	28007736	1	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	計時/每日/50元每小時	計度/8元每度	B2	022265-1151			121.51427	25.07499	2026-05-01 01:00:08+00	0101000020E610000017D4B7CCE9605E40EC866D8B32133940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1354	好市多內湖店停車場	94175832	3	14	14	14	14	{"slow_ac": 14}	每日/10:00-21:30	計時/每日/100元每小時，每日最高無上限	計度/固定/8 元每度	B1	4499909			121.57552	25.06441	2026-05-01 01:00:08+00	0101000020E6100000698CD651D5645E400D897B2C7D103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1056	便利停車場瑞光站	94175832	3	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/每日/30元每小時，每日最高/170元 每日	計分/1 元每分	B1	2799-1001#168			121.58197	25.07072	2026-05-01 01:00:08+00	0101000020E6100000335019FF3E655E40522CB7B41A123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0800	南港軟體園區南軟大樓地下室停車場	94175832	3	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/30元每小時，每日最高無上限	計分/1.25 元每分	B1	022654-9101#369			121.61445	25.0574	2026-05-01 01:00:08+00	0101000020E6100000BEC1172653675E4058CA32C4B10E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE1048	南港軟體園區經貿大樓地下停車場	94175832	3	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/30元每小時，每日最高無上限	計分/1.25 元每分	B1	2654-9101			121.61623	25.05711	2026-05-01 01:00:08+00	0101000020E61000001A34F44F70675E404A46CEC29E0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1388	大港墘公園地下停車場	28114216	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/平日(08~20)/40元每小時/每日最高/280元每日,計時/平日(20~08)/20元每小時/每日最高/280元每日,計時/假日/20元每小時/每日最高/280元每日	計度/固定/8.00元每度	B1	0227995657			121.5743	25.07851	2026-05-01 01:00:08+00	0101000020E6100000F085C954C1645E40B2683A3B19143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1604	東湖立體停車場	28114216	2	15	15	15	15	{"slow_ac": 15}	每日/00:00-24:00	計時/每日(08~21)/40元每小時/每日最高/200元每日,計時/每日(21~08)/20元每小時/每日最高/200元每日	計度/固定/8.00元每度	B2	(02)27995657			121.61243	25.06902	2026-05-01 01:00:08+00	0101000020E6100000B745990D32675E4019C5724BAB113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0014	USPACE晶華酒店附設停車場	94175832	3	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/100元每小時，每日最高無上限	計分/1.25 元每分	B1	7751-8097			121.52424	25.05416	2026-05-01 01:00:08+00	0101000020E610000053D0ED258D615E4059C0046EDD0D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0447	大潤發中崙店停車場	94175832	3	12	12	12	12	{"slow_ac": 12}	每日/00:00-24:00	計時/每日/50元每小時，每日最高無上限	計分/1.25 元每分	B1	8772-6635			121.54249	25.04695	2026-05-01 01:00:08+00	0101000020E61000000D1AFA27B8625E40158C4AEA040C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0493	便利停車場民生站	94175832	3	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/每日/60元每小時，每日最高無上限	計分/1 元每分	B1	2799-1001			121.53872	25.05758	2026-05-01 01:00:08+00	0101000020E6100000DF6C73637A625E4058E71890BD0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0247	永田停車場	28007736	3	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	計時/每日/30元每小時	計分/ 0.9元每分	B5	2370-5266			121.51573	25.04572	2026-05-01 01:00:08+00	0101000020E61000003BE466B801615E40EBC5504EB40B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0155	市民大道復敦段停車場	28114216	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	計時/平日(08~12)/30元每小時,計時/平日(12~23)/40元每小時,計時/平日(23~08)/10元每小時,計時/假日(08~12)/60元每小時,計時/假日(12~08)/10元每小時	計度/固定/8.00元每度	B1	2799-5657			121.54678	25.04508	2026-05-01 01:00:08+00	0101000020E6100000D7868A71FE625E4024B4E55C8A0B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0163	市民大道敦延段停車場	28114216	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	計時/平日(08~23)/30元每小時,計時/平日(23~08)/10元每小時,計時/假日(08~18)/30元每小時,計時/假日(18~23)/40元每小時,計時/假日(23~08)/10元每小時	計度/固定/8.00元每度	B1	022799-5657			121.55061	25.04467	2026-05-01 01:00:08+00	0101000020E610000070B6B9313D635E40C11C3D7E6F0B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0164	市民大道延吉段停車場	28114216	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/平日(08~12)/30元每小時,計時/平日(12~23)/40元每小時,計時/平日(23~08)/10元每小時,計時/假日(08~12)/40元每小時,計時/假日(12~23)/50元每小時,計時/假日(23~08)/10元每小時	計度/固定/8.00元每度	B1	022799-5657			121.55357	25.04437	2026-05-01 01:00:08+00	0101000020E6100000FD82DDB06D635E406CEC12D55B0B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE1402	健康1區社會住宅地下停車場	94175832	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	計時/每日/30元每小時，每12小時最高/170元每12小時	計度/固定/8 元每度	B1	0277518097			121.56408	25.05438	2026-05-01 01:00:08+00	0101000020E6100000F91400E319645E40758E01D9EB0D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE1403	健康2區社會住宅地下停車場	94175832	2	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	計時/每日/30元每小時，每12小時最高/170元每12小時	計分/6.9 元每分	B1	027751-8097			121.56587	25.05448	2026-05-01 01:00:08+00	0101000020E610000067F2CD3637645E403D49BA66F20D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0038	王朝大酒店	94175832	3	10	10	10	10	{"slow_ac": 10}	每日/00:00-24:00	計時/平日/100元每小時，每日最高無上限；計時/假日/150元每小時，每日最高無上限	計分/1.25 元每分	B1	2719-8399			121.54857	25.05278	2026-05-01 01:00:08+00	0101000020E6100000456458C51B635E4004E275FD820D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0656	宏國大樓停車場	94175832	3	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	免費	計分/1.25 元每分	B1	0225147188			121.54958	25.05464	2026-05-01 01:00:08+00	0101000020E610000049A297512C635E40AE0D15E3FC0D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE1598	USPACE富邦敦北大樓	94175832	3	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	計時/平日/40元每小時，每日最高無上限；計時/假日/60元每小時，每日最高無上限	計分/1.25 元每分	B1	027751-8097			121.54824	25.04523	2026-05-01 01:00:08+00	0101000020E6100000FB96395D16635E404FCC7A31940B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0874	臺北文創停車場	94175832	3	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	計時/每日/80元每小時，每日最高無上限	計分/1.1 元每分	B1	66386398			121.56193	25.04466	2026-05-01 01:00:08+00	0101000020E61000000B293FA9F6635E407A7077D66E0B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0022	台北君悅酒店停車場	94175832	3	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	計時/每日/70元每小時，每日最高無上限	計分/1.25 元每分	B1	02-27290580			121.56262	25.03556	2026-05-01 01:00:08+00	0101000020E6100000D50451F701645E40B70BCD751A093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0343	USPACE 宏泰A19購物中心停車場	94175832	3	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/70元每小時，每日最高無上限	計分/1 元每分	B1	02-77518097			121.56776	25.03568	2026-05-01 01:00:08+00	0101000020E610000087FE092E56645E400C1F115322093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1053	USPACE交易一號停車場	94175832	3	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/平日/60元每小時，每日最高/380元 每日；計時/假日/80元每小時，每日最高無上限	計分/1.25 元每分	B1				121.56875	25.03722	2026-05-01 01:00:08+00	0101000020E61000006666666666645E40D3C1FA3F87093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1054	USPACE交易二號停車場	94175832	3	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	計時/每日/80元每小時，每日最高/380元 每日	計分/1 元每分	B1				121.56869	25.03608	2026-05-01 01:00:08+00	0101000020E6100000FCE3BD6A65645E40280AF4893C093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0741	大安運動中心停車場	94175832	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/每日/30元每小時，每日最高無上限	計分/1.25 元每分	B1	2377-0300			121.5462	25.02052	2026-05-01 01:00:08+00	0101000020E6100000D044D8F0F4625E40F7E978CC40053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE1292	三井飯店停車場	94175832	3	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	計時/平日/60元每小時，每日最高/250元 每日；計時/假日/80元每小時，每日最高/350元 每日	計分/1.25 元每分	B1	0953022736			121.53416	25.0418	2026-05-01 01:00:08+00	0101000020E610000035B56CAD2F625E4009F9A067B30A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0468	富邦金融大樓停車場	94175832	3	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/80元每小時，每日最高無上限	計分/1.25 元每分	B1	2771-6699#68995、7751-8097			121.55221	25.03829	2026-05-01 01:00:08+00	0101000020E61000008CA19C6857635E408BC3995FCD093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0502	USPACE仁愛帝寶停車場	94175832	3	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/平日/40元每小時，每日最高/200元 每日；計時/假日/110元每小時，每日最高/440元 每日	計分/1.25 元每分	B1	7751-8097			121.53729	25.03922	2026-05-01 01:00:08+00	0101000020E6100000F19D98F562625E40605969520A0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0702	臺北市立金華國民中學	28007736	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	計次/每日/70元每次	計度/8元每度	1	33931799			121.53308	25.03141	2026-05-01 01:00:08+00	0101000020E6100000B58993FB1D625E4072C45A7C0A083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE1099	USPACE電信大樓停車場	94175832	3	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/80元每小時，每日最高/300元 每日	計分/1.1 元每分	B1	7751-8097			121.55443	25.02633	2026-05-01 01:00:08+00	0101000020E6100000F67AF7C77B635E4058E71890BD063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE1715	富山杭州南路停車場	28007736	3	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	計時/每日/60元每小時	計度/8元每度	1	2265-1151			121.52255	25.03062	2026-05-01 01:00:08+00	0101000020E610000096218E7571615E40809A5AB6D6073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0311	便利停車場大安地政事務所站	94175832	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/半小/35元/半小時(第一小時以一小時計費)，每日最高無上限	計分/1.25 元每分	B1	2799-1001#166			121.55648	25.0337	2026-05-01 01:00:08+00	0101000020E610000032384A5E9D635E400DE02D90A0083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE1081	臺北和平籃球館停車場	94175832	1	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	計時/平日/30元每小時每日最高無上限 每日；計時/假日/40元每小時，每日最高無上限	計分/1.25 元每分	B1	2377-0300			121.54587	25.02211	2026-05-01 01:00:08+00	0101000020E61000008577B988EF625E4021EA3E00A9053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0944	便利停車場富敦站	94175832	3	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/每日/60元每小時，每日最高無上限	計分/1.25 元每分	B1	2799-1001#168			121.54948	25.04441	2026-05-01 01:00:08+00	0101000020E6100000977329AE2A635E40889D29745E0B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE1864	振華公園地下停車場	28652185	2	13	13	13	13	{"slow_ac": 13}	每日/00:00-24:00	計時/每日/40 元每小時/每日最高/240 元每日	計度/固定/8元每度	B1	0227995657			121.51822	25.11576	2026-05-01 01:00:08+00	0101000020E6100000850838842A615E405A2F8672A21D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE1675	168停車聯盟-士林場	80158495	1	1	1	1	1	{"slow_ac": 1}	24H	60/1H	慢充每度8元	1	(02)27546661			121.53243	25.11172	2026-05-01 01:00:08+00	0101000020E6100000325A475513625E40224F92AE991C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0896	168停車聯盟-大龍場	80158495	1	1	1	1	1	{"slow_ac": 1}	24H	50/1H	慢充每度8元	1	022754-6661			121.51717	25.06905	2026-05-01 01:00:08+00	0101000020E61000003A1E335019615E40EFC9C342AD113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE1267	168停車聯盟-西園國宅場	97329493	1	1	1	1	1	{"slow_ac": 1}	24H	150/1H	慢充每度8元	1	27546661#18			121.49138	25.02694	2026-05-01 01:00:08+00	0101000020E6100000257A19C5725F5E4049F4328AE5063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0639	168停車聯盟-昆陽場(南港信義保管場)	80158495	3	1	1	1	1	{"slow_ac": 1}	24H	150/1H	慢充每度8元	1	0227546661#18			121.58581	25.04922	2026-05-01 01:00:08+00	0101000020E6100000DDEA39E97D655E40224F92AE990C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE1476	168停車聯盟-水源市場	88324010	1	2	2	2	2	{"slow_ac": 2}	24H	60/1H	慢充每度8元	1	2754-6661			121.535	25.01374	2026-05-01 01:00:08+00	0101000020E61000000AD7A3703D625E40A4A5F27684033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0459	168停車聯盟-華視停車場	80158495	3	1	1	1	1	{"slow_ac": 1}	24H	150/1H	慢充每度5元	1	27546661			121.55698	25.04373	2026-05-01 01:00:08+00	0101000020E6100000AB21718FA5635E40A5DAA7E3310B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE1650	168停車聯盟-興岩社福大樓	93161281	1	3	3	3	3	{"slow_ac": 3}	24H	60/1H	慢充每度8元	1	022754-6661#18			121.54869	25.00027	2026-05-01 01:00:08+00	0101000020E61000001A69A9BC1D635E40802BD9B111003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE1589	景美女中地下停車場	52693448	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/20 元每小時，無上限	計度/正常/00:00-24:00/8元每度	B2	6603-9014			121.55619	24.9808	2026-05-01 01:00:08+00	0101000020E61000002F17F19D98635E40B3EA73B515FB3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE1148	永建國小地下停車場	52693448	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	計時/每日/30 元每小時	計度/正常/00:00-24:00/8元每度	B1	22347883			121.55566	24.98904	2026-05-01 01:00:08+00	0101000020E610000081ECF5EE8F635E40936FB6B931FD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE1411	興隆D1社會住宅地下停車場	52693448	2	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	計時/每日/20 元每小時	計度/正常/00:00-24:00/8元每度	B1	2939-8930			121.55793	24.98833	2026-05-01 01:00:08+00	0101000020E610000044DD0720B5635E40DBA7E33103FD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE1164	興隆D2社會住宅地下停車場	52693448	2	7	7	7	7	{"slow_ac": 7}	每日/00:00-24:00	計時/每日/20 元每小時，每日最高/150 元每日	計度/正常/00:00-24:00/8元每度	B2	8661-7601			121.56261	24.98811	2026-05-01 01:00:08+00	0101000020E6100000C4995FCD01645E40BED9E6C6F4FC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1773	臺北市內湖區新湖國民小學活動中心地下停車場	08612854	2	3	3	3	3	{"slow_ac": 3}	本場為月租場，未開放臨時停車。	本場為月租場，未開放臨時停車。	● 計度 / 固定 / 6 元每度	B1	0227963721#121			121.58803	25.06885	2026-05-01 01:00:08+00	0101000020E610000048C49448A2655E4061545227A0113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0082	民權公園地下停車場	89132567	2	14	14	14	14	{"slow_ac": 14}	7x24 小時	計時/每日 08:00~22:00/30元/每小時, 每日 22:00~08:00/10元/每小時 	計度/固定/8元每度	B1	0227676903			121.55896	25.06136	2026-05-01 01:00:08+00	0101000020E61000006BF12900C6635E405648F949B50F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE1562	臺北市立明倫高級中學停車場	93519232	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	無臨停。季繳：7,200元，半年繳優惠：14,000元(每月2,400元)	計分/固定/0.8 元每分	B1	2596-1567			121.51983	25.0756	2026-05-01 01:00:08+00	0101000020E6100000B35E0CE544615E40DE9387855A133940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0535	濱江國中地下停車場	89132567	2	5	5	5	5	{"slow_ac": 5}	7x24 小時	計時/每日/10元/每小時, 計時/每日/20元/每小時	計度/固定/8元每度	B1	2502-3333			121.56168	25.07956	2026-05-01 01:00:08+00	0101000020E61000004EB4AB90F2635E40DC114E0B5E143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE1809	華榮社宅場	53703514	1	2	2	2	2	{"slow_ac": 2}	7x24 小時	計時/每日/150 元每小時;計次/每日/400 元每次	計度/固定/12 元每度	B1	0277381111			121.52257	25.0965	2026-05-01 01:00:08+00	0101000020E6100000BAF770C971615E4062105839B4183940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE1227	臺北市中正區社會福利綜合大樓附設停車場	53703514	2	1	1	1	1	{"slow_ac": 1}	平日/08:00-18:00,假日/08:00-18:00	計次/每日/200 元每次	計度/固定/0 元每度	1	2381-0267			121.50769	25.03278	2026-05-01 01:00:08+00	0101000020E610000066A032FE7D605E407FF6234564083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0068	敦北翠苑停車場	28007736	3	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/每日/60元每小時	計分/ 0.7元每分	B1	0225474157			121.55054	25.05599	2026-05-01 01:00:08+00	0101000020E6100000F3C81F0C3C635E402EE7525C550E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0255	助安企業有限公司懷愛館地下停車場	89132567	1	7	7	7	7	{"slow_ac": 7}	7x24 小時	計時/每日/50元/每小時	計度/固定/8元每度	B3	27546661			121.55293	25.01377	2026-05-01 01:00:08+00	0101000020E61000008CBE823463635E407AAA436E86033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE1400	東明乙區社會住宅地下停車場	88260607	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/平日/20 元每小時, 計時/假日/40 元每小時	計度/固定/8 元每度	B1	0228318671			121.60407	25.05453	2026-05-01 01:00:08+00	0101000020E6100000A99F3715A9665E40A0A696ADF50D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0928	兒童新樂園停車場	42441649	1	9	9	9	9	{"slow_ac": 9}	24小時	計時/平日/30元每小時，計時/假日/40元每小時	計度/固定/8元每度	1	0228345378			121.51484	25.09754	2026-05-01 01:00:08+00	0101000020E61000000DAB7823F3605E40450DA661F8183940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE1544	北投稻香地下停車場	88395963	1	3	3	3	3	{"slow_ac": 3}	24小時	目前無收費	目前無收費 	B2	0228983536			121.48936	25.14095	2026-05-01 01:00:08+00	0101000020E61000001EFE9AAC515F5E40075F984C15243940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0712	臺北田徑場平面、地下停車場	88258237	1	6	6	6	6	{"slow_ac": 6}	7*24小時	汽車40元/時(08-20)，當日最高上限230元，30元/時(20-08)，全程以半小時計費	免費	B1	0225798520			121.55081	25.04886	2026-05-01 01:00:08+00	0101000020E6100000D313967840635E402315C616820C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0935	臺北市立大學天母校區體育館平面停車場	88177523	1	2	2	2	2	{"slow_ac": 2}	每日00:00至24:00	平日30元/每小時 12小時最高200元 假日50元/每小時 12小時最高350元	計度/固定/8元每度	1	0228726018			121.5356	25.11602	2026-05-01 01:00:08+00	0101000020E610000035EF384547625E4092AE997CB31D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0201U02	國立臺灣大學公館平面停車場	90807408	2	7	7	7	7	{"slow_ac": 7}	每日/00:00-24:00	40元/小時	AC/計度/一般/ 7.8000元每度	1	33663366			121.53844	25.01241	2026-05-01 01:00:08+00	0101000020E6100000EDB60BCD75625E40B324404D2D033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0709	臺北市立大學天母校區教學、行政科資大樓地下停車場	88177523	1	14	14	14	14	{"slow_ac": 14}	每日00:00至24:00	平日30元/每小時 12小時最高200元 假日50元/每小時 12小時最高350元	計度/固定/8元每度	1,B2	0228726018			121.53644	25.11609	2026-05-01 01:00:08+00	0101000020E61000000A11700855625E4084640113B81D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE1399	東明甲區社會住宅地下停車場	88260590	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	計時/平日/20 元每小時, 計時/假日/40 元每小時	計度/固定/8 元每度	B1	0226510865			121.60395	25.05426	2026-05-01 01:00:08+00	0101000020E6100000D49AE61DA7665E40207BBDFBE30D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0151	臺北體育館地下停車場	88258243	1	3	3	3	3	{"slow_ac": 3}	7*24小時	汽車40元/時(08-20)，當日最高上限230元，30元/時(20-08)，全程以半小時計費	免費	B1	0225798373			121.55195	25.05132	2026-05-01 01:00:08+00	0101000020E6100000BEC1172653635E4077A1B94E230D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0177	健康國小地下停車場	28371994	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	0226550818			121.56267	25.05617	2026-05-01 01:00:08+00	0101000020E61000002E1C08C902645E402E043928610E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0106	附中公園地下停車場	28371994	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	022655-0818			121.54246	25.03623	2026-05-01 01:00:08+00	0101000020E6100000D8D825AAB7625E405322895E46093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0103	嘟嘟房捷運石牌站停車場	33029464	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1	0226550818			121.51454	25.11601	2026-05-01 01:00:08+00	0101000020E6100000F71E2E39EE605E404B02D4D4B21D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0104	嘟嘟房捷運唭哩岸站停車場	33029464	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1	0226550818			121.50644	25.12083	2026-05-01 01:00:08+00	0101000020E6100000B858518369605E402D6002B7EE1E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0117	嘟嘟房捷運北投站停車場	33029464	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1	0226550818			121.49815	25.13284	2026-05-01 01:00:08+00	0101000020E610000027A089B0E15F5E40C4995FCD01223940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0102	嘟嘟房捷運新北投站停車場	33029464	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1	0226550818			121.50144	25.13687	2026-05-01 01:00:08+00	0101000020E6100000003ACC9717605E40B3CD8DE909233940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0114	嘟嘟房捷運忠義站停車場	33029464	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1	0226550818			121.47338	25.1311	2026-05-01 01:00:08+00	0101000020E610000027A5A0DB4B5E5E406F8104C58F213940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0678	嘟嘟房捷運內湖機廠站停車場	33029464	1	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	3	0226550818			121.61881	25.06139	2026-05-01 01:00:08+00	0101000020E6100000041C42959A675E402B4D4A41B70F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0091	嘟嘟房捷運芝山站停車場	33029464	1	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1	0226550818			121.52283	25.10166	2026-05-01 01:00:08+00	0101000020E610000088D7F50B76615E40B54FC763061A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0140	嘟嘟房捷運士林站停車場	33029464	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1	0226550818			121.52637	25.09215	2026-05-01 01:00:08+00	0101000020E61000001DE6CB0BB0615E408F53742497173940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U01	建國北路高架橋下O區	28371994	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53671	25.04689	2026-05-01 01:00:08+00	0101000020E6100000EA5BE67459625E406B82A8FB000C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U11	建國北路高架橋下IB區	28371994	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53701	25.06444	2026-05-01 01:00:08+00	0101000020E6100000FFE7305F5E625E40E38DCC237F103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U12	建國北路高架橋下J區	28371994	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53607	25.06585	2026-05-01 01:00:08+00	0101000020E610000078978BF84E625E400D71AC8BDB103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U08	建國北路高架橋下G區	28371994	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53698	25.05931	2026-05-01 01:00:08+00	0101000020E6100000CAA65CE15D625E406553AEF02E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U09	建國北路高架橋下H區	28371994	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53695	25.06076	2026-05-01 01:00:08+00	0101000020E6100000956588635D625E40ABE7A4F78D0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U06	建國北路高架橋下E區	28371994	2	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53697	25.05657	2026-05-01 01:00:08+00	0101000020E6100000B83B6BB75D625E404AEF1B5F7B0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U07	建國北路高架橋下F區	28371994	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53693	25.05719	2026-05-01 01:00:08+00	0101000020E6100000718FA50F5D625E4082A8FB00A40E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U03	建國北路高架橋下B區	28371994	2	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53677	25.04989	2026-05-01 01:00:08+00	0101000020E610000055DE8E705A625E40BF654E97C50C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U04	建國北路高架橋下C區	28371994	2	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53685	25.0534	2026-05-01 01:00:08+00	0101000020E6100000E3361AC05B625E403D9B559FAB0D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U05	建國北路高架橋下D區	28371994	2	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53687	25.0542	2026-05-01 01:00:08+00	0101000020E6100000060DFD135C625E4076711B0DE00D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U02	建國北路高架橋下A區	28371994	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53676	25.04922	2026-05-01 01:00:08+00	0101000020E610000043739D465A625E40224F92AE990C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0645	僑安地下停車場	28371994	2	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	2655-0818			121.5566	25.04045	2026-05-01 01:00:08+00	0101000020E6100000083D9B559F635E408A1F63EE5A0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0100	市民大道中林段停車場	28371994	2	10	10	10	10	{"slow_ac": 10}	每日/00:00-24:00	每1小時0元	計時/每日/5元每1度	B1	2655-0818			121.52274	25.0479	2026-05-01 01:00:08+00	0101000020E6100000E813799274615E40787AA52C430C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0110	市民大道林金段停車場	28371994	2	19	19	19	19	{"slow_ac": 19}	每日/00:00-24:00	每1小時0元	計時/每日/5元每1度	B1	2655-0818			121.52792	25.04687	2026-05-01 01:00:08+00	0101000020E6100000E0B9F770C9615E40DC291DACFF0B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0051	八德立體停車場	28371994	2	7	7	7	7	{"slow_ac": 7}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	0226550818			121.5714	25.04959	2026-05-01 01:00:08+00	0101000020E6100000CD3B4ED191645E40693524EEB10C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0011	中山堂地下停車場	28371994	2	9	9	9	9	{"slow_ac": 9}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	2655-0818			121.51059	25.04404	2026-05-01 01:00:08+00	0101000020E610000089EAAD81AD605E4041B79734460B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0355	中崙高中地下停車場	28371994	2	7	7	7	7	{"slow_ac": 7}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B2	0226550818			121.5614	25.05002	2026-05-01 01:00:08+00	0101000020E61000005DFE43FAED635E405B25581CCE0C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0228U10	建國北路高架橋下IA區	28371994	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1	2655-0818			121.53705	25.06337	2026-05-01 01:00:08+00	0101000020E61000004694F6065F625E402A8C2D0439103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0680	七星公園地下停車場	28371994	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	B1	0226550818			121.50219	25.13655	2026-05-01 01:00:08+00	0101000020E6100000359886E123605E40D044D8F0F4223940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0316	陽明大學停車場	90807408	1	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.000元每度	B1	0800208333			121.5134	25.11966	2026-05-01 01:00:08+00	0101000020E61000000D71AC8BDB605E40ADA3AA09A21E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	未分類	TPE0611	臺北市立明德國民中學附設停車場	90807408	3	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00		AC/計度/一般/ 8.0元每度	1				0.0	0.0	2026-05-01 01:00:08+00	0101000020E610000000000000000000000000000000000000
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	未分類	TPE0648	巧愛公寓地下室停車場	90807408	3	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00		AC/計度/一般/ 8.000元每度	1				0.0	0.0	2026-05-01 01:00:08+00	0101000020E610000000000000000000000000000000000000
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	未分類	TPE0892	新北投公園停車場	90807408	3	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00		AC/計度/一般/ 8.000元每度	1				0.0	0.0	2026-05-01 01:00:08+00	0101000020E610000000000000000000000000000000000000
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE1674	北投運動中心停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.000元每度	B1	(02)28202880；0932-200970			121.5098	25.11612	2026-05-01 01:00:08+00	0101000020E61000000DE02D90A0605E405969520ABA1D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE1560	博客停車場-家福公館場	42861108	1	4	4	4	0	{}	7x24小時	計時/每日/40元每小時	計時/浮動/0.7元每分	1F	(02)29488889			121.50726	25.12773	2026-05-01 01:00:08+00	0101000020E61000006AA4A5F276605E40D4B7CCE9B2203940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1795	潭美停車場	83058885	3	2	2	1	1	{"slow_ac": 1}	星期一：00:00～23:59星期二：00:00～23:59星期三：00:00～23:59星期四：00:00～23:59星期五：00:00～23:59星期六：00:00～23:59星期日：00:00～23:59	計時/每日/40 元每小時	計度/尖峰/09:00-23:59/5.51 元每度, 計度/尖峰/06:00-11:00/5.42 元每度, 計度/尖峰/14:00-23:59/5.42 元每度, 計度/離峰/23:59-09:00/3.46 元每度, 計度/離峰/23:59-06:00/3.39 元每度, 計度/離峰/11:00-14:00/3.39 元每度, 計度/半尖峰/09:00-23:59/4.14 元每度, 計度/半尖峰/06:00-11:00/4.06 元每度, 計度/半尖峰/14:00-23:59/4.06 元每度, 	1	0958388960			121.59348	25.06105	2026-05-01 01:00:08+00	0101000020E610000020B58993FB655E40BA6B09F9A00F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE1868	南港重陽停車場	83058885	3	2	2	1	1	{"slow_ac": 1}	星期一：00:00～23:59星期二：00:00～23:59星期三：00:00～23:59星期四：00:00～23:59星期五：00:00～23:59星期六：00:00～23:59星期日：00:00～23:59	計時/每日/40 元每小時	計度/尖峰/09:00-23:59/5.51 元每度, 計度/尖峰/06:00-11:00/5.42 元每度, 計度/尖峰/14:00-23:59/5.42 元每度, 計度/離峰/23:59-09:00/3.46 元每度, 計度/離峰/23:59-06:00/3.39 元每度, 計度/離峰/11:00-14:00/3.39 元每度, 計度/半尖峰/09:00-23:59/4.14 元每度, 計度/半尖峰/06:00-11:00/4.06 元每度, 計度/半尖峰/14:00-23:59/4.06 元每度, 	1				121.59824	25.05528	2026-05-01 01:00:08+00	0101000020E61000002ECA6C9049665E40751F80D4260E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0118	臺北市立聯合醫院-陽明院區停車場	90807408	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	40元/時	AC/計度/一般/ 8.000元每度	1	0800000269			121.53165	25.10566	2026-05-01 01:00:08+00	0101000020E6100000C7BAB88D06625E40D07EA4880C1B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0402	臺北市立聯合醫院-中興院區停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	40元/時	AC/計度/一般/ 8.000元每度	1	0800000269			121.50876	25.05119	2026-05-01 01:00:08+00	0101000020E6100000D4601A868F605E40DAE1AFC91A0D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0354	朝陽公園地下停車場	52693448	2	5	5	4	4	{"slow_ac": 4}	每日/00:00-24:00	計時/平日/40 元每小時，每日最高/200 元每日；計時/假日/40 元每小時，無上限	計度/正常/00:00-24:00/8元每度	B1	2959-9991			121.51369	25.05614	2026-05-01 01:00:08+00	0101000020E61000001092054CE0605E4058FFE7305F0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0760	叭叭房亞太C區停車場	90807408	3	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	20元/30分鐘	AC/計度/一般/ 8.000元每度	1	2655-0000			121.57595	25.07233	2026-05-01 01:00:08+00	0101000020E61000006688635DDC645E400A85083884123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1032	CITYLINK 內湖店停車場	90807408	1	13	12	13	13	{"slow_ac": 11, "medium_dc": 2}	每日/00:00-24:00	20元/半小時(平日每12小時最高收費120元、假日每12小時最高收費200元)	AC/計度/一般/ 8.000元每度;DC/計度/一般/ 9.8000元每度	5	0227831863			121.59439	25.08413	2026-05-01 01:00:08+00	0101000020E610000072C45A7C0A665E40CB9C2E8B89153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0530	臺北市南港運動中心停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	每日/05:50-22:30	30元/時	AC/計度/一般/ 8.000元每度	B3	0226532279			121.58169	25.04868	2026-05-01 01:00:08+00	0101000020E6100000419AB1683A655E4023F8DF4A760C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0901	台北花卉產銷股份有限公司A館	22957668	1	10	9	9	9	{"slow_ac": 9}	平日/00:00-24:00,假日 /00:00-24:00	計時/每日/30 元每小時	計度/固定/10 元每度	3	0227909729			121.57417	25.063	2026-05-01 01:00:08+00	0101000020E610000009168733BF645E40E3A59BC420103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0902	台北花卉產銷股份有限公司B館	22957668	1	20	2	2	2	{"slow_ac": 2}	平日/00:00-24:00,假日 /00:00-24:00	計時/每日/30 元每小時	計度/固定/10 元每度	2	0227909729			121.5751	25.06304	2026-05-01 01:00:08+00	0101000020E61000007FFB3A70CE645E400057B26323103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0824	建成公園地下停車場	90807408	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	30元/周一~周五，40元/周六~周日	AC/計度/一般/ 8.000元每度	B1	0226550818			121.51822	25.05389	2026-05-01 01:00:08+00	0101000020E6100000850838842A615E40D9942BBCCB0D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0239	建成國中地下停車場	90807408	2	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	40元/8:00~22:00，10元/22:00~8:00	AC/計度/一般/ 8.000元每度	 B1,B1	2759-0666			121.51975	25.05166	2026-05-01 01:00:08+00	0101000020E61000002506819543615E40E882FA96390D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE1206	臺北市立大同高級中學附設停車場	94128120	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/每日50 元每小時每日最高/300 元每日	週日/固定/8.0000元(每度),週一/固定/8.0000元(每度),週二/固定/8.0000元(每度),週三/固定/8.0000元(每度),週四/固定/8.0000元(每度),週五/固定/8.0000元(每度),週六/固定/8.0000元(每度)	1	0225235000			121.53626	25.05729	2026-05-01 01:00:08+00	0101000020E6100000CA89761552625E404963B48EAA0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0389	臺北農產運銷股份有限公司第二果菜批發市場地下三樓停車場(濱江市場地下停車場)	01176272	1	20	7	7	7	{"slow_ac": 7}	平日/00:00-24:00,假日 /00:00-24:00	計時/每日30 元每小時	計度/固定/9 元每度	B3	2516-2519#1125、1116、1117			121.53735	25.06765	2026-05-01 01:00:08+00	0101000020E61000005C2041F163625E400C93A98251113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0997	台北美福大飯店停車場	90807408	3	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	120元/時(未滿1小時以1小時計算，逾1小時以上，未滿半小時以半小時計算)	AC/計度/一般/ 8.0元每度	B4	0277325599			121.55407	25.08022	2026-05-01 01:00:08+00	0101000020E6100000766C04E275635E40317C444C89143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0220	台北地下街停車場	90807408	1	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	依場域公告為準	AC/計度/一般/ 8.000元每度	B2	25594566#508			121.51801	25.04851	2026-05-01 01:00:08+00	0101000020E610000010406A1327615E406A87BF266B0C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0665	臺北市立聯合醫院-婦幼院區停車場	90807408	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	40元/時	AC/計度/一般/ 8.000元每度	1	0800-000-269；2786-7755			121.51929	25.02908	2026-05-01 01:00:08+00	0101000020E6100000F3C81F0C3C615E40BAF770C971073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0666	臺北市立聯合醫院-和平院區停車場	90807408	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	40元/時	AC/計度/一般/ 8.000元每度	1	0800000269			121.50734	25.0356	2026-05-01 01:00:08+00	0101000020E6100000F8FC304278605E40D3BCE3141D093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0529	臺北市中正運動中心地下停車場	85012273	1	2	2	1	1	{"slow_ac": 1}	星期一：06:00～22:00星期二：06:00～22:00星期三：06:00～22:00星期四：06:00～22:00星期五：06:00～22:00星期六：06:00～22:00星期日：06:00～22:00	計時/每日/40 元每小時	計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/8.00 元每度, 計度/離峰/23:59-06:00/8.00 元每度, 計度/離峰/11:00-14:00/8.00 元每度, 計度/半尖峰/09:00-23:59/8.00 元每度, 計度/半尖峰/06:00-11:00/8.00 元每度, 計度/半尖峰/14:00-23:59/8.00 元每度, 	1	23961000			121.51937	25.03836	2026-05-01 01:00:08+00	0101000020E61000008121AB5B3D615E407D7901F6D1093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0054	民生社區中心地下停車場	90807408	2	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.000元每度	B3	0222408767			121.56298	25.05985	2026-05-01 01:00:08+00	0101000020E6100000551344DD07645E4065AA6054520F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0766	市府轉運站停車場	90807408	3	10	10	10	10	{"slow_ac": 10}	每日/00:00-24:00	50元/30分鐘(館內消費滿500元，可折抵1小時)	AC/計度/一般/ 8.000元每度	B4				121.56515	25.04087	2026-05-01 01:00:08+00	0101000020E610000067D5E76A2B645E403563D174760A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1265	臺北市立聯合醫院-松德院區停車場	90807408	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	40元/時	AC/計度/一般/ 8.000元每度	1				121.57543	25.03034	2026-05-01 01:00:08+00	0101000020E6100000C9C859D8D3645E40B9C2BB5CC4073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1667	詮營信義101停車場	90482725	3	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/平日/60元每小時，每日最高/200元每日；計時/假日及定假日/60元每小時，每日最高/280元每日	充電費率每度 8 元	1	0227935818			121.56482	25.03262	2026-05-01 01:00:08+00	0101000020E61000001C08C90226645E400E32C9C859083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0571	科技服務大樓附設停車場	90505425	1	3	3	3	3	{"slow_ac": 3}	7x24小時	計時/每日/30元每小時	計時/固定/1元每分	5	0227160802			121.55448	25.05879	2026-05-01 01:00:08+00	0101000020E61000004F92AE997C635E40F35487DC0C0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0129	臺北市立聯合醫院-仁愛院區停車場	90807408	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	40元/時	AC/計度/一般/ 8.000元每度	1	0800000269			121.5445	25.03737	2026-05-01 01:00:08+00	0101000020E6100000022B8716D9625E40FDD98F1491093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0716	景美國小地下停車場	90807408	2	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	周一至周四：11:00~21:00 30元/小時，21:00~11:00 20元/小時；周五至周日　11:00~21:00 40元/小時，21:00~11:00 20元/小時	AC/計度/一般/ 8.000元每度	B1	022240-8767			121.54027	24.98855	2026-05-01 01:00:08+00	0101000020E6100000A3409FC893625E40F775E09C11FD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0318	青年公園棒球場地下停車場	90807408	2	7	7	7	7	{"slow_ac": 7}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.0元每度,AC/計度/尖峰/ 0元每度,AC/計度/離峰/ 0元每度	B1	23092133			121.50307	25.02381	2026-05-01 01:00:08+00	0101000020E61000005166834C32605E405951836918063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0840	歐特儀股份有限公司捷運木柵站轉乘停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	20元/時(06點~22點)，10元/時(22點~06點)	AC/計度/一般/ 8.000元每度	B1	022705-7716			121.57305	24.99818	2026-05-01 01:00:08+00	0101000020E6100000423EE8D9AC645E40738577B988FF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0069	遠企中心地下停車場	97179430	3	8	7	7	7	{"slow_ac": 7}	週日/11:00-21:30,週一至週四/11:00-21:30	計時 /每日/50元每半小時\r\n	計度 /固定 /12元 DC每度	B4	27363033			121.54923	25.02607	2026-05-01 01:00:08+00	0101000020E6100000DAFE959526635E401F680586AC063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0453	臺北市公有士東市場地下室停車場	28007736	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	計時/每日/40元每小時	計分/ 0.8元每分	B2	0228345308			121.52945	25.11196	2026-05-01 01:00:08+00	0101000020E610000080B74082E2615E40CD751A69A91C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE1676	臺北市文山運動中心停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	每日/06:00-22:00	30元/小時	AC/計度/一般/ 7.0元每度,AC/計度/尖峰/ 7.0元每度,AC/計度/離峰/ 7.0元每度	B1	0222308268#221			121.55939	24.99717	2026-05-01 01:00:08+00	0101000020E610000067EDB60BCD635E40658D7A8846FF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0818	葫蘆國小夜間停車場	12981268	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00  [不對外開放] 	免費  [不對外開放] 	免費	1	28129586			121.50758	25.08388	2026-05-01 01:00:08+00	0101000020E6100000A306D3307C605E40DAC9E02879153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0706	Times 松山運動中心	90807408	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	平日/40元，假日/40元(依現場為準)	AC/計度/一般/ 7.000元每度,AC/計度/尖峰/ 7.000元每度,AC/計度/離峰/ 7.000元每度	B1	0809008924			121.55024	25.04884	2026-05-01 01:00:08+00	0101000020E6100000DE3CD52137635E4094BC3AC7800C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0787	公館路平面停車場	90807408	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度	1	(02)25683773			121.5029	25.12122	2026-05-01 01:00:08+00	0101000020E6100000234A7B832F605E40029F1F46081F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE1160	公舘路228巷平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度	1	(02)25683773分機561			121.50504	25.12503	2026-05-01 01:00:08+00	0101000020E6100000FFCA4A9352605E40D50451F701203940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0742	承德公園地下停車場	28371994	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	B1	0226550818			121.52227	25.08976	2026-05-01 01:00:08+00	0101000020E6100000A56B26DF6C615E402C7DE882FA163940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0667	太平洋崇光百貨股份有限公司天母店停車場	97179430	3	3	4	4	8	{"medium_dc": 8}	每日/09:00-23:00	計時 /每日/80元每小時	計度 /固定 /12元 DC每度	B3	(02)27765555分機3898			121.52421	25.10548	2026-05-01 01:00:08+00	0101000020E61000001D8F19A88C615E40D061BEBC001B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0237	東和公園平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度	1	(02)25573722			121.53333	25.1201	2026-05-01 01:00:08+00	0101000020E610000072FE261422625E40E63FA4DFBE1E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0735	忠誠路（二）平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	30元/時	AC/計度/一般/ 0.00元每度	1	(02)25573722			121.52938	25.10666	2026-05-01 01:00:08+00	0101000020E610000004CAA65CE1615E4097CADB114E1B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE1180	士林高商停車場	42649057	2	1	1	1	1	{"slow_ac": 1}	平日/22:30-07:00, 假日/00:00-24:00	季租4,000元；年租16,000元。租借場地如有停車需求，30元/時。	待確認	1	0228313114			121.51687	25.09407	2026-05-01 01:00:08+00	0101000020E61000002592E86514615E40E388B5F814183940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE1767	和興水岸社會住宅地下停車場	50965513	2	3	3	3	3	{"slow_ac": 3}	24小時/每日/00:00-24:00	計時/每日/20元每小時	計度/0:00-24:00/每度8元	B2	25573722			121.54942	24.985	2026-05-01 01:00:08+00	0101000020E61000002CF180B229635E405C8FC2F528FC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE1769	青年二期社會住宅地下停車場	50965513	2	6	6	6	6	{"slow_ac": 6}	24小時/每日/00:00-24:00	計時/每日/每小時30元	計度/00:00-24:00/每度8元	B1	25573722			121.50325	25.02043	2026-05-01 01:00:08+00	0101000020E610000091ED7C3F35605E4077DB85E63A053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1785	廣慈3區社會住宅地下停車場	50965513	2	6	6	6	6	{"slow_ac": 6}	24小時/每日/00:00-24:00	平日$30元/1小時(入場12小時最高$150元)，假日$30元/1小時(無最高上限)	計度/00:00-24:00/每度8元	B2	0225573722			121.58155	25.03856	2026-05-01 01:00:08+00	0101000020E610000048BF7D1D38655E400BEF7211DF093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE1807	興隆A區社會住宅地下停車場	52693448	2	5	5	5	5	{"slow_ac": 5}	每日/00:00~24:00	依現場公告	依現場公告	B2	2939-8935			121.55479	25.00089	2026-05-01 01:00:08+00	0101000020E61000007689EAAD81635E40B8E4B8533A003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0536	延平北路5段1巷平面停車場	90807408	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度	1	0222740068			121.51001	25.07869	2026-05-01 01:00:08+00	0101000020E610000082A8FB00A4605E40B285200725143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0170	社正路平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.0元每度	1	0222740068			121.50908	25.08807	2026-05-01 01:00:08+00	0101000020E61000000DC347C494605E403BC269C18B163940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0963	福林路平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度	1	0227590666			121.53277	25.09633	2026-05-01 01:00:08+00	0101000020E61000008E9257E718625E40A99F3715A9183940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE1346	懷德街55巷平面停車場	90807408	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	30元/時	AC/計度/一般/ 8.0元每度	1	(02)25683773			121.51921	25.11312	2026-05-01 01:00:08+00	0101000020E6100000657094BC3A615E400586AC6EF51C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0971	大業路280巷臨時平面停車場	90807408	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	50元/時	AC/計度/一般/ 8.000元每度	1	0227590666			121.50008	25.12794	2026-05-01 01:00:08+00	0101000020E61000008E588B4F01605E40A9D903ADC0203940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0231	市民大道塔城段停車場	28371994	2	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	每1小時0元	計度/固定/8元每度	B1	0226550818			121.50986	25.05027	2026-05-01 01:00:08+00	0101000020E61000007862D68BA1605E404DF8A57EDE0C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0178	華江橋下與雙層小型車停車場	90807408	2	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	20元/時	AC/計度/一般/ 8.000元每度	1	0909566815			121.49135	25.03543	2026-05-01 01:00:08+00	0101000020E6100000EF384547725F5E401B4CC3F011093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE1435	新和庭園平面停車場	90807408	2	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	40元/時	AC/計度/一般/ 8.000元每度	1	2655-0818			121.50531	25.02791	2026-05-01 01:00:08+00	0101000020E6100000DF15C1FF56605E403A3B191C25073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0407	安康公車調度站臨時平面停車場	85051710	2	3	3	3	3	{"slow_ac": 3}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	27867755			121.61322	25.06733	2026-05-01 01:00:08+00	0101000020E6100000335019FF3E675E40280AF4893C113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0751	叭叭房陽光大樓停車場	00570949	3	5	5	5	5	{"slow_ac": 5}	每日/00:00~24:00	依現場公告	依現場公告	1	2655-0000			121.57816	25.07363	2026-05-01 01:00:08+00	0101000020E6100000BEF6CC9200655E4026016A6AD9123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0959	南港車站地下停車場	28652185	3	32	32	32	44	{"slow_ac": 20, "medium_dc": 24}	每日/00:00-24:00	計時/平日/40元每小時/每日最高/240元每日,計時/假日/50元每小時/每日最高/240元每日	慢充：計度/固定/9.00元每度, 快充：計度/固定/15.00元每度	B2	0227995657			121.60374	25.05211	2026-05-01 01:00:08+00	0101000020E61000005FD218ADA3665E4068CBB914570D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0099	市民大道公中段停車場	28371994	2	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	每1小時0元	計度/固定/8元每度	B1	2655-0818			121.51917	25.04835	2026-05-01 01:00:08+00	0101000020E61000001EC4CE143A615E40F8C264AA600C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0123	中山北路3段55巷平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時40元	計度/每度8.00元	1	2504-6290 分機85082鍾先生			121.52364	25.06802	2026-05-01 01:00:08+00	0101000020E610000028B8585183615E4053793BC269113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0738	臺北農產運銷股份有限公司第二果菜批發市場停車場	01176272	1	10	12	12	12	{"slow_ac": 12}	平日/00:00-24:00,假日 /00:00-24:00	計時/每日/30 元每小時	計度/固定/9 元每度	5	2516-2519#1122、1125			121.53721	25.06777	2026-05-01 01:00:08+00	0101000020E610000063450DA661625E4061A6ED5F59113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE1142	城中社會福利綜合大樓地下停車場	42649057	1	1	1	1	1	{"slow_ac": 1}	24小時	計時：小型車150元/時，全程以半小時計。計次：機車50元/次，隔日另計。月租：小型車8,500元/月、機車1,000元/月。	待確認	B2	24551299			121.509	25.0388	2026-05-01 01:00:08+00	0101000020E61000007F6ABC7493605E40B515FBCBEE093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE1624	臺北市客家文化中心附設地下停車場	73981000	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	計時/每日/40元每小時	計分/1元每分	B1	2369-1198			121.52488	25.02054	2026-05-01 01:00:08+00	0101000020E6100000C49448A297615E408542041C42053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1238	遠東百貨信義分公司	97179430	3	3	2	2	4	{"medium_dc": 4}	週日-週四/11:00-21:30,週五-週六及例假日前一天/11:00-22:00	計時 /每日/100元每小時	計度 /固定 /12元 DC每度	B4	027750-0888			121.56795	25.03693	2026-05-01 01:00:08+00	0101000020E6100000D8F0F44A59645E40C53D963E74093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE0409	吳興街284巷臨時平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時40元	計度/每度8.00元	1	2246-1708			121.56367	25.02513	2026-05-01 01:00:08+00	0101000020E610000020EF552B13645E40032670EB6E063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0542	太平洋崇光百貨股份有限公司復興店停車場	97179430	3	3	4	4	8	{"medium_dc": 8}	每日/09:00-22:30	計時 /每日/60元每半小時	計度 /固定 /12元 DC每度	B4	2776-5555分機3898			121.54307	25.04107	2026-05-01 01:00:08+00	0101000020E6100000145CACA8C1625E40C3D84290830A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0127	辛亥高架橋下停車場	85051710	2	3	3	3	3	{"slow_ac": 3}	每日/00:00~24:00	每小時30元	計度/每度8.00元	1	0225046290			121.53368	25.02241	2026-05-01 01:00:08+00	0101000020E6100000E0A128D027625E40761A69A9BC053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0135	太平洋崇光百貨股份有限公司忠孝店停車場	97179430	3	3	2	2	4	{"medium_dc": 4}	每日/09:00-22:30	計時 /每日/60元每半小時	計度 /固定 /12元 DC每度	B3	2776-5555分機3898			121.54489	25.04195	2026-05-01 01:00:08+00	0101000020E6100000B77A4E7ADF625E403411363CBD0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0066	國立臺灣師範大學和平校區Ⅰ運動場地下停車場	97179430	2	9	9	9	9	{"slow_ac": 9}	每日/06:00-24:00	計時 /每日/70 元每小時	計度 /固定 /8.5元 AC 7kW每度	B1	7749-3266			121.52567	25.02602	2026-05-01 01:00:08+00	0101000020E6100000419FC893A4615E40BB0A293FA9063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1875	六張犁1區社宅停車場	28652185	2	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	計時/每日/30元每小時	慢充：計度/固定/8.00元每度	B1				121.55889	25.02747	2026-05-01 01:00:08+00	0101000020E6100000EF0390DAC4635E40029F1F4608073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0067	國立臺灣師範大學和平校區Ⅱ羅馬廣場地下停車場	97179430	2	3	3	3	6	{"medium_dc": 6}	每日/06:00-24:00	計時 /每日/70 元每小時	計度 /固定 /12元 DC 30kW每度	B1	77493266			121.52962	25.02675	2026-05-01 01:00:08+00	0101000020E6100000AED3484BE5615E40022B8716D9063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0232	和平東路四段381巷平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	2518-5299			121.57481	24.99951	2026-05-01 01:00:08+00	0101000020E61000007BDAE1AFC9645E4064062AE3DFFF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0080	興隆市場旁平面停車場	85051710	2	2	2	2	2	{"slow_ac": 2}	每日/00:00~24:00	每小時20元	計度/每度8.00元	1	2246-1708			121.54713	24.99967	2026-05-01 01:00:08+00	0101000020E6100000452A8C2D04635E40D5CA845FEAFF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE1505	國立臺灣師範大學附屬高級中學體育教學館地下停車場	88339626	1	1	1	1	1	{"slow_ac": 1}	星期一：00:00～23:59\r\n星期二：00:00～23:59\r\n星期三：00:00～23:59\r\n星期四：00:00～23:59\r\n星期五：00:00～23:59\r\n星期六：00:00～23:59\r\n星期日：00:00～23:59	免費	計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/8.00 元每度, 計度/離峰/23:59-06:00/8.00 元每度, 計度/離峰/11:00-14:00/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/	B1	2708-6000			121.54014	25.03379	2026-05-01 01:00:08+00	0101000020E6100000BBD05CA791625E408DEE2076A6083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1876	六張犁2區社宅停車場	28652185	2	7	7	7	7	{"slow_ac": 7}	每日/00:00-24:00	計時/每日/30元每小時	慢充：計度/固定/8.00元每度	B1				121.5593	25.02773	2026-05-01 01:00:08+00	0101000020E6100000C7293A92CB635E403A1E335019073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE1883	南港停車場	89132567	3	1	1	1	1	{"slow_ac": 1}	7x24 小時	計時/平日/40元/每小時, 計時/假日/50元/每小時	計度/固定/8元每度	1	0925975999			121.60577	25.05332	2026-05-01 01:00:08+00	0101000020E610000078B988EFC4665E4004392861A60D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE1884	經貿社會住宅地下停車場	00641938	2	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	計時/日間/30 元每小時, 計時/夜間/20 元每小時	計度/固定/8 元每度	B1	0800021111			121.6103	25.05626	2026-05-01 01:00:08+00	0101000020E6100000EC2FBB270F675E40AE122C0E670E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0183	臺北市士林區行政中心地下停車場	12981268	2	1	1	1	1	{"slow_ac": 1}	平日/20:00-08:00,六日及國定假日都不開放	免費	免費	1	0228826200			121.51976	25.09283	2026-05-01 01:00:08+00	0101000020E6100000377172BF43615E407216F6B4C3173940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE1027	振興公園地下停車場	80682490	2	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/40元每小時	計時/10 元/每小時(依停車費率加收)	B1	(02)27057716			121.52324	25.11877	2026-05-01 01:00:08+00	0101000020E610000061FD9FC37C615E40F5BEF1B5671E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0636	臺北市萬華區老松國民小學附設停車場	12981268	2	1	1	1	1	{"slow_ac": 1}	每日/19:00-07:00  [不對外開放] 	免費  [不對外開放] 	免費	1	2336-1266			121.50358	25.03743	2026-05-01 01:00:08+00	0101000020E6100000DCBA9BA73A605E40A8E3310395093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	TPE0182	臺北市大同區行政中心地下停車場	12981268	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	免費	免費	1	2597-5323			121.51578	25.06632	2026-05-01 01:00:08+00	0101000020E610000094FB1D8A02615E401B12F758FA103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1084	臺北市網球中心停車場	94175832	1	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/40元每小時，每日最高/230 元每日	計分/1.25 元每分	B1	2246-1708			121.59695	25.06757	2026-05-01 01:00:08+00	0101000020E610000039D6C56D34665E40D3307C444C113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1108	臺北市內湖區麗山國民小學停車場	12981268	2	2	2	2	2	{"slow_ac": 2}	平日/18:00-07:00,假日/00:00-24:00 [不對外開放] 	免費 [不對外開放] 	免費	1	(02)26574158分機515			121.57266	25.0826	2026-05-01 01:00:08+00	0101000020E61000008DEE2076A6645E404CA60A4625153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE1537	南湖國小活動中心附設停車場	12981268	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	免費	免費	1	0226313366			121.61179	25.06837	2026-05-01 01:00:08+00	0101000020E610000045813E9127675E400C0742B280113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0952	臺北市南港區胡適國小地下停車場	12981268	2	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00 [不對外開放]	免費 [不對外開放]	免費	1	0227824949			121.61756	25.04246	2026-05-01 01:00:08+00	0101000020E610000056D4601A86675E405E6397A8DE0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE1599	臺北市南港區東新國民小學停車場	12981268	2	2	2	2	2	{"slow_ac": 2}	每日/19:00-07:00  [不對外開放] 	免費  [不對外開放] 	免費	1	0227837577			121.60207	25.05616	2026-05-01 01:00:08+00	0101000020E6100000C6F99B5088665E40E6577380600E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0184	內湖區行政中心停車場	12981268	2	1	1	1	1	{"slow_ac": 1}	地上1層:平日/08:30-17:30,18:00-07:30，例假日不開放，地下1層:平日/18:00-08:00，選舉期間、特殊活動不開放	免費	免費	1	0227925828			121.58901	25.06921	2026-05-01 01:00:08+00	0101000020E610000016C1FF56B2655E40618E1EBFB7113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0176	中山區行政中心停車場	12981268	2	1	1	1	1	{"slow_ac": 1}	每日/08:00-20:00	計時/每日/80元每小時洽公民眾前30分鐘以下免費，逾30分鐘至1小時30元，逾1小時每30分鐘40元，全程以半小時計費。月租:租工小型2,000元/月，機車200元/月；夜間小型車1,800元/月，日間小型車2,000元/月	免費	1	022503-1369#205			121.5335	25.0644	2026-05-01 01:00:08+00	0101000020E6100000A01A2FDD24625E40C6DCB5847C103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	TPE0977	中山大樓停車場	89132567	3	1	1	1	1	{"slow_ac": 1}	7x24 小時	計時/每日 08:00~24:00/60元/每小時, 計時/每日 24:00~08:00/10元/每小時	計度/固定/8元每度	1	0225117767			121.52346	25.05625	2026-05-01 01:00:08+00	0101000020E6100000E8305F5E80615E4066666666660E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0792	便利停車場萬國站	94175832	3	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/平日/70 元每小時，每日最高/420 元每日；計時/假日/60 元每小時，每日最高/420 元每日	計分/1.25 元每分	B1	(02)27991001			121.54806	25.04794	2026-05-01 01:00:08+00	0101000020E6100000BB0F406A13635E40952BBCCB450C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1472	廣慈1區社會住宅地下停車場	89132567	2	8	8	8	8	{"slow_ac": 8}	7x24 小時	計時/每日/30元/每小時	計度/固定/8元每度	B1	0225023333			121.58287	25.0397	2026-05-01 01:00:08+00	0101000020E610000073F4F8BD4D655E40B5A679C7290A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1488	廣慈2區社會住宅地下停車場	89132567	2	6	6	6	6	{"slow_ac": 6}	7x24 小時	計時/每日/30元/每小時	計度/固定/8元每度	B1	0225023333			121.58103	25.03863	2026-05-01 01:00:08+00	0101000020E6100000ACFF73982F655E40FDA4DAA7E3093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0270	萬芳醫院附設停車場	76303216	1	6	6	6	6	{"slow_ac": 6}	每 日/00:00-24:00	計時/每日/40 元每小時	計度/固定/7元每度	B2	2930-7930			121.55798	24.99985	2026-05-01 01:00:08+00	0101000020E61000009DF4BEF1B5635E40D5E76A2BF6FF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0153	驛林交通股份有限公司興隆站	53953738	1	1	1	1	1	{"slow_ac": 1}	星期一：00:00～23:59星期二：00:00～23:59星期三：00:00～23:59星期四：00:00～23:59星期五：00:00～23:59星期六：00:00～23:59星期日：00:00～23:59	計時/每日/30元每小時	計度/尖峰/09:00-23:59/10.00 元每度, 計度/尖峰/06:00-11:00/10.00 元每度, 計度/尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/8.00 元每度,計度/離峰/23:59-06:00/8.00 元每度, 計度/離峰/11:00-14:00/8.00 元每度, 計度/半尖峰/09:00-23:59/8.00 元每度, 計度/半尖峰/06:00-11:00/8.00 元每度, 計度/半尖峰/14:00-23:59/8.00 元每	3				121.55181	25.00162	2026-05-01 01:00:08+00	0101000020E6100000C5E6E3DA50635E40FF04172B6A003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE1888	科技大樓地下停車場	28652185	2	4	4	4	4	{"slow_ac": 4}	每日/00:00-24:00	計時/每日(09~21)/50元每小時/每日最高/300元每日，計時/每日(21~09)/10元每小時/每日最高/300元每日	慢充：計度/固定/8.00元每度	B2	27995657			121.54328	25.02608	2026-05-01 01:00:08+00	0101000020E610000089247A19C5625E406614CB2DAD063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	TPE0763	成德國中運動中心停車場	26262936	1	1	1	1	1	{"slow_ac": 1}	星期一：00:00～23:59\r\n星期二：00:00～23:59\r\n星期三：00:00～23:59\r\n星期四：00:00～23:59\r\n星期五：00:00～23:59	免費	計度/尖峰/09:00-23:59/7.00 元每度, 計度/尖峰/06:00-11:00/7.00 元每度, 計度/尖峰/14:00-23:59/7.00 元每度, 計度/離峰/23:59-09:00/7.00 元每度, 計度/離峰/23:59-06:00/7.00 元每度, 計度/離峰/11:00-14:00/7.00 元每度, 計度/半尖峰/09:00-23:59/7.00 元每度, 計度/半尖峰/06:00-11:00/7.00 元每度, 計度/半尖峰/14:00-23:59/7.00 元每度, 	B一	022782-5000			121.58771	25.04492	2026-05-01 01:00:08+00	0101000020E61000000F62670A9D655E40B3EF8AE07F0B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	TPE0280	關渡自然公園停車場	50965513	1	1	1	1	1	{"slow_ac": 1}	24小時/每日/00:00-24:00	計時/每日/40元每小時，未滿半小時以20元計算	計度/00:00-24:00/每度9元	1	0228587417			121.46942	25.1192	2026-05-01 01:00:08+00	0101000020E6100000A7052FFA0A5E5E40E6AE25E4831E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	內湖區	TPE0348	內湖垃圾焚化廠停車場	50965513	2	2	2	2	2	{"slow_ac": 2}	開放時間：05:00-22:00，週一及國定例假日不開放	計時/每日/每小時20元	計度/00:00-24:00/每度8元	B1	0227961833			121.60451	25.06277	2026-05-01 01:00:08+00	0101000020E6100000B806B64AB0665E40802BD9B111103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE1463	力行停車場	50965513	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	平日$15/半小時，假日$15/半小時(入場12小時最高$180)	計度/00:00-24:00/每度10元	B1	7715-2938			121.55631	24.97964	2026-05-01 01:00:08+00	0101000020E6100000041C42959A635E407BDAE1AFC9FA3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE1911	台灣聯通延吉好室停車場	28007736	1	2	2	2	0	{}	每日/00:00-24:00	計時/每日/100元每小時,全程以半小時計	計度/10元每度	B1	0225235000			121.55702	25.04617	2026-05-01 01:00:08+00	0101000020E6100000F2CD3637A6635E406B0E10CCD10B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE0101	臺北市立天文科學教育館地下及戶外平面停車場	03751032	2	6	6	6	0	{}	週二~周日 07:30~18:00	計時/每日/30 元每小時  	計度/固定/8 元每度	B1	0228314551			121.51837	25.09583	2026-05-01 01:00:08+00	0101000020E6100000904E5DF92C615E40C6F99B5088183940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE1277	環南市場停車場	00601133	1	36	36	36	0	{}	7*24	汽車臨停半小時15元	充電服務每度8元	4,4F	2362-1685			121.48984	25.02977	2026-05-01 01:00:08+00	0101000020E61000007311DF89595F5E40E466B8019F073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	萬華區	TPE0570	華江高中活動中心地下停車場	12981268	1	1	1	1	0	{}	每日/00:00-24:00	免費	免費	1	2339-6689			121.49643	25.02851	2026-05-01 01:00:08+00	0101000020E610000036B05582C55F5E40E59B6D6E4C073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0446	台北車站K區地下街停車場	12681939	1	2	2	2	0	{}	每日/00:00 24:00	計時/每日/50元每小時/每日最高360元每日	計度 /固定 /10元每度	1	2314-1219			121.51756	25.04701	2026-05-01 01:00:08+00	0101000020E6100000F06DFAB31F615E40C095ECD8080C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0646	水岸停車場	90505425	2	3	3	3	0	{}	7x24小時	計時/平日/30元每小時，計時/假日/50元每小時\n	快充計度/離峰/6.5元每度，計度/尖峰/13.5元每度，尖峰時段為15:00-21:00，慢充計時/固定/1元每分	1F	8369-5098			121.52895	25.01131	2026-05-01 01:00:08+00	0101000020E610000007CE1951DA615E40261E5036E5023940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0871	臺北車站西區地下停車場	28652185	3	2	2	2	0	{}	每日/00:00-24:00	計時/平日/60元每小時/每日最高/500元每日,計時/假日/70元每小時/每日最高/500元每日	計度/固定/9.00元每度	B1	2799-5657			121.51662	25.04786	2026-05-01 01:00:08+00	0101000020E6100000691D554D10615E405CC98E8D400C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	TPE0047	臺北車站東區地下停車場	28652185	3	2	2	2	0	{}	每日/00:00-24:00	計時/平日/60元每小時/每日最高/500元每日,計時/假日/70元每小時/每日最高/500元每日	計度/固定/9.00元每度	B1	2799-5657			121.51769	25.04769	2026-05-01 01:00:08+00	0101000020E6100000D7DD3CD521615E40A3586E69350C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	TPE0008	北寧路地下停車場	28652185	2	2	2	2	0	{}	每日/00:00-24:00	計時/每日/40元/時(09:00~21:00)，夜間時段30元/時(21:00~09:00)，每12小時最高280元	計度/固定/8.00元每度	B2	0227995657			121.55254	25.04908	2026-05-01 01:00:08+00	0101000020E6100000D66EBBD05C635E403FE3C281900C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	TPE1661	臺北大巨蛋園區停車場	12681939	3	20	20	20	0	{}	每日/00:00 24:00	平日：小客車$30元/每半小時，假日/活動日：小客車$35元/每半小時	計度 /固定 /5元每度	1	0222461708			121.5595	25.04199	2026-05-01 01:00:08+00	0101000020E61000002B8716D9CE635E4050C24CDBBF0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0774	助安企業股份有限公司黎元停車場	93111038	1	2	2	2	0	{}	24H	40/1H	慢充每度8元	1F	2754-6661			121.55086	25.01612	2026-05-01 01:00:08+00	0101000020E61000002C2B4D4A41635E40C0CFB87020043940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0116	助安企業股份有限公司辛亥路高架橋下停車場	93111044	1	3	3	3	0	{}	24H	40/1H	慢充每度8元	1F	2754-6661			121.5531	25.01411	2026-05-01 01:00:08+00	0101000020E6100000BADA8AFD65635E40EB8B84B69C033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	TPE0812	168停車聯盟-中華信義場	97329493	3	1	1	1	0	{}	24H	50	慢充每度8元	1F	27546661			121.54749	25.03297	2026-05-01 01:00:08+00	0101000020E6100000C5387F130A635E40C6BFCFB870083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0065	臺北市文山區行政中心停車場	12681939	2	3	3	3	0	{}	每日/00:00 24:00	計時/每日/30元每小時	計度 /固定 /10元每度	1				121.56966	24.98955	2026-05-01 01:00:08+00	0101000020E6100000B875374F75645E40BEC1172653FD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0139	嘟嘟房捷運木柵機廠站停車場	50965513	1	14	14	14	0	{}	假日/08:00-22:00	120 元/次	計度/00:00-24:00/每度8元	2	0225573722			121.58393	25.0007	2026-05-01 01:00:08+00	0101000020E6100000CF49EF1B5F655E40711B0DE02D003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE1336	木柵社會住宅地下停車場	88390637	2	2	2	2	0	{}	24H	週一至週五20元/時，週六至週日及行政機關放假之紀念日、民俗節日30元/時	慢充每度8元	1F				121.56632	24.98923	2026-05-01 01:00:08+00	0101000020E610000087C43D963E645E40DA38622D3EFD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	文山區	TPE0739	嘟嘟房動物園站停車場	50965513	1	3	3	3	0	{}	每日/00:00-24:00	平日：10元/小時，假日：06:00-22:00時60元/小時；22:00-06:00時10元/小時	計度/00:00-24:00/每度8元	B1	0225573722			121.57877	24.99736	2026-05-01 01:00:08+00	0101000020E6100000FB7953910A655E40AC5626FC52FF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	TPE1916	永平社會住宅地下停車場	00655165	1	1	1	1	0	{}	24H	月租2200	慢充每度8元	1F	0227546661			121.5033	25.08899	2026-05-01 01:00:08+00	0101000020E6100000EA04341136605E40C9AB730CC8163940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	33029464-STP6360001	中山國中站	33029464	1	6	6	6	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	B1	02-26550818	台北市松山區復興北路361巷7號B1-B2停車場	台北市松山區復興北路361巷7號B1-B2停車場	121.54553	25.06043	2026-05-01 01:00:08+00	0101000020E6100000293FA9F6E9625E4081B22957780F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	33029464-STP6410001	林森公園站	33029464	1	17	17	17	0	{}	每日/00:00-24:00	每1小時0元	計時/每日/5元每1度	B2	02-26550818	台北市中山區南京東路1段35號B1-B3	台北市中山區南京東路1段35號B1-B3	121.52643	25.05223	2026-05-01 01:00:08+00	0101000020E610000088687407B1615E40BEDEFDF15E0D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	28371994-STP6510001	玉成國小站	28371994	3	6	6	6	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	B2	02-26550818	台北市南港區昆陽街23號B1-B2地下停車場	台北市南港區昆陽街23號B1-B2地下停車場	121.59264	25.0532	2026-05-01 01:00:08+00	0101000020E61000004B9352D0ED655E40AF25E4839E0D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	28371994-STP6910001	松壽廣場站	28371994	3	8	8	8	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	B1	02-26550818	台北市信義區松智路15號B1-B3	台北市信義區松智路15號B1-B3	121.56637	25.03701	2026-05-01 01:00:08+00	0101000020E6100000E0DBF4673F645E40FD9FC37C79093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	33029464-STP6650001	捷運芝山站	33029464	3	5	5	5	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1F	02-26550818	台北市士林區福國路70號	台北市士林區福國路70號	121.52261	25.10303	2026-05-01 01:00:08+00	0101000020E610000001A4367172615E40C381902C601A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	33029464-STP6750001	捷運忠義站	33029464	3	1	1	1	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1F	02-26550818	台北市北投區中央北路4段301號	台北市北投區中央北路4段301號	121.47319	25.13102	2026-05-01 01:00:08+00	0101000020E6100000D5B2B5BE485E5E40361FD7868A213940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	33029464-STP6800001	捷運唭哩岸站	33029464	3	1	1	1	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1F	02-26550818	台北市北投區東華街2段301號	台北市北投區東華街2段301號	121.5062	25.12094	2026-05-01 01:00:08+00	0101000020E61000000E4FAF9465605E403BC780ECF51E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	33029464-STP6810001	捷運石牌站	33029464	3	1	1	1	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1F	02-26550818	台北市北投區石牌路1段200號	台北市北投區石牌路1段200號	121.51607	25.11385	2026-05-01 01:00:08+00	0101000020E6100000971C774A07615E404CA60A46251D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	33029464-STP6780001	捷運北投站	33029464	3	2	2	2	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1F	02-26550818	台北市北投區光明路1號	台北市北投區光明路1號	121.49853	25.13177	2026-05-01 01:00:08+00	0101000020E6100000CB845FEAE75F5E400B98C0ADBB213940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	33029464-STP6770001	捷運新北投站	33029464	3	1	1	1	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1F	02-26550818	台北市北投區大業路700號	台北市北投區大業路700號	121.5022	25.13699	2026-05-01 01:00:08+00	0101000020E61000004703780B24605E4009E1D1C611233940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP6520001	建國高架站A區	28371994	3	2	2	2	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP6540001	建國高架站C區	28371994	3	3	3	3	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP6550001	建國高架站D區	28371994	3	3	3	3	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP6560001	建國高架站E區	28371994	3	3	3	3	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP6580001	建國高架站G區	28371994	3	6	6	6	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP6590001	建國高架站H區	28371994	3	6	6	6	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP6600001	建國高架站IB區	28371994	3	1	1	1	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP6610001	建國高架站J區	28371994	3	1	1	1	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP6620001	建國高架站O區	28371994	3	2	2	2	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP5490001	市民大道-中林站	28371994	1	10	10	10	0	{}	每日/00:00-24:00	每1小時0元	計時/每日/5元每1度	B1	02-26550818	台北市中山區市民大道2段(中山北路至林森北路)地下1、2樓停車場	台北市中山區市民大道2段(中山北路至林森北路)地下1、2樓停車場	121.52428	25.04798	2026-05-01 01:00:08+00	0101000020E61000009A7CB3CD8D615E40B1DCD26A480C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP5500001	市民大道-林金站	28371994	1	19	19	19	0	{}	每日/00:00-24:00	每1小時0元	計時/每日/5元每1度	B1	02-26550818	台北市中山區市民大道2段(林森北路至金山北路)地下1、2樓停車場	台北市中山區市民大道2段(林森北路至金山北路)地下1、2樓停車場	121.53058	25.04628	2026-05-01 01:00:08+00	0101000020E610000059FAD005F5615E4079758E01D90B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	33029464-STP6660001	捷運士林站	33029464	3	2	2	2	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	1F	02-26550818	台北市士林區福德路1號	台北市士林區福德路1號	121.52476	25.08461	2026-05-01 01:00:08+00	0101000020E6100000EF8FF7AA95615E4021EA3E00A9153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	北投區	28371994-STP3570001	七星公園站	28371994	3	6	6	6	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	B1	02-26550818	台北市北投區七星街3號地下停車場	台北市北投區七星街3號地下停車場	121.50224	25.13673	2026-05-01 01:00:08+00	0101000020E61000008EAF3DB324605E40D061BEBC00233940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	28371994-STP5410001	八德立體站	28371994	3	7	7	7	0	{}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	02-26550818	台北市松山區八德路4段580號B1-10F停車場	台北市松山區八德路4段580號B1-10F停車場	121.57195	25.04982	2026-05-01 01:00:08+00	0101000020E61000009F3C2CD49A645E40CDAFE600C10C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	南港區	33029464-STP6720001	捷運內湖機廠站	33029464	3	8	8	8	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	3F	02-26550818	台北市南港區經貿一路265號3~5F	台北市南港區經貿一路265號3~5F	121.61812	25.06126	2026-05-01 01:00:08+00	0101000020E61000003A4030478F675E408F8D40BCAE0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	28371994-STP7600001	附中公園站	28371994	3	2	2	2	0	{}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	02-26550818	台北市大安區復興南路1段340巷11號B1-B2	台北市大安區復興南路1段340巷11號B1-B2	121.5402	25.03603	2026-05-01 01:00:08+00	0101000020E6100000265305A392625E40C5AC174339093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP3930001	建國高架站	28371994	3	1	1	1	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP6530001	建國高架站B區	28371994	3	5	5	5	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	信義區	28371994-STP6900001	府前廣場站	28371994	3	40	40	40	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	B1	02-26550818	台北市信義區松壽路1號B1-B2	台北市信義區松壽路1號B1-B2	121.56299	25.03594	2026-05-01 01:00:08+00	0101000020E6100000677E350708645E40459E245D33093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP6570001	建國高架站F區	28371994	3	1	1	1	0	{}	每日/00:00-24:00	每1小時20元	計時/每日/10元每1時	1F	02-26550818	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	台北市中山區建國北路高架橋下停車場(八德路-民族東路)	121.53714	25.06028	2026-05-01 01:00:08+00	0101000020E6100000E657738060625E40569A94826E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	28371994-STP4180001	中崙高中站	28371994	3	7	7	7	0	{}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B2	02-26550818	台北市松山區八德路4段101號B2停車場	台北市松山區八德路4段101號B2停車場	121.56111	25.04858	2026-05-01 01:00:08+00	0101000020E610000059DDEA39E9635E405C3D27BD6F0C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	28371994-STP4170001	偶戲博物館站	28371994	3	2	2	2	0	{}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	02-26550818	台北市松山區市民大道5段99號B1停車場	台北市松山區市民大道5段99號B1停車場	121.5612	25.04796	2026-05-01 01:00:08+00	0101000020E6100000F9A067B3EA635E402384471B470C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中正區	28371994-STP4340001	中山堂站	28371994	3	9	9	9	0	{}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	02-26550818	台北市中正區延平南路98號地下停車場	台北市中正區延平南路98號地下停車場	121.50912	25.04289	2026-05-01 01:00:08+00	0101000020E6100000546F0D6C95605E405053CBD6FA0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大安區	28371994-STP5850001	僑安站	28371994	3	8	8	8	0	{}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	02-26550818	台北市大安區忠孝東路四段306號B1-B3停車場	台北市大安區忠孝東路四段306號B1-B3停車場	121.55668	25.04109	2026-05-01 01:00:08+00	0101000020E6100000969526A5A0635E405131CEDF840A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	28371994-STP7430001	健康國小站	28371994	3	4	4	4	0	{}	每日/00:00-24:00	每1小時0元	計時/每日/0元每1時	B1	02-26550818	台北市松山區延壽街168號B1-B2停車場(由三民路43巷入場)	台北市松山區延壽街168號B1-B2停車場(由三民路43巷入場)	121.5627	25.05608	2026-05-01 01:00:08+00	0101000020E6100000645DDC4603645E40AEF545425B0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	松山區	28371994-STP4900001	台北小巨蛋站	28371994	3	8	8	9	9	{"slow_ac": 9}	每日/00:00-24:00	每1小時0元	計時/每日/5元每1度	B1	02-26550818	台北市松山區南京東路四段2號B1-B2	台北市松山區南京東路四段2號B1-B2	121.5492	25.04993	2026-05-01 01:00:08+00	0101000020E6100000A5BDC11726635E40DB166536C80C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	中山區	28371994-STP5990001	市民大道-公中站	28371994	1	8	8	8	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/8元每度	B1	02-26550818	台北市中山區市民大道公園路至中山北路地下停車場(鄰近市民大道一段256號)	台北市中山區市民大道公園路至中山北路地下停車場(鄰近市民大道一段256號)	121.52055	25.04827	2026-05-01 01:00:08+00	0101000020E6100000B37BF2B050615E40BF60376C5B0C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	大同區	28371994-STP6000001	市民大道-塔城站	28371994	1	8	8	8	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/8元每度	B1	02-26550818	台北市大同區西寧北路至塔城街地下停車場(鄰近大同區鄭州路139號)	台北市大同區西寧北路至塔城街地下停車場(鄰近大同區鄭州路139號)	121.51009	25.05036	2026-05-01 01:00:08+00	0101000020E610000011018750A5605E40CD069964E40C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/臺北市	臺北市	士林區	28371994-STP6010001	承德公園站	28371994	1	4	4	4	0	{}	每日/00:00-24:00	每1小時0元	計度/固定/5元每度	B1	02-26550818	台北市士林區基河路150號B1-B2停車場	台北市士林區基河路150號B1-B2停車場	121.52257	25.08971	2026-05-01 01:00:08+00	0101000020E6100000BAF770C971615E40C91F0C3CF7163940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	永和區	34104124-S01	THPS	34104124	2	2	2	2	2	{"slow_ac": 2}	計度/不分時段固定每度8元	校內停車場，無開放臨停，限月租戶使用。	計度/不分時段固定每度8元	B1	0229212058	新北市永和區文化路133號B1	新北市永和區文化路133號B1	121.51171	25.01547	2026-05-02 14:10:16+00	0101000020E610000050C24CDBBF605E40B21188D7F5033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	42861108-S17090	新北－土城日月光廣場(B3)	42861108	3	6	6	6	6	{"slow_ac": 6}	每日上午7點到晚上12點	計時停車: 每小時30元。  半小時內離場: 不計費。  平日消費優惠: 不限金額消費可享當日3小時免費停車。 	免費	B3	0809007518			121.44507	24.97891	2026-05-02 14:10:16+00	0101000020E6100000919BE1067C5C5E4034BA83D899FA3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	54363149-Ss1n0	新埔國小地下停車場	54363149	1	2	2	2	2	{"slow_ac": 2}	24小時	30元每小時	60元每小時	B1	0277287300	新北市板橋區四維路177巷177巷22號	新北市板橋區四維路177巷177巷22號	121.46351	25.02681	2026-05-02 14:10:16+00	0101000020E61000009DD7D825AA5D5E40AD342905DD063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	70553757-S0001	頭前平面停車場充電站	70553757	1	1	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/30 元每小時/12小時上限150元/24小時上限300元	計度/固定/10 元每度	1	0229907400	新北市新莊區頭前路、福前街口中原段234地號	新北市新莊區頭前路、福前街口中原段234地號	121.46359	25.05196	2026-05-02 14:10:16+00	0101000020E61000002B306475AB5D5E403EB324404D0D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	54710871-S0001	宏匯思源公共停車場	54710871	1	10	10	10	10	{"slow_ac": 10}	每日/00:00-24:00	計時/每日/40元每小時/每日最高200元	計度固定/7.5元每度	B1	02-8522-9882	新北市新莊區思源路555號	新北市新莊區思源路555號	121.4593	25.0584	2026-05-02 14:10:16+00	0101000020E610000061C3D32B655D5E401E166A4DF30E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	90016138-SF001	麗林國小停車場	90016138	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/開放日/40元每小時	計度/固定/10元每度	B1	02-26008457	新北市林口區公園路46號	新北市林口區公園路46號	121.367874	25.068695	2026-05-02 14:10:16+00	0101000020E61000001EC3633F8B575E401366DAFE95113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	90016138-S643927b1	林口展悅CEO豪辦站	90016138	3	3	3	3	3	{"slow_ac": 3}	每日/07:00-23:00	20元/每小時(4/1號後調整為30元/每小時)，半小時內不計費，超過半小時未滿一小時以一小時計費	計度/平日/00:00-23:59/8元每度，計度/假日/00:00-23:59/9元每度	B1	02-86018535	新北市林口區文化三路451-457號	新北市林口區文化三路451-457號	121.38115	25.09043	2026-05-02 14:10:16+00	0101000020E6100000B537F8C264585E40C993A46B26173940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	94128120-S0004120	DARA-聯通雙和慈濟站	94128120	3	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	免費	週日/固定/7.0000元(每度),週一/固定/7.0000元(每度),週二/固定/7.0000元(每度),週三/固定/7.0000元(每度),週四/固定/7.0000元(每度),週五/固定/7.0000元(每度),週六/固定/7.0000元(每度)	B1	0225235000	新北市中和區中山路三段41號	新北市中和區中山路三段41號	121.477211724795	25.0050707485185	2026-05-02 14:10:16+00	0101000020E6100000C9D00BA38A5E5E409E0D0B514C013940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	94128120-S0004121	DARA-宏匯廣場站	94128120	3	16	14	14	16	{"fast_dc": 1, "slow_ac": 11, "medium_dc": 4}	平日/11:00-23:00,假日/11:00-23:00	計時/每日40 元每小時	週日/固定/12.5000元(每度),週一/固定/12.5000元(每度),週二/固定/12.5000元(每度),週三/固定/12.5000元(每度),週四/固定/12.5000元(每度),週五/固定/12.5000元(每度),週六/固定/12.5000元(每度)	B3,B4	0285128366	新北市新莊區新北大道四段3號	新北市新莊區新北大道四段3號	121.449249267578	25.059289932251	2026-05-02 14:10:16+00	0101000020E6100000F7FFFF7FC05C5E40070000A02D0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	汐止區	94273051-S2gpG2Tp	汐止區公所	94273051	1	3	3	3	3	{"slow_ac": 3}	每日/00:00-24:00	計時/每日/20元每小時，月租2500元	計度/固定/8元每度	B1	02-26411111	新北市汐止區新台五路一段268	新北市汐止區新台五路一段268	121.65862	25.064318	2026-05-02 14:10:16+00	0101000020E6100000751F80D4266A5E404C8BFA2477103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	93519232-S0010	板橋中山停車場	93519232	3	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	計時/平日/60 元每小時、假日/70 元每小時	計度/固定/10 元每度	B2	03-5285025	新北市板橋區中山路一段1	新北市板橋區中山路一段1	121.459698	25.007714	2026-05-02 14:10:16+00	0101000020E6100000580229B16B5D5E40AAB8718BF9013940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	汐止區	37759379-SB0021	忠厚地下停車場	37759379	2	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	平日/日間收費20/1小時(08:00-22:00)夜間收費10/1小時(22:00-0800)假日日間收費30/1小時(08:00-22:00)假日夜間收費10/1小時(22:00-0800)	計度/固定/8元每度	B1	26437872	新北市汐止樟樹一路13726	新北市汐止樟樹一路13726	121.64068	25.06577	2026-05-02 14:10:16+00	0101000020E6100000E2CCAFE600695E40D40E7F4DD6103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	瑞芳區	60225577-SA0694011	俥亭停車事業瑞芳八斗子營業所	60225577	1	1	1	1	1	{"slow_ac": 1}	24小時營業	不分平假日每小時20元	免費	1	02-24257730	新北市瑞芳區建基路二段127	新北市瑞芳區建基路二段127	121.80509	25.13457	2026-05-02 14:10:16+00	0101000020E61000008C15359886735E40D105F52D73223940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	91887251-SA040601	雙和醫院停車場	91887251	3	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時:40 元/每小時	計度/固定/8元每度	B3	02-22432965	新北市中和區中正路291號	新北市中和區中正路291號	121.4940065	24.9931734	2026-05-02 14:10:16+00	0101000020E6100000BB6070CD9D5F5E40D341A89C40FE3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	91903689-SA040701	雙和醫院二停車場	91903689	1	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時: 40元/小時	計度:  8元/每度	1F	02-22436083	新北市中和區圓通路301號	新北市中和區圓通路301號	121.49418	24.991234	2026-05-02 14:10:16+00	0101000020E6100000969526A5A05F5E40EAAEEC82C1FD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	97179430-S162	板橋大遠百	97179430	3	8	8	8	14	{"slow_ac": 2, "medium_dc": 12}	每日/11:00-22:00	計時 /每日/60元每小時	計度 /固定 /12元 DC每度,計度 /固定 /8.5元 AC每度	B4		新北市板橋區新站路28號	新北市板橋區新站路28號	121.467434	25.014509	2026-05-02 14:10:16+00	0101000020E610000076C24B70EA5D5E40677FA0DCB6033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	97179430-S161	亞東科技大學地下停車場	97179430	3	2	2	2	4	{"medium_dc": 4}	每日/00:00-24:00	計時/每日/30元每小時, 計時/每日/10元每小時	計度 /固定 /12元 DC每度	B1		新北市板橋區四川路二段28號	新北市板橋區四川路二段28號	121.454143442233	24.9956997136522	2026-05-02 14:10:16+00	0101000020E61000005A05A8AF105D5E40D4C52A2DE6FE3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	28114216-S124	土城國民運動中心	28114216	1	2	2	2	4	{"medium_dc": 4}	每日/06:00-22:00	計時/每日/20元每小時	計度/固定/10.50元每度	B1	03-5775036	236新北市土城區金城路二段247-1號	236新北市土城區金城路二段247-1號	121.45717901	24.98598325	2026-05-02 14:10:16+00	0101000020E61000008817C06B425D5E405F27F56569FC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	28114216-S184	三重國民運動中心	28114216	1	2	2	2	4	{"medium_dc": 4}	每日/00:00-24:00	計時/每日/20元每小時	計度/固定/10.50元每度	B2	03-5775036	241新北市三重區集美街55號	241新北市三重區集美街55號	121.48819565	25.05491803	2026-05-02 14:10:16+00	0101000020E61000002AB3F7983E5F5E408DCFA61B0F0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	85051710-S471	林口亞昕福朋喜來登酒店	85051710	3	6	6	6	6	{"slow_ac": 6}	每日/00:00~23:59	計時/每日/40 元每小時每日最高/400元每日, 月租/每月/3000元每月	計時/每1分鐘0.93元	B2	02-77276988	新北市林口區文化三路一段1號	新北市林口區文化三路一段1號	121.360965	25.066492	2026-05-02 14:10:16+00	0101000020E61000000A80F10C1A575E401572A59E05113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三峽區	85051710-S639	國立臺北大學	85051710	3	4	2	2	4	{"ultra_fast_dc": 4}	每日/00:00~23:59	計時/平日/20 元每小時, 計時/假日/40元每小時	○星晴電價(非夏季):週一至週五21:00〜隔日14:59、週六00:00〜06:59,每度6.5元○尖峰費率(非夏季):週一至週五15:00〜20:59,每度13.2元<br>○假日費費率(週六週日與國定假日):假日首日00:00〜06:59,適用星晴電價,其餘採假日費率每度8.4元計算<br>○車廠優惠費率方案與上述優惠共享&nbsp;<br><br>「啟動前請確認車輛已到位並完成插槍。若因誤觸啟動導致非本人車輛充電，相關扣費恕不退還。」	1F	02-26731949	新北市三峽區大學路151號	新北市三峽區大學路151號	121.367965	24.939676	2026-05-02 14:10:16+00	0101000020E6100000A64412BD8C575E400AD6389B8EF03840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	33029464-STP6820001	捷運蘆洲站	33029464	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	06:00-22:00：$30/0.5H，當日無上限；22:00-06:00：$35/0.5H，當日無上限	計度/固定/5元每度	B1	02-26550818	新北市蘆洲區三民路386號B1	新北市蘆洲區三民路386號B1	121.46446	25.09157	2026-05-02 14:10:16+00	0101000020E610000036936FB6B95D5E40734BAB2171173940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	33029464-STP6640001	捷運紅樹林站	33029464	1	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	00:00-06:00：$5/0.5H，當日無上限；06:00-00:00：$10/0.5H，當日無上限	計度/固定/5元每度	1F	02-26550818	新北市淡水區中正東路2段68號	新北市淡水區中正東路2段68號	121.45903	25.15475	2026-05-02 14:10:16+00	0101000020E610000081785DBF605D5E40560E2DB29D273940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	28371994-STP7630001	捷運淡水站	28371994	1	12	12	12	12	{"slow_ac": 12}	每日/00:00-24:00	汽車：平日：06~00-$15/0.5H,00~06-$10/0.5H，假日：10~00-$30/0.5H,00~10-$10/0.5H；機車：$30/次(隔日另計,以2:00為跨日基準)	計度/固定/5元每度	1F	02-26550818	新北市淡水區中正路1號	新北市淡水區中正路1號	121.43273	25.17477	2026-05-02 14:10:16+00	0101000020E6100000E17F2BD9B15B5E4069520ABABD2C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	28371994-STP4370001	蘆洲功學社站	28371994	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	汽車：$40/H；機車：$20/H	計度/固定/5元每度	B1	02-26550818	新北市蘆洲區中山二路162號B1~B2	新北市蘆洲區中山二路162號B1~B2	121.4708	25.08145	2026-05-02 14:10:16+00	0101000020E61000003CBD5296215E5E405B423EE8D9143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	五股區	28007736-S049	五股運動中心	28007736	1	1	1	1	1	{"slow_ac": 1}	每日 /00:00-24:00	計時/每日/20元每小時	計分/0.9元每分	1	0931-263-103	新北市五股區成泰路三段296號	新北市五股區成泰路三段296號	121.448458	25.09521105	2026-05-02 14:10:16+00	0101000020E61000004BE82E89B35C5E40C3F759C05F183940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	28007736-S051	蘆洲運動中心	28007736	1	1	1	1	1	{"slow_ac": 1}	每日 /00:00-24:00	計時/每日/30元每小時	計分/0.9元每分	1	0931-263-103	新北市蘆洲區長樂路235-1號	新北市蘆洲區長樂路235-1號	121.4619974	25.09151955	2026-05-02 14:10:16+00	0101000020E610000092F58A5D915D5E40D43142D36D173940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	汐止區	42861108-Sd70033ee-9101-425a-adb5-919c788f5dbc	新北－汐止日月光家飾館	42861108	3	9	9	9	9	{"slow_ac": 5, "ultra_fast_dc": 4}	每日/08:00-20:00	費用詳情請查詢TESLA站點	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度	P1	0809007518			121.63807	25.07461	2026-05-02 14:10:16+00	0101000020E6100000C2A38D23D6685E405EF415A419133940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	42861108-S543408c0-ad77-4f2c-af34-6bbbf4175c31	新北－中和環球購物中心	42861108	3	8	8	8	16	{"fast_dc": 16}	7x24小時	費用詳情請查詢TESLA站點	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分	6	0809007518			121.47482	25.00622	2026-05-02 14:10:16+00	0101000020E610000026DF6C73635E5E40C49448A297013940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	42861108-S09bf3b8f-8fe9-44d3-be15-2a0cf5891db6	新北－新店	42861108	3	4	4	4	8	{"fast_dc": 8}	7x24小時	費用詳情請查詢TESLA站點	計分/0-60kW/5 元每分,計分/60-100kW/11 元每分,計分/100-180kW/17 元每分,計分/180-250kW/28 元每分	B2	0809007518			121.54005	24.9852	2026-05-02 14:10:16+00	0101000020E61000001B0DE02D90625E40EA04341136FC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	42861108-Sbe38b430-6d41-40e7-bc9d-d0f913b1f36a	新北－土城日月光廣場	42861108	3	4	4	4	4	{"ultra_fast_dc": 4}	每日/07:00-23:00	費用詳情請查詢TESLA站點	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-12:00/8 元每度計度/一般時段/12:00-20:00/10 元每度計度/離峰/20:00-00:00/9 元每度	B3	0809007518			121.44455	24.97961	2026-05-02 14:10:16+00	0101000020E6100000F5DBD781735C5E40A6D590B8C7FA3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	42861108-S5f440307-00e3-4c34-a2a1-f66f48123618	新北－三重愛買	42861108	3	6	6	6	6	{"ultra_fast_dc": 6}	每日/09:00-22:00	費用詳情請查詢TESLA站點	計度/一般時段/00:00-04:00/8 元每度計度/一般時段/04:00-12:00/8 元每度計度/一般時段/12:00-00:00/8 元每度	1F	0809007518			121.47518	25.07139	2026-05-02 14:10:16+00	0101000020E6100000A6ED5F59695E5E40EE42739D46123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	42861108-S945a1b98-3f8d-4da2-8de2-928295b1378d	新北－滬尾藝文休閒園區	42861108	3	10	10	10	10	{"slow_ac": 4, "ultra_fast_dc": 6}	7x24小時	費用詳情請查詢TESLA站點	計度/離峰/00:00-04:00/8 元每度計度/離峰/04:00-15:00/8 元每度計度/尖峰/15:00-22:00/13 元每度計度/離峰/22:00-00:00/8 元每度	B1	0809007518			121.42868	25.17628	2026-05-02 14:10:16+00	0101000020E6100000C11C3D7E6F5B5E405AF0A2AF202D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	42861108-Sf90c9fd9-843b-4573-bba4-96b5740c6ab9	新北－新莊	42861108	3	6	6	6	6	{"ultra_fast_dc": 6}	7x24小時	費用詳情請查詢TESLA站點	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度	1F	0809007518			121.44638	25.05149	2026-05-02 14:10:16+00	0101000020E6100000AA656B7D915C5E403012DA722E0D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	42861108-S6b706da3-fa15-4a3c-8d93-320a5c21af23	新北 - 中和環球購物中心	42861108	3	9	9	9	9	{"slow_ac": 9}	7x24小時	費用詳情請查詢TESLA站點	費用詳情請查詢TESLA站點	1F	0809007518			121.47495	25.00673	2026-05-02 14:10:16+00	0101000020E61000000E4FAF94655E5E40EFE6A90EB9013940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	42861108-S90b04491-49d2-4010-b5f5-30dd08d88254	林口A9環球購物中心	42861108	3	3	3	3	3	{"slow_ac": 3}	7x24小時	費用詳情請查詢TESLA站點	費用詳情請查詢TESLA站點	1F	0809007518			121.36144	25.06606	2026-05-02 14:10:16+00	0101000020E6100000D7DD3CD521575E40E292E34EE9103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	石門區	42861108-S7cb16f34-2913-4db7-bc2f-a6ba16f52005	新北 - 黃金海岸高爾夫球場	42861108	3	3	3	3	3	{"slow_ac": 3}	7x24小時	費用詳情請查詢TESLA站點	費用詳情請查詢TESLA站點	1F	0809007518			121.60162	25.27652	2026-05-02 14:10:16+00	0101000020E6100000A6272CF180665E409FB0C403CA463940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	烏來區	42861108-S01342a10-aa64-4f90-ae30-1b8d7d3fcc86	璞石麗緻溫泉會館	42861108	3	3	3	3	3	{"slow_ac": 3}	7x24小時	費用詳情請查詢TESLA站點	費用詳情請查詢TESLA站點	1F	0809007518			121.54757	24.87175	2026-05-02 14:10:16+00	0101000020E610000053910A630B635E40BA490C022BDF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	42861108-S852a2236-52bc-4366-aa9e-1552330789ac	新北－三重愛買	42861108	3	4	4	4	4	{"slow_ac": 4}	7x24小時	費用詳情請查詢TESLA站點	費用詳情請查詢TESLA站點	1F	0809007518			121.4763	25.0715	2026-05-02 14:10:16+00	0101000020E61000006DC5FEB27B5E5E40FCA9F1D24D123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三峽區	42861108-S9e864926-d6fd-4100-929e-27498da60fb2	新北－三峽	42861108	3	9	9	9	9	{"ultra_fast_dc": 9}	7x24小時	費用詳情請查詢TESLA站點	計度/離峰/00:00-04:00/7 元每度計度/離峰/04:00-15:00/7 元每度計度/尖峰/15:00-22:00/12 元每度計度/離峰/22:00-00:00/7 元每度	1F	0809007518			121.37291	24.94085	2026-05-02 14:10:16+00	0101000020E61000007D96E7C1DD575E400D71AC8BDBF03840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	42861108-S663cbaf2-0ad2-43cf-89de-d05bfe391308	168parking 蘆洲三民停車場	42861108	3	4	4	4	4	{"slow_ac": 4}	7x24小時	費用詳情請查詢TESLA站點	費用詳情請查詢TESLA站點	1F	0809007518			121.47478	25.08317	2026-05-02 14:10:16+00	0101000020E6100000DF32A7CB625E5E4021020EA14A153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	42861108-S554815bb-24da-4ed1-8e6d-5aeb04c584c6	新北－林口亞昕福朋喜來登酒店	42861108	3	4	4	4	4	{"ultra_fast_dc": 4}	7x24小時	費用詳情請查詢TESLA站點	計度/一般時段/00:00-24:00/8 元每度	B2	0809007518			121.36089	25.06651	2026-05-02 14:10:16+00	0101000020E610000005DD5ED218575E4062DBA2CC06113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	八里區	42861108-Se3f94cf3-0acd-4ed4-a383-7d095af4e934	新北 - 八里福朋喜來登酒店	42861108	3	4	4	4	4	{"slow_ac": 4}	7x24小時	費用詳情請查詢TESLA站點	費用詳情請查詢TESLA站點	1F	0809007518			121.42962	25.15936	2026-05-02 14:10:16+00	0101000020E6100000486DE2E47E5B5E40624A24D1CB283940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	42861108-S5a4c664d-b9f1-4b87-b33a-51295d34979a	美麗人生產後護理之家	42861108	3	2	2	2	2	{"slow_ac": 2}	7x24小時	費用詳情請查詢TESLA站點	費用詳情請查詢TESLA站點	1F	0809007518			121.47212	25.04855	2026-05-02 14:10:16+00	0101000020E610000067F2CD36375E5E408638D6C56D0C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	28652185-SJIA001	捷運江子翠站	28652185	1	1	1	1	1	{"slow_ac": 1}	每日/00:00-24:00	每小時0元	計度/固定/0元每度	1	02-27995656	新北市板橋區文化路二段296號	新北市板橋區文化路二段296號	121.460858	25.013104	2026-05-02 14:10:16+00	0101000020E610000066868DB27E5D5E406072A3C85A033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	28652185-SLINKOU001	林口世大運選手村社會住宅地下停車場A區	28652185	1	7	7	7	7	{"slow_ac": 7}	每日/00:00-24:00	計時/每日/30元每小時/每日最高/150元每日	計度/固定/8元每度	B1	02-8601-8552	新北市林口區仁愛路二段496號	新北市林口區仁愛路二段496號	121.37561	25.07756	2026-05-02 14:10:16+00	0101000020E61000003C8386FE09585E404E7ADFF8DA133940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	28652185-SLINKOU002	林口世大運選手村社會住宅地下停車場B區	28652185	1	6	6	6	6	{"slow_ac": 6}	每日/00:00-24:00	計時/每日/30元每小時/每日最高/150元每日	計度/固定/8元每度	B1	02-8601-8536	新北市林口區仁愛路二段492號	新北市林口區仁愛路二段492號	121.37692	25.07539	2026-05-02 14:10:16+00	0101000020E6100000554D10751F585E40087250C24C133940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	28652185-SLINKOU003	林口世大運選手村社會住宅地下停車場C區	28652185	1	7	7	7	7	{"slow_ac": 7}	每日/00:00-24:00	計時/每日/30元每小時/每日最高/150元每日	計度/固定/8元每度	B1	02-8601-8565	新北市林口區仁愛路二段196號	新北市林口區仁愛路二段196號	121.37942	25.075	2026-05-02 14:10:16+00	0101000020E6100000B1DCD26A48585E403333333333133940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	28652185-SLINKOU004	林口世大運選手村社會住宅地下停車場D區	28652185	1	8	8	8	8	{"slow_ac": 8}	每日/00:00-24:00	計時/每日/30元每小時/每日最高/150元每日	計度/固定/8元每度	B1	02-2606-8064	新北市林口區仁愛路二段140號	新北市林口區仁愛路二段140號	121.3776	25.07248	2026-05-02 14:10:16+00	0101000020E61000000EBE30992A585E40349D9D0C8E123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	28652185-SXZPEP0001	新莊體育園區停車場	28652185	1	14	14	14	14	{"slow_ac": 14}	每日/00:00-24:00	計時/平日/30元每小時/每日最高/180元,計時/假日/30元每小時/每日	計度/固定/8元每度	B1	02-77137800	新北市新莊區中華路一段75號	新北市新莊區中華路一段75號	121.44779	25.042396	2026-05-02 14:10:16+00	0101000020E6100000745E6397A85C5E40317BD976DA0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	28652185-SMRTHL0001	捷運迴龍站轉乘停車場	28652185	1	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	計時/平日：06:00-24:00 30元/時,00:00-06:00 10元/時,計時/假日：06:00-24:00 30元/時,00:00-06:00 10元/時,平日、假日最高上限150元	計度/固定/8元每度	1	02-77137800	新北市新莊區中正路758號	新北市新莊區中正路758號	121.4131	25.02275	2026-05-02 14:10:16+00	0101000020E6100000917EFB3A705A5E40E7FBA9F1D2053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	28652185-SBQTS0001	板橋車站地下停車場	28652185	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/平日：00:00-24:00 40元/時,計時/假日：00:00-24:00 40元/時,平日、假日最高上限300元	計度/固定/9元每度	B2	02-77137800	新北市新莊區縣民大道二段7號	新北市新莊區縣民大道二段7號	121.46419	25.01549	2026-05-02 14:10:16+00	0101000020E61000005648F949B55D5E40406A1327F7033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	28652185-SMRTHS0001	捷運海山站轉乘停車場	28652185	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/平日：06:00-22:00 40元/時,22:00-06:00 20元/時,計時/假日：06:00-22:00 40元/時,22:00-06:00 20元/時,平日最高上限180元,假日最高上限200元	計度/固定/8元每度	B1	02-77137800	新北市土城區海山路39號	新北市土城區海山路39號	121.44919	24.98715	2026-05-02 14:10:16+00	0101000020E61000002DEC6987BF5C5E40143FC6DCB5FC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	28652185-SMRTYN0001	捷運永寧站轉乘停車場	28652185	1	5	5	5	5	{"slow_ac": 5}	每日/00:00-24:00	計時/平日：06:00-24:00 20元/時,00:00-06:00 10元/時,計時/假日：06:00-24:00 20元/時,00:00-06:00 10元/時,平日、假日最高上限200元	計度/固定/8元每度	1	02-77137800	新北市土城區中央路三段105號	新北市土城區中央路三段105號	121.43628	24.96566	2026-05-02 14:10:16+00	0101000020E610000087F9F202EC5B5E402C0E677E35F73840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	28652185-SMRTDP0001	捷運頂埔站轉乘停車場	28652185	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/平日：06:00-24:00 20元/時,00:00-06:00 10元/時,計時/假日：06:00-24:00 20元/時,00:00-06:00 10元/時,平日、假日最高上限200元	計度/固定/8元每度	1	02-77137800	新北市土城區中央路四段51-6號	新北市土城區中央路四段51-6號	121.41981	24.9589	2026-05-02 14:10:16+00	0101000020E61000002922C32ADE5A5E4068226C787AF53840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	83284334-S00001	充電飽_新北產業園區服務中心站	83284334	1	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/30元每小時	8元/度	1	(02)8791-0021	新北市新莊區五工路95號	新北市新莊區五工路95號	121.457105	25.06329	2026-05-02 14:10:16+00	0101000020E6100000A3755435415D5E40F12900C633103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	汐止區	94175832-SUCF0279F048	好市多汐止店B1充電站	94175832	3	14	14	14	14	{"slow_ac": 14}	7x24小時或每日/10:00-21:30	計時/每日/100 元每小時	計度/8 元每度	B1	02-77518097			121.6335611	25.0562271	2026-05-02 14:10:16+00	0101000020E61000002321DB438C685E4020A633E6640E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	94175832-SUCF0233F039	好市多中和店B1充電站	94175832	3	14	14	14	14	{"slow_ac": 14}	7x24小時或每日/10:00-21:30	計時/每日/100 元每小時	計度/8 元每度	B1	02-77518097			121.4924039	25.0017206	2026-05-02 14:10:16+00	0101000020E610000010BBA58B835F5E40C0BAE0C270003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	94175832-SUCG0178G001	新北市板橋國民運動中心B1充電站	94175832	3	5	5	5	5	{"slow_ac": 5}	每日/06:00-22:00	計時/每日/30 元每小時	計分/1.25 元每分	B1	02-77518097			121.4577385	25.0229371	2026-05-02 14:10:16+00	0101000020E6100000B0E76B964B5D5E40765DAE34DF053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	94175832-SUCF0259F040	好市多新莊店4F充電站	94175832	3	14	14	14	14	{"slow_ac": 14}	7x24小時或每日/10:00-21:30	計時/每日/100 元每小時	計度/8 元每度	4	02-77518097			121.4341007	25.027198	2026-05-02 14:10:16+00	0101000020E6100000ED6A4D4EC85B5E404084B872F6063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	94175832-SUCB0078G002	24TPS 永固便利停（南山威力站）	94175832	3	6	6	6	6	{"slow_ac": 6}	7x24小時或每日/00:00-24:00	計時/每日/40 元每小時	計分/1 元每分	6	02-77518097			121.496062	25.0017136	2026-05-02 14:10:16+00	0101000020E610000074B2D47ABF5F5E405BF56F4D70003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	94175832-SUCB0233G002	大潤發中和店	94175832	3	6	6	6	6	{"slow_ac": 6}	7x24小時或每日/07:30-23:00	計時/每日/50 元每小時	計分/1.25 元每分	B3	02-77518097			121.499242	25.00361	2026-05-02 14:10:16+00	0101000020E610000089B2B794F35F5E4045F0BF95EC003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	94175832-SUCG0015G001	新莊典華B2充電站	94175832	3	2	2	2	2	{"slow_ac": 2}	7x24小時或每日/00:00-24:00	計時/每日/60 元每小時	計分/1.25 元每分	B2	02-77518097			121.4468134	25.0573342	2026-05-02 14:10:16+00	0101000020E6100000881A3B97985C5E403CF14174AD0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SACSD00069	新北市三重區三光國民小學	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	免費	計度/固定/10元每度	B1	0800-885-150	新北市三重區大同南路157號	新北市三重區大同南路157號	121.496443	25.056557	2026-05-02 14:10:16+00	0101000020E61000000055DCB8C55F5E40215C01857A0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	永和區	90807408-SCSD00077	新北永和比漾廣場	90807408	3	1	2	2	2	{"slow_ac": 2}	7x24小時	50元/小時 (依現場為準)	計度/固定/8元每度	B5	0800-885-150	新北市永和區中山路一段238號B5	新北市永和區中山路一段238號B5	121.507555	25.007919	2026-05-02 14:10:16+00	0101000020E6100000F67AF7C77B605E405C04C6FA06023940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	90807408-SCSD02391	MITSUI OUTLET PARK 林口Ⅰ館	90807408	3	18	20	20	20	{"slow_ac": 20}	平日 /11:00-22:00, 平日 /11:00-23:59, 假日 /11:00-22:00	依現場為準	計度/固定/8.8元每度	3F	0800-885-150	新北市林口區文化三路一段356號	新北市林口區文化三路一段356號	121.363891	25.071507	2026-05-02 14:10:16+00	0101000020E6100000C2137AFD49575E40616F62484E123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	90807408-SCSD02634	新北市林口國民運動中心	90807408	3	2	2	2	2	{"slow_ac": 2}	每日/06:00-22:00	20元/時	計度/固定/7.5元每度	B2	0800-885-150	新北市林口區文化二路二段299號	新北市林口區文化二路二段299號	121.380713	25.086989	2026-05-02 14:10:16+00	0101000020E61000005F0A0F9A5D585E409B1C3EE944163940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	90807408-SCSD02635	新北市青少年圖書館	90807408	3	2	2	2	2	{"slow_ac": 2}	7x24小時	30元/時	計度/固定/8元每度	B2	0800-885-150	新北市新店區安康路二段151號B2	新北市新店區安康路二段151號B2	121.51074	24.959752	2026-05-02 14:10:16+00	0101000020E61000009430D3F6AF605E4046459C4EB2F53840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD02645	宏匯思源i-Tower大樓	90807408	3	1	7	7	7	{"slow_ac": 7}	7x24小時	40元/時	計度/固定/7.5元每度	4F	0800-885-150	新北市新莊區思源路555號	新北市新莊區思源路555號	121.459033	25.057376	2026-05-02 14:10:16+00	0101000020E61000003AB2F2CB605D5E4047938B31B00E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三峽區	90807408-SCSD02685	新北三峽公有市場	90807408	3	2	2	2	2	{"slow_ac": 2}	7x24小時	20元/時	計度/固定/8元每度	B1	0800-885-150	新北市三峽區民生街186號	新北市三峽區民生街186號	121.370433	24.935345	2026-05-02 14:10:16+00	0101000020E6100000FD169D2CB5575E40257A19C572EF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD02686	新北民享公有市場	90807408	3	2	2	2	2	{"slow_ac": 2}	7x24小時	20元/時	免費	B1	0800-885-150	新北市中和區自治街2號	新北市中和區自治街2號	121.474213	25.003116	2026-05-02 14:10:16+00	0101000020E6100000A3957B81595E5E402618CE35CC003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	泰山區	90807408-SCSD02687	新北泰山公有市場	90807408	3	1	2	2	2	{"slow_ac": 2}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市泰山區全興路212號	新北市泰山區全興路212號	121.433439	25.056068	2026-05-02 14:10:16+00	0101000020E6100000E773EE76BD5B5E40255AF2785A0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD02693	新北捷運幸福站立體停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	30元/小時	計度/固定/8元每度	3F	0800-885-150	新北市新莊區思源路296巷2號	新北市新莊區思源路296巷2號	121.460467	25.050109	2026-05-02 14:10:16+00	0101000020E6100000C878944A785D5E403A3C84F1D30C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	90807408-SCSD02804	新北金城立體停車場	90807408	1	5	11	11	11	{"slow_ac": 11}	7x24小時	20元/小時	計度/固定/8元每度	B1	0800-885-150	新北市土城區金城路2段266號	新北市土城區金城路2段266號	121.458552	24.983809	2026-05-02 14:10:16+00	0101000020E6100000FCE07CEA585D5E40AE8218E8DAFB3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	90807408-SCSD02763	MITSUI OUTLET PARK 林口Ⅱ館	90807408	3	23	23	23	23	{"slow_ac": 23}	每日/11:00-22:00	⚠️停車優惠僅限於MITSUI OUTLET PARK 林口當日消費之發票，為利於優惠折抵，請牢記車牌號碼。 1.每消費滿1,000元可折停車1小時，依此類推，請於消費同時，告知車牌號碼進行停車優惠折抵。 2.持永豐三井OUTLET聯名卡可於自動繳費機過卡，即享2小時停車優惠，每日每卡每車僅限優惠乙次。 3.憑威秀影城當日購買之票根，於繳費機掃描QR CODE，即享3小時停車優惠，每日每車限抵扣乙次。 4.以上3項優惠可合併使用，每車每日最高折抵5小時。	計度/固定/8.8元每度	4F, B1	0800-885-150	新北市林口區文化二路一段123號B1、4F	新北市林口區文化二路一段123號B1、4F	121.36461	25.067742	2026-05-02 14:10:16+00	0101000020E6100000DA722EC555575E40CD902A8A57113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02779	新北永福國小地下停車場	90807408	1	4	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市三重區永福街66號	新北市三重區永福街66號	121.479728	25.077617	2026-05-02 14:10:16+00	0101000020E61000006EBE11DDB35E5E40179D2CB5DE133940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02780	新北龍門公園地下停車場	90807408	1	1	2	2	2	{"slow_ac": 2}	7x24小時	20元/小時	計度/固定/8元每度	1F	0800-885-150	新北市三重區公園街32號	新北市三重區公園街32號	121.49847	25.074325	2026-05-02 14:10:16+00	0101000020E61000006002B7EEE65F5E40744694F606133940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02781	新北二重國中地下停車場	90807408	1	4	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市三重區忠孝路3段89號	新北市三重區忠孝路3段89號	121.479652	25.064761	2026-05-02 14:10:16+00	0101000020E6100000815D4D9EB25E5E40670E492D94103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02782	新北厚德國小地下停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市三重區忠孝路1段70號	新北市三重區忠孝路1段70號	121.490182	25.071788	2026-05-02 14:10:16+00	0101000020E6100000A0C552245F5F5E40C93EC8B260123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02783	新北五常地下停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市三重區五華街7巷30號	新北市三重區五華街7巷30號	121.496408	25.080731	2026-05-02 14:10:16+00	0101000020E6100000425E0F26C55F5E40FCC56CC9AA143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02787	新北聯邦公園地下停車場	90807408	1	4	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市三重區中華路125號	新北市三重區中華路125號	121.484092	25.063818	2026-05-02 14:10:16+00	0101000020E61000005610035DFB5E5E4069E55E6056103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02788	新北正義公園地下停車場	90807408	1	3	4	4	4	{"slow_ac": 4}	7x24小時	平日30元/時，假日40元/時	計度/固定/8元每度	B1	0800-885-150	新北市三重區雙園街1號	新北市三重區雙園街1號	121.497753	25.068702	2026-05-02 14:10:16+00	0101000020E6100000191F662FDB5F5E40772B4B7496113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02789	新北溪美立體停車場	90807408	1	3	7	7	7	{"slow_ac": 7}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市三重區自強路4段55號	新北市三重區自強路4段55號	121.490593	25.078727	2026-05-02 14:10:16+00	0101000020E610000061A92EE0655F5E40EC4FE27327143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	八里區	90807408-SCSD02790	新北八里區第一立體停車場	90807408	1	11	11	11	11	{"slow_ac": 11}	7x24小時	20元/小時	計度/固定/8元每度	1F	0800-885-150	新北市八里區舊城路12號	新北市八里區舊城路12號	121.400127	25.146544	2026-05-02 14:10:16+00	0101000020E6100000C8CF46AE9B595E40CE6C57E883253940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	五股區	90807408-SCSD02791	新北五股區工商路立體停車場	90807408	1	6	6	6	6	{"slow_ac": 6}	7x24小時	平日20元/小時，假日30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市五股區工商路3號	新北市五股區工商路3號	121.43953	25.083255	2026-05-02 14:10:16+00	0101000020E610000019E76F42215C5E407E3A1E3350153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	汐止區	90807408-SCSD02792	新北智興立體停車場	90807408	1	5	8	8	8	{"slow_ac": 8}	7x24小時	30元/時	計度/固定/8元每度	3F	0800-885-150	新北市汐止區忠孝東路1號	新北市汐止區忠孝東路1號	121.657151	25.064006	2026-05-02 14:10:16+00	0101000020E6100000286211C30E6A5E406EBF7CB262103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	泰山區	90807408-SCSD02793	新北楓樹腳公園地下停車場	90807408	1	3	8	8	8	{"slow_ac": 8}	7x24小時	20元/時	計度/固定/8元每度	B2	0800-885-150	新北市泰山區楓江路26巷26號	新北市泰山區楓江路26巷26號	121.434631	25.062149	2026-05-02 14:10:16+00	0101000020E6100000FAB48AFED05B5E40A77A32FFE80F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	泰山區	90807408-SCSD02794	新北義學立體停車場	90807408	1	3	11	11	11	{"slow_ac": 11}	7x24小時	20元/小時	計度/固定/8元每度	B1	0800-885-150	新北市泰山區明志路2段188號	新北市泰山區明志路2段188號	121.427472	25.050096	2026-05-02 14:10:16+00	0101000020E61000002AFD84B35B5B5E4011A96917D30C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	貢寮區	90807408-SCSD02802	新北澳底公園地下停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	20元/時	計度/固定/8元每度	B1	0800-885-150	新北市貢寮區仁愛路43號	新北市貢寮區仁愛路43號	121.925193	25.053703	2026-05-02 14:10:16+00	0101000020E61000003D5FB35C367B5E4074B2D47ABF0D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三峽區	90807408-SCSD02803	新北三峽國小地下停車場	90807408	1	3	5	5	5	{"slow_ac": 5}	7x24小時	40元/小時	計度/固定/8元每度	B1	0800-885-150	新北市三峽區中山路16號	新北市三峽區中山路16號	121.370076	24.93458	2026-05-02 14:10:16+00	0101000020E610000035423F53AF575E40E57E87A240EF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02809	新北三張公園地下停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市三重區大智街188號	新北市三重區大智街188號	121.490718	25.070902	2026-05-02 14:10:16+00	0101000020E6100000BF6378EC675F5E4093382BA226123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02810	新北光興國小地下停車場	90807408	1	3	6	6	6	{"slow_ac": 6}	7x24小時	平日30元/時，假日40元/時	計度/固定/8元每度	1F, B1	0800-885-150	新北市三重區正義南路62號	新北市三重區正義南路62號	121.499305	25.060173	2026-05-02 14:10:16+00	0101000020E6100000AD6EF59CF45F5E402A1A6B7F670F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02811	新北碧華國小地下停車場	90807408	1	3	5	5	5	{"slow_ac": 5}	7x24小時	20元/時	計度/固定/8元每度	B1	0800-885-150	新北市三重區五華街160號	新北市三重區五華街160號	121.489026	25.084461	2026-05-02 14:10:16+00	0101000020E61000003239B5334C5F5E4097C9703C9F153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02812	新北光榮國小地下停車場	90807408	1	7	11	11	11	{"slow_ac": 11}	7x24小時	30元/小時	計度/固定/8元每度	B2	0800-885-150	新北市三重區介壽路32號	新北市三重區介壽路32號	121.500557	25.072308	2026-05-02 14:10:16+00	0101000020E61000002B323A2009605E403A3DEFC682123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02813	新北興穀國小地下停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市三重區神農街101號	新北市三重區神農街101號	121.47428	25.050496	2026-05-02 14:10:16+00	0101000020E61000006649809A5A5E5E402D944C4EED0C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	90807408-SCSD02814	新北市三民立體停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	30元/小時	計度/固定/8元每度	1F, B1	0800-885-150	新北市淡水區建設街6號	新北市淡水區建設街6號	121.439186	25.172644	2026-05-02 14:10:16+00	0101000020E61000001CB7989F1B5C5E40C2D9AD65322C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	90807408-SCSD02815	新北市水碓立體停車場	90807408	1	5	9	9	9	{"slow_ac": 9}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市淡水區中山北路1段189號	新北市淡水區中山北路1段189號	121.443584	25.178233	2026-05-02 14:10:16+00	0101000020E6100000D94125AE635C5E4066118AADA02D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	90807408-SCSD02816	新北市民生立體停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	50元/小時	計度/固定/8元每度	2F, 3F	0800-885-150	新北市淡水區民生路27-1號	新北市淡水區民生路27-1號	121.461791	25.137999	2026-05-02 14:10:16+00	0101000020E610000094A5D6FB8D5D5E4076E107E753233940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	樹林區	90807408-SCSD02817	新北長壽公園地下停車場	90807408	1	6	6	6	6	{"slow_ac": 6}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市樹林區樹德街40號	新北市樹林區樹德街40號	121.421553	24.991795	2026-05-02 14:10:16+00	0101000020E6100000F7216FB9FA5A5E401956F146E6FD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	90807408-SCSD02878	新北延吉立體停車場	90807408	1	3	9	9	9	{"slow_ac": 9}	7x24小時	30元/時	計度/固定/8元每度	1F	0800-885-150	新北市土城區德峰街65號	新北市土城區德峰街65號	121.469296	24.987509	2026-05-02 14:10:16+00	0101000020E6100000310917F2085E5E407381CB63CDFC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	90807408-SCSD02879	新北三民地下停車場	90807408	1	3	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市新店區三民路20-1號	新北市新店區三民路20-1號	121.537333	24.971019	2026-05-02 14:10:16+00	0101000020E6100000F183F3A963625E406CCB80B394F83840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	90807408-SCSD02880	新北裕生立體停車場	90807408	1	3	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市土城區裕生路106號	新北市土城區裕生路106號	121.44684	24.98447	2026-05-02 14:10:16+00	0101000020E6100000DBA2CC06995C5E40A4E4D53906FC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	90807408-SCSD02881	新北學成公園地下停車場	90807408	1	3	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市土城區學成路81號	新北市土城區學成路81號	121.451282	24.9881	2026-05-02 14:10:16+00	0101000020E610000081D1E5CDE15C5E40772D211FF4FC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	90807408-SCSD02882	新北員和公園地下停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	20元/小時	計度/固定/8元每度	B1	0800-885-150	新北市土城區中央路2段59號	新北市土城區中央路2段59號	121.442969	24.978827	2026-05-02 14:10:16+00	0101000020E61000001409A69A595C5E401971016894FA3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	90807408-SCSD02883	新北綠湖公園地下停車場	90807408	1	7	7	7	7	{"slow_ac": 7}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市新店區寶中路36號	新北市新店區寶中路36號	121.546333	24.979579	2026-05-02 14:10:16+00	0101000020E610000070EEAF1EF7625E4030D978B0C5FA3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	瑞芳區	90807408-SCSD02884	新北市瑞芳區立體停車場	90807408	1	3	7	7	7	{"slow_ac": 7}	7x24小時	平日20元/小時，假日30元/小時	計度/固定/8元每度	1F	0800-885-150	新北市瑞芳區民權街3之1號	新北市瑞芳區民權街3之1號	121.809347	25.108253	2026-05-02 14:10:16+00	0101000020E610000068075C57CC735E40A3B1F677B61B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	90807408-SCSD02885	新北市蘆洲國小地下停車場	90807408	1	3	5	5	5	{"slow_ac": 5}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市蘆洲區中正路100號	新北市蘆洲區中正路100號	121.469937	25.084184	2026-05-02 14:10:16+00	0101000020E61000008B8BA372135E5E40B2D826158D153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	90807408-SCSD02920	新北新店高中地下停車場	90807408	1	5	6	6	6	{"slow_ac": 6}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市新店區三民路161號	新北市新店區三民路161號	121.534123	24.974231	2026-05-02 14:10:16+00	0101000020E6100000A6423C122F625E40D7BFEB3367F93840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	90807408-SCSD02886	新北市鷺江立體停車場	90807408	1	5	9	9	9	{"slow_ac": 9}	7x24小時	平日20元/小時，假日30元/小時	計度/固定/8元每度	1F	0800-885-150	新北市蘆洲區民權路26號	新北市蘆洲區民權路26號	121.476735	25.086046	2026-05-02 14:10:16+00	0101000020E6100000F37684D3825E5E409DF3531C07163940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	90807408-SCSD02887	新北市成功地下停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市蘆洲區長安街222號	新北市蘆洲區長安街222號	121.458132	25.084956	2026-05-02 14:10:16+00	0101000020E61000001250E108525D5E40569929ADBF153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	90807408-SCSD02888	新北市溪墘地下停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市蘆洲區信義路73巷2號	新北市蘆洲區信義路73巷2號	121.476246	25.079636	2026-05-02 14:10:16+00	0101000020E610000074B680D07A5E5E4092955F0663143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	90807408-SCSD02889	新北市仁愛立體停車場	90807408	1	9	9	9	9	{"slow_ac": 9}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市蘆洲區民權路141號	新北市蘆洲區民權路141號	121.471447	25.0908	2026-05-02 14:10:16+00	0101000020E610000007B309302C5E5E40107A36AB3E173940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02890	新北三重商工地下停車場	90807408	1	7	10	10	10	{"slow_ac": 10}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市三重區力行路1段88號	新北市三重區力行路1段88號	121.482649	25.070585	2026-05-02 14:10:16+00	0101000020E61000009D9CA1B8E35E5E409296CADB11123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三芝區	90807408-SCSD02891	新北市中正停車場	90807408	1	5	5	5	5	{"slow_ac": 5}	7x24小時	10元/小時	計度/固定/8元每度	B1	0800-885-150	新北市三芝區中山路2段48之1號	新北市三芝區中山路2段48之1號	121.503153	25.254658	2026-05-02 14:10:16+00	0101000020E610000098F8A3A833605E402EAA454431413940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD02892	新北市後港公園地下停車場	90807408	1	4	4	4	4	{"slow_ac": 4}	7x24小時	30元/小時	計度/固定/8元每度	B3	0800-885-150	新北市新莊區後港一路19號	新北市新莊區後港一路19號	121.424011	25.026071	2026-05-02 14:10:16+00	0101000020E61000003B8908FF225B5E40C05FCC96AC063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD02893	新北市頭前國中地下停車場	90807408	1	3	5	5	5	{"slow_ac": 5}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市新莊區中原路2號	新北市新莊區中原路2號	121.458088	25.055071	2026-05-02 14:10:16+00	0101000020E61000002AAC5450515D5E4041F50F22190E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD02894	新北市民安國民小學地下停車場	90807408	1	4	4	4	4	{"slow_ac": 4}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市新莊區民安路261號	新北市新莊區民安路261號	121.428446	25.022126	2026-05-02 14:10:16+00	0101000020E61000008786C5A86B5B5E402C64AE0CAA053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02895	新北正義國小地下停車場	90807408	1	3	6	6	6	{"slow_ac": 6}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市三重區信義西街31號	新北市三重區信義西街31號	121.495244	25.064597	2026-05-02 14:10:16+00	0101000020E610000093E2E313B25F5E40726BD26D89103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02896	新北江翠國小地下停車場	90807408	1	3	5	5	5	{"slow_ac": 5}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區文化路2段413號	新北市板橋區文化路2段413號	121.473845	25.033357	2026-05-02 14:10:16+00	0101000020E6100000E197FA79535E5E40B91798158A083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02897	新北特專三臨時平面停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	30元/時	計度/固定/8元每度	1F	0800-885-150	新北市板橋區漢生東路64號旁空地	新北市板橋區漢生東路64號旁空地	121.465581	25.016363	2026-05-02 14:10:16+00	0101000020E6100000E5284014CC5D5E404CDD955D30043940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02898	新北新埔國小地下停車場	90807408	1	5	8	8	8	{"slow_ac": 8}	7x24小時	30元/小時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區陽明街206號	新北市板橋區陽明街206號	121.462579	25.026576	2026-05-02 14:10:16+00	0101000020E61000004034F3E49A5D5E40C6DB4AAFCD063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD02899	新北錦和運動公園地下停車場	90807408	1	12	16	16	16	{"slow_ac": 12, "ultra_fast_dc": 4}	7x24小時	30元/小時	計度/固定/8元每度免費	B1, 1F	0800-885-150	新北市中和區錦和路352號	新北市中和區錦和路352號	121.490762	24.992314	2026-05-02 14:10:16+00	0101000020E6100000A70705A5685F5E40EA5C514A08FE3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02900	新北華翠橋下平面停車場	90807408	1	3	6	6	6	{"slow_ac": 2, "ultra_fast_dc": 4}	7x24小時	30元/時	計度/固定/8元每度免費	1F	0800-885-150	新北市板橋區富山街62巷至太和街間	新北市板橋區富山街62巷至太和街間	121.477266	25.021908	2026-05-02 14:10:16+00	0101000020E6100000895FB1868B5E5E4051853FC39B053940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02901	新北臺北紙廠停車場	90807408	1	2	4	4	4	{"slow_ac": 4}	7x24小時	平日20元/時，假日30元/時	計度/固定/8元每度	1F	0800-885-150	新北市板橋區大觀路2段28號	新北市板橋區大觀路2段28號	121.44456	25.0035	2026-05-02 14:10:16+00	0101000020E61000000647C9AB735C5E4037894160E5003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02902	新北華東平面停車場	90807408	1	3	6	6	6	{"slow_ac": 2, "ultra_fast_dc": 4}	7x24小時	30元/時	計度/固定/8元每度免費	1F	0800-885-150	新北市板橋區南雅南路2段144巷88號對面	新北市板橋區南雅南路2段144巷88號對面	121.450822	24.995845	2026-05-02 14:10:16+00	0101000020E61000004F948444DA5C5E4097E2AAB2EFFE3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02903	新北江翠102平面停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	20元/時	計度/固定/8元每度	1F	0800-885-150	新北市板橋區華江一路及華江七路交叉口	新北市板橋區華江一路及華江七路交叉口	121.468691	25.033765	2026-05-02 14:10:16+00	0101000020E61000007E3B8908FF5D5E40DBBFB2D2A4083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD02904	新北台65高架橋下停車場	90807408	1	2	3	3	3	{"slow_ac": 1, "ultra_fast_dc": 2}	7x24小時	20元/時	計度/固定/8元每度免費	1F	0800-885-150	新北市新莊區中環路2段48之8號斜對面橋下	新北市新莊區中環路2段48之8號斜對面橋下	121.442033	25.044251	2026-05-02 14:10:16+00	0101000020E61000002DB0C7444A5C5E40B7D09508540B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	90807408-SCSD02905	新北中洲平面停車場	90807408	1	3	6	6	6	{"slow_ac": 2, "ultra_fast_dc": 4}	7x24小時	20元/時	計度/固定/8元每度免費	1F	0800-885-150	新北市土城區中洲路11號對面空地	新北市土城區中洲路11號對面空地	121.414198	24.957872	2026-05-02 14:10:16+00	0101000020E610000064045438825A5E400DC1711937F53840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	90807408-SCSD02906	新北永豐平面停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	30元/時	計度/固定/8元每度	1F	0800-885-150	新北市土城區立德路113號對面	新北市土城區立德路113號對面	121.464622	24.986957	2026-05-02 14:10:16+00	0101000020E610000023C0E95DBC5D5E40EB8EC536A9FC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	90807408-SCSD02907	新北明德平面停車場	90807408	1	1	1	1	1	{"slow_ac": 1}	7x24小時	20元/時	計度/固定/8元每度	1F	0800-885-150	新北市土城區永豐路145號對面	新北市土城區永豐路145號對面	121.466671	24.983668	2026-05-02 14:10:16+00	0101000020E610000077BF0AF0DD5D5E402A1F82AAD1FB3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD02908	新北圓通平面停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	20元/時	計度/固定/8元每度	1F	0800-885-150	新北市中和區圓通路369巷33號	新北市中和區圓通路369巷33號	121.49054	24.988019	2026-05-02 14:10:16+00	0101000020E61000004F58E201655F5E409ED32CD0EEFC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	90807408-SCSD02909	新北安和公園臨時平面停車場	90807408	1	1	2	2	2	{"slow_ac": 2}	7x24小時	30元/時(7~22時)，10元/時(22~7時)	計度/固定/8元每度	1F	0800-885-150	新北市新店區安和路2段141號旁	新北市新店區安和路2段141號旁	121.519233	24.973327	2026-05-02 14:10:16+00	0101000020E610000041800C1D3B615E40555051F52BF93840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	鶯歌區	90807408-SCSD02910	新北三鶯轉運站平面停車場	90807408	1	3	4	4	4	{"slow_ac": 2, "ultra_fast_dc": 2}	7x24小時	平日20元/時，假日40元/時	計度/固定/8元每度免費	1F, 平面(北側), 平面(南側)	0800-885-150	新北市鶯歌區館前路與文化路交叉口	新北市鶯歌區館前路與文化路交叉口	121.358002	24.954557	2026-05-02 14:10:16+00	0101000020E6100000C4793881E9565E40FA2AF9D85DF43840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02911	新北江翠國中游泳池共構地下停車場	90807408	1	4	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	B2	0800-885-150	新北市板橋區松江街63號	新北市板橋區松江街63號	121.468499	25.027882	2026-05-02 14:10:16+00	0101000020E61000005BCD3AE3FB5D5E40A725564623073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02912	新北四維公園地下停車場	90807408	1	10	10	10	10	{"slow_ac": 10}	7x24小時	30元/時	計度/固定/8元每度	B1, B2	0800-885-150	新北市板橋區四維路177巷3弄6號	新北市板橋區四維路177巷3弄6號	121.463891	25.02563	2026-05-02 14:10:16+00	0101000020E6100000297AE063B05D5E40E6CB0BB08F063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02913	新北音樂公園地下停車場	90807408	1	4	10	10	10	{"slow_ac": 10}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區大同街76號	新北市板橋區大同街76號	121.480036	25.02822	2026-05-02 14:10:16+00	0101000020E6100000C539EAE8B85E5E40D717096D39073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	90807408-SCSD02914	新北市立鷺江國民中學地下停車場	90807408	1	4	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	B2	0800-885-150	新北市蘆洲區長興路300號	新北市蘆洲區長興路300號	121.460765	25.090338	2026-05-02 14:10:16+00	0101000020E61000000D897B2C7D5D5E400796236420173940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD02915	新北市新莊國中運動場地下停車場	90807408	1	5	6	6	6	{"slow_ac": 6}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市新莊區景德路138號	新北市新莊區景德路138號	121.451316	25.034264	2026-05-02 14:10:16+00	0101000020E6100000570A815CE25C5E401E6E8786C5083940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三芝區	90807408-SCSD02916	新北市中山停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	10元/時	計度/固定/8元每度	2F	0800-885-150	新北市三芝區淡金路1段61號	新北市三芝區淡金路1段61號	121.500262	25.259009	2026-05-02 14:10:16+00	0101000020E61000009F5BE84A04605E40A25EF0694E423940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02917	新北二重公園地下停車場	90807408	1	4	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市三重區疏洪東路2段131號	新北市三重區疏洪東路2段131號	121.475227	25.066316	2026-05-02 14:10:16+00	0101000020E610000047CB811E6A5E5E409833DB15FA103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	90807408-SCSD02918	新北中興低碳立體停車場	90807408	1	7	8	8	8	{"slow_ac": 8}	7x24小時	平日20元/時，假日30元/時	計度/固定/8元每度	1F	0800-885-150	新北市新店區中興路3段6號	新北市新店區中興路3段6號	121.547288	24.977152	2026-05-02 14:10:16+00	0101000020E6100000915F3FC406635E4093382BA226FA3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	深坑區	90807408-SCSD02919	新北兒童遊戲場地下停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	平日20元/時，假日40元/時	計度/固定/8元每度	1F, B1	0800-885-150	新北市深坑區文化街與平埔街口	新北市深坑區文化街與平埔街口	121.615591	25.001815	2026-05-02 14:10:16+00	0101000020E6100000902DCBD765675E406AA4A5F276003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02921	新北板橋國小地下停車場	90807408	1	4	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區文化路1段23號	新北市板橋區文化路1段23號	121.456409	25.012013	2026-05-02 14:10:16+00	0101000020E6100000672618CE355D5E407920B24813033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02922	新北重慶公園地下停車場	90807408	1	3	7	7	7	{"slow_ac": 7}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區重慶路265號	新北市板橋區重慶路265號	121.463728	24.999861	2026-05-02 14:10:16+00	0101000020E6100000548F34B8AD5D5E40BD8BF7E3F6FF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02923	新北市民廣場地下停車場	90807408	1	5	17	17	17	{"slow_ac": 17}	7x24小時	平日30元/時，假日40元/時	計度/固定/8元每度	B2	0800-885-150	新北市板橋區縣民大道2段22號	新北市板橋區縣民大道2段22號	121.465669	25.014099	2026-05-02 14:10:16+00	0101000020E6100000B5705985CD5D5E4004E8F7FD9B033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02924	新北板橋國民中學地下停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	平日20元/時，假日30元/時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區中正路437號	新北市板橋區中正路437號	121.454335	25.025236	2026-05-02 14:10:16+00	0101000020E6100000679B1BD3135D5E408EAED2DD75063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02925	新北民生公園地下停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	40元/時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區民生路1段30號	新北市板橋區民生路1段30號	121.475675	25.013311	2026-05-02 14:10:16+00	0101000020E610000096218E75715E5E4054AD855968033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02926	新北民權立體停車場	90807408	1	3	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	2F	0800-885-150	新北市板橋區民權路89號	新北市板橋區民權路89號	121.460475	25.011991	2026-05-02 14:10:16+00	0101000020E61000000A68226C785D5E40A9D898D711033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02927	新北府後立體停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	30元/時	計度/固定/8元每度	4F	0800-885-150	新北市板橋區府中路32-1號	新北市板橋區府中路32-1號	121.458657	25.010301	2026-05-02 14:10:16+00	0101000020E610000037C5E3A25A5D5E40B81D1A16A3023940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02928	新北市立圖書館地下停車場	90807408	1	3	5	5	5	{"slow_ac": 5}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區貴興路139號	新北市板橋區貴興路139號	121.455095	25.001393	2026-05-02 14:10:16+00	0101000020E6100000AE64C746205D5E407E71A94A5B003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02930	新北板橋高中地下停車場	90807408	1	3	5	5	5	{"slow_ac": 5}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區文化路1段25號	新北市板橋區文化路1段25號	121.458289	25.012112	2026-05-02 14:10:16+00	0101000020E610000075C7629B545D5E409FE3A3C519033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02931	新北中山國小地下停車場	90807408	1	5	5	5	5	{"slow_ac": 5}	7x24小時	20元/時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區大觀路2段59巷31號	新北市板橋區大觀路2段59巷31號	121.448553	25.001169	2026-05-02 14:10:16+00	0101000020E61000007461A417B55C5E40DFC4909C4C003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02932	新北忠孝國民中學地下停車場	90807408	1	5	10	10	10	{"slow_ac": 10}	7x24小時	平日30元/時，假日40元/時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區成都街30號	新北市板橋區成都街30號	121.462235	25.004151	2026-05-02 14:10:16+00	0101000020E610000043041C42955D5E40E63E390A10013940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02933	新北五權公園地下停車場	90807408	1	7	7	7	7	{"slow_ac": 7}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區廣權路130號	新北市板橋區廣權路130號	121.465551	24.993075	2026-05-02 14:10:16+00	0101000020E6100000B0E76B96CB5D5E40A779C7293AFE3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	坪林區	90807408-SCSD02934	新北水柳腳立體停車場	90807408	1	3	4	4	4	{"slow_ac": 4}	7x24小時	20元/時	計度/固定/8元每度	1F, B1	0800-885-150	新北市坪林區水柳腳34之1號	新北市坪林區水柳腳34之1號	121.71046	24.935442	2026-05-02 14:10:16+00	0101000020E61000006F47382D786D5E40094E7D2079EF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD02935	新北中和國小地下停車場	90807408	1	5	12	12	12	{"slow_ac": 12}	7x24小時	平日30元/時，假日40元/時	計度/固定/8元每度	B1	0800-885-150	新北市中和區景平路632-8號	新北市中和區景平路632-8號	121.499909	24.998571	2026-05-02 14:10:16+00	0101000020E6100000787E5182FE5F5E40E8BB5B59A2FF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD02936	新北民樂立體停車場	90807408	1	3	5	5	5	{"slow_ac": 5}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市中和區民樂路65號	新北市中和區民樂路65號	121.483546	25.001583	2026-05-02 14:10:16+00	0101000020E61000002507EC6AF25E5E40C53A55BE67003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD02937	新北中和地政事務所及稅捐稽徵處	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	平日20元/時，假日30元/時	計度/固定/8元每度	B1, B2	0800-885-150	新北市中和區復興路278號	新北市中和區復興路278號	121.502334	24.990792	2026-05-02 14:10:16+00	0101000020E6100000CF6A813D26605E407023658BA4FD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02938	新北中山立體停車場	90807408	1	5	9	9	9	{"slow_ac": 9}	7x24小時	30元/時	計度/固定/8元每度	2F	0800-885-150	新北市三重區新北大道1段7號	新北市三重區新北大道1段7號	121.489604	25.061005	2026-05-02 14:10:16+00	0101000020E610000069FF03AC555F5E407AE40F069E0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	90807408-SCSD02939	新北停三立體停車場	90807408	1	3	3	3	3	{"slow_ac": 3}	7x24小時	平日20元/時，假日30元/時	計度/固定/8元每度	1F	0800-885-150	新北市林口區中山路99號	新北市林口區中山路99號	121.389284	25.078752	2026-05-02 14:10:16+00	0101000020E6100000CA367007EA585E409E7E501729143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	90807408-SCSD02940	新北林口公車轉運站平面停車場	90807408	1	2	2	2	2	{"ultra_fast_dc": 2}	7x24小時	平日20元/時，假日30元/時。<進場30分鐘內免停車費>	浮動費率,,計度/離峰/00:00-11:00/8.4元每度,計度/一般/*11:01-23:59/11元每度	1F	0800-885-150	新北市林口區八德路260號	新北市林口區八德路260號	121.361835	25.065977	2026-05-02 14:10:16+00	0101000020E610000015E3FC4D28575E40C74961DEE3103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	90807408-SCSD02941	新北中央公園地下停車場	90807408	1	5	6	6	6	{"slow_ac": 6}	7x24小時	20元/時	計度/固定/8元每度	B2	0800-885-150	新北市土城區中央路1段325-1號	新北市土城區中央路1段325-1號	121.444762	24.98315	2026-05-02 14:10:16+00	0101000020E61000003A2009FB765C5E40F90FE9B7AFFB3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	90807408-SCSD02942	新北市永康公園地下停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市蘆洲區長安街及長安街220巷口	新北市蘆洲區長安街及長安街220巷口	121.458347	25.084557	2026-05-02 14:10:16+00	0101000020E610000010CEA78E555D5E40DBA50D87A5153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	金山區	90807408-SCSD02943	新北市金山立體停車場	90807408	1	5	7	7	7	{"slow_ac": 7}	7x24小時	平日20元/時，假日30元/時	計度/固定/8元每度	1F	0800-885-150	新北市金山區中興路101號	新北市金山區中興路101號	121.641663	25.220227	2026-05-02 14:10:16+00	0101000020E61000006803B00111695E403AB2F2CB60383940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD02944	新北市新莊運動公園地下停車場	90807408	1	9	12	12	12	{"slow_ac": 12}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市新莊區復興路1段99號對面	新北市新莊區復興路1段99號對面	121.447791	25.042413	2026-05-02 14:10:16+00	0101000020E61000005C1C959BA85C5E40DDEC0F94DB0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	永和區	90807408-SCSD02945	新北仁愛公園地下停車場	90807408	1	3	13	13	13	{"slow_ac": 13}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市永和區仁愛路244-1號	新北市永和區仁愛路244-1號	121.506209	25.010088	2026-05-02 14:10:16+00	0101000020E610000037FC6EBA65605E4001158E2095023940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	永和區	90807408-SCSD02946	新北永和國小地下停車場	90807408	1	5	6	6	6	{"slow_ac": 6}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市永和區中正路299號	新北市永和區中正路299號	121.517269	25.00182	2026-05-02 14:10:16+00	0101000020E6100000048F6FEF1A615E408D7A884677003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	永和區	90807408-SCSD02947	新北秀朗國民小學地下停車場	90807408	1	7	15	15	15	{"slow_ac": 15}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市永和區民權路1號	新北市永和區民權路1號	121.520332	24.998833	2026-05-02 14:10:16+00	0101000020E6100000FCC3961E4D615E40632AFD84B3FF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	永和區	90807408-SCSD02948	新北福和國中地下停車場	90807408	1	7	11	11	11	{"slow_ac": 11}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市永和區永亨路96號	新北市永和區永亨路96號	121.522887	25.004688	2026-05-02 14:10:16+00	0101000020E61000003A2009FB76615E4004AF963B33013940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	永和區	90807408-SCSD02949	新北網溪國小地下停車場	90807408	1	5	13	13	13	{"slow_ac": 13}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市永和區竹林路79號	新北市永和區竹林路79號	121.519858	25.013837	2026-05-02 14:10:16+00	0101000020E610000018247D5A45615E40897956D28A033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	90807408-SCSD02950	新北大豐地下停車場	90807408	1	3	4	4	4	{"slow_ac": 4}	7x24小時	30元/時	計度/固定/8元每度	B2	0800-885-150	新北市新店區民族路109號	新北市新店區民族路109號	121.538394	24.977241	2026-05-02 14:10:16+00	0101000020E610000035971B0C75625E40724F57772CFA3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	90807408-SCSD02951	新北安康立體停車場	90807408	1	3	4	4	4	{"slow_ac": 4}	7x24小時	30元(7時~22時)，10元(22時~7時)	計度/固定/8元每度	4F	0800-885-150	新北市新店區安康路2段120號	新北市新店區安康路2段120號	121.512632	24.962686	2026-05-02 14:10:16+00	0101000020E610000084B872F6CE605E402B51F69672F63840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	90807408-SCSD02952	新北北新地下停車場	90807408	1	3	7	7	7	{"slow_ac": 7}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市新店區北新路1段92號	新北市新店區北新路1段92號	121.54256	24.9682	2026-05-02 14:10:16+00	0101000020E61000008907944DB9625E40B9FC87F4DBF73840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	90807408-SCSD02953	新北寶橋立體停車場	90807408	1	2	10	10	10	{"slow_ac": 10}	7x24小時	30元/小時	計度/固定/8元每度	1F, 1F	0800-885-150	新北市新店區寶橋路10號	新北市新店區寶橋路10號	121.545719	24.974504	2026-05-02 14:10:16+00	0101000020E61000009373620FED625E4039D2191879F93840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	樹林區	90807408-SCSD02954	新北第七立體停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	20元/時	計度/固定/8元每度	2F露天	0800-885-150	新北市樹林區復興路202號	新北市樹林區復興路202號	121.419697	24.990625	2026-05-02 14:10:16+00	0101000020E6100000AD4ECE50DC5A5E409A99999999FD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	樹林區	90807408-SCSD02955	新北樹林藝文綜合行政大樓地下停車場	90807408	1	5	5	5	5	{"slow_ac": 5}	7x24小時	平日20元/時，假日30元/時	計度/固定/8元每度	B1	0800-885-150	新北市樹林區樹新路40-7號	新北市樹林區樹新路40-7號	121.428787	24.996278	2026-05-02 14:10:16+00	0101000020E6100000CC7C073F715B5E406BB933130CFF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD02956	新北景新立體停車場	90807408	1	3	4	4	4	{"slow_ac": 4}	7x24小時	平日30元/時，假日40元/時	計度/固定/8元每度	B1	0800-885-150	新北市中和區景新街399巷12號	新北市中和區景新街399巷12號	121.513224	24.989691	2026-05-02 14:10:16+00	0101000020E61000006DE179A9D8605E404225AE635CFD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	烏來區	90807408-SCSD02957	新北烏來立體停車場	90807408	1	5	8	8	8	{"slow_ac": 8}	7x24小時	室內:平日60元/次，假日30元/小時；路邊:平日60元/次，假日90元/次	計度/固定/8元每度	2F	0800-885-150	新北市烏來區烏來街47號	新北市烏來區烏來街47號	121.551642	24.865513	2026-05-02 14:10:16+00	0101000020E610000067463F1A4E635E404A438D4292DD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD02958	新北萬板高架橋下停車場	90807408	1	3	6	6	6	{"slow_ac": 2, "ultra_fast_dc": 4}	7x24小時	平日20元/時，假日30元/時	計度/固定/8元每度免費	1F	0800-885-150	新北市板橋區萬板路558號對面	新北市板橋區萬板路558號對面	121.481012	25.026614	2026-05-02 14:10:16+00	0101000020E6100000F33E8EE6C85E5E40A19DD32CD0063940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD02959	新北民德立體停車場	90807408	1	3	8	8	8	{"slow_ac": 8}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市中和區民德路188號	新北市中和區民德路188號	121.468304	24.999167	2026-05-02 14:10:16+00	0101000020E6100000812557B1F85D5E40103E9468C9FF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD02960	新北民享公園地下停車場	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市中和區自治街67號	新北市中和區自治街67號	121.47562	25.003547	2026-05-02 14:10:16+00	0101000020E6100000B554DE8E705E5E40B9FFC874E8003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD02961	新北秀山公園地下停車場	90807408	1	5	8	8	8	{"slow_ac": 8}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市中和區自立路15巷12號	新北市中和區自立路15巷12號	121.523581	24.995689	2026-05-02 14:10:16+00	0101000020E6100000A5F3E15982615E40A8FC6B79E5FE3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD02962	新北佳和公園地下停車場	90807408	1	6	6	6	6	{"slow_ac": 6}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市中和區中山路2段64巷9號	新北市中和區中山路2段64巷9號	121.502912	25.004855	2026-05-02 14:10:16+00	0101000020E61000000531D0B52F605E40DA38622D3E013940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	90807408-SCSD02965	新北高工地下停車場	90807408	1	5	5	5	5	{"slow_ac": 5}	7x24小時	30元/時	計度/固定/8元每度	B2	0800-885-150	新北市土城區明德路二段60號14號	新北市土城區明德路二段60號14號	121.448808	24.983839	2026-05-02 14:10:16+00	0101000020E6100000B98B3045B95C5E40838769DFDCFB3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD02966	新北重陽公園地下停車場	90807408	1	6	6	6	6	{"slow_ac": 6}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市三重區朝陽街77號	新北市三重區朝陽街77號	121.483176	25.057609	2026-05-02 14:10:16+00	0101000020E6100000938D075BEC5E5E408CF4A276BF0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	永和區	90807408-SCSD02967	新北頂溪國小地下停車場	90807408	1	5	9	9	9	{"slow_ac": 9}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市永和區文化路135巷12號	新北市永和區文化路135巷12號	121.510753	25.015622	2026-05-02 14:10:16+00	0101000020E61000005ED5592DB0605E401E19ABCDFF033940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD02968	新北中港平面停車場	90807408	1	1	1	1	1	{"slow_ac": 1}	7x24小時	30元(20時~0時)，20元(0時~20時)	計度/固定/8元每度	1F平面	0800-885-150	新北市新莊區中港路及中華路2段交叉口	新北市新莊區中港路及中華路2段交叉口	121.453007	25.044616	2026-05-02 14:10:16+00	0101000020E6100000FB761211FE5C5E40DBE044F46B0B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	鶯歌區	90807408-SCSD02969	新北公八公園平面停車場	90807408	1	1	1	1	1	{"slow_ac": 1}	7x24小時	平日20元/時，假日40元/時	計度/固定/8元每度	1F	0800-885-150	新北市鶯歌區國華路31號對面	新北市鶯歌區國華路31號對面	121.342511	24.95554	2026-05-02 14:10:16+00	0101000020E61000004CE141B3EB555E401405FA449EF43840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三峽區	90807408-SCSD03173	歐特儀_三峽台北大學運動場停車場	90807408	1	20	20	20	20	{"slow_ac": 20}	7x24小時	20元/時，當日上限250元	計度/固定/8元每度	4B2, 5B2, B2	0800-885-150	新北市三峽區大學路151號B1	新北市三峽區大學路151號B1	121.364274	24.938824	2026-05-02 14:10:16+00	0101000020E61000001E32E54350575E402DB308C556F03840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90807408-SCSD03192	力揚_板橋體育場	90807408	3	2	2	2	2	{"slow_ac": 2}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市板橋區漢生東路278號B1	新北市板橋區漢生東路278號B1	121.469913	25.009854	2026-05-02 14:10:16+00	0101000020E6100000C7BDF90D135E5E401BBCAFCA85023940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	90807408-SCSD03203	新北建昇淡水行政中心	90807408	3	1	2	2	2	{"ultra_fast_dc": 2}	7x24小時	平日40元/時，假日50元/時	浮動費率,,計度/離峰/00:00-11:00/8.4元每度,計度/一般/*11:01-23:59/9.5元每度	1F	0800-885-150	新北市淡水區濱海路一段300號	新北市淡水區濱海路一段300號	121.440729	25.189988	2026-05-02 14:10:16+00	0101000020E6100000865968E7345C5E40E8A1B60DA3303940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD03220	新北國家電影及視聽文化中心	90807408	3	2	2	2	2	{"slow_ac": 2}	每日/07:00-23:00	平日15元/30分鐘(當日最高上限120元)，假日25元/30分鐘(當日最高上限200元)；館內消費不限金額，停車費比照平日收費(唯無最高收費上限)	計度/固定/8元每度	B1	0800-885-150	新北市新莊區文藝路2號B1	新北市新莊區文藝路2號B1	121.44742	25.056796	2026-05-02 14:10:16+00	0101000020E6100000E2E47E87A25C5E402A8BC22E8A0E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD03230	新北晶冠廣場	90807408	1	8	8	8	8	{"slow_ac": 8}	7x24小時	40元/時	計度/固定/8元每度	B2	0800-885-150	新北市新莊區五工路66號B2	新北市新莊區五工路66號B2	121.458322	25.063823	2026-05-02 14:10:16+00	0101000020E61000006342CC25555D5E408CBB41B456103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD03253	歐特儀_新北文中小平面停車場	90807408	3	6	6	6	6	{"slow_ac": 6}	7x24小時	平日20元/時，假日30元/時(24小時內最高收費200元)	計度/固定/8元每度	1F	0800-885-150	新北市三重區三陽路100巷3弄172-7號	新北市三重區三陽路100巷3弄172-7號	121.482223	25.058943	2026-05-02 14:10:16+00	0101000020E61000004298DBBDDC5E5E40005471E3160F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90807408-SCSD03263	新北興穀國小操場地下停車場	90807408	1	7	7	7	7	{"slow_ac": 7}	7x24小時	平日30元/時，假日40元/時	計度/固定/8元每度	B1	0800-885-150	新北市三重區五谷王北街46號B1	新北市三重區五谷王北街46號B1	121.475523	25.049805	2026-05-02 14:10:16+00	0101000020E6100000BB5F05F86E5E5E40622D3E05C00C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	90807408-SCSD03463	易亭_新北新店中正停車場	90807408	3	2	2	2	2	{"slow_ac": 2}	7x24小時	40元/時，當日最高上限180元	計度/固定/8元每度	1F	0800-885-150	新北市新店區中正路660號	新北市新店區中正路660號	121.5341	24.98942	2026-05-02 14:10:16+00	0101000020E6100000CA32C4B12E625E4021020EA14AFD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD03467	新北市新莊國民運動中心	90807408	1	6	6	6	6	{"slow_ac": 6}	7x24小時	30元/時	計度/固定/8元每度	B2	0800-885-150	新北市新莊區和興街35-8號B2	新北市新莊區和興街35-8號B2	121.447089	25.039745	2026-05-02 14:10:16+00	0101000020E6100000B0592E1B9D5C5E40F52D73BA2C0A3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	90807408-SCSD03484	新北新莊農會_信用部	90807408	1	2	2	2	2	{"slow_ac": 2}	7x24小時	30元/時	計度/固定/8元每度	B2	0800-885-150	新北市新莊區中正路80號B2	新北市新莊區中正路80號B2	121.457871	25.037414	2026-05-02 14:10:16+00	0101000020E61000005BB22AC24D5D5E409C69C2F693093940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	90807408-SCSD03505	力揚_新北蘆洲重陽大樓停車場	90807408	3	1	1	1	1	{"slow_ac": 1}	7x24小時	30元/時	計度/固定/8元每度	B1	0800-885-150	新北市蘆洲區集賢路245號B1	新北市蘆洲區集賢路245號B1	121.481917	25.084479	2026-05-02 14:10:16+00	0101000020E6100000BB9866BAD75E5E40E4326E6AA0153940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90807408-SCSD03541	力揚_新北中和安邦青年社會住宅	90807408	1	5	8	8	8	{"slow_ac": 4, "medium_dc": 4}	7x24小時	40元/時	免費計度/固定/7元每度	B1	0800-885-150	新北市中和區連城路144巷3弄1號B1	新北市中和區連城路144巷3弄1號B1	121.495317	24.998502	2026-05-02 14:10:16+00	0101000020E6100000C8091346B35F5E4097FDBAD39DFF3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	八里區	90807408-SCSD03547	新北市八里區行政中心	90807408	1	8	8	8	8	{"slow_ac": 8}	7x24小時	20元/時	計度/固定/8元每度	1F	0800-885-150	新北市八里區八里大道18號	新北市八里區八里大道18號	121.406811	25.154312	2026-05-02 14:10:16+00	0101000020E6100000CC290131095A5E405F61C1FD80273940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	金山區	90807408-SCSD03554	力揚_新北金山老街文化一路停車場	90807408	1	1	1	1	1	{"slow_ac": 1}	7x24小時	平日:80元/次；假日:100元/次	計度/固定/8元每度	1F	0800-885-150	新北市金山區文化二路2號旁平面停車場	新北市金山區文化二路2號旁平面停車場	121.637678	25.223718	2026-05-02 14:10:16+00	0101000020E61000003CD862B7CF685E40CB86359545393940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	汐止區	12681939-Shfc_17	上嘉管理顧問有限公司汐科營業所	12681939	1	4	4	4	5	{"slow_ac": 3, "medium_dc": 2}	24H	每小時60元	一度8.5元	1F	02-22697887	新北市汐止區復興路2號	新北市汐止區復興路2號	121.65527	25.06538	2026-05-02 14:10:16+00	0101000020E6100000320395F1EF695E40FFCF61BEBC103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	12681939-SPSS_YA41001	城市車旅三重元信(三重元信2)	12681939	3	2	2	2	3	{"slow_ac": 1, "medium_dc": 2}	24H	一小時60元	1度10元	1	02-22697887	新北市三重區仁義街120號	新北市三重區仁義街120號	121.497697	25.0800244	2026-05-02 14:10:16+00	0101000020E61000004F948444DA5F5E40CCE1A47A7C143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	24394433-Ssungreen_20	ECAR-台灣藝術大學站	24394433	3	2	2	2	2	{"slow_ac": 2}	24H	一小時30元	1度8元	1F	02-22697887	新北市板橋區大觀路一段59號	新北市板橋區大觀路一段59號	121.44753	25.00546	2026-05-02 14:10:16+00	0101000020E6100000A67EDE54A45C5E40A86F99D365013940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	60219358-S168_8	及泰企業有限公司紅毛城停車場	60219358	1	1	1	2	2	{"slow_ac": 2}	24H	30	慢充每度8元	1F	02-22697887	新北市淡水區中正路28巷1號	新北市淡水區中正路28巷1號	121.43208	25.17505	2026-05-02 14:10:16+00	0101000020E61000005D50DF32A75B5E40302AA913D02C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	80390037-S168_7	根基國際有限公司青潭國民小學停車場	80390037	1	2	2	2	2	{"slow_ac": 2}	24H	30	慢充每度8元	1F	(02)27546661	新北市新店區北宜路82巷旁空地	新北市新店區北宜路82巷旁空地	121.55448	24.95204	2026-05-02 14:10:16+00	0101000020E61000004F92AE997C635E40DD7BB8E4B8F33840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	86711789-Sgowin_1	國雲停車-府中汽車停車場	86711789	1	2	2	2	2	{"slow_ac": 2}	24H	平日60元/時；假日100元/時	9:00-24:00  8元/度,24:00-09:00 5元/度	1F	02-25573722	新北市板橋區縣民大道一段與府中路口1號	新北市板橋區縣民大道一段與府中路口1號	121.45876	25.0076	2026-05-02 14:10:16+00	0101000020E6100000A12DE7525C5D5E401973D712F2013940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	87545768-S168_11	江翠停五平面停車場	87545768	1	1	1	8	8	{"slow_ac": 8}	24H	30	慢充每度8元	1F	02-22697887	新北市板橋區中正路560號	新北市板橋區中正路560號	121.45558	25.02783	2026-05-02 14:10:16+00	0101000020E61000008C2D0439285D5E4002D9EBDD1F073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	87545768-S168_26	市立殯儀館停車場	87545768	1	1	1	1	1	{"slow_ac": 1}	24H	30	慢充每度8元	1F	02-22697887	新北市板橋區中正路560號殯儀館附屬平面停車空間	新北市板橋區中正路560號殯儀館附屬平面停車空間	121.45659	25.02846	2026-05-02 14:10:16+00	0101000020E6100000906B43C5385D5E40813E912749073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三峽區	87545789-S168_13	新北市立殯儀館三峽火化立體停車場	87545789	1	1	1	2	2	{"slow_ac": 2}	24H	30	慢充每度8元	1F	02-22697887	新北市三峽區介壽路260巷1號	新北市三峽區介壽路260巷1號	121.40795	24.94835	2026-05-02 14:10:16+00	0101000020E6100000CE1951DA1B5A5E405F29CB10C7F23840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	汐止區	90148497-S1046	白雲國民小學	90148497	1	1	1	1	1	{"slow_ac": 1}	平日 /07:00-19:00	免費	計度/固定/9 元每度	B1	0982052927	新北市汐止區民權街二段90	新北市汐止區民權街二段90	121.618677	25.047103	2026-05-02 14:10:16+00	0101000020E610000065726A6798675E40228B34F10E0C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	90148497-S1171	興南國民小學	90148497	2	1	1	1	1	{"slow_ac": 1}	週一~週日 00:00~23:59	$3,100/月	$9/kWh	B1	0939310208	新北市中和興南路一段13524	新北市中和興南路一段13524	121.50968	24.987066	2026-05-02 14:10:16+00	0101000020E610000038DBDC989E605E4058FE7C5BB0FC3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	汐止區	90148497-S1215	星舟x城市車旅_汐止遠雄iFG	90148497	3	18	16	16	18	{"slow_ac": 14, "medium_dc": 4}	24小時開放。	停車費率依現場公告為準。	充電費率依系統公告為準。	1	(02)28328057	新北市汐止新台五路93-99	新北市汐止新台五路93-99	121.650582	25.062755	2026-05-02 14:10:16+00	0101000020E61000007157AF22A3695E4015A930B610103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	90148497-S1240	星舟x城市車旅_三重冠德心天匯	90148497	3	2	1	1	2	{"medium_dc": 2}	24小時開放。	停車費率依現場公告為準。	充電費率依系統公告為準。	B1	(02)28328057	新北市三重區重新路五段611	新北市三重區重新路五段611	121.46805	25.044641	2026-05-02 14:10:16+00	0101000020E610000024B9FC87F45D5E408C0FB3976D0B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	90482725-S0080	學府停車場	90482725	3	2	2	2	2	{"slow_ac": 2}	每日/00:00-24:00	計時/平日/25元每半小時/假日/45元每半小時	計度/固定/7.8元每度	B1	(02)-26028799	新北市淡水區鄧公路2巷6號	新北市淡水區鄧公路2巷6號	121.44864	25.16881	2026-05-02 14:10:16+00	0101000020E61000005BEB8B84B65C5E40DE3CD521372B3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	50965513-SPDP3104001	立言停車場	50965513	3	2	2	2	2	{"slow_ac": 2}	24小時/每日/00:00-24:00	計時/平日/08:00-20:00/每小時40元/每日最高200元,計時/平日/20:00-08:00/每小時10元/每日最高200元,計時/假日/08:00-20:00/每小時20元/每日最高200元,計時/假日/20:00-08:00/每小時10元/每日最高200元	計度/00:00-24:00/每度7元	1	(02)8912-1051	新北中和中山路二段544巷3號	新北中和中山路二段544巷3號	121.48475	25.00673	2026-05-02 14:10:16+00	0101000020E61000001B2FDD24065F5E40EFE6A90EB9013940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	90444103-S53	淞和快充 土城站 evbar	90444103	3	3	3	3	5	{"fast_dc": 4, "slow_ac": 1}	7x24 小時	免費	計度/尖峰/16:00-22:00/13.50 元每度, 計度/尖峰/15:00-21:00/13.50 元每度, 計度/離峰/23:59-16:00/6.00 元每度, 計度/離峰/22:00-23:59/6.00 元每度, 計度/離峰/23:59-15:00/6.00 元每度, 計度/離峰/21:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.50 元每度, 計度/離峰/00:00-23:59/6.50 元每度	1	02-22559610	新北市土城區學士路72號	新北市土城區學士路72號	121.449766124708	24.9796477958895	2026-05-02 14:10:16+00	0101000020E61000000D1EDBF7C85C5E40A2F1AC32CAFA3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三峽區	46037888-S59	全尚大同路充電站 evbar	46037888	3	1	1	1	1	{"slow_ac": 1}	7x24 小時	免費	固定費率(非尖峰費率)	1	02-22559610	新北市三峽區大同路214號	新北市三峽區大同路214號	121.366924724812	24.9266330899188	2026-05-02 14:10:16+00	0101000020E6100000534AD7B17B575E40B99780D337ED3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三峽區	46037888-S60	全尚國際二街充電站 evbar	46037888	3	1	1	1	1	{"slow_ac": 1}	7x24 小時	免費	固定費率(非尖峰費率)	1	02-22559610	新北市三峽區國際二街25號	新北市三峽區國際二街25號	121.372871127356	24.9434748704619	2026-05-02 14:10:16+00	0101000020E61000007867DC1EDD575E40503BB19187F13840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	54991324-S62	新莊思源快充站 evbar	54991324	3	1	1	1	2	{"fast_dc": 2}	7x24 小時	免費	計度/尖峰/09:00-23:59/8.90 元每度, 計度/尖峰/06:00-11:00/8.90 元每度, 計度/尖峰/14:00-23:59/8.90 元每度, 計度/離峰/23:59-09:00/5.90 元每度, 計度/離峰/23:59-06:00/5.90 元每度, 計度/離峰/11:00-14:00/5.90 元每度, 計度/半尖峰/09:00-23:59/5.90 元每度, 計度/半尖峰/06:00-11:00/5.90 元每度, 計度/半尖峰/14:00-23:59/5.90 元每度, 計度/離峰/23:59-09:00/5.90 元每度, 計度/離峰/23:59-06:00/5.90 元每度, 計度/離峰/11:00-14:00/5.90 元每度, 計度/離峰/00:00-23:59/5.90 元每度, 計度/離峰/00:00-23:59/5.90 元每度	1	02-22559610	新北市新莊區思源路507號	新北市新莊區思源路507號	121.459530883638	25.0569514298367	2026-05-02 14:10:16+00	0101000020E61000008A2E39F4685D5E40EC9B705E940E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	樹林區	46037888-S64	全尚學成路充電站 evbar	46037888	3	1	1	1	1	{"slow_ac": 1}	7x24 小時	計時/每日/10 元每小時	固定費率(非尖峰費率)	1	02-22559610	新北市樹林區學成路540號旁	新北市樹林區學成路540號旁	121.380843453649	24.9457748083847	2026-05-02 14:10:16+00	0101000020E61000005D9438BD5F585E4099643F4C1EF23840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	46037888-S65	全尚粗坑里辦事處充電站 evbar	46037888	3	1	1	1	1	{"slow_ac": 1}	7x24 小時	計時/每日/60 元每小時	固定費率(非尖峰費率)	1	02-22559610	新北市新店區花園二路一段11-303號	新北市新店區花園二路一段11-303號	121.555377100368	24.9327351840537	2026-05-02 14:10:16+00	0101000020E6100000C9C1644C8B635E40D556A7BBC7EE3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	永和區	89132567-S0109	Acon-eco新北永和運動中心站	89132567	3	6	6	6	6	{"slow_ac": 6}	24小時	計時/每日/30元/每小時	計度/固定/8元每度	B1	0800-868885	新北市永和區永利路250號B	新北市永和區永利路250號B	121.524995	25.00342	2026-05-02 14:10:16+00	0101000020E610000011E4A08499615E40FE261422E0003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	中和區	54991324-S74	中和充電站 evbar	54991324	3	4	4	4	4	{"slow_ac": 4}	7x24 小時	免費	計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/半尖峰/09:00-23:59/6.00 元每度, 計度/半尖峰/06:00-11:00/6.00 元每度, 計度/半尖峰/14:00-23:59/6.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度	1	02-22559610	新北市中和區板南路與大洋街口	新北市中和區板南路與大洋街口	121.491374106274	25.0007325079423	2026-05-02 14:10:16+00	0101000020E6100000132361AC725F5E40FFA7710130003940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	46037888-S122	全尚誠陽車業 evbar	46037888	3	1	1	1	1	{"slow_ac": 1}	7x24 小時	免費	固定費率(非尖峰費率)	1	02-22559610	新北市土城區中華路二段26號	新北市土城區中華路二段26號	121.439138624736	24.9785830977845	2026-05-02 14:10:16+00	0101000020E6100000B3E9E3D81A5C5E401E67016C84FA3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	鶯歌區	53328840-S132	全方位停車場鶯桃站 evbar	53328840	3	2	2	2	2	{"slow_ac": 2}	星期一：00:00～23:59\n星期二：00:00～23:59\n星期三：00:00～23:59\n星期四：00:00～23:59\n星期五：00:00～23:59\n星期六：00:00～23:59\n星期日：00:00～11:59	免費	固定費率(非尖峰費率)	1	02-22559610	新北市鶯歌區鶯桃路129號	新北市鶯歌區鶯桃路129號	121.338396371164	24.9546668807791	2026-05-02 14:10:16+00	0101000020E610000001CF4049A8555E404485770C65F43840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	34176631-S179	新北市立江翠國民中學 evbar	34176631	2	1	1	1	1	{"slow_ac": 1}	7x24 小時	計時/每日/20 元每小時	計度/尖峰/09:00-23:59/8.00 元每度, 計度/尖峰/06:00-11:00/8.00 元每度, 計度/尖峰/14:00-23:59/8.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/半尖峰/09:00-23:59/6.00 元每度, 計度/半尖峰/06:00-11:00/6.00 元每度, 計度/半尖峰/14:00-23:59/6.00 元每度, 計度/離峰/23:59-09:00/6.00 元每度, 計度/離峰/23:59-06:00/6.00 元每度, 計度/離峰/11:00-14:00/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度, 計度/離峰/00:00-23:59/6.00 元每度		02-22559610	新北市板橋區松江街63號	新北市板橋區松江街63號	121.466556600655	25.0279145394091	2026-05-02 14:10:16+00	0101000020E6100000F4623710DC5D5E4051D8416825073940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	汐止區	24788035-S185	汐科站停車場 evbar	24788035	1	4	4	4	4	{"slow_ac": 4}	7x24 小時	免費	固定費率(非尖峰費率)	1	02-22559610	新北市汐止區復興路2號	新北市汐止區復興路2號	121.656115922089	25.0654441179494	2026-05-02 14:10:16+00	0101000020E610000075F0A2CDFD695E40E94E1AF2C0103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	34220432-S238	蘆洲區忠義國小地下停車場 evbar	34220432	1	2	2	2	2	{"slow_ac": 2}	7x24 小時	計時/每日/40 元每小時	計度/尖峰/09:00-23:59/10.00 元每度, 計度/尖峰/06:00-11:00/10.00 元每度, 計度/尖峰/14:00-23:59/10.00 元每度, 計度/離峰/23:59-09:00/8.00 元每度, 計度/離峰/23:59-06:00/8.00 元每度, 計度/離峰/11:00-14:00/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度, 計度/離峰/00:00-23:59/8.00 元每度			新北市蘆洲區光榮路99號	新北市蘆洲區光榮路99號	121.463262209674	25.0900162472095	2026-05-02 14:10:16+00	0101000020E610000071018A16A65D5E409BDF054E0B173940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	89132567-S0067	Acon-eco新北新店央北站	89132567	3	1	1	1	1	{"slow_ac": 1}	24小時	計時/每日/30元/每小時	計度/固定/8元每度	1	0800-868885			121.52584	24.98047	2026-05-02 14:10:16+00	0101000020E61000006FBBD05CA7615E4089B5F81400FB3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	89132567-S0069	Acon-eco新北新莊昌平站	89132567	3	2	2	2	2	{"slow_ac": 2}	24小時	計時/每日/20元/每小時	計度/固定/8元每度	1	0800-868885	新北市新莊區中央路276號	新北市新莊區中央路276號	121.45338	25.05921	2026-05-02 14:10:16+00	0101000020E6100000452A8C2D045D5E409E98F562280F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	蘆洲區	89132567-S0072	Acon-eco新北蘆洲仁愛街站	89132567	3	1	1	1	1	{"slow_ac": 1}	24小時	月租車位	計度/固定/8元每度	1	0800-868885	新北市蘆洲區仁愛街118巷\n          6號	新北市蘆洲區仁愛街118巷\n          6號	121.46958	25.09507	2026-05-02 14:10:16+00	0101000020E6100000C3B645990D5E5E40AAD4EC8156183940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	89132567-S0080	Acon-eco新北新店央北青年社宅站	89132567	1	7	8	8	8	{"slow_ac": 8}	24小時	計時/每日/30元/每小時	計度/固定/8元每度	B1	0800-868885	新北市新店區中山路135號	新北市新店區中山路135號	121.52598	24.98141	2026-05-02 14:10:16+00	0101000020E6100000689604A8A9615E40A5F78DAF3DFB3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	89132567-S0081	Acon-eco新北土城員和青年社宅站	89132567	1	5	5	5	5	{"slow_ac": 5}	24小時	計時/每日/30元/每小時	計度/固定/8元每度	B1	0800-868885	新北市土城區莊園街155-1號	新北市土城區莊園街155-1號	121.44782	24.98165	2026-05-02 14:10:16+00	0101000020E6100000A99F3715A95C5E404F1E166A4DFB3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	89132567-S0084	Acon-eco新北淡水國小站	89132567	1	1	1	1	1	{"slow_ac": 1}	國定例假日/07:00-22:00	計時/國定例假日/50元/每小時	計度/固定/8元每度	1	0800-868885	新北市淡水區大智街46巷\n          \n          	新北市淡水區大智街46巷\n          \n          	121.44089	25.17312	2026-05-02 14:10:16+00	0101000020E61000008AC8B08A375C5E409548A297512C3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新莊區	89132567-S0105	Acon-eco新北新莊副都84站	89132567	3	2	2	2	2	{"slow_ac": 2}	24小時	計時/每日/30元/每小時	計度/固定/8元每度	1	0800-868885	\n          \n          新莊副都心一小段85地號	\n          \n          新莊副都心一小段85地號	121.45893	25.0563	2026-05-02 14:10:16+00	0101000020E6100000CF49EF1B5F5D5E40CAC342AD690E3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	八里區	89132567-S0110	Acon-eco新北台北港站	89132567	3	1	1	1	1	{"slow_ac": 1}	24小時	計時/每日/20元/每小時	計度/固定/8元每度	1	0800-868885	新北市八里區商港路123號	新北市八里區商港路123號	121.39069	25.14989	2026-05-02 14:10:16+00	0101000020E6100000F437A11001595E4058FFE7305F263940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	89132567-S0113	Acon-eco新北林口忠孝站	89132567	3	1	1	1	1	{"slow_ac": 1}	24小時	計時/每日/20元/每小時	計度/固定/8元每度	1	0800-868885	新北市林口區忠孝路9號旁空地	新北市林口區忠孝路9號旁空地	121.37252	25.0698	2026-05-02 14:10:16+00	0101000020E6100000C746205ED7575E40C442AD69DE113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	89132567-S0114	Acon-eco新北碧潭東岸停車場站	89132567	3	2	2	2	2	{"slow_ac": 2}	24小時	計時/平日/30元/每小時, 計時/假日/40元/每小時	計度/固定/8元每度	1	0800-868885			121.53697	24.96116	2026-05-02 14:10:16+00	0101000020E6100000B83B6BB75D625E402E39EE940EF63840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	89132567-S0115	Acon-eco新北碧潭西岸停車場站	89132567	3	2	2	2	2	{"slow_ac": 2}	24小時	計時/每日/30元/每小時	計度/固定/8元每度	1	0800-868885			121.53438	24.95954	2026-05-02 14:10:16+00	0101000020E6100000BCE82B4833625E402F34D769A4F53840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	89132567-S0116	Acon-eco新北碧潭渡船頭停車場站	89132567	3	2	2	2	2	{"slow_ac": 2}	24小時	計時/平日/30元/每小時, 計時/假日/40元/每小時	計度/固定/8元每度	1	0800-868885			121.53787	24.95255	2026-05-02 14:10:16+00	0101000020E6100000F8DF4A766C625E4007CE1951DAF33840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	汐止區	89132567-S0121	Acon-eco新北汐止同興停車場站	89132567	3	1	1	1	1	{"slow_ac": 1}	24小時	計時/每日/50元/每小時	計度/固定/8元每度	1	0800-868885	新北市汐止區大同路一段339-2號	新北市汐止區大同路一段339-2號	121.63856	25.05978	2026-05-02 14:10:16+00	0101000020E61000002922C32ADE685E4073F4F8BD4D0F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	樹林區	89132567-S0122	Acon-eco新北樹林區公所站	89132567	3	1	1	1	1	{"slow_ac": 1}	24小時	計時/每日/30元/每小時	計度/固定/8元每度	1	0800-868885	新北市樹林區鎮前街93號(樹林區公所一樓	新北市樹林區鎮前街93號(樹林區公所一樓	121.42455	24.99012	2026-05-02 14:10:16+00	0101000020E61000001361C3D32B5B5E40931D1B8178FD3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	89132567-S0128	Acon-eco新北林口檔案館站	89132567	3	5	5	5	5	{"slow_ac": 5}	24小時	計時/每日/30元/每小時	計度/固定/8元每度	B1	0800-868885	新北市林口區檔案館路B1停車場	新北市林口區檔案館路B1停車場	121.37344	25.07373	2026-05-02 14:10:16+00	0101000020E61000002BC1E270E6575E40EDBB22F8DF123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三芝區	89132567-S0134	Acon-eco新北三芝淺水灣站	89132567	1	5	5	5	5	{"slow_ac": 5}	24小時	計次/每日/100元/每次	計度/固定/8元每度	1	0800-868885	新北市三芝區后厝里北勢子45-32號 淺水灣停車場(後厝派出所旁)	新北市三芝區后厝里北勢子45-32號 淺水灣停車場(後厝派出所旁)	121.47035	25.2515	2026-05-02 14:10:16+00	0101000020E61000001CEBE2361A5E5E40AAF1D24D62403940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	金山區	89132567-S0135	Acon-eco新北金山中角灣站	89132567	1	2	2	2	2	{"slow_ac": 2}	24小時	計次/平日/60元/每次, 計次/假日/120元/每次	計度/固定/8元每度	1	0800-868885	新北市金山區萬壽里海興路180 之3 號	新北市金山區萬壽里海興路180 之3 號	121.63303	25.2392	2026-05-02 14:10:16+00	0101000020E6100000C3D8429083685E40053411363C3D3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	新店區	89132567-S0148	Acon-eco新北新店民權中正站	89132567	3	1	1	1	1	{"slow_ac": 1}	24小時	計時/每日/70元/每小時	計度/固定/8元每度	1	0800-868885	新北市新店區民權路188號旁	新北市新店區民權路188號旁	121.5343	24.9831	2026-05-02 14:10:16+00	0101000020E61000002E90A0F831625E4096B20C71ACFB3840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	89132567-S0149	Acon-eco新北全聯林口文化北站	89132567	3	2	1	1	2	{"fast_dc": 2}	24小時	計時/平日/50元/每小時, 計時/假日/100元/每小時	計度/固定/10元每度	1	0800-868885	新北市林口區文化北路１段１段１段153號、155號	新北市林口區文化北路１段１段１段153號、155號	121.3569	25.07032	2026-05-02 14:10:16+00	0101000020E610000050FC1873D7565E403541D47D00123940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	83039115-S0003	全聯林口公園站	83039115	3	2	1	1	2	{"ultra_fast_dc": 2}	7x24小時	全聯購物金額不限，免費停車30分，滿300元免費一小時，最高折抵一小時	計度/尖峰/15:00-20:59（星期一到星期五）/ 13.9元每度,計度/離峰/其他時段/ 7.5元每度	B1	02-26069114	新北市林口區公園路59號	新北市林口區公園路59號	121.367495468942	25.0691899589144	2026-05-02 14:10:16+00	0101000020E61000002E22B70B85575E40BABFE26EB6113940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	三重區	83039115-S0002	全聯三重仁義站	83039115	3	2	1	1	2	{"ultra_fast_dc": 2}	7x24小時	全聯購物金額不限，免費停車30分，滿300元免費一小時，最高折抵一小時	計度/尖峰/15:00-20:59（星期一到星期五）/ 13.9元每度,計度/離峰/其他時段/ 7.5元每度	1F	02-26069114	新北市三重區仁義街95號	新北市三重區仁義街95號	121.498561452766	25.0799208930537	2026-05-02 14:10:16+00	0101000020E610000047AB4B6EE85F5E40C9EE15B275143940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	八里區	53703514-S2209	YES八里永續環境教育中心	53703514	2	2	2	2	2	{"slow_ac": 2}	7*24 小時	計時/每日/40元每小時	計分/1元每分	F1	02-55900599	新北市八里區觀海大道36號	新北市八里區觀海大道36號	121.429683	25.160655	2026-05-02 14:10:16+00	0101000020E61000006B2920ED7F5B5E405AF0A2AF20293940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	53703514-S2375	新北市淡水區公所	53703514	2	1	1	1	1	{"slow_ac": 1}	每日 /07:00~21:00	計時/每日/20元每小時	免費	F1	02-55900599	新北市淡水區中山北路二段375號	新北市淡水區中山北路二段375號	121.44393	25.18714	2026-05-02 14:10:16+00	0101000020E6100000A6ED5F59695C5E4000C63368E82F3940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	土城區	53703514-S1101	新北市土城區公所	53703514	2	1	1	1	1	{"slow_ac": 1}	7*24 小時	計時/每日/30元每小時	計度/固定/8元每度	F1		新北市土城區金城路一段101號	新北市土城區金城路一段101號	121.44294	24.97239	2026-05-02 14:10:16+00	0101000020E6100000C6850321595C5E401BF5108DEEF83840
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	林口區	42861108-S32202	新北－林口亞昕福朋喜來登酒店	42861108	3	4	4	4	4	{"ultra_fast_dc": 4}	7x24小時	計時/每日/40元每小時/每日最高/400元每日	計度/浮動/8元每度	B2	0809007518	新北市林口區文化三路一段1號	新北市林口區文化三路一段1號	121.36076	25.06623	2026-05-02 14:10:16+00	0101000020E61000001E6D1CB116575E409B030473F4103940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	板橋區	90505425-S58665	板橋遠百中山店	90505425	3	8	8	8	8	{"fast_dc": 6, "slow_ac": 2}	每日/11:00-22:00	計時/每日/60元每小時，停車折抵優惠訊息請依照現場說明\r\n	計度/固定/9.9元每度	B3	02-2531-0858	新北市板橋區中山路一段152號	新北市板橋區中山路一段152號	121.46436	25.01065	2026-05-02 14:10:16+00	0101000020E610000084640113B85D5E40D0B359F5B9023940
TDX CityEVCharging Station	https://tdx.transportdata.tw/api/basic/v1/EV/Station/City/新北市	新北市	淡水區	85017137-SNWT0001	雲樁科技鄧公國小站	85017137	2	2	2	2	2	{"slow_ac": 2}	假日/08:00-23:00	計時/假日/50元每小時	計分/1元每分	1	02-8751-1886	新北市淡水區學府路99號	新北市淡水區學府路99號	121.44903	25.1722	2026-05-02 14:10:16+00	0101000020E6100000103B53E8BC5C5E40075F984C152C3940
\.


--
-- Name: env_ev_charging_connector_power_district env_ev_charging_connector_power_district_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.env_ev_charging_connector_power_district
    ADD CONSTRAINT env_ev_charging_connector_power_district_pkey PRIMARY KEY (city_scope, city, district, power_bucket);


--
-- Name: env_ev_charging_connectors env_ev_charging_connectors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.env_ev_charging_connectors
    ADD CONSTRAINT env_ev_charging_connectors_pkey PRIMARY KEY (connector_id);


--
-- Name: env_ev_charging_district_summary env_ev_charging_district_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.env_ev_charging_district_summary
    ADD CONSTRAINT env_ev_charging_district_summary_pkey PRIMARY KEY (city_scope, city, district);


--
-- Name: env_ev_charging_points env_ev_charging_points_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.env_ev_charging_points
    ADD CONSTRAINT env_ev_charging_points_pkey PRIMARY KEY (charging_point_id);


--
-- Name: env_ev_charging_stations env_ev_charging_stations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.env_ev_charging_stations
    ADD CONSTRAINT env_ev_charging_stations_pkey PRIMARY KEY (station_id);


--
-- PostgreSQL database dump complete
--

