CREATE TABLE "profiles"."profile_categories" (
  "id" bigserial,
  "profile_id" uuid NOT NULL,
  "category_id" text NOT NULL,
  UNIQUE (profile_id, category_id)
);

COMMENT ON TABLE "profiles"."profile_categories" IS 'Describes which categories this profile is related to.

Useful when performing searches to filter out unwanted categories.';

ALTER TABLE "profiles"."profile_categories" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX profile_categories_pkey ON profiles.profile_categories USING btree (id);

ALTER TABLE "profiles"."profile_categories"
  ADD CONSTRAINT "profile_categories_pkey" PRIMARY KEY USING INDEX "profile_categories_pkey";

CREATE INDEX profile_categories_profile_id_idx ON profiles.profile_categories USING btree (profile_id);

ALTER TABLE "profiles"."profile_categories"
  ADD CONSTRAINT "profile_categories_profile_id_fkey" FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."profile_categories" validate CONSTRAINT "profile_categories_profile_id_fkey";

CREATE INDEX profile_categories_category_id_idx ON profiles.profile_categories USING btree (category_id);

ALTER TABLE "profiles"."profile_categories"
  ADD CONSTRAINT "profile_categories_category_id_fkey" FOREIGN KEY (category_id) REFERENCES profiles.categories (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."profile_categories" validate CONSTRAINT "profile_categories_category_id_fkey";

