CREATE TABLE `events` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `date` datetime NULL,
  `type` text COLLATE 'utf8mb4_unicode_ci' NULL,
  `location` text COLLATE 'utf8mb4_unicode_ci' NULL
) ENGINE='InnoDB' COLLATE 'utf8mb4_unicode_ci';