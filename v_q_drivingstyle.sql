DROP TABLE IF EXISTS t_q_driving_style CASCADE;
CREATE TABLE t_q_driving_style AS

SELECT
t_id_subject2applicant.subject_id,
v_q_screening.ds01,
v_q_screening.ds02,
v_q_screening.ds03,
v_q_screening.ds04,
v_q_screening.ds05,
v_q_screening.ds06,
v_q_screening.ds07,
v_q_screening.ds08,
v_q_screening.ds09,
v_q_screening.ds10,
v_q_screening.ds11
FROM
v_q_screening
INNER JOIN t_id_subject2applicant.subject_id ON v_q_screening.applicant_id = t_id_subject2applicant.subject_id
ORDER BY
t_id_subject2applicant.subject_id
