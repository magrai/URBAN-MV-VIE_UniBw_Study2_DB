-- Find minimum gps distance
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION f_t_adtf_dist_gps_pos_min (pod_id INT DEFAULT NULL) 
RETURNS VOID
LANGUAGE plpgsql AS $$
--------------------------------------------------------------------------------
DECLARE colexist INT;
DECLARE pos_id INT := pos_id;
DECLARE pos_id_txt TEXT := LPAD(pos_id::text, 2, '0');
DECLARE helper_varname TEXT;
DECLARE helper_val INT;
--------------------------------------------------------------------------------
BEGIN
RAISE INFO 
'

==================================================
Processing f_t_adtf_dist_gps_pos_min
GPS reference position %', pos_id'
==================================================

', s;
--------------------------------------------------------------------------------
	-- Create table for minimum gps distances (if not exists)
	IF NOT EXISTS (
		SELECT 1 FROM pg_catalog.pg_tables 
		WHERE 
		schemaname = 'public' AND 
		tablename  = 't_adtf_dist_gps_pos_min'
	) THEN
			RAISE NOTICE 'Create table t_adtf_dist_gps_pos_min';
			CREATE TABLE t_adtf_dist_gps_pos_min (
				rnr_min INT,
				rnr_max INT,
				subject_id INT,
				round_id INT);
			INSERT INTO t_adtf_dist2gpsref_min (subject_id, round_id)
				SELECT DISTINCT subject_id, round_id
				FROM t_adtf_dist;
		ELSE
			RAISE NOTICE 'Table t_adtf_dist_gps_pos_min already exists';
	END IF;
--------------------------------------------------------------------------------
	-- Set values for round identification workaround
	--IF pos_id < 9 OR pos_id > 11
	-- Set values for round identification workaround
	--IF pos_id < 9 OR pos_id > 11
	IF pos_id < 20 AND (pos_id <= 8 OR pos_id >= 12)
		THEN helper_varname := 'round_helper1'; RAISE NOTICE 'helper1';
		ELSE helper_varname := 'round_helper2'; RAISE NOTICE 'helper2';
	END IF;
	--END IF;

	IF  pos_id < 20 AND pos_id >= 12 
		THEN helper_val := 2; RAISE NOTICE 'helper_val2';
		ELSE helper_val := 1; RAISE NOTICE 'helper_val1';
	END IF;
	--END IF;

	IF pos_id > 20 AND (pos_id <= 28 OR pos_id >= 32)
		THEN helper_varname := 'round_helper1'; RAISE NOTICE 'helper1';
		ELSE helper_varname := 'round_helper2'; RAISE NOTICE 'helper2';
	END IF;

	IF pos_id > 20 AND pos_id >= 32
		THEN helper_val := 2; RAISE NOTICE 'helper_val2';
		ELSE helper_val := 1; RAISE NOTICE 'helper_val1';
	END IF;

--------------------------------------------------------------------------------
	-- Check if column for minimum GPS distances already exists for current case
	EXECUTE '
	SELECT (
		SELECT 1 
		FROM 
		information_schema.columns 
		WHERE 
		table_schema=''public'' AND 
		table_name = ''t_adtf_dist_gps_pos_min'' AND 
		column_name = ''p' || pos_id_txt || '_gps_dist_m_min'')' 
	INTO colexist;
--------------------------------------------------------------------------------	
	IF colexist IS NOT NULL
	THEN 
		RAISE NOTICE 'COLUMN ALREADY EXISTS';
	ELSE 
		RAISE NOTICE 'COLUMN DOES NOT EXIST: CREATE COLUMN';
		EXECUTE '
		ALTER TABLE t_adtf_dist_gps_pos_min 
		ADD COLUMN p' || pos_id_txt || '_gps_dist_m_min NUMERIC
		';	
	END IF;
--------------------------------------------------------------------------------
	-- PART 1
	-- Get minimum row number for each round
	-- Using round_helper1 = 1 = 0-5000 m driven distance and 
  -- ... round_helper1 = 2 = 5001 m driven distance until end of trip
  -- PART 2
	-- Get maximum row number for each round
	-- Using round_helper1 = 1 = 0-5000 m driven distance and 
  -- ... round_helper1 = 2 = 5001 m driven distance until end of trip
	-- PART 3
	-- Limiting the data window for extracting the minimum distance
	-- ... between the gps data and gps reference positions
	-- Using adaptive round_helper variables and values
	EXECUTE format('
	UPDATE t_adtf_dist_gps_pos_min 
		SET 
		rnr_min = temp1.rnr_min
		FROM
		( SELECT MIN(rnr) AS rnr_min, subject_id, round_id
			--FROM t_adtf_dist2gpsref_p' || pos_id_txt || '
			FROM t_adtf_dist
			WHERE round_helper1 = 1
			GROUP BY subject_id, round_id
		) temp1
		WHERE 
		t_adtf_dist2gpsref_min.subject_id = temp1.subject_id AND
		t_adtf_dist2gpsref_min.round_id = temp1.round_id;
--------------------------------------------------------------------------------
	UPDATE t_adtf_dist_gps_pos_min 
		SET 
		rnr_max = temp2.rnr_max
		FROM
		( SELECT MAX(rnr) AS rnr_max, subject_id, round_id
			--FROM t_adtf_dist2gpsref_p' || pos_id_txt || '
			FROM t_adtf_dist
			WHERE round_helper1 = 2
			GROUP BY subject_id, round_id
		) temp2
		WHERE 
		t_adtf_dist2gpsref_min.subject_id = temp2.subject_id AND
		t_adtf_dist2gpsref_min.round_id = temp2.round_id;
--------------------------------------------------------------------------------
	UPDATE t_adtf_dist_gps_pos_min 
			SET 
			--rnr_min = temp_gps.rnr_min,
			p' || pos_id_txt || '_gps_dist_m_min = temp_gps.p' || pos_id_txt || '_gps_dist_m_min
			FROM 
			( SELECT 
				--MIN(rnr) as rnr_min, 
				subject_id, round_id,
				MIN(p' || pos_id_txt || '_gps_dist_m) AS p' || pos_id_txt || '_gps_dist_m_min
				FROM t_adtf_dist2gpsref_p' || pos_id_txt || '
				WHERE ' || helper_varname || ' = ' || helper_val || ' 
				GROUP BY subject_id, round_id
			) temp_gps
			WHERE 
			t_adtf_dist_gps_pos_min.subject_id = temp_gps.subject_id AND
			t_adtf_dist_gps_pos_min.round_id = temp_gps.round_id;		
--------------------------------------------------------------------------------
	'); -- End EXECUTE format
END $$;
-- 
-- INSERT INTO t_adtf_dist2gpsref_min
-- SELECT
-- MIN(t_adtf_dist2gpsref.rnr) AS rnr_min,
-- -- MAX(t_adtf_dist2gpsref.rnr) AS rnr_max,
-- subject_id,
-- round_id,
-- MIN(s01_gps_dist_m) AS s01_gps_dist_m_min
-- 
-- FROM
-- t_adtf_dist2gpsref 
-- 
-- WHERE 
-- round_helper1 = 1
-- 
-- GROUP BY
-- subject_id,
-- round_id