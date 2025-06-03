USE `drugbank_db`;

SELECT * FROM `drugs` ORDER BY RAND() LIMIT 3;
SELECT * FROM `categories` ORDER BY RAND() LIMIT 3;
SELECT * FROM `drug_categories` ORDER BY RAND() LIMIT 3;
SELECT * FROM `external_db_identifiers` ORDER BY RAND() LIMIT 3;
SELECT * FROM `products` ORDER BY RAND() LIMIT 3;
SELECT * FROM `experimental_properties` ORDER BY RAND() LIMIT 3;
SELECT * FROM `targets` ORDER BY RAND() LIMIT 3;
SELECT * FROM `drug_targets` ORDER BY RAND() LIMIT 3;
SELECT * FROM `references` ORDER BY RAND() LIMIT 3;
SELECT * FROM `drug_references` ORDER BY RAND() LIMIT 3;
