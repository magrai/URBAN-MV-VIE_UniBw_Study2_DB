DROP VIEW IF EXISTS v_q_drivingstyle CASCADE;
CREATE VIEW v_q_drivingstyle AS

SELECT
"public".t_subid2candid.subid,
"public".v_q_screening.ds01,
"public".v_q_screening.ds02,
"public".v_q_screening.ds03,
"public".v_q_screening.ds04,
"public".v_q_screening.ds05,
"public".v_q_screening.ds06,
"public".v_q_screening.ds07,
"public".v_q_screening.ds08,
"public".v_q_screening.ds09,
"public".v_q_screening.ds10,
"public".v_q_screening.ds11
FROM
"public".v_q_screening
INNER JOIN "public".t_subid2candid ON "public".t_subid2candid.candid = "public".v_q_screening.candid
ORDER BY
"public".t_subid2candid.subid
