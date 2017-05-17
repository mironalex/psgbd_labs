set serveroutput on;
DECLARE
  TYPE arr is varray(5) of INTEGER;
  Type MyMat IS TABLE of NUMBER INDEX BY PLS_INTEGER;
  mat1 MyMat;
  mat2 MyMat;
  rez MyMat;
  x integer;
  n1 integer;
  n2 integer;
  m1 integer;
  m2 integer;
  n3 integer;
  m3 integer;
  lg integer;
  lengths2 arr := arr(0,0,0,0,0);
  
PROCEDURE print_matrix (mat MyMat, l1 integer, c1 integer)
AS
  lengths arr :=arr(0,0,0,0,0);
  x integer;
  lg integer;
BEGIN
  
  for i IN 0..(l1-1) LOOP
    for j IN 0..(c1-1) LOOP
      x := mat(i*c1+j);
      lg := 0;
      while (x > 0) loop
        lg := lg +1;
        x := floor(x/10);
      END LOOP;
      if(lg > lengths(j+1)) then
        lengths(j+1) := lg;
      END IF;
    END LOOP;
  END LOOP;
  
  for i IN 0..(l1-1) LOOP
    for j IN 0..(c1-1) LOOP
      x := mat(i*c1+j);
      lg := 0;
      
      if (x = 0) then
        lg := 1;
      END IF;
      
      while (x > 0) loop
        lg := lg+1;
        x := floor(x/10);
      END LOOP;
      for k IN lg+1..lengths(j+1) LOOP
        DBMS_OUTPUT.PUT(' ');
      END LOOP;
      DBMS_OUTPUT.PUT(mat(i*c1+j)||' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
  END LOOP;
  DBMS_OUTPUT.NEW_LINE;
END;

begin
  n1 := DBMS_RANDOM.VALUE(2,5);
  m1 := DBMS_RANDOM.VALUE(2,5);
  n2 := m1;
  m2 := DBMS_RANDOM.VALUE(2,5);
  n3 := n1;
  m3 := m2;
  
  for i IN 0..(n1*m1-1) LOOP
    x := DBMS_RANDOM.VALUE(0,30);
    mat1(i) := x;
  END LOOP;
  
  print_matrix(mat1,n1,m1);
  
  for i IN 0..(n2*m2-1) LOOP
    x := DBMS_RANDOM.VALUE(0,30);
    mat2(i) := x;
  END LOOP;
  
  print_matrix(mat2,n2,m2);
  
  for i IN 0..(n3-1) LOOP
    for j IN 0..(m3-1) LOOP
      x := 0;
      for k IN 0..(m1-1) LOOP
        x := x + (mat1(i*m1+k) * mat2(k*m2+j));
      END LOOP;
      rez(i*m3+j):=x;
    END LOOP;
  END LOOP;
  
  print_matrix(rez,n3,m3);
  
end;