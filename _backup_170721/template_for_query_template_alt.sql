SELECT
"public".v_can_wrange_gps_sx_helper_6final.subid,
"public".v_can_wrange_gps_sx_helper_6final.time_s,
"public".v_can_wrange_gps_sx_helper_6final.dist_m,
"public".v_can_wrange_gps_sx_helper_6final.dist2gps_s1_m,
"public".v_can_wrange_gps_sx_helper_6final.dist2gps_s2_m,
"public".v_can_wrange_gps_sx_helper_6final.dist2gps_s3_m
FROM
"public".v_can_wrange_gps_sx_helper_6final
INNER JOIN "public".v_condfinder ON "public".v_can_wrange_gps_sx_helper_6final.subid = "public".v_condfinder.subid
WHERE
"public".v_condfinder.subid = 1 AND
"public".v_condfinder.runs50_first = 1 AND
"public".v_can_wrange_gps_sx_helper_6final.runid = "public".v_condfinder.runs50_t1_runid AND
"public".v_can_wrange_gps_sx_helper_6final.mdir = 'right' AND
"public".v_can_wrange_gps_sx_helper_6final.mstart = 1



