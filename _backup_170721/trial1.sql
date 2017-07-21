SELECT
"public".t_can_format.rownr,
"public".t_can_format.subid,
"public".t_can_format.time_s,
"public".v_can_dist.dist_m,
"public".t_can_format.speed_kmh,
"public".v_can_runs50_asblock1_t1.dist_m AS dist_m_asgps1,
"public".v_can_dist2gpsx.s1_dist_m,
"public".v_can_dist2gpsx.s2_dist_m,
"public".t_can_format.gps_lat,
"public".t_can_format.gps_lon
FROM
"public".t_can_format
INNER JOIN "public".v_can_dist ON "public".t_can_format.rownr = "public".v_can_dist.rownr AND "public".t_can_format.subid = "public".v_can_dist.subid
INNER JOIN "public".v_can_dist2gpsx ON "public".t_can_format.rownr = "public".v_can_dist2gpsx.rownr AND "public".t_can_format.subid = "public".v_can_dist2gpsx.subid,
"public".v_can_runs50_asblock1_t1
WHERE
"public".t_can_format.subid <= 2 AND
"public".t_can_format.subid = "public".v_can_runs50_asblock1_t1.subid AND
"public".v_can_runs50_asblock1_t1.mdir = 'right' AND
"public".v_can_dist.dist_m >= "public".v_can_runs50_asblock1_t1.dist_m - 100 AND
"public".v_can_dist.dist_m <= "public".v_can_runs50_asblock1_t1.dist_m + 100 AND
"public".v_can_dist2gpsx.s1_dist_m 

ORDER BY
"public".v_can_runs50_asblock1_t1.subid ASC,
"public".v_can_runs50_asblock1_t1.time_s ASC
