DROP VIEW IF EXISTS v_can_runs70_asblock2 CASCADE;
CREATE OR REPLACE VIEW v_can_runs70_asblock2 AS

SELECT *

FROM
"public".v_can_runs70

WHERE
runid >= 3
