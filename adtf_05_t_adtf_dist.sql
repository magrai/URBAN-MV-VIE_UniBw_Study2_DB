DROP TABLE IF EXISTS t_adtf_dist CASCADE;
CREATE TABLE t_adtf_dist AS

SELECT
v_adtf_dist_diff.row_nr,
v_adtf_dist_diff.subject_id,
v_adtf_dist_diff.round_id,
v_adtf_dist_diff.time_s,

-- Sum driven distance over all rows
SUM(v_adtf_dist_diff.dist_m_diff) 
	OVER (PARTITION BY v_adtf_dist_diff.subject_id 
				ORDER BY v_adtf_dist_diff.row_nr) 
	AS dist_m

FROM
v_adtf_dist_diff
	LEFT JOIN t_adtf_rounds ON
	v_adtf_dist_diff.row_nr = t_adtf_rounds.row_nr

ORDER BY
v_adtf_dist_diff.row_nr