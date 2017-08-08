SELECT
	part1.subid,
	part1.runid,
	part1.mid,
	part1.time_s AS time_s_start,
	part2.time_s AS time_s_end,
	round(part1.dist_m, 5) AS dist_m_start,
	round(part2.dist_m, 5) AS dist_m_end,
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
	dist_m,
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
	LEFT JOIN ( SELECT subid, time_s, dist_m, mstart, mid FROM v_can_wrange_gps_sx_helper_6final WHERE mstart = 0 ) part2 ON part1.subid = part2.subid 
	AND part1.mid = part2.mid