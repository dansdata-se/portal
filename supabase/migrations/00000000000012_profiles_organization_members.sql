CREATE TABLE "profiles"."organization_members" (
  "id" bigserial,
  "organization_id" uuid NOT NULL,
  "individual_id" uuid NOT NULL,
  UNIQUE (organization_id, individual_id)
);

ALTER TABLE "profiles"."organization_members" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX organization_members_pkey ON profiles.organization_members USING btree (id);

ALTER TABLE "profiles"."organization_members"
  ADD CONSTRAINT "organization_members_pkey" PRIMARY KEY USING INDEX "organization_members_pkey";

CREATE INDEX organization_members_organization_id_idx ON profiles.organization_members USING btree (organization_id);

ALTER TABLE "profiles"."organization_members"
  ADD CONSTRAINT "organization_members_organization_id_fkey" FOREIGN KEY (organization_id) REFERENCES profiles.organizations (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."organization_members" validate CONSTRAINT "organization_members_organization_id_fkey";

CREATE INDEX organization_members_individual_id_idx ON profiles.organization_members USING btree (individual_id);

ALTER TABLE "profiles"."organization_members"
  ADD CONSTRAINT "organization_members_individual_id_fkey" FOREIGN KEY (individual_id) REFERENCES profiles.individuals (id) ON DELETE CASCADE NOT valid;

ALTER TABLE "profiles"."organization_members" validate CONSTRAINT "organization_members_individual_id_fkey";

