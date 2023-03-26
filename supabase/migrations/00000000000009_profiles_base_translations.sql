CREATE TABLE "profiles"."base_translations" (
  "translation_id" bigserial,
  "language_code" text NOT NULL CHECK (length(language_code) = 2),
  "text" text NOT NULL CHECK (is_strlen (text, 1, 3000)),
  "created_at" timestamp with time zone NOT NULL DEFAULT (now() AT TIME ZONE 'utc'::text)
);

ALTER TABLE "profiles"."base_translations" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX base_translations_pkey ON profiles.base_translations USING btree (translation_id);

ALTER TABLE "profiles"."base_translations"
  ADD CONSTRAINT "base_translations_pkey" PRIMARY KEY USING INDEX "base_translations_pkey";

