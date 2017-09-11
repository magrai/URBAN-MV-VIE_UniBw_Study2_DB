-- Join non-aggregated arrival measures with vehicle data and conditions
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION f_t_adtf_pxx_full (pos_id INT DEFAULT NULL) 
RETURNS VOID
LANGUAGE plpgsql AS $$
--------------------------------------------------------------------------------
DECLARE pos_id_txt TEXT = LPAD(pos_id::text, 2, '0');
--------------------------------------------------------------------------------
BEGIN
RAISE INFO '==================================================';
RAISE INFO 'Processing f_t_adtf_pxx_full';
RAISE INFO 'GPS reference position %', pos_id;
RAISE INFO '==================================================';
--------------------------------------------------------------------------------
EXECUTE '
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS t_adtf_full_p' || pos_id_txt || '_full CASCADE;
CREATE TABLE t_adtf_p' || pos_id_txt || '_full AS
--------------------------------------------------------------------------------
SELECT
t_adtf_p' || pos_id_txt || '_am.row_nr,
t_adtf_p' || pos_id_txt || '_am.subject_id,
t_adtf_p' || pos_id_txt || '_am.round_id,
t_adtf_rounds_by_row.round_txt,
t_adtf_rounds_by_row.condition_run,
t_adtf_rounds_by_row.condition_speed,

t_adtf_p' || pos_id_txt || '_am.time_s,
t_adtf_p' || pos_id_txt || '_am.dist_m,

t_adtf_p' || pos_id_txt || '_am.p' ||  pos_id_txt || '_tti_s,
t_adtf_p' || pos_id_txt || '_am.p' ||  pos_id_txt || '_dti_m,

t_adtf_formatted.gps_lat,
t_adtf_formatted.gps_lon,

t_adtf_formatted.speed_kmh,
t_adtf_formatted.speed_ms,
t_adtf_formatted.acc_lat_ms2,
t_adtf_formatted.acc_lon_ms2,
t_adtf_formatted.yaw_rate_degs,
t_adtf_formatted.brake_status,
t_adtf_formatted.brake_press_bar,
t_adtf_formatted.steer_angle_deg,
t_adtf_formatted.steer_angle_speed_degs,
t_adtf_formatted.acc_pedal_pos_perc,
t_adtf_formatted.ind

FROM
t_adtf_p' ||  pos_id_txt || '_am
	LEFT JOIN t_adtf_formatted ON 
	t_adtf_p'|| pos_id_txt ||'_am.row_nr 	= t_adtf_formatted.row_nr
	LEFT JOIN t_adtf_rounds_by_row ON 
	t_adtf_p' ||  pos_id_txt || '_am.row_nr = t_adtf_rounds_by_row.row_nr

WHERE
p' || pos_id_txt || '_dti_m >= -300 AND 
p' || pos_id_txt || '_dti_m <= 300

ORDER BY
t_adtf_p' || pos_id_txt || '_am.row_nr
--------------------------------------------------------------------------------
';
--------------------------------------------------------------------------------
END $$;



