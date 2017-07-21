DROP VIEW IF EXISTS v_can_wrange_gps_sx_helper CASCADE;
CREATE OR REPLACE VIEW v_can_wrange_gps_sx_helper AS

SELECT *,
-- Compute if driver is within range of 10 m to GPS-helper points
CASE WHEN t_can_dist2gps.dist2gps_s1_helper_m <= 10 THEN 1 ELSE 0 END AS wrange_gps_s1_helper,
CASE WHEN t_can_dist2gps.dist2gps_s2_helper_m <= 10 THEN 1 ELSE 0 END AS wrange_gps_s2_helper,
CASE WHEN t_can_dist2gps.dist2gps_s3_helper_m <= 10 THEN 1 ELSE 0 END AS wrange_gps_s3_helper

FROM
t_can_dist2gps

ORDER BY
subid,
time_s
