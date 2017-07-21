DROP VIEW IF EXISTS v_can_dist CASCADE;
CREATE OR REPLACE VIEW v_can_dist AS

SELECT
"public".v_can_dist_diff.rownr,
"public".v_can_dist_diff.subid,
"public".v_can_dist_diff.time_s,
"public".v_can_dist_diff.dist_m_diff,

--Summierung der gefahrenen Distanz je Messung
sum("public".v_can_dist_diff.dist_m_diff) over (partition by "public".v_can_dist_diff.subid order by "public".v_can_dist_diff.rownr) as dist_m

FROM
"public".v_can_dist_diff

ORDER BY "public".v_can_dist_diff.rownr