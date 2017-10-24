DROP VIEW IF EXISTS v_q_demo CASCADE;
CREATE VIEW v_q_demo AS

SELECT 
subject_id,
sex,
age::NUMERIC,
drivexp AS driving_experience,
licence_year::NUMERIC,
driving_years::NUMERIC AS driving_years,
km_overall::NUMERIC,
km_12month::NUMERIC,
driving_freq

FROM
public."150924_data4screen-export_formatiert_V7_filter_4postgreSQL"
INNER JOIN 
public.t_link_subject_applicant ON public.t_link_subject_applicant.applicant_id::VARCHAR = public."150924_data4screen-export_formatiert_V7_filter_4postgreSQL".id

ORDER BY
subject_id