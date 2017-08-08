-- Compute distance between gps data and reference gps points
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION compute_dist_gps_pos (s INT DEFAULT NULL) 
RETURNS VOID
LANGUAGE plpgsql AS $$
--------------------------------------------------------------------------------
DECLARE s_txt TEXT = LPAD(s::text, 2, '0');
--------------------------------------------------------------------------------
BEGIN
	RAISE INFO '==================================================';
	RAISE INFO 'Processing f_t_adtf_dist2gpsref_sxx';
	RAISE INFO 'GPS reference position %', s;
	RAISE INFO '==================================================';
--------------------------------------------------------------------------------
	EXECUTE '
		DROP TABLE IF EXISTS t_adtf_dist2gpsref_s' ||  s_txt || ' CASCADE;
		CREATE TABLE t_adtf_dist2gpsref_s' ||  s_txt || ' AS

		SELECT
		t_adtf.rnr,
		t_adtf.subject_id,
		t_adtf_dist.round_id,
		t_adtf_dist.round_helper1,
		t_adtf_dist.round_helper2,
		t_adtf.time_s,
		t_adtf_dist.dist_m,
		t_adtf.gps_lat,
		t_adtf.gps_lon,

		ST_distance_sphere(
			st_point(t_adtf.gps_lon, t_adtf.gps_lat), 
			st_point(gps_s' || s_txt || '.lon, gps_s' || s_txt || '.lat)) 
		AS s' ||  s_txt || '_gps_dist_m

		FROM
		t_adtf LEFT JOIN t_adtf_dist ON t_adtf.rnr = t_adtf_dist.rnr,
		(SELECT sxx, lat, lon FROM t_gpsref WHERE sxx = ' || s || ') gps_s' || s_txt || '
		';
END $$;