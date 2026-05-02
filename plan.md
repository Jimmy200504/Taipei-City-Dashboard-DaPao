# Add Other-Agency River Water Quality Source

## Summary

- The two endpoint schemas are not the same.
  - Current `Get_point_WQStation_River` provides MOENV station metadata plus upstream `WQ_Index` / `WQ_Index_Dec`.
  - New `Get_point_WQStation_Ext_River` provides other-agency station metadata plus raw indicators: `Id_204` DO, `Id_206` BOD5, `Id_202` SS, `Id_209` NH3-N, `Id_107` conductivity.
- Add the new endpoint to the existing river-water-quality DAG and merge both sources into the same RPI station dataset.
- Existing official rows keep upstream-provided `WQ_Index`; new other-agency rows calculate RPI from indicator scores: `(DO_score + BOD_score + SS_score + NH3_score) / 4`.

## Key Changes

- Data-end:
  - Fetch both MOENV AJAX endpoints.
  - Normalize current endpoint rows with source label `moenv_river` and RPI method `source_wq_index`.
  - Normalize `Ext_River` rows with source label `moenv_ext_river` and RPI method `calculated_from_items`.
  - Prefix new-source station IDs, for example `ext:{SiteMgt_ID}:{SiteID}`, to avoid collisions with official `Station_ID`.
  - Parse `<...` values as `0` per user preference; parse `－`, empty, or null as missing.
  - Mark new-source RPI as incomplete if any of DO/BOD/SS/NH3-N is missing.
  - Keep `Id_107` conductivity for popup/data context but exclude it from RPI.

- RPI scoring:
  - DO: `>= 6.5 => 1`, `4.6.. <6.5 => 3`, `2.0..4.5 => 6`, `<2.0 => 10`.
  - BOD5: `<=3.0 => 1`, `>3.0..4.9 => 3`, `5.0..15.0 => 6`, `>15.0 => 10`.
  - SS: `<=20 => 1`, `>20..49.9 => 3`, `50..100 => 6`, `>100 => 10`.
  - NH3-N: `<=0.50 => 1`, `>0.50..0.99 => 3`, `1.00..3.00 => 6`, `>3.00 => 10`.
  - Risk level remains based on final RPI: `<=2` unpolluted, `>2..3` mild, `>3..6` moderate, `>6` severe.

- Schema/config:
  - Extend `env_river_monitoring_sites` and `env_river_site_rpi_latest` with source/method fields and optional raw indicator fields: DO, BOD5, SS, NH3-N, conductivity, plus item scores.
  - Keep `env_river_rpi_segments_latest` based on official endpoint ordering only, because `Ext_River` lacks `River_ID` and `Station_Order`.
  - Update backend sample SQL source links/descriptions and popup properties to show source, RPI method, and raw indicators.
  - Existing ranking and distribution charts include both official and calculated RPI rows.

## Frontend

- Existing map rendering stays mostly unchanged because it already colors by `risk_level` / `rpi_value`.
- Update popup formatting labels for:
  - `rpi_method`: upstream MOENV RPI vs dashboard-calculated RPI.
  - DO/BOD5/SS/NH3-N/conductivity values and scores.
- Segment gradient lines remain official-source-only; point layers include merged official and other-agency stations.

## Test Plan

- Data-end unit tests:
  - Verify both endpoint schemas normalize into common site/latest DataFrames.
  - Verify `<0.02` parses to `0`, `－` becomes missing, and incomplete rows do not calculate RPI.
  - Verify each RPI threshold boundary maps to the correct item score and risk level.
  - Verify ID prefixing prevents collisions.
- Integration checks:
  - Run `pytest Taipei-City-Dashboard-DE/dags/test/test_env_river_water_quality.py`.
  - Run frontend build: `cd Taipei-City-Dashboard-FE && npm run build`.
  - Run backend tests if backend Go files change: `cd Taipei-City-Dashboard-BE && go test ./...`.

## Assumptions

- `Id_209` means ammonia nitrogen `NH3-N`, not nitrogen gas.
- Conductivity `Id_107` is displayed only and does not affect RPI.
- Other-agency stations should be included in existing high-risk ranking and risk-distribution charts when RPI can be calculated.
- Other-agency stations without complete RPI inputs remain in site data/popup context but are excluded from RPI charts and segment generation.
