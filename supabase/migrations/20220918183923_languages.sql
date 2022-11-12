-- This script was generated by the Schema Diff utility in pgAdmin 4
-- For the circular dependencies, the order in which Schema Diff writes the objects is not very sophisticated
-- and may require manual changes to the script to ensure changes are applied in the correct order.
-- Please report an issue for any failure with the reproduction steps.
CREATE EXTENSION IF NOT EXISTS "pg_trgm" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "btree_gin" WITH SCHEMA "extensions";

CREATE TABLE IF NOT EXISTS internal.languages (
  code text COLLATE pg_catalog."default" NOT NULL CHECK (code = LOWER(code)),
  CONSTRAINT languages_pkey PRIMARY KEY (code)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS internal.languages OWNER TO postgres;

ALTER TABLE IF EXISTS internal.languages ENABLE ROW LEVEL SECURITY;

COMMENT ON TABLE internal.languages IS 'List of supported languages';

COMMENT ON COLUMN internal.languages.code IS 'ISO 639-1 language code (with `xx` reserved for "untranslatable" and/or fallback translations)';

CREATE TABLE IF NOT EXISTS internal.language_translations (
  id bigserial,
  language_code text COLLATE pg_catalog."default" NOT NULL,
  translation_code text COLLATE pg_catalog."default" NOT NULL,
  name text COLLATE pg_catalog."default" NOT NULL,
  CONSTRAINT language_translations_pkey PRIMARY KEY (id),
  CONSTRAINT language_translations_language_code_translation_code_key UNIQUE (language_code, translation_code),
  CONSTRAINT language_translations_language_code_fkey FOREIGN KEY (language_code) REFERENCES internal.languages (code) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT language_translations_translation_code_fkey FOREIGN KEY (translation_code) REFERENCES internal.languages (code) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS internal.language_translations OWNER TO postgres;

ALTER TABLE IF EXISTS internal.language_translations ENABLE ROW LEVEL SECURITY;

COMMENT ON TABLE internal.language_translations IS 'Language codes and their names in different languages';

COMMENT ON COLUMN internal.language_translations.language_code IS 'The code this row is naming';

COMMENT ON COLUMN internal.language_translations.translation_code IS 'The language in which the name is given';

CREATE INDEX IF NOT EXISTS language_translations_name_gin_idx ON internal.language_translations USING GIN (name extensions.gin_trgm_ops);

INSERT INTO internal.languages (
  code)
VALUES (
  'xx'),
(
  'en'),
(
  'sv');

INSERT INTO internal.language_translations (
  language_code,
  translation_code,
  name)
VALUES (
  'en',
  'xx',
  'English'),
(
  'en',
  'en',
  'English'),
(
  'en',
  'sv',
  'Engelska'),
(
  'sv',
  'xx',
  'Swedish'),
(
  'sv',
  'en',
  'Swedish'),
(
  'sv',
  'sv',
  'Svenska');

