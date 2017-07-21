DROP VIEW IF EXISTS v_can_wrange_gps_sx_helper_5correction CASCADE;
CREATE OR REPLACE VIEW v_can_wrange_gps_sx_helper_5correction AS


SELECT *,

-- Annotate introduction and runs
-- Special Case: ID38 repeates run 2
CASE
	WHEN subid = 38 THEN
		CASE 
			WHEN gps_sx_reached_id_rev <= 36 AND gps_sx_reached_id_rev >= 31 THEN 0
			WHEN gps_sx_reached_id_rev <= 30 AND gps_sx_reached_id_rev >= 25 THEN 1
			WHEN gps_sx_reached_id_rev <= 24 AND gps_sx_reached_id_rev >= 19 THEN 2
			WHEN gps_sx_reached_id_rev <= 18 AND gps_sx_reached_id_rev >= 13 THEN 3
			WHEN gps_sx_reached_id_rev <= 12 AND gps_sx_reached_id_rev >=  7 THEN 4
			WHEN gps_sx_reached_id_rev <=  6 AND gps_sx_reached_id_rev >=  1 THEN 22
		END
	ELSE
		CASE
			WHEN gps_sx_reached_id_rev <= 30 AND gps_sx_reached_id_rev >= 25 THEN 0
			WHEN gps_sx_reached_id_rev <= 24 AND gps_sx_reached_id_rev >= 19 THEN 1
			WHEN gps_sx_reached_id_rev <= 18 AND gps_sx_reached_id_rev >= 13 THEN 2
			WHEN gps_sx_reached_id_rev <= 12 AND gps_sx_reached_id_rev >=  7 THEN 3
			WHEN gps_sx_reached_id_rev <=  6 AND gps_sx_reached_id_rev >=  1 THEN 4
		END
END AS runid,

-- Annotate direction
CASE
	WHEN gps_sx_reached_id_rev = 30 OR gps_sx_reached_id_rev = 29 THEN 'right'
	WHEN gps_sx_reached_id_rev = 28 OR gps_sx_reached_id_rev = 27 THEN 'left'
	WHEN gps_sx_reached_id_rev = 26 OR gps_sx_reached_id_rev = 25 THEN 'straight'
	WHEN gps_sx_reached_id_rev = 24 OR gps_sx_reached_id_rev = 23 THEN 'right'
	WHEN gps_sx_reached_id_rev = 22 OR gps_sx_reached_id_rev = 21 THEN 'left'
	WHEN gps_sx_reached_id_rev = 20 OR gps_sx_reached_id_rev = 19 THEN 'straight'
	WHEN gps_sx_reached_id_rev = 18 OR gps_sx_reached_id_rev = 17 THEN 'right'
	WHEN gps_sx_reached_id_rev = 16 OR gps_sx_reached_id_rev = 15 THEN 'left'
	WHEN gps_sx_reached_id_rev = 14 OR gps_sx_reached_id_rev = 13 THEN 'straight'
	WHEN gps_sx_reached_id_rev = 12 OR gps_sx_reached_id_rev = 11 THEN 'right'
	WHEN gps_sx_reached_id_rev = 10 OR gps_sx_reached_id_rev =  9 THEN 'left'
	WHEN gps_sx_reached_id_rev =  8 OR gps_sx_reached_id_rev =  7 THEN 'straight'
	WHEN gps_sx_reached_id_rev =  6 OR gps_sx_reached_id_rev =  5 THEN 'right'
	WHEN gps_sx_reached_id_rev =  4 OR gps_sx_reached_id_rev =  3 THEN 'left'
	WHEN gps_sx_reached_id_rev =  2 OR gps_sx_reached_id_rev =  1 THEN 'straight'
	WHEN subid = 38 THEN
		CASE
			WHEN gps_sx_reached_id_rev = 36 OR gps_sx_reached_id_rev = 35 THEN 'right'
			WHEN gps_sx_reached_id_rev = 34 OR gps_sx_reached_id_rev = 33 THEN 'left'
			WHEN gps_sx_reached_id_rev = 32 OR gps_sx_reached_id_rev = 31 THEN 'straight'
		END
-- In case for subject 11 and 39 (everything above 30 is correctly wrong)
ELSE 'error'
-- mdir = maneuver direction
END AS mdir,

-- Annotate maneouvre id
CASE
	WHEN gps_sx_reached_id_rev = 30 OR gps_sx_reached_id_rev = 29 THEN  1
	WHEN gps_sx_reached_id_rev = 28 OR gps_sx_reached_id_rev = 27 THEN  2
	WHEN gps_sx_reached_id_rev = 26 OR gps_sx_reached_id_rev = 25 THEN  3
	WHEN gps_sx_reached_id_rev = 24 OR gps_sx_reached_id_rev = 23 THEN  4
	WHEN gps_sx_reached_id_rev = 22 OR gps_sx_reached_id_rev = 21 THEN  5
	WHEN gps_sx_reached_id_rev = 20 OR gps_sx_reached_id_rev = 19 THEN  6
	WHEN gps_sx_reached_id_rev = 18 OR gps_sx_reached_id_rev = 17 THEN  7
	WHEN gps_sx_reached_id_rev = 16 OR gps_sx_reached_id_rev = 15 THEN  8
	WHEN gps_sx_reached_id_rev = 14 OR gps_sx_reached_id_rev = 13 THEN  9
	WHEN gps_sx_reached_id_rev = 12 OR gps_sx_reached_id_rev = 11 THEN 10
	WHEN gps_sx_reached_id_rev = 10 OR gps_sx_reached_id_rev =  9 THEN 11
	WHEN gps_sx_reached_id_rev =  8 OR gps_sx_reached_id_rev =  7 THEN 12
	WHEN gps_sx_reached_id_rev =  6 OR gps_sx_reached_id_rev =  5 THEN 13
	WHEN gps_sx_reached_id_rev =  4 OR gps_sx_reached_id_rev =  3 THEN 14
	WHEN gps_sx_reached_id_rev =  2 OR gps_sx_reached_id_rev =  1 THEN 15
-- mid = maneuver id
END AS mid,

-- Annotate start
CASE
	WHEN gps_sx_reached_id_rev % 2 = 0 THEN 1
	ELSE 0
-- mstart = maneuver start (0 = start, 1 = end)
END AS mstart


FROM v_can_wrange_gps_sx_helper_3check4dupl2

WHERE
wrange_gps_s1_helper_v2 <> 2 AND
wrange_gps_s2_helper_v2 <> 2 AND
wrange_gps_s3_helper_v2 <> 2

ORDER BY
subid,
time_s
