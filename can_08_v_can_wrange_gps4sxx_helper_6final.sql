DROP VIEW IF EXISTS v_can_wrange_gps_sx_helper_6final CASCADE;
CREATE OR REPLACE VIEW v_can_wrange_gps_sx_helper_6final AS


SELECT 
rownr,
v_can_wrange_gps_sx_helper_5correction.subid,
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
mstart,
v_condfinder.cond,
v_condfinder.runs50_first,
v_condfinder.runs70_first,
v_condfinder.runs50_t1_runid,
v_condfinder.runs50_t2_runid,
v_condfinder.runs70_t1_runid,
v_condfinder.runs70_t2_runid

FROM
v_can_wrange_gps_sx_helper_5correction
INNER JOIN "public".v_condfinder ON "public".v_can_wrange_gps_sx_helper_5correction.subid = "public".v_condfinder.subid

WHERE 
(gps_sx_reached_id_rev <= 30 OR
(v_can_wrange_gps_sx_helper_5correction.subid = 38))

ORDER BY
v_can_wrange_gps_sx_helper_5correction.subid,
time_s