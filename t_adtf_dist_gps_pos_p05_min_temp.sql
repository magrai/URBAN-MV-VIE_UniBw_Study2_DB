DROP TABLE IF EXISTS t_adtf_dist_gps_pos_p05_min_temp CASCADE;
CREATE TABLE t_adtf_dist_gps_pos_p05_min_temp AS

SELECT
row_nr,
subject_id,
round_id,
time_s,
-- Sum vlaues in temp_id to fill column
-- ... rowwise for each subject and round 
SUM( 
	CASE WHEN time_s - time_s_lag > 15 THEN 1 ELSE 0 END
) OVER (PARTITION BY subject_id, round_id ORDER BY row_nr) AS temp_id,
p05_gps_dist_m

FROM
-- Compute lag time
(
	SELECT
	t_adtf_dist_gps_pos_p05.row_nr,
	t_adtf_dist_gps_pos_p05.subject_id,
	t_adtf_rounds.round_id,
	t_adtf_dist_gps_pos_p05.time_s,
	LAG(time_s, 1, time_s) 
		OVER (
			PARTITION BY 
			t_adtf_dist_gps_pos_p05.subject_id, 
			t_adtf_rounds.round_id 
		ORDER BY t_adtf_dist_gps_pos_p05.row_nr) 
		AS time_s_lag,
	t_adtf_dist_gps_pos_p05.p05_gps_dist_m

	FROM
	t_adtf_dist_gps_pos_p05
		LEFT JOIN t_adtf_rounds 
		ON t_adtf_dist_gps_pos_p05.row_nr = t_adtf_rounds.row_nr

	WHERE
	-- t_adtf_dist_gps_pos_p05.subject_id = 1 AND
	t_adtf_dist_gps_pos_p05.p05_gps_dist_m <= 5 AND
	t_adtf_rounds.round_id >= 0 AND 
	t_adtf_rounds.round_id <= 4
) gps_dist_window