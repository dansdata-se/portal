CREATE SCHEMA "profiles" AUTHORIZATION supabase_admin;

ALTER SCHEMA "profiles" OWNER TO "postgres";

GRANT USAGE ON SCHEMA profiles TO postgres, anon, authenticated, service_role, tokenauthed;

ALTER DEFAULT privileges IN SCHEMA profiles GRANT ALL ON tables TO postgres, anon, authenticated, service_role, tokenauthed;

ALTER DEFAULT privileges IN SCHEMA profiles GRANT ALL ON functions TO postgres, anon, authenticated, service_role, tokenauthed;

ALTER DEFAULT privileges IN SCHEMA profiles GRANT ALL ON sequences TO postgres, anon, authenticated, service_role, tokenauthed;

CREATE TABLE IF NOT EXISTS profiles.profiles (
  id uuid NOT NULL DEFAULT gen_random_uuid (),
  CONSTRAINT profiles_pkey PRIMARY KEY (id))
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.profiles OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.profiles ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS profiles.editors (
  user_id uuid NOT NULL,
  profile_id uuid NOT NULL,
  approved_at timestamp with time zone DEFAULT NULL,
  requested_at timestamp with time zone NOT NULL DEFAULT (now() AT TIME ZONE 'utc'::text),
  CONSTRAINT editors_pkey PRIMARY KEY (user_id, profile_id),
  CONSTRAINT editors_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT editors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.editors OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.editors ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS profiles.presentations (
  profile_id uuid NOT NULL,
  lang text NOT NULL,
  name text NOT NULL,
  description text NOT NULL,
  CONSTRAINT presentations_pkey PRIMARY KEY (profile_id, lang),
  CONSTRAINT presentations_lang_fkey FOREIGN KEY (lang) REFERENCES common.languages (code) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT presentations_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.presentations OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.presentations ENABLE ROW LEVEL SECURITY;

DROP TYPE IF EXISTS profiles.link_type;

CREATE TYPE profiles.link_type AS ENUM (
  'other',
  'website',
  'webshop',
  'facebook',
  'instagram',
  'twitter',
  'youtube',
  'tiktok',
  'spotify'
);

ALTER TYPE profiles.link_type OWNER TO postgres;

CREATE TABLE IF NOT EXISTS profiles.links (
  id serial,
  profile_id uuid NOT NULL,
  type profiles.link_type NOT NULL,
  url text NOT NULL,
  CONSTRAINT links_pkey PRIMARY KEY (id),
  CONSTRAINT links_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.links OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.links ENABLE ROW LEVEL SECURITY;

DROP TYPE IF EXISTS profiles.contact_type;

CREATE TYPE profiles.contact_type AS ENUM (
  'other',
  'email',
  'phone'
);

ALTER TYPE profiles.contact_type OWNER TO postgres;

CREATE TABLE IF NOT EXISTS profiles.contact_details (
  id serial,
  profile_id uuid NOT NULL,
  type profiles.contact_type NOT NULL,
  value text NOT NULL,
  CONSTRAINT contact_details_pkey PRIMARY KEY (id),
  CONSTRAINT contact_details_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT contact_details_profile_id_type_idx UNIQUE (profile_id, type))
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.contact_details OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.contact_details ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS profiles.individuals (
  profile_id uuid NOT NULL,
  CONSTRAINT individuals_pkey PRIMARY KEY (profile_id),
  CONSTRAINT individuals_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.individuals OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.individuals ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS profiles.bands (
  profile_id uuid NOT NULL,
  CONSTRAINT bands_pkey PRIMARY KEY (profile_id),
  CONSTRAINT bands_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.bands OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.bands ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS profiles.band_members (
  id serial,
  band_id uuid NOT NULL,
  individual_id uuid NOT NULL,
  CONSTRAINT band_members_pkey PRIMARY KEY (id),
  CONSTRAINT band_members_band_id_fkey FOREIGN KEY (band_id) REFERENCES profiles.bands (profile_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT band_members_individual_id_fkey FOREIGN KEY (individual_id) REFERENCES profiles.individuals (profile_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT band_members_band_id_individual_id_idx UNIQUE (band_id, individual_id))
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.band_members OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.band_members ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS profiles.band_member_roles (
  id integer NOT NULL,
  lang text NOT NULL,
  role text NOT NULL,
  CONSTRAINT band_member_roles_pkey PRIMARY KEY (id),
  CONSTRAINT band_member_roles_id_fkey FOREIGN KEY (id) REFERENCES profiles.band_members (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT band_member_roles_lang_fkey FOREIGN KEY (lang) REFERENCES common.languages (code) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.band_member_roles OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.band_member_roles ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS profiles.organizations (
  profile_id uuid NOT NULL,
  parent_org_id uuid,
  CONSTRAINT organizations_pkey PRIMARY KEY (profile_id),
  CONSTRAINT organizations_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT organizations_parent_org_id_fkey FOREIGN KEY (parent_org_id) REFERENCES profiles.organizations (profile_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE SET NULL)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.organizations OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.organizations ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS profiles.organization_members (
  id serial,
  org_id uuid NOT NULL,
  individual_id uuid NOT NULL,
  CONSTRAINT organization_members_pkey PRIMARY KEY (id),
  CONSTRAINT organization_members_individual_id_fkey FOREIGN KEY (individual_id) REFERENCES profiles.individuals (profile_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT organization_members_org_id_fkey FOREIGN KEY (org_id) REFERENCES profiles.organizations (profile_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT organization_members_org_id_individual_id_idx UNIQUE (org_id, individual_id))
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.organization_members OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.organization_members ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS profiles.organization_member_roles (
  id integer NOT NULL,
  lang text NOT NULL,
  role text NOT NULL,
  CONSTRAINT organization_member_roles_pkey PRIMARY KEY (id),
  CONSTRAINT organization_member_roles_id_fkey FOREIGN KEY (id) REFERENCES profiles.organization_members (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT organization_member_roles_lang_fkey FOREIGN KEY (lang) REFERENCES common.languages (code) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.organization_member_roles OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.organization_member_roles ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS profiles.venues (
  profile_id uuid NOT NULL,
  parent_venue_id uuid,
  CONSTRAINT venues_pkey PRIMARY KEY (profile_id),
  CONSTRAINT venues_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT venues_parent_venue_id_fkey FOREIGN KEY (parent_venue_id) REFERENCES profiles.venues (profile_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE SET NULL)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS profiles.venues OWNER TO postgres;

ALTER TABLE IF EXISTS profiles.venues ENABLE ROW LEVEL SECURITY;

