DROP TABLE IF EXISTS t_adtf_rounds_by_row CASCADE;
CREATE TABLE t_adtf_rounds_by_row AS
--------------------------------------------------------------------------------
-- Combine vehicle data and round information
SELECT
t_adtf_formatted.row_nr, 
t_adtf_formatted.subject_id, 
t_adtf_rounds_summary.round_id,
--------------------------------------------------------------------------------
COALESCE(
	CASE WHEN t_adtf_rounds_summary.round_id = runs50_t1_runid THEN 't1_v50' ELSE NULL END,
	CASE WHEN t_adtf_rounds_summary.round_id = runs50_t2_runid THEN 't2_v50' ELSE NULL END,
	CASE WHEN t_adtf_rounds_summary.round_id = runs70_t1_runid THEN 't1_v70' ELSE NULL END,
	CASE WHEN t_adtf_rounds_summary.round_id = runs70_t2_runid THEN 't2_v70' ELSE NULL END
) AS round_txt,
--------------------------------------------------------------------------------
CASE 
	WHEN 
		t_adtf_rounds_summary.round_id = runs50_t1_runid OR 
		t_adtf_rounds_summary.round_id = runs70_t1_runid
	THEN 
		1 
	ELSE 
		CASE 
			WHEN 
				t_adtf_rounds_summary.round_id <> 0 
			THEN 
			2 
		END
	END AS condition_run,
--------------------------------------------------------------------------------
CASE 
	WHEN 
		(t_adtf_rounds_summary.round_id = trip_id_t1_50_kmh OR 
		t_adtf_rounds_summary.round_id = trip_id_t2_50_kmh) AND
		t_adtf_rounds_summary.round_id <> 0
	THEN 
		50 
	ELSE 
		CASE 
			WHEN 
				t_adtf_rounds_summary.round_id <> 0 
			THEN 
				70 
			END	
	END AS condition_speed
--------------------------------------------------------------------------------
FROM 
t_adtf_formatted
LEFT JOIN
	t_adtf_rounds_summary ON 
		t_adtf_formatted.subject_id =  t_adtf_rounds_summary.subject_id AND
		t_adtf_formatted.row_nr     >= t_adtf_rounds_summary.row_nr_round_start AND
		t_adtf_formatted.row_nr     <= t_adtf_rounds_summary.row_nr_round_end
LEFT JOIN
	t_experimental_conditions_speed_order ON 
		t_adtf_rounds_summary.subject_id = t_experimental_conditions_speed_order.subject_id
--------------------------------------------------------------------------------
WHERE 
round_id IS NOT NULL
--------------------------------------------------------------------------------s
ORDER BY
row_nr