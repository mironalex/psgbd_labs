CREATE OR REPLACE PACKAGE lab5_actions AS
  FUNCTION isNotLazy(stud_id INTEGER) RETURN INTEGER;
  FUNCTION getRelevancy(q_id INTEGER) RETURN INTEGER;
  FUNCTION getRelevancy(stud_name VARCHAR2) RETURN INTEGER;
END lab5_actions;
/
CREATE OR REPLACE PACKAGE body lab5_actions AS
  FUNCTION isNotLazy(stud_id INTEGER)
    RETURN INTEGER IS 
      status INTEGER;
      total_given INTEGER;
      answered INTEGER;
  BEGIN
    
    select count(id) into total_given from answers
    where user_id = stud_id;
  
    select count(id) into answered from answers
    where user_id = stud_id and solved = 1;
    
    if answered*2 < total_given then status := 0;
    else status := 1;
    end if;
    
    RETURN status;
  END isNotLazy;
  FUNCTION getRelevancy(q_id INTEGER) 
    RETURN INTEGER
    IS 
      relevancy INTEGER;
      answered_count INTEGER;
      asked_count INTEGER;

  BEGIN
    select count(user_id) into asked_count from answers ans
    where q_id = ans.QUESTION_ID;
    
    
    select count(user_id) into answered_count from answers ans
    where q_id = ans.question_id and LAB5_ACTIONS.isNotLazy(user_id) = 1 and solved = 1;
    
    if asked_count = 0 then asked_count := 1;
    end if;
    
    if answered_count / asked_count >= 0.3 and answered_count / asked_count <=0.9 then
      relevancy := asked_count;
    else
      relevancy := 0;
    end if;
    
    if asked_count < 20 then
      relevancy := 0;
    end if;
    
    RETURN relevancy;
  END getRelevancy;
  
  FUNCTION getRelevancy(stud_name VARCHAR2) 
    RETURN INTEGER
    IS 
      max_relevancy INTEGER := 0;
      current_relevancy INTEGER := 0;
      v_q_id INTEGER;
      v_u_id INTEGER;
      CURSOR questions_list IS
        SELECT id FROM questions where user_id = v_u_id;
  BEGIN
    SELECT id INTO v_u_id FROM users
    where stud_name = users.username;
    
    OPEN questions_list;
    
    
    LOOP 
      FETCH questions_list INTO v_q_id;
      
      EXIT WHEN questions_list%NOTFOUND;
      current_relevancy := lab5_actions.getRelevancy(v_q_id);
      if(current_relevancy > max_relevancy) then
        max_relevancy := current_relevancy;
      end if;
    END LOOP; 
    RETURN max_relevancy;
  END getRelevancy;
END lab5_actions;