DROP VIEW IF EXISTS v_q_pasa_t1_scores CASCADE;
CREATE VIEW v_q_pasa_t1_scores AS

SELECT *,

-- PASA (only part 1 = PA) scores
pasa01i + pasa05 + pasa09i + pasa13 as pasa_threat,
pasa02 + pasa06i + pasa10i + pasa14 as pasa_challenge,
-- ... alternative due to potential misunderstanding of item 02
pasa06i + pasa10i + pasa14 as pasa_challenge_v2,

-- PASA primary appraisal score
pasa01i + pasa05 + pasa09i + pasa13 + pasa02 + pasa06i + pasa10i + pasa14 as pasa_pa,
-- ... alternative due to potential misunderstanding of item 02
pasa01i + pasa05 + pasa09i + pasa13 + pasa06i + pasa10i + pasa14 as pasa_pa_v2,

-- PASA primary appraisal score relative
(100 / (8*6)) * (pasa01i + pasa05 + pasa09i + pasa13 + pasa02 + pasa06i + pasa10i + pasa14) as pasa_pa_rel,
-- ... alternative due to potential misunderstanding of item 02
(100 / (7*6)) * (pasa01i + pasa05 + pasa09i + pasa13 + pasa06i + pasa10i + pasa14) as pasa_pa_rel_v2

FROM
( 
	SELECT
	subid,

	-- PASA items (only part 1 = PA) and recodings:
	-- Items threat: 1, 5, 9, 13
	-- Items challenge: 2, 6, 10, 14) 
	-- Items to be recoded generally (range 1-6): 1, 6, 7, 9, 10
	-- Items to be recoded here (range 1-6): 1, 6, 9, 10
	pasa01,
	CASE 
		WHEN pasa01 = 1 THEN 6
		WHEN pasa01 = 2 THEN 5
		WHEN pasa01 = 3 THEN 4
		WHEN pasa01 = 4 THEN 4
		WHEN pasa01 = 5 THEN 2
		WHEN pasa01 = 6 THEN 1
	END as pasa01i,
	pasa02,
	pasa05,
	pasa06,
	CASE 
		WHEN pasa06 = 1 THEN 6
		WHEN pasa06 = 2 THEN 5
		WHEN pasa06 = 3 THEN 4
		WHEN pasa06 = 4 THEN 4
		WHEN pasa06 = 5 THEN 2
		WHEN pasa06 = 6 THEN 1
	END as pasa06i,
	pasa09,
	CASE 
		WHEN pasa09 = 1 THEN 6
		WHEN pasa09 = 2 THEN 5
		WHEN pasa09 = 3 THEN 4
		WHEN pasa09 = 4 THEN 4
		WHEN pasa09 = 5 THEN 2
		WHEN pasa09 = 6 THEN 1
	END as pasa09i,
	pasa10,
	CASE 
		WHEN pasa10 = 1 THEN 6
		WHEN pasa10 = 2 THEN 5
		WHEN pasa10 = 3 THEN 4
		WHEN pasa10 = 4 THEN 4
		WHEN pasa10 = 5 THEN 2
		WHEN pasa10 = 6 THEN 1
	END as pasa10i,
	pasa13,
	pasa14

	FROM
	t_q_pasa_t1

) pasa_t1_temp