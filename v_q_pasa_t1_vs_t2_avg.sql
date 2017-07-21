DROP VIEW IF EXISTS v_q_pasa_t1_vs_t2_avg CASCADE;
CREATE VIEW v_q_pasa_t1_vs_t2_avg AS

SELECT
"public".v_q_pasa_t1_vs_t2.cond,
avg("public".v_q_pasa_t1_vs_t2.pasa_threat_t1) as pasa_threat_t1_avg,
avg("public".v_q_pasa_t1_vs_t2.pasa_threat_t2) as pasa_threat_t2_avg,
avg("public".v_q_pasa_t1_vs_t2.pasa_threat_t1) - avg("public".v_q_pasa_t1_vs_t2.pasa_threat_t2) as pasa_threat_t2_avg_diff,
avg("public".v_q_pasa_t1_vs_t2.pasa_challenge_t1) as pasa_challenge_t1_avg,
avg("public".v_q_pasa_t1_vs_t2.pasa_challenge_t2) as pasa_challenge_t2_avg,
avg("public".v_q_pasa_t1_vs_t2.pasa_challenge_t1) - avg("public".v_q_pasa_t1_vs_t2.pasa_challenge_t2) as pasa_challenge_t2_avg_diff,
avg("public".v_q_pasa_t1_vs_t2.pasa_challenge_v2_t1) as pasa_challenge_v2_t1_avg,
avg("public".v_q_pasa_t1_vs_t2.pasa_challenge_v2_t2) as pasa_challenge_v2_t2_avg,
avg("public".v_q_pasa_t1_vs_t2.pasa_challenge_v2_t1) - avg("public".v_q_pasa_t1_vs_t2.pasa_challenge_v2_t2) as pasa_challenge_v2_t2_avg_diff,
avg("public".v_q_pasa_t1_vs_t2.pasa_pa_rel_t1) as pasa_pa_rel_t1_avg,
avg("public".v_q_pasa_t1_vs_t2.pasa_pa_rel_t2) as pasa_pa_rel_t2_avg,
avg("public".v_q_pasa_t1_vs_t2.pasa_pa_rel_t1) - avg("public".v_q_pasa_t1_vs_t2.pasa_pa_rel_t2) as pasa_pa_rel_t2_avg_diff,
avg("public".v_q_pasa_t1_vs_t2.pasa_pa_rel_v2_t1) as pasa_pa_rel_v2_t1_avg,
avg("public".v_q_pasa_t1_vs_t2.pasa_pa_rel_v2_t2) as pasa_pa_rel_v2_t2_avg,
avg("public".v_q_pasa_t1_vs_t2.pasa_pa_rel_v2_t1) - avg("public".v_q_pasa_t1_vs_t2.pasa_pa_rel_v2_t2) as pasa_pa_rel_v2_t2_avg_diff
FROM
"public".v_q_pasa_t1_vs_t2

GROUP BY
"public".v_q_pasa_t1_vs_t2.cond
