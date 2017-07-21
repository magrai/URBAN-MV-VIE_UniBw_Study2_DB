DROP VIEW IF EXISTS v_can_wrange_gps_sx_helper_1check4count CASCADE;
CREATE OR REPLACE VIEW v_can_wrange_gps_sx_helper_1check4count AS

SELECT 
check4count.subid, 
COUNT(*)

FROM 
(SELECT *
FROM v_can_wrange_gps_sx_helper
WHERE (wrange_gps_s1_helper = 1 OR wrange_gps_s2_helper = 1 OR wrange_gps_s3_helper = 1)
ORDER BY time_s) check4count

GROUP BY
subid

ORDER BY
subid