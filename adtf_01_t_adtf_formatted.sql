DROP TABLE IF EXISTS t_adtf_formatted CASCADE;
CREATE TABLE t_adtf_formatted AS
--------------------------------------------------------------------------------
SELECT 
-- Row number on complete table
ROW_NUMBER() 
	OVER (ORDER BY v_adtf_union.subject_id::NUMERIC, v_adtf_union."Time"::NUMERIC) 
	AS row_nr,
v_adtf_union.subject_id::NUMERIC AS subject_id, 
--------------------------------------------------------------------------------
-- Vehicle data
v_adtf_union."Time"										::NUMERIC AS time_s, 
v_adtf_union."ESP_v_Signal"						::NUMERIC AS speed_kmh,
v_adtf_union."ESP_Querbeschleunigung"	::NUMERIC * 9.81 AS acc_lat_ms2, 
v_adtf_union."ESP_Laengsbeschl"				::NUMERIC AS acc_lon_ms2,v_adtf_union."OBD_Abs_Pedal_Pos"			::NUMERIC AS acc_pedal_pos_perc, 
v_adtf_union."ESP_Status_Bremsdruck"	::NUMERIC AS brake_status, 
v_adtf_union."ESP_Bremsdruck"					::NUMERIC AS brake_press_bar,
v_adtf_union."ESP_Gierrate"						::NUMERIC AS yaw_rate_degs, 
v_adtf_union."LWI_Lenkradwinkel"			::NUMERIC AS steer_angle_deg, 
v_adtf_union."LWI_Lenkradw_Geschw"		::NUMERIC AS steer_angle_speed_degs,
--------------------------------------------------------------------------------
-- Create single column for indicator status
CASE
	WHEN 
		v_adtf_union."BH_Blinker_li"::NUMERIC = 1 
	THEN 
		1::NUMERIC
	WHEN 
		v_adtf_union."BH_Blinker_re"::NUMERIC = 1 
	THEN 
		-1::NUMERIC
	ELSE 
		(0)::NUMERIC
END AS ind,  
--------------------------------------------------------------------------------
-- GPS data
v_adtf_union."latitude"								::NUMERIC AS gps_lat, 
v_adtf_union."longitude"							::NUMERIC AS gps_lon
-- v_adtf_union."height"									::NUMERIC AS gps_height
-- v_adtf_union."struct_1.latitude_deviation"::NUMERIC AS gps_lat_dev, 
-- v_adtf_union."struct_1.longitude_deviation"::NUMERIC AS gps_lon_dev, 
-- v_adtf_union."struct_1.height_deviation"::NUMERIC AS gps_height_dev,
-- v_adtf_union."struct_1.position_type"::NUMERIC AS dgps_correct_type,
-- v_adtf_union."struct_1.solution_status"::NUMERIC AS dgps_ressginal, 
-- v_adtf_union."struct_1.differential_age"::NUMERIC AS dgps_correct_age, 
-- v_adtf_union."struct_1.gps_week"::NUMERIC AS dgps_time_week, 
-- v_adtf_union."struct_1.gps_ms"::NUMERIC AS dgps_time_ms, 
-- Filename
-- v_adtf_union.filename::VARCHAR as filename
--------------------------------------------------------------------------------
FROM 
v_adtf_union
--------------------------------------------------------------------------------
ORDER BY
v_adtf_union.subject_id::NUMERIC,
v_adtf_union."Time"::NUMERIC
