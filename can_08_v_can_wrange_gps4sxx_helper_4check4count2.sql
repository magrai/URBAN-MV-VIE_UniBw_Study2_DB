DROP VIEW IF EXISTS v_can_wrange_gps_sx_helper_4check4count2 CASCADE;
CREATE OR REPLACE VIEW v_can_wrange_gps_sx_helper_4check4count2 AS

SELECT 
subid, 
COUNT(*)

FROM v_can_wrange_gps_sx_helper_3check4dupl2

GROUP BY
subid

ORDER BY
subid