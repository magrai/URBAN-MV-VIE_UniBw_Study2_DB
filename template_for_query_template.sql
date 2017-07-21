--DROP VIEW IF EXISTS test CASCADE;
--CREATE OR REPLACE VIEW test AS

SELECT
"public".t_can_format.rownr,
"public".t_can_format.subid,
"public".t_can_format.time_s,
"public".t_can_format.speed_kmh,
"public".t_can_format.gps_lat,
"public".t_can_format.gps_lon,
"public".t_can_dist2gps.dist_m,
"public".t_can_dist2gps.dist2gps_s1_m,
"public".t_can_dist2gps.dist2gps_s2_m,
"public".t_can_dist2gps.dist2gps_s3_m,
--distance 
"public".v_can_wrange_gps_sx_helper_6final.dist_m as dist_m_4gps_sx,
"public".v_can_wrange_gps_sx_helper_6final.runid,
"public".v_can_wrange_gps_sx_helper_6final.mdir

FROM
"public".t_can_format
INNER JOIN "public".t_can_dist2gps ON "public".t_can_format.subid = "public".t_can_dist2gps.subid AND "public".t_can_format.time_s = "public".t_can_dist2gps.time_s
INNER JOIN "public".v_can_wrange_gps_sx_helper_6final ON "public".t_can_dist2gps.subid = "public".v_can_wrange_gps_sx_helper_6final.subid
INNER JOIN "public".v_condfinder ON "public".v_can_wrange_gps_sx_helper_6final.subid = "public".v_condfinder.subid

WHERE
"public".t_can_format.subid = 3 AND 
-- "public".v_condfinder.runs50_first = 0 AND
"public".v_can_wrange_gps_sx_helper_6final.runid = "public".v_condfinder.runs70_t1_runid AND
"public".v_can_wrange_gps_sx_helper_6final.mdir = 'right' AND
"public".v_can_wrange_gps_sx_helper_6final.mstart = 1 AND
"public".t_can_dist2gps.dist_m >= "public".v_can_wrange_gps_sx_helper_6final.dist_m - 200 AND
"public".t_can_dist2gps.dist_m <= "public".v_can_wrange_gps_sx_helper_6final.dist_m + 200

--GROUP BY
--"public".t_can_format.subid
--"public".v_can_wrange_gps_sx_helper_6final.runid,
--"public".v_can_wrange_gps_sx_helper_6final.mdir

ORDER BY
"public".t_can_format.subid