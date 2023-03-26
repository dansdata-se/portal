CREATE TABLE "profiles"."image_formats" (
  "name" text NOT NULL CHECK (is_strlen (name, 1, 50) AND is_without_whitespace (name)),
  "aspect" text NOT NULL CHECK (aspect ~ '^\d+(?:\.\d+)?:\d+(?:\.\d+)?$'),
  "w_min" smallint NOT NULL DEFAULT '150' ::smallint,
  "w_max" smallint NOT NULL DEFAULT '4096' ::smallint,
  "w_rec" smallint NOT NULL CHECK (w_rec < w_max AND w_rec >= w_min),
  "h_min" smallint NOT NULL DEFAULT '150' ::smallint,
  "h_max" smallint NOT NULL DEFAULT '4096' ::smallint,
  "h_rec" smallint NOT NULL CHECK (h_rec < h_max AND h_rec >= h_min)
);

ALTER TABLE "profiles"."image_formats" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX image_formats_pkey ON profiles.image_formats USING btree (name);

ALTER TABLE "profiles"."image_formats"
  ADD CONSTRAINT "image_formats_pkey" PRIMARY KEY USING INDEX "image_formats_pkey";

INSERT INTO "profiles"."image_formats" (
  name,
  aspect,
  w_rec,
  h_rec)
VALUES (
  'square',
  '1:1',
  400,
  400),
(
  'cover',
  '1.91:1',
  1920,
  1005),
(
  'poster',
  '3:4',
  750,
  1000);

