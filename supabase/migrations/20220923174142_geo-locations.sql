CREATE EXTENSION IF NOT EXISTS "postgis" WITH SCHEMA "extensions";

CREATE TABLE IF NOT EXISTS internal.countries (
  code text NOT NULL CHECK (code = LOWER(code)),
  created_at timestamp with time zone NOT NULL DEFAULT (now() AT TIME ZONE 'utc'::text),
  CONSTRAINT countries_pkey PRIMARY KEY (code)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS internal.countries OWNER TO postgres;

ALTER TABLE IF EXISTS internal.countries ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS internal.country_translations (
  id bigserial,
  country_code text NOT NULL,
  language_code text NOT NULL,
  title text NOT NULL,
  CONSTRAINT country_translations_pkey PRIMARY KEY (id),
  CONSTRAINT country_translations_country_code_language_code_key UNIQUE (country_code, language_code),
  CONSTRAINT country_translations_country_code_fkey FOREIGN KEY (country_code) REFERENCES internal.countries (code) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT country_translations_language_code_fkey FOREIGN KEY (language_code) REFERENCES internal.languages (code) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
)
TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS country_translations_title_gin_idx ON internal.country_translations USING GIN (title extensions.gin_trgm_ops);

ALTER TABLE IF EXISTS internal.country_translations OWNER TO postgres;

ALTER TABLE IF EXISTS internal.country_translations ENABLE ROW LEVEL SECURITY;

COMMENT ON TABLE internal.country_translations IS 'Localized texts to describe a given country in a human-readable way';

CREATE TABLE IF NOT EXISTS internal.geo_locations (
  id bigserial,
  geom geometry(MultiPolygon, 4326) NOT NULL,
  municipality text NOT NULL,
  region text NOT NULL,
  country_code text NOT NULL,
  license text NOT NULL,
  updated_at timestamp with time zone NOT NULL DEFAULT (now() AT TIME ZONE 'utc'::text),
  CONSTRAINT geo_locations_pkey PRIMARY KEY (id),
  CONSTRAINT geo_locations_country_code_fkey FOREIGN KEY (country_code) REFERENCES internal.countries (code) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS internal.geo_locations OWNER TO postgres;

CREATE INDEX IF NOT EXISTS geo_locations_geom_geom_idx ON internal.geo_locations USING gist (geom) TABLESPACE pg_default;

CREATE TRIGGER geo_locations_moddatetime
  BEFORE UPDATE ON internal.geo_locations
  FOR EACH ROW
  EXECUTE FUNCTION extensions.moddatetime ('updated_at');

INSERT INTO internal.countries (
  code)
VALUES (
  'se'),
(
  'no');

INSERT INTO internal.country_translations (
  country_code,
  language_code,
  title)
VALUES (
  'se',
  'xx',
  'Sweden'),
(
  'se',
  'en',
  'Sweden'),
(
  'se',
  'sv',
  'Sverige'),
(
  'no',
  'xx',
  'Norway'),
(
  'no',
  'en',
  'Norway'),
(
  'no',
  'sv',
  'Norge');

