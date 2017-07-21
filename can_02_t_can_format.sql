DROP TABLE IF EXISTS t_can_format CASCADE;
CREATE TABLE t_can_format AS


SELECT 

--Zeilennummerierung für gesamten Tabelle
ROW_NUMBER() OVER (ORDER BY v_can_union.subid::NUMERIC, v_can_union."Time"::NUMERIC) AS rownr,

v_can_union.subid::NUMERIC AS subid, 

--Zeilennummerierung für jede Versuchsperson
ROW_NUMBER() OVER (PARTITION BY v_can_union.subid::NUMERIC 
	ORDER BY v_can_union.subid::NUMERIC, v_can_union."Time"::NUMERIC) 
	AS rnr_subid,

v_can_union.filename::VARCHAR as name_data,
v_can_union."Time"::NUMERIC AS time_s, 
v_can_union."struct_0.ESP_v_Signal"::NUMERIC AS speed_kmh, 
v_can_union."struct_0.ESP_Querbeschleunigung"::NUMERIC AS acclat_ms2, 
v_can_union."struct_0.ESP_Laengsbeschl"::NUMERIC AS acclong_ms2, 
v_can_union."struct_0.ESP_Gierrate"::NUMERIC AS yawrate_degs, 
v_can_union."struct_0.ESP_Bremsdruck"::NUMERIC AS brakepress_bar,
v_can_union."struct_0.ESP_Status_Bremsdruck"::NUMERIC AS brakepress_status, 
v_can_union."struct_0.LWI_Lenkradwinkel"::NUMERIC AS steerangle_deg, 
v_can_union."struct_0.OBD_Abs_Pedal_Pos"::NUMERIC AS accpedalpos_perc, 

--Integration des Blinkerstatus links und rechts in einer neuen Variable
CASE
	WHEN v_can_union."struct_0.BH_Blinker_li"::NUMERIC=1 THEN 1::NUMERIC
	WHEN v_can_union."struct_0.BH_Blinker_re"::NUMERIC=1 THEN -1::NUMERIC
	ELSE (0)::NUMERIC
END AS ind,  

v_can_union."struct_1.position_type"::NUMERIC AS dgps_correct_type,
v_can_union."struct_1.solution_status"::NUMERIC AS dgps_ressginal, 
v_can_union."struct_1.differential_age"::NUMERIC AS dgps_correct_age, 
v_can_union."struct_1.gps_week"::NUMERIC AS dgps_time_week, 
v_can_union."struct_1.gps_ms"::NUMERIC AS dgps_time_ms, 
v_can_union."struct_1.latitude"::NUMERIC AS gps_lat, 
v_can_union."struct_1.latitude_deviation"::NUMERIC AS gps_lat_dev, 
v_can_union."struct_1.longitude"::NUMERIC AS gps_lon, 
v_can_union."struct_1.longitude_deviation"::NUMERIC AS gps_lon_dev, 
v_can_union."struct_1.height"::NUMERIC AS gps_height, 
v_can_union."struct_1.height_deviation"::NUMERIC AS gps_height_dev
   
FROM 
v_can_union

ORDER BY
v_can_union.subid::NUMERIC,
v_can_union."Time"::NUMERIC
