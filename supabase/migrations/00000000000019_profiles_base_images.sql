CREATE TABLE "profiles"."base_images" (
  "image_id" uuid NOT NULL,
  "format" text NOT NULL
);

ALTER TABLE "profiles"."base_images" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX base_images_pkey ON profiles.base_images USING btree (image_id);

ALTER TABLE "profiles"."base_images"
  ADD CONSTRAINT "base_images_pkey" PRIMARY KEY USING INDEX "base_images_pkey";

ALTER TABLE "profiles"."base_images"
  ADD CONSTRAINT "base_images_image_id_fkey" FOREIGN KEY (image_id) REFERENCES storage.objects (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."base_images" validate CONSTRAINT "base_images_image_id_fkey";

ALTER TABLE "profiles"."base_images"
  ADD CONSTRAINT "base_images_format_fkey" FOREIGN KEY (format) REFERENCES profiles.image_formats (name) ON DELETE RESTRICT NOT valid;

ALTER TABLE "profiles"."base_images" validate CONSTRAINT "base_images_format_fkey";

-- TODO: INSERT and DELETE triggers on storage.objects?
