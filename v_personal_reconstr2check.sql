DROP VIEW IF EXISTS v_personal_reconstr2check CASCADE;
CREATE OR REPLACE VIEW v_personal_reconstr2check AS
 
SELECT t_subid2candid.subid,
    t_subid2candid.candid,
    "150924_resultssurvey219528_adjusted4postgre"."contact [forename]",
    "150924_resultssurvey219528_adjusted4postgre"."contact [surname]",
    "150924_resultssurvey219528_adjusted4postgre"."contact [email]",
    "150924_resultssurvey219528_adjusted4postgre"."contact [tele]"
   FROM ("150924_resultssurvey219528_adjusted4postgre"
   JOIN t_subid2candid ON ((t_subid2candid.candid = "150924_resultssurvey219528_adjusted4postgre".id)))
  ORDER BY t_subid2candid.candid;