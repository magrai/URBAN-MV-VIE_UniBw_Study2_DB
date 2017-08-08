DROP VIEW IF EXISTS v_adtf_dist_diff CASCADE;
CREATE VIEW v_adtf_dist_diff AS

SELECT 
t_adtf_formatted.row_nr,
t_adtf_formatted.subject_id,
t_adtf_formatted.time_s,
CASE
	WHEN (t_adtf_formatted.speed_kmh / 3.6) * 
			 (t_adtf_formatted.time_s - lag(t_adtf_formatted.time_s) OVER (PARTITION BY t_adtf_formatted.subject_id ORDER BY t_adtf_formatted.row_nr)) IS NULL 
	THEN (t_adtf_formatted.speed_kmh / 3.6) * 
        t_adtf_formatted.time_s
  ELSE (t_adtf_formatted.speed_kmh / 3.6) * 
       (t_adtf_formatted.time_s - lag(t_adtf_formatted.time_s) OVER (PARTITION BY t_adtf_formatted.subject_id ORDER BY t_adtf_formatted.row_nr))
END AS dist_m_diff

FROM
t_adtf_formatted

