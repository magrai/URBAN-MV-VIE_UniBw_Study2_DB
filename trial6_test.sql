SELECT
min("public".t_can_format.rownr) as rownr_min,
"public".t_can_format.subid,
min("public".t_can_format.time_s) as time_s_min,
min("public".t_can_format.speed_kmh) as speed_kmh_min,
min("public".t_can_dist2gpsx.dist_m) as dist_m,
min("public".t_can_dist2gpsx.gps_s1_dist_m) as gps_s1_dist_m_min,
min("public".t_can_dist2gpsx.gps_s2_dist_m) as gps_s2_dist_m_min,
min("public".v_can_dist2gpsx_xm_6final.dist_m) as dist_m_4gpsx,
min("public".v_can_dist2gpsx_xm_6final.runid) as runid,
min("public".v_can_dist2gpsx_xm_6final.mdir) as mdir

FROM
"public".t_can_format
INNER JOIN "public".t_can_dist2gpsx ON "public".t_can_format.subid = "public".t_can_dist2gpsx.subid AND "public".t_can_format.time_s = "public".t_can_dist2gpsx.time_s
INNER JOIN "public".v_can_dist2gpsx_xm_6final ON "public".t_can_dist2gpsx.subid = "public".v_can_dist2gpsx_xm_6final.subid
INNER JOIN "public".v_condfinder ON "public".v_can_dist2gpsx_xm_6final.subid = "public".v_condfinder.subid

WHERE
--"public".t_can_format.subid = 3 OR
"public".t_can_format.subid = 4 AND 
-- "public".v_condfinder.runs50_first = 0 AND
"public".v_can_dist2gpsx_xm_6final.runid = "public".v_condfinder.runs50_t1_runid AND
"public".v_can_dist2gpsx_xm_6final.mdir = 'right' AND
"public".v_can_dist2gpsx_xm_6final.mstart = 1

GROUP BY
"public".t_can_format.subid
--"public".v_can_dist2gpsx_xm_6final.runid,
--"public".v_can_dist2gpsx_xm_6final.mdir

ORDER BY
"public".t_can_format.subid