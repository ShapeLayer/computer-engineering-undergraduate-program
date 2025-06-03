DROP DATABASE `drugbank_db`

CREATE DATABASE IF NOT EXISTS `drugbank_db`
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;

USE `drugbank_db`;

CREATE TABLE IF NOT EXISTS `drugs` (
  `id` VARCHAR(20) NOT NULL PRIMARY KEY,
  `name` VARCHAR(256) NOT NULL,
  `description` TEXT,
  `cas_number` VARCHAR(50),
  `state` VARCHAR(50),
  `unii` VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS `categories` (
  `id` VARCHAR(20) NOT NULL PRIMARY KEY,
  `name` VARCHAR(256) NOT NULL
);

-- Connections between drugs and categories
CREATE TABLE IF NOT EXISTS `drug_categories` (
  `drug_id` VARCHAR(20) NOT NULL,
  `category_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`drug_id`, `category_id`),
  FOREIGN KEY (`drug_id`) REFERENCES `drugs`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `external_db_identifiers` (
  -- id: Specially converted from uuid
  `id` BINARY(16) NOT NULL PRIMARY KEY,
  -- `external_id` can be duplicated across different resources.
  -- so `id` is denoted as a primary key to identify the record uniquely.
  `external_id` VARCHAR(512) NOT NULL,
  `derived_from` VARCHAR(20) NOT NULL,
  `resource` VARCHAR(50) NOT NULL,
  FOREIGN KEY (`derived_from`) REFERENCES `drugs`(`id`) ON DELETE CASCADE
);

-- Connections between drugs and external databases
/*
-- No more required: `dervied_from` in `external_db_identifiers` table references `drug_id` in `darugs` table.
CREATE TABLE IF NOT EXISTS `drug_external_ids` (
  `drug_id` VARCHAR(20) NOT NULL,
  `external_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`drug_id`, `external_id`),
  FOREIGN KEY (`drug_id`) REFERENCES `drugs`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`external_id`) REFERENCES `external_db_identifiers`(`external_id`) ON DELETE CASCADE
);
*/

CREATE TABLE IF NOT EXISTS `products` (
  `id` BINARY(16) NOT NULL PRIMARY KEY,
  `derived_from` VARCHAR(20) NOT NULL,
  `name` VARCHAR(512) NOT NULL,
  `labeller` VARCHAR(256),
  `strength` VARCHAR(50),
  `route` TEXT,
  `approved` BOOLEAN DEFAULT FALSE,
  `ndc_product_code` VARCHAR(20),
  `ema_ma_number` VARCHAR(20),
  FOREIGN KEY (`derived_from`) REFERENCES `drugs`(`id`) ON DELETE CASCADE
);

-- Connections between drugs and products
/*
-- No more required: `dervied_from` in `products` table references `drug_id` in `darugs` table.
CREATE TABLE IF NOT EXISTS `drug_products` (
  `drug_id` VARCHAR(20) NOT NULL,
  `product_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`drug_id`, `product_id`),
  FOREIGN KEY (`drug_id`) REFERENCES `drugs`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
);
*/

CREATE TABLE IF NOT EXISTS `experimental_properties` (
  -- id: Specially converted from uuid
  `id` BINARY(16) NOT NULL PRIMARY KEY,
  `derived_from` VARCHAR(20) NOT NULL,
  `kind` VARCHAR(50) NOT NULL,
  `value` VARCHAR(256) NOT NULL,
  `unit` VARCHAR(1000) DEFAULT NULL,
  FOREIGN KEY (`derived_from`) REFERENCES `drugs`(`id`) ON DELETE CASCADE
);

-- Connections between drugs and experimental properties
/*
-- No more required: `dervied_from` in `experimental_properties` table references `drug_id` in `darugs` table.
CREATE TABLE IF NOT EXISTS `drug_experimental_properties` (
  `drug_id` VARCHAR(20) NOT NULL,
  `property_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`drug_id`, `property_id`),
  FOREIGN KEY (`drug_id`) REFERENCES `drugs`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`property_id`) REFERENCES `experimental_properties`(`id`) ON DELETE CASCADE
);
*/

CREATE TABLE IF NOT EXISTS `targets` (
  `id` VARCHAR(20) NOT NULL PRIMARY KEY,
  `name` VARCHAR(256) NOT NULL,
  `organism` VARCHAR(256)
);

-- Connections between drugs and targets
CREATE TABLE IF NOT EXISTS `drug_targets` (
  `drug_id` VARCHAR(20) NOT NULL,
  `target_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`drug_id`, `target_id`),
  FOREIGN KEY (`drug_id`) REFERENCES `drugs`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`target_id`) REFERENCES `targets`(`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `references` (
  `ref_id` VARCHAR(20) NOT NULL PRIMARY KEY,
  `pubmed_id` VARCHAR(20) NOT NULL,
  `citation` TEXT NOT NULL
);

-- Connections between drugs and references
CREATE TABLE IF NOT EXISTS `drug_references` (
  `drug_id` VARCHAR(20) NOT NULL,
  `ref_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`drug_id`, `ref_id`),
  FOREIGN KEY (`drug_id`) REFERENCES `drugs`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`ref_id`) REFERENCES `references`(`ref_id`) ON DELETE CASCADE
);
