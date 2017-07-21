DROP VIEW IF EXISTS v_q_pasa_t1_vs_t2 CASCADE;
CREATE VIEW v_q_pasa_t1_vs_t2 AS

SELECT
"public".v_condfinder.subid,
"public".v_condfinder.cond,
"public".v_q_pasa_t1_scores.pasa_threat as pasa_threat_t1,
"public".v_q_pasa_t2_scores.pasa_threat as pasa_threat_t2,
"public".v_q_pasa_t1_scores.pasa_challenge as pasa_challenge_t1,
"public".v_q_pasa_t2_scores.pasa_challenge as pasa_challenge_t2,
"public".v_q_pasa_t1_scores.pasa_challenge_v2 as pasa_challenge_v2_t1,
"public".v_q_pasa_t2_scores.pasa_challenge_v2 as pasa_challenge_v2_t2,
"public".v_q_pasa_t1_scores.pasa_pa as pasa_pa_t1,
"public".v_q_pasa_t2_scores.pasa_pa as pasa_pa_t2,
"public".v_q_pasa_t1_scores.pasa_pa_v2 as pasa_pa_v2_t1,
"public".v_q_pasa_t2_scores.pasa_pa_v2 as pasa_pa_v2_t2,
"public".v_q_pasa_t1_scores.pasa_pa_rel as pasa_pa_rel_t1,
"public".v_q_pasa_t2_scores.pasa_pa_rel as pasa_pa_rel_t2,
"public".v_q_pasa_t1_scores.pasa_pa_rel_v2 as pasa_pa_rel_v2_t1,
"public".v_q_pasa_t2_scores.pasa_pa_rel_v2 as pasa_pa_rel_v2_t2
FROM
"public".v_condfinder
INNER JOIN "public".v_q_pasa_t1_scores ON "public".v_condfinder.subid = "public".v_q_pasa_t1_scores.subid
INNER JOIN "public".v_q_pasa_t2_scores ON "public".v_q_pasa_t1_scores.subid = "public".v_q_pasa_t2_scores.subid

ORDER BY
"public".v_condfinder.cond
