CREATE TABLE "profiles"."profile_descriptions" (
  "profile_id" uuid NOT NULL,
  UNIQUE (profile_id, language_code)
)
INHERITS (
  "profiles"."base_translations"
);

ALTER TABLE "profiles"."profile_descriptions" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX profile_descriptions_pkey ON profiles.profile_descriptions USING btree (translation_id);

ALTER TABLE "profiles"."profile_descriptions"
  ADD CONSTRAINT "profile_descriptions_pkey" PRIMARY KEY USING INDEX "profile_descriptions_pkey";

CREATE INDEX profile_descriptions_profile_id_idx ON profiles.profile_descriptions USING btree (profile_id);

ALTER TABLE "profiles"."profile_descriptions"
  ADD CONSTRAINT "profile_descriptions_profile_id_fkey" FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."profile_descriptions" validate CONSTRAINT "profile_descriptions_profile_id_fkey";

