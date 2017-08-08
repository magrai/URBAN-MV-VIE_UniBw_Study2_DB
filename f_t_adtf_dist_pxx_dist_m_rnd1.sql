-- Round values of distance-based arrival measures
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION f_t_adtf_dist_pxx_dist_m_rnd1 (pos_id INT DEFAULT NULL) 
RETURNS VOID
LANGUAGE plpgsql AS $$
--------------------------------------------------------------------------------
DECLARE pos_id_txt TEXT = LPAD(pos_id::text, 2, '0');
--------------------------------------------------------------------------------
BEGIN
RAISE INFO '==================================================';
RAISE INFO 'Processing f_t_adtf_dist_pxx_dist_m_rnd1';
RAISE INFO 'GPS reference position %', pos_id;
RAISE INFO '==================================================';
--------------------------------------------------------------------------------
EXECUTE '
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS t_adtf_dist_p' ||  pos_id_txt || '_dist_m_rnd1 CASCADE;
CREATE TABLE t_adtf_dist_p' ||  pos_id_txt || '_dist_m_rnd1 AS
--------------------------------------------------------------------------------
SELECT 
MIN(row_nr) as row_nr,
subject_id,
round_id,
MIN(p' || pos_id_txt || '_dist_s) AS p' || pos_id_txt || '_dist_s,
ROUND(p' || pos_id_txt || '_dist_m, 1) AS p' || pos_id_txt || '_dist_m_rnd1

FROM
t_adtf_dist_p' || pos_id_txt || '

WHERE 
p' || pos_id_txt || '_dist_m >= -300 AND 
p' || pos_id_txt || '_dist_m <= 300

GROUP BY
subject_id,
round_id,
round(p' || pos_id_txt || '_dist_m, 1)

ORDER BY
MIN(row_nr)
--------------------------------------------------------------------------------
';
--------------------------------------------------------------------------------
END $$;