SELECT
t_can_format.subid,
t_can_format.time_s,
t_can_format.speed_kmh,
t_can_format.acclat_ms2,
t_can_format.acclon_ms2,
t_can_format.yawrate_degs,
t_can_format.brakepress_bar,
t_can_format.brakepress_status,
t_can_format.steerangle_deg,
t_can_format.accpedalpos_perc,
t_can_format.gps_lat,
t_can_format.gps_lon,
t_can_dist2gps.dist_m,
t_can_dist2gps.dist2gps_s1_m,
t_can_dist2gps.dist2gps_s2_m,
t_can_dist2gps.dist2gps_s3_m,
-- time_start_end.dist_m as dist_m_4gps_sx,
time_start_end.runid,
time_start_end.mdir,
time_start_end.cond,
time_start_end.runs50_first,
time_start_end.runs70_first,
time_start_end.runs50_t1_runid,
time_start_end.runs50_t2_runid,
time_start_end.runs70_t1_runid,
time_start_end.runs70_t2_runid

FROM
t_can_format
LEFT JOIN t_can_dist2gps ON t_can_format.subid = t_can_dist2gps.subid AND t_can_format.time_s = t_can_dist2gps.time_s
LEFT JOIN 
(
SELECT
	part1.subid,
	part1.runid,
	part1.mid,
	part1.time_s AS time_s_start,
	part2.time_s AS time_s_end,
	part1.mdir,
	part1.cond,
	part1.runs50_first,
	part1.runs70_first,
	part1.runs50_t1_runid,
	part1.runs50_t2_runid,
	part1.runs70_t1_runid,
	part1.runs70_t2_runid 
FROM
	(
SELECT
	subid,
	runid,
	mid,
	time_s,
	mdir,
	cond,
	runs50_first,
	runs70_first,
	runs50_t1_runid,
	runs50_t2_runid,
	runs70_t1_runid,
	runs70_t2_runid 
FROM
	v_can_wrange_gps_sx_helper_6final 
WHERE
	mstart = 1 
	) part1
	LEFT JOIN ( SELECT subid, time_s, mstart, mid FROM v_can_wrange_gps_sx_helper_6final WHERE mstart = 0 ) part2 ON part1.subid = part2.subid 
	AND part1.mid = part2.mid
) time_start_end ON t_can_format.subid = time_start_end.subid AND t_can_format.time_s >= time_start_end.time_s_start AND t_can_format.time_s <= time_start_end.time_s_end

WHERE
t_can_format.subid = 1
ORDER BY
t_can_format.subid,
t_can_format.rownr