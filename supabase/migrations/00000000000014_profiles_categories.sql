CREATE TABLE "profiles"."categories" (
  "id" text NOT NULL CHECK (is_strlen (id, 1, 50) AND is_without_whitespace (id)),
  "organizations" boolean NOT NULL DEFAULT FALSE,
  "individuals" boolean NOT NULL DEFAULT FALSE,
  "venues" boolean NOT NULL DEFAULT FALSE,
  "created_at" timestamp with time zone NOT NULL DEFAULT (now() AT TIME ZONE 'utc'::text)
);

COMMENT ON COLUMN "profiles"."categories"."organizations" IS 'Whether the category can be used for an organization';

COMMENT ON COLUMN "profiles"."categories"."individuals" IS 'Whether the category can be used for an individual';

COMMENT ON COLUMN "profiles"."categories"."venues" IS 'Whether the category can be used for a venue';

ALTER TABLE "profiles"."categories" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX categories_pkey ON profiles.categories USING btree (id);

ALTER TABLE "profiles"."categories"
  ADD CONSTRAINT "categories_pkey" PRIMARY KEY USING INDEX "categories_pkey";

INSERT INTO "profiles"."categories" (
  id,
  organizations,
  individuals,
  venues)
VALUES (
  'performer',
  TRUE,
  TRUE,
  FALSE),
(
  'photographer',
  TRUE,
  TRUE,
  FALSE),
(
  'association',
  TRUE,
  FALSE,
  FALSE),
(
  'instructor',
  FALSE,
  TRUE,
  FALSE);

