USE cookDB;
SELECT ROW_NUMBER() OVER(ORDER BY height DESC) "키큰순위", userName, addr, height FROM userTBL;

SELECT ROW_NUMBER() OVER(ORDER BY height DESC, userName ASC) "키큰순위", userName, addr, height FROM userTBL;

SELECT addr, ROW_NUMBER() OVER(PARTITION BY addr ORDER BY height DESC, userName ASC) "지역 별키큰순위", userName, height FROM userTBL;

SELECT DENSE_RANK() OVER(ORDER BY height DESC) "키큰순위", userName, addr, height FROM userTBL;

SELECT RANK() OVER(ORDER BY height DESC) "키큰순위", userName, addr, height FROM userTBL;

SELECT NTILE(2) OVER(ORDER BY height DESC) "반번호", userName, addr, height FROM userTBL;

SELECT NTILE(4) OVER(ORDER BY height DESC) "반번호", userName, addr, height FROM userTBL;
