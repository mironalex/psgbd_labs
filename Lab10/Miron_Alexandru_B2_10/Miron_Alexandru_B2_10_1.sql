DECLARE
  current_object VARCHAR2(100);
  current_object2 USER_OBJECTS%ROWTYPE;
  CURSOR object_list IS
    SELECT *
    FROM USER_OBJECTS
    WHERE OBJECT_TYPE IN (
      'TABLE',
      'TRIGGER',
      'PROCEDURE',
      'FUNCTION',
      'PACKAGE',
      'VIEW');
BEGIN
  OPEN object_list;
  LOOP
    FETCH object_list into current_object2;
    EXIT WHEN object_list%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('NAME: ' || current_object2.object_name);
    DBMS_OUTPUT.PUT_LINE('TYPE: ' || current_object2.object_type);
    DBMS_OUTPUT.PUT_LINE(' ');
  END LOOP;
END;