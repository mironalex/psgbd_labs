set serveroutput on;
DECLARE
   TYPE utilizatori_thing 
   IS TABLE OF utilizatori%ROWTYPE
      INDEX BY PLS_INTEGER;
   bulk_utilizatori utilizatori_thing ;
   
   nr int := 0;
BEGIN
   SELECT *
   BULK COLLECT INTO bulk_utilizatori
   FROM utilizatori;
     
   FOR i IN 1 .. bulk_utilizatori.COUNT LOOP
       if(substr(bulk_utilizatori(i).prenume,-1) = 'a') then 
        nr := nr + 1;
       END IF;
   END LOOP;
   
   DBMS_OUTPUT.PUT_LINE('Nr fete: ' || nr);
   
END process_all_rows;