set serveroutput on;
DECLARE
  id1 integer:=134;
  id2 integer:=137;
  questions1 integer;
  questions2 integer;
  solved1 integer;
  solved2 integer;
  name1 VARCHAR(50);
  name2 VARCHAR(50);
BEGIN
  SELECT name into name1 from users
  where id1 = id;
  
  SELECT name into name2 from users
  where id2 = id;
  
  SELECT count(id) into solved1 from ANSWERS
  where user_id = id1;
  
  SELECT count(id) into solved2 from ANSWERS
  where user_id = id2;
  
  SELECT count(id) into questions1 from QUESTIONS
  where user_id = id1;
  
  SELECT count(id) into questions2 from QUESTIONS
  where user_id = id2;
  
  IF questions1 > questions2 THEN
    DBMS_OUTPUT.PUT_LINE(name1 || ' a introdus la mai multe intrebari');
  ELSIF questions2 > questions1 THEN
    DBMS_OUTPUT.PUT_LINE(name2 || ' a introdus mai multe intrebari');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('amandoi au introdus acelasi numar de intrebari');
    IF solved1 > solved2 THEN
      DBMS_OUTPUT.PUT_LINE(name1 || ' a raspuns la mai multe intrebari');
    ELSIF solved2 > solved1 THEN
      DBMS_OUTPUT.PUT_LINE(name2 || ' a raspuns mai multe intrebari');
    ELSE 
      DBMS_OUTPUT.PUT_LINE('amandoi au raspuns la acelasi numar de intrebari');
    END IF;
  END IF;
END;