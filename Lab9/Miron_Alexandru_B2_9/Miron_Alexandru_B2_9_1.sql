set SERVEROUTPUT on;
CREATE OR REPLACE PROCEDURE deleteTable(stud_id INTEGER) IS
  v_deleteTableString VARCHAR2(500);
  v_cursorId INTEGER;
  v_uselessNum INTEGER;
BEGIN
  v_cursorId := DBMS_SQL.OPEN_CURSOR;
  v_deleteTableString := 'DROP TABLE u' || TO_CHAR(stud_id);
  DBMS_SQL.PARSE(v_cursorId,v_deleteTableString,DBMS_SQL.NATIVE);
  v_uselessNum := DBMS_SQL.EXECUTE(v_cursorId);
END deleteTable;
CREATE OR REPLACE PROCEDURE createTable(stud_id INTEGER) IS
  v_cursorId INTEGER;
  v_username VARCHAR2(50);
  v_createTableString VARCHAR2(500);
  v_insertTableString VARCHAR2(500);
  v_uselessNum INTEGER;
  v_isLazy INTEGER;
  v_total_question_count INTEGER;
  v_relevant_question_count INTEGER;
  v_report_count INTEGER;
  v_invalid_report_count INTEGER;
  v_deleteTableString VARCHAR2(500);
  BEGIN
    v_cursorId := DBMS_SQL.OPEN_CURSOR;

    --deleteTable(stud_id);

    v_createTableString := 'CREATE TABLE u' || TO_CHAR(stud_id) || ' (
      username VARCHAR2(50),
      lazy integer,
      total_question_count integer,
      relevant_question_count integer,
      report_count integer,
      invalid_report_count integer
    )';

    DBMS_SQL.PARSE(v_cursorId,v_createTableString,DBMS_SQL.NATIVE);

    v_uselessNum := DBMS_SQL.EXECUTE(v_cursorId);

    v_isLazy := LAB5_ACTIONS.ISLAZY(stud_id);

    select users.USERNAME into v_username from users
    where id = stud_id;

    select count(q.id) INTO v_total_question_count from QUESTIONS q
    JOIN USERS u on u.id = q.user_id
    where q.user_id = stud_id;

    v_relevant_question_count := LAB5_ACTIONS.GETRELEVANCY(stud_id);

    select count(r.user_id) into v_report_count from reports r
    JOIN users u on u.id = r.USER_ID
    where u.id = stud_id;

    select count(r.id) into v_invalid_report_count from reports r
    JOIN users u on r.user_id = u.ID
    JOIN questions q on q.id = r.QUESTION_ID
    where q.REPORT_RESOLVED = 1 and u.id='118';


    v_insertTableString := 'insert into u' || TO_CHAR(stud_id)
                           || ' VALUES (:v_username, :v_isLazy, :v_total_question_count, :v_relevant_question_count, :v_report_count, :v_invalid_report_count)';
    DBMS_SQL.PARSE(v_cursorId,v_insertTableString,DBMS_SQL.NATIVE);
    DBMS_SQL.BIND_VARIABLE(v_cursorId,':v_username',v_username);
    DBMS_SQL.BIND_VARIABLE(v_cursorId,':v_isLazy',v_isLazy);
    DBMS_SQL.BIND_VARIABLE(v_cursorId,':v_total_question_count',v_total_question_count);
    DBMS_SQL.BIND_VARIABLE(v_cursorId,':v_relevant_question_count',v_relevant_question_count);
    DBMS_SQL.BIND_VARIABLE(v_cursorId,':v_report_count',v_report_count);
    DBMS_SQL.BIND_VARIABLE(v_cursorId,':v_invalid_report_count',v_invalid_report_count);

    v_uselessNum := DBMS_SQL.EXECUTE(v_cursorId);
    COMMIT;
  END createTable;
DECLARE
  ind integer;
  CURSOR bad_bois IS
    select users.id from USERS
    join reports on reports.user_id = users.ID
    where users.user_role = 'user'
    group by users.id, users.NAME
    order by count(REPORTS.id) desc;

  current_id integer;

BEGIN

  OPEN bad_bois;

  for ind in 1..10 LOOP
    FETCH bad_bois into current_id;
    EXIT WHEN bad_bois%NOTFOUND;
    createTable(current_id);
  END LOOP;
END;

CREATE OR REPLACE PROCEDURE DELTABLES IS
  ind integer;
  CURSOR bad_bois IS
    select users.id from USERS
    join reports on reports.user_id = users.ID
    where users.user_role = 'user'
    group by users.id, users.NAME
    order by count(REPORTS.id) desc;

  current_id integer;

BEGIN

  OPEN bad_bois;

  for ind in 1..10 LOOP
    FETCH bad_bois into current_id;
    EXIT WHEN bad_bois%NOTFOUND;
    deleteTable(current_id);
  END LOOP;
END;
/
BEGIN
  DELTABLES();
END;