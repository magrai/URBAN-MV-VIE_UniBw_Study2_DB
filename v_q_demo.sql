DROP VIEW IF EXISTS v_q_demo CASCADE;
CREATE VIEW v_q_demo AS

SELECT
"public".t_subid2candid.subid,
"public".v_q_screening.sex,
"public".v_q_screening.age,
"public".v_q_screening.drivexp,
"public".v_q_screening.licence_year,
"public".v_q_screening.regdriving_years,
"public".v_q_screening.km_overall,
"public".v_q_screening.km_12month,
"public".v_q_screening.driving_freq
FROM
"public".v_q_screening
INNER JOIN "public".t_subid2candid ON "public".t_subid2candid.candid = "public".v_q_screening.candid

ORDER BY
"public".t_subid2candid.subid