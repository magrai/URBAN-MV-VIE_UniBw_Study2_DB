DROP VIEW IF EXISTS v_can_runs50_asblock1_t1 CASCADE;
CREATE OR REPLACE VIEW v_can_runs50_asblock1_t1 AS

SELECT *

FROM
"public".v_can_runs50_asblock1

WHERE
runid = 1
