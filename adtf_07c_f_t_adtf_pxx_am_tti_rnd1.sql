-- Round values of time-based arrival measures
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION f_t_adtf_pxx_am_tti_rnd1 (pos_id INT DEFAULT NULL) 
RETURNS VOID
LANGUAGE plpgsql AS $$
--------------------------------------------------------------------------------
DECLARE pos_id_txt TEXT = LPAD(pos_id::text, 2, '0');
--------------------------------------------------------------------------------
BEGIN
RAISE INFO '==================================================';
RAISE INFO 'Processing f_t_adtf_pxx_tti_rnd1';
RAISE INFO 'GPS reference position %', pos_id;
RAISE INFO '==================================================';
--------------------------------------------------------------------------------
EXECUTE '
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS t_adtf_p' ||  pos_id_txt || '_am_tti_rnd1 CASCADE;
CREATE TABLE t_adtf_p' ||  pos_id_txt || '_am_tti_rnd1 AS
--------------------------------------------------------------------------------
SELECT 
MIN(row_nr) as row_nr,
subject_id,
round_id,
ROUND(p' || pos_id_txt || '_tti_s, 1) AS p' || pos_id_txt || '_tti_s_rnd1,
MIN(p' || pos_id_txt || '_dti_m) AS p' || pos_id_txt || '_dti_m

FROM
t_adtf_p' || pos_id_txt || '_am

WHERE 
p' || pos_id_txt || '_tti_s >= -15 AND 
p' || pos_id_txt || '_tti_s <= 15

GROUP BY
subject_id,
round_id,
round(p' || pos_id_txt || '_tti_s, 1)

ORDER BY
MIN(row_nr)
--------------------------------------------------------------------------------
';
--------------------------------------------------------------------------------
END $$;