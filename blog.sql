-- MySQL dump 10.13  Distrib 8.1.0, for Win64 (x86_64)
--
-- Host: localhost    Database: shopping
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `addr`
--

DROP TABLE IF EXISTS `addr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addr` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `province` varchar(20) NOT NULL,
  `city` varchar(20) NOT NULL,
  `county` varchar(20) NOT NULL,
  `address` varchar(200) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `addr_user_id_65e09bac_fk_users_id` (`user_id`),
  CONSTRAINT `addr_user_id_65e09bac_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addr`
--

LOCK TABLES `addr` WRITE;
/*!40000 ALTER TABLE `addr` DISABLE KEYS */;
INSERT INTO `addr` VALUES (1,'13970145387','JANSON','姹熻タ鐪?,'璧ｅ窞甯?,'澶т綑鍘?,'姹犳睙鏉戝涓?,0,2),(2,'13970145387','JANSON1','姹熻タ鐪?,'璧ｅ窞甯?,'澶т綑鍘?,'姹犳睙鏉?,1,2),(3,'13970145387','JANSON2','姹熻タ鐪?,'璧ｅ窞甯?,'澶т綑鍘?,'姹犳睙鏉?,0,2),(4,'13970145387','JANSON2','姹熻タ鐪?,'璧ｅ窞甯?,'澶т綑鍘?,'姹犳睙鏉?,0,3);
/*!40000 ALTER TABLE `addr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `area` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pid` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `level` varchar(20) DEFAULT NULL,
  `/*` varchar(64) DEFAULT NULL,
  `deep` int DEFAULT NULL,
  `pinyin_prefix` varchar(50) DEFAULT NULL,
  `pinyin` varchar(50) DEFAULT NULL,
  `ext_id` int DEFAULT NULL,
  `ext_name` varchar(50) DEFAULT NULL,
  `--` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add 鐪佸競鍘垮尯鍩熻〃',6,'add_area'),(22,'Can change 鐪佸競鍘垮尯鍩熻〃',6,'change_area'),(23,'Can delete 鐪佸競鍘垮尯鍩熻〃',6,'delete_area'),(24,'Can view 鐪佸競鍘垮尯鍩熻〃',6,'view_area'),(25,'Can add 鎵嬫満楠岃瘉鐮佽〃',7,'add_verifcode'),(26,'Can change 鎵嬫満楠岃瘉鐮佽〃',7,'change_verifcode'),(27,'Can delete 鎵嬫満楠岃瘉鐮佽〃',7,'delete_verifcode'),(28,'Can view 鎵嬫満楠岃瘉鐮佽〃',7,'view_verifcode'),(29,'Can add 鐢ㄦ埛琛?,8,'add_user'),(30,'Can change 鐢ㄦ埛琛?,8,'change_user'),(31,'Can delete 鐢ㄦ埛琛?,8,'delete_user'),(32,'Can view 鐢ㄦ埛琛?,8,'view_user'),(33,'Can add 鏀惰揣鍦板潃琛?,9,'add_addr'),(34,'Can change 鏀惰揣鍦板潃琛?,9,'change_addr'),(35,'Can delete 鏀惰揣鍦板潃琛?,9,'delete_addr'),(36,'Can view 鏀惰揣鍦板潃琛?,9,'view_addr'),(37,'Can add 鍟嗗搧琛?,10,'add_goods'),(38,'Can change 鍟嗗搧琛?,10,'change_goods'),(39,'Can delete 鍟嗗搧琛?,10,'delete_goods'),(40,'Can view 鍟嗗搧琛?,10,'view_goods'),(41,'Can add 棣栭〉鍟嗗搧杞挱鍥?,11,'add_goodsbanner'),(42,'Can change 棣栭〉鍟嗗搧杞挱鍥?,11,'change_goodsbanner'),(43,'Can delete 棣栭〉鍟嗗搧杞挱鍥?,11,'delete_goodsbanner'),(44,'Can view 棣栭〉鍟嗗搧杞挱鍥?,11,'view_goodsbanner'),(45,'Can add 鍟嗗搧鍒嗙被琛?,12,'add_goodsgroup'),(46,'Can change 鍟嗗搧鍒嗙被琛?,12,'change_goodsgroup'),(47,'Can delete 鍟嗗搧鍒嗙被琛?,12,'delete_goodsgroup'),(48,'Can view 鍟嗗搧鍒嗙被琛?,12,'view_goodsgroup'),(49,'Can add 鍟嗗搧璇︽儏',13,'add_detail'),(50,'Can change 鍟嗗搧璇︽儏',13,'change_detail'),(51,'Can delete 鍟嗗搧璇︽儏',13,'delete_detail'),(52,'Can view 鍟嗗搧璇︽儏',13,'view_detail'),(53,'Can add 鏀惰棌鍟嗗搧',14,'add_collect'),(54,'Can change 鏀惰棌鍟嗗搧',14,'change_collect'),(55,'Can delete 鏀惰棌鍟嗗搧',14,'delete_collect'),(56,'Can view 鏀惰棌鍟嗗搧',14,'view_collect'),(57,'Can add 璐墿杞?,15,'add_cart'),(58,'Can change 璐墿杞?,15,'change_cart'),(59,'Can delete 璐墿杞?,15,'delete_cart'),(60,'Can view 璐墿杞?,15,'view_cart');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `title` varchar(200) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `seq` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
INSERT INTO `banner` VALUES (1,'2023-12-24 09:51:46.094869','2023-12-24 09:51:46.094869',0,'娴锋姤1','娴锋姤1.png',1,1);
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `number` int NOT NULL,
  `is_checked` tinyint(1) NOT NULL,
  `goods_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_goods_id_a0c55193_fk_goods_id` (`goods_id`),
  KEY `cart_user_id_1361a739_fk_users_id` (`user_id`),
  CONSTRAINT `cart_goods_id_a0c55193_fk_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`),
  CONSTRAINT `cart_user_id_1361a739_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,'2023-12-25 11:48:29.073986','2023-12-25 11:48:29.073986',0,1,1,1,1),(2,'2023-12-25 11:54:30.429584','2023-12-25 11:54:30.429584',0,1,1,1,1),(3,'2023-12-25 12:01:09.829189','2023-12-25 12:16:57.344125',0,3,1,2,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collect`
--

DROP TABLE IF EXISTS `collect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collect` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `goods_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collect_user_id_9b5330ca_fk_users_id` (`user_id`),
  KEY `collect_goods_id_696c83a5_fk_goods_id` (`goods_id`),
  CONSTRAINT `collect_goods_id_696c83a5_fk_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`),
  CONSTRAINT `collect_user_id_9b5330ca_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collect`
--

LOCK TABLES `collect` WRITE;
/*!40000 ALTER TABLE `collect` DISABLE KEYS */;
INSERT INTO `collect` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4);
/*!40000 ALTER TABLE `collect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail`
--

DROP TABLE IF EXISTS `detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `producer` varchar(200) NOT NULL,
  `norms` varchar(200) NOT NULL,
  `detail` longtext NOT NULL,
  `goods_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `detail_goods_id_9bb8c24d_fk_goods_id` (`goods_id`),
  CONSTRAINT `detail_goods_id_9bb8c24d_fk_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail`
--

LOCK TABLES `detail` WRITE;
/*!40000 ALTER TABLE `detail` DISABLE KEYS */;
INSERT INTO `detail` VALUES (3,'2023-12-25 05:44:03.724131','2023-12-25 05:44:03.724131',0,'鎺㈠懗鍚涳紙TANWEIJUN锛?,'500g/浠?,'<ul>\r\n	<li>鍝佺墝锛?nbsp;<a href=\"https://list.jd.com/list.html?cat=12218,12221,13563&amp;ev=exbrand_386843\" target=\"_blank\">鎺㈠懗鍚涳紙TANWEIJUN锛?/a></li>\r\n</ul>\r\n\r\n<ul>\r\n	<li>鍟嗗搧鍚嶇О锛氭帰鍛冲悰 骞胯タ 棣欒晧 灏忕背钑?鏂伴矞姘存灉 5鏂よ</li>\r\n	<li>鍟嗗搧缂栧彿锛?0036388821228</li>\r\n	<li>搴楅摵锛?nbsp;<a href=\"https://mall.jd.com/index-641574.html?from=pc\" target=\"_blank\">鎺㈠懗鍚涚敓椴滄棗鑸板簵</a></li>\r\n	<li>鍟嗗搧姣涢噸锛?.5kg</li>\r\n	<li>鍝佺锛氭櫘閫氶钑?/li>\r\n	<li>璐瓨鏉′欢锛氬父娓?/li>\r\n	<li>鍥戒骇/杩涘彛锛氬浗浜?/li>\r\n</ul>\r\n\r\n<p><a href=\"https://item.jd.com/10036388821228.html#product-detail\">鏇村鍙傛暟<s>&gt;&gt;</s></a></p>\r\n\r\n<p><img src=\"http://img30.360buyimg.com/popWareDetail/jfs/t1/125119/14/26611/208251/624d5e90Ef359e53c/44667e7681b6c366.jpg\" /><img src=\"http://img30.360buyimg.com/popWareDetail/jfs/t1/104466/11/26609/123507/624d5e90E34c9445d/5b08286e588b89f5.jpg\" /><img src=\"http://img30.360buyimg.com/popWareDetail/jfs/t1/211157/37/20000/96238/624d5e90E6abc5158/1f06fcb7c488e813.jpg\" /><img src=\"http://img30.360buyimg.com/popWareDetail/jfs/t1/115625/28/25924/194223/624d5e98E24584ab7/47cd2c1f38c1176c.jpg\" /><img src=\"http://img30.360buyimg.com/popWareDetail/jfs/t1/89223/21/26742/187933/624d5e98E953ef306/12c88c04b2524c3d.jpg\" /><img src=\"http://img30.360buyimg.com/popWareDetail/jfs/t1/118427/19/25179/154601/624d5e9bE29141c42/f459d534c27a002e.jpg\" /><img src=\"http://img30.360buyimg.com/popWareDetail/jfs/t1/165731/8/22999/163253/624d5e9fE6d0c6969/e06301af2c687957.jpg\" /><img src=\"http://img30.360buyimg.com/popWareDetail/jfs/t1/214627/33/16611/156361/624d5e9fE8277219a/cba8065c94f790b7.jpg\" /></p>',1);
/*!40000 ALTER TABLE `detail` ENABLE KEYS */;
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
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-12-24 09:43:36.980043','1','钄彍',1,'[{\"added\": {}}]',12,1),(2,'2023-12-24 09:43:52.497076','2','姘存灉',1,'[{\"added\": {}}]',12,1),(3,'2023-12-24 09:44:26.499961','3','鑲夌被鍒跺搧',1,'[{\"added\": {}}]',12,1),(4,'2023-12-24 09:44:54.311627','4','楸肩嚎娴疯櫨',1,'[{\"added\": {}}]',12,1),(5,'2023-12-24 09:49:54.241458','1','棣欒晧',1,'[{\"added\": {}}]',10,1),(6,'2023-12-24 09:50:02.682864','1','棣欒晧',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u4e0a\\u67b6\"]}}]',10,1),(7,'2023-12-24 09:51:46.097511','1','娴锋姤1',1,'[{\"added\": {}}]',11,1),(8,'2023-12-24 09:53:50.731831','2','鑼勫瓙',1,'[{\"added\": {}}]',10,1),(9,'2023-12-24 09:55:01.075464','3','绉嬪垁楸?,1,'[{\"added\": {}}]',10,1),(10,'2023-12-24 09:55:56.649379','4','鑽夎帗',1,'[{\"added\": {}}]',10,1),(11,'2023-12-25 05:44:03.726129','3','Detail object (3)',1,'[{\"added\": {}}]',13,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(15,'cart','cart'),(4,'contenttypes','contenttype'),(14,'goods','collect'),(13,'goods','detail'),(10,'goods','goods'),(11,'goods','goodsbanner'),(12,'goods','goodsgroup'),(5,'sessions','session'),(9,'users','addr'),(6,'users','area'),(8,'users','user'),(7,'users','verifcode');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-12-19 04:16:00.194887'),(2,'contenttypes','0002_remove_content_type_name','2023-12-19 04:16:00.258333'),(3,'auth','0001_initial','2023-12-19 04:16:00.588487'),(4,'auth','0002_alter_permission_name_max_length','2023-12-19 04:16:00.698658'),(5,'auth','0003_alter_user_email_max_length','2023-12-19 04:16:00.704952'),(6,'auth','0004_alter_user_username_opts','2023-12-19 04:16:00.718100'),(7,'auth','0005_alter_user_last_login_null','2023-12-19 04:16:00.723258'),(8,'auth','0006_require_contenttypes_0002','2023-12-19 04:16:00.723258'),(9,'auth','0007_alter_validators_add_error_messages','2023-12-19 04:16:00.733186'),(10,'auth','0008_alter_user_username_max_length','2023-12-19 04:16:00.736694'),(11,'auth','0009_alter_user_last_name_max_length','2023-12-19 04:16:00.743341'),(12,'auth','0010_alter_group_name_max_length','2023-12-19 04:16:00.753414'),(13,'auth','0011_update_proxy_permissions','2023-12-19 04:16:00.753414'),(14,'auth','0012_alter_user_first_name_max_length','2023-12-19 04:16:00.753414'),(15,'users','0001_initial','2023-12-19 04:16:01.238501'),(16,'admin','0001_initial','2023-12-19 04:16:01.473305'),(17,'admin','0002_logentry_remove_auto_add','2023-12-19 04:16:01.483650'),(18,'admin','0003_logentry_add_action_flag_choices','2023-12-19 04:16:01.493435'),(19,'sessions','0001_initial','2023-12-19 04:16:01.533425'),(20,'users','0002_alter_addr_address','2023-12-21 15:25:45.037246'),(21,'goods','0001_initial','2023-12-24 07:38:11.757275'),(22,'goods','0002_alter_detail_options','2023-12-24 07:38:11.768812'),(23,'goods','0003_alter_goodsgroup_image','2023-12-24 09:43:09.981070'),(24,'goods','0004_remove_goodsgroup_create_time_and_more','2023-12-24 09:47:02.356023'),(25,'cart','0001_initial','2023-12-25 06:28:42.411152'),(26,'users','0003_alter_area_level_alter_area_pid','2023-12-26 06:46:32.494205');
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
INSERT INTO `django_session` VALUES ('p1o9ovcuvaw0b33i7wjw4pn0rvhtu9n0','.eJxVy7sKwyAYQOF3cS5BrdeO3fsM8l8UQ4mBxgyl9N2DkKFdz8f5iAR7r2nf8ivNLG5CictvQ6BnbgNoXZa1TYNy6zNBz9PjfT_9b6qw1XEgW48UsmdgQ8HHiL44CU4VBKO8suhkRDZgtXbAQZerLMNMiMDiewBD_DR0:1rHJFM:5srDaLcwPHb9W2VGMRg-SSMpEcmab9J1zRUpojwrT6M','2024-01-07 07:50:04.354184'),('ygc1hrphbo1lmz8henodjfwam28pygoz','.eJxVy7sKwyAYQOF3cS5BrdeO3fsM8l8UQ4mBxgyl9N2DkKFdz8f5iAR7r2nf8ivNLG5CictvQ6BnbgNoXZa1TYNy6zNBz9PjfT_9b6qw1XEgW48UsmdgQ8HHiL44CU4VBKO8suhkRDZgtXbAQZerLMNMiMDiewBD_DR0:1rfDjd:4ys3jhGXcBIHR5Fqy7216Jny2VUC9itX95KR9wbvbWI','2024-03-13 06:48:09.487131');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `title` varchar(200) NOT NULL,
  `desc` varchar(200) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `cover` varchar(100) DEFAULT NULL,
  `stock` int NOT NULL,
  `sales` int NOT NULL,
  `is_on` tinyint(1) NOT NULL,
  `recommend` tinyint(1) NOT NULL,
  `group_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_group_id_a4f95326_fk_goods_group_id` (`group_id`),
  CONSTRAINT `goods_group_id_a4f95326_fk_goods_group_id` FOREIGN KEY (`group_id`) REFERENCES `goods_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1,'2023-12-24 09:49:54.238467','2023-12-24 09:50:02.681016',0,'棣欒晧','绮惧搧棣欒晧',3.60,'棣欒晧.jpg',999,0,1,1,2),(2,'2023-12-24 09:53:50.730601','2023-12-24 09:53:50.730601',0,'鑼勫瓙','鏂伴矞鑼勫瓙',1.69,'',888,12,1,1,1),(3,'2023-12-24 09:55:01.070489','2023-12-24 09:55:01.071464',0,'绉嬪垁楸?,'鏃ユ湰杩涘彛绉嬪垁楸?,45.12,'绉嬪垁楸?jpg',50,6,1,1,4),(4,'2023-12-24 09:55:56.645404','2023-12-24 09:55:56.645404',0,'鑽夎帗','鐜版憳鑽夎帗',8.99,'鑽夎帗.jpg',40,32,1,1,2);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_group`
--

DROP TABLE IF EXISTS `goods_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_group` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_group`
--

LOCK TABLES `goods_group` WRITE;
/*!40000 ALTER TABLE `goods_group` DISABLE KEYS */;
INSERT INTO `goods_group` VALUES (1,'钄彍','',1),(2,'姘存灉','',1),(3,'鑲夌被鍒跺搧','',1),(4,'楸肩嚎娴疯櫨','',0);
/*!40000 ALTER TABLE `goods_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
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
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'pbkdf2_sha256$720000$AlQ1lZD1nnA2IRfw0Ns6jq$Lr4i0NXC++/7fQ3nAPHwyFA7DrFDSKyv5ElxhclBE/0=','2024-02-28 06:48:09.480140',1,'admin','','寮犳．','123@qq.com',1,1,'2023-12-19 06:31:57.604907','2023-12-19 06:31:57.770067','2023-12-23 14:27:56.863539',0,'15579757892','澶村儚_h1moz3K.png'),(2,'pbkdf2_sha256$720000$z3PEtLyik1giN8W064wLQ6$2KJQ6T5m/TiQzD5rBJ+FvxK/xAQZPfsj+YSjyE0PwnE=',NULL,0,'JANSON','','','12@qq.com',0,1,'2023-12-19 08:19:38.729760','2023-12-19 08:19:38.890870','2023-12-19 08:19:38.890870',0,'',''),(3,'pbkdf2_sha256$720000$MxE6SLoxHnxaHHQBp8pHEf$EA9OTcUUqFp7F9+MN7x4BkpdSL35X8j68twLNAm+Gh8=',NULL,0,'JANSON1','','','1233@qq.com',0,1,'2023-12-21 07:34:49.881836','2023-12-21 07:34:50.049046','2023-12-21 07:34:50.049046',0,'','');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_user_id_group_id_fc7788e8_uniq` (`user_id`,`group_id`),
  KEY `users_groups_group_id_2f3517aa_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_groups_group_id_2f3517aa_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `users_groups_user_id_f500bee5_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_permissions`
--

DROP TABLE IF EXISTS `users_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_permissions_user_id_permission_id_3b86cbdf_uniq` (`user_id`,`permission_id`),
  KEY `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_user_permissions_user_id_92473840_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_permissions`
--

LOCK TABLES `users_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verifcode`
--

DROP TABLE IF EXISTS `verifcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verifcode` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mobile` varchar(11) NOT NULL,
  `code` varchar(6) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verifcode`
--

LOCK TABLES `verifcode` WRITE;
/*!40000 ALTER TABLE `verifcode` DISABLE KEYS */;
INSERT INTO `verifcode` VALUES (2,'15579757892','834069','2023-12-23 07:56:39.598635'),(6,'15579757892','351477','2023-12-27 08:19:52.665786');
/*!40000 ALTER TABLE `verifcode` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-29 15:14:46
