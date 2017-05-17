set serveroutput on;
DECLARE
  nr int := 0;
  zodie_nume varchar2(20);
  startd varchar2(5);
  endd varchar2(5);
BEGIN
  DELETE FROM STUDENT.ZODIAC;
  INSERT INTO ZODIAC VALUES('BERBEC','21-03','20-04');
  INSERT INTO ZODIAC VALUES('TAUR','21-04','21-05');
  INSERT INTO ZODIAC VALUES('GEMENI','22-05','21-06');
  INSERT INTO ZODIAC VALUES('RAC','22-06','21-07');
  INSERT INTO ZODIAC VALUES('LEU','22-07','22-08');
  INSERT INTO ZODIAC VALUES('FECIOARA','23-08','22-09');
  INSERT INTO ZODIAC VALUES('BALANTA','23-09','22-10');
  INSERT INTO ZODIAC VALUES('SCORPION','23-10','21-11');
  INSERT INTO ZODIAC VALUES('SAGETATOR','22-11','21-12');
  INSERT INTO ZODIAC VALUES('CAPRICORN','22-12','19-01');
  INSERT INTO ZODIAC VALUES('VARSATOR','20-01','18-02');
  INSERT INTO ZODIAC VALUES('PESTI','19-02','20-03');
  
  SELECT count(id) INTO NR from utilizatori;
  for i in 1..12 LOOP
  
    SELECT zodie into zodie_nume from(
      select zodie,row_number() OVER (order by zodie) as rn from zodiac
    )
    WHERE rn = i;
    
    SELECT start_date into startd from(
      select start_date,row_number() OVER (order by zodie) as rn from zodiac
    )
    WHERE rn = i;
    
   SELECT end_date into endd from(
      select end_date,row_number() OVER (order by zodie) as rn from zodiac
    )
    WHERE rn = i; 
    
    IF (i!=3) THEN
      SELECT count(utilizatori.id) into nr from utilizatori
      WHERE DATA_NASTERE > TO_DATE('1997-'||startd,'yyyy-dd-mm') and
      DATA_NASTERE < TO_DATE('1997-'||endd,'yyyy-dd-mm');
    ELSIF (i=3) THEN
      SELECT count(utilizatori.id) into nr from utilizatori
      WHERE DATA_NASTERE > TO_DATE('1997-'||startd,'yyyy-dd-mm') and
      DATA_NASTERE < TO_DATE('1998-'||endd,'yyyy-dd-mm');
    END IF;
    DBMS_OUTPUT.PUT_LINE(zodie_nume||':'||' '||TO_CHAR(nr));
    
  END LOOP;
END;

