-- Compute arrival measures using driven distance and time
-- ... until reaching the minimum GPS distance
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION f_t_adtf_pxx_am (pos_id INT DEFAULT NULL) 
RETURNS VOID
LANGUAGE plpgsql AS $$
--------------------------------------------------------------------------------
DECLARE pos_id INT := pos_id;
DECLARE pos_id_txt TEXT := LPAD(pos_id::text, 2, '0');
--------------------------------------------------------------------------------
BEGIN
RAISE INFO '==================================================';
RAISE INFO 'Processing f_t_adtf_pxx_am';
RAISE INFO 'GPS reference position %', pos_id;
RAISE INFO '==================================================';
--------------------------------------------------------------------------------
EXECUTE '
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS t_adtf_p' || pos_id_txt || '_am CASCADE;
CREATE TABLE t_adtf_p' || pos_id_txt || '_am AS
--------------------------------------------------------------------------------
SELECT
t_adtf_dist.row_nr,
t_adtf_dist.subject_id,
t_adtf_dist.round_id,
t_adtf_dist.time_s,
t_adtf_dist.dist_m,
t_adtf_dist.time_s - temp_pxx.time_s AS p' || pos_id_txt || '_tti_s,
t_adtf_dist.dist_m - temp_pxx.dist_m AS p' || pos_id_txt || '_dti_m

FROM 
t_adtf_dist
	LEFT JOIN
	(
		SELECT
		t_adtf_dist.row_nr,
		t_adtf_dist.subject_id,
		t_adtf_dist.round_id,
		t_adtf_dist.time_s,
		t_adtf_dist.dist_m,
		t_adtf_p' || pos_id_txt || '_gps_dist_min.p' || pos_id_txt || '_gps_dist_m
		FROM
		t_adtf_p' || pos_id_txt || '_gps_dist_min
			LEFT JOIN t_adtf_dist ON 
			t_adtf_p' || pos_id_txt || '_gps_dist_min.row_nr = t_adtf_dist.row_nr
	) temp_pxx ON
	t_adtf_dist.subject_id = temp_pxx.subject_id AND 
	t_adtf_dist.round_id   = temp_pxx.round_id 
--------------------------------------------------------------------------------
';
--------------------------------------------------------------------------------
END $$;



