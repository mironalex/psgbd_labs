CREATE INDEX index_relevancy ON answers(user_id,solved);
/

set serveroutput on;

<<global>>
DECLARE
  name_max VARCHAR2(30) := 'nan';
  relevancy_max INTEGER := -1;
  current_q_id INTEGER;
  CURSOR questions_list IS
        SELECT distinct q.id FROM QUESTIONS q
        JOIN USERS u on q.user_id = u.id
        where u.USER_ROLE != 'admin'
        order by q.id;
        
      q_id INTEGER;
BEGIN
  
  OPEN questions_list;
  
  LOOP
    FETCH questions_list into global.current_q_id;
    EXIT WHEN questions_list%NOTFOUND;
    DECLARE
      relevancy INTEGER;
      name_stud VARCHAR2(30);
      
    BEGIN
      relevancy := lab5_actions.getRelevancy(global.current_q_id);
      
      
      select u.name into name_stud from questions q
      join users u on u.id = q.user_id
      where global.current_q_id = q.id;
      
      if relevancy > global.relevancy_max then
        global.relevancy_max := relevancy;
        global.name_max := name_stud;
      end if;
      SYS.DBMS_OUTPUT.PUT_LINE(TO_CHAR(global.current_q_id,'99999') || ' relevancy: ' || TO_CHAR(relevancy,'99999')); 
      EXCEPTION when NO_DATA_FOUND then
          relevancy := 0;
          
    END;
  END LOOP;
    SYS.DBMS_OUTPUT.PUT_LINE('Max relevancy achieved by ' || name_max || ' with relevancy: ' || TO_CHAR(global.relevancy_max));
END;