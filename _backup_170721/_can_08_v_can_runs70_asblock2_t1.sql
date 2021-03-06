DROP VIEW IF EXISTS v_can_runs70_asblock2_t1 CASCADE;
CREATE OR REPLACE VIEW v_can_runs70_asblock2_t1 AS

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
("public".v_can_dist2gpsx_xm_6final.run = "public".v_condfinder.run1_70 OR
"public".v_can_dist2gpsx_xm_6final.run = "public".v_condfinder.run2_70) AND
run = 3 AND
"public".v_can_dist2gpsx_xm_6final.mstart = 1
