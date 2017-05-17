set serveroutput on;
DECLARE
vizibil integer:=1;
BEGIN
  DECLARE
  vizibil integer:=2;
  BEGIN
    DECLARE
    vizibil integer:=3;
    BEGIN
    DBMS_OUTPUT.PUT_LINE(vizibil);
    END;
  DBMS_OUTPUT.PUT_LINE(vizibil);
  END;
  DBMS_OUTPUT.PUT_LINE(vizibil);
END;