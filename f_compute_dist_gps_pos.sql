-- Compute distance between gps data and reference gps points
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION f_t_adtf_dist_gps_pxx (pos_id INT DEFAULT NULL) 
RETURNS VOID
LANGUAGE plpgsql AS $$
--------------------------------------------------------------------------------
DECLARE pos_id_txt TEXT = LPAD(pos_id::text, 2, '0');
--------------------------------------------------------------------------------
BEGIN
	RAISE INFO '==================================================';
	RAISE INFO 'Processing f_t_adtf_dist_gps_pos';
	RAISE INFO 'GPS reference position %', pos_id;
	RAISE INFO '==================================================';
--------------------------------------------------------------------------------
	EXECUTE '
		DROP TABLE IF EXISTS t_dist_gps_p' ||  pos_id_txt || ' CASCADE;
		CREATE TABLE t_dist_gps_p' ||  pos_id_txt || ' AS

		SELECT
		t_can_format.rnr,
		t_can_format.subject_id,
		t_can_format.time_s,
		t_can_format.gps_lat,
		t_can_format.gps_lon,

		ST_distance_sphere(
			st_point(t_can_format.gps_lon, t_can_format.gps_lat), 
			st_point(gps_s' || pos_id_txt || '.lon, gps_p' || pos_id_txt || '.lat)) 
		AS p' ||  pos_id_txt || '_gps_dist_m

		FROM
		t_adtf,
		(SELECT sxx, lat, lon FROM t_gps_position WHERE pos_id = ' || pos_id || ') gps_p' || pos_id_txt || '
		';
END $$;