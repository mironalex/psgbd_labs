--set serveroutput on;
DECLARE
  type arr is table of varchar2(20);
  
  commonNouns arr := arr('time','issue','year','side','people','kind','way',
  'head','day','house','man','service','thing','friend','woman','father',
  'life','power','child','hour','world','game','school','line','state','end',
  'family','member','student','law','group','car','country','city','problem',
  'community','hand','name','part','president','place','team','case','minute',
  'week','idea','company','kid','system','body','program','information','question',
  'back','work','parent','government','face','number','others','night','level',
  'office','point','door','home','health','water','person','room','art','mother',
  'war','area','history','money','party','story','result','fact','change','month',
  'morning','lot','reason','right','research','study','girl','book','guy','eye',
  'food','job','mment','word','air','business','teacher'
  );
  
  commonVerbs arr := arr('accept','care','could','enjoy','happen','lead','open',
  'reduce','settle','teach','account','carry','count','examine','hate','learn',
  'order','refer','shake','tell','achieve','catch','cover','exist','have','leave',
  'ought','reflect','shall','tend','act','cause','create','expect','head','lend',
  'own','refuse','share','test','add','change','cross','experience','hear','let',
  'pass','regard','shoot','thank','admit','charge','cry','explain','help','lie',
  'pay','relate','should','think','affect','check','cut','express','hide','like',
  'perform','release','shout','throw','afford','choose','damage','extend','hit',
  'limit','pick','remain','show','touch','agree','claim','dance','face','hold',
  'link','place','remember','shut','train','aim','clean','deal','fail','hope',
  'listen','plan','remove','sing','travel','allow','clear','decide','fall','hurt',
  'live','play','repeat','sit','treat','answer','climb','deliver','fasten','identify',
  'look','point','replace','sleep','try','appear','close','demand','feed','imagine',
  'lose','prefer','reply','smile','turn','apply','collect','deny','feel','improve',
  'love','prepare','report','sort','understand','argue','come','depend','fight',
  'include','make','present','represent','sound','use','arrange','commit','describe',
  'fill','increase','manage','press','require','speak','used','to','arrive','compare',
  'design','find','indicate','mark','prevent','rest','stand','visit','ask','complain',
  'destroy','finish','influence','matter','produce','result','start','vote','attack',
  'complete','develop','fit','inform','may','promise','return','state','wait','avoid',
  'concern','die','fly','intend','mean','protect','reveal','stay','walk','base',
  'confirm','disappear','fold','introduce','measure','prove','ring','stick','want',
  'be','connect','discover','follow','invite','meet','provide','rise','stop','warn',
  'beat','consider','discuss','force','involve','mention','publish','roll','study',
  'wash','become','consist','divide','forget','join','might','pull','run','succeed'
  ,'watch','begin','contact','do','forgive','jump','mind','push','save','suffer',
  'wear','believe','contain','draw','form','keep','miss','put','say','suggest',
  'will','belong','continue','dress','found','kick','move','raise','see','suit',
  'win','break','contribute','drink','gain','kill','must','reach','seem','supply',
  'wish','build','control','drive','get','knock','need','read','sell','support',
  'wonder','burn','cook','drop','give','know','notice','realize','send','suppose',
  'work','buy','copy','eat','go','last','obtain','receive','separate','survive',
  'worry','call','correct','enable','grow','laugh','occur','recognize','serve',
  'take','would','can','cost','encourage','handle','lay','offer','record','set',
  'talk','write'
  );
  
  nrNouns int := commonNouns.count;
  nrVerbs int := commonVerbs.count;
  
  
  type arr2 is varray(2) of varchar2(20);
  postType arr2 := arr2('Private', 'Public');
  post_id int := 0;
  username posts.username%type;
  postTypeNr int := 0;
  post_Title posts.post_title%type;
  post_Text posts.post_text%type;
  
  data_created DATE;
  zizi DATE;
  scadere int;
  
  nounNr int;
  verbNr int;
  userNr int;
  
BEGIN
  for i in 1..10000 LOOP
    SELECT DBMS_RANDOM.VALUE(1,nrNouns) into nounNr FROM DUAL;
    SELECT DBMS_RANDOM.VALUE(1,nrVerbs) into verbNr FROM DUAL;
    SELECT DBMS_RANDOM.VALUE(1,10000000) into post_id FROM DUAL;
    SELECT DBMS_RANDOM.VALUE(1,100000) into userNr FROM DUAL;
    SELECT DBMS_RANDOM.VALUE(1,2) into postTypeNr FROM DUAL;
    
    zizi := current_timestamp;
    
    SELECT DBMS_RANDOM.VALUE(0,3000) into scadere FROM DUAL;
    
    SELECT USERNAME into username from (SELECT username, rownum as nrr FROM users) where nrr = userNr ; 
    
    post_Title := commonVerbs(nounNr) || initcap(commonNouns(nounNr));
    post_Text := '';
    
    for i in 1..5 LOOP
    
      SELECT DBMS_RANDOM.VALUE(1,nrNouns) into nounNr FROM DUAL;
      SELECT DBMS_RANDOM.VALUE(1,nrVerbs) into verbNr FROM DUAL;
      post_Text := post_Text || commonVerbs(verbNr) || ' ' || commonNouns(nounNr) || ' '  ;
      
    END LOOP;
    
    data_created := TO_DATE(zizi - scadere, 'dd/mm/yyyy');
     
    INSERT INTO POSTS VALUES(i, username, postType(postTypeNr), post_Title, post_Text, data_created);
 END LOOP;
END;