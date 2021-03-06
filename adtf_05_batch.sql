-- Study 2 Batch processing
-- Batch computing for all GPS-Coordinates given in t_gps_reference_positions
--------------------------------------------------------------------------------
DO
$do$
--------------------------------------------------------------------------------
DECLARE 
pos_id INT;
position_ids INT[];
--------------------------------------------------------------------------------
BEGIN
--------------------------------------------------------------------------------
SELECT 
	ARRAY_AGG(DISTINCT position_id ORDER BY position_id) 
	FROM t_gps_reference_positions 
	INTO position_ids;
--------------------------------------------------------------------------------
-- For manual situation selection use following line
-- SELECT array_agg(1) INTO position_ids;
--------------------------------------------------------------------------------
-- Loop through each position
FOREACH pos_id IN ARRAY position_ids LOOP
	RAISE INFO 'Processing position %', pos_id;
	-- Compute distance between gps data and reference position
	-- CASE 
	-- WHEN pos_id != 4 
	-- THEN PERFORM f_t_adtf_pxx_gps_dist(pos_id); 
	-- ELSE -- Do nothing 
	-- END CASE;
	
	-- Find minimum gps distance
	-- Deprecated: Computed in R (using visual exploration)
	-- PERFORM f_t_adtf_dist_gps_pxx_min(pos_id); 
	
	-- Compute driven distance or time until reaching the gps reference position
	PERFORM f_t_adtf_pxx_am(pos_id); 
	
	-- Find minimum driven distance or time when reaching the minimum distance to the gps reference position
	-- NECESSARY?
	-- PERFORM f_t_adtf_dist2sxx_min(pos_id); 
	
	-- Aggregate to 10 Hz time (and minimise distance)
	PERFORM f_t_adtf_pxx_am_dti_rnd1(pos_id); 
	
	-- Aggregate to 10 Hz distance (and minimise time)
	PERFORM f_t_adtf_pxx_am_tti_rnd1(pos_id); 
	
	-- Join non-aggregated arrival measures with vehicle data and round names
	PERFORM f_t_adtf_pxx_full(pos_id); 
			
	-- Join distance-aggregated arrival measures with vehicle data and round names
	PERFORM f_t_adtf_pxx_full_dti_rnd1(pos_id); 
	
	-- Join time-aggregated arrival measures with vehicle data and round names
	PERFORM f_t_adtf_pxx_full_tti_rnd1(pos_id); 
END LOOP;
--------------------------------------------------------------------------------
END $do$;