DROP TABLE IF EXISTS t_adtf_driven_dist_cum CASCADE;
CREATE TABLE t_adtf_driven_dist_cum AS

SELECT
v_adtf_driven_dist_diff_by_row.row_nr,
v_adtf_driven_dist_diff_by_row.subject_id,
t_adtf_rounds_by_row.round_id,
v_adtf_driven_dist_diff_by_row.time_s,

-- Sum driven distance over all rows
SUM(v_adtf_driven_dist_diff_by_row.dist_m_diff) 
	OVER (PARTITION BY v_adtf_driven_dist_diff_by_row.subject_id 
				ORDER BY v_adtf_driven_dist_diff_by_row.row_nr) 
	AS dist_m

FROM
v_adtf_driven_dist_diff_by_row
	LEFT JOIN t_adtf_rounds_by_row ON
	v_adtf_driven_dist_diff_by_row.row_nr = t_adtf_rounds_by_row.row_nr

ORDER BY
v_adtf_driven_dist_diff_by_row.row_nr