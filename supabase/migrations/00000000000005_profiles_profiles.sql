CREATE TABLE "profiles"."profiles" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4 (),
  "created_at" timestamp with time zone NOT NULL DEFAULT (now() AT TIME ZONE 'utc'::text)
);

ALTER TABLE "profiles"."profiles" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX profiles_pkey ON profiles.profiles USING btree (id);

ALTER TABLE "profiles"."profiles"
  ADD CONSTRAINT "profiles_pkey" PRIMARY KEY USING INDEX "profiles_pkey";

-- As noted [here](https://github.com/orgs/supabase/discussions/7067#discussioncomment-3773245)
-- Supabase does not support image deletion via SQL at this time...
-- CREATE VIEW profile_images_dangling AS SELECT
CREATE OR REPLACE FUNCTION "profiles"."create_associated_profile" ()
  RETURNS TRIGGER
  AS $BODY$
DECLARE
  profile_id uuid;
BEGIN
  IF NEW.id IS NOT NULL THEN
    RAISE EXCEPTION 'Non-null id';
  END IF;
  INSERT INTO "profiles"."profiles" DEFAULT
  VALUES
  RETURNING
    id INTO profile_id;
  NEW.id = profile_id;
  RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "profiles"."delete_associated_profile" ()
  RETURNS TRIGGER
  AS $BODY$
DECLARE
  profile_id uuid;
BEGIN
  DELETE FROM "profiles"."profiles"
  WHERE id = OLD.id;
  RETURN OLD;
END;
$BODY$
LANGUAGE plpgsql;

