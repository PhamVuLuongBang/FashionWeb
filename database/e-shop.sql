-- --------------------------------------------------------
-- Máy chủ:                      127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Phiên bản:           12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for shop
CREATE DATABASE IF NOT EXISTS `shop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shop`;

-- Dumping structure for table shop.banners
CREATE TABLE IF NOT EXISTS `banners` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `banners_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.banners: ~3 rows (approximately)
DELETE FROM `banners`;
INSERT INTO `banners` (`id`, `title`, `slug`, `photo`, `description`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Lorem Ipsum is', 'lorem-ipsum-is', '/storage/photos/1/Products/Screenshot (39).png', '<h2><span style="font-weight: bold; color: rgb(99, 99, 99);">Up to 10%</span></h2>', 'active', '2020-08-14 01:47:38', '2025-09-17 18:57:05'),
	(2, 'Lorem Ipsum', 'lorem-ipsum', '/storage/photos/1/Banner/banner-07.jpg', '<p>Up to 90%</p>', 'active', '2020-08-14 01:50:23', '2020-08-14 01:50:23'),
	(4, 'Banner', 'banner', '/storage/photos/1/Banner/banner-06.jpg', '<h2><span style="color: rgb(156, 0, 255); font-size: 2rem; font-weight: bold;">Up to 40%</span><br></h2><h2><span style="color: rgb(156, 0, 255);"></span></h2>', 'active', '2020-08-17 20:46:59', '2020-08-17 20:46:59');

-- Dumping structure for table shop.brands
CREATE TABLE IF NOT EXISTS `brands` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `brands_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.brands: ~5 rows (approximately)
DELETE FROM `brands`;
INSERT INTO `brands` (`id`, `title`, `slug`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Adidas', 'adidas', 'active', '2020-08-14 04:23:00', '2020-08-14 04:23:00'),
	(2, 'Nike', 'nike', 'active', '2020-08-14 04:23:08', '2020-08-14 04:23:08'),
	(3, 'Kappa', 'kappa', 'active', '2020-08-14 04:23:48', '2020-08-14 04:23:48'),
	(4, 'Prada', 'prada', 'active', '2020-08-14 04:24:08', '2020-08-14 04:24:08'),
	(6, 'Brand', 'brand', 'active', '2020-08-17 20:50:31', '2020-08-17 20:50:31'),
	(7, '$maker', 'maker', 'active', '2025-09-13 04:27:23', '2025-09-13 04:27:23');

-- Dumping structure for table shop.carts
CREATE TABLE IF NOT EXISTS `carts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `order_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `price` double(8,2) NOT NULL,
  `status` enum('new','progress','delivered','cancel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `quantity` int NOT NULL,
  `amount` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_product_id_foreign` (`product_id`),
  KEY `carts_user_id_foreign` (`user_id`),
  KEY `carts_order_id_foreign` (`order_id`),
  CONSTRAINT `carts_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.carts: ~9 rows (approximately)
DELETE FROM `carts`;
INSERT INTO `carts` (`id`, `product_id`, `order_id`, `user_id`, `price`, `status`, `quantity`, `amount`, `created_at`, `updated_at`) VALUES
	(1, 8, 1, 3, 200.00, 'new', 2, 400.00, '2020-08-14 07:15:45', '2020-08-14 07:20:45'),
	(2, 7, 1, 3, 1939.03, 'new', 1, 1999.00, '2020-08-14 07:15:59', '2020-08-14 07:20:45'),
	(3, 5, 1, 3, 3600.00, 'new', 3, 12000.00, '2020-08-14 07:16:12', '2020-08-14 07:20:45'),
	(4, 7, 2, 2, 1939.03, 'new', 1, 1939.03, '2020-08-14 22:13:51', '2020-08-14 22:14:59'),
	(5, 8, 3, 3, 200.00, 'new', 1, 200.00, '2020-08-15 06:39:59', '2020-08-15 06:41:00'),
	(8, 9, 4, 3, 190.00, 'new', 2, 380.00, '2020-08-15 07:44:53', '2020-08-15 07:54:53'),
	(9, 6, 4, 3, 5820.00, 'new', 4, 23280.00, '2020-08-15 07:45:29', '2020-08-15 07:54:53'),
	(10, 10, NULL, 2, 270.00, 'new', 1, 270.00, '2020-08-17 21:07:33', '2020-08-17 21:17:03'),
	(11, 9, NULL, 2, 190.00, 'new', 2, 380.00, '2020-08-17 21:08:35', '2020-08-17 21:17:03'),
	(13, 4, 6, 1, 2000.00, 'new', 3, 6000.00, '2025-09-12 22:37:46', '2025-09-17 05:00:03'),
	(14, 16, 6, 1, 18.00, 'new', 1, 18.00, '2025-09-17 04:58:24', '2025-09-17 05:00:03');

-- Dumping structure for table shop.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_parent` tinyint(1) NOT NULL DEFAULT '1',
  `parent_id` bigint unsigned DEFAULT NULL,
  `added_by` bigint unsigned DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  KEY `categories_added_by_foreign` (`added_by`),
  CONSTRAINT `categories_added_by_foreign` FOREIGN KEY (`added_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.categories: ~7 rows (approximately)
DELETE FROM `categories`;
INSERT INTO `categories` (`id`, `title`, `slug`, `summary`, `photo`, `is_parent`, `parent_id`, `added_by`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Men\'s Fashion', 'mens-fashion', NULL, '/storage/photos/1/Category/mini-banner1.jpg', 1, NULL, NULL, 'active', '2020-08-14 04:26:15', '2020-08-14 04:26:15'),
	(2, 'Women\'s Fashion', 'womens-fashion', NULL, '/storage/photos/1/Category/mini-banner2.jpg', 1, NULL, NULL, 'active', '2020-08-14 04:26:40', '2020-08-14 04:26:40'),
	(3, 'Kid\'s', 'kids', NULL, '/storage/photos/1/Category/mini-banner3.jpg', 1, NULL, NULL, 'active', '2020-08-14 04:27:10', '2020-08-14 04:27:42'),
	(4, 'T-shirt\'s', 't-shirts', NULL, '/storage/photos/1/Products/Screenshot (38).png', 0, 1, NULL, 'active', '2020-08-14 04:32:14', '2025-09-17 18:27:56'),
	(5, 'Jeans pants', 'jeans-pants', NULL, '/storage/photos/1/Products/Screenshot (40).png', 0, 1, NULL, 'active', '2020-08-14 04:32:49', '2025-09-17 18:28:23'),
	(6, 'Sweater & Jackets', 'sweater-jackets', NULL, '/storage/photos/1/Category/Screenshot (43).png', 0, 1, NULL, 'active', '2020-08-14 04:33:37', '2025-09-17 04:51:01'),
	(13, 'Glasses', 'glasses', '&nbsp;Mắt kính của anh wrxdie á&nbsp;', '/storage/photos/1/Category/Screenshot (5).png', 1, NULL, NULL, 'active', '2025-09-17 04:26:41', '2025-09-17 04:30:25');

-- Dumping structure for table shop.coupons
CREATE TABLE IF NOT EXISTS `coupons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('fixed','percent') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `value` decimal(20,2) NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupons_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.coupons: ~3 rows (approximately)
DELETE FROM `coupons`;
INSERT INTO `coupons` (`id`, `code`, `type`, `value`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'abc123', 'fixed', 300.00, 'active', NULL, NULL),
	(2, '111111', 'percent', 10.00, 'active', NULL, NULL),
	(5, 'abcd', 'fixed', 250.00, 'active', '2020-08-17 20:54:58', '2020-08-17 20:54:58'),
	(6, '2222', 'percent', 25.00, 'active', '2025-09-13 04:38:43', '2025-09-13 04:38:43');

-- Dumping structure for table shop.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.failed_jobs: ~0 rows (approximately)
DELETE FROM `failed_jobs`;

-- Dumping structure for table shop.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.jobs: ~0 rows (approximately)
DELETE FROM `jobs`;

-- Dumping structure for table shop.messages
CREATE TABLE IF NOT EXISTS `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.messages: ~3 rows (approximately)
DELETE FROM `messages`;
INSERT INTO `messages` (`id`, `name`, `subject`, `email`, `photo`, `phone`, `message`, `read_at`, `created_at`, `updated_at`) VALUES
	(1, 'Prajwal Rai', 'About price', 'prajwal.iar@gmail.com', NULL, '9807009999', 'Hello sir i am from kathmandu nepal.', '2020-08-14 08:25:46', '2020-08-14 08:00:01', '2020-08-14 08:25:46'),
	(2, 'Prajwal Rai', 'About Price', 'prajwal.iar@gmail.com', NULL, '9800099000', 'Hello i am Prajwal Rai', '2020-08-18 03:04:15', '2020-08-15 07:52:39', '2020-08-18 03:04:16'),
	(3, 'Prajwal Rai', 'lorem ipsum', 'prajwal.iar@gmail.com', NULL, '1200990009', 'hello sir sdfdfd dfdjf ;dfjd fd ldkfd', '2025-09-13 04:16:34', '2020-08-17 21:15:12', '2025-09-13 04:16:34'),
	(4, 'Huỳnh Lâm Gia Linh', 'aaaaaa', 'gialinh.29032004@gmail.com', NULL, '0966276904', 'You giao chậm quá à :(((', NULL, '2025-09-17 19:16:10', '2025-09-17 19:16:10'),
	(5, 'Huỳnh Lâm Gia Linh', 'aaaaaa', 'gialinh.29032004@gmail.com', NULL, '0966276904', 'You giao chậm quá à :(((', NULL, '2025-09-17 19:16:13', '2025-09-17 19:16:13');

-- Dumping structure for table shop.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.migrations: ~20 rows (approximately)
DELETE FROM `migrations`;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2020_07_10_021010_create_brands_table', 1),
	(5, '2020_07_10_025334_create_banners_table', 1),
	(6, '2020_07_10_112147_create_categories_table', 1),
	(7, '2020_07_11_063857_create_products_table', 1),
	(8, '2020_07_12_073132_create_post_categories_table', 1),
	(9, '2020_07_12_073701_create_post_tags_table', 1),
	(10, '2020_07_12_083638_create_posts_table', 1),
	(11, '2020_07_13_151329_create_messages_table', 1),
	(12, '2020_07_14_023748_create_shippings_table', 1),
	(13, '2020_07_15_054356_create_orders_table', 1),
	(14, '2020_07_15_102626_create_carts_table', 1),
	(15, '2020_07_16_041623_create_notifications_table', 1),
	(16, '2020_07_16_053240_create_coupons_table', 1),
	(17, '2020_07_23_143757_create_wishlists_table', 1),
	(18, '2020_07_24_074930_create_product_reviews_table', 1),
	(19, '2020_07_24_131727_create_post_comments_table', 1),
	(20, '2020_08_01_143408_create_settings_table', 1),
	(21, '2019_12_14_000001_create_personal_access_tokens_table', 2),
	(22, '2023_06_21_164432_create_jobs_table', 2);

-- Dumping structure for table shop.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.notifications: ~14 rows (approximately)
DELETE FROM `notifications`;
INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
	('2145a8e3-687d-444a-8873-b3b2fb77a342', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New Comment created","actionURL":"http:\\/\\/e-shop.loc\\/blog-detail\\/where-can-i-get-some","fas":"fas fa-comment"}', NULL, '2020-08-15 07:31:21', '2020-08-15 07:31:21'),
	('3af39f84-cab4-4152-9202-d448435c67de', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New order created","actionURL":"http:\\/\\/localhost:8000\\/admin\\/order\\/4","fas":"fa-file-alt"}', NULL, '2020-08-15 07:54:52', '2020-08-15 07:54:52'),
	('4a0afdb0-71ad-4ce6-bc70-c92ef491a525', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New Comment created","actionURL":"http:\\/\\/localhost:8000\\/blog-detail\\/the-standard-lorem-ipsum-passage-used-since-the-1500s","fas":"fas fa-comment"}', '2025-09-13 04:16:47', '2020-08-17 21:13:51', '2025-09-13 04:16:47'),
	('540ca3e9-0ff9-4e2e-9db3-6b5abc823422', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New Comment created","actionURL":"http:\\/\\/e-shop.loc\\/blog-detail\\/where-can-i-get-some","fas":"fas fa-comment"}', '2020-08-15 07:30:44', '2020-08-14 07:12:28', '2020-08-15 07:30:44'),
	('5da09dd1-3ffc-43b0-aba2-a4260ba4cc76', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New Comment created","actionURL":"http:\\/\\/localhost:8000\\/blog-detail\\/the-standard-lorem-ipsum-passage","fas":"fas fa-comment"}', NULL, '2020-08-15 07:51:02', '2020-08-15 07:51:02'),
	('5e91e603-024e-45c5-b22f-36931fef0d90', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New Product Rating!","actionURL":"http:\\/\\/localhost:8000\\/product-detail\\/white-sports-casual-t","fas":"fa-star"}', NULL, '2020-08-15 07:44:07', '2020-08-15 07:44:07'),
	('73a3b51a-416a-4e7d-8ca2-53b216d9ad8e', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New Comment created","actionURL":"http:\\/\\/e-shop.loc\\/blog-detail\\/where-can-i-get-some","fas":"fas fa-comment"}', NULL, '2020-08-14 07:11:03', '2020-08-14 07:11:03'),
	('8605db5d-1462-496e-8b5f-8b923d88912c', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New order created","actionURL":"http:\\/\\/e-shop.loc\\/admin\\/order\\/1","fas":"fa-file-alt"}', NULL, '2020-08-14 07:20:44', '2020-08-14 07:20:44'),
	('a6ec5643-748c-4128-92e2-9a9f293f53b5', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New order created","actionURL":"http:\\/\\/localhost:8000\\/admin\\/order\\/5","fas":"fa-file-alt"}', '2025-09-12 23:00:17', '2020-08-17 21:17:03', '2025-09-12 23:00:17'),
	('b186a883-42f2-4a05-8fc5-f0d3e10309ff', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New order created","actionURL":"http:\\/\\/e-shop.loc\\/admin\\/order\\/2","fas":"fa-file-alt"}', '2020-08-15 04:17:24', '2020-08-14 22:14:55', '2020-08-15 04:17:24'),
	('d2fd7c33-b0fe-47d6-8bc6-f377d404080d', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New Comment created","actionURL":"http:\\/\\/e-shop.loc\\/blog-detail\\/where-can-i-get-some","fas":"fas fa-comment"}', NULL, '2020-08-14 07:08:50', '2020-08-14 07:08:50'),
	('dc28c23a-b9ea-492e-b8dc-2afc58f96e9a', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New order created","actionURL":"http:\\/\\/localhost\\/Complete-Ecommerce-in-laravel-10-master\\/public\\/index.php\\/admin\\/order\\/6","fas":"fa-file-alt"}', NULL, '2025-09-17 05:00:02', '2025-09-17 05:00:02'),
	('dff78b90-85c8-42ee-a5b1-de8ad0b21be4', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New order created","actionURL":"http:\\/\\/e-shop.loc\\/admin\\/order\\/3","fas":"fa-file-alt"}', NULL, '2020-08-15 06:40:54', '2020-08-15 06:40:54'),
	('e28b0a73-4819-4016-b915-0e525d4148f5', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New Product Rating!","actionURL":"http:\\/\\/localhost:8000\\/product-detail\\/lorem-ipsum-is-simply","fas":"fa-star"}', NULL, '2020-08-17 21:08:16', '2020-08-17 21:08:16'),
	('ffffa177-c54e-4dfe-ba43-27c466ff1f4b', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{"title":"New Comment created","actionURL":"http:\\/\\/localhost:8000\\/blog-detail\\/the-standard-lorem-ipsum-passage-used-since-the-1500s","fas":"fas fa-comment"}', NULL, '2020-08-17 21:13:29', '2020-08-17 21:13:29');

-- Dumping structure for table shop.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `sub_total` double(8,2) NOT NULL,
  `shipping_id` bigint unsigned DEFAULT NULL,
  `coupon` double(8,2) DEFAULT NULL,
  `total_amount` double(8,2) NOT NULL,
  `quantity` int NOT NULL,
  `payment_method` enum('cod','paypal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cod',
  `payment_status` enum('paid','unpaid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `status` enum('new','process','delivered','cancel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_order_number_unique` (`order_number`),
  KEY `orders_user_id_foreign` (`user_id`),
  KEY `orders_shipping_id_foreign` (`shipping_id`),
  CONSTRAINT `orders_shipping_id_foreign` FOREIGN KEY (`shipping_id`) REFERENCES `shippings` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.orders: ~5 rows (approximately)
DELETE FROM `orders`;
INSERT INTO `orders` (`id`, `order_number`, `user_id`, `sub_total`, `shipping_id`, `coupon`, `total_amount`, `quantity`, `payment_method`, `payment_status`, `status`, `first_name`, `last_name`, `email`, `phone`, `country`, `post_code`, `address1`, `address2`, `created_at`, `updated_at`) VALUES
	(1, 'ORD-PMIQF5MYPK', 3, 14399.00, 1, 573.90, 13925.10, 6, 'cod', 'unpaid', 'delivered', 'Prajwal', 'Rai', 'prajwal.iar@gmail.com', '9800887778', 'NP', '44600', 'Koteshwor', 'Kathmandu', '2020-08-14 07:20:44', '2020-08-14 09:37:37'),
	(2, 'ORD-YFF8BF0YBK', 2, 1939.03, 1, NULL, 2039.03, 1, 'cod', 'unpaid', 'delivered', 'Sandhya', 'Rai', 'user@gmail.com', '90000000990', 'NP', NULL, 'Lalitpur', NULL, '2020-08-14 22:14:49', '2020-08-14 22:15:19'),
	(3, 'ORD-1CKWRWTTIK', 3, 200.00, 1, NULL, 300.00, 1, 'paypal', 'paid', 'process', 'Prajwal', 'Rai', 'prajwal.iar@gmail.com', '9807009999', 'NP', '44600', 'Kathmandu', 'Kadaghari', '2020-08-15 06:40:49', '2020-08-17 20:52:40'),
	(4, 'ORD-HVO0KX0YHW', 3, 23660.00, 3, 150.00, 23910.00, 6, 'paypal', 'paid', 'new', 'Prajwal', 'Rai', 'prajwal.iar@gmail.com', '9800098878', 'NP', '44600', 'Pokhara', NULL, '2020-08-15 07:54:52', '2020-08-15 07:54:52'),
	(6, 'ORD-QHQLHSM9CQ', 1, 6018.00, NULL, NULL, 6018.00, 4, 'cod', 'unpaid', 'new', 'Tàu Hủ Bánh Lọt aka Gia Linh', 'Linh', 'gialinh.29032004@gmail.com', '0966276904', 'VN', '13343545', 'Le Trong Tan', 'Long Annnn', '2025-09-17 05:00:00', '2025-09-17 05:00:00');

-- Dumping structure for table shop.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.password_resets: ~0 rows (approximately)
DELETE FROM `password_resets`;

-- Dumping structure for table shop.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.personal_access_tokens: ~0 rows (approximately)
DELETE FROM `personal_access_tokens`;

-- Dumping structure for table shop.posts
CREATE TABLE IF NOT EXISTS `posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `quote` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_cat_id` bigint unsigned DEFAULT NULL,
  `post_tag_id` bigint unsigned DEFAULT NULL,
  `added_by` bigint unsigned DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`),
  KEY `posts_post_cat_id_foreign` (`post_cat_id`),
  KEY `posts_post_tag_id_foreign` (`post_tag_id`),
  KEY `posts_added_by_foreign` (`added_by`),
  CONSTRAINT `posts_added_by_foreign` FOREIGN KEY (`added_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `posts_post_cat_id_foreign` FOREIGN KEY (`post_cat_id`) REFERENCES `post_categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `posts_post_tag_id_foreign` FOREIGN KEY (`post_tag_id`) REFERENCES `post_tags` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.posts: ~5 rows (approximately)
DELETE FROM `posts`;
INSERT INTO `posts` VALUES
(1,'Where does it come from?','where-does-it-come-from',
'<h2 style="font-family:DauphinPlain; font-size:24px; line-height:28px;"></h2><p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">Contrary to popular belief, this text is not random. It is used as sample content for layout design to help visualize structure before real content is added.</p>',
'<h2 style="font-family:DauphinPlain; font-size:24px; line-height:28px;">What is placeholder text?</h2><p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">Placeholder text is widely used in publishing and web design to simulate real content. It helps visualize typography and layout without distraction.</p>',
'<p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">Here is a brief example of placeholder content for reference.</p>',
'/storage/photos/1/Blog/blog1.jpg','2020, Visit Nepal 2020',1,NULL,2,'active','2020-08-14 01:55:55','2020-08-14 04:29:56'),

(2,'Where can I get some?','where-can-i-get-some',
'<h2 style="font-family:DauphinPlain; font-size:24px; line-height:28px;"></h2><p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">Readable content attracts attention. Designers and developers use sample text to preview page structure and balance, giving a sense of how final content will look.</p>',
'<h2 style="font-family:DauphinPlain; font-size:24px; line-height:28px;">Why do we use it?</h2><p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">Sample text helps designers test layout and spacing before actual content is added. It ensures visual consistency and readability across devices.</p>',
NULL,'/storage/photos/1/Blog/blog2.jpg','Enjoy',2,NULL,1,'active','2020-08-14 01:58:52','2020-08-14 07:08:14'),

(3,'The standard sample passage used in publishing','the-standard-lorem-ipsum-passage-used-since-the-1500s',
'<h2 style="font-family:DauphinPlain; font-size:24px; line-height:28px;"></h2><p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">This is an example of a standard placeholder passage. It demonstrates how sample text can be formatted for testing design or typography without focusing on real meaning.</p>',
'<h2 style="font-family:DauphinPlain; font-size:24px; line-height:28px;">Example Translation</h2><p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">This paragraph shows how placeholder content is styled and structured to simulate real articles during development.</p>',
NULL,'/storage/photos/1/Blog/blog3.jpg','',3,NULL,3,'active','2020-08-14 02:59:33','2020-08-14 04:29:44'),

(5,'Sample Passage Example','the-standard-lorem-ipsum-passage',
'<h2 style="font-family:DauphinPlain; font-size:24px; line-height:28px;"></h2><p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">This section contains sample text for layout preview. It helps designers visualize spacing and alignment before publishing real content.</p>',
'<h2 style="font-family:DauphinPlain; font-size:24px; line-height:28px;">Sample Content Block</h2><p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">This block is used for testing how content appears on screen before actual articles are written. It ensures spacing and alignment look correct.</p>',
'<p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">Example paragraph for demonstration only.</p>',
'/storage/photos/1/Blog/blog2.jpg','Enjoy, 2020, Visit Nepal 2020',1,NULL,1,'active','2020-08-15 06:58:45','2020-08-15 06:58:45'),

(6,'Sample Demo Article','lorem-ipsum-is-simply',
'<h2 style="font-family:DauphinPlain; font-size:24px; line-height:28px;"></h2><p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">Sample text is commonly used as a placeholder in design templates. It helps developers and designers visualize content flow and structure.</p>',
'<h2 style="font-family:DauphinPlain; font-size:24px; line-height:28px;">What is sample content?</h2><p style="text-align:justify; font-family:Open Sans, Arial, sans-serif; font-size:13px;">It’s demonstration text used to fill space during development or design stages, showing how final content will appear once added.</p>',
NULL,'/storage/photos/1/Blog/blog3.jpg','Enjoy, 2020',2,NULL,1,'active','2020-08-17 20:54:19','2020-08-17 20:54:19');

-- Dumping structure for table shop.post_categories
CREATE TABLE IF NOT EXISTS `post_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_categories_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.post_categories: ~5 rows (approximately)
DELETE FROM `post_categories`;
INSERT INTO `post_categories` (`id`, `title`, `slug`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Travel', 'contrary', 'active', '2020-08-14 01:51:03', '2020-08-14 01:51:39'),
	(2, 'Electronics', 'richard', 'active', '2020-08-14 01:51:22', '2020-08-14 01:52:00'),
	(3, 'Cloths', 'cloths', 'active', '2020-08-14 01:52:22', '2020-08-14 01:52:22'),
	(4, 'enjoy', 'enjoy', 'active', '2020-08-14 03:16:10', '2020-08-14 03:16:10'),
	(5, 'Post Category', 'post-category', 'active', '2020-08-15 06:59:04', '2020-08-15 06:59:04');

-- Dumping structure for table shop.post_comments
CREATE TABLE IF NOT EXISTS `post_comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `post_id` bigint unsigned DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `replied_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `parent_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_comments_user_id_foreign` (`user_id`),
  KEY `post_comments_post_id_foreign` (`post_id`),
  CONSTRAINT `post_comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `post_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.post_comments: ~7 rows (approximately)
DELETE FROM `post_comments`;
INSERT INTO `post_comments` (`id`, `user_id`, `post_id`, `comment`, `status`, `replied_comment`, `parent_id`, `created_at`, `updated_at`) VALUES
	(1, 1, 2, 'Testing comment edited', 'active', NULL, NULL, '2020-08-14 07:08:42', '2020-08-15 06:59:58'),
	(2, 3, 2, 'testing 2', 'active', NULL, 1, '2020-08-14 07:11:03', '2020-08-14 07:11:03'),
	(3, 2, 2, 'That\'s cool', 'active', NULL, 2, '2020-08-14 07:12:27', '2020-08-14 07:12:27'),
	(4, 1, 2, 'nice', 'active', NULL, NULL, '2020-08-15 07:31:19', '2020-08-15 07:31:19'),
	(5, 3, 5, 'nice blog', 'active', NULL, NULL, '2020-08-15 07:51:01', '2020-08-15 07:51:01'),
	(6, 2, 3, 'nice', 'active', NULL, NULL, '2020-08-17 21:13:29', '2020-08-17 21:13:29'),
	(7, 2, 3, 'really', 'active', NULL, 6, '2020-08-17 21:13:51', '2020-08-17 21:13:51');

-- Dumping structure for table shop.post_tags
CREATE TABLE IF NOT EXISTS `post_tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_tags_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.post_tags: ~4 rows (approximately)
DELETE FROM `post_tags`;
INSERT INTO `post_tags` (`id`, `title`, `slug`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Enjoy', 'enjoy', 'active', '2020-08-14 01:53:52', '2020-08-14 01:53:52'),
	(2, '2020', '2020', 'active', '2020-08-14 01:54:09', '2020-08-14 01:54:09'),
	(3, 'Visit nepal 2020', 'visit-nepal-2020', 'active', '2020-08-14 01:54:33', '2020-08-14 01:54:33'),
	(4, 'Tag', 'tag', 'active', '2025-08-15 06:59:31', '2020-08-15 06:59:31'),
	(5, 'EcEc', 'ecec', 'active', '2025-09-13 04:37:24', '2025-09-13 04:37:24');

-- Dumping structure for table shop.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock` int NOT NULL DEFAULT '1',
  `size` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'M',
  `condition` enum('default','new','hot') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `price` double(8,2) NOT NULL,
  `discount` double(8,2) NOT NULL,
  `is_featured` tinyint(1) NOT NULL,
  `cat_id` bigint unsigned DEFAULT NULL,
  `child_cat_id` bigint unsigned DEFAULT NULL,
  `brand_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_slug_unique` (`slug`),
  KEY `products_brand_id_foreign` (`brand_id`),
  KEY `products_cat_id_foreign` (`cat_id`),
  KEY `products_child_cat_id_foreign` (`child_cat_id`),
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL,
  CONSTRAINT `products_cat_id_foreign` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `products_child_cat_id_foreign` FOREIGN KEY (`child_cat_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.products: ~14 rows (approximately)
DELETE FROM `products`;
INSERT INTO `products`
(`id`, `title`, `slug`, `summary`, `description`, `photo`, `stock`, `size`, `condition`, `status`, `price`, `discount`, `is_featured`, `cat_id`, `child_cat_id`, `brand_id`, `created_at`, `updated_at`) VALUES
(1, 'Áo thun nam Basic trắng', 'ao-thun-nam-basic-trang',
 '<p>Áo thun nam cotton thoáng mát</p>',
 '<p>Áo thun nam Basic trắng 100% cotton, phù hợp mặc hằng ngày.</p>',
 '/storage/photos/1/Products/ao_thun_nam_mautrang.jpg',
 20, 'M,L,XL', 'new', 'active', 15, 5.00, 1, 1, 1, 1, NOW(), NOW()),

(2, 'Áo sơ mi nam caro xanh', 'ao-so-mi-nam-caro-xanh',
 '<p>Áo sơ mi caro lịch lãm</p>',
 '<p>Áo sơ mi nam caro xanh, form regular fit, dễ phối đồ.</p>',
 '/storage/photos/1/Products/ao_somi_caro_xanh.jpg',
 15, 'M,L,XL', 'new', 'active', 15, 5.00, 0, 1, 1, 2, NOW(), NOW()),

(3, 'Áo polo nam đen trơn', 'ao-polo-nam-den-tron',
 '<p>Áo polo nam cổ bẻ</p>',
 '<p>Áo polo đen trơn chất liệu cá sấu cao cấp.</p>',
 '/storage/photos/1/Products/ao_polo_nam_den.jpg',
 18, 'L,XL', 'hot', 'active', 15, 8.00, 1, 1, 1, 3, NOW(), NOW()),

(4, 'Quần jeans slim fit xanh', 'quan-jeans-slim-fit-xanh',
 '<p>Quần jeans slim fit</p>',
 '<p>Quần jeans xanh đậm ôm dáng, dễ phối giày sneaker.</p>',
 '/storage/photos/1/Products/quan_xanhhslim.jpg',
 25, '29,30,31,32', 'default', 'active', 15, 5.00, 0, 1, 1, 4, NOW(), NOW()),

(5, 'Quần tây nam đen', 'quan-tay-nam-den',
 '<p>Quần tây nam công sở</p>',
 '<p>Quần tây nam đen lịch sự, phù hợp môi trường văn phòng.</p>',
 '/storage/photos/1/Products/quan_tay_nam_den.jpg',
 12, '30,31,32,33', 'new', 'active', 15, 5.00, 0, 1, 1, 5, NOW(), NOW()),

(6, 'Áo hoodie unisex xám', 'ao-hoodie-unisex-xam',
 '<p>Áo hoodie nỉ ấm áp</p>',
 '<p>Áo hoodie unisex xám có mũ, phong cách trẻ trung.</p>',
 '/storage/photos/1/Products/ao_hoodie_xam_unisex.jpg',
 30, 'M,L,XL', 'hot', 'active', 15, 5.00, 1, 1, 1, 6, NOW(), NOW()),

(7, 'Áo khoác bomber đen', 'ao-khoac-bomber-den',
 '<p>Áo khoác bomber cá tính</p>',
 '<p>Áo khoác bomber đen chất liệu dù, chống gió hiệu quả.</p>',
 '/storage/photos/1/Products/ao_khoac_bomber_den.jpg',
 10, 'M,L,XL', 'default', 'active', 15, 5.00, 0, 1, 1, 7, NOW(), NOW()),

(8, 'Áo khoác jean xanh', 'ao-khoac-jean-xanh',
 '<p>Áo khoác jean năng động</p>',
 '<p>Áo khoác jean xanh basic, phù hợp đi học đi chơi.</p>',
 '/storage/photos/1/Products/ao_khoac_jean_xanh.jpg',
 14, 'M,L', 'new', 'active', 15, 5.00, 0, 1, 1, 8, NOW(), NOW()),

(9, 'Quần short kaki be', 'quan-short-kaki-be',
 '<p>Quần short kaki mùa hè</p>',
 '<p>Quần short kaki be thoáng mát, phù hợp đi dạo phố.</p>',
 '/storage/photos/1/Products/quan_short_kaki_be.jpg',
 22, 'M,L,XL', 'new', 'active', 15, 8.00, 0, 1, 1, 9, NOW(), NOW()),

(10, 'Quần jogger đen unisex', 'quan-jogger-den-unisex',
 '<p>Quần jogger thể thao</p>',
 '<p>Quần jogger đen unisex chất thun co giãn, thoải mái vận động.</p>',
 '/storage/photos/1/Products/quan_jogger_den_unisex.jpg',
 28, 'M,L,XL', 'hot', 'active', 15, 5.00, 1, 1, 1, 10, NOW(), NOW()),

(11, 'Áo blazer công sở xám', 'ao-blazer-cong-so-xam',
 '<p>Áo blazer công sở</p>',
 '<p>Áo blazer xám, phong cách thanh lịch.</p>',
 '/storage/photos/1/Products/11f4f-image1xxl.jpg',
 8, 'M,L', 'default', 'active', 15, 5.00, 0, 1, 1, 11, NOW(), NOW()),

(12, 'Áo len cổ lọ đen', 'ao-len-co-lo-den',
 '<p>Áo len mùa đông</p>',
 '<p>Áo len cổ lọ đen giữ ấm tốt, phù hợp trời lạnh.</p>',
 '/storage/photos/1/Products/ao_len_co_lo_den.jpg',
 16, 'M,L', 'new', 'active', 15, 5.00, 0, 1, 1, 12, NOW(), NOW()),

(13, 'Váy hoa nữ vintage', 'vay-hoa-nu-vintage',
 '<p>Váy hoa phong cách vintage</p>',
 '<p>Thiết kế nhẹ nhàng, tôn dáng, phù hợp đi chơi.</p>',
 '/storage/photos/1/Products/vay_hoa_nu_vintage.jpg',
 20, 'S,M,L', 'new', 'active', 15, 5.00, 1, 2, 2, 13, NOW(), NOW()),

(14, 'Đầm maxi trắng dự tiệc', 'dam-maxi-trang-du-tiec',
 '<p>Đầm maxi sang trọng</p>',
 '<p>Đầm maxi trắng thướt tha, phù hợp dự tiệc.</p>',
 '/storage/photos/1/Products/Screenshot (20).png',
 12, 'S,M,L', 'hot', 'active', 15, 5.00, 1, 2, 2, 14, NOW(), NOW()),

(15, 'Áo crop top nữ đen', 'ao-crop-top-nu-den',
 '<p>Áo crop top cá tính</p>',
 '<p>Áo crop top nữ màu đen, trẻ trung năng động.</p>',
 '/storage/photos/1/Products/ao_croptop_nu_den.jpg',
 18, 'S,M,L', 'new', 'active', 15, 5.00, 0, 2, 2, 15, NOW(), NOW()),

(16, 'Chân váy chữ A caro', 'chan-vay-chu-a-caro',
 '<p>Chân váy chữ A nữ tính</p>',
 '<p>Chân váy caro dáng ngắn, dễ phối áo sơ mi.</p>',
 '/storage/photos/1/Products/ChanvaychuAcaro.jpg',
 14, 'S,M,L', 'new', 'active', 15, 5.00, 0, 2, 2, 16, NOW(), NOW()),

(17, 'Áo khoác cardigan len', 'ao-khoac-cardigan-len',
 '<p>Áo cardigan nữ</p>',
 '<p>Áo cardigan len mềm mại, giữ ấm mùa đông.</p>',
 '/storage/photos/1/Products/aocardigannu.jpg',
 10, 'M,L', 'default', 'active', 15, 5.00, 0, 2, 2, 17, NOW(), NOW()),

(18, 'Giày sneaker trắng unisex', 'giay-sneaker-trang-unisex',
 '<p>Giày sneaker basic</p>',
 '<p>Giày sneaker trắng dễ phối đồ, phong cách trẻ trung.</p>',
 '/storage/photos/1/Products/Giaysneakertrangunisex.jpg',
 25, '38,39,40,41,42', 'hot', 'active', 15, 5.00, 1, 3, 3, 18, NOW(), NOW()),

(19, 'Giày cao gót 7cm', 'giay-cao-got-7cm',
 '<p>Giày cao gót nữ</p>',
 '<p>Giày cao gót 7cm màu nude, thanh lịch và dễ phối đồ.</p>',
 '/storage/photos/1/Products/giaycaogot.jpg',
 12, '36,37,38,39', 'new', 'active', 15, 5.00, 0, 3, 3, 19, NOW(), NOW()),

(20, 'Dép sandal unisex', 'dep-sandal-unisex',
 '<p>Dép sandal thoáng mát</p>',
 '<p>Dép sandal unisex chất liệu nhẹ, dễ mang mùa hè.</p>',
 '/storage/photos/1/Products/Depsandalunisex.jpg',
 30, '37,38,39,40,41,42', 'default', 'active', 15, 5.00, 0, 3, 3, 20, NOW(), NOW()),

(21, 'Áo thun nữ tay lỡ hồng', 'ao-thun-nu-tay-lo-hong',
 '<p>Áo thun nữ basic</p>',
 '<p>Áo thun tay lỡ màu hồng pastel, trẻ trung năng động.</p>',
 '/storage/photos/1/Products/9002f-pwt003t.jpg',
 20, 'S,M,L', 'new', 'active', 15, 5.00, 1, 2, 2, 21, NOW(), NOW()),

(22, 'Áo sơ mi trắng nữ', 'ao-so-mi-trang-nu',
 '<p>Áo sơ mi nữ công sở</p>',
 '<p>Áo sơ mi trắng form slim fit, thanh lịch, dễ phối đồ.</p>',
 '/storage/photos/1/Products/0bc05-pwt000a.jpg',
 15, 'S,M,L', 'new', 'active', 15, 5.00, 0, 2, 2, 22, NOW(), NOW()),

(23, 'Set đồ thể thao unisex', 'set-do-the-thao-unisex',
 '<p>Set thể thao 2 món</p>',
 '<p>Bộ đồ thể thao unisex chất cotton thoáng mát.</p>',
 '/storage/photos/1/Products/set_do_thethao_unisex.jpg',
 18, 'M,L,XL', 'hot', 'active', 15, 5.00, 1, 4, 4, 23, NOW(), NOW()),

(24, 'Áo khoác dù chống nắng', 'ao-khoac-du-chong-nang',
 '<p>Áo khoác dù mỏng nhẹ</p>',
 '<p>Áo khoác dù chống nắng, phù hợp đi ngoài trời.</p>',
 '/storage/photos/1/Products/1a69c-image3xxl-4-.jpg',
 22, 'M,L,XL', 'new', 'active', 15, 5.00, 0, 4, 4, 24, NOW(), NOW()),

(25, 'Áo vest nam đen', 'ao-vest-nam-den',
 '<p>Áo vest nam công sở</p>',
 '<p>Áo vest nam màu đen, form chuẩn, sang trọng.</p>',
 '/storage/photos/1/Products/3a815-pmo002a.jpg',
 10, 'M,L,XL', 'default', 'active', 15, 5.00, 1, 1, 1, 25, NOW(), NOW()),
 
 (26, 'Kính râm unisex đen', 'kinh-ram-unisex-den',
 '<p>Kính râm thời trang</p>',
 '<p>Kính râm unisex đen, chống UV400, phong cách hiện đại.</p>',
 '/storage/photos/1/Products/kinhden.jpg',
 20, 'Free', 'default', 'active', 15, 5.00, 1, 13, NULL, 9, NOW(), NOW()),

(27, 'Kính cận gọng tròn', 'kinh-can-gong-tron',
 '<p>Kính cận thời trang</p>',
 '<p>Kính gọng tròn hợp thời trang, nhẹ và bền.</p>',
 '/storage/photos/1/Products/Screenshot (5).png',
 18, 'Free', 'new', 'active', 15, 5.00, 0, 13, NULL, 10, NOW(), NOW()),
 
 (28, 'Áo thun đen tay dài 68', 'ao-thun-den-tay-dai-68',
 '<p>Áo thun đen tay dài 68</p>',
 '<p>Vải 100% cotton, chất lượng cao </p>',
 '/storage/photos/1/Products/ao_den_tay_dai_78 - Copy.jpg',
 18, 'S, M, L', 'hot', 'active', 15, 5.00, 0, 13, NULL, 10, NOW(), NOW()),
 
 (29, 'Đồ cho trẻ em', 'do-tre-em',
 '<p>Đồ cho trẻ em</p>',
 '<p>Đồ trẻ em chất lượng cao</p>',
 '/storage/photos/1/Products/Screenshot (35).png',
 18, 'S, M, L', 'new', 'active', 15, 5.00, 0, 13, NULL, 10, NOW(), NOW());

-- Dumping structure for table shop.product_reviews
CREATE TABLE IF NOT EXISTS `product_reviews` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `product_id` bigint unsigned DEFAULT NULL,
  `rate` tinyint NOT NULL DEFAULT '0',
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_reviews_user_id_foreign` (`user_id`),
  KEY `product_reviews_product_id_foreign` (`product_id`),
  CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  CONSTRAINT `product_reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.product_reviews: ~2 rows (approximately)
DELETE FROM `product_reviews`;
INSERT INTO `product_reviews` (`id`, `user_id`, `product_id`, `rate`, `review`, `status`, `created_at`, `updated_at`) VALUES
	(1, 3, 2, 5, 'nice product', 'active', '2020-08-15 07:44:05', '2020-08-15 07:44:05'),
	(2, 2, 9, 5, 'nice', 'active', '2020-08-17 21:08:14', '2020-08-17 21:18:31');

-- Dumping structure for table shop.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_des` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.settings: ~1 rows (approximately)
DELETE FROM `settings`;
INSERT INTO `settings` VALUES (1,'Discover fashion with purpose.\r\n\r\nOur store offers more than style—it’s a journey of growth and self-expression. Each piece is designed to inspire confidence and reflect inner strength.\r\n\r\nWe believe fashion is intentional. By dressing with meaning, you embrace balance, perseverance, and authenticity.\r\n\r\nLet your wardrobe tell your story.\r\n\r\nWelcome to meaningful fashion.','^-^','/storage/photos/1/logo.png','/storage/photos/1/blog3.jpg','140 Lê Trọng Tấn, Tân Phú, TP Hồ Chí Minh','+080 (666) 276-904','team7@gmail.com',NULL,'2025-08-14 01:49:09');

-- Dumping structure for table shop.shippings
CREATE TABLE IF NOT EXISTS `shippings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.shippings: ~4 rows (approximately)
DELETE FROM `shippings`;
INSERT INTO `shippings` (`id`, `type`, `price`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Kahtmandu', 100.00, 'active', '2020-08-14 04:22:17', '2020-08-14 04:22:17'),
	(2, 'Out of valley', 300.00, 'active', '2020-08-14 04:22:41', '2020-08-14 04:22:41'),
	(3, 'Pokhara', 400.00, 'active', '2020-08-15 06:54:04', '2020-08-15 06:54:04'),
	(4, 'Dharan', 400.00, 'active', '2020-08-17 20:50:48', '2020-08-17 20:50:48'),
	(5, 'GL', 77.00, 'active', '2025-09-13 04:35:54', '2025-09-13 04:35:54');

-- Dumping structure for table shop.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('admin','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `provider` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.users: ~16 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `photo`, `role`, `provider`, `provider_id`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'GL-Cute', 'admin@gmail.com', NULL, '$2y$10$GOGIJdzJydYJ5nAZ42iZNO3IL1fdvXoSPdUOH3Ajy5hRmi0xBmTzm', 'http://localhost/Complete-Ecommerce-in-laravel-10-master/public/storage/photos/1/users/user1.jpg', 'admin', NULL, NULL, 'active', 'wI0oRfwpJiE2ds4wN8o00nuC2qqX4f8NjvKakFI0wrqxUsq8NoEu8mI6pmLz', NULL, '2025-09-13 04:39:44'),
	(2, 'User', 'user@gmail.com', NULL, '$2y$10$10jB2lupSfvAUfocjguzSeN95LkwgZJUM7aQBdb2Op7XzJ.BhNoHq', '/storage/photos/1/users/user2.jpg', 'user', NULL, NULL, 'active', NULL, NULL, '2020-08-15 07:30:07'),
	(3, 'Prajwal Rai', 'prajwal.iar@gmail.com', NULL, '$2y$10$15ZVMgH040v4Ukf9KSAFiucPJcfDwmeRKCaguVJBXplTs93m48F1G', '/storage/photos/1/users/user3.jpg', 'user', NULL, NULL, 'active', NULL, '2020-08-11 04:20:58', '2020-08-15 07:56:58'),
	(4, 'Cynthia Beier', 'ernestina.wehner@example.net', '2020-08-14 21:18:52', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user', NULL, NULL, 'active', 'fzmQDfEoaP', '2020-08-14 21:18:52', '2020-08-14 21:18:52'),
	(5, 'Prof. Maybell Zulauf', 'wolf.harvey@example.org', '2020-08-14 21:18:52', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user', NULL, NULL, 'active', 'B8cYq4huyT', '2020-08-14 21:18:54', '2020-08-14 21:18:54'),
	(6, 'Diego Lind II', 'schroeder.emile@example.net', '2025-08-14 21:18:52', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user', NULL, NULL, 'active', 'xLUaF26dE1', '2020-08-14 21:18:54', '2020-08-14 21:18:54'),
	(7, 'Ian Macejkovic', 'ashlee16@example.com', '2025-08-14 21:18:52', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user', NULL, NULL, 'active', 'i2ZIKbiM9O', '2020-08-12 21:18:54', '2020-08-14 21:18:54'),
	(8, 'Perry McClure DDS', 'mayer.ashlynn@example.org', '2025-08-14 21:18:52', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user', NULL, NULL, 'active', 'VD1MlsvW3I', '2020-08-14 21:18:55', '2020-08-14 21:18:55'),
	(9, 'Juana Yost', 'carter47@example.net', '2025-08-14 21:19:50', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user', NULL, NULL, 'active', 'kARxoay0FT', '2020-08-11 21:19:50', '2020-08-14 21:19:50'),
	(10, 'Louvenia Will DDS', 'lowell06@example.net', '2025-08-14 21:19:50', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user', NULL, NULL, 'active', 'QkbNNnO7ZG', '2020-08-10 21:19:50', '2020-08-14 21:19:50'),
	(11, 'Miss Layla McClure', 'dcummings@example.com', '2025-08-14 21:19:50', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user', NULL, NULL, 'active', 'DFnCS0bKFa', '2020-08-08 21:19:51', '2020-08-14 21:19:51'),
	(12, 'Mrs. Taya Ziemann', 'anderson.luz@example.net', '2025-08-14 21:19:50', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user', NULL, NULL, 'active', '4Xgvb1HnFT', '2020-08-09 21:19:51', '2020-08-14 21:19:51'),
	(13, 'Porter Olson', 'jaden24@example.com', '2025-08-14 21:19:50', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user', NULL, NULL, 'active', 'gFX2w4WaMj', '2020-08-14 21:19:51', '2020-08-14 21:19:51'),
	(29, 'Prajwal Rai', 'rae.prajwal@gmail.com', '2025-09-14 14:04:53', NULL, NULL, 'user', 'google', '110717103019405487938', 'active', NULL, '2020-08-15 07:36:29', '2020-08-15 07:36:29'),
	(30, 'Tàu Hủ Bánh Lọt aka Gia Linh', 'gialinh.29032004@gmail.com', '2025-09-14 14:04:50', '$2y$10$N/AkF97i8OYr4H3fHp/2dO4skVJu1x1AXkXVU5U.8iw4S8YPFh/0e', NULL, 'user', NULL, NULL, 'active', NULL, '2025-09-14 04:56:09', '2025-09-14 04:56:09'),
	(31, 'Tàu Hủ Bánh Lọt aka Gia Linh', 'banhlot@gmail.com', '2025-09-14 14:04:45', '$2y$10$a6YQkUFBtzCP6GHQlQrvCewl.5y.nyIno66Ts/oO4Ix9ljiL3oAiW', NULL, 'user', NULL, NULL, 'active', NULL, '2025-09-14 07:03:58', '2025-09-14 07:03:58');

-- Dumping structure for table shop.wishlists
CREATE TABLE IF NOT EXISTS `wishlists` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `cart_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `price` double(8,2) NOT NULL,
  `quantity` int NOT NULL,
  `amount` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wishlists_product_id_foreign` (`product_id`),
  KEY `wishlists_user_id_foreign` (`user_id`),
  KEY `wishlists_cart_id_foreign` (`cart_id`),
  CONSTRAINT `wishlists_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `wishlists_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table shop.wishlists: ~0 rows (approximately)
DELETE FROM `wishlists`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
-- productsproductsshopproducts
