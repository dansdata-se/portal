CREATE TABLE "profiles"."category_names" (
  "category_id" text NOT NULL,
  UNIQUE (category_id, language_code)
)
INHERITS (
  "profiles"."base_translations"
);

ALTER TABLE "profiles"."category_names" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX category_names_pkey ON profiles.category_names USING btree (translation_id);

ALTER TABLE "profiles"."category_names"
  ADD CONSTRAINT "category_names_pkey" PRIMARY KEY USING INDEX "category_names_pkey";

CREATE INDEX category_names_category_id_idx ON profiles.category_names USING btree (category_id);

ALTER TABLE "profiles"."category_names"
  ADD CONSTRAINT "category_names_category_id_fkey" FOREIGN KEY (category_id) REFERENCES profiles.categories (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."category_names" validate CONSTRAINT "category_names_category_id_fkey";

ALTER TABLE "profiles"."category_names"
  ADD CONSTRAINT "category_names_text_check" CHECK (is_strlen (text, 1, 50) AND is_singleline (text));

INSERT INTO "profiles"."category_names" (
  category_id,
  language_code,
  text)
VALUES (
  'performer',
  'en',
  'Performer'),
(
  'performer',
  'sv',
  'Band/Artist'),
(
  'photographer',
  'en',
  'Photographer'),
(
  'photographer',
  'sv',
  'Fotograf'),
(
  'association',
  'en',
  'Association'),
(
  'association',
  'sv',
  'Förening'),
(
  'instructor',
  'en',
  'Instructor'),
(
  'instructor',
  'sv',
  'Instruktör');

