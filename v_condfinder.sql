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
	"public".t_subid2candid.subid,
	"public".t_subid2candid.candid,
	CASE
		WHEN t_subjects_overview.cond_v2 IS NULL THEN t_subjects_overview.cond 
		ELSE t_subjects_overview.cond_v2
	END AS cond

	FROM
	"public".t_subjects_overview
	INNER JOIN "public".t_subid2candid ON "public".t_subjects_overview."id" = "public".t_subid2candid.candid

	ORDER BY
	subid
) condfinder