CREATE TABLE "profiles"."individuals" (
  "id" uuid NOT NULL DEFAULT NULL, -- Generated by trigger
  "first_name" text NOT NULL CHECK (is_strlen (first_name, 1, 50) AND is_singleline (first_name)),
  "last_name" text NOT NULL CHECK (is_strlen (last_name, 1, 50) AND is_singleline (last_name)),
  "email" text CHECK (is_strlen (email, 3, 320) AND is_singleline (email)),
  "phone" text CHECK (is_strlen (phone, 5, 20) AND is_singleline (phone))
);

COMMENT ON COLUMN "profiles"."individuals"."id" IS 'Corresponds to "profiles"."profiles". Automatically generated on insertion';

ALTER TABLE "profiles"."individuals" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX individuals_pkey ON profiles.individuals USING btree (id);

ALTER TABLE "profiles"."individuals"
  ADD CONSTRAINT "individuals_pkey" PRIMARY KEY USING INDEX "individuals_pkey";

ALTER TABLE "profiles"."individuals"
  ADD CONSTRAINT "profile_individuals_id_fkey" FOREIGN KEY (id) REFERENCES profiles.profiles (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."individuals" validate CONSTRAINT "profile_individuals_id_fkey";

CREATE TRIGGER "profiles_individuals_create_trigger"
  BEFORE INSERT ON "profiles"."individuals"
  FOR EACH ROW
  EXECUTE PROCEDURE "profiles"."create_associated_profile" ();

CREATE TRIGGER "profiles_individuals_delete_associated_profile_trigger"
  AFTER DELETE ON "profiles"."individuals"
  FOR EACH ROW
  EXECUTE PROCEDURE "profiles"."delete_associated_profile" ();

