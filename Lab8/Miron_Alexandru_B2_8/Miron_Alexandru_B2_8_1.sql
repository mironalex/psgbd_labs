CREATE OR REPLACE TYPE rectangle AS OBJECT(
  width integer,
  height integer,
  CONSTRUCTOR FUNCTION rectangle(width integer, height integer) RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION rectangle(r rectangle) RETURN SELF AS RESULT,
  member procedure setValues(width integer, height integer),
  order member function measure(r rectangle) return integer,
  NOT FINAL member function getArea return integer,
  NOT FINAL member function getPerimeter return integer
  ) NOT FINAL;
/
CREATE OR REPLACE TYPE BODY rectangle AS
  CONSTRUCTOR FUNCTION rectangle(width integer, height integer) 
    RETURN SELF AS RESULT
  AS
  BEGIN
    SELF.width := width;
    SELF.height := height;
    RETURN;
  END;
  
  CONSTRUCTOR FUNCTION rectangle(r rectangle) 
    RETURN SELF AS RESULT
  AS
  BEGIN
    SELF.width := r.width;
    SELF.height := r.height;
    RETURN;
  END;
  
  member procedure setValues (width integer, height integer) IS
  BEGIN
    SELF.width := width;
    SELF.height := height;
  END setValues;
  
  ORDER MEMBER FUNCTION measure(r rectangle) return integer IS 
   BEGIN 
      IF(self.getArea()>r.getArea()) then 
         return(1); 
      ELSE 
         return(-1); 
      END IF; 
   END measure;
  
  member function getPerimeter RETURN integer 
  IS
  BEGIN
    RETURN (2*(SELF.width+SELF.height));
  END getPerimeter;
  
  member function getArea RETURN integer 
  IS
  BEGIN
    RETURN (SELF.width*SELF.height);
  END getArea;
END;
/
CREATE OR REPLACE TYPE square UNDER rectangle(
  member procedure setValues(side integer),
  OVERRIDING MEMBER FUNCTION getPerimeter return integer,
  OVERRIDING MEMBER FUNCTION getArea return integer
);
/
CREATE OR REPLACE TYPE BODY square AS
  
  member procedure setValues(side integer) IS
  BEGIN
    SELF.width := side;
    SELF.height := side;
  END setValues;
  
  OVERRIDING MEMBER FUNCTION getPerimeter return integer IS
  BEGIN
    RETURN (4*SELF.width);
  END getPerimeter;
  
  OVERRIDING MEMBER FUNCTION getArea return integer IS
  BEGIN
    RETURN (SELF.width*SELF.width);
  END getArea;
END;
/
set serveroutput on;;
DECLARE
  r1 rectangle;
  r2 rectangle;
  r3 rectangle;
  s square;
  a1 integer;
  a2 integer;
  a3 integer;
BEGIN
  s := square(5,5);
  s.setValues(10);
  r1 := rectangle(10,5);
  r2 := rectangle(2,3);
  r3 := rectangle(r2);
  INSERT INTO rectangles(obj,area) VALUES (r1,r1.getArea);
  INSERT INTO rectangles(obj,area) VALUES (r2,r2.getArea);
  INSERT INTO rectangles(obj,area) VALUES (r3,r3.getArea);
  DBMS_OUTPUT.PUT_LINE(s.getArea);
END;
/
SELECT * FROM RECTANGLES
ORDER BY obj;