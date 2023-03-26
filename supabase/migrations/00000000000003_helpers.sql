CREATE FUNCTION is_without_whitespace (str text)
  RETURNS boolean
  AS $BODY$
BEGIN
  RETURN str !~ '\s';
END;
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION is_singleline (str text)
  RETURNS boolean
  AS $BODY$
BEGIN
  RETURN str NOT LIKE '%' || CHR(10) || '%';
END;
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION is_strlen (str text, min integer, max integer)
  RETURNS boolean
  AS $BODY$
BEGIN
  RETURN length(str) >= min
    AND length(str) < max;
END;
$BODY$
LANGUAGE plpgsql;

