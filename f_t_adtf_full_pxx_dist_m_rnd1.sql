-- Join distance-aggregated arrival measures with vehicle data and conditions
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION f_t_adtf_full_pxx_dist_m_rnd1 (pos_id INT DEFAULT NULL) 
RETURNS VOID
LANGUAGE plpgsql AS $$
--------------------------------------------------------------------------------
DECLARE pos_id_txt TEXT = LPAD(pos_id::text, 2, '0');
--------------------------------------------------------------------------------
BEGIN
RAISE INFO '==================================================';
RAISE INFO 'Processing f_t_adtf_full_dist_m_rnd1_pxx';
RAISE INFO 'GPS reference position %', pos_id;
RAISE INFO '==================================================';
--------------------------------------------------------------------------------
EXECUTE '
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS t_adtf_full_p' ||  pos_id_txt || '_dist_m_rnd1 CASCADE;
CREATE TABLE t_adtf_full_p' ||  pos_id_txt || '_dist_m_rnd1 AS
--------------------------------------------------------------------------------
SELECT
t_adtf_dist_p'|| pos_id_txt ||'_dist_m_rnd1.subject_id,
t_adtf_dist_p'|| pos_id_txt ||'_dist_m_rnd1.round_id,
t_adtf_rounds.round_txt,
t_adtf_rounds.condition_run,
t_adtf_rounds.condition_speed,

t_adtf_formatted.time_s,

t_adtf_dist_p'|| pos_id_txt ||'_dist_m_rnd1.p'|| pos_id_txt ||'_dist_s,
t_adtf_dist_p'|| pos_id_txt ||'_dist_m_rnd1.p'|| pos_id_txt ||'_dist_m_rnd1,

t_adtf_formatted.lat,
t_adtf_formatted.lon,

t_adtf_formatted.speed_kmh,
t_adtf_formatted.acclat_ms2,
t_adtf_formatted.acclon_ms2,
t_adtf_formatted.yawrate_degs,
t_adtf_formatted.brakepress_bar,
t_adtf_formatted.brakepress_status,
t_adtf_formatted.steerangle_deg,
t_adtf_formatted.steerangle_speed,
t_adtf_formatted.accpedalpos_perc,
t_adtf_formatted.ind

FROM
t_adtf_dist_p'|| pos_id_txt ||'_dist_m_rnd1
	LEFT JOIN t_adtf_formatted ON 
	t_adtf_dist_p'|| pos_id_txt ||'_dist_m_rnd1.row_nr 	= t_adtf_formatted.row_nr
	LEFT JOIN t_adtf_rounds ON 
	t_adtf_dist_p'|| pos_id_txt ||'_dist_m_rnd1.row_nr = t_adtf_rounds.row_nr

ORDER BY
t_adtf_dist_p' || pos_id_txt || '_dist_m_rnd1.row_nr
--------------------------------------------------------------------------------
';
--------------------------------------------------------------------------------
END $$;