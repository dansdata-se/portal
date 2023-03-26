CREATE TABLE "profiles"."profile_links" (
  "id" bigserial,
  "profile_id" uuid NOT NULL,
  "url" text NOT NULL CHECK (is_strlen (url, 10, 500) AND is_singleline (url) AND starts_with (url, 'http')),
  UNIQUE (profile_id, url)
);

ALTER TABLE "profiles"."profile_links" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX profile_links_pkey ON profiles.profile_links USING btree (id);

ALTER TABLE "profiles"."profile_links"
  ADD CONSTRAINT "profile_links_pkey" PRIMARY KEY USING INDEX "profile_links_pkey";

CREATE INDEX profile_links_profile_id_idx ON profiles.profile_links USING btree (profile_id);

ALTER TABLE "profiles"."profile_links"
  ADD CONSTRAINT "profile_links_profile_id_fkey" FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."profile_links" validate CONSTRAINT "profile_links_profile_id_fkey";

