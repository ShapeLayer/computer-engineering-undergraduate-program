USE shopdb;

SELECT * FROM memberTBL WHERE memberName = '토마스';
SELECT * FROM productTBL WHERE productName = '냉장고';

DELIMITER //
CREATE PROCEDURE myProc()
BEGIN
    SELECT * FROM memberTBL WHERE memberName = '토마스';
    SELECT * FROM productTBL WHERE productName = '냉장고';
END //
DELIMITER ;

CALL myProc();
