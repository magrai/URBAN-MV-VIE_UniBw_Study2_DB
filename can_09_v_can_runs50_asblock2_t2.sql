DROP VIEW IF EXISTS v_can_runs50_asblock2_t2 CASCADE;
CREATE OR REPLACE VIEW v_can_runs50_asblock2_t2 AS

SELECT *

FROM
"public".v_can_runs50_asblock2

WHERE
runid = 4
