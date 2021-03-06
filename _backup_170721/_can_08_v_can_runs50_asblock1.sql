DROP VIEW IF EXISTS v_can_runs50_asblock1 CASCADE;
CREATE OR REPLACE VIEW v_can_runs50_asblock1 AS

SELECT
"public".v_can_dist2gpsx_xm_6final.rownr,
"public".v_can_dist2gpsx_xm_6final.subid,
"public".v_can_dist2gpsx_xm_6final.time_s,
"public".v_can_dist2gpsx_xm_6final.dist_m,
"public".v_can_dist2gpsx_xm_6final.gps_lat,
"public".v_can_dist2gpsx_xm_6final.gps_lon,
"public".v_can_dist2gpsx_xm_6final.gps1_dist_m,
"public".v_can_dist2gpsx_xm_6final.gps2_dist_m,
"public".v_can_dist2gpsx_xm_6final.gps3_dist_m,
"public".v_can_dist2gpsx_xm_6final.gps1_dist_xm_v2,
"public".v_can_dist2gpsx_xm_6final.gps2_dist_xm_v2,
"public".v_can_dist2gpsx_xm_6final.gps3_dist_xm_v2,
"public".v_can_dist2gpsx_xm_6final.gpsx_reached_id_rev,
"public".v_can_dist2gpsx_xm_6final.run,
"public".v_can_dist2gpsx_xm_6final.mdir,
"public".v_can_dist2gpsx_xm_6final.mid,
"public".v_can_dist2gpsx_xm_6final.mstart
FROM
"public".v_can_dist2gpsx_xm_6final
INNER JOIN "public".v_condfinder ON "public".v_can_dist2gpsx_xm_6final.subid = "public".v_condfinder.subid
WHERE
("public".v_can_dist2gpsx_xm_6final.run = "public".v_condfinder.runs50_t1 OR
"public".v_can_dist2gpsx_xm_6final.run = "public".v_condfinder.runs50_t2) AND
run <= 2 AND
"public".v_can_dist2gpsx_xm_6final.mstart = 1
