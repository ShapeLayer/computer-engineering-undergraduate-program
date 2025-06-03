USE `drugbank_db`;

SHOW INDEX FROM `drugs`;
SHOW INDEX FROM `categories`;
SHOW INDEX FROM `drug_categories`;
SHOW INDEX FROM `external_db_identifiers`;
SHOW INDEX FROM `products`;
SHOW INDEX FROM `experimental_properties`;
SHOW INDEX FROM `targets`;
SHOW INDEX FROM `drug_targets`;
SHOW INDEX FROM `references`;
SHOW INDEX FROM `drug_references`;

CREATE INDEX `idx_drug_name` ON `drugs` (`name`);
CREATE INDEX `idx_drug_external_id` ON `external_db_identifiers` (`external_id`);
CREATE INDEX `idx_product_name` ON `products` (`name`);
CREATE INDEX `idx_experimental_property_kind` ON `experimental_properties` (`kind`);
CREATE INDEX `idx_target_name` ON `targets` (`name`);
CREATE INDEX `idx_drug_reference` ON `drug_references` (`drug_id`, `ref_id`);
CREATE INDEX `idx_drug_target` ON `drug_targets` (`drug_id`, `target_id`);
CREATE INDEX `idx_drug_category` ON `drug_categories` (`drug_id`, `category_id`);
