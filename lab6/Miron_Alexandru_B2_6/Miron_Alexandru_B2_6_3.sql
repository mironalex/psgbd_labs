set serveroutput on;

DECLARE
TYPE persoana IS RECORD(
  nume varchar2(30),
  prenume varchar2(30)
);
TYPE colectie IS TABLE OF persoana
INDEX BY PLS_INTEGER;
individ1 persoana;
individ2 persoana;
persoane colectie;

PROCEDURE count_relevant(indivizi in colectie)
AS
  nr INTEGER;
  id_student INTEGER;
BEGIN
  nr := 0;
  FOR i in indivizi.first..indivizi.last LOOP
    SELECT id into id_student FROM USERS
    where name = (indivizi(i).prenume ||' '|| indivizi(i).nume);
    nr := nr + lab5_actions.getRelevancy(id_student);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(nr);
END;

BEGIN
  individ1.nume := 'Rosca';
  individ1.prenume := 'Valentin';
  
  individ2.nume := 'Miron';
  individ2.prenume := 'Alexandru';
  
  persoane(1) := individ1;
  persoane(2) := individ2;
  
  
  
  count_relevant(persoane);
END;
