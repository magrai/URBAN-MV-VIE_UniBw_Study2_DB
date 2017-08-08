DROP TABLE IF EXISTS t_adtf_formatted CASCADE;
CREATE TABLE t_adtf_formatted AS

SELECT 
-- Row number on complete table
ROW_NUMBER() OVER (ORDER BY v_adtf_union.subject_id::NUMERIC, v_adtf_union."Time"::NUMERIC) AS row_nr,
v_adtf_union.subject_id::NUMERIC AS subject_id, 

-- Vehicle data
v_adtf_union."Time"::NUMERIC AS time_s, 
v_adtf_union."ESP_v_Signal"::NUMERIC AS speed_kmh, 
v_adtf_union."ESP_Querbeschleunigung"::NUMERIC * 9.81 AS acclat_ms2, 
v_adtf_union."ESP_Laengsbeschl"::NUMERIC AS acclon_ms2, 
v_adtf_union."ESP_Gierrate"::NUMERIC AS yawrate_degs, 
v_adtf_union."ESP_Bremsdruck"::NUMERIC AS brakepress_bar,
v_adtf_union."ESP_Status_Bremsdruck"::NUMERIC AS brakepress_status, 
v_adtf_union."LWI_Lenkradwinkel"::NUMERIC AS steerangle_deg, 
v_adtf_union."LWI_Lenkradw_Geschw"::NUMERIC AS steerangle_speed_degs, 
v_adtf_union."OBD_Abs_Pedal_Pos"::NUMERIC AS accpedalpos_perc, 
-- v_adtf_union."KBI_Kilometerstand"::NUMERIC as mileage,

-- Create single column for indicator status
CASE
	WHEN v_adtf_union."BH_Blinker_li"::NUMERIC=1 THEN 1::NUMERIC
	WHEN v_adtf_union."BH_Blinker_re"::NUMERIC=1 THEN -1::NUMERIC
	ELSE (0)::NUMERIC
END AS ind,  

-- GPS data
v_adtf_union."latitude"::NUMERIC AS lat, 
v_adtf_union."longitude"::NUMERIC AS lon,
-- v_adtf_union."struct_1.position_type"::NUMERIC AS dgps_correct_type,
-- v_adtf_union."struct_1.solution_status"::NUMERIC AS dgps_ressginal, 
-- v_adtf_union."struct_1.differential_age"::NUMERIC AS dgps_correct_age, 
-- v_adtf_union."struct_1.gps_week"::NUMERIC AS dgps_time_week, 
-- v_adtf_union."struct_1.gps_ms"::NUMERIC AS dgps_time_ms, 
-- v_adtf_union."struct_1.latitude_deviation"::NUMERIC AS gps_lat_dev, 
-- v_adtf_union."struct_1.longitude_deviation"::NUMERIC AS gps_lon_dev, 
-- v_adtf_union."struct_1.height"::NUMERIC AS gps_height, 
-- v_adtf_union."struct_1.height_deviation"::NUMERIC AS gps_height_dev,
-- Filename
--v_adtf_union.filename::VARCHAR as filename

FROM 
v_adtf_union

ORDER BY
v_adtf_union.subject_id::NUMERIC,
v_adtf_union."Time"::NUMERIC
