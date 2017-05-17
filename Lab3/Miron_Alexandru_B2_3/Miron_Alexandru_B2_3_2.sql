UPDATE QUESTIONS
  SET REPORT_RESOLVED = 2
WHERE CREATED_AT > TO_DATE('2017-01-15','yyyy-mm-dd') and reported >= 5;

SELECT DISTINCT u.id,u.name from users u
  JOIN QUESTIONS q on u.id = q.USER_ID
  WHERE q.CREATED_AT > TO_DATE('2017-01-15','yyyy-mm-dd') and q.reported >=5
ORDER BY u.NAME;