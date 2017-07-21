DROP VIEW IF EXISTS v_can_wrange_gps_sx_helper_2check4dupl CASCADE;
CREATE OR REPLACE VIEW v_can_wrange_gps_sx_helper_2check4dupl AS

SELECT *,

-- 25 is any plausible value, to avoid confusion with rounds
CASE 
	WHEN 
		wrange_gps_s1_helper = 1 AND
		lag(wrange_gps_s1_helper) OVER (PARTITION BY subid ORDER BY time_s) = 1 AND
		dist_m - (lag(dist_m) OVER (PARTITION BY subid ORDER BY time_s)) <= 25
	THEN 2
	ELSE wrange_gps_s1_helper
END AS wrange_gps_s1_helper_v2,

CASE 
	WHEN 
		wrange_gps_s2_helper = 1 AND
		lag(wrange_gps_s2_helper) OVER (PARTITION BY subid ORDER BY time_s) = 1 AND
		dist_m - (lag(dist_m) OVER (PARTITION BY subid ORDER BY time_s)) <= 25
	THEN 2
	ELSE wrange_gps_s2_helper
END AS wrange_gps_s2_helper_v2,

CASE 
	WHEN 
		wrange_gps_s3_helper = 1 AND
		lag(wrange_gps_s3_helper) OVER (PARTITION BY subid ORDER BY time_s) = 1 AND
		dist_m - (lag(dist_m) OVER (PARTITION BY subid ORDER BY time_s)) <= 25
	THEN 2
	ELSE wrange_gps_s3_helper
END AS wrange_gps_s3_helper_v2


FROM 
(
	SELECT *
	FROM v_can_wrange_gps_sx_helper
	WHERE (wrange_gps_s1_helper = 1 OR wrange_gps_s2_helper = 1 OR wrange_gps_s3_helper = 1)
	ORDER BY time_s
) check4count

ORDER BY
subid, time_s
