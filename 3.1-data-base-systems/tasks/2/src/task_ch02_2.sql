CREATE TABLE `shopdb`.`membertbl` (
    `memberID` CHAR(8) NOT NULL PRIMARY KEY,
    `memberName` CHAR(5) NOT NULL,
    `memberAddress` CHAR(20) NULL
);
CREATE TABLE `shopdb`.`producttbl` (
    `productName` CHAR(4) NOT NULL PRIMARY KEY,
    `cost` INT NOT NULL,
    `makeDate` DATE,
    `company` CHAR(5),
    `amount` INT NOT NULL
);
