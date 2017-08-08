SELECT 
*,
MAX(rownr_diff) OVER (PARTITION BY subid ORDER BY rownr) as rownr_diff_max,
SUM(round) OVER (PARTITION BY subid ORDER BY rownr) as round_sum
FROM (

SELECT
	rownr,
	subid,
	rnr_subid,
	time_s,
	speed_kmh,
	rownr - lag(rownr) OVER (PARTITION BY subid ORDER BY rownr) as rownr_diff,
	CASE WHEN rownr - lag(rownr) OVER (PARTITION BY subid ORDER BY rownr) > 1
	THEN 1
	ELSE 0
	END AS round
FROM
	t_can_format 
WHERE
	subid = 3 AND
	speed_kmh = 0
ORDER BY
	rownr
	
) temp