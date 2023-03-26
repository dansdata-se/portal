CREATE VIEW "profiles"."languages" AS (
  SELECT DISTINCT
    language_code
  FROM
    "profiles"."base_translations");

