DROP TABLE IF EXISTS t_can_dist2gps CASCADE;
CREATE TABLE t_can_dist2gps AS

SELECT * FROM v_can_dist2gps
ORDER BY rownr

-- ~est. 20 Minutes