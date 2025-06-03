-- 2-1
CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
DROP TABLE IF EXISTS userTBL;
CREATE TABLE userTBL (
  userID char(8) NOT NULL PRIMARY KEY,
  userName varchar(10) NOT NULL,
  birthYear int NOT NULL,
  addr char(2) NOT NULL
);

-- 2-2
INSERT INTO userTBL VALUES ('YJS', '유재석', 1972, '서울');
INSERT INTO userTBL VALUES ('KHD', '강호동', 1970, '경북');
INSERT INTO userTBL VALUES ('KKJ', '김국진', 1965, '서울');
INSERT INTO userTBL VALUES ('KYM', '김용만', 1967, '서울');
INSERT INTO userTBL VALUES ('KJD', '김제동', 1974, '경남');
SELECT * FROM userTBL;

-- 2-3
ALTER TABLE userTBL DROP PRIMARY KEY;
ALTER TABLE userTBL
ADD CONSTRAINT pk_userName PRIMARY KEY (userName);
SELECT * FROM userTBL;
