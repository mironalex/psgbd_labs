DECLARE
  type arr is varray(200) of varchar2(20);
  
  commonNames arr := arr('James','Mary','John','Patricia','Robert',
  'Jennifer','Michael','Elizabeth','William','Linda','David','Barbara',
  'Richard','Susan','Joseph','Jessica','Thomas','Margaret','Charles',
  'Sarah','Christopher','Karen','Daniel','Nancy','Matthew','Betty',
  'Anthony','Dorothy','Donald','Lisa','Mark','Sandra','Paul','Ashley',
  'Steven','Kimberly','George','Donna','Kenneth','Carol','Andrew','Michelle',
  'Joshua','Emily','Edward','Helen','Brian','Amanda','Kevin','Melissa','Ronald',
  'Deborah','Timothy','Stephanie','Jason','Laura','Jeffrey','Rebecca','Ryan',
  'Sharon','Gary','Cynthia','Jacob','Kathleen','Nicholas','Shirley','Eric',
  'Amy','Stephen','Anna','Jonathan','Angela','Larry','Ruth','Scott','Brenda',
  'Frank','Pamela','Justin','Virginia','Brandon','Katherine','Raymond','Nicole',
  'Gregory','Catherine','Samuel','Christine','Benjamin','Samantha','Patrick',
  'Debra','Jack','Janet','Alexander','Carolyn','Dennis','Rachel','Jerry',
  'Heather','Tyler','Maria','Aaron','Diane','Henry','Emma','Douglas','Julie',
  'Peter','Joyce','Jose','Frances','Adam','Evelyn','Zachary','Joan','Walter',
  'Christina','Nathan','Kelly','Harold','Martha','Kyle','Lauren','Carl',
  'Victoria','Arthur','Judith','Gerald','Cheryl','Roger','Megan','Keith',
  'Alice','Jeremy','Ann','Lawrence','Jean','Terry','Doris','Sean','Andrea',
  'Albert','Marie','Joe','Kathryn','Christian','Jacqueline','Austin','Gloria',
  'Willie','Teresa','Jesse','Hannah','Ethan','Sara','Billy','Janice','Bruce',
  'Julia','Bryan','Olivia','Ralph','Grace','Roy','Rose','Jordan','Theresa',
  'Eugene','Judy','Wayne','Beverly','Louis','Denise','Dylan','Marilyn','Alan',
  'Amber','Juan','Danielle','Noah','Brittany','Russell','Madison','Harry','Diana',
  'Randy','Jane','Philip','Lori','Vincent','Mildred','Gabriel','Tiffany','Bobby',
  'Natalie','Johnny','Abigail','Howard','Kathy');
  type arr2 is varray(5) of varchar2(20);
  semne arr2 := arr2('.', '_', '?', '-', '!');
  emailProvider arr2 := arr2('@yahoo.com', '@gmail.com', '@hotmail.com', '@info.uaic.ro', '@uaic.ro');
  firstNameNr int := 0;
  secondNameNr int := 0;
  idNr int := 0;
  semnNr int := 0;
  emailNr int := 0;
  
  nrNames int := 200;
  display_name USERS.DISPLAY_NAME%TYPE;
  user_name USERS.USERNAME%TYPE;
  email USERS.EMAIL%TYPE;
  
  zizi DATE;
  scadere int;
  data_created DATE;
  
BEGIN
  for i in 1..100000 LOOP
    SELECT DBMS_RANDOM.VALUE(1,nrNames) into firstNameNr FROM DUAL;
    SELECT DBMS_RANDOM.VALUE(1,nrNames) into secondNameNr FROM DUAL;
    SELECT DBMS_RANDOM.VALUE(0,999999) into idNr FROM DUAL;
    SELECT DBMS_RANDOM.VALUE(1,5) into semnNr FROM DUAL;
    SELECT DBMS_RANDOM.VALUE(1,5) into emailNr FROM DUAL;
    
    zizi := current_timestamp;
    
    SELECT DBMS_RANDOM.VALUE(0,3000) into scadere FROM DUAL;
    
    display_name := commonNames(firstNameNr) || ' ' || commonNames(secondNameNr);
    user_name := commonNames(firstNameNr) || semne(semnNr) || commonNames(secondNameNr) || idNr;
    
    
    
    SELECT DBMS_RANDOM.VALUE(0,999999) into idNr FROM DUAL;
    
    email := commonNames(firstNameNr) || '.' || commonNames(secondNameNr) || idNr || emailProvider(emailNr);
    
    data_created := TO_DATE(zizi - scadere, 'dd/mm/yyyy');
     
    INSERT INTO USERS VALUES(user_name, display_name, email, data_created, STANDARD_HASH(user_name, 'SHA512'));
  END LOOP;
END;