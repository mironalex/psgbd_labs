CREATE TABLE QUESTIONS_LAB7
  AS (SELECT * FROM QUESTIONS WHERE 1 = 2);
ALTER TABLE QUESTIONS_LAB7
ADD CONSTRAINT id_unique UNIQUE (ID);
/
CREATE OR REPLACE FUNCTION insert_question(q_id INTEGER) RETURN INTEGER 
AS
    irrelevant exception;
    PRAGMA EXCEPTION_INIT( irrelevant, -20001);
    
  BEGIN
    if LAB5_ACTIONS.getRelevancy(q_id) = 0 then
      RAISE irrelevant;
    end if;
  
  insert into questions_lab7
    select * from questions WHERE id = q_id;

  return 1;
  EXCEPTION
    WHEN irrelevant then
      return 0;
    WHEN DUP_VAL_ON_INDEX THEN
      return 0;
    WHEN NO_DATA_FOUND THEN
      return 0;
  
  END insert_question;
/
CREATE OR REPLACE PROCEDURE insert_questions(q_count integer) AS
  indx integer;
  current_question integer;
BEGIN  
  indx := 1;
  WHILE indx <= q_count
  LOOP
    current_question:= DBMS_RANDOM.VALUE(17,16400);
    indx := indx + insert_question(current_question);
  END LOOP;
END insert_questions;
/
DECLARE 
  result integer;
BEGIN
  insert_questions(1000);
  COMMIT;
  DBMS_OUTPUT.PUT_LINE(result);
END;