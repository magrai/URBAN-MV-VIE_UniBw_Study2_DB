DROP TABLE IF EXISTS t_adtf_dist_m_full CASCADE;
CREATE TABLE t_adtf_dist_m_full AS

SELECT
"public".t_can_format.subid,
"public".t_can_format.time_s,
"public".t_can_format.speed_kmh,
"public".t_can_format.acclat_ms2,
"public".t_can_format.acclon_ms2,
"public".t_can_format.yawrate_degs,
"public".t_can_format.brakepress_bar,
"public".t_can_format.brakepress_status,
"public".t_can_format.steerangle_deg,
"public".t_can_format.accpedalpos_perc,
"public".t_can_format.gps_lat,
"public".t_can_format.gps_lon,
"public".t_can_dist2gps.dist_m,
"public".t_can_dist2gps.dist2gps_s1_m,
"public".t_can_dist2gps.dist2gps_s2_m,
"public".t_can_dist2gps.dist2gps_s3_m,
"public".v_can_wrange_gps_sx_helper_6final.dist_m as dist_m_4gps_sx,
"public".v_can_wrange_gps_sx_helper_6final.runid,
"public".v_can_wrange_gps_sx_helper_6final.mdir,
"public".v_can_wrange_gps_sx_helper_6final.mstart,
"public".v_can_wrange_gps_sx_helper_6final.cond,
"public".v_can_wrange_gps_sx_helper_6final.runs50_first,
"public".v_can_wrange_gps_sx_helper_6final.runs70_first,
"public".v_can_wrange_gps_sx_helper_6final.runs50_t1_runid,
"public".v_can_wrange_gps_sx_helper_6final.runs50_t2_runid,
"public".v_can_wrange_gps_sx_helper_6final.runs70_t1_runid,
"public".v_can_wrange_gps_sx_helper_6final.runs70_t2_runid

FROM
"public".t_can_format
INNER JOIN "public".t_can_dist2gps ON "public".t_can_format.subid = "public".t_can_dist2gps.subid AND "public".t_can_format.time_s = "public".t_can_dist2gps.time_s
INNER JOIN "public".v_can_wrange_gps_sx_helper_6final ON "public".t_can_dist2gps.subid = "public".v_can_wrange_gps_sx_helper_6final.subid
INNER JOIN "public".v_condfinder ON "public".v_can_wrange_gps_sx_helper_6final.subid = "public".v_condfinder.subid

ORDER BY
"public".t_can_format.subid,
"public".t_can_format.rownr