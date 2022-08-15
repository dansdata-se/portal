CREATE SCHEMA "events" AUTHORIZATION supabase_admin;

ALTER SCHEMA "events" OWNER TO "postgres";

GRANT USAGE ON SCHEMA events TO postgres, anon, authenticated, service_role, tokenauthed;

ALTER DEFAULT privileges IN SCHEMA events GRANT ALL ON tables TO postgres, anon, authenticated, service_role, tokenauthed;

ALTER DEFAULT privileges IN SCHEMA events GRANT ALL ON functions TO postgres, anon, authenticated, service_role, tokenauthed;

ALTER DEFAULT privileges IN SCHEMA events GRANT ALL ON sequences TO postgres, anon, authenticated, service_role, tokenauthed;

CREATE TABLE IF NOT EXISTS events.events (
  id uuid NOT NULL DEFAULT gen_random_uuid (),
  -- No fkey in case the creator's account is deleted
  created_by uuid NOT NULL DEFAULT auth.uid (),
  created_at timestamp with time zone NOT NULL DEFAULT (now() AT TIME ZONE 'utc'::text),
  cancelled_at timestamp with time zone DEFAULT NULL,
  CONSTRAINT events_pkey PRIMARY KEY (id))
TABLESPACE pg_default;

ALTER TABLE IF EXISTS events.events OWNER TO postgres;

ALTER TABLE IF EXISTS events.events ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS events.organizers (
  user_id uuid NOT NULL,
  approved_at timestamp with time zone DEFAULT NULL,
  requested_at timestamp with time zone NOT NULL DEFAULT (now() AT TIME ZONE 'utc'::text),
  CONSTRAINT organizers_pkey PRIMARY KEY (user_id),
  CONSTRAINT organizers_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS events.organizers OWNER TO postgres;

ALTER TABLE IF EXISTS events.organizers ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS events.presentations (
  event_id uuid NOT NULL,
  lang text NOT NULL,
  title text NOT NULL,
  description text NOT NULL,
  CONSTRAINT presentations_pkey PRIMARY KEY (event_id, lang),
  CONSTRAINT presentations_lang_fkey FOREIGN KEY (lang) REFERENCES common.languages (code) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT presentations_event_id_fkey FOREIGN KEY (event_id) REFERENCES events.events (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS events.presentations OWNER TO postgres;

ALTER TABLE IF EXISTS events.presentations ENABLE ROW LEVEL SECURITY;

DROP TYPE IF EXISTS events.link_type;

CREATE TYPE events.link_type AS ENUM (
  'other',
  'website',
  'tickets',
  'facebook_page',
  'facebook_event',
  'instagram_page',
  'twitter_page'
);

ALTER TYPE events.link_type OWNER TO postgres;

CREATE TABLE IF NOT EXISTS events.links (
  id serial,
  event_id uuid NOT NULL,
  type events.link_type NOT NULL,
  url text NOT NULL,
  CONSTRAINT links_pkey PRIMARY KEY (id),
  CONSTRAINT links_event_id_fkey FOREIGN KEY (event_id) REFERENCES events.events (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS events.links OWNER TO postgres;

ALTER TABLE IF EXISTS events.links ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS events.tags (
  id serial,
  tag text NOT NULL CHECK (lower(tag) = tag),
  CONSTRAINT tags_pkey PRIMARY KEY (id))
TABLESPACE pg_default;

ALTER TABLE IF EXISTS events.tags OWNER TO postgres;

ALTER TABLE IF EXISTS events.tags ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS events.tag_descriptions (
  tag_id int NOT NULL,
  lang text NOT NULL,
  description text NOT NULL,
  CONSTRAINT tag_descriptions_pkey PRIMARY KEY (tag_id, lang),
  CONSTRAINT tag_descriptions_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES events.tags (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT tag_descriptions_lang_fkey FOREIGN KEY (lang) REFERENCES common.languages (code) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS events.tags OWNER TO postgres;

ALTER TABLE IF EXISTS events.tags ENABLE ROW LEVEL SECURITY;

INSERT INTO events.tags (
  tag)
VALUES (
  'pro'),
(
  'spf'),
(
  'skpf');

INSERT INTO events.tag_descriptions (
  tag_id,
  lang,
  description)
VALUES (
  1,
  '',
  'Swedish National Pensioners'' Organisation'),
(
  1,
  'en',
  'Swedish National Pensioners'' Organisation'),
(
  1,
  'sv',
  'Pensionärernas Riksorganisation'),
(
  2,
  '',
  'The Swedish Association for Senior Citizens'),
(
  2,
  'en',
  'The Swedish Association for Senior Citizens'),
(
  2,
  'sv',
  'Sveriges Pensionärsförbund'),
(
  3,
  '',
  'Svenska KommunalPensionärernas Förbund'),
(
  3,
  'sv',
  'Svenska KommunalPensionärernas Förbund');

CREATE TYPE profiles.association AS ENUM (
  'other',
  'organizer',
  'perfomer',
  'venue',
  'instructor',
  'photographer'
);

CREATE TABLE IF NOT EXISTS events.associations (
  id serial,
  event_id uuid NOT NULL,
  profile_id uuid NOT NULL,
  association profiles.association NOT NULL,
  CONSTRAINT associations_pkey PRIMARY KEY (id),
  CONSTRAINT associations_event_id_fkey FOREIGN KEY (event_id) REFERENCES events.events (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT associations_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT associations_uniq UNIQUE (event_id, profile_id, association))
TABLESPACE pg_default;

ALTER TABLE IF EXISTS events.associations OWNER TO postgres;

ALTER TABLE IF EXISTS events.associations ENABLE ROW LEVEL SECURITY;

