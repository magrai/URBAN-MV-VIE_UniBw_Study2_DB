DROP VIEW IF EXISTS v_can_dist_diff CASCADE;
CREATE VIEW v_can_dist_diff AS

SELECT 
t_can_format.rownr,
t_can_format.subid,
t_can_format.time_s,
CASE
	WHEN (t_can_format.speed_kmh / 3.6) * 
			 (t_can_format.time_s - lag(t_can_format.time_s) OVER (PARTITION BY t_can_format.subid ORDER BY t_can_format.rownr)) IS NULL 
	THEN (t_can_format.speed_kmh / 3.6) * 
        t_can_format.time_s
  ELSE (t_can_format.speed_kmh / 3.6) * 
       (t_can_format.time_s - lag(t_can_format.time_s) OVER (PARTITION BY t_can_format.subid ORDER BY t_can_format.rownr))
END AS dist_m_diff

FROM
t_can_format