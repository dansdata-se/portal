-- This script was generated by the Schema Diff utility in pgAdmin 4
-- For the circular dependencies, the order in which Schema Diff writes the objects is not very sophisticated
-- and may require manual changes to the script to ensure changes are applied in the correct order.
-- Please report an issue for any failure with the reproduction steps.
CREATE OR REPLACE FUNCTION public.delete_account ()
  RETURNS void
  LANGUAGE 'plpgsql'
  COST 100 VOLATILE
  SECURITY DEFINER PARALLEL UNSAFE
  AS $BODY$
BEGIN
  DELETE FROM auth.users
  WHERE id = auth.uid ();
END;
$BODY$;

COMMENT ON FUNCTION public.api_auth_log_request IS $$Delete the current user''s account.$$;

ALTER FUNCTION public.delete_account () OWNER TO postgres;

REVOKE EXECUTE ON FUNCTION public.delete_account () FROM PUBLIC;

REVOKE EXECUTE ON FUNCTION public.delete_account () FROM anon;

REVOKE EXECUTE ON FUNCTION public.delete_account () FROM tokenauthed;

GRANT EXECUTE ON FUNCTION public.delete_account () TO authenticated;

GRANT EXECUTE ON FUNCTION public.delete_account () TO postgres;

GRANT EXECUTE ON FUNCTION public.delete_account () TO service_role;

