DROP VIEW IF EXISTS v_q_driving_style CASCADE;
CREATE VIEW v_q_driving_style AS

SELECT 
subject_id,
ds_01::NUMERIC AS ds_01,
ds_02::NUMERIC AS ds_02,
ds_03::NUMERIC AS ds_03,
ds_04::NUMERIC AS ds_04,
ds_05::NUMERIC AS ds_05,
ds_06::NUMERIC AS ds_06,
ds_07::NUMERIC AS ds_07,
ds_08::NUMERIC AS ds_08,
ds_09::NUMERIC AS ds_09,
ds_10::NUMERIC AS ds_10,
ds_11::NUMERIC AS ds_11

FROM
public."150924_data4screen-export_formatiert_V7_filter_4postgreSQL"
INNER JOIN 
public.t_link_subject_applicant ON public.t_link_subject_applicant.applicant_id::VARCHAR = public."150924_data4screen-export_formatiert_V7_filter_4postgreSQL".id

ORDER BY
subject_id