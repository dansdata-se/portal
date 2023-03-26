CREATE TABLE "profiles"."membership_titles" (
  "membership_id" bigint NOT NULL,
  UNIQUE (membership_id, language_code)
)
INHERITS (
  "profiles"."base_translations"
);

ALTER TABLE "profiles"."membership_titles" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX membership_titles_pkey ON profiles.membership_titles USING btree (translation_id);

ALTER TABLE "profiles"."membership_titles"
  ADD CONSTRAINT "membership_titles_pkey" PRIMARY KEY USING INDEX "membership_titles_pkey";

CREATE INDEX membership_titles_membership_id_idx ON profiles.membership_titles USING btree (membership_id);

ALTER TABLE "profiles"."membership_titles"
  ADD CONSTRAINT "membership_titles_membership_id_fkey" FOREIGN KEY (membership_id) REFERENCES profiles.organization_members (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."membership_titles" validate CONSTRAINT "membership_titles_membership_id_fkey";

ALTER TABLE "profiles"."membership_titles"
  ADD CONSTRAINT "membership_titles_text_check" CHECK (is_strlen (text, 1, 50) AND is_singleline (text));

