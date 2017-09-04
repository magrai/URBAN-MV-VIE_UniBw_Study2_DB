DROP VIEW IF EXISTS v_q_screening CASCADE;
CREATE OR REPLACE VIEW v_q_screening AS

SELECT
"id"::NUMERIC as applicant_id,
sex,
age::NUMERIC,
drivexp,
licence_year::NUMERIC,
regdriving_years::NUMERIC,
km_overall::NUMERIC,
km_12month::NUMERIC,
driving_freq,
ds01::NUMERIC,
ds02::NUMERIC,
ds03::NUMERIC,
ds04::NUMERIC,
ds05::NUMERIC,
ds06::NUMERIC,
ds07::NUMERIC,
ds08::NUMERIC,
ds09::NUMERIC,
ds10::NUMERIC,
ds11::NUMERIC,
vip01::NUMERIC,
vip02::NUMERIC,
vip03::NUMERIC,
vip04::NUMERIC,
vip05::NUMERIC,
vip06::NUMERIC,
vip07::NUMERIC,
vip08::NUMERIC,
vip09::NUMERIC,
vip10::NUMERIC,
vip11::NUMERIC,
vip12::NUMERIC,
vip13::NUMERIC,
vip14::NUMERIC,
vip15::NUMERIC,
vip16::NUMERIC,
vip17::NUMERIC,
vip18::NUMERIC,
vip19::NUMERIC,
vip20::NUMERIC,
vip21::NUMERIC,
vip22::NUMERIC,
vip23::NUMERIC,
vip24::NUMERIC,
vip25::NUMERIC,
vip26::NUMERIC,
vip27::NUMERIC,
vip28::NUMERIC,
vip29::NUMERIC,
vip30::NUMERIC,
vip31::NUMERIC,
vip32::NUMERIC,
vip33::NUMERIC,
vip34::NUMERIC,
vip35::NUMERIC,
vip36::NUMERIC,
vip37::NUMERIC,
vip38::NUMERIC,
vip39::NUMERIC,
vip40::NUMERIC,
vip41::NUMERIC,
vip42::NUMERIC,
vip43::NUMERIC,
vip44::NUMERIC,
vip45::NUMERIC,
vip46::NUMERIC,
vip47::NUMERIC,
vip48::NUMERIC,
vip49::NUMERIC,
score_us::NUMERIC,
score_ai::NUMERIC,
score_ea::NUMERIC,
score_se::NUMERIC,
pr_us_comp::NUMERIC,
pr_ai_comp::NUMERIC,
pr_ea_comp::NUMERIC,
pr_se_comp::NUMERIC,
pr_us_int::NUMERIC,
pr_ai_int::NUMERIC,
pr_ea_int::NUMERIC,
pr_se_int::NUMERIC,
"GROUP" as "group"

FROM 
"public"."150924_data4screen-export_formatiert_V7_filter_4postgreSQL"


ORDER BY
applicant_id