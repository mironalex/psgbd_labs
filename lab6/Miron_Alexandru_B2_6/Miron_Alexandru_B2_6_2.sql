DECLARE    
    sir_prenume persoane.prenume%type;
    
    type prenume_bulk
    IS TABLE OF persoane%ROWTYPE
      INDEX BY PLS_INTEGER;
    x prenume_bulk;
    nr INTEGER;
    ok INTEGER;
BEGIN
    nr := 0;
    SELECT * BULK COLLECT INTO x FROM persoane;
    FOR i in 1..x.COUNT LOOP
      ok := 0;
      FOR j in x(i).prenume.first..x(i).prenume.last LOOP
        if (instr(x(i).prenume(j),'u')>0) then
          ok := 1;
        END IF;
      END LOOP;
      if (ok = 1) then
        nr := nr+1;
        DBMS_OUTPUT.PUT(x(i).nume||' ');
        FOR j in x(i).prenume.first..x(i).prenume.last LOOP
          DBMS_OUTPUT.PUT(x(i).prenume(j)||' ');  
        END LOOP;
        SYS.DBMS_OUTPUT.NEW_LINE;
      end if;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Numar total: '||nr);
END;
