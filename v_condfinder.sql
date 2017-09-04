DROP VIEW IF EXISTS v_condfinder CASCADE;
CREATE OR REPLACE VIEW v_condfinder AS

SELECT *,

CASE WHEN condfinder.cond = '50-50-70-70' THEN 1 ELSE 0 END AS runs50_first,
CASE WHEN condfinder.cond = '70-70-50-50' THEN 1 ELSE 0 END AS runs70_first,

CASE WHEN condfinder.cond = '50-50-70-70' THEN 1 ELSE 3 END AS runs50_t1_runid,
CASE WHEN condfinder.cond = '50-50-70-70' THEN 2 ELSE 4 END AS runs50_t2_runid,
CASE WHEN condfinder.cond = '70-70-50-50' THEN 1 ELSE 3 END AS runs70_t1_runid,
CASE WHEN condfinder.cond = '70-70-50-50' THEN 2 ELSE 4 END AS runs70_t2_runid

FROM 
-- create window for with corrected condition info
(	SELECT
	t_id_subject2applicant.subject_id,
	t_id_subject2applicant.applicant_id,
	CASE
		WHEN t_subjects_overview.cond_v2 IS NULL THEN t_subjects_overview.cond 
		ELSE t_subjects_overview.cond_v2
	END AS cond

	FROM
	t_subjects_overview
	INNER JOIN t_id_subject2applicant ON t_subjects_overview.applicant_id = t_id_subject2applicant.applicant_id

	ORDER BY
	subject_id
) condfinder