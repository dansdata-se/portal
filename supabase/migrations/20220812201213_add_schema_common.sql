CREATE SCHEMA "common" AUTHORIZATION supabase_admin;

ALTER SCHEMA "common" OWNER TO "postgres";

GRANT USAGE ON SCHEMA common TO postgres, anon, authenticated, service_role, tokenauthed;

ALTER DEFAULT privileges IN SCHEMA common GRANT ALL ON tables TO postgres, anon, authenticated, service_role, tokenauthed;

ALTER DEFAULT privileges IN SCHEMA common GRANT ALL ON functions TO postgres, anon, authenticated, service_role, tokenauthed;

ALTER DEFAULT privileges IN SCHEMA common GRANT ALL ON sequences TO postgres, anon, authenticated, service_role, tokenauthed;

CREATE TABLE IF NOT EXISTS common.admins (
  user_id uuid NOT NULL,
  CONSTRAINT admins_pkey PRIMARY KEY (user_id),
  CONSTRAINT admins_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS common.admins OWNER TO postgres;

ALTER TABLE IF EXISTS common.admins ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION common.is_admin ()
  RETURNS boolean
  LANGUAGE plpgsql
  STABLE
  AS $BODY$
BEGIN
  RETURN EXISTS (
    SELECT
      *
    FROM
      common.admins
    WHERE
      user_id = auth.uid ());
END;
$BODY$;

ALTER FUNCTION "common"."is_admin" OWNER TO supabase_auth_admin;

GRANT EXECUTE ON FUNCTION common.is_admin TO PUBLIC;

CREATE TABLE IF NOT EXISTS common.languages (
  code text COLLATE pg_catalog."default" NOT NULL,
  name_en text COLLATE pg_catalog."default" NOT NULL,
  name_localized text COLLATE pg_catalog."default" NOT NULL,
  CONSTRAINT languages_pkey PRIMARY KEY (code))
TABLESPACE pg_default;

ALTER TABLE IF EXISTS common.languages OWNER TO postgres;

ALTER TABLE IF EXISTS common.languages ENABLE ROW LEVEL SECURITY;

INSERT INTO common.languages (
  code,
  name_en,
  name_localized)
VALUES (
  '',
  'fallback',
  'fallback');

INSERT INTO common.languages (
  code,
  name_en,
  name_localized)
VALUES (
  'en',
  'english',
  'english');

INSERT INTO common.languages (
  code,
  name_en,
  name_localized)
VALUES (
  'sv',
  'swedish',
  'svenska');

