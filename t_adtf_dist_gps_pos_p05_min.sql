-- DROP TABLE IF EXISTS t_adtf_dist_gps_pos_p05_min CASCADE;
-- CREATE TABLE t_adtf_dist_gps_pos_p05_min AS

-- In case of rows with same minimimal distance to gps reference point:
-- Take timely minimum
SELECT 
MIN(t_adtf_dist_gps_pos_p05_min_temp.row_nr) AS row_nr,
t_adtf_dist_gps_pos_p05_min_temp.subject_id,
t_adtf_dist_gps_pos_p05_min_temp.round_id,
MIN(t_adtf_dist_gps_pos_p05_min_temp.time_s) AS time_s,
MIN(t_adtf_dist_gps_pos_p05_min_temp.p05_gps_dist_m) AS p05_gps_dist_m

FROM 
-- Table with minimum distances within range of 5 m
-- ... in round_id >= 0 and round_id <= 4
t_adtf_dist_gps_pos_p05_min_temp,

(
	SELECT 
	subject_id, 
	round_id, 
	MIN(p05_gps_dist_m) AS p05_gps_dist_m_min 
	FROM 
	t_adtf_dist_gps_pos_p05_min_temp 
	GROUP BY 
	subject_id, 
	round_id
) temp_min

WHERE 
t_adtf_dist_gps_pos_p05_min_temp.subject_id     = temp_min.subject_id AND
t_adtf_dist_gps_pos_p05_min_temp.round_id       = temp_min.round_id AND
t_adtf_dist_gps_pos_p05_min_temp.p05_gps_dist_m = temp_min.p05_gps_dist_m_min

GROUP BY
t_adtf_dist_gps_pos_p05_min_temp.subject_id,
t_adtf_dist_gps_pos_p05_min_temp.round_id

ORDER BY
MIN(t_adtf_dist_gps_pos_p05_min_temp.row_nr)
