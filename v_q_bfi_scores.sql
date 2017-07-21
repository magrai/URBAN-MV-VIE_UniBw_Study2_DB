DROP VIEW IF EXISTS v_q_bfi_scores CASCADE;
CREATE VIEW v_q_bfi_scores AS

SELECT *,

-- BFI-10 Scores 
(bfi04i + bfi09)  / 2 as bfi_neuro,
(bfi01i + bfi06)  / 2 as bfi_extra,
(bfi05i + bfi10)  / 2 as bfi_open,
(bfi02  + bfi07i) / 2 as bfi_agree,
(bfi03i + bfi08)  / 2 as bfi_consc

FROM
( 
	SELECT
	subid,

	-- BFI-10 items and recodings
	bfi01,
	CASE 
		WHEN bfi01 = 1 THEN 5
		WHEN bfi01 = 2 THEN 4
		WHEN bfi01 = 5 THEN 1
		WHEN bfi01 = 4 THEN 2
		ELSE 3
	END as bfi01i,
	bfi02,
	bfi03,
	CASE 
		WHEN bfi03 = 1 THEN 5
		WHEN bfi03 = 2 THEN 4
		WHEN bfi03 = 5 THEN 1
		WHEN bfi03 = 4 THEN 2
		ELSE 3
	END as bfi03i,
	bfi04,
	CASE 
		WHEN bfi04 = 1 THEN 5
		WHEN bfi04 = 2 THEN 4
		WHEN bfi04 = 5 THEN 1
		WHEN bfi04 = 4 THEN 2
		ELSE 3
	END as bfi04i,
	bfi05,
	CASE 
		WHEN bfi05 = 1 THEN 5
		WHEN bfi05 = 2 THEN 4
		WHEN bfi05 = 5 THEN 1
		WHEN bfi05 = 4 THEN 2
		ELSE 3
	END as bfi05i,
	bfi06,
	bfi07,
	CASE 
		WHEN bfi07 = 1 THEN 5
		WHEN bfi07 = 2 THEN 4
		WHEN bfi07 = 5 THEN 1
		WHEN bfi07 = 4 THEN 2
		ELSE 3
	END as bfi07i,
	bfi08,
	bfi09,
	bfi10

FROM t_q_bfi
) bfi_temp

ORDER BY
subid