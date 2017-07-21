DROP VIEW IF EXISTS v_can_wrange_gps_sx_helper_3check4dupl2 CASCADE;
CREATE OR REPLACE VIEW v_can_wrange_gps_sx_helper_3check4dupl2 AS

SELECT *,
ROW_NUMBER() OVER (PARTITION BY subid ORDER BY subid ASC, time_s DESC) as gps_sx_reached_id_rev

FROM
v_can_wrange_gps_sx_helper_2check4dupl

WHERE
wrange_gps_s1_helper_v2 <> 2 AND
wrange_gps_s2_helper_v2 <> 2 AND
wrange_gps_s3_helper_v2 <> 2

ORDER BY
subid,
time_s