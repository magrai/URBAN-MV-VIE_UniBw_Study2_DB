DROP TABLE IF EXISTS t_can_dist2gps_sx_helper_summary CASCADE;
CREATE TABLE t_can_dist2gps_sx_helper_summary AS

SELECT
subid,

-- Compute distance to helper GPS-points
min(dist2gps_s1_helper_m) as dist2gps_s1_helper_m_min,
min(dist2gps_s2_helper_m) as dist2gps_s2_helper_m_min,
min(dist2gps_s3_helper_m) as dist2gps_s3_helper_m_min

--
FROM
t_can_dist2gps

GROUP BY
subid

ORDER BY
subid