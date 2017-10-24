DROP VIEW IF EXISTS q_v_q_vpi CASCADE;
CREATE VIEW q_v_q_vpi AS

SELECT 
subject_id,
vip_01::NUMERIC AS vip_01,
vip_02::NUMERIC AS vip_02,
vip_03::NUMERIC AS vip_03,
vip_04::NUMERIC AS vip_04,
vip_05::NUMERIC AS vip_05,
vip_06::NUMERIC AS vip_06,
vip_07::NUMERIC AS vip_07,
vip_08::NUMERIC AS vip_08,
vip_09::NUMERIC AS vip_09,
vip_10::NUMERIC AS vip_10,
vip_11::NUMERIC AS vip_11,
vip_12::NUMERIC AS vip_12,
vip_13::NUMERIC AS vip_13,
vip_14::NUMERIC AS vip_14,
vip_15::NUMERIC AS vip_15,
vip_16::NUMERIC AS vip_16,
vip_17::NUMERIC AS vip_17,
vip_18::NUMERIC AS vip_18,
vip_19::NUMERIC AS vip_19,
vip_20::NUMERIC AS vip_20,
vip_21::NUMERIC AS vip_21,
vip_22::NUMERIC AS vip_22,
vip_23::NUMERIC AS vip_23,
vip_24::NUMERIC AS vip_24,
vip_25::NUMERIC AS vip_25,
vip_26::NUMERIC AS vip_26,
vip_27::NUMERIC AS vip_27,
vip_28::NUMERIC AS vip_28,
vip_29::NUMERIC AS vip_29,
vip_30::NUMERIC AS vip_30,
vip_31::NUMERIC AS vip_31,
vip_32::NUMERIC AS vip_32,
vip_33::NUMERIC AS vip_33,
vip_34::NUMERIC AS vip_34,
vip_35::NUMERIC AS vip_35,
vip_36::NUMERIC AS vip_36,
vip_37::NUMERIC AS vip_37,
vip_38::NUMERIC AS vip_38,
vip_39::NUMERIC AS vip_39,
vip_40::NUMERIC AS vip_40,
vip_41::NUMERIC AS vip_41,
vip_42::NUMERIC AS vip_42,
vip_43::NUMERIC AS vip_43,
vip_44::NUMERIC AS vip_44,
vip_45::NUMERIC AS vip_45,
vip_46::NUMERIC AS vip_46,
vip_47::NUMERIC AS vip_47,
vip_48::NUMERIC AS vip_48,
vip_49::NUMERIC AS vip_49

FROM
public."150924_data4screen-export_formatiert_V7_filter_4postgreSQL"
INNER JOIN 
public.t_link_subject_applicant ON public.t_link_subject_applicant.applicant_id::VARCHAR = public."150924_data4screen-export_formatiert_V7_filter_4postgreSQL".id

ORDER BY
subject_id