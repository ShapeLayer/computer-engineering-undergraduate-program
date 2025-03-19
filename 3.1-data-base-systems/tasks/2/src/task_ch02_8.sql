USE shopdb;

INSERT INTO memberTBL VALUES ('Soccer', '흥민', '서울시 서대문구 북가좌동');
UPDATE memberTBL SET memberAddress = '서울 강남구 역삼동' WHERE memberName = '흥민';
DELETE FROM memberTBL WHERE memberName = '흥민';

CREATE TABLE deletedMemberTBL(
    memberID char(8),
    memberName char(5),
    memberAddress char(20),
    deletedDate date -- 삭제한 날짜
);

DELIMITER //
CREATE TRIGGER trg_deletedMemberTBL -- 트리거 이름
    AFTER DELETE -- 삭제 후에 작동하게 지정
    ON memberTBL -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용
BEGIN
    -- OLD 테이블의 내용을 백업 테이블에 삽입
    INSERT INTO deletedMemberTBL
        VALUES (OLD.memberID, OLD.memberName, OLD.memberAddress, CURDATE());
END //
DELIMITER ;

SELECT * FROM memberTBL;
INSERT INTO memberTBL VALUES ('Soccer', '흥민', '서울시 서대문구 북가좌동');
DELETE FROM memberTBL WHERE memberName = '흥민';

SELECT * FROM memberTBL;
SELECT * FROM deletedMemberTBL;
