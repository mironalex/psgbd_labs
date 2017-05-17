set SERVEROUTPUT ON;
DECLARE
  type arr2 is varray(5) of varchar2(20);
  
  id_student utilizatori.id%TYPE;
  nume utilizatori.nume%TYPE;
  prenume utilizatori.nume%TYPE;
  prenume2 utilizatori.nume%TYPE;
  data_nastere UTILIZATORI.DATA_NASTERE%TYPE;
  telefon UTILIZATORI.TELEFON%TYPE;
  mail UTILIZATORI.ADRESA_EMAIL%TYPE;
  emailNr int := 0;
  randNr int :=0;
  emailProvider arr2 := arr2('@gmail.com', '@yahoo.co.uk', '@info.uaic.ro', '@gmail.co.uk', '@yahoo.com');
  prefixTelefonic arr2 := arr2('072','074','076','073','075');
  doilea int := 0;
BEGIN
  DELETE FROM UTILIZATORI;
  for i in 4..500 LOOP
    id_student := i;
    
    randNr := DBMS_RANDOM.VALUE(4,300);
    
    SELECT (SUBSTR(name,INSTR(name,' ',1,1)+1)) INTO nume FROM (
      SELECT name, row_number() over (ORDER BY id) as rn from users
    )
    WHERE rn = randNr;
    
    randNr := DBMS_RANDOM.VALUE(4,300);
    
    SELECT (SUBSTR(name,0,INSTR(name,' ',1,1)-1)) INTO prenume FROM (
        SELECT name, row_number() over (ORDER BY id) as rn from users
      )
      WHERE rn = randNr;
      
      doilea := DBMS_RANDOM.VALUE(1,10);
       
      if (doilea = 2) THEN
        randNr := DBMS_RANDOM.VALUE(4,300);
      
      IF(SUBSTR(prenume,-1)='a') THEN
        prenume2 := ' ';
        WHILE (SUBSTR(prenume2,-1)!='a') LOOP
          randNr := DBMS_RANDOM.VALUE(4,300);
          SELECT (SUBSTR(name,0,INSTR(name,' ',1,1)-1)) INTO prenume2 FROM (
            SELECT name, row_number() over (ORDER BY id) as rn from users
          )
          WHERE rn = randNr;
        END LOOP;
        prenume := prenume || ' ' || prenume2;
      END IF;
      
      IF(SUBSTR(prenume,-1)!='a') THEN
        prenume2 := 'a';
        WHILE (SUBSTR(prenume2,-1)='a') LOOP
          randNr := DBMS_RANDOM.VALUE(4,300);
          SELECT (SUBSTR(name,0,INSTR(name,' ',1,1)-1)) INTO prenume2 FROM (
            SELECT name, row_number() over (ORDER BY id) as rn from users
          )
          WHERE rn = randNr;
        END LOOP;
        prenume:= prenume || ' ' || prenume2;
      END IF;
    END IF;
    data_nastere:= TO_DATE('1997-01-01', 'yyyy-mm-dd') + DBMS_RANDOM.VALUE(0,364);
    
    emailNr:= DBMS_RANDOM.VALUE(1,999);
    mail := LOWER(nume|| '.' ||prenume || TO_CHAR(emailNr) || emailProvider(DBMS_RANDOM.VALUE(1,5)));
    
    randNr := DBMS_RANDOM.VALUE(1000000,9999999);
    telefon := prefixTelefonic(DBMS_RANDOM.VALUE(1,5)) || TO_CHAR(randNr);
    
    IF(instr(nume,'test',1,1)=0 and prenume is not NULL) THEN
      INSERT INTO UTILIZATORI VALUES(id_student,nume,prenume,data_nastere,telefon,mail);
    END IF;
  
  END LOOP;
END;