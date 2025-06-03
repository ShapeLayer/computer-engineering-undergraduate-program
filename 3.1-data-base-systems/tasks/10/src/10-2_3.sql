-- 3-1
SHOW INDEX FROM userTBL;

-- 3-2
DROP INDEX idx_userTBL_addr ON userTBL;
DROP INDEX idx_userTBL_birthYear ON userTBL;
DROP INDEX idx_userTBL_mobile1 ON userTBL;

-- 3-3
ALTER TABLE userTBL DROP PRIMARY KEY;
