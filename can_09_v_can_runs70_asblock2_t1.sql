DROP VIEW IF EXISTS v_can_runs70_asblock2_t1 CASCADE;
CREATE OR REPLACE VIEW v_can_runs70_asblock2_t1 AS

SELECT *

FROM
"public".v_can_runs70_asblock2

WHERE
runid = 3
