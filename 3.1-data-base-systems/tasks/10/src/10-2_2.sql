-- 2-1
USE cookDB;
SELECT * FROM userTBL;

-- 2-2
SHOW INDEX FROM userTBL;

-- 2-3
CREATE INDEX idx_userTBL_addr ON userTBL (addr);

-- 2-4
SHOW INDEX FROM userTBL;

-- 2-5
CREATE UNIQUE INDEX idx_userTBL_birthYear ON userTBL (birthYear);

-- 2-6
CREATE UNIQUE INDDEX idx_userTBL_userName ON userTBL (userName);
SHOW INDEX FROM userTBL;

-- 2-7
INSERT INTO userTBL VALUES ('GHD', '강호동', 1988, '미국');

-- 2-8
CREATE INDEX idx_userTBL_birthYear ON userTBL (userName, birthYear);
DROP INDEX idx_userTBL_userName ON userTBL;
SHOW INDEX FROM userTBL;

-- 2-9
SELECT * FROM userTBL WHERE userName = '신동엽' AND birthYear = '1971';

CREATE INDEX idx_userTBL_mobile1 ON userTBL (mobile1);
SELECT FROM userTBL WHERE mobile1 = '011';
