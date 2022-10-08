-- This script was generated by the Schema Diff utility in pgAdmin 4
-- For the circular dependencies, the order in which Schema Diff writes the objects is not very sophisticated
-- and may require manual changes to the script to ensure changes are applied in the correct order.
-- Please report an issue for any failure with the reproduction steps.
CREATE SCHEMA IF NOT EXISTS "internal" AUTHORIZATION "postgres";

COMMENT ON SCHEMA "internal" IS 'Non-public tables backing public API';

GRANT ALL PRIVILEGES ON SCHEMA internal TO supabase_auth_admin;

GRANT USAGE ON SCHEMA internal TO postgres, anon, authenticated, service_role, tokenauthed;

ALTER DEFAULT privileges IN SCHEMA api_auth GRANT ALL ON tables TO supabase_auth_admin;

ALTER DEFAULT privileges IN SCHEMA api_auth GRANT ALL ON functions TO supabase_auth_admin;

ALTER DEFAULT privileges IN SCHEMA api_auth GRANT ALL ON sequences TO supabase_auth_admin;

