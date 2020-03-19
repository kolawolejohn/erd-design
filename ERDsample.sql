CREATE TABLE `drivers` (
  `id` INT PRIMARY KEY,
  `wallet_id` INT,
  `document_id` INT,
  `first_name` VARCHAR,
  `last_name` VARCHAR,
  `phone_number` VARCHAR,
  `email` VARCHAR,
  `password` VARCHAR,
  `gender` VARCHAR,
  `age` INT,
  `car_type` VARCHAR,
  `PRIMARY` KEY(id)
);

CREATE TABLE `vehicles` (
  `id` INT PRIMARY KEY,
  `driver_id` INT,
  `plate_number` VARCHAR,
  `color` VARCHAR,
  `type` VARCHAR,
  `model` VARCHAR,
  `PRIMARY` KEY(id)
);

CREATE TABLE `status` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR
);

CREATE TABLE `users` (
  `id` INT PRIMARY KEY,
  `wallet_id` INT,
  `name` VARCHAR,
  `first_name` VARCHAR,
  `last_name` VARCHAR,
  `type` ENUM ('customer', 'driver', 'admin'),
  `created_at` CURRENT_TIMESTAMP
);

CREATE TABLE `wallets` (
  `id` INT PRIMARY KEY,
  `users_id` INT,
  `user_type_id` ENUM ('customer', 'driver', 'admin'),
  `refcode` VARCHAR,
  `balance` Decimal,
  `created_at` CURRENT_TIMESTAMP,
  `modified_at` CURRENT_TIMESTAMP,
  `status_id` ENUM ('active', 'inactive', 'cancelled', 'failed', 'successful')
);

CREATE TABLE `documents` (
  `id` INT PRIMARY KEY,
  `users_id` INT,
  `user_type_id` ENUM ('customer', 'driver', 'admin'),
  `url` VARCAHR,
  `created_at` CURRENT_TIMESTAMP,
  `modified_at` CURRENT_TIMESTAMP,
  `status` ENUM ('active', 'inactive', 'cancelled', 'failed', 'successful')
);

CREATE TABLE `document_types` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR
);

CREATE TABLE `customers` (
  `id` INT PRIMARY KEY,
  `wallet_id` INT,
  `document_id` INT,
  `location_id` INT,
  `first_name` VARCHAR,
  `last_name` VARCHAR,
  `phone_number` VARCHAR,
  `email` VARCHAR,
  `password` VARCHAR,
  `gender` VARCHAR,
  `age` INT
);

CREATE TABLE `orders` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR,
  `customer_id` INT,
  `amount` Decimal,
  `status_id` ENUM ('active', 'inactive', 'cancelled', 'failed', 'successful'),
  `created_at` CURRENT_TIMESTAMP
);

CREATE TABLE `ratings` (
  `id` INT,
  `driver_id` INT,
  `customer_id` INT,
  `name` VARCHAR,
  `comment` VARCHAR,
  `type` ENUM ('1', '2', '3', '4', '5'),
  `created_at` CURRENT_TIMESTAMP,
  `modified_at` CURRENT_TIMESTAMP
);

CREATE TABLE `locations` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR,
  `pickup_address` VARCHAR,
  `drop_address` VARCHAR
);

CREATE TABLE `routes` (
  `id` INT PRIMARY KEY,
  `distance_from` VARCHAR,
  `distance_to` VARCHAR,
  `longitude` VARCHAR,
  `latitude` VARCHAR
);

CREATE TABLE `cards` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR,
  `number` VARCHAR,
  `expiry_date` VARCHAR,
  `CVV` INT,
  `type` ENUM ('visa', 'mastercard', 'verve'),
  `status_id` ENUM ('active', 'inactive', 'cancelled', 'failed', 'successful'),
  `created_at` CURRENT_TIMESTAMP,
  `modified_at` CURRENT_TIMESTAMP
);

CREATE TABLE `payments` (
  `id` INT PRIMARY KEY,
  `card_id` INT,
  `order_id` INT,
  `wallet_id` INT,
  `status_id` ENUM ('active', 'inactive', 'cancelled', 'failed', 'successful'),
  `name` VARCHAR,
  `order_amount` Decimal,
  `confirmation` ENUM ('active', 'inactive', 'cancelled', 'failed', 'successful'),
  `type` ENUM ('card_type', 'cash'),
  `created_at` CURRENT_TIMESTAMP
);

ALTER TABLE `drivers` ADD FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`);

ALTER TABLE `drivers` ADD FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`);

ALTER TABLE `vehicles` ADD FOREIGN KEY (`id`) REFERENCES `drivers` (`id`);

ALTER TABLE `users` ADD FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`);

ALTER TABLE `users` ADD FOREIGN KEY (`type`) REFERENCES `drivers` (`id`);

ALTER TABLE `users` ADD FOREIGN KEY (`type`) REFERENCES `customers` (`id`);

ALTER TABLE `wallets` ADD FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

ALTER TABLE `document_types` ADD FOREIGN KEY (`id`) REFERENCES `documents` (`id`);

ALTER TABLE `customers` ADD FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`);

ALTER TABLE `customers` ADD FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`);

ALTER TABLE `customers` ADD FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`);

ALTER TABLE `customers` ADD FOREIGN KEY (`id`) REFERENCES `orders` (`customer_id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);

ALTER TABLE `drivers` ADD FOREIGN KEY (`id`) REFERENCES `ratings` (`driver_id`);

ALTER TABLE `customers` ADD FOREIGN KEY (`id`) REFERENCES `ratings` (`comment`);

ALTER TABLE `routes` ADD FOREIGN KEY (`id`) REFERENCES `locations` (`id`);

ALTER TABLE `status` ADD FOREIGN KEY (`id`) REFERENCES `cards` (`expiry_date`);

ALTER TABLE `payments` ADD FOREIGN KEY (`id`) REFERENCES `wallets` (`id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

CREATE INDEX `user_type` ON `users` (`wallet_id`, `type`);

CREATE UNIQUE INDEX `users_index_1` ON `users` (`id`);

CREATE INDEX `status` ON `orders` (`customer_id`, `status_id`);

CREATE UNIQUE INDEX `orders_index_3` ON `orders` (`id`);

CREATE INDEX `rating_type` ON `ratings` (`driver_id`, `customer_id`);

CREATE INDEX `status` ON `cards` (`expiry_date`, `status_id`);

CREATE UNIQUE INDEX `cards_index_6` ON `cards` (`id`);

CREATE INDEX `payment_type` ON `payments` (`wallet_id`, `status_id`);

CREATE INDEX `card_type` ON `payments` (`wallet_id`, `card_id`);

CREATE INDEX `status` ON `payments` (`wallet_id`, `confirmation`);

CREATE UNIQUE INDEX `payments_index_10` ON `payments` (`id`);
