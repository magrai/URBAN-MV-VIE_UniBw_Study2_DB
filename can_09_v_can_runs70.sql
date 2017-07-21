DROP VIEW IF EXISTS v_can_runs70 CASCADE;
CREATE OR REPLACE VIEW v_can_runs70 AS

SELECT
"public".v_can_wrange_gps_sx_helper_6final.rownr,
"public".v_can_wrange_gps_sx_helper_6final.subid,
"public".v_can_wrange_gps_sx_helper_6final.time_s,
"public".v_can_wrange_gps_sx_helper_6final.dist_m,
"public".v_can_wrange_gps_sx_helper_6final.gps_lat,
"public".v_can_wrange_gps_sx_helper_6final.gps_lon,
"public".v_can_wrange_gps_sx_helper_6final.dist2gps_s1_m,
"public".v_can_wrange_gps_sx_helper_6final.dist2gps_s2_m,
"public".v_can_wrange_gps_sx_helper_6final.dist2gps_s3_m,
"public".v_can_wrange_gps_sx_helper_6final.dist2gps_s1_helper_m,
"public".v_can_wrange_gps_sx_helper_6final.dist2gps_s2_helper_m,
"public".v_can_wrange_gps_sx_helper_6final.dist2gps_s3_helper_m,
"public".v_can_wrange_gps_sx_helper_6final.wrange_gps_s1_helper_v2,
"public".v_can_wrange_gps_sx_helper_6final.wrange_gps_s2_helper_v2,
"public".v_can_wrange_gps_sx_helper_6final.wrange_gps_s3_helper_v2,
"public".v_can_wrange_gps_sx_helper_6final.gps_sx_reached_id_rev,
"public".v_can_wrange_gps_sx_helper_6final.runid,
"public".v_can_wrange_gps_sx_helper_6final.mdir,
"public".v_can_wrange_gps_sx_helper_6final.mid,
"public".v_can_wrange_gps_sx_helper_6final.mstart

FROM
"public".v_can_wrange_gps_sx_helper_6final
INNER JOIN "public".v_condfinder ON "public".v_can_wrange_gps_sx_helper_6final.subid = "public".v_condfinder.subid

WHERE
("public".v_can_wrange_gps_sx_helper_6final.runid = "public".v_condfinder.runs70_t1_runid OR
"public".v_can_wrange_gps_sx_helper_6final.runid = "public".v_condfinder.runs70_t2_runid) AND
"public".v_can_wrange_gps_sx_helper_6final.mstart = 1
