DROP VIEW IF EXISTS v_groups CASCADE;
CREATE VIEW v_groups AS

SELECT
"public".t_subid2candid.subid,
"public".v_q_screening."group",

-- Format group names
CASE 
	WHEN "public".v_q_screening."group" LIKE '%EA=1n%' THEN 'EA-low'
	WHEN "public".v_q_screening."group" LIKE '%EA=5n%' THEN 'EA-high'
	WHEN "public".v_q_screening."group" LIKE '%US=1n%' THEN 'US-low'
	WHEN "public".v_q_screening."group" LIKE '%US=5n%' THEN 'US-high'
END AS group_v2,

-- Relating scale
CASE 
	WHEN "public".v_q_screening."group" LIKE '%EA%' THEN 'EA'
	WHEN "public".v_q_screening."group" LIKE '%US%' THEN 'US'
END AS group_scale,

-- Relativ level
CASE 
	WHEN "public".v_q_screening."group" LIKE '%1n%' THEN 'low'
	WHEN "public".v_q_screening."group" LIKE '%5n%' THEN 'high'
END AS group_level

FROM
"public".t_subid2candid
INNER JOIN "public".v_q_screening ON "public".t_subid2candid.candid = "public".v_q_screening.candid

ORDER BY
"public".t_subid2candid.subid