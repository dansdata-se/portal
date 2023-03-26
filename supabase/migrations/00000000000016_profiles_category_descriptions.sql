CREATE TABLE "profiles"."category_descriptions" (
  "category_id" text NOT NULL,
  UNIQUE (category_id, language_code)
)
INHERITS (
  "profiles"."base_translations"
);

ALTER TABLE "profiles"."category_descriptions" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX category_descriptions_pkey ON profiles.category_descriptions USING btree (translation_id);

ALTER TABLE "profiles"."category_descriptions"
  ADD CONSTRAINT "category_descriptions_pkey" PRIMARY KEY USING INDEX "category_descriptions_pkey";

CREATE INDEX category_descriptions_category_id_idx ON profiles.category_descriptions USING btree (category_id);

ALTER TABLE "profiles"."category_descriptions"
  ADD CONSTRAINT "category_descriptions_category_id_fkey" FOREIGN KEY (category_id) REFERENCES profiles.categories (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."category_descriptions" validate CONSTRAINT "category_descriptions_category_id_fkey";

INSERT INTO "profiles"."category_descriptions" (
  category_id,
  language_code,
  text)
VALUES (
  'performer',
  'en',
  'A group or individual performing music.'),
(
  'performer',
  'sv',
  'En grupp eller individ som spelar musik.'),
(
  'photographer',
  'en',
  'An individual or organization capturing photos and/or videos.'),
(
  'photographer',
  'sv',
  'En individ eller organisation som fotograferar eller videofilmar.'),
(
  'association',
  'en',
  'E.g. a local dance club (sv. "Förening").'),
(
  'association',
  'sv',
  'Ex. en lokal dansklubb.'),
(
  'instructor',
  'en',
  'An individual who teaches dance.'),
(
  'instructor',
  'sv',
  'En individ som lär ut dans.');

