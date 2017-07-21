DROP VIEW IF EXISTS v_can_dist2gps CASCADE;
CREATE OR REPLACE VIEW v_can_dist2gps AS

SELECT
"public".t_can_format.rownr,
"public".t_can_format.subid,
"public".t_can_format.time_s,
"public".v_can_dist.dist_m,

"public".t_can_format.gps_lat,
"public".t_can_format.gps_lon,

-- Compute distance to GPS-points from maneuvers (e.g. stopping line)
ST_distance_sphere(
 	st_point("public".t_can_format.gps_lon, "public".t_can_format.gps_lat), 
 	st_point(gps4s1.lon, gps4s1.lat)) 
 	AS dist2gps_s1_m,

ST_distance_sphere(
 	st_point("public".t_can_format.gps_lon, "public".t_can_format.gps_lat), 
 	st_point(gps4s2.lon, gps4s2.lat)) 
 	AS dist2gps_s2_m,

ST_distance_sphere(
 	st_point("public".t_can_format.gps_lon, "public".t_can_format.gps_lat), 
 	st_point(gps4s3.lon, gps4s3.lat)) 
 	AS dist2gps_s3_m,

-- Compute distance to helper-GPS-points (boundaries)
ST_distance_sphere(
 	st_point("public".t_can_format.gps_lon, "public".t_can_format.gps_lat), 
 	st_point(gps4s1_helper.lon, gps4s1_helper.lat)) 
 	AS dist2gps_s1_helper_m,

ST_distance_sphere(
 	st_point("public".t_can_format.gps_lon, "public".t_can_format.gps_lat), 
 	st_point(gps4s2_helper.lon, gps4s2_helper.lat)) 
 	AS dist2gps_s2_helper_m,

ST_distance_sphere(
 	st_point("public".t_can_format.gps_lon, "public".t_can_format.gps_lat), 
 	st_point(gps4s3_helper.lon, gps4s3_helper.lat)) 
 	AS dist2gps_s3_helper_m



FROM
"public".t_can_format
LEFT OUTER JOIN "public".v_can_dist ON "public".t_can_format.rownr = "public".v_can_dist.rownr,

(	SELECT
	"public".t_gps4sxx_helper.gpsx,
	"public".t_gps4sxx_helper.lat,
	"public".t_gps4sxx_helper.lon
	FROM
	"public".t_gps4sxx_helper
	WHERE
	"public".t_gps4sxx_helper.gpsx = 1
) gps4s1_helper,

(	SELECT
	"public".t_gps4sxx_helper.gpsx,
	"public".t_gps4sxx_helper.lat,
	"public".t_gps4sxx_helper.lon
	FROM
	"public".t_gps4sxx_helper
	WHERE
	"public".t_gps4sxx_helper.gpsx = 2
) gps4s2_helper,

(	SELECT
	"public".t_gps4sxx_helper.gpsx,
	"public".t_gps4sxx_helper.lat,
	"public".t_gps4sxx_helper.lon
	FROM
	"public".t_gps4sxx_helper
	WHERE
	"public".t_gps4sxx_helper.gpsx = 3
) gps4s3_helper,

(	SELECT
	"public".t_gps4sxx.sxx,
	"public".t_gps4sxx.lat,
	"public".t_gps4sxx.lon
	FROM
	"public".t_gps4sxx
	WHERE
	"public".t_gps4sxx.sxx = 1
) gps4s1,

(	SELECT
	"public".t_gps4sxx.sxx,
	"public".t_gps4sxx.lat,
	"public".t_gps4sxx.lon
	FROM
	"public".t_gps4sxx
	WHERE
	"public".t_gps4sxx.sxx = 2
) gps4s2,

(	SELECT
	"public".t_gps4sxx.sxx,
	"public".t_gps4sxx.lat,
	"public".t_gps4sxx.lon
	FROM
	"public".t_gps4sxx
	WHERE
	"public".t_gps4sxx.sxx = 3
) gps4s3

ORDER BY "public".t_can_format.rownr