set SERVEROUTPUT on;
CREATE OR REPLACE PROCEDURE printInfo(stud_id INTEGER) IS
  v_username VARCHAR2(50);
  v_lazy INTEGER;
  v_total_question_count INTEGER;
  v_relevant_question_count INTEGER;
  v_report_count INTEGER;
  v_invalid_report_count INTEGER;
  v_cursorId INTEGER;
  v_getString VARCHAR2(500);
  v_uselessNum INTEGER;
BEGIN
  v_cursorId := DBMS_SQL.OPEN_CURSOR;
  v_getString := 'SELECT * FROM U' || TO_CHAR(stud_id);

  DBMS_SQL.PARSE(v_cursorId,v_getString,DBMS_SQL.NATIVE);

  DBMS_SQL.DEFINE_COLUMN(v_CursorID,1,v_username,50);
  DBMS_SQL.DEFINE_COLUMN(v_CursorID,2,v_lazy);
  DBMS_SQL.DEFINE_COLUMN(v_CursorID,3,v_total_question_count);
  DBMS_SQL.DEFINE_COLUMN(v_CursorID,4,v_relevant_question_count);
  DBMS_SQL.DEFINE_COLUMN(v_CursorID,5,v_report_count);
  DBMS_SQL.DEFINE_COLUMN(v_CursorID,6,v_invalid_report_count);

  v_uselessNum := DBMS_SQL.EXECUTE(v_CursorID);

  LOOP
    IF DBMS_SQL.FETCH_ROWS(v_CursorID) = 0 THEN
      EXIT;
    END IF;
    DBMS_SQL.COLUMN_VALUE(v_CursorId,1,v_username);
    DBMS_SQL.COLUMN_VALUE(v_CursorId,2,v_lazy);
    DBMS_SQL.COLUMN_VALUE(v_CursorId,3,v_total_question_count);
    DBMS_SQL.COLUMN_VALUE(v_CursorId,4,v_relevant_question_count);
    DBMS_SQL.COLUMN_VALUE(v_CursorId,5,v_report_count);
    DBMS_SQL.COLUMN_VALUE(v_CursorId,6,v_invalid_report_count);

    DBMS_OUTPUT.PUT_LINE(v_username);
    DBMS_OUTPUT.PUT_LINE(v_lazy);
    DBMS_OUTPUT.PUT_LINE(v_total_question_count);
    DBMS_OUTPUT.PUT_LINE(v_relevant_question_count);
    DBMS_OUTPUT.PUT_LINE(v_report_count);
    DBMS_OUTPUT.PUT_LINE(v_invalid_report_count);
  END LOOP;
  DBMS_SQL.CLOSE_CURSOR(v_CursorID);

END printInfo;
/
BEGIN
  dbms_output.enable();
  printInfo(105);
END;