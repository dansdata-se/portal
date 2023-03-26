CREATE TABLE "profiles"."profile_images" (
  "profile_id" uuid NOT NULL,
  UNIQUE (profile_id, format)
)
INHERITS (
  "profiles"."base_images"
);

ALTER TABLE "profiles"."profile_images" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX profile_images_pkey ON profiles.profile_images USING btree (image_id);

ALTER TABLE "profiles"."profile_images"
  ADD CONSTRAINT "profile_images_pkey" PRIMARY KEY USING INDEX "profile_images_pkey";

ALTER TABLE "profiles"."profile_images"
  ADD CONSTRAINT "profile_images_id_fkey" FOREIGN KEY (image_id) REFERENCES storage.objects (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."profile_images" validate CONSTRAINT "profile_images_id_fkey";

CREATE INDEX profile_images_profile_id_idx ON profiles.profile_images USING btree (profile_id);

ALTER TABLE "profiles"."profile_images"
  ADD CONSTRAINT "profile_images_profile_id_fkey" FOREIGN KEY (profile_id) REFERENCES profiles.profiles (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."profile_images" validate CONSTRAINT "profile_images_profile_id_fkey";

ALTER TABLE "profiles"."profile_images"
  ADD CONSTRAINT "profile_images_format_fkey" FOREIGN KEY (format) REFERENCES profiles.image_formats (name) ON DELETE RESTRICT NOT valid;

ALTER TABLE "profiles"."profile_images" validate CONSTRAINT "profile_images_format_fkey";

