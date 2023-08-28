-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: new_canteen1
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.22.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Transaction`
--

DROP TABLE IF EXISTS `Transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(8,2) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `collection_id` bigint NOT NULL,
  `created_by_id` int NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Transaction_collection_id_802c28b0_fk_collection_id` (`collection_id`),
  KEY `Transaction_created_by_id_ede5a347_fk_auth_user_id` (`created_by_id`),
  KEY `Transaction_order_id_2959c101_fk_orders_id` (`order_id`),
  KEY `Transaction_user_id_cb49484d_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Transaction_collection_id_802c28b0_fk_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `collection` (`id`),
  CONSTRAINT `Transaction_created_by_id_ede5a347_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `Transaction_order_id_2959c101_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `Transaction_user_id_cb49484d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction`
--

LOCK TABLES `Transaction` WRITE;
/*!40000 ALTER TABLE `Transaction` DISABLE KEYS */;
INSERT INTO `Transaction` VALUES (1,81.00,1,'2023-08-01 09:41:48.871715','2023-08-01 09:41:48.871786',1,14,1,14),(2,81.00,0,'2023-08-01 09:42:16.985138','2023-08-01 09:42:16.985151',1,4,1,14),(3,81.00,1,'2023-08-01 09:43:11.779687','2023-08-01 09:43:11.779741',1,14,2,14),(4,81.00,1,'2023-08-01 09:44:15.295794','2023-08-01 09:44:15.295823',1,14,3,14),(5,81.00,1,'2023-08-01 09:45:00.556426','2023-08-01 09:45:00.556438',1,14,4,14),(6,81.00,1,'2023-08-01 09:51:29.661635','2023-08-01 09:51:29.661669',1,14,5,14),(7,213.00,1,'2023-08-01 11:21:44.239282','2023-08-01 11:21:44.239297',1,11,6,11),(8,213.00,0,'2023-08-01 11:22:33.920767','2023-08-01 11:22:33.920786',1,4,6,11),(9,81.00,1,'2023-08-01 11:34:23.270950','2023-08-01 11:34:23.270983',1,14,7,14),(10,81.00,1,'2023-08-01 11:36:27.301830','2023-08-01 11:36:27.301844',1,14,8,14),(11,81.00,0,'2023-08-01 11:36:53.602370','2023-08-01 11:36:53.602414',1,4,8,14),(12,81.00,0,'2023-08-01 12:48:20.882460','2023-08-01 12:48:20.882475',1,4,7,14),(13,81.00,0,'2023-08-01 12:50:01.398692','2023-08-01 12:50:01.398709',1,4,7,14),(14,81.00,0,'2023-08-01 12:53:15.544469','2023-08-01 12:53:15.544494',1,4,7,14),(15,81.00,0,'2023-08-01 12:56:43.740487','2023-08-01 12:56:43.740503',1,4,2,14),(16,81.00,0,'2023-08-01 12:57:37.805152','2023-08-01 12:57:37.805191',1,4,2,14),(17,81.00,0,'2023-08-01 13:02:06.421539','2023-08-01 13:02:06.421557',1,4,2,14),(18,81.00,1,'2023-08-01 13:07:57.191232','2023-08-01 13:07:57.191284',1,14,9,14),(19,81.00,1,'2023-08-01 13:09:25.236106','2023-08-01 13:09:25.236146',1,14,10,14),(20,81.00,1,'2023-08-01 13:10:25.286177','2023-08-01 13:10:25.286223',1,14,11,14),(21,81.00,0,'2023-08-01 13:12:02.253414','2023-08-01 13:12:02.253427',1,4,11,14),(22,186.00,1,'2023-08-01 13:12:56.250917','2023-08-01 13:12:56.250931',1,14,12,14),(23,186.00,0,'2023-08-01 13:14:46.371742','2023-08-01 13:14:46.371754',1,4,12,14),(24,105.00,1,'2023-08-01 13:15:09.261323','2023-08-01 13:15:09.261365',1,14,13,14),(25,105.00,1,'2023-08-01 13:15:17.045572','2023-08-01 13:15:17.045583',1,14,14,14),(26,105.00,1,'2023-08-01 13:15:26.343886','2023-08-01 13:15:26.343899',1,14,15,14),(27,62.00,1,'2023-08-02 09:42:17.199865','2023-08-02 09:42:17.199934',1,16,16,16),(28,97.00,1,'2023-08-02 09:45:12.013234','2023-08-02 09:45:12.013306',1,16,17,16),(29,35.00,1,'2023-08-02 09:46:01.457582','2023-08-02 09:46:01.457614',1,16,18,16),(30,54.00,1,'2023-08-02 09:46:17.740162','2023-08-02 09:46:17.740210',1,16,19,16),(31,105.00,1,'2023-08-02 09:46:32.182411','2023-08-02 09:46:32.182480',1,16,20,16),(32,67.00,1,'2023-08-02 09:49:00.518724','2023-08-02 09:49:00.518769',1,16,21,16),(33,80.00,1,'2023-08-02 09:49:23.189151','2023-08-02 09:49:23.189178',1,16,22,16),(34,10.00,1,'2023-08-02 09:50:11.873724','2023-08-02 09:50:11.873813',1,10,23,10),(35,297.00,1,'2023-08-02 09:53:42.347755','2023-08-02 09:53:42.347818',1,11,24,11),(36,157.00,1,'2023-08-02 11:27:06.622972','2023-08-02 11:27:06.623050',1,16,25,16),(37,10.00,1,'2023-08-02 13:34:13.039320','2023-08-02 13:34:13.039348',1,16,26,16),(38,10.00,1,'2023-08-03 05:37:12.486050','2023-08-03 05:37:12.486081',1,16,27,16),(39,10.00,1,'2023-08-03 06:12:22.693168','2023-08-03 06:12:22.693187',1,11,28,11),(40,20.00,1,'2023-08-03 06:30:43.210217','2023-08-03 06:30:43.210293',1,16,29,16),(41,20.00,1,'2023-08-03 06:30:55.506022','2023-08-03 06:30:55.506052',1,16,30,16),(42,105.00,1,'2023-08-03 06:31:41.784901','2023-08-03 06:31:41.784938',1,10,31,10),(43,105.00,1,'2023-08-03 06:32:27.289838','2023-08-03 06:32:27.289861',1,10,32,10),(44,10.00,1,'2023-08-03 06:34:26.937803','2023-08-03 06:34:26.937878',1,11,33,11),(45,105.00,1,'2023-08-03 06:34:29.095135','2023-08-03 06:34:29.095182',1,10,34,10),(46,105.00,1,'2023-08-03 06:38:24.458150','2023-08-03 06:38:24.458190',1,10,35,10),(47,20.00,0,'2023-08-03 06:41:30.196248','2023-08-03 06:41:30.196304',1,4,29,16),(48,10.00,0,'2023-08-03 06:50:39.356130','2023-08-03 06:50:39.356170',1,4,26,16),(49,80.00,0,'2023-08-03 08:04:56.627931','2023-08-03 08:04:56.628004',1,4,22,16),(50,157.00,0,'2023-08-03 08:05:08.797895','2023-08-03 08:05:08.797963',1,4,25,16),(51,105.00,0,'2023-08-03 08:39:25.376313','2023-08-03 08:39:25.376328',1,4,35,10),(52,105.00,0,'2023-08-03 08:39:28.356232','2023-08-03 08:39:28.356283',1,4,35,10),(53,70.00,1,'2023-08-03 08:40:10.858148','2023-08-03 08:40:10.858213',1,16,36,16),(54,35.00,1,'2023-08-03 08:41:25.948997','2023-08-03 08:41:25.949021',1,16,37,16),(55,35.00,0,'2023-08-03 08:41:44.318191','2023-08-03 08:41:44.318243',1,4,37,16),(56,40.00,1,'2023-08-03 08:42:15.411506','2023-08-03 08:42:15.411611',1,16,38,16),(57,40.00,1,'2023-08-03 08:42:42.106738','2023-08-03 08:42:42.106832',1,16,39,16),(58,35.00,1,'2023-08-03 08:45:24.505421','2023-08-03 08:45:24.505436',1,16,40,16),(59,35.00,0,'2023-08-03 08:49:00.309033','2023-08-03 08:49:00.309063',1,4,40,16),(60,70.00,0,'2023-08-03 08:49:15.175869','2023-08-03 08:49:15.175905',1,4,36,16),(61,40.00,0,'2023-08-03 08:50:32.893855','2023-08-03 08:50:32.893896',1,4,39,16),(62,40.00,0,'2023-08-03 08:50:58.406116','2023-08-03 08:50:58.406149',1,4,39,16),(63,40.00,1,'2023-08-03 09:11:40.020149','2023-08-03 09:11:40.020191',1,16,41,16),(64,45.00,1,'2023-08-03 09:12:10.866245','2023-08-03 09:12:10.866338',1,16,42,16),(65,520.00,1,'2023-08-03 09:29:28.829396','2023-08-03 09:29:28.829445',1,11,43,11),(66,45.00,0,'2023-08-03 09:43:47.498241','2023-08-03 09:43:47.498289',1,4,42,16),(67,45.00,0,'2023-08-03 09:43:50.623594','2023-08-03 09:43:50.623626',1,4,42,16),(68,40.00,0,'2023-08-03 10:39:18.039779','2023-08-03 10:39:18.039817',1,4,41,16),(69,40.00,0,'2023-08-03 10:39:19.997073','2023-08-03 10:39:19.997105',1,4,41,16),(70,40.00,0,'2023-08-03 10:39:20.104742','2023-08-03 10:39:20.104779',1,4,41,16),(71,40.00,0,'2023-08-03 10:39:20.594412','2023-08-03 10:39:20.594428',1,4,41,16),(72,40.00,0,'2023-08-03 10:39:20.647356','2023-08-03 10:39:20.647374',1,4,41,16),(73,40.00,0,'2023-08-03 10:39:20.914060','2023-08-03 10:39:20.914077',1,4,41,16),(74,40.00,0,'2023-08-03 10:39:21.544030','2023-08-03 10:39:21.544066',1,4,41,16),(75,40.00,0,'2023-08-03 10:39:21.681292','2023-08-03 10:39:21.681340',1,4,41,16),(76,115.00,1,'2023-08-03 11:12:20.570495','2023-08-03 11:12:20.570581',1,16,44,16),(77,610.00,1,'2023-08-03 11:15:01.076567','2023-08-03 11:15:01.076602',1,16,45,16),(78,610.00,0,'2023-08-03 11:15:34.490741','2023-08-03 11:15:34.490837',1,4,45,16),(79,115.00,0,'2023-08-03 11:15:47.135908','2023-08-03 11:15:47.135980',1,4,44,16),(80,80.00,1,'2023-08-03 11:17:42.953283','2023-08-03 11:17:42.953368',1,16,46,16),(81,80.00,0,'2023-08-03 11:17:47.313044','2023-08-03 11:17:47.313079',1,4,46,16);
/*!40000 ALTER TABLE `Transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'user');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,1,46),(47,1,47),(48,1,48),(49,1,49),(50,1,50),(51,1,51),(52,1,52),(53,1,53),(54,1,54),(55,1,55),(56,1,56),(57,1,57),(58,1,58),(59,1,59),(60,1,60),(61,1,61),(62,1,62),(63,1,63),(64,1,64),(65,1,65),(66,1,66),(67,1,67),(68,1,68),(69,1,69),(70,1,70),(71,1,71),(72,1,72),(73,1,73),(74,1,74),(75,1,75),(76,1,76),(77,1,77),(78,1,78),(79,1,79),(80,1,80),(81,1,81),(82,1,82),(83,1,83),(84,1,84);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add category',7,'add_category'),(26,'Can change category',7,'change_category'),(27,'Can delete category',7,'delete_category'),(28,'Can view category',7,'view_category'),(29,'Can add user social',8,'add_usersocial'),(30,'Can change user social',8,'change_usersocial'),(31,'Can delete user social',8,'delete_usersocial'),(32,'Can view user social',8,'view_usersocial'),(33,'Can add user profile',9,'add_userprofile'),(34,'Can change user profile',9,'change_userprofile'),(35,'Can delete user profile',9,'delete_userprofile'),(36,'Can view user profile',9,'view_userprofile'),(37,'Can add forgot password',10,'add_forgotpassword'),(38,'Can change forgot password',10,'change_forgotpassword'),(39,'Can delete forgot password',10,'delete_forgotpassword'),(40,'Can view forgot password',10,'view_forgotpassword'),(41,'Can add Token',11,'add_token'),(42,'Can change Token',11,'change_token'),(43,'Can delete Token',11,'delete_token'),(44,'Can view Token',11,'view_token'),(45,'Can add token',12,'add_tokenproxy'),(46,'Can change token',12,'change_tokenproxy'),(47,'Can delete token',12,'delete_tokenproxy'),(48,'Can view token',12,'view_tokenproxy'),(49,'Can add product',13,'add_product'),(50,'Can change product',13,'change_product'),(51,'Can delete product',13,'delete_product'),(52,'Can view product',13,'view_product'),(53,'Can add cafe times',14,'add_cafetimes'),(54,'Can change cafe times',14,'change_cafetimes'),(55,'Can delete cafe times',14,'delete_cafetimes'),(56,'Can view cafe times',14,'view_cafetimes'),(57,'Can add collection',15,'add_collection'),(58,'Can change collection',15,'change_collection'),(59,'Can delete collection',15,'delete_collection'),(60,'Can view collection',15,'view_collection'),(61,'Can add order',16,'add_order'),(62,'Can change order',16,'change_order'),(63,'Can delete order',16,'delete_order'),(64,'Can view order',16,'view_order'),(65,'Can add wallet',17,'add_wallet'),(66,'Can change wallet',17,'change_wallet'),(67,'Can delete wallet',17,'delete_wallet'),(68,'Can view wallet',17,'view_wallet'),(69,'Can add transaction',18,'add_transaction'),(70,'Can change transaction',18,'change_transaction'),(71,'Can delete transaction',18,'delete_transaction'),(72,'Can view transaction',18,'view_transaction'),(73,'Can add order items',19,'add_orderitems'),(74,'Can change order items',19,'change_orderitems'),(75,'Can delete order items',19,'delete_orderitems'),(76,'Can view order items',19,'view_orderitems'),(77,'Can add cart',20,'add_cart'),(78,'Can change cart',20,'change_cart'),(79,'Can delete cart',20,'delete_cart'),(80,'Can view cart',20,'view_cart'),(81,'Can add FCM device',21,'add_fcmdevice'),(82,'Can change FCM device',21,'change_fcmdevice'),(83,'Can delete FCM device',21,'delete_fcmdevice'),(84,'Can view FCM device',21,'view_fcmdevice'),(85,'Can add user session',22,'add_usersession'),(86,'Can change user session',22,'change_usersession'),(87,'Can delete user session',22,'delete_usersession'),(88,'Can view user session',22,'view_usersession'),(89,'Can add custom token',23,'add_customtoken'),(90,'Can change custom token',23,'change_customtoken'),(91,'Can delete custom token',23,'delete_customtoken'),(92,'Can view custom token',23,'view_customtoken');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (4,'pbkdf2_sha256$260000$QLdcTqHiZLAcTHAjUmwBNB$oZedWGO/g+Zr/QcNEjcKpp0aPDs8FviCqyl8thvRbFI=','2023-08-01 09:41:31.327965',1,'admin','','','admin@yopmail.com',1,1,'2023-07-31 11:26:28.504633'),(5,'pbkdf2_sha256$260000$KxZbLL2BatSLbU6Nn32gJd$klhizC7LNoiWvq3zGJOKodk3a7vIwHe/5dn3tVcN7S8=','2023-08-02 13:02:48.376258',0,'210','sahil','das','ridham@yopmail.com',0,1,'2023-07-31 11:27:29.004004'),(6,'pbkdf2_sha256$260000$Lmm9oGtuUPDHqiClipOt25$CSVxo8XLhiIO+vdb8cRsonHTyK8DeffqCINNPg28PJg=','2023-08-03 11:23:25.809159',0,'211','shubham','chicmic','shubham11@yopmail.com',0,1,'2023-07-31 11:30:08.000000'),(8,'pbkdf2_sha256$260000$B8jkxyvnsdKuKC950WCzCt$Ecb7121PdHUGtio7dmhF5B1sMTSoNPDh93cA4AQfQGc=','2023-08-01 05:30:48.969363',0,'605','tgfhdtyu','rtdyx','shobhit@yopmail.com',0,1,'2023-07-31 11:35:17.698295'),(9,'pbkdf2_sha256$260000$PfmgFoNWLSks5Ynj22bB2k$b6gCUB/fWoCzf36qAPU86wjiuAq/zQ7Wf7JpUL0byio=','2023-08-01 13:55:39.038712',0,'571','Ritvik','','ritvikgarg@yopmail.com',0,1,'2023-07-31 11:43:52.000000'),(10,'pbkdf2_sha256$260000$UyskaXVyl3klHO8m0QyxwT$xIySNM4QFF9TvJ9x3vd8Xz4rl6jSgUlQ7gfFx5DgRo4=','2023-08-03 10:39:20.676938',0,'601','shobhit','werg','shobhit1@yopmail.com',0,1,'2023-07-31 12:06:27.000000'),(11,'pbkdf2_sha256$260000$TDRlGi8stsUvGE0v2vpKI1$1ApBA2rEF5uvZ3af2BkVSxWvOp9XK2wDXUzbJ9tfOSc=','2023-08-03 09:22:11.186287',0,'783','sahil','ji','shahil1@yopmail.com',0,1,'2023-08-01 05:21:43.000000'),(14,'pbkdf2_sha256$260000$532ShwLRf2MUG3VVAb2Gt2$Yof3ADcnxVYserm8kzoApu1/eRTeJAZ70qZGrJETmX4=','2023-08-02 07:27:15.365938',0,'787','shobhit','','shobhit123@yopmail.com',0,1,'2023-08-01 09:34:13.999828'),(15,'pbkdf2_sha256$260000$n6kBIzkFx2wxERG4eayl2D$uMqBGFtp2LQWNZ2+XYOa968YWVC4EaKg/TCPb8cObpw=','2023-08-01 10:41:58.407762',1,'test','','','test@yopmail.com',1,1,'2023-08-01 10:37:56.945111'),(16,'pbkdf2_sha256$260000$1k74NeY5ugoWGWdRJ58bcz$uVpzgE+LfoKkLEOe3NIZVj++4oajVpbMvQOaaFt5l64=','2023-08-03 11:12:08.875468',0,'541','Ritvik Garg','','canteenuser@yopmail.com',0,1,'2023-08-02 04:34:43.798238'),(17,'pbkdf2_sha256$260000$gEMWvrMmaT9liXWvqzuneg$mS8bOBR8G/VDoBwsjLzeAHGueG9ArT88YQglxiCpM5A=',NULL,0,'563','sahil','animesh','sahil@yopmail.com',0,1,'2023-08-02 10:49:57.470437'),(19,'pbkdf2_sha256$260000$5SnEWna3SIDchGPct6sU5u$xMlGD9ozPb3LXc70bnWoTguBEWdPk25CkGv/LVDIvbQ=','2023-08-03 10:11:43.951540',0,'780','shobhit','ji','abhishek@yopmail.com',0,1,'2023-08-03 05:38:38.344738'),(20,'pbkdf2_sha256$260000$wphaA0aqoKsk0w5w8xkME7$Ob6SpqEb2lyfrmWa97sD6N/B+ufSW0IgtzK5vJ3mM14=',NULL,0,'111','Ritvik','','ritviktest@yopmail.com',0,0,'2023-08-03 10:17:21.941724'),(21,'pbkdf2_sha256$260000$2LN3N1VaJxm2C1yT9MmCaM$pdGDDSSEhL/ZXcy+u82n8EOsND4FKC3B3584ICZp2X0=',NULL,0,'504','Sumit','','sumit@yopmail.com',0,0,'2023-08-03 11:12:03.876844');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (3,9,1),(2,11,1),(1,14,1),(4,16,1),(5,17,1),(6,19,1),(7,20,1),(8,21,1);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=337 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (85,6,1),(86,6,2),(87,6,3),(88,6,4),(89,6,5),(90,6,6),(91,6,7),(92,6,8),(93,6,9),(94,6,10),(95,6,11),(96,6,12),(97,6,13),(98,6,14),(99,6,15),(100,6,16),(101,6,17),(102,6,18),(103,6,19),(104,6,20),(105,6,21),(106,6,22),(107,6,23),(108,6,24),(109,6,25),(110,6,26),(111,6,27),(112,6,28),(113,6,29),(114,6,30),(115,6,31),(116,6,32),(117,6,33),(118,6,34),(119,6,35),(120,6,36),(121,6,37),(122,6,38),(123,6,39),(124,6,40),(125,6,41),(126,6,42),(127,6,43),(128,6,44),(129,6,45),(130,6,46),(131,6,47),(132,6,48),(133,6,49),(134,6,50),(135,6,51),(136,6,52),(137,6,53),(138,6,54),(139,6,55),(140,6,56),(141,6,57),(142,6,58),(143,6,59),(144,6,60),(145,6,61),(146,6,62),(147,6,63),(148,6,64),(149,6,65),(150,6,66),(151,6,67),(152,6,68),(153,6,69),(154,6,70),(155,6,71),(156,6,72),(157,6,73),(158,6,74),(159,6,75),(160,6,76),(161,6,77),(162,6,78),(163,6,79),(164,6,80),(165,6,81),(166,6,82),(167,6,83),(168,6,84),(1,9,1),(2,9,2),(3,9,3),(4,9,4),(5,9,5),(6,9,6),(7,9,7),(8,9,8),(9,9,9),(10,9,10),(11,9,11),(12,9,12),(13,9,13),(14,9,14),(15,9,15),(16,9,16),(17,9,17),(18,9,18),(19,9,19),(20,9,20),(21,9,21),(22,9,22),(23,9,23),(24,9,24),(25,9,25),(26,9,26),(27,9,27),(28,9,28),(29,9,29),(30,9,30),(31,9,31),(32,9,32),(33,9,33),(34,9,34),(35,9,35),(36,9,36),(37,9,37),(38,9,38),(39,9,39),(40,9,40),(41,9,41),(42,9,42),(43,9,43),(44,9,44),(45,9,45),(46,9,46),(47,9,47),(48,9,48),(49,9,49),(50,9,50),(51,9,51),(52,9,52),(53,9,53),(54,9,54),(55,9,55),(56,9,56),(57,9,57),(58,9,58),(59,9,59),(60,9,60),(61,9,61),(62,9,62),(63,9,63),(64,9,64),(65,9,65),(66,9,66),(67,9,67),(68,9,68),(69,9,69),(70,9,70),(71,9,71),(72,9,72),(73,9,73),(74,9,74),(75,9,75),(76,9,76),(77,9,77),(78,9,78),(79,9,79),(80,9,80),(81,9,81),(82,9,82),(83,9,83),(84,9,84),(169,10,1),(170,10,2),(171,10,3),(172,10,4),(173,10,5),(174,10,6),(175,10,7),(176,10,8),(177,10,9),(178,10,10),(179,10,11),(180,10,12),(181,10,13),(182,10,14),(183,10,15),(184,10,16),(185,10,17),(186,10,18),(187,10,19),(188,10,20),(189,10,21),(190,10,22),(191,10,23),(192,10,24),(193,10,25),(194,10,26),(195,10,27),(196,10,28),(197,10,29),(198,10,30),(199,10,31),(200,10,32),(201,10,33),(202,10,34),(203,10,35),(204,10,36),(205,10,37),(206,10,38),(207,10,39),(208,10,40),(209,10,41),(210,10,42),(211,10,43),(212,10,44),(213,10,45),(214,10,46),(215,10,47),(216,10,48),(217,10,49),(218,10,50),(219,10,51),(220,10,52),(221,10,53),(222,10,54),(223,10,55),(224,10,56),(225,10,57),(226,10,58),(227,10,59),(228,10,60),(229,10,61),(230,10,62),(231,10,63),(232,10,64),(233,10,65),(234,10,66),(235,10,67),(236,10,68),(237,10,69),(238,10,70),(239,10,71),(240,10,72),(241,10,73),(242,10,74),(243,10,75),(244,10,76),(245,10,77),(246,10,78),(247,10,79),(248,10,80),(249,10,81),(250,10,82),(251,10,83),(252,10,84),(253,11,1),(254,11,2),(255,11,3),(256,11,4),(257,11,5),(258,11,6),(259,11,7),(260,11,8),(261,11,9),(262,11,10),(263,11,11),(264,11,12),(265,11,13),(266,11,14),(267,11,15),(268,11,16),(269,11,17),(270,11,18),(271,11,19),(272,11,20),(273,11,21),(274,11,22),(275,11,23),(276,11,24),(277,11,25),(278,11,26),(279,11,27),(280,11,28),(281,11,29),(282,11,30),(283,11,31),(284,11,32),(285,11,33),(286,11,34),(287,11,35),(288,11,36),(289,11,37),(290,11,38),(291,11,39),(292,11,40),(293,11,41),(294,11,42),(295,11,43),(296,11,44),(297,11,45),(298,11,46),(299,11,47),(300,11,48),(301,11,49),(302,11,50),(303,11,51),(304,11,52),(305,11,53),(306,11,54),(307,11,55),(308,11,56),(309,11,57),(310,11,58),(311,11,59),(312,11,60),(313,11,61),(314,11,62),(315,11,63),(316,11,64),(317,11,65),(318,11,66),(319,11,67),(320,11,68),(321,11,69),(322,11,70),(323,11,71),(324,11,72),(325,11,73),(326,11,74),(327,11,75),(328,11,76),(329,11,77),(330,11,78),(331,11,79),(332,11,80),(333,11,81),(334,11,82),(335,11,83),(336,11,84);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('38bba7f9bd7c99642236f5bf3977aadbfa7d0797','2023-08-03 10:11:43.947374',19),('4b53a80aa9325a764224089d912bbbad330537ad','2023-08-03 10:39:20.674698',10),('9d047938bf1b33248a7e343f543ab3bb38498a91','2023-08-03 11:23:25.805914',6),('a3bba479b7cea5dd078e932b961cd5e045aba914','2023-08-02 07:27:15.363217',14),('a4aa944e42d142f0d7ad8a9f493e0c6fe54c6b31','2023-08-01 13:55:39.035064',9),('b0a423a276d46ccaea8c7d7c951e928fb2f0b110','2023-08-03 11:12:08.873616',16),('c16edfd843a4d3eeaa4c341462969607e2a93d49','2023-08-02 13:02:48.372442',5),('df2d7f0b23275fded6b3d93f94df6a947d5b5641','2023-08-03 09:22:11.183536',11);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cafe_times`
--

DROP TABLE IF EXISTS `cafe_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cafe_times` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `startTime` time(6) NOT NULL,
  `endTime` time(6) NOT NULL,
  `is_open` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cafe_times`
--

LOCK TABLES `cafe_times` WRITE;
/*!40000 ALTER TABLE `cafe_times` DISABLE KEYS */;
INSERT INTO `cafe_times` VALUES (1,'11:27:29.050636','11:27:29.050636',1);
/*!40000 ALTER TABLE `cafe_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_product_id_508e72da_fk_products_id` (`product_id`),
  KEY `cart_user_id_1361a739_fk_auth_user_id` (`user_id`),
  CONSTRAINT `cart_product_id_508e72da_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `cart_user_id_1361a739_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `cart_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (7,2,'2023-08-01 11:13:48.463682','2023-08-01 11:16:57.432463',1,9);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `ref_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_ref_user_id_015a443c_fk_auth_user_id` (`ref_user_id`),
  CONSTRAINT `categories_ref_user_id_015a443c_fk_auth_user_id` FOREIGN KEY (`ref_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'snacks','category_images/snacks_WY7R6ba.jpeg',1,4),(2,'lunch','category_images/breakfast.jpeg',1,4),(3,'Breakfast','category_images/rajma-chawal-1.jpeg',1,4),(4,'Shakes','category_images/rajma-chawal-1_FScI8yd.jpeg',1,4);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collection`
--

DROP TABLE IF EXISTS `collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collection` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount_credited` double DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `spare_amount` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collection`
--

LOCK TABLES `collection` WRITE;
/*!40000 ALTER TABLE `collection` DISABLE KEYS */;
INSERT INTO `collection` VALUES (1,0,'2023-07-31 11:27:29.050636',0,0);
/*!40000 ALTER TABLE `collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-08-01 09:34:10.776872','1','user',1,'[{\"added\": {}}]',3,4),(2,'2023-08-01 09:41:44.114673','2','Wallet object (2)',2,'[{\"changed\": {\"fields\": [\"Balance\"]}}]',17,4),(3,'2023-08-01 10:42:25.850439','9','571',2,'[{\"changed\": {\"fields\": [\"User permissions\"]}}]',4,15),(4,'2023-08-01 10:42:44.564683','6','211',2,'[{\"changed\": {\"fields\": [\"User permissions\"]}}]',4,15),(5,'2023-08-01 10:42:51.382912','10','601',2,'[{\"changed\": {\"fields\": [\"User permissions\"]}}]',4,15),(6,'2023-08-01 10:43:08.417917','11','783',2,'[{\"changed\": {\"fields\": [\"Groups\", \"User permissions\"]}}]',4,15),(7,'2023-08-01 10:43:22.915682','9','571',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,15),(8,'2023-08-02 09:41:01.707453','10','Wallet object (10)',2,'[{\"changed\": {\"fields\": [\"Balance\"]}}]',17,15);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'administrator','category'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(11,'authtoken','token'),(12,'authtoken','tokenproxy'),(5,'contenttypes','contenttype'),(21,'fcm_django','fcmdevice'),(14,'ordersmanagement','cafetimes'),(20,'ordersmanagement','cart'),(15,'ordersmanagement','collection'),(16,'ordersmanagement','order'),(19,'ordersmanagement','orderitems'),(18,'ordersmanagement','transaction'),(17,'ordersmanagement','wallet'),(13,'products','product'),(6,'sessions','session'),(23,'sitepanel','customtoken'),(10,'sitepanel','forgotpassword'),(9,'sitepanel','userprofile'),(22,'sitepanel','usersession'),(8,'sitepanel','usersocial');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-08-01 09:09:31.721268'),(2,'auth','0001_initial','2023-08-01 09:09:31.928205'),(3,'admin','0001_initial','2023-08-01 09:09:32.048802'),(4,'admin','0002_logentry_remove_auto_add','2023-08-01 09:09:32.055285'),(5,'admin','0003_logentry_add_action_flag_choices','2023-08-01 09:09:32.060065'),(6,'administrator','0001_initial','2023-08-01 09:09:32.092563'),(7,'contenttypes','0002_remove_content_type_name','2023-08-01 09:09:32.138493'),(8,'auth','0002_alter_permission_name_max_length','2023-08-01 09:09:32.167700'),(9,'auth','0003_alter_user_email_max_length','2023-08-01 09:09:32.194946'),(10,'auth','0004_alter_user_username_opts','2023-08-01 09:09:32.207895'),(11,'auth','0005_alter_user_last_login_null','2023-08-01 09:09:32.230536'),(12,'auth','0006_require_contenttypes_0002','2023-08-01 09:09:32.233375'),(13,'auth','0007_alter_validators_add_error_messages','2023-08-01 09:09:32.241151'),(14,'auth','0008_alter_user_username_max_length','2023-08-01 09:09:32.265915'),(15,'auth','0009_alter_user_last_name_max_length','2023-08-01 09:09:32.426393'),(16,'auth','0010_alter_group_name_max_length','2023-08-01 09:09:32.457757'),(17,'auth','0011_update_proxy_permissions','2023-08-01 09:09:32.479350'),(18,'auth','0012_alter_user_first_name_max_length','2023-08-01 09:09:32.523459'),(19,'authtoken','0001_initial','2023-08-01 09:09:32.558657'),(20,'authtoken','0002_auto_20160226_1747','2023-08-01 09:09:32.574980'),(21,'authtoken','0003_tokenproxy','2023-08-01 09:09:32.577200'),(22,'fcm_django','0001_initial','2023-08-01 09:09:32.633904'),(23,'fcm_django','0002_auto_20160808_1645','2023-08-01 09:09:32.669542'),(24,'fcm_django','0003_auto_20170313_1314','2023-08-01 09:09:32.684325'),(25,'fcm_django','0004_auto_20181128_1642','2023-08-01 09:09:32.699359'),(26,'fcm_django','0005_auto_20170808_1145','2023-08-01 09:09:32.705995'),(27,'fcm_django','0006_auto_20210802_1140','2023-08-01 09:09:32.719092'),(28,'fcm_django','0007_auto_20211001_1440','2023-08-01 09:09:32.930998'),(29,'fcm_django','0008_auto_20211224_1205','2023-08-01 09:09:32.980274'),(30,'fcm_django','0009_alter_fcmdevice_user','2023-08-01 09:09:32.998877'),(31,'fcm_django','0010_unique_registration_id','2023-08-01 09:09:33.018027'),(32,'fcm_django','0011_fcmdevice_fcm_django_registration_id_user_id_idx','2023-08-01 09:09:33.024431'),(33,'products','0001_initial','2023-08-01 09:09:33.090266'),(34,'ordersmanagement','0001_initial','2023-08-01 09:09:33.362680'),(35,'sessions','0001_initial','2023-08-01 09:09:33.378727'),(36,'sitepanel','0001_initial','2023-08-01 09:09:33.479872'),(37,'sitepanel','0002_forgotpassword','2023-08-01 09:09:33.552585'),(38,'sitepanel','0003_alter_userprofile_year_of_joining','2023-08-01 09:09:33.642259'),(39,'sitepanel','0004_usersession','2023-08-02 14:24:04.178125'),(40,'sitepanel','0005_usersession_device_type','2023-08-02 14:34:41.433946'),(41,'sitepanel','0006_userprofile_web_token','2023-08-03 05:48:52.521240'),(42,'sitepanel','0007_alter_userprofile_year_of_joining','2023-08-03 06:04:46.860914'),(43,'sitepanel','0008_auto_20230803_1702','2023-08-03 11:32:38.877586');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('','','2023-08-02 07:20:59.484422'),('g0f1frq62n2i7so6g0427uaox6irl48j','.eJxVjDEOwjAMRe-SGUWp0xjCyM4ZKsd2aAElUtNOiLtDpQ6w_vfef5mB1mUc1qbzMIk5my6Yw--YiB9aNiJ3KrdquZZlnpLdFLvTZq9V9HnZ3b-Dkdr4rQMyRA6ZlX2I_VG0owwZNfXORQZRh5iQRTN6gC4BZfK9ygmdIKB5fwAoOjjB:1qQmpC:LQTG0-GVIAHp9f-de9Q4aymmVeH9hAJYrq4YhPC_rbI','2023-08-15 10:41:58.409517'),('ne3nx3ecso9wr20sxq7ilb7f38nzblh5','.eJxVjDsOwyAQBe9CHSEwmE_K9D4Dgt0lOIlAMnYV5e6xJRdJ-2bmvVmI21rC1mkJM7Ir0-zyu6UIT6oHwEes98ah1XWZEz8UftLOp4b0up3u30GJvey1QmlIoQay1hszxsFJ0MJnSJ4wm-TQSgKTCR3tkopCCI9ioBHJg2afL_0IONg:1qQllP:TLKyfZntb0qt7aAl5tyTakG23WaUtYYpIfTZaXXRyc4','2023-08-15 09:33:59.936102'),('rlmpsrgxed5vdskhs5goeligkv653awe','.eJxVjDsOwyAQBe9CHSEwmE_K9D4Dgt0lOIlAMnYV5e6xJRdJ-2bmvVmI21rC1mkJM7Ir0-zyu6UIT6oHwEes98ah1XWZEz8UftLOp4b0up3u30GJvey1QmlIoQay1hszxsFJ0MJnSJ4wm-TQSgKTCR3tkopCCI9ioBHJg2afL_0IONg:1qQlsh:FUmTOZvmMtDvv2a8C8zSu2iPKeal2JvZHjsQ6tD9T6M','2023-08-15 09:41:31.329275');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fcm_django_fcmdevice`
--

DROP TABLE IF EXISTS `fcm_django_fcmdevice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fcm_django_fcmdevice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `registration_id` longtext NOT NULL,
  `type` varchar(10) NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fcm_django_fcmdevice_user_id_6cdfc0a2_fk_auth_user_id` (`user_id`),
  KEY `fcm_django_fcmdevice_device_id_a9406c36` (`device_id`),
  CONSTRAINT `fcm_django_fcmdevice_user_id_6cdfc0a2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fcm_django_fcmdevice`
--

LOCK TABLES `fcm_django_fcmdevice` WRITE;
/*!40000 ALTER TABLE `fcm_django_fcmdevice` DISABLE KEYS */;
/*!40000 ALTER TABLE `fcm_django_fcmdevice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forgot_password`
--

DROP TABLE IF EXISTS `forgot_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forgot_password` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(100) NOT NULL,
  `expiry_time` datetime(6) NOT NULL,
  `fp_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forgot_password_fp_user_id_db8fdca5_fk_auth_user_id` (`fp_user_id`),
  CONSTRAINT `forgot_password_fp_user_id_db8fdca5_fk_auth_user_id` FOREIGN KEY (`fp_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forgot_password`
--

LOCK TABLES `forgot_password` WRITE;
/*!40000 ALTER TABLE `forgot_password` DISABLE KEYS */;
/*!40000 ALTER TABLE `forgot_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_412ad78b_fk_orders_id` (`order_id`),
  KEY `order_items_product_id_dd557d5a_fk_products_id` (`product_id`),
  CONSTRAINT `order_items_order_id_412ad78b_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_items_product_id_dd557d5a_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `order_items_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,3,1,1),(2,3,2,1),(3,3,3,1),(4,3,4,1),(5,3,5,1),(6,4,6,1),(7,3,6,5),(8,3,7,1),(9,3,8,1),(10,3,9,1),(11,3,10,1),(12,3,11,1),(13,3,12,1),(14,3,12,2),(15,3,13,2),(16,3,14,2),(17,3,15,2),(18,1,16,1),(19,1,16,2),(20,1,17,1),(21,2,17,2),(22,1,18,2),(23,2,19,1),(24,3,20,2),(25,1,21,1),(26,1,21,4),(27,2,22,4),(28,1,23,7),(29,11,24,1),(30,1,25,1),(31,1,25,3),(32,1,25,4),(33,2,25,6),(34,1,26,7),(35,1,27,7),(36,1,28,7),(37,2,29,7),(38,2,30,7),(39,3,31,2),(40,3,32,2),(41,1,33,7),(42,3,34,2),(43,3,35,2),(44,2,36,5),(45,1,37,5),(46,1,38,4),(47,1,39,4),(48,1,40,5),(49,1,41,4),(50,1,42,5),(51,1,42,7),(52,13,43,4),(53,2,44,4),(54,1,44,5),(55,4,45,4),(56,12,45,5),(57,3,45,7),(58,2,46,4);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `total_amount` int NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `status` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_user_id_7e2523fb_fk_auth_user_id` (`user_id`),
  CONSTRAINT `orders_user_id_7e2523fb_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,81,NULL,'2023-08-01 09:41:48.858852','2023-08-01 09:42:16.983409',5,14),(2,81,NULL,'2023-08-01 09:43:11.770394','2023-08-01 13:02:06.448948',5,14),(3,81,NULL,'2023-08-01 09:44:15.289670','2023-08-03 09:10:19.703649',4,14),(4,81,NULL,'2023-08-01 09:45:00.552044','2023-08-03 09:10:15.985830',4,14),(5,81,NULL,'2023-08-01 09:51:29.653190','2023-08-03 09:10:06.872455',4,14),(6,213,NULL,'2023-08-01 11:21:44.234044','2023-08-01 11:22:33.918783',5,11),(7,81,NULL,'2023-08-01 11:34:23.263066','2023-08-01 12:53:15.574563',5,14),(8,81,NULL,'2023-08-01 11:36:27.298001','2023-08-01 11:36:53.578180',5,14),(9,81,NULL,'2023-08-01 13:07:57.181852','2023-08-03 09:10:00.832770',4,14),(10,81,NULL,'2023-08-01 13:09:25.228820','2023-08-03 09:09:58.537827',4,14),(11,81,NULL,'2023-08-01 13:10:25.276763','2023-08-01 13:12:02.251421',5,14),(12,186,NULL,'2023-08-01 13:12:56.245899','2023-08-01 13:14:46.370015',5,14),(13,105,NULL,'2023-08-01 13:15:09.252672','2023-08-03 09:09:56.238669',4,14),(14,105,NULL,'2023-08-01 13:15:17.041839','2023-08-03 09:09:23.046617',4,14),(15,105,NULL,'2023-08-01 13:15:26.339788','2023-08-03 09:05:47.450720',4,14),(16,62,NULL,'2023-08-02 09:42:17.181801','2023-08-03 09:05:40.946994',4,16),(17,97,NULL,'2023-08-02 09:45:11.999234','2023-08-03 09:09:16.473687',4,16),(18,35,NULL,'2023-08-02 09:46:01.450957','2023-08-03 09:05:03.237400',4,16),(19,54,NULL,'2023-08-02 09:46:17.731865','2023-08-03 09:09:13.886700',4,16),(20,105,NULL,'2023-08-02 09:46:32.168037','2023-08-03 09:03:52.912521',4,16),(21,67,NULL,'2023-08-02 09:49:00.482252','2023-08-03 09:03:23.185901',4,16),(22,80,NULL,'2023-08-02 09:49:23.183437','2023-08-03 08:04:56.601773',5,16),(23,10,NULL,'2023-08-02 09:50:11.856587','2023-08-03 09:04:58.924736',4,10),(24,297,NULL,'2023-08-02 09:53:42.337636','2023-08-03 08:54:55.292919',4,11),(25,157,NULL,'2023-08-02 11:27:06.553164','2023-08-03 08:05:08.771082',5,16),(26,10,NULL,'2023-08-02 13:34:13.031958','2023-08-03 06:50:39.361951',5,16),(27,10,NULL,'2023-08-03 05:37:12.471968','2023-08-03 08:55:05.165463',4,16),(28,10,NULL,'2023-08-03 06:12:22.686317','2023-08-03 09:03:17.727495',4,11),(29,20,NULL,'2023-08-03 06:30:43.172267','2023-08-03 06:41:30.228717',5,16),(30,20,NULL,'2023-08-03 06:30:55.470026','2023-08-03 08:52:25.446939',4,16),(31,105,NULL,'2023-08-03 06:31:41.777841','2023-08-03 08:41:03.171198',4,10),(32,105,NULL,'2023-08-03 06:32:27.284417','2023-08-03 08:55:11.795550',4,10),(33,10,NULL,'2023-08-03 06:34:26.928458','2023-08-03 08:59:40.285499',4,11),(34,105,NULL,'2023-08-03 06:34:29.085818','2023-08-03 08:55:14.393470',4,10),(35,105,NULL,'2023-08-03 06:38:24.449350','2023-08-03 08:55:18.800563',4,10),(36,70,NULL,'2023-08-03 08:40:10.825819','2023-08-03 08:49:15.206978',5,16),(37,35,NULL,'2023-08-03 08:41:25.931348','2023-08-03 08:51:34.594732',4,16),(38,40,NULL,'2023-08-03 08:42:15.400340','2023-08-03 08:54:47.831120',4,16),(39,40,NULL,'2023-08-03 08:42:42.083988','2023-08-03 08:50:58.437478',5,16),(40,35,NULL,'2023-08-03 08:45:24.470637','2023-08-03 08:49:00.335147',5,16),(41,40,NULL,'2023-08-03 09:11:40.008404','2023-08-03 10:39:21.740666',5,16),(42,45,NULL,'2023-08-03 09:12:10.851860','2023-08-03 09:43:50.628017',5,16),(43,520,NULL,'2023-08-03 09:29:28.821734','2023-08-03 09:43:22.557552',4,11),(44,115,NULL,'2023-08-03 11:12:20.556110','2023-08-03 11:15:47.068773',5,16),(45,610,NULL,'2023-08-03 11:15:01.004116','2023-08-03 11:15:34.465273',5,16),(46,80,NULL,'2023-08-03 11:17:42.947330','2023-08-03 11:17:47.288800',5,16);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `image` varchar(100) NOT NULL,
  `price` int NOT NULL,
  `status` tinyint(1) NOT NULL,
  `stock` tinyint(1) NOT NULL,
  `availability` int NOT NULL,
  `category_id` bigint NOT NULL,
  `ref_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_category_id_a7a3a156_fk_categories_id` (`category_id`),
  KEY `products_ref_user_id_878d08c2_fk_auth_user_id` (`ref_user_id`),
  CONSTRAINT `products_category_id_a7a3a156_fk_categories_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `products_ref_user_id_878d08c2_fk_auth_user_id` FOREIGN KEY (`ref_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Aloo Paratha','qfwaegrsh','product_images/alooparatha_Moqgtl4.jpeg',27,1,0,1,1,4),(2,'curd','wergasthj','product_images/curd_U0rwcqk.jpeg',35,1,0,1,1,4),(3,'Maggie','dfvfvzdf','product_images/panner_parantha_RVPNi6R.jpeg',30,1,0,1,1,4),(4,'Parantha','fdsaga','product_images/panner_parantha_kTbgYLG.jpeg',40,1,1,1,1,4),(5,'Demo','dsgshdf','product_images/panner_parantha_XKloSnY.jpeg',35,1,1,1,1,4),(6,'Milk','dfgs','product_images/rajma-chawal-1_bqza7Ta.jpeg',30,1,0,1,1,4),(7,'tea','dgsgh','product_images/rajma-chawal-1_u5VaDHF.jpeg',10,1,1,1,1,4);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitepanel_customtoken`
--

DROP TABLE IF EXISTS `sitepanel_customtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sitepanel_customtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `key` varchar(40) NOT NULL,
  `purpose` varchar(255) NOT NULL,
  `device_type` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `sitepanel_customtoken_user_id_1f2a73e2_fk_auth_user_id` (`user_id`),
  CONSTRAINT `sitepanel_customtoken_user_id_1f2a73e2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitepanel_customtoken`
--

LOCK TABLES `sitepanel_customtoken` WRITE;
/*!40000 ALTER TABLE `sitepanel_customtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `sitepanel_customtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uuid` char(32) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `phone_number` varchar(12) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL,
  `fcm_token` longtext,
  `user_type` int NOT NULL,
  `emp_code` varchar(15) DEFAULT NULL,
  `device_type` int NOT NULL,
  `otp` int DEFAULT NULL,
  `year_of_joining` int unsigned NOT NULL,
  `gender` varchar(128) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `ref_user_id` int NOT NULL,
  `web_token` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ref_user_id` (`ref_user_id`),
  CONSTRAINT `user_profile_ref_user_id_2852f316_fk_auth_user_id` FOREIGN KEY (`ref_user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `user_profile_year_of_joining_05ef0e84_check` CHECK ((`year_of_joining` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
INSERT INTO `user_profile` VALUES (4,'0ac60c82cc5f48fd8d60f90f388fb8d7','user.png',NULL,1,NULL,3,'CHM/2023/210',3,947945,2012,NULL,'2023-07-31 11:27:29.050636','2023-08-02 13:02:48.379807',5,NULL),(5,'5b93e1b1086b4a23b297d5eb5c842ab9','users_photo/android_eg_1_cY4bqHh.jpeg',NULL,1,'c1lIK2h1Q--x9QIZMcAaqX:APA91bG3zY6b6ZaaS46JmP6OXlMJqjfV4RTmzInYLP7RI8P0M0lYWo31R7LIDuqQuqtABbU5_llrJTZcdwcFz8TxMq0yAxvMFsp1krRPSDVHV-DhtMt88O4AL8uAM0Sqq78dX9HPZMik',4,NULL,1,NULL,2012,NULL,'2023-07-31 11:30:08.293620','2023-08-03 11:23:25.812079',6,NULL),(6,'87513d5781604d32bd75847d74b31de9','users_photo/android_eg_1_i5s6JXB.jpeg','34668776',1,'Pandeyfdasfrhdtg',3,'CHM/2023/605',1,117175,2012,'male','2023-07-31 11:35:17.750353','2023-08-01 06:42:25.894798',8,NULL),(7,'95cc1a4c536e4de9bea749a869da9ed3','user.png',NULL,0,'c5PMsuvkTN6baprkFzcOTU:APA91bHzOnSC0dqDHdjkNNaRoV1YFgIrZfRX2TpqENowRtrLBHYBf5ZXRrodAegza9ZffkSQMBgIWuIdqtSZ0Z3c7Uvd3Klnj3GLJgbteBP8MeoppdKnd52MPxG6URAzLVaqXQt0Me_S',3,'CHM/2012/571',1,NULL,2012,NULL,'2023-07-31 11:43:52.994331','2023-08-01 13:55:39.041969',9,NULL),(8,'6c5adaf7bfcf416a98dbdebc63cf3257','users_photo/pakoda.jpeg',NULL,0,NULL,3,NULL,1,NULL,453,NULL,'2023-07-31 12:06:27.639483','2023-08-03 10:39:20.678537',10,NULL),(9,'6c5adaf7bfcf416a98dbdebc63cf3256','user.png',NULL,1,NULL,2,'CHM/2023/607',1,NULL,2016,NULL,'2023-07-31 12:06:27.639483','2023-07-31 12:06:27.639483',4,NULL),(10,'3cb566ba45ca4bfb8bccd91f93ae1044','user.png',NULL,1,NULL,3,NULL,3,NULL,2015,NULL,'2023-08-01 05:21:43.157339','2023-08-03 11:04:57.219436',11,'cqY7p8WYvyAfxLtKmwmdtD:APA91bG6tyAgb-kvpiaSRuVBJXDDUg6W0xKDmtbHXXfq87RjQm6Pnimw5eUsypii2Fmqyr5U9a0SPpYSD_oFgueVdFUXrHfm4hl-x_eIQCJLWfzYwEf79wviDUpo2heNZtDWthfENeQ3'),(12,'060ef23ee0994f7d969bc5500a44f714','users_photo/sandwich_QJl5sHP.jpeg',NULL,1,'Pandeyfdasfrhdtg',3,'45',1,NULL,2021,NULL,'2023-08-01 09:34:14.051932','2023-08-02 07:27:15.368388',14,NULL),(13,'66ab77d75e98468191c2ce066ba62323','users_photo/IMG-20230801-WA0053_HJccOdj.jpg',NULL,1,NULL,3,'CHM/2022/900',1,NULL,2022,NULL,'2023-08-02 04:34:43.861196','2023-08-03 11:29:27.017272',16,NULL),(14,'16c06cfcbe42474abb6f9fe90678aed2','user.png',NULL,0,NULL,3,'CHM/2023/563',3,NULL,2023,NULL,'2023-08-02 10:49:57.536641','2023-08-02 10:49:57.536657',17,NULL),(15,'ce005662ca45416a8969cb2abb0cb6ca','users_photo/Screenshot_20230726_163037_Ludo_Game.jpg',NULL,1,NULL,3,NULL,1,NULL,2015,NULL,'2023-08-03 05:38:38.396636','2023-08-03 10:11:43.956915',19,NULL),(16,'4aacff5f47f84b17a51ffa67f082cc68','user.png',NULL,0,NULL,3,'CHM/2022/111',3,NULL,2022,NULL,'2023-08-03 10:17:22.012011','2023-08-03 10:17:22.012027',20,NULL),(17,'72a3250730e8455cac09de181dd85cc3','user.png',NULL,1,NULL,3,'CHM/2012/504',3,NULL,2012,NULL,'2023-08-03 11:12:03.936132','2023-08-03 11:30:15.588324',21,NULL);
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_social`
--

DROP TABLE IF EXISTS `user_social`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_social` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `social_type` varchar(30) NOT NULL,
  `social_id` varchar(255) DEFAULT NULL,
  `twitter_username` varchar(255) DEFAULT NULL,
  `instagram_username` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `ref_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ref_user_id` (`ref_user_id`),
  CONSTRAINT `user_social_ref_user_id_70b23b01_fk_auth_user_id` FOREIGN KEY (`ref_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_social`
--

LOCK TABLES `user_social` WRITE;
/*!40000 ALTER TABLE `user_social` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_social` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet`
--

DROP TABLE IF EXISTS `wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `balance` int unsigned NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `wallet_user_id_03d82c01_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `wallet_chk_1` CHECK ((`balance` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet`
--

LOCK TABLES `wallet` WRITE;
/*!40000 ALTER TABLE `wallet` DISABLE KEYS */;
INSERT INTO `wallet` VALUES (2,9604,1,'2023-08-01 09:34:14.052339','2023-08-01 13:15:26.338131',14),(4,99404,1,'2023-07-31 11:27:29.051039','2023-08-01 05:38:12.580124',5),(5,10000,1,'2023-07-31 11:30:08.294149','2023-07-31 11:51:59.686186',6),(6,9676,1,'2023-07-31 11:35:17.750972','2023-08-01 05:27:44.757130',8),(7,10000,1,'2023-07-31 11:43:52.994753','2023-07-31 11:51:46.481426',9),(8,9780,1,'2023-07-31 12:06:27.640527','2023-08-03 08:39:28.360618',10),(9,9136,1,'2023-08-01 05:21:43.158150','2023-08-03 09:29:28.819587',11),(10,9875,1,'2023-08-02 04:34:43.861974','2023-08-03 11:17:47.314932',16),(11,0,1,'2023-08-02 10:49:57.537064','2023-08-02 10:49:57.537075',17),(12,0,1,'2023-08-03 05:38:38.397184','2023-08-03 05:38:38.397195',19),(13,0,1,'2023-08-03 10:17:22.012557','2023-08-03 10:17:22.012570',20),(14,0,1,'2023-08-03 11:12:03.936885','2023-08-03 11:12:03.936905',21);
/*!40000 ALTER TABLE `wallet` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-03 17:06:24
