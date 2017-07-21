SELECT
"public".t_can_format.subid,
"public".t_can_format.time_s,
"public".t_can_format.speed_kmh,
"public".t_can_dist2gpsx.dist_m,
"public".t_can_dist2gpsx.s1_dist_m,
"public".t_can_dist2gpsx.s2_dist_m,
"public".v_can_dist2gpsx_xm_6final.dist_m
FROM
"public".t_can_format
INNER JOIN "public".t_can_dist2gpsx ON "public".t_can_format.subid = "public".t_can_dist2gpsx.subid AND "public".t_can_format.time_s = "public".t_can_dist2gpsx.time_s
INNER JOIN "public".v_can_dist2gpsx_xm_6final ON "public".t_can_format.subid = "public".v_can_dist2gpsx_xm_6final.subid AND "public".t_can_format.time_s = "public".v_can_dist2gpsx_xm_6final.time_s
INNER JOIN "public".v_condfinder ON "public".v_can_dist2gpsx_xm_6final.subid = "public".v_condfinder.subid
WHERE
"public".t_can_format.subid = 1 AND
"public".v_condfinder.runs50_first = 1 AND
"public".v_can_dist2gpsx_xm_6final.runid = "public".v_condfinder.runs50_t1_runid AND
"public".v_can_dist2gpsx_xm_6final.mdir = 'right' AND
"public".v_can_dist2gpsx_xm_6final.mstart = 1

