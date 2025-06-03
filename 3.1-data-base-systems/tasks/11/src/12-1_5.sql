-- 5-1
SET GLOBAL innodb_ft_aux_table = 'fulltextdb/fulltexttbl';
SELECT word, doc_count, doc_id, position
FROM INFORMATION_SCHEMA.INNODB_FT_INDEX_TABLE;

-- 5-2
DROP INDEX idx_description ON FulltextTbl;

-- 5-3
CREATE TABLE user_stopword (value VARCHAR(30));

-- 5-4
INSERT INTO user_stopword VALUES ('그는'), ('그리고'), ('극에');

-- 5-5
SET GLOBAL innodb_ft_server_stopword_table = 'fulltextdb/user_stopword';
SHOW GLOBAL VARIABLES LIKE 'innodb_ft_server_stopword_table';

-- 5-6
CREATE FULLTEXT INDEX idx_description ON FulltextTbl(description);

-- 5-7
SELECT word, doc_count, doc_id, position
FROM INFORMATION_SCHEMA.INNODB_FT_INDEX_TABLE;
