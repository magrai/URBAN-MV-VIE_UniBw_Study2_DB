DROP VIEW IF EXISTS v_can_runs50_asblock1_t2 CASCADE;
CREATE OR REPLACE VIEW v_can_runs50_asblock1_t2 AS

SELECT *

FROM
"public".v_can_runs50_asblock1

WHERE
runid = 2
