DROP TABLE IF EXISTS t_experimental_conditions_speed_order CASCADE;
CREATE TABLE t_experimental_conditions_speed_order AS

SELECT *,

CASE WHEN temp.speed_order = '50-50-70-70' THEN TRUE ELSE FALSE END AS starts_with_50_kmh,
CASE WHEN temp.speed_order = '70-70-50-50' THEN TRUE ELSE FALSE END AS starts_with_70_kmh,

CASE WHEN temp.speed_order = '50-50-70-70' THEN 1 ELSE 3 END AS trip_id_t1_50_kmh,
CASE WHEN temp.speed_order = '50-50-70-70' THEN 2 ELSE 4 END AS trip_id_t2_50_kmh,
CASE WHEN temp.speed_order = '70-70-50-50' THEN 1 ELSE 3 END AS trip_id_t1_70_kmh,
CASE WHEN temp.speed_order = '70-70-50-50' THEN 2 ELSE 4 END AS trip_id_t2_70_kmh

FROM 
-- Create window with corrected information on speed condition
(	SELECT
	t_experimental_design.subject_id,
	CASE
		WHEN t_experimental_design.speed_order_corrected IS NULL 
		THEN t_experimental_design.speed_order
		ELSE t_experimental_design.speed_order_corrected
	END AS speed_order

	FROM
	t_experimental_design

	ORDER BY
	subject_id
) temp