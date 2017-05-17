set serveroutput on;
DECLARE
      v_secv VARCHAR2(50) ;
      v_count INTEGER;
      v_rand_poz INTEGER;
      v_rand_id users.id%TYPE;
      v_rand_prenume users.name%TYPE;
      v_rand_nume users.name%TYPE;
      v_rand_asked_count INTEGER; 
BEGIN
      v_secv := '&input';
        SELECT count(id) INTO v_count FROM users
        WHERE NAME like  '%'||v_secv||'%'
        ORDER BY ID;
        
      v_rand_poz := DBMS_RANDOM.VALUE(1,v_count);
        
        DBMS_OUTPUT.PUT_LINE('Random Position: ' || v_rand_poz);
        
        SELECT ID into v_rand_id FROM (
          SELECT ID, row_number() OVER (ORDER BY ID) as RN FROM(
           SELECT * FROM users
           WHERE NAME like '%'||v_secv||'%'
          )
        ) WHERE RN = v_rand_poz;

        SELECT UPPER(substr(NAME,1,instr(NAME,' '))) INTO v_rand_prenume FROM users
        WHERE ID = v_rand_id;
        
        SELECT INITCAP(substr(NAME,instr(NAME,' ')+1)) INTO v_rand_nume FROM USERS
        where ID = v_rand_id;
      
        SELECT count(ID) into v_rand_asked_count FROM QUESTIONS 
        WHERE user_id = v_rand_id and reported < 5;
      
      DBMS_OUTPUT.PUT_LINE('ID: ' || v_rand_id);
      DBMS_OUTPUT.PUT_LINE('NUME: ' || v_rand_nume);
      DBMS_OUTPUT.PUT_LINE('PRENUME: ' || v_rand_prenume);
      DBMS_OUTPUT.PUT_LINE('NR INTREBARI: ' || v_rand_asked_count);      
END;
