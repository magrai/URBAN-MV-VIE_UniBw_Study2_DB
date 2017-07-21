DROP VIEW IF EXISTS v_can_wrange_gps_sx_helper_6final CASCADE;
CREATE OR REPLACE VIEW v_can_wrange_gps_sx_helper_6final AS


SELECT 
rownr,
subid,
time_s,
dist_m,
gps_lat,
gps_lon,
dist2gps_s1_m,
dist2gps_s2_m,
dist2gps_s3_m,
dist2gps_s1_helper_m,
dist2gps_s2_helper_m,
dist2gps_s3_helper_m,
wrange_gps_s1_helper_v2,
wrange_gps_s2_helper_v2,
wrange_gps_s3_helper_v2,
gps_sx_reached_id_rev,
runid,
mdir,
mid,
mstart

FROM
v_can_wrange_gps_sx_helper_5correction

WHERE 
gps_sx_reached_id_rev <= 30 OR
(subid = 38)

ORDER BY
subid,
time_s