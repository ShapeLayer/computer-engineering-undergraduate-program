-- 4-1
SELECT * FROM FulltextTbl WHERE MATCH(description) AGAINST('남자*' IN BOOLEAN MODE);

-- 4-3
SELECT * , MATCH(description) AGAINST('남자 * 여자 * ' IN BOOLEAN MODE) AS 점수
FROM FulltextTbl WHERE MATCH(description) AGAINST('남자 * 여자 * ' IN BOOLEAN MODE);

-- 4-4
SELECT * FROM FulltextTbl
WHERE MATCH(description) AGAINST('+남자 * +여자 * ' IN BOOLEAN MODE);

-- 4-5
SELECT * FROM FulltextTbl
WHERE MATCH(description) AGAINST('남자 * -여자 * ' IN BOOLEAN MODE);
