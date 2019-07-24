-- MySQL dump 10.14  Distrib 5.5.60-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: vue_face
-- ------------------------------------------------------
-- Server version	5.5.60-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `vue_face`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `vue_face` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `vue_face`;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add group',4,'add_group'),(11,'Can change group',4,'change_group'),(12,'Can delete group',4,'delete_group'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add user profile',7,'add_userprofile'),(20,'Can change user profile',7,'change_userprofile'),(21,'Can delete user profile',7,'delete_userprofile'),(22,'Can add ?????',8,'add_verifycode'),(23,'Can change ?????',8,'change_verifycode'),(24,'Can delete ?????',8,'delete_verifycode'),(25,'Can add ????',9,'add_face'),(26,'Can change ????',9,'change_face'),(27,'Can delete ????',9,'delete_face'),(28,'Can add ??????',10,'add_faceimg'),(29,'Can change ??????',10,'change_faceimg'),(30,'Can delete ??????',10,'delete_faceimg'),(31,'Can add ????',11,'add_check'),(32,'Can change ????',11,'change_check'),(33,'Can delete ????',11,'delete_check'),(34,'Can add ???',12,'add_stream'),(35,'Can change ???',12,'change_stream'),(36,'Can delete ???',12,'delete_stream'),(37,'Can add Token',13,'add_token'),(38,'Can change Token',13,'change_token'),(39,'Can delete Token',13,'delete_token'),(40,'Can add captcha store',14,'add_captchastore'),(41,'Can change captcha store',14,'change_captchastore'),(42,'Can delete captcha store',14,'delete_captchastore');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$eLCTUNX7Oz5Q$zp0r5PIlI2tMD/CWZ3jeGzPdOQXDEbTCMxHpZbcZk4s=','2019-06-28 17:36:00',1,'test','','','',1,1,'2019-06-27 15:35:55');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('0d224c4a3cadacd68906a0dba4973ab7d4606337','2019-06-27 15:35:55',1);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captcha_captchastore`
--

DROP TABLE IF EXISTS `captcha_captchastore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `captcha_captchastore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_captchastore`
--

LOCK TABLES `captcha_captchastore` WRITE;
/*!40000 ALTER TABLE `captcha_captchastore` DISABLE KEYS */;
INSERT INTO `captcha_captchastore` VALUES (1,'FIDP','fidp','f77892161f694201218e6695561b1919580fd91c','2019-06-27 15:20:04'),(2,'TYFV','tyfv','e11403c6351dbaa99d4d440e4fa4e6aac0ab96ab','2019-06-27 15:20:04'),(3,'TBTG','tbtg','56832664b0760b16a9009e4745cc30d136c26043','2019-06-27 15:20:07'),(4,'DDLF','ddlf','8e2a8854586da229b47fce5f45fe2d456e84da55','2019-06-27 15:20:16'),(5,'TZYB','tzyb','a2f648d4598425fcece4927587c7cf18ecb44172','2019-06-27 15:35:24'),(6,'HSTX','hstx','030ddce3251a2f0ad1a2b4a772c1f5994b87870c','2019-06-27 15:35:48'),(7,'MIRD','mird','48a425b66be2d6a28c603f9d676713816e02afe0','2019-06-27 15:35:52'),(8,'MPAG','mpag','f5eee3533fdb8107b8a03185ad1d1be537fd352f','2019-06-27 15:37:14'),(9,'EBUB','ebub','f818a19a5e4f50f32f78bcd028c35fedc9e68362','2019-06-27 15:38:15'),(10,'PWZI','pwzi','9ceacfc3390b7def02a1ad9e5e4cfd428f2ad986','2019-06-27 15:38:28'),(11,'HZDF','hzdf','8cb31d69b8e8e44472376f0baea05ffd46c081d5','2019-06-27 15:39:22'),(12,'TSNO','tsno','1cd39b3040f89371b6eabafb239263806771db0b','2019-06-27 15:39:25'),(13,'MPFB','mpfb','a777e476193c6a3c6471485fdfb846a349bd1ab3','2019-06-27 15:45:12'),(14,'DMEZ','dmez','72d4f12536e5525a35f46265996aebe1255f991c','2019-06-27 15:45:20'),(15,'BGXK','bgxk','e0ee19ebf93e4170e503da0e8b3764004820a7b1','2019-06-27 15:45:25'),(16,'QYSZ','qysz','ab0d0c523bdd0041fe365405cd05922adb315a2c','2019-06-27 15:45:28'),(17,'EKIJ','ekij','cff7f0fb0edb087d37559c0f5058fd68bd344f91','2019-06-27 16:16:24'),(18,'NXSS','nxss','54d147d3d2dda9b3fd5db94f49e4501cadfceed6','2019-06-27 16:19:20'),(19,'YKWJ','ykwj','fed5774bfda1f8f343e91e870599a87b3345f0fc','2019-06-27 17:50:22'),(20,'DOHJ','dohj','1d94e4d10724b2582eb67e93d8f1d9e9c3cac14d','2019-06-28 14:53:24'),(21,'AQXG','aqxg','f1123d6e56154dcaadeb15093c8c40e861f64f80','2019-06-28 15:02:16'),(22,'VPLM','vplm','de7e59a53162f8c44e5dbab8a4d925b0c5817996','2019-06-28 15:16:24'),(23,'YQPR','yqpr','be0292cd6db1728692863f8d24517522b919e762','2019-06-28 15:16:38'),(24,'ZFZS','zfzs','6d16ff807d97c617550832c35e567696bb3cd493','2019-06-28 15:18:22'),(25,'OYMK','oymk','d86a3746c34557890adc99e2c1ff736fcc30423c','2019-06-28 15:20:42'),(26,'BSCA','bsca','d44e9b2cc4ca060c769c3996e4deeb813cb3c19e','2019-06-28 15:53:02'),(27,'CWRJ','cwrj','58b014449e9d67b1270ec2919b423034b440c800','2019-06-28 16:25:24'),(28,'BVRT','bvrt','343468605db0a0d07646588a4328d585f1f16ad1','2019-06-28 16:39:22'),(29,'FGGX','fggx','3338071afa3575a1f67bbee47ed27fd34b992eb7','2019-06-28 16:39:51'),(30,'HCMI','hcmi','35f0d81ae850d85c332dcc64fa80a50a003bbf9b','2019-06-28 16:40:00'),(31,'WZGZ','wzgz','14fa64fb5808c80f775cf8af9a9f63e56c39886d','2019-06-28 16:40:09'),(32,'YNDJ','yndj','28cd3ab9d8475cdfa12a1ded25fe7d66c683b624','2019-06-28 16:40:36'),(33,'SXOI','sxoi','59c9aadaeb68f1b364e5c2effb456f4977fa5ddc','2019-06-28 16:40:46'),(34,'GPNW','gpnw','3f794369df18bd9bc7bf3aea101ff3b93a360d60','2019-06-28 16:40:52'),(35,'RFWR','rfwr','5994fbdfe334e1e7441261de3f54fc8513374209','2019-06-28 16:41:00'),(36,'KPCC','kpcc','07b14557049962a562d7fd62fdb64fd63264960a','2019-06-28 16:41:09'),(37,'DVPR','dvpr','fdb04d7e5a12312d0dec051c9679c08eb7c1db63','2019-06-28 16:41:16'),(38,'CVDU','cvdu','a010a9ee96bc2943a81c28878824eae4c78786f1','2019-06-28 16:41:24'),(39,'YGIW','ygiw','bfc0db067430b90c5c5f13b5a9bfb9f084e1089d','2019-06-28 16:44:59'),(40,'BVWV','bvwv','7dc8f8889518fd4075e3d9be6a0e89535188234d','2019-06-28 16:45:05'),(41,'AFHK','afhk','69d564650d0ce12daa7f875a54db49484524daff','2019-06-28 16:45:14'),(42,'CKAF','ckaf','3e70b03c7482f29e513eea74a57095ef1809ee21','2019-06-28 16:45:49'),(43,'YTGO','ytgo','929ebdb29538f52cbd01d610f43eb4936cdfbc52','2019-06-28 16:47:36'),(44,'EVLX','evlx','3c02c1a618097939dba98bd39f0d51f5d1d54243','2019-06-28 16:47:46'),(45,'QDXZ','qdxz','4011655f859b32e7f3ab2652a9ec0fd2f438c558','2019-06-28 16:51:03'),(46,'IKLZ','iklz','e58fe7d2c54044494803d1582b0b6127eb206fd2','2019-06-28 17:11:38'),(47,'KXKY','kxky','83ea42a09c2e846e6ea27d15d7ca4748bf1a48a9','2019-06-28 17:59:35'),(48,'OFQQ','ofqq','4b14c1eaee7256ca0d201af18830c51f927eb2e9','2019-06-28 18:20:05'),(49,'HAAO','haao','b4d87347602e8ae9a988711be57c6b0e4046e814','2019-06-28 18:35:53'),(50,'PXVN','pxvn','8337850b90f955ca59fba266c566281a040342be','2019-07-01 09:48:02'),(51,'PJRS','pjrs','c558617fd02783527b91be89a434773f878be54b','2019-07-01 10:05:00'),(52,'NWOO','nwoo','180e4906b49a39511fbdecd773bcfcdb7ac995fa','2019-07-01 11:55:47'),(53,'ZKTA','zkta','3b8de643932cb2484508fdf6c99caf59520fd40b','2019-07-01 11:56:48'),(54,'NHBT','nhbt','18030eda901fa4e65890c4880bdb5da9f38a4eb5','2019-07-01 12:03:40'),(55,'GLBG','glbg','23f182fbfcb7b000eef260e61ec281ae1b54194a','2019-07-01 15:58:04'),(56,'HKGE','hkge','e6c7efb92db011ea2051f65c634de321932e9e9e','2019-07-02 10:10:19'),(57,'SYEJ','syej','9fee44bab772478d1373f01f2899a831ec632f5d','2019-07-02 14:06:06'),(58,'IWXZ','iwxz','000eb6c9488c100809692fa2748973f59ff72d98','2019-07-02 14:13:34'),(59,'TKPW','tkpw','c90c6ea79c27706179ab4e094280ed4155b5a764','2019-07-02 14:13:34'),(60,'DIGQ','digq','cba29a42e34e363af9727ad93c9eea719b87c385','2019-07-02 14:13:52'),(61,'CNYY','cnyy','7ee8840acb975eb777fc60b829f0706a0725f5f8','2019-07-02 14:14:13'),(62,'ZVDV','zvdv','2b963cb43315f18d7b9c5b6e46d4becead82e16b','2019-07-02 14:14:34'),(63,'MGBN','mgbn','b140384036bf25e37610bd3859a3a0d854e4b5e1','2019-07-02 16:09:03'),(64,'DGTI','dgti','95da2f4e22a0ab392381115b91fb0a6efd5599c6','2019-07-02 16:53:53'),(65,'OVMI','ovmi','f94fa0bbd1f469fe9b1d29748b5fc1701ca96a1c','2019-07-02 16:54:09'),(66,'WJIH','wjih','ab4d15608b91e5ea1869252f9d19d773ac74f684','2019-07-02 16:55:35'),(67,'SHNV','shnv','9e2a93d40b6e5dfe9b272c7f433fb7217fc6a7c3','2019-07-03 10:19:26'),(68,'MSTO','msto','0aab1f3a04e50349e1593478764bf29422a415f2','2019-07-03 16:22:21'),(69,'VRBF','vrbf','24e6bb5947ab7090c936228c312788ea7c48f27a','2019-07-03 17:29:50'),(70,'PIAP','piap','b6c98a9a13f0f8e721a19728098f3ac7322c497f','2019-07-03 17:44:55'),(71,'WVQZ','wvqz','7cef11c597bbcd195733849e62016229cbfde860','2019-07-03 18:00:15'),(72,'BHVB','bhvb','cdfa34c2c2796ad3b659a0366e263c5f432ff3bb','2019-07-04 09:52:51'),(73,'AYCM','aycm','696b07a2250ba1fc5177c2e60989c72ff5d25f20','2019-07-04 10:09:51'),(74,'ACVN','acvn','52074b2d04be6f4976736cc137bb4980aeaed5df','2019-07-04 10:20:06'),(75,'RSQH','rsqh','a9dd9950fa4b9290c3819806adf2e70346d44939','2019-07-04 17:40:53'),(76,'JGUM','jgum','bb67eca8b56fc347ddb9f3f743d582c4cf1b0f34','2019-07-05 10:25:33'),(77,'KZHM','kzhm','6154881c4924396a9f2c80251fcb2923652a4c46','2019-07-05 10:45:26'),(78,'EDMA','edma','5c8c916cf98ef8ea04de9ee6729a9c87f67fbc44','2019-07-05 10:45:27'),(79,'XWDW','xwdw','675bc83ff44d390ff3f4f44b712fd4c314cfc306','2019-07-05 10:52:09'),(80,'HORJ','horj','41e0b32e210a38ca651b8b07ab2756910c280aa3','2019-07-05 11:05:47'),(81,'IPPS','ipps','1ebfe7d7221ab6172461b541f47e0f804453efea','2019-07-05 12:02:32'),(82,'ASXR','asxr','1a30d4362edb5e2f806a1132e634f6dd419e0e27','2019-07-05 16:33:38'),(83,'LWHJ','lwhj','a637c9e1d807030f4f6e0d81cf52cc24b64806a2','2019-07-05 16:41:26'),(84,'JXZG','jxzg','23a50ed0b51191c79282463114e61398070ab105','2019-07-05 17:24:31'),(85,'SETZ','setz','a399b886c9b9ddce517e6b061002cdb1837a56ce','2019-07-08 09:12:33'),(86,'OYVX','oyvx','a26ca8a87b6624924068fc347649745376ad3f1b','2019-07-08 09:12:59'),(87,'MPUO','mpuo','104564d3d1ba807d3638a2ee83f246b22c88ad2e','2019-07-09 09:32:33'),(88,'PKWY','pkwy','7c5926b1b22373f1bbd8581ebd7bf4431dcf2930','2019-07-10 09:33:45'),(89,'KQXF','kqxf','0476e699417618af266e7b9e34d356bb82997de0','2019-07-10 11:27:10'),(90,'EMVL','emvl','e7af1f729815371a81ca57609febf72b818be353','2019-07-11 10:24:49'),(91,'MBIF','mbif','310ab3fae7335a3c728b4825d0b1dcd208c60f6a','2019-07-11 15:10:16'),(92,'PDTA','pdta','07c2e88ca38d98c92406b837da1c9890fe9702fb','2019-07-11 15:10:27'),(93,'QGAM','qgam','2f49d977b29d7f8a00bcc76d9949545ceed8d4bf','2019-07-12 15:10:50'),(94,'EHLX','ehlx','3c610026661e716c5a7b33303610b9bfe002a85b','2019-07-15 09:07:59'),(95,'YNMT','ynmt','77b860d6371c33709353fc26dbd072f19146f6c1','2019-07-15 15:43:34'),(96,'VLUN','vlun','735ca3b7686cd1f6826992cc329f8fe92d58ca5f','2019-07-15 15:44:24'),(97,'XOJU','xoju','0e516f0a1439ceb3ed042f1ee8afaaffd55cdf53','2019-07-15 15:48:52'),(98,'YHRG','yhrg','c55e19ab56999a3098a0b174b064df596718ea32','2019-07-17 09:34:30'),(99,'FEAM','feam','d4d6bd21f3951e6e0f2f91e91515245ecad3ffcb','2019-07-18 09:41:12'),(100,'JIOB','jiob','b459e0323816a1df266547c064b26b220ec7a04f','2019-07-19 09:59:52'),(101,'NUYA','nuya','29d60cdd87d337f7a64ce52a9fe6058a0d6357d6','2019-07-22 14:24:15'),(102,'IWUT','iwut','c80b3ae06d6f6d1fdfdb21791f1ca03cf109cd9e','2019-07-22 17:37:28'),(103,'LOZN','lozn','630eea785d0bdb82ea0991cd4f6aa416042c7e20','2019-07-22 17:37:32'),(104,'NFXY','nfxy','fd95c334525ea16453cb6fc7dec297445cdf0416','2019-07-22 17:54:18'),(105,'JXKR','jxkr','07106ab5ce34502a1b3955eb37e89a9d38665dfe','2019-07-23 10:31:06'),(106,'SFKR','sfkr','fb2fbe6b7e13c75a96373546a4e71ac0642caea0','2019-07-23 10:32:51'),(107,'KRIL','kril','29bddaafd8108903e882b573a27b1a8f3603adc2','2019-07-23 10:44:11'),(108,'VEIV','veiv','93a6e9f6a915c727e8f868881b42cc8e8646a743','2019-07-23 10:44:13'),(109,'BYBX','bybx','a536f349e7ebdc4580982c24d5def47f77ff5bda','2019-07-23 14:12:22');
/*!40000 ALTER TABLE `captcha_captchastore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(4,'auth','group'),(2,'auth','permission'),(3,'auth','user'),(13,'authtoken','token'),(14,'captcha','captchastore'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(11,'users','check'),(9,'users','face'),(10,'users','faceimg'),(12,'users','stream'),(7,'users','userprofile'),(8,'users','verifycode');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-06-27 10:34:50'),(2,'auth','0001_initial','2019-06-27 10:34:52'),(3,'admin','0001_initial','2019-06-27 10:34:52'),(4,'admin','0002_logentry_remove_auto_add','2019-06-27 10:34:52'),(5,'contenttypes','0002_remove_content_type_name','2019-06-27 10:34:52'),(6,'auth','0002_alter_permission_name_max_length','2019-06-27 10:34:52'),(7,'auth','0003_alter_user_email_max_length','2019-06-27 10:34:52'),(8,'auth','0004_alter_user_username_opts','2019-06-27 10:34:52'),(9,'auth','0005_alter_user_last_login_null','2019-06-27 10:34:52'),(10,'auth','0006_require_contenttypes_0002','2019-06-27 10:34:52'),(11,'auth','0007_alter_validators_add_error_messages','2019-06-27 10:34:52'),(12,'auth','0008_alter_user_username_max_length','2019-06-27 10:34:53'),(13,'authtoken','0001_initial','2019-06-27 10:34:53'),(14,'authtoken','0002_auto_20160226_1747','2019-06-27 10:34:53'),(15,'captcha','0001_initial','2019-06-27 10:34:53'),(16,'sessions','0001_initial','2019-06-27 10:34:53'),(17,'users','0001_initial','2019-06-27 15:52:43'),(18,'users','0002_auto_20190627_1552','2019-06-27 15:52:43');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('hs0v43s4cifixd6sex4nsux52xlnzk9t','ODE1NGM2NDVjN2ZlZjYxYzM4Y2UwYjg2ZjBiMmMwY2YxNTk5Mjk2Yjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI5ZDQ4ZGRiOGJjYWNjYTkzMGQxNTRhMzUzNmIyNGI1NGI4MzNiYTAxIn0=','2019-07-12 17:36:00');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_check`
--

DROP TABLE IF EXISTS `users_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `faceid` varchar(10) CHARACTER SET latin1 NOT NULL,
  `streamid` varchar(256) CHARACTER SET latin1 NOT NULL,
  `timestap` varchar(100) CHARACTER SET latin1 NOT NULL,
  `c_x` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_y` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_w` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_h` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_ip` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `c_gender` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_age` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_threshold` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `imgurl` varchar(100) DEFAULT NULL,
  `time` float(11,2) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_check`
--

LOCK TABLES `users_check` WRITE;
/*!40000 ALTER TABLE `users_check` DISABLE KEYS */;
INSERT INTO `users_check` VALUES (1,'1','16','1','1218','669','331','235','10.2.151.139','men','18','0.472976','/res_img/tangli.mp4/frame_1_0.jpg',0.04,'/media/test_video/tangli.mp4'),(2,'7','16','16','317','520','53','48','10.2.151.139','men','18','0.462497','/res_img/tangli.mp4/frame_16_0.jpg',0.64,'/media/test_video/tangli.mp4'),(3,'7','13','34','1532','602','68','61','10.2.151.139','men','18','0.522990','/res_img/tl.mp4/frame_34_0.jpg',1.37,'/media/test_video/tl.mp4'),(4,'7','13','37','1532','604','66','63','10.2.151.139','men','18','0.593013','/res_img/tl.mp4/frame_37_0.jpg',1.49,'/media/test_video/tl.mp4'),(5,'7','13','40','1531','602','77','67','10.2.151.139','men','18','0.539990','/res_img/tl.mp4/frame_40_0.jpg',1.61,'/media/test_video/tl.mp4'),(6,'1','16','28','1194','665','346','250','10.2.151.139','men','18','0.471404','/res_img/tangli.mp4/frame_28_0.jpg',1.12,'/media/test_video/tangli.mp4'),(7,'7','13','43','1536','609','73','63','10.2.151.139','men','18','0.650889','/res_img/tl.mp4/frame_43_0.jpg',1.73,'/media/test_video/tl.mp4'),(8,'7','13','46','1537','611','78','65','10.2.151.139','men','18','0.567244','/res_img/tl.mp4/frame_46_0.jpg',1.85,'/media/test_video/tl.mp4'),(9,'7','13','49','1540','612','75','64','10.2.151.139','men','18','0.533021','/res_img/tl.mp4/frame_49_0.jpg',1.97,'/media/test_video/tl.mp4'),(10,'7','13','52','1538','605','73','62','10.2.151.139','men','18','0.706901','/res_img/tl.mp4/frame_52_0.jpg',2.09,'/media/test_video/tl.mp4'),(11,'7','13','55','1535','600','76','66','10.2.151.139','men','18','0.579494','/res_img/tl.mp4/frame_55_0.jpg',2.21,'/media/test_video/tl.mp4'),(12,'6','14','4','276','433','110','94','10.2.151.139','men','18','0.496353','/res_img/luoxin.mp4/frame_4_0.jpg',0.16,'/media/test_video/luoxin.mp4'),(13,'7','13','58','1535','599','74','64','10.2.151.139','men','18','0.598448','/res_img/tl.mp4/frame_58_0.jpg',2.33,'/media/test_video/tl.mp4'),(14,'6','14','7','307','436','106','93','10.2.151.139','men','18','0.492542','/res_img/luoxin.mp4/frame_7_0.jpg',0.28,'/media/test_video/luoxin.mp4'),(15,'7','13','61','1537','600','77','68','10.2.151.139','men','18','0.499067','/res_img/tl.mp4/frame_61_0.jpg',2.45,'/media/test_video/tl.mp4'),(16,'7','13','64','1545','602','75','68','10.2.151.139','men','18','0.503039','/res_img/tl.mp4/frame_64_0.jpg',2.57,'/media/test_video/tl.mp4'),(17,'7','13','79','1539','603','77','68','10.2.151.139','men','18','0.504267','/res_img/tl.mp4/frame_79_0.jpg',3.17,'/media/test_video/tl.mp4'),(18,'7','13','82','1534','600','79','69','10.2.151.139','men','18','0.488851','/res_img/tl.mp4/frame_82_0.jpg',3.29,'/media/test_video/tl.mp4'),(19,'2','3','1','857','347','168','140','10.2.151.139','men','18','0.677336','/res_img/lc_yl.mp4/frame_1_0.jpg',0.04,'/media/test_video/lc_yl.mp4'),(20,'7','13','85','1532','604','75','66','10.2.151.139','men','18','0.489606','/res_img/tl.mp4/frame_85_0.jpg',3.41,'/media/test_video/tl.mp4'),(21,'2','3','4','858','352','155','133','10.2.151.139','men','18','0.695457','/res_img/lc_yl.mp4/frame_4_0.jpg',0.16,'/media/test_video/lc_yl.mp4'),(22,'1','3','4','1222','93','170','141','10.2.151.139','men','18','0.480163','/res_img/lc_yl.mp4/frame_4_1.jpg',0.16,'/media/test_video/lc_yl.mp4'),(23,'7','13','88','1529','603','71','64','10.2.151.139','men','18','0.637209','/res_img/tl.mp4/frame_88_0.jpg',3.53,'/media/test_video/tl.mp4'),(24,'7','13','91','1526','598','78','67','10.2.151.139','men','18','0.641857','/res_img/tl.mp4/frame_91_0.jpg',3.65,'/media/test_video/tl.mp4'),(25,'2','3','7','847','358','146','133','10.2.151.139','men','18','0.453609','/res_img/lc_yl.mp4/frame_7_0.jpg',0.28,'/media/test_video/lc_yl.mp4'),(26,'1','3','7','1219','103','158','143','10.2.151.139','men','18','0.497100','/res_img/lc_yl.mp4/frame_7_1.jpg',0.28,'/media/test_video/lc_yl.mp4'),(27,'7','13','94','1526','599','72','62','10.2.151.139','men','18','0.659820','/res_img/tl.mp4/frame_94_0.jpg',3.78,'/media/test_video/tl.mp4'),(28,'7','13','97','1524','600','70','63','10.2.151.139','men','18','0.706644','/res_img/tl.mp4/frame_97_0.jpg',3.90,'/media/test_video/tl.mp4'),(29,'1','3','22','1202','124','160','145','10.2.151.139','men','18','0.527039','/res_img/lc_yl.mp4/frame_22_0.jpg',0.88,'/media/test_video/lc_yl.mp4'),(30,'1','3','28','1171','125','175','154','10.2.151.139','men','18','0.478688','/res_img/lc_yl.mp4/frame_28_0.jpg',1.12,'/media/test_video/lc_yl.mp4'),(31,'1','3','31','1182','125','174','147','10.2.151.139','men','18','0.527478','/res_img/lc_yl.mp4/frame_31_0.jpg',1.24,'/media/test_video/lc_yl.mp4'),(32,'1','3','34','1178','125','168','149','10.2.151.139','men','18','0.597165','/res_img/lc_yl.mp4/frame_34_0.jpg',1.37,'/media/test_video/lc_yl.mp4'),(33,'1','3','37','1199','132','155','141','10.2.151.139','men','18','0.546998','/res_img/lc_yl.mp4/frame_37_0.jpg',1.49,'/media/test_video/lc_yl.mp4'),(34,'1','3','40','1198','127','153','138','10.2.151.139','men','18','0.570869','/res_img/lc_yl.mp4/frame_40_0.jpg',1.61,'/media/test_video/lc_yl.mp4'),(35,'1','3','43','1210','127','152','135','10.2.151.139','men','18','0.580474','/res_img/lc_yl.mp4/frame_43_0.jpg',1.73,'/media/test_video/lc_yl.mp4'),(36,'1','3','46','1212','117','166','143','10.2.151.139','men','18','0.626892','/res_img/lc_yl.mp4/frame_46_0.jpg',1.85,'/media/test_video/lc_yl.mp4'),(37,'1','3','49','1230','117','162','137','10.2.151.139','men','18','0.622150','/res_img/lc_yl.mp4/frame_49_0.jpg',1.97,'/media/test_video/lc_yl.mp4'),(38,'1','4','1','615','393','317','258','10.2.151.139','men','18','0.667122','/res_img/lichao.mp4/frame_1_0.jpg',0.04,'/media/test_video/lichao.mp4'),(39,'1','4','4','613','394','317','260','10.2.151.139','men','18','0.669869','/res_img/lichao.mp4/frame_4_0.jpg',0.16,'/media/test_video/lichao.mp4'),(40,'1','4','7','629','406','310','251','10.2.151.139','men','18','0.671815','/res_img/lichao.mp4/frame_7_0.jpg',0.28,'/media/test_video/lichao.mp4'),(41,'1','4','10','621','405','296','247','10.2.151.139','men','18','0.706730','/res_img/lichao.mp4/frame_10_0.jpg',0.40,'/media/test_video/lichao.mp4'),(42,'1','4','13','609','391','333','269','10.2.151.139','men','18','0.733878','/res_img/lichao.mp4/frame_13_0.jpg',0.52,'/media/test_video/lichao.mp4'),(43,'1','4','16','604','400','321','260','10.2.151.139','men','18','0.770172','/res_img/lichao.mp4/frame_16_0.jpg',0.64,'/media/test_video/lichao.mp4'),(44,'1','4','19','603','408','303','247','10.2.151.139','men','18','0.785269','/res_img/lichao.mp4/frame_19_0.jpg',0.76,'/media/test_video/lichao.mp4'),(45,'1','4','22','616','425','281','222','10.2.151.139','men','18','0.858113','/res_img/lichao.mp4/frame_22_0.jpg',0.88,'/media/test_video/lichao.mp4'),(46,'1','4','25','595','422','291','247','10.2.151.139','men','18','0.891328','/res_img/lichao.mp4/frame_25_0.jpg',1.00,'/media/test_video/lichao.mp4'),(47,'1','4','28','600','418','310','241','10.2.151.139','men','18','0.897184','/res_img/lichao.mp4/frame_28_0.jpg',1.12,'/media/test_video/lichao.mp4'),(48,'1','4','31','626','431','284','224','10.2.151.139','men','18','0.822420','/res_img/lichao.mp4/frame_31_0.jpg',1.24,'/media/test_video/lichao.mp4'),(49,'1','4','34','603','423','290','232','10.2.151.139','men','18','0.872761','/res_img/lichao.mp4/frame_34_0.jpg',1.37,'/media/test_video/lichao.mp4'),(50,'1','4','37','595','424','304','235','10.2.151.139','men','18','0.866479','/res_img/lichao.mp4/frame_37_0.jpg',1.49,'/media/test_video/lichao.mp4'),(51,'1','4','40','587','413','315','253','10.2.151.139','men','18','0.816509','/res_img/lichao.mp4/frame_40_0.jpg',1.61,'/media/test_video/lichao.mp4'),(52,'1','4','46','602','430','301','250','10.2.151.139','men','18','0.914061','/res_img/lichao.mp4/frame_46_0.jpg',1.85,'/media/test_video/lichao.mp4'),(53,'1','4','49','607','415','311','238','10.2.151.139','men','18','0.879873','/res_img/lichao.mp4/frame_49_0.jpg',1.97,'/media/test_video/lichao.mp4'),(54,'2','8','1','911','337','160','138','10.2.151.139','men','18','0.832120','/res_img/yl_lc.mp4/frame_1_0.jpg',0.04,'/media/test_video/yl_lc.mp4'),(55,'1','8','1','1266','189','204','168','10.2.151.139','men','18','0.584036','/res_img/yl_lc.mp4/frame_1_1.jpg',0.04,'/media/test_video/yl_lc.mp4'),(56,'2','8','4','906','336','166','147','10.2.151.139','men','18','0.834965','/res_img/yl_lc.mp4/frame_4_0.jpg',0.16,'/media/test_video/yl_lc.mp4'),(57,'1','8','4','1271','195','210','177','10.2.151.139','men','18','0.558069','/res_img/yl_lc.mp4/frame_4_1.jpg',0.16,'/media/test_video/yl_lc.mp4'),(58,'2','8','7','903','330','179','150','10.2.151.139','men','18','0.773159','/res_img/yl_lc.mp4/frame_7_0.jpg',0.28,'/media/test_video/yl_lc.mp4'),(59,'1','8','7','1268','198','175','153','10.2.151.139','men','18','0.554497','/res_img/yl_lc.mp4/frame_7_1.jpg',0.28,'/media/test_video/yl_lc.mp4'),(60,'2','8','10','912','338','162','141','10.2.151.139','men','18','0.835425','/res_img/yl_lc.mp4/frame_10_0.jpg',0.40,'/media/test_video/yl_lc.mp4'),(61,'1','8','10','1267','195','196','169','10.2.151.139','men','18','0.568306','/res_img/yl_lc.mp4/frame_10_1.jpg',0.40,'/media/test_video/yl_lc.mp4'),(62,'2','8','13','905','326','180','153','10.2.151.139','men','18','0.765831','/res_img/yl_lc.mp4/frame_13_0.jpg',0.52,'/media/test_video/yl_lc.mp4'),(63,'1','8','13','1281','193','195','155','10.2.151.139','men','18','0.537782','/res_img/yl_lc.mp4/frame_13_1.jpg',0.52,'/media/test_video/yl_lc.mp4'),(64,'2','8','16','910','334','167','145','10.2.151.139','men','18','0.813006','/res_img/yl_lc.mp4/frame_16_0.jpg',0.64,'/media/test_video/yl_lc.mp4'),(65,'1','8','16','1262','197','192','171','10.2.151.139','men','18','0.563224','/res_img/yl_lc.mp4/frame_16_1.jpg',0.64,'/media/test_video/yl_lc.mp4'),(66,'2','8','19','912','337','162','141','10.2.151.139','men','18','0.824097','/res_img/yl_lc.mp4/frame_19_0.jpg',0.76,'/media/test_video/yl_lc.mp4'),(67,'1','8','19','1273','193','192','160','10.2.151.139','men','18','0.512867','/res_img/yl_lc.mp4/frame_19_1.jpg',0.76,'/media/test_video/yl_lc.mp4'),(68,'2','8','22','913','337','163','140','10.2.151.139','men','18','0.828949','/res_img/yl_lc.mp4/frame_22_0.jpg',0.88,'/media/test_video/yl_lc.mp4'),(69,'1','8','22','1267','187','184','162','10.2.151.139','men','18','0.488657','/res_img/yl_lc.mp4/frame_22_1.jpg',0.88,'/media/test_video/yl_lc.mp4'),(70,'2','8','25','905','336','164','142','10.2.151.139','men','18','0.804608','/res_img/yl_lc.mp4/frame_25_0.jpg',1.00,'/media/test_video/yl_lc.mp4'),(71,'2','8','28','899','335','166','147','10.2.151.139','men','18','0.823555','/res_img/yl_lc.mp4/frame_28_0.jpg',1.12,'/media/test_video/yl_lc.mp4'),(72,'1','8','28','1289','179','200','168','10.2.151.139','men','18','0.538764','/res_img/yl_lc.mp4/frame_28_1.jpg',1.12,'/media/test_video/yl_lc.mp4'),(73,'2','8','31','892','332','169','147','10.2.151.139','men','18','0.795023','/res_img/yl_lc.mp4/frame_31_0.jpg',1.24,'/media/test_video/yl_lc.mp4'),(74,'1','8','31','1303','195','184','154','10.2.151.139','men','18','0.555274','/res_img/yl_lc.mp4/frame_31_1.jpg',1.24,'/media/test_video/yl_lc.mp4'),(75,'2','8','34','886','328','178','150','10.2.151.139','men','18','0.803166','/res_img/yl_lc.mp4/frame_34_0.jpg',1.37,'/media/test_video/yl_lc.mp4'),(76,'1','8','34','1304','194','191','163','10.2.151.139','men','18','0.556402','/res_img/yl_lc.mp4/frame_34_1.jpg',1.37,'/media/test_video/yl_lc.mp4'),(77,'2','8','37','885','332','178','153','10.2.151.139','men','18','0.794906','/res_img/yl_lc.mp4/frame_37_0.jpg',1.49,'/media/test_video/yl_lc.mp4'),(78,'1','8','37','1303','193','191','168','10.2.151.139','men','18','0.570473','/res_img/yl_lc.mp4/frame_37_1.jpg',1.49,'/media/test_video/yl_lc.mp4'),(79,'2','8','40','886','337','168','147','10.2.151.139','men','18','0.817285','/res_img/yl_lc.mp4/frame_40_0.jpg',1.61,'/media/test_video/yl_lc.mp4'),(80,'1','8','40','1323','203','201','164','10.2.151.139','men','18','0.479629','/res_img/yl_lc.mp4/frame_40_1.jpg',1.61,'/media/test_video/yl_lc.mp4'),(81,'2','8','43','886','337','169','147','10.2.151.139','men','18','0.801866','/res_img/yl_lc.mp4/frame_43_0.jpg',1.73,'/media/test_video/yl_lc.mp4'),(82,'1','8','43','1320','182','193','162','10.2.151.139','men','18','0.550809','/res_img/yl_lc.mp4/frame_43_1.jpg',1.73,'/media/test_video/yl_lc.mp4'),(83,'7','15','37','1514','608','75','67','10.2.151.139','men','18','0.545591','/res_img/liupengbo_tangli.mp4/frame_37_0.jpg',1.49,'/media/test_video/liupengbo_tangli.mp4'),(84,'2','8','46','889','334','174','150','10.2.151.139','men','18','0.832513','/res_img/yl_lc.mp4/frame_46_0.jpg',1.85,'/media/test_video/yl_lc.mp4'),(85,'1','8','46','1320','170','202','173','10.2.151.139','men','18','0.584483','/res_img/yl_lc.mp4/frame_46_1.jpg',1.85,'/media/test_video/yl_lc.mp4'),(86,'7','15','40','1517','612','77','68','10.2.151.139','men','18','0.503371','/res_img/liupengbo_tangli.mp4/frame_40_0.jpg',1.61,'/media/test_video/liupengbo_tangli.mp4'),(87,'2','8','49','890','332','171','151','10.2.151.139','men','18','0.787696','/res_img/yl_lc.mp4/frame_49_0.jpg',1.97,'/media/test_video/yl_lc.mp4'),(88,'1','8','49','1327','173','185','159','10.2.151.139','men','18','0.565535','/res_img/yl_lc.mp4/frame_49_1.jpg',1.97,'/media/test_video/yl_lc.mp4'),(89,'7','15','43','1517','613','75','66','10.2.151.139','men','18','0.473241','/res_img/liupengbo_tangli.mp4/frame_43_0.jpg',1.73,'/media/test_video/liupengbo_tangli.mp4'),(90,'7','15','46','1519','612','77','66','10.2.151.139','men','18','0.540547','/res_img/liupengbo_tangli.mp4/frame_46_0.jpg',1.85,'/media/test_video/liupengbo_tangli.mp4'),(91,'7','15','49','1519','612','81','69','10.2.151.139','men','18','0.537895','/res_img/liupengbo_tangli.mp4/frame_49_0.jpg',1.97,'/media/test_video/liupengbo_tangli.mp4'),(92,'1','3','52','1231','119','158','132','10.2.151.139','men','18','0.577964','/res_img/lc_yl.mp4/frame_52_0.jpg',2.09,'/media/test_video/lc_yl.mp4'),(93,'7','13','100','1526','599','71','61','10.2.151.139','men','18','0.657104','/res_img/tl.mp4/frame_100_0.jpg',4.02,'/media/test_video/tl.mp4'),(94,'1','3','55','1201','133','165','145','10.2.151.139','men','18','0.477597','/res_img/lc_yl.mp4/frame_55_0.jpg',2.21,'/media/test_video/lc_yl.mp4'),(95,'7','13','103','1526','597','72','62','10.2.151.139','men','18','0.604844','/res_img/tl.mp4/frame_103_0.jpg',4.14,'/media/test_video/tl.mp4'),(96,'7','13','106','1527','596','73','64','10.2.151.139','men','18','0.633154','/res_img/tl.mp4/frame_106_0.jpg',4.26,'/media/test_video/tl.mp4'),(97,'7','13','109','1527','595','75','65','10.2.151.139','men','18','0.633433','/res_img/tl.mp4/frame_109_0.jpg',4.38,'/media/test_video/tl.mp4'),(98,'1','3','64','1148','247','174','157','10.2.151.139','men','18','0.551646','/res_img/lc_yl.mp4/frame_64_0.jpg',2.57,'/media/test_video/lc_yl.mp4'),(99,'7','13','112','1527','598','74','65','10.2.151.139','men','18','0.655722','/res_img/tl.mp4/frame_112_0.jpg',4.50,'/media/test_video/tl.mp4'),(100,'7','13','115','1527','601','73','63','10.2.151.139','men','18','0.654696','/res_img/tl.mp4/frame_115_0.jpg',4.62,'/media/test_video/tl.mp4'),(101,'1','3','67','1134','266','179','162','10.2.151.139','men','18','0.572133','/res_img/lc_yl.mp4/frame_67_0.jpg',2.69,'/media/test_video/lc_yl.mp4'),(102,'7','13','118','1527','604','73','64','10.2.151.139','men','18','0.634556','/res_img/tl.mp4/frame_118_0.jpg',4.74,'/media/test_video/tl.mp4'),(103,'1','3','70','1109','272','187','165','10.2.151.139','men','18','0.635264','/res_img/lc_yl.mp4/frame_70_0.jpg',2.81,'/media/test_video/lc_yl.mp4'),(104,'7','13','121','1527','605','77','67','10.2.151.139','men','18','0.557518','/res_img/tl.mp4/frame_121_0.jpg',4.86,'/media/test_video/tl.mp4'),(105,'7','13','124','1529','608','75','67','10.2.151.139','men','18','0.523027','/res_img/tl.mp4/frame_124_0.jpg',4.98,'/media/test_video/tl.mp4'),(106,'1','3','73','1105','276','174','155','10.2.151.139','men','18','0.580248','/res_img/lc_yl.mp4/frame_73_0.jpg',2.93,'/media/test_video/lc_yl.mp4'),(107,'7','13','127','1532','609','77','67','10.2.151.139','men','18','0.459254','/res_img/tl.mp4/frame_127_0.jpg',5.10,'/media/test_video/tl.mp4'),(108,'1','3','76','1075','277','174','158','10.2.151.139','men','18','0.595297','/res_img/lc_yl.mp4/frame_76_0.jpg',3.05,'/media/test_video/lc_yl.mp4'),(109,'7','13','130','1533','609','78','68','10.2.151.139','men','18','0.472198','/res_img/tl.mp4/frame_130_0.jpg',5.22,'/media/test_video/tl.mp4'),(110,'1','3','79','1085','298','155','134','10.2.151.139','men','18','0.525367','/res_img/lc_yl.mp4/frame_79_0.jpg',3.17,'/media/test_video/lc_yl.mp4'),(111,'7','13','133','1536','609','78','69','10.2.151.139','men','18','0.518848','/res_img/tl.mp4/frame_133_0.jpg',5.34,'/media/test_video/tl.mp4'),(112,'7','13','136','1538','611','75','67','10.2.151.139','men','18','0.504458','/res_img/tl.mp4/frame_136_0.jpg',5.46,'/media/test_video/tl.mp4'),(113,'7','13','139','1540','612','72','65','10.2.151.139','men','18','0.494307','/res_img/tl.mp4/frame_139_0.jpg',5.58,'/media/test_video/tl.mp4'),(114,'7','13','145','1539','616','71','66','10.2.151.139','men','18','0.495534','/res_img/tl.mp4/frame_145_0.jpg',5.82,'/media/test_video/tl.mp4'),(115,'1','3','97','1074','187','153','129','10.2.151.139','men','18','0.478091','/res_img/lc_yl.mp4/frame_97_0.jpg',3.90,'/media/test_video/lc_yl.mp4'),(116,'7','16','103','1399','508','75','66','10.2.151.139','men','18','0.465481','/res_img/tangli.mp4/frame_103_0.jpg',4.14,'/media/test_video/tangli.mp4'),(117,'7','16','106','1406','509','69','61','10.2.151.139','men','18','0.554260','/res_img/tangli.mp4/frame_106_0.jpg',4.26,'/media/test_video/tangli.mp4'),(118,'7','16','109','1402','506','74','64','10.2.151.139','men','18','0.593317','/res_img/tangli.mp4/frame_109_0.jpg',4.38,'/media/test_video/tangli.mp4'),(119,'7','16','112','1400','505','68','56','10.2.151.139','men','18','0.656797','/res_img/tangli.mp4/frame_112_0.jpg',4.50,'/media/test_video/tangli.mp4'),(120,'7','16','115','1397','501','70','61','10.2.151.139','men','18','0.673837','/res_img/tangli.mp4/frame_115_0.jpg',4.62,'/media/test_video/tangli.mp4'),(121,'7','16','118','1397','505','67','55','10.2.151.139','men','18','0.691395','/res_img/tangli.mp4/frame_118_0.jpg',4.74,'/media/test_video/tangli.mp4'),(122,'7','16','121','1392','506','68','59','10.2.151.139','men','18','0.671703','/res_img/tangli.mp4/frame_121_0.jpg',4.86,'/media/test_video/tangli.mp4'),(123,'7','16','124','1393','506','67','58','10.2.151.139','men','18','0.679853','/res_img/tangli.mp4/frame_124_0.jpg',4.98,'/media/test_video/tangli.mp4'),(124,'7','16','127','1394','506','67','58','10.2.151.139','men','18','0.696737','/res_img/tangli.mp4/frame_127_0.jpg',5.10,'/media/test_video/tangli.mp4'),(125,'7','16','130','1399','504','67','58','10.2.151.139','men','18','0.621853','/res_img/tangli.mp4/frame_130_0.jpg',5.22,'/media/test_video/tangli.mp4'),(126,'7','16','133','1408','504','67','58','10.2.151.139','men','18','0.464134','/res_img/tangli.mp4/frame_133_0.jpg',5.34,'/media/test_video/tangli.mp4'),(127,'7','15','52','1519','612','81','68','10.2.151.139','men','18','0.516247','/res_img/liupengbo_tangli.mp4/frame_52_04',2.09,'/media/test_video/liupengbo_tangli.mp4'),(128,'7','15','55','1517','614','79','68','10.2.151.139','men','18','0.526679','/res_img/liupengbo_tangli.mp4/frame_55_07',2.21,'/media/test_video/liupengbo_tangli.mp4'),(129,'7','15','58','1519','613','76','65','10.2.151.139','men','18','0.495704','/res_img/liupengbo_tangli.mp4/frame_58_0:',2.33,'/media/test_video/liupengbo_tangli.mp4'),(130,'7','15','61','1518','614','79','69','10.2.151.139','men','18','0.502692','/res_img/liupengbo_tangli.mp4/frame_61_0=',2.45,'/media/test_video/liupengbo_tangli.mp4'),(131,'7','15','64','1519','616','77','66','10.2.151.139','men','18','0.514961','/res_img/liupengbo_tangli.mp4/frame_64_0@',2.57,'/media/test_video/liupengbo_tangli.mp4'),(132,'7','15','67','1518','617','78','67','10.2.151.139','men','18','0.527830','/res_img/liupengbo_tangli.mp4/frame_67_0C',2.69,'/media/test_video/liupengbo_tangli.mp4'),(133,'7','15','76','1519','614','77','68','10.2.151.139','men','18','0.467038','/res_img/liupengbo_tangli.mp4/frame_76_0L',3.05,'/media/test_video/liupengbo_tangli.mp4'),(134,'7','15','82','1519','616','75','65','10.2.151.139','men','18','0.479510','/res_img/liupengbo_tangli.mp4/frame_82_0R',3.29,'/media/test_video/liupengbo_tangli.mp4'),(135,'7','15','85','1518','615','79','71','10.2.151.139','men','18','0.468888','/res_img/liupengbo_tangli.mp4/frame_85_0U',3.41,'/media/test_video/liupengbo_tangli.mp4'),(136,'7','15','88','1520','615','76','68','10.2.151.139','men','18','0.543537','/res_img/liupengbo_tangli.mp4/frame_88_0X',3.53,'/media/test_video/liupengbo_tangli.mp4'),(137,'7','15','97','1518','615','78','69','10.2.151.139','men','18','0.475161','/res_img/liupengbo_tangli.mp4/frame_97_0a',3.90,'/media/test_video/liupengbo_tangli.mp4'),(138,'4','1','199','1276','385','80','72','10.2.151.139','men','18','0.512405','/res_img/jwc.mp4/frame_199_0.jpg',7.99,'/media/test_video/jwc.mp4'),(139,'7','15','100','1519','618','79','69','10.2.151.139','men','18','0.463319','/res_img/liupengbo_tangli.mp4/frame_100_d',4.02,'/media/test_video/liupengbo_tangli.mp4'),(140,'7','16','151','1570','522','80','72','10.2.151.139','men','18','0.515287','/res_img/tangli.mp4/frame_151_0.jpg',6.06,'/media/test_video/tangli.mp4'),(141,'7','15','103','1518','617','80','70','10.2.151.139','men','18','0.465885','/res_img/liupengbo_tangli.mp4/frame_103_g',4.14,'/media/test_video/liupengbo_tangli.mp4'),(142,'4','1','205','1267','353','87','75','10.2.151.139','men','18','0.479824','/res_img/jwc.mp4/frame_205_0.jpg',8.23,'/media/test_video/jwc.mp4'),(143,'7','16','154','1574','530','74','66','10.2.151.139','men','18','0.590695','/res_img/tangli.mp4/frame_154_0.jpg',6.18,'/media/test_video/tangli.mp4'),(144,'7','15','106','1517','615','83','73','10.2.151.139','men','18','0.460959','/res_img/liupengbo_tangli.mp4/frame_106_j',4.26,'/media/test_video/liupengbo_tangli.mp4'),(145,'4','1','208','1246','343','93','86','10.2.151.139','men','18','0.508551','/res_img/jwc.mp4/frame_208_0.jpg',8.35,'/media/test_video/jwc.mp4'),(146,'7','16','157','1564','521','84','74','10.2.151.139','men','18','0.571787','/res_img/tangli.mp4/frame_157_0.jpg',6.31,'/media/test_video/tangli.mp4'),(147,'7','15','109','1518','615','78','67','10.2.151.139','men','18','0.534721','/res_img/liupengbo_tangli.mp4/frame_109_m',4.38,'/media/test_video/liupengbo_tangli.mp4'),(148,'4','1','214','1201','330','97','83','10.2.151.139','men','18','0.510832','/res_img/jwc.mp4/frame_214_0.jpg',8.59,'/media/test_video/jwc.mp4'),(149,'7','16','160','1563','533','72','65','10.2.151.139','men','18','0.565908','/res_img/tangli.mp4/frame_160_0.jpg',6.43,'/media/test_video/tangli.mp4'),(150,'7','15','112','1516','609','73','63','10.2.151.139','men','18','0.630602','/res_img/liupengbo_tangli.mp4/frame_112_p',4.50,'/media/test_video/liupengbo_tangli.mp4'),(151,'2','7','172','1478','409','52','45','10.2.151.139','men','18','0.494228','/res_img/yl.mp4/frame_172_0.jpg',6.91,'/media/test_video/yl.mp4'),(152,'4','1','217','1183','302','106','90','10.2.151.139','men','18','0.471471','/res_img/jwc.mp4/frame_217_0.jpg',8.71,'/media/test_video/jwc.mp4'),(153,'7','16','163','1552','530','79','69','10.2.151.139','men','18','0.504347','/res_img/tangli.mp4/frame_163_0.jpg',6.55,'/media/test_video/tangli.mp4'),(154,'7','15','115','1514','605','73','64','10.2.151.139','men','18','0.682208','/res_img/liupengbo_tangli.mp4/frame_115_s',4.62,'/media/test_video/liupengbo_tangli.mp4'),(155,'2','7','175','1479','407','54','49','10.2.151.139','men','18','0.512422','/res_img/yl.mp4/frame_175_0.jpg',7.03,'/media/test_video/yl.mp4'),(156,'4','1','220','1195','283','111','94','10.2.151.139','men','18','0.452107','/res_img/jwc.mp4/frame_220_0.jpg',8.84,'/media/test_video/jwc.mp4'),(157,'7','16','166','1545','543','75','68','10.2.151.139','men','18','0.663343','/res_img/tangli.mp4/frame_166_0.jpg',6.67,'/media/test_video/tangli.mp4'),(158,'7','15','118','1507','600','76','66','10.2.151.139','men','18','0.755160','/res_img/liupengbo_tangli.mp4/frame_118_v',4.74,'/media/test_video/liupengbo_tangli.mp4'),(159,'7','16','169','1538','555','75','67','10.2.151.139','men','18','0.648293','/res_img/tangli.mp4/frame_169_0.jpg',6.79,'/media/test_video/tangli.mp4'),(160,'2','7','181','1500','397','54','45','10.2.151.139','men','18','0.457731','/res_img/yl.mp4/frame_181_0.jpg',7.27,'/media/test_video/yl.mp4'),(161,'7','15','121','1508','600','71','64','10.2.151.139','men','18','0.723254','/res_img/liupengbo_tangli.mp4/frame_121_y',4.86,'/media/test_video/liupengbo_tangli.mp4'),(162,'7','16','172','1534','569','79','64','10.2.151.139','men','18','0.550372','/res_img/tangli.mp4/frame_172_0.jpg',6.91,'/media/test_video/tangli.mp4'),(163,'7','15','124','1507','599','72','66','10.2.151.139','men','18','0.758767','/res_img/liupengbo_tangli.mp4/frame_124_|',4.98,'/media/test_video/liupengbo_tangli.mp4'),(164,'2','7','187','1497','385','61','52','10.2.151.139','men','18','0.502258','/res_img/yl.mp4/frame_187_0.jpg',7.51,'/media/test_video/yl.mp4'),(165,'2','7','190','1486','386','63','54','10.2.151.139','men','18','0.510046','/res_img/yl.mp4/frame_190_0.jpg',7.63,'/media/test_video/yl.mp4'),(166,'7','15','127','1509','597','72','64','10.2.151.139','men','18','0.653070','/res_img/liupengbo_tangli.mp4/frame_127_',5.10,'/media/test_video/liupengbo_tangli.mp4'),(167,'2','7','196','1445','375','62','55','10.2.151.139','men','18','0.450124','/res_img/yl.mp4/frame_196_0.jpg',7.87,'/media/test_video/yl.mp4'),(168,'7','16','181','1540','617','70','63','10.2.151.139','men','18','0.549906','/res_img/tangli.mp4/frame_181_0.jpg',7.27,'/media/test_video/tangli.mp4'),(169,'7','16','184','1538','610','72','62','10.2.151.139','men','18','0.552425','/res_img/tangli.mp4/frame_184_0.jpg',7.39,'/media/test_video/tangli.mp4'),(170,'7','16','187','1532','607','70','60','10.2.151.139','men','18','0.638359','/res_img/tangli.mp4/frame_187_0.jpg',7.51,'/media/test_video/tangli.mp4'),(171,'7','16','190','1526','603','72','62','10.2.151.139','men','18','0.572266','/res_img/tangli.mp4/frame_190_0.jpg',7.63,'/media/test_video/tangli.mp4'),(172,'7','16','193','1520','608','66','59','10.2.151.139','men','18','0.559630','/res_img/tangli.mp4/frame_193_0.jpg',7.75,'/media/test_video/tangli.mp4'),(173,'7','16','196','1513','607','66','56','10.2.151.139','men','18','0.542059','/res_img/tangli.mp4/frame_196_0.jpg',7.87,'/media/test_video/tangli.mp4'),(174,'7','13','202','1542','615','75','62','10.2.151.139','men','18','0.486206','/res_img/tl.mp4/frame_202_0.jpg',8.11,'/media/test_video/tl.mp4'),(175,'7','13','205','1540','616','71','63','10.2.151.139','men','18','0.485410','/res_img/tl.mp4/frame_205_0.jpg',8.23,'/media/test_video/tl.mp4'),(176,'2','7','199','1423','362','67','56','10.2.151.139','men','18','0.456084','/res_img/yl.mp4/frame_199_0.jpg',7.99,'/media/test_video/yl.mp4'),(177,'2','7','202','1416','358','65','57','10.2.151.139','men','18','0.646150','/res_img/yl.mp4/frame_202_0.jpg',8.11,'/media/test_video/yl.mp4'),(178,'2','7','205','1415','354','68','58','10.2.151.139','men','18','0.608187','/res_img/yl.mp4/frame_205_0.jpg',8.23,'/media/test_video/yl.mp4'),(179,'2','7','208','1420','353','69','59','10.2.151.139','men','18','0.604502','/res_img/yl.mp4/frame_208_0.jpg',8.35,'/media/test_video/yl.mp4'),(180,'2','7','211','1431','344','68','58','10.2.151.139','men','18','0.505943','/res_img/yl.mp4/frame_211_0.jpg',8.47,'/media/test_video/yl.mp4'),(181,'2','7','214','1435','333','69','60','10.2.151.139','men','18','0.465183','/res_img/yl.mp4/frame_214_0.jpg',8.59,'/media/test_video/yl.mp4'),(182,'2','7','217','1424','321','73','67','10.2.151.139','men','18','0.599985','/res_img/yl.mp4/frame_217_0.jpg',8.71,'/media/test_video/yl.mp4'),(183,'2','7','220','1413','317','76','69','10.2.151.139','men','18','0.501757','/res_img/yl.mp4/frame_220_0.jpg',8.84,'/media/test_video/yl.mp4'),(184,'2','7','232','1282','285','83','84','10.2.151.139','men','18','0.466203','/res_img/yl.mp4/frame_232_0.jpg',9.32,'/media/test_video/yl.mp4'),(185,'7','13','247','1519','618','71','64','10.2.151.139','men','18','0.470799','/res_img/tl.mp4/frame_247_0.jpg',9.92,'/media/test_video/tl.mp4'),(186,'7','13','250','1517','616','70','65','10.2.151.139','men','18','0.514555','/res_img/tl.mp4/frame_250_0.jpg',10.04,'/media/test_video/tl.mp4'),(187,'7','15','256','1517','594','82','68','10.2.151.139','men','18','0.503702','/res_img/liupengbo_tangli.mp4/frame_256_',10.28,'/media/test_video/liupengbo_tangli.mp4'),(188,'7','13','307','1588','613','70','61','10.2.151.139','men','18','0.511251','/res_img/tl.mp4/frame_307_0.jpg',12.33,'/media/test_video/tl.mp4'),(189,'7','13','310','1587','613','71','62','10.2.151.139','men','18','0.578750','/res_img/tl.mp4/frame_310_0.jpg',12.45,'/media/test_video/tl.mp4'),(190,'7','13','313','1587','613','72','61','10.2.151.139','men','18','0.621580','/res_img/tl.mp4/frame_313_0.jpg',12.57,'/media/test_video/tl.mp4'),(191,'7','13','316','1587','617','73','62','10.2.151.139','men','18','0.549130','/res_img/tl.mp4/frame_316_0.jpg',12.69,'/media/test_video/tl.mp4'),(192,'7','13','319','1586','613','75','63','10.2.151.139','men','18','0.595426','/res_img/tl.mp4/frame_319_0.jpg',12.81,'/media/test_video/tl.mp4'),(193,'7','13','322','1588','616','70','61','10.2.151.139','men','18','0.591627','/res_img/tl.mp4/frame_322_0.jpg',12.93,'/media/test_video/tl.mp4'),(194,'7','13','325','1587','615','74','63','10.2.151.139','men','18','0.530246','/res_img/tl.mp4/frame_325_0.jpg',13.05,'/media/test_video/tl.mp4'),(195,'7','13','328','1584','612','78','65','10.2.151.139','men','18','0.511036','/res_img/tl.mp4/frame_328_0.jpg',13.17,'/media/test_video/tl.mp4'),(196,'7','13','331','1582','612','80','68','10.2.151.139','men','18','0.541102','/res_img/tl.mp4/frame_331_0.jpg',13.29,'/media/test_video/tl.mp4'),(197,'7','13','334','1586','617','74','67','10.2.151.139','men','18','0.539933','/res_img/tl.mp4/frame_334_0.jpg',13.41,'/media/test_video/tl.mp4'),(198,'7','13','337','1589','620','71','62','10.2.151.139','men','18','0.548453','/res_img/tl.mp4/frame_337_0.jpg',13.53,'/media/test_video/tl.mp4'),(199,'7','13','340','1591','620','74','62','10.2.151.139','men','18','0.548574','/res_img/tl.mp4/frame_340_0.jpg',13.65,'/media/test_video/tl.mp4'),(200,'7','13','343','1591','622','77','66','10.2.151.139','men','18','0.459276','/res_img/tl.mp4/frame_343_0.jpg',13.78,'/media/test_video/tl.mp4'),(201,'7','13','349','1595','626','70','62','10.2.151.139','men','18','0.495188','/res_img/tl.mp4/frame_349_0.jpg',14.02,'/media/test_video/tl.mp4'),(202,'7','13','352','1590','618','75','66','10.2.151.139','men','18','0.510395','/res_img/tl.mp4/frame_352_0.jpg',14.14,'/media/test_video/tl.mp4'),(203,'7','13','355','1589','614','75','61','10.2.151.139','men','18','0.557060','/res_img/tl.mp4/frame_355_0.jpg',14.26,'/media/test_video/tl.mp4'),(204,'1','2','319','1417','420','68','54','10.2.151.139','men','18','0.508996','/res_img/lc.mp4/frame_319_0.jpg',12.81,'/media/test_video/lc.mp4'),(205,'1','2','325','1393','417','73','57','10.2.151.139','men','18','0.469044','/res_img/lc.mp4/frame_325_0.jpg',13.05,'/media/test_video/lc.mp4'),(206,'7','13','379','1558','604','74','59','10.2.151.139','men','18','0.493968','/res_img/tl.mp4/frame_379_0.jpg',15.22,'/media/test_video/tl.mp4'),(207,'7','13','382','1558','605','72','56','10.2.151.139','men','18','0.512031','/res_img/tl.mp4/frame_382_0.jpg',15.34,'/media/test_video/tl.mp4'),(208,'7','13','391','1550','605','70','55','10.2.151.139','men','18','0.506375','/res_img/tl.mp4/frame_391_0.jpg',15.70,'/media/test_video/tl.mp4'),(209,'7','13','394','1550','606','70','55','10.2.151.139','men','18','0.510732','/res_img/tl.mp4/frame_394_0.jpg',15.82,'/media/test_video/tl.mp4'),(210,'7','13','397','1547','605','73','58','10.2.151.139','men','18','0.462397','/res_img/tl.mp4/frame_397_0.jpg',15.94,'/media/test_video/tl.mp4'),(211,'1','2','346','1180','354','100','87','10.2.151.139','men','18','0.466079','/res_img/lc.mp4/frame_346_0.jpg',13.90,'/media/test_video/lc.mp4'),(212,'1','2','349','1160','349','109','87','10.2.151.139','men','18','0.456393','/res_img/lc.mp4/frame_349_0.jpg',14.02,'/media/test_video/lc.mp4'),(213,'1','2','352','1125','331','109','92','10.2.151.139','men','18','0.490145','/res_img/lc.mp4/frame_352_0.jpg',14.14,'/media/test_video/lc.mp4'),(214,'2','6','1540','1482','426','49','44','10.2.151.139','men','18','0.462409','/res_img/lpb_yl.mp4/frame_1540_0.jpg',61.85,'/media/test_video/lpb_yl.mp4'),(215,'5','6','1549','1211','358','93','87','10.2.151.139','men','18','0.487008','/res_img/lpb_yl.mp4/frame_1549_0.jpg',62.21,'/media/test_video/lpb_yl.mp4'),(216,'5','6','1552','1211','355','93','86','10.2.151.139','men','18','0.616476','/res_img/lpb_yl.mp4/frame_1552_0.jpg',62.33,'/media/test_video/lpb_yl.mp4'),(217,'2','6','1552','1489','405','54','47','10.2.151.139','men','18','0.478434','/res_img/lpb_yl.mp4/frame_1552_1.jpg',62.33,'/media/test_video/lpb_yl.mp4'),(218,'5','6','1555','1209','334','111','93','10.2.151.139','men','18','0.497411','/res_img/lpb_yl.mp4/frame_1555_0.jpg',62.45,'/media/test_video/lpb_yl.mp4'),(219,'2','6','1555','1496','405','55','48','10.2.151.139','men','18','0.491370','/res_img/lpb_yl.mp4/frame_1555_1.jpg',62.45,'/media/test_video/lpb_yl.mp4'),(220,'5','6','1558','1198','316','98','93','10.2.151.139','men','18','0.524529','/res_img/lpb_yl.mp4/frame_1558_0.jpg',62.57,'/media/test_video/lpb_yl.mp4'),(221,'5','6','1561','1179','302','105','98','10.2.151.139','men','18','0.520483','/res_img/lpb_yl.mp4/frame_1561_0.jpg',62.69,'/media/test_video/lpb_yl.mp4'),(222,'2','6','1561','1512','392','59','50','10.2.151.139','men','18','0.493790','/res_img/lpb_yl.mp4/frame_1561_1.jpg',62.69,'/media/test_video/lpb_yl.mp4'),(223,'5','6','1567','1140','292','108','105','10.2.151.139','men','18','0.495005','/res_img/lpb_yl.mp4/frame_1567_0.jpg',62.93,'/media/test_video/lpb_yl.mp4'),(224,'5','6','1573','1143','232','129','130','10.2.151.139','men','18','0.541316','/res_img/lpb_yl.mp4/frame_1573_0.jpg',63.17,'/media/test_video/lpb_yl.mp4'),(225,'1','16','1','1218','669','331','235','10.2.151.139','men','18','0.472976','/res_img/tangli.mp4/frame_1_0.jpg',0.04,'/media/test_video/tangli.mp4'),(226,'7','16','16','317','520','53','48','10.2.151.139','men','18','0.462497','/res_img/tangli.mp4/frame_16_0.jpg',0.64,'/media/test_video/tangli.mp4'),(227,'7','13','34','1532','602','68','61','10.2.151.139','men','18','0.522990','/res_img/tl.mp4/frame_34_0.jpg',1.37,'/media/test_video/tl.mp4'),(228,'7','13','37','1532','604','66','63','10.2.151.139','men','18','0.593012','/res_img/tl.mp4/frame_37_0.jpg',1.49,'/media/test_video/tl.mp4'),(229,'7','13','40','1531','602','77','67','10.2.151.139','men','18','0.539990','/res_img/tl.mp4/frame_40_0.jpg',1.61,'/media/test_video/tl.mp4'),(230,'1','16','28','1194','665','346','250','10.2.151.139','men','18','0.471404','/res_img/tangli.mp4/frame_28_0.jpg',1.12,'/media/test_video/tangli.mp4'),(231,'7','13','43','1536','609','73','63','10.2.151.139','men','18','0.650889','/res_img/tl.mp4/frame_43_0.jpg',1.73,'/media/test_video/tl.mp4'),(232,'7','13','46','1537','611','78','65','10.2.151.139','men','18','0.567244','/res_img/tl.mp4/frame_46_0.jpg',1.85,'/media/test_video/tl.mp4'),(233,'7','13','49','1540','612','75','64','10.2.151.139','men','18','0.533021','/res_img/tl.mp4/frame_49_0.jpg',1.97,'/media/test_video/tl.mp4'),(234,'1','4','1','615','393','317','258','10.2.151.139','men','18','0.667123','/res_img/lichao.mp4/frame_1_0.jpg',0.04,'/media/test_video/lichao.mp4'),(235,'1','4','4','613','394','317','260','10.2.151.139','men','18','0.669869','/res_img/lichao.mp4/frame_4_0.jpg',0.16,'/media/test_video/lichao.mp4'),(236,'1','4','7','629','406','310','251','10.2.151.139','men','18','0.671815','/res_img/lichao.mp4/frame_7_0.jpg',0.28,'/media/test_video/lichao.mp4'),(237,'1','4','10','621','405','296','247','10.2.151.139','men','18','0.706730','/res_img/lichao.mp4/frame_10_0.jpg',0.40,'/media/test_video/lichao.mp4'),(238,'1','4','13','609','391','333','269','10.2.151.139','men','18','0.733879','/res_img/lichao.mp4/frame_13_0.jpg',0.52,'/media/test_video/lichao.mp4'),(239,'1','4','16','604','400','321','260','10.2.151.139','men','18','0.770172','/res_img/lichao.mp4/frame_16_0.jpg',0.64,'/media/test_video/lichao.mp4'),(240,'1','4','19','603','408','303','247','10.2.151.139','men','18','0.785269','/res_img/lichao.mp4/frame_19_0.jpg',0.76,'/media/test_video/lichao.mp4'),(241,'1','4','22','616','425','281','222','10.2.151.139','men','18','0.858113','/res_img/lichao.mp4/frame_22_0.jpg',0.88,'/media/test_video/lichao.mp4'),(242,'1','4','25','595','422','291','247','10.2.151.139','men','18','0.891328','/res_img/lichao.mp4/frame_25_0.jpg',1.00,'/media/test_video/lichao.mp4'),(243,'7','13','52','1538','605','73','62','10.2.151.139','men','18','0.706901','/res_img/tl.mp4/frame_52_0.jpg',2.09,'/media/test_video/tl.mp4'),(244,'1','4','28','600','418','310','241','10.2.151.139','men','18','0.897184','/res_img/lichao.mp4/frame_28_0.jpg',1.12,'/media/test_video/lichao.mp4'),(245,'7','13','55','1535','600','76','66','10.2.151.139','men','18','0.579494','/res_img/tl.mp4/frame_55_0.jpg',2.21,'/media/test_video/tl.mp4'),(246,'1','4','31','626','431','284','224','10.2.151.139','men','18','0.822420','/res_img/lichao.mp4/frame_31_0.jpg',1.24,'/media/test_video/lichao.mp4'),(247,'7','13','58','1535','599','74','64','10.2.151.139','men','18','0.598448','/res_img/tl.mp4/frame_58_0.jpg',2.33,'/media/test_video/tl.mp4'),(248,'1','4','34','603','423','290','232','10.2.151.139','men','18','0.872761','/res_img/lichao.mp4/frame_34_0.jpg',1.37,'/media/test_video/lichao.mp4'),(249,'7','13','61','1537','600','77','68','10.2.151.139','men','18','0.499067','/res_img/tl.mp4/frame_61_0.jpg',2.45,'/media/test_video/tl.mp4'),(250,'1','4','37','595','424','304','235','10.2.151.139','men','18','0.866480','/res_img/lichao.mp4/frame_37_0.jpg',1.49,'/media/test_video/lichao.mp4'),(251,'7','13','64','1545','602','75','68','10.2.151.139','men','18','0.503038','/res_img/tl.mp4/frame_64_0.jpg',2.57,'/media/test_video/tl.mp4'),(252,'1','4','40','587','413','315','253','10.2.151.139','men','18','0.816509','/res_img/lichao.mp4/frame_40_0.jpg',1.61,'/media/test_video/lichao.mp4'),(253,'1','4','46','602','430','301','250','10.2.151.139','men','18','0.914061','/res_img/lichao.mp4/frame_46_0.jpg',1.85,'/media/test_video/lichao.mp4'),(254,'7','13','79','1539','603','77','68','10.2.151.139','men','18','0.504266','/res_img/tl.mp4/frame_79_0.jpg',3.17,'/media/test_video/tl.mp4'),(255,'1','4','49','607','415','311','238','10.2.151.139','men','18','0.879873','/res_img/lichao.mp4/frame_49_0.jpg',1.97,'/media/test_video/lichao.mp4'),(256,'7','13','82','1534','600','79','69','10.2.151.139','men','18','0.488851','/res_img/tl.mp4/frame_82_0.jpg',3.29,'/media/test_video/tl.mp4'),(257,'7','13','85','1532','604','75','66','10.2.151.139','men','18','0.489606','/res_img/tl.mp4/frame_85_0.jpg',3.41,'/media/test_video/tl.mp4'),(258,'7','13','88','1529','603','71','64','10.2.151.139','men','18','0.637209','/res_img/tl.mp4/frame_88_0.jpg',3.53,'/media/test_video/tl.mp4'),(259,'7','13','91','1526','598','78','67','10.2.151.139','men','18','0.641857','/res_img/tl.mp4/frame_91_0.jpg',3.65,'/media/test_video/tl.mp4'),(260,'7','13','94','1526','599','72','62','10.2.151.139','men','18','0.659820','/res_img/tl.mp4/frame_94_0.jpg',3.78,'/media/test_video/tl.mp4'),(261,'7','13','97','1524','600','70','63','10.2.151.139','men','18','0.706644','/res_img/tl.mp4/frame_97_0.jpg',3.90,'/media/test_video/tl.mp4'),(262,'2','8','1','911','337','160','138','10.2.151.139','men','18','0.832120','/res_img/yl_lc.mp4/frame_1_0.jpg',0.04,'/media/test_video/yl_lc.mp4'),(263,'1','8','1','1266','189','204','168','10.2.151.139','men','18','0.584036','/res_img/yl_lc.mp4/frame_1_1.jpg',0.04,'/media/test_video/yl_lc.mp4'),(264,'2','8','4','906','336','166','147','10.2.151.139','men','18','0.834965','/res_img/yl_lc.mp4/frame_4_0.jpg',0.16,'/media/test_video/yl_lc.mp4'),(265,'1','8','4','1271','195','210','177','10.2.151.139','men','18','0.558069','/res_img/yl_lc.mp4/frame_4_1.jpg',0.16,'/media/test_video/yl_lc.mp4'),(266,'2','8','7','903','330','179','150','10.2.151.139','men','18','0.773159','/res_img/yl_lc.mp4/frame_7_0.jpg',0.28,'/media/test_video/yl_lc.mp4'),(267,'1','8','7','1268','198','175','153','10.2.151.139','men','18','0.554497','/res_img/yl_lc.mp4/frame_7_1.jpg',0.28,'/media/test_video/yl_lc.mp4'),(268,'2','8','10','912','338','162','141','10.2.151.139','men','18','0.835425','/res_img/yl_lc.mp4/frame_10_0.jpg',0.40,'/media/test_video/yl_lc.mp4'),(269,'1','8','10','1267','195','196','169','10.2.151.139','men','18','0.568306','/res_img/yl_lc.mp4/frame_10_1.jpg',0.40,'/media/test_video/yl_lc.mp4'),(270,'2','8','13','905','326','180','153','10.2.151.139','men','18','0.765831','/res_img/yl_lc.mp4/frame_13_0.jpg',0.52,'/media/test_video/yl_lc.mp4'),(271,'1','8','13','1281','193','195','155','10.2.151.139','men','18','0.537782','/res_img/yl_lc.mp4/frame_13_1.jpg',0.52,'/media/test_video/yl_lc.mp4'),(272,'2','8','16','910','334','167','145','10.2.151.139','men','18','0.813006','/res_img/yl_lc.mp4/frame_16_0.jpg',0.64,'/media/test_video/yl_lc.mp4'),(273,'1','8','16','1262','197','192','171','10.2.151.139','men','18','0.563224','/res_img/yl_lc.mp4/frame_16_1.jpg',0.64,'/media/test_video/yl_lc.mp4'),(274,'2','8','19','912','337','162','141','10.2.151.139','men','18','0.824097','/res_img/yl_lc.mp4/frame_19_0.jpg',0.76,'/media/test_video/yl_lc.mp4'),(275,'1','8','19','1273','193','192','160','10.2.151.139','men','18','0.512867','/res_img/yl_lc.mp4/frame_19_1.jpg',0.76,'/media/test_video/yl_lc.mp4');
/*!40000 ALTER TABLE `users_check` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_face`
--

DROP TABLE IF EXISTS `users_face`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_face` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `mobile` varchar(11) CHARACTER SET latin1 NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `email` varchar(254) NOT NULL,
  `flag` int(11) NOT NULL,
  `createDate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_face`
--

LOCK TABLES `users_face` WRITE;
/*!40000 ALTER TABLE `users_face` DISABLE KEYS */;
INSERT INTO `users_face` VALUES (1,'李超','18812341234',0,'lichao-ams@ict.ac.cn',1,'2019-06-27 16:19:26'),(2,'严龙','12345678911',0,'yanlong@test.com',1,'2019-06-27 16:36:58'),(3,'董睿','18812354879',0,'jiaweichuang@ict.ac.cn',1,'2019-06-27 16:44:45'),(4,'贾伟闯','18812354879',0,'jiaweichuang@ict.ac.cn',1,'2019-06-27 16:44:52'),(5,'刘鹏博','13678977897',0,'liupengbo@ict.ac.cn',1,'2019-06-27 16:45:18'),(6,'罗鑫','18845647897',0,'luoxin@ict.ac.cn',1,'2019-06-27 16:45:46'),(7,'唐立','15645644454',0,'tangli@ict.ac.cn',1,'2019-06-27 16:46:31'),(8,'陆倩雯','18896722430',1,'luqianwen@ict.ac.cn',1,'2019-06-28 15:29:33'),(9,'范晓琪','12346551111',0,'fanxiaoqi@sina.com',0,'2019-07-02 16:18:20'),(10,'张三','18812345647',0,'aaa@163.com',1,'2019-07-02 16:53:58'),(11,'李四','11111111111',0,'test@test.com',1,'2019-07-02 16:55:15'),(12,'王五','11111111111',0,'test1@test.com',1,'2019-07-02 17:01:40'),(13,'李大仁','11111111111',1,'test2@test.com',1,'2019-07-02 17:08:16'),(14,'李超','18812341254',0,'a@163.com',1,'2019-07-02 17:25:36'),(15,'周一山','18815647894',0,'fe@163.com',1,'2019-07-05 14:14:57'),(16,'周大福','18846877894',0,'fffe@163.com',1,'2019-07-05 14:15:55'),(17,'周生生','15644577897',0,'aaa@163.com',1,'2019-07-05 14:16:38');
/*!40000 ALTER TABLE `users_face` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_faceimg`
--

DROP TABLE IF EXISTS `users_faceimg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_faceimg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imgurl` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `userid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_faceimg_userid_id_53f4ee7b_fk_users_face_id` (`userid_id`),
  CONSTRAINT `users_faceimg_userid_id_53f4ee7b_fk_users_face_id` FOREIGN KEY (`userid_id`) REFERENCES `users_face` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_faceimg`
--

LOCK TABLES `users_faceimg` WRITE;
/*!40000 ALTER TABLE `users_faceimg` DISABLE KEYS */;
INSERT INTO `users_faceimg` VALUES (4,'http://10.2.151.139:8888/media/image/2/yl.jpg',2),(6,'http://10.2.151.139:8888/media/image/4/jwc.jpg',4),(7,'http://10.2.151.139:8888/media/image/5/lpb.jpg',5),(8,'http://10.2.151.139:8888/media/image/6/lx.jpg',6),(9,'http://10.2.151.139:8888/media/image/7/tl.jpg',7),(11,'http://10.2.151.139:8888/media/image/1/lic.jpg',1),(13,'http://10.2.151.139:8888/media/image/8/luqianwen.jpg',8),(14,'http://10.2.151.139:8888/media/image/1/li.jpg',1),(15,'http://10.2.151.139:8888/media/image/9/timg.jpg',9),(17,'http://10.2.151.139:8888/media/image/3/1.jpg',3),(32,'http://10.2.151.139:8888/media/image/11/7.jpg',11),(35,'http://10.2.151.139:8888/media/image/17/13.jpg',17),(36,'http://10.2.151.139:8888/media/image/12/5.jpg',12),(37,'http://10.2.151.139:8888/media/image/13/15.jpg',13),(38,'http://10.2.151.139:8888/media/image/14/3.jpg',14),(39,'http://10.2.151.139:8888/media/image/15/4.jpg',15),(40,'http://10.2.151.139:8888/media/image/16/20.jpg',16),(41,'http://10.2.151.139:8888/media/image/10/19.jpg',10);
/*!40000 ALTER TABLE `users_faceimg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_stream`
--

DROP TABLE IF EXISTS `users_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_stream` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `streamname` varchar(50) CHARACTER SET latin1 NOT NULL,
  `streamlocation` varchar(100) NOT NULL,
  `streamurl` varchar(100) CHARACTER SET latin1 NOT NULL,
  `streamlat` varchar(24) CHARACTER SET latin1 NOT NULL,
  `streamlon` varchar(24) CHARACTER SET latin1 NOT NULL,
  `flag` int(11) NOT NULL,
  `createDate` datetime NOT NULL,
  `streamtime` varchar(256) DEFAULT NULL,
  `streamfps` varchar(256) DEFAULT NULL,
  `streamstatus` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `streamname` (`streamname`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_stream`
--

LOCK TABLES `users_stream` WRITE;
/*!40000 ALTER TABLE `users_stream` DISABLE KEYS */;
INSERT INTO `users_stream` VALUES (1,'video_jwc','城市学院','http://10.2.151.139:8888/media/test_video/jwc.mp4','39.987299','116.34657',0,'2019-06-27 17:22:22','16.0','25.0','1'),(2,'video_lc','城市学院','http://10.2.151.139:8888/media/test_video/lc.mp4','39.987298','116.35657',0,'2019-06-27 17:23:26','24.0','25.0','1'),(3,'video_lc_yl','城市学院','http://10.2.151.139:8888/media/test_video/lc_yl.mp4','39.987297','116.37657',0,'2019-06-28 11:28:22','7.0','25.0','1'),(4,'video_lichao','城市学院','http://10.2.151.139:8888/media/test_video/lichao.mp4','39.987296','116.34657',0,'2019-06-28 11:32:24','5.0','25.0','1'),(6,'video_lpb_yl','城市学院','http://10.2.151.139:8888/media/test_video/lpb_yl.mp4','39.987295','116.34657',0,'2019-06-28 14:47:27','77.0','25.0','1'),(7,'video_yl','城市学院','http://10.2.151.139:8888/media/test_video/yl.mp4','39.987294','116.34657',0,'2019-06-28 14:47:27','20.0','25.0','1'),(8,'video_yl_lc','城市学院','http://10.2.151.139:8888/media/test_video/yl_lc.mp4','39.987293','116.44657',0,'2019-06-28 14:47:27','5.0','25.0','1'),(11,'video_08_02','环保园','asd','39.987292','116.34657',0,'2019-07-03 18:57:19','10.0','25.0','0'),(12,'video_07_02','城市学院','http://10.2.151.139:8888/media/test_video/video_07_02.mp4','39.787298','116.34657',0,'2019-07-05 11:41:01','27.0','25.0','1'),(13,'video_tl','城市学院','http://10.2.151.139:8888/media/test_video/tl.mp4','39.787288','116.34657',0,'2019-07-15 17:49:00','18.7','25.0','1'),(14,'video_lx','城市学院','http://10.2.151.139:8888/media/test_video/luoxin.mp4','39.787278','116.34668',0,'2019-07-15 17:49:40','8.9','25.0','1'),(15,'video_lpb_tl','城市学院','http://10.2.151.139:8888/media/test_video/liupengbo_tangli.mp4','39.787268','116.34658',0,'2019-07-15 17:50:22','19.8','25.0','1'),(16,'video_tl1','城市学院','http://10.2.151.139:8888/media/test_video/tangli.mp4','39.787258','116.34659',0,'2019-07-15 17:50:52','8.1','25.0','1'),(17,'video_new','北京理工大学','http://10.2.151.139:8888/media/test_video/lpb_yl.mp4','39.156457','119.152313',0,'2019-07-22 15:54:48','77.7','25.0','0'),(18,'video_hellpo','顺义研究院','http://10.2.151.139:8888/media/test_video/lpb_yl.mp4','39.157898','120.148568',0,'2019-07-22 16:00:30','77.7','25.0','0'),(19,'video_yc','盐城高通量研究院','http://10.2.151.139:8888/media/test_video/jwc.mp4','29.135487','114.111567',0,'2019-07-22 16:06:48','17.0','25.0','0'),(20,'video_nanjin','南京分公司','http://10.2.151.139:8888/media/test_video/jwc.mp4','38.1562235','116.123453',0,'2019-07-22 16:09:35','17.0','25.0','0');
/*!40000 ALTER TABLE `users_stream` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile`
--

DROP TABLE IF EXISTS `users_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `users_userprofile_user_id_87251ef1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile`
--

LOCK TABLES `users_userprofile` WRITE;
/*!40000 ALTER TABLE `users_userprofile` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_verifycode`
--

DROP TABLE IF EXISTS `users_verifycode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_verifycode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_verifycode`
--

LOCK TABLES `users_verifycode` WRITE;
/*!40000 ALTER TABLE `users_verifycode` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_verifycode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `vue_face`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `vue_face` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `vue_face`;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add group',4,'add_group'),(11,'Can change group',4,'change_group'),(12,'Can delete group',4,'delete_group'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add user profile',7,'add_userprofile'),(20,'Can change user profile',7,'change_userprofile'),(21,'Can delete user profile',7,'delete_userprofile'),(22,'Can add ?????',8,'add_verifycode'),(23,'Can change ?????',8,'change_verifycode'),(24,'Can delete ?????',8,'delete_verifycode'),(25,'Can add ????',9,'add_face'),(26,'Can change ????',9,'change_face'),(27,'Can delete ????',9,'delete_face'),(28,'Can add ??????',10,'add_faceimg'),(29,'Can change ??????',10,'change_faceimg'),(30,'Can delete ??????',10,'delete_faceimg'),(31,'Can add ????',11,'add_check'),(32,'Can change ????',11,'change_check'),(33,'Can delete ????',11,'delete_check'),(34,'Can add ???',12,'add_stream'),(35,'Can change ???',12,'change_stream'),(36,'Can delete ???',12,'delete_stream'),(37,'Can add Token',13,'add_token'),(38,'Can change Token',13,'change_token'),(39,'Can delete Token',13,'delete_token'),(40,'Can add captcha store',14,'add_captchastore'),(41,'Can change captcha store',14,'change_captchastore'),(42,'Can delete captcha store',14,'delete_captchastore');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$eLCTUNX7Oz5Q$zp0r5PIlI2tMD/CWZ3jeGzPdOQXDEbTCMxHpZbcZk4s=','2019-06-28 17:36:00',1,'test','','','',1,1,'2019-06-27 15:35:55');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('0d224c4a3cadacd68906a0dba4973ab7d4606337','2019-06-27 15:35:55',1);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captcha_captchastore`
--

DROP TABLE IF EXISTS `captcha_captchastore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `captcha_captchastore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_captchastore`
--

LOCK TABLES `captcha_captchastore` WRITE;
/*!40000 ALTER TABLE `captcha_captchastore` DISABLE KEYS */;
INSERT INTO `captcha_captchastore` VALUES (1,'FIDP','fidp','f77892161f694201218e6695561b1919580fd91c','2019-06-27 15:20:04'),(2,'TYFV','tyfv','e11403c6351dbaa99d4d440e4fa4e6aac0ab96ab','2019-06-27 15:20:04'),(3,'TBTG','tbtg','56832664b0760b16a9009e4745cc30d136c26043','2019-06-27 15:20:07'),(4,'DDLF','ddlf','8e2a8854586da229b47fce5f45fe2d456e84da55','2019-06-27 15:20:16'),(5,'TZYB','tzyb','a2f648d4598425fcece4927587c7cf18ecb44172','2019-06-27 15:35:24'),(6,'HSTX','hstx','030ddce3251a2f0ad1a2b4a772c1f5994b87870c','2019-06-27 15:35:48'),(7,'MIRD','mird','48a425b66be2d6a28c603f9d676713816e02afe0','2019-06-27 15:35:52'),(8,'MPAG','mpag','f5eee3533fdb8107b8a03185ad1d1be537fd352f','2019-06-27 15:37:14'),(9,'EBUB','ebub','f818a19a5e4f50f32f78bcd028c35fedc9e68362','2019-06-27 15:38:15'),(10,'PWZI','pwzi','9ceacfc3390b7def02a1ad9e5e4cfd428f2ad986','2019-06-27 15:38:28'),(11,'HZDF','hzdf','8cb31d69b8e8e44472376f0baea05ffd46c081d5','2019-06-27 15:39:22'),(12,'TSNO','tsno','1cd39b3040f89371b6eabafb239263806771db0b','2019-06-27 15:39:25'),(13,'MPFB','mpfb','a777e476193c6a3c6471485fdfb846a349bd1ab3','2019-06-27 15:45:12'),(14,'DMEZ','dmez','72d4f12536e5525a35f46265996aebe1255f991c','2019-06-27 15:45:20'),(15,'BGXK','bgxk','e0ee19ebf93e4170e503da0e8b3764004820a7b1','2019-06-27 15:45:25'),(16,'QYSZ','qysz','ab0d0c523bdd0041fe365405cd05922adb315a2c','2019-06-27 15:45:28'),(17,'EKIJ','ekij','cff7f0fb0edb087d37559c0f5058fd68bd344f91','2019-06-27 16:16:24'),(18,'NXSS','nxss','54d147d3d2dda9b3fd5db94f49e4501cadfceed6','2019-06-27 16:19:20'),(19,'YKWJ','ykwj','fed5774bfda1f8f343e91e870599a87b3345f0fc','2019-06-27 17:50:22'),(20,'DOHJ','dohj','1d94e4d10724b2582eb67e93d8f1d9e9c3cac14d','2019-06-28 14:53:24'),(21,'AQXG','aqxg','f1123d6e56154dcaadeb15093c8c40e861f64f80','2019-06-28 15:02:16'),(22,'VPLM','vplm','de7e59a53162f8c44e5dbab8a4d925b0c5817996','2019-06-28 15:16:24'),(23,'YQPR','yqpr','be0292cd6db1728692863f8d24517522b919e762','2019-06-28 15:16:38'),(24,'ZFZS','zfzs','6d16ff807d97c617550832c35e567696bb3cd493','2019-06-28 15:18:22'),(25,'OYMK','oymk','d86a3746c34557890adc99e2c1ff736fcc30423c','2019-06-28 15:20:42'),(26,'BSCA','bsca','d44e9b2cc4ca060c769c3996e4deeb813cb3c19e','2019-06-28 15:53:02'),(27,'CWRJ','cwrj','58b014449e9d67b1270ec2919b423034b440c800','2019-06-28 16:25:24'),(28,'BVRT','bvrt','343468605db0a0d07646588a4328d585f1f16ad1','2019-06-28 16:39:22'),(29,'FGGX','fggx','3338071afa3575a1f67bbee47ed27fd34b992eb7','2019-06-28 16:39:51'),(30,'HCMI','hcmi','35f0d81ae850d85c332dcc64fa80a50a003bbf9b','2019-06-28 16:40:00'),(31,'WZGZ','wzgz','14fa64fb5808c80f775cf8af9a9f63e56c39886d','2019-06-28 16:40:09'),(32,'YNDJ','yndj','28cd3ab9d8475cdfa12a1ded25fe7d66c683b624','2019-06-28 16:40:36'),(33,'SXOI','sxoi','59c9aadaeb68f1b364e5c2effb456f4977fa5ddc','2019-06-28 16:40:46'),(34,'GPNW','gpnw','3f794369df18bd9bc7bf3aea101ff3b93a360d60','2019-06-28 16:40:52'),(35,'RFWR','rfwr','5994fbdfe334e1e7441261de3f54fc8513374209','2019-06-28 16:41:00'),(36,'KPCC','kpcc','07b14557049962a562d7fd62fdb64fd63264960a','2019-06-28 16:41:09'),(37,'DVPR','dvpr','fdb04d7e5a12312d0dec051c9679c08eb7c1db63','2019-06-28 16:41:16'),(38,'CVDU','cvdu','a010a9ee96bc2943a81c28878824eae4c78786f1','2019-06-28 16:41:24'),(39,'YGIW','ygiw','bfc0db067430b90c5c5f13b5a9bfb9f084e1089d','2019-06-28 16:44:59'),(40,'BVWV','bvwv','7dc8f8889518fd4075e3d9be6a0e89535188234d','2019-06-28 16:45:05'),(41,'AFHK','afhk','69d564650d0ce12daa7f875a54db49484524daff','2019-06-28 16:45:14'),(42,'CKAF','ckaf','3e70b03c7482f29e513eea74a57095ef1809ee21','2019-06-28 16:45:49'),(43,'YTGO','ytgo','929ebdb29538f52cbd01d610f43eb4936cdfbc52','2019-06-28 16:47:36'),(44,'EVLX','evlx','3c02c1a618097939dba98bd39f0d51f5d1d54243','2019-06-28 16:47:46'),(45,'QDXZ','qdxz','4011655f859b32e7f3ab2652a9ec0fd2f438c558','2019-06-28 16:51:03'),(46,'IKLZ','iklz','e58fe7d2c54044494803d1582b0b6127eb206fd2','2019-06-28 17:11:38'),(47,'KXKY','kxky','83ea42a09c2e846e6ea27d15d7ca4748bf1a48a9','2019-06-28 17:59:35'),(48,'OFQQ','ofqq','4b14c1eaee7256ca0d201af18830c51f927eb2e9','2019-06-28 18:20:05'),(49,'HAAO','haao','b4d87347602e8ae9a988711be57c6b0e4046e814','2019-06-28 18:35:53'),(50,'PXVN','pxvn','8337850b90f955ca59fba266c566281a040342be','2019-07-01 09:48:02'),(51,'PJRS','pjrs','c558617fd02783527b91be89a434773f878be54b','2019-07-01 10:05:00'),(52,'NWOO','nwoo','180e4906b49a39511fbdecd773bcfcdb7ac995fa','2019-07-01 11:55:47'),(53,'ZKTA','zkta','3b8de643932cb2484508fdf6c99caf59520fd40b','2019-07-01 11:56:48'),(54,'NHBT','nhbt','18030eda901fa4e65890c4880bdb5da9f38a4eb5','2019-07-01 12:03:40'),(55,'GLBG','glbg','23f182fbfcb7b000eef260e61ec281ae1b54194a','2019-07-01 15:58:04'),(56,'HKGE','hkge','e6c7efb92db011ea2051f65c634de321932e9e9e','2019-07-02 10:10:19'),(57,'SYEJ','syej','9fee44bab772478d1373f01f2899a831ec632f5d','2019-07-02 14:06:06'),(58,'IWXZ','iwxz','000eb6c9488c100809692fa2748973f59ff72d98','2019-07-02 14:13:34'),(59,'TKPW','tkpw','c90c6ea79c27706179ab4e094280ed4155b5a764','2019-07-02 14:13:34'),(60,'DIGQ','digq','cba29a42e34e363af9727ad93c9eea719b87c385','2019-07-02 14:13:52'),(61,'CNYY','cnyy','7ee8840acb975eb777fc60b829f0706a0725f5f8','2019-07-02 14:14:13'),(62,'ZVDV','zvdv','2b963cb43315f18d7b9c5b6e46d4becead82e16b','2019-07-02 14:14:34'),(63,'MGBN','mgbn','b140384036bf25e37610bd3859a3a0d854e4b5e1','2019-07-02 16:09:03'),(64,'DGTI','dgti','95da2f4e22a0ab392381115b91fb0a6efd5599c6','2019-07-02 16:53:53'),(65,'OVMI','ovmi','f94fa0bbd1f469fe9b1d29748b5fc1701ca96a1c','2019-07-02 16:54:09'),(66,'WJIH','wjih','ab4d15608b91e5ea1869252f9d19d773ac74f684','2019-07-02 16:55:35'),(67,'SHNV','shnv','9e2a93d40b6e5dfe9b272c7f433fb7217fc6a7c3','2019-07-03 10:19:26'),(68,'MSTO','msto','0aab1f3a04e50349e1593478764bf29422a415f2','2019-07-03 16:22:21'),(69,'VRBF','vrbf','24e6bb5947ab7090c936228c312788ea7c48f27a','2019-07-03 17:29:50'),(70,'PIAP','piap','b6c98a9a13f0f8e721a19728098f3ac7322c497f','2019-07-03 17:44:55'),(71,'WVQZ','wvqz','7cef11c597bbcd195733849e62016229cbfde860','2019-07-03 18:00:15'),(72,'BHVB','bhvb','cdfa34c2c2796ad3b659a0366e263c5f432ff3bb','2019-07-04 09:52:51'),(73,'AYCM','aycm','696b07a2250ba1fc5177c2e60989c72ff5d25f20','2019-07-04 10:09:51'),(74,'ACVN','acvn','52074b2d04be6f4976736cc137bb4980aeaed5df','2019-07-04 10:20:06'),(75,'RSQH','rsqh','a9dd9950fa4b9290c3819806adf2e70346d44939','2019-07-04 17:40:53'),(76,'JGUM','jgum','bb67eca8b56fc347ddb9f3f743d582c4cf1b0f34','2019-07-05 10:25:33'),(77,'KZHM','kzhm','6154881c4924396a9f2c80251fcb2923652a4c46','2019-07-05 10:45:26'),(78,'EDMA','edma','5c8c916cf98ef8ea04de9ee6729a9c87f67fbc44','2019-07-05 10:45:27'),(79,'XWDW','xwdw','675bc83ff44d390ff3f4f44b712fd4c314cfc306','2019-07-05 10:52:09'),(80,'HORJ','horj','41e0b32e210a38ca651b8b07ab2756910c280aa3','2019-07-05 11:05:47'),(81,'IPPS','ipps','1ebfe7d7221ab6172461b541f47e0f804453efea','2019-07-05 12:02:32'),(82,'ASXR','asxr','1a30d4362edb5e2f806a1132e634f6dd419e0e27','2019-07-05 16:33:38'),(83,'LWHJ','lwhj','a637c9e1d807030f4f6e0d81cf52cc24b64806a2','2019-07-05 16:41:26'),(84,'JXZG','jxzg','23a50ed0b51191c79282463114e61398070ab105','2019-07-05 17:24:31'),(85,'SETZ','setz','a399b886c9b9ddce517e6b061002cdb1837a56ce','2019-07-08 09:12:33'),(86,'OYVX','oyvx','a26ca8a87b6624924068fc347649745376ad3f1b','2019-07-08 09:12:59'),(87,'MPUO','mpuo','104564d3d1ba807d3638a2ee83f246b22c88ad2e','2019-07-09 09:32:33'),(88,'PKWY','pkwy','7c5926b1b22373f1bbd8581ebd7bf4431dcf2930','2019-07-10 09:33:45'),(89,'KQXF','kqxf','0476e699417618af266e7b9e34d356bb82997de0','2019-07-10 11:27:10'),(90,'EMVL','emvl','e7af1f729815371a81ca57609febf72b818be353','2019-07-11 10:24:49'),(91,'MBIF','mbif','310ab3fae7335a3c728b4825d0b1dcd208c60f6a','2019-07-11 15:10:16'),(92,'PDTA','pdta','07c2e88ca38d98c92406b837da1c9890fe9702fb','2019-07-11 15:10:27'),(93,'QGAM','qgam','2f49d977b29d7f8a00bcc76d9949545ceed8d4bf','2019-07-12 15:10:50'),(94,'EHLX','ehlx','3c610026661e716c5a7b33303610b9bfe002a85b','2019-07-15 09:07:59'),(95,'YNMT','ynmt','77b860d6371c33709353fc26dbd072f19146f6c1','2019-07-15 15:43:34'),(96,'VLUN','vlun','735ca3b7686cd1f6826992cc329f8fe92d58ca5f','2019-07-15 15:44:24'),(97,'XOJU','xoju','0e516f0a1439ceb3ed042f1ee8afaaffd55cdf53','2019-07-15 15:48:52'),(98,'YHRG','yhrg','c55e19ab56999a3098a0b174b064df596718ea32','2019-07-17 09:34:30'),(99,'FEAM','feam','d4d6bd21f3951e6e0f2f91e91515245ecad3ffcb','2019-07-18 09:41:12'),(100,'JIOB','jiob','b459e0323816a1df266547c064b26b220ec7a04f','2019-07-19 09:59:52'),(101,'NUYA','nuya','29d60cdd87d337f7a64ce52a9fe6058a0d6357d6','2019-07-22 14:24:15'),(102,'IWUT','iwut','c80b3ae06d6f6d1fdfdb21791f1ca03cf109cd9e','2019-07-22 17:37:28'),(103,'LOZN','lozn','630eea785d0bdb82ea0991cd4f6aa416042c7e20','2019-07-22 17:37:32'),(104,'NFXY','nfxy','fd95c334525ea16453cb6fc7dec297445cdf0416','2019-07-22 17:54:18'),(105,'JXKR','jxkr','07106ab5ce34502a1b3955eb37e89a9d38665dfe','2019-07-23 10:31:06'),(106,'SFKR','sfkr','fb2fbe6b7e13c75a96373546a4e71ac0642caea0','2019-07-23 10:32:51'),(107,'KRIL','kril','29bddaafd8108903e882b573a27b1a8f3603adc2','2019-07-23 10:44:11'),(108,'VEIV','veiv','93a6e9f6a915c727e8f868881b42cc8e8646a743','2019-07-23 10:44:13'),(109,'BYBX','bybx','a536f349e7ebdc4580982c24d5def47f77ff5bda','2019-07-23 14:12:22');
/*!40000 ALTER TABLE `captcha_captchastore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(4,'auth','group'),(2,'auth','permission'),(3,'auth','user'),(13,'authtoken','token'),(14,'captcha','captchastore'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(11,'users','check'),(9,'users','face'),(10,'users','faceimg'),(12,'users','stream'),(7,'users','userprofile'),(8,'users','verifycode');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-06-27 10:34:50'),(2,'auth','0001_initial','2019-06-27 10:34:52'),(3,'admin','0001_initial','2019-06-27 10:34:52'),(4,'admin','0002_logentry_remove_auto_add','2019-06-27 10:34:52'),(5,'contenttypes','0002_remove_content_type_name','2019-06-27 10:34:52'),(6,'auth','0002_alter_permission_name_max_length','2019-06-27 10:34:52'),(7,'auth','0003_alter_user_email_max_length','2019-06-27 10:34:52'),(8,'auth','0004_alter_user_username_opts','2019-06-27 10:34:52'),(9,'auth','0005_alter_user_last_login_null','2019-06-27 10:34:52'),(10,'auth','0006_require_contenttypes_0002','2019-06-27 10:34:52'),(11,'auth','0007_alter_validators_add_error_messages','2019-06-27 10:34:52'),(12,'auth','0008_alter_user_username_max_length','2019-06-27 10:34:53'),(13,'authtoken','0001_initial','2019-06-27 10:34:53'),(14,'authtoken','0002_auto_20160226_1747','2019-06-27 10:34:53'),(15,'captcha','0001_initial','2019-06-27 10:34:53'),(16,'sessions','0001_initial','2019-06-27 10:34:53'),(17,'users','0001_initial','2019-06-27 15:52:43'),(18,'users','0002_auto_20190627_1552','2019-06-27 15:52:43');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('hs0v43s4cifixd6sex4nsux52xlnzk9t','ODE1NGM2NDVjN2ZlZjYxYzM4Y2UwYjg2ZjBiMmMwY2YxNTk5Mjk2Yjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI5ZDQ4ZGRiOGJjYWNjYTkzMGQxNTRhMzUzNmIyNGI1NGI4MzNiYTAxIn0=','2019-07-12 17:36:00');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_check`
--

DROP TABLE IF EXISTS `users_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `faceid` varchar(10) CHARACTER SET latin1 NOT NULL,
  `streamid` varchar(256) CHARACTER SET latin1 NOT NULL,
  `timestap` varchar(100) CHARACTER SET latin1 NOT NULL,
  `c_x` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_y` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_w` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_h` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_ip` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `c_gender` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_age` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `c_threshold` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `imgurl` varchar(100) DEFAULT NULL,
  `time` float(11,2) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_check`
--

LOCK TABLES `users_check` WRITE;
/*!40000 ALTER TABLE `users_check` DISABLE KEYS */;
INSERT INTO `users_check` VALUES (1,'1','16','1','1218','669','331','235','10.2.151.139','men','18','0.472976','/res_img/tangli.mp4/frame_1_0.jpg',0.04,'/media/test_video/tangli.mp4'),(2,'7','16','16','317','520','53','48','10.2.151.139','men','18','0.462497','/res_img/tangli.mp4/frame_16_0.jpg',0.64,'/media/test_video/tangli.mp4'),(3,'7','13','34','1532','602','68','61','10.2.151.139','men','18','0.522990','/res_img/tl.mp4/frame_34_0.jpg',1.37,'/media/test_video/tl.mp4'),(4,'7','13','37','1532','604','66','63','10.2.151.139','men','18','0.593013','/res_img/tl.mp4/frame_37_0.jpg',1.49,'/media/test_video/tl.mp4'),(5,'7','13','40','1531','602','77','67','10.2.151.139','men','18','0.539990','/res_img/tl.mp4/frame_40_0.jpg',1.61,'/media/test_video/tl.mp4'),(6,'1','16','28','1194','665','346','250','10.2.151.139','men','18','0.471404','/res_img/tangli.mp4/frame_28_0.jpg',1.12,'/media/test_video/tangli.mp4'),(7,'7','13','43','1536','609','73','63','10.2.151.139','men','18','0.650889','/res_img/tl.mp4/frame_43_0.jpg',1.73,'/media/test_video/tl.mp4'),(8,'7','13','46','1537','611','78','65','10.2.151.139','men','18','0.567244','/res_img/tl.mp4/frame_46_0.jpg',1.85,'/media/test_video/tl.mp4'),(9,'7','13','49','1540','612','75','64','10.2.151.139','men','18','0.533021','/res_img/tl.mp4/frame_49_0.jpg',1.97,'/media/test_video/tl.mp4'),(10,'7','13','52','1538','605','73','62','10.2.151.139','men','18','0.706901','/res_img/tl.mp4/frame_52_0.jpg',2.09,'/media/test_video/tl.mp4'),(11,'7','13','55','1535','600','76','66','10.2.151.139','men','18','0.579494','/res_img/tl.mp4/frame_55_0.jpg',2.21,'/media/test_video/tl.mp4'),(12,'6','14','4','276','433','110','94','10.2.151.139','men','18','0.496353','/res_img/luoxin.mp4/frame_4_0.jpg',0.16,'/media/test_video/luoxin.mp4'),(13,'7','13','58','1535','599','74','64','10.2.151.139','men','18','0.598448','/res_img/tl.mp4/frame_58_0.jpg',2.33,'/media/test_video/tl.mp4'),(14,'6','14','7','307','436','106','93','10.2.151.139','men','18','0.492542','/res_img/luoxin.mp4/frame_7_0.jpg',0.28,'/media/test_video/luoxin.mp4'),(15,'7','13','61','1537','600','77','68','10.2.151.139','men','18','0.499067','/res_img/tl.mp4/frame_61_0.jpg',2.45,'/media/test_video/tl.mp4'),(16,'7','13','64','1545','602','75','68','10.2.151.139','men','18','0.503039','/res_img/tl.mp4/frame_64_0.jpg',2.57,'/media/test_video/tl.mp4'),(17,'7','13','79','1539','603','77','68','10.2.151.139','men','18','0.504267','/res_img/tl.mp4/frame_79_0.jpg',3.17,'/media/test_video/tl.mp4'),(18,'7','13','82','1534','600','79','69','10.2.151.139','men','18','0.488851','/res_img/tl.mp4/frame_82_0.jpg',3.29,'/media/test_video/tl.mp4'),(19,'2','3','1','857','347','168','140','10.2.151.139','men','18','0.677336','/res_img/lc_yl.mp4/frame_1_0.jpg',0.04,'/media/test_video/lc_yl.mp4'),(20,'7','13','85','1532','604','75','66','10.2.151.139','men','18','0.489606','/res_img/tl.mp4/frame_85_0.jpg',3.41,'/media/test_video/tl.mp4'),(21,'2','3','4','858','352','155','133','10.2.151.139','men','18','0.695457','/res_img/lc_yl.mp4/frame_4_0.jpg',0.16,'/media/test_video/lc_yl.mp4'),(22,'1','3','4','1222','93','170','141','10.2.151.139','men','18','0.480163','/res_img/lc_yl.mp4/frame_4_1.jpg',0.16,'/media/test_video/lc_yl.mp4'),(23,'7','13','88','1529','603','71','64','10.2.151.139','men','18','0.637209','/res_img/tl.mp4/frame_88_0.jpg',3.53,'/media/test_video/tl.mp4'),(24,'7','13','91','1526','598','78','67','10.2.151.139','men','18','0.641857','/res_img/tl.mp4/frame_91_0.jpg',3.65,'/media/test_video/tl.mp4'),(25,'2','3','7','847','358','146','133','10.2.151.139','men','18','0.453609','/res_img/lc_yl.mp4/frame_7_0.jpg',0.28,'/media/test_video/lc_yl.mp4'),(26,'1','3','7','1219','103','158','143','10.2.151.139','men','18','0.497100','/res_img/lc_yl.mp4/frame_7_1.jpg',0.28,'/media/test_video/lc_yl.mp4'),(27,'7','13','94','1526','599','72','62','10.2.151.139','men','18','0.659820','/res_img/tl.mp4/frame_94_0.jpg',3.78,'/media/test_video/tl.mp4'),(28,'7','13','97','1524','600','70','63','10.2.151.139','men','18','0.706644','/res_img/tl.mp4/frame_97_0.jpg',3.90,'/media/test_video/tl.mp4'),(29,'1','3','22','1202','124','160','145','10.2.151.139','men','18','0.527039','/res_img/lc_yl.mp4/frame_22_0.jpg',0.88,'/media/test_video/lc_yl.mp4'),(30,'1','3','28','1171','125','175','154','10.2.151.139','men','18','0.478688','/res_img/lc_yl.mp4/frame_28_0.jpg',1.12,'/media/test_video/lc_yl.mp4'),(31,'1','3','31','1182','125','174','147','10.2.151.139','men','18','0.527478','/res_img/lc_yl.mp4/frame_31_0.jpg',1.24,'/media/test_video/lc_yl.mp4'),(32,'1','3','34','1178','125','168','149','10.2.151.139','men','18','0.597165','/res_img/lc_yl.mp4/frame_34_0.jpg',1.37,'/media/test_video/lc_yl.mp4'),(33,'1','3','37','1199','132','155','141','10.2.151.139','men','18','0.546998','/res_img/lc_yl.mp4/frame_37_0.jpg',1.49,'/media/test_video/lc_yl.mp4'),(34,'1','3','40','1198','127','153','138','10.2.151.139','men','18','0.570869','/res_img/lc_yl.mp4/frame_40_0.jpg',1.61,'/media/test_video/lc_yl.mp4'),(35,'1','3','43','1210','127','152','135','10.2.151.139','men','18','0.580474','/res_img/lc_yl.mp4/frame_43_0.jpg',1.73,'/media/test_video/lc_yl.mp4'),(36,'1','3','46','1212','117','166','143','10.2.151.139','men','18','0.626892','/res_img/lc_yl.mp4/frame_46_0.jpg',1.85,'/media/test_video/lc_yl.mp4'),(37,'1','3','49','1230','117','162','137','10.2.151.139','men','18','0.622150','/res_img/lc_yl.mp4/frame_49_0.jpg',1.97,'/media/test_video/lc_yl.mp4'),(38,'1','4','1','615','393','317','258','10.2.151.139','men','18','0.667122','/res_img/lichao.mp4/frame_1_0.jpg',0.04,'/media/test_video/lichao.mp4'),(39,'1','4','4','613','394','317','260','10.2.151.139','men','18','0.669869','/res_img/lichao.mp4/frame_4_0.jpg',0.16,'/media/test_video/lichao.mp4'),(40,'1','4','7','629','406','310','251','10.2.151.139','men','18','0.671815','/res_img/lichao.mp4/frame_7_0.jpg',0.28,'/media/test_video/lichao.mp4'),(41,'1','4','10','621','405','296','247','10.2.151.139','men','18','0.706730','/res_img/lichao.mp4/frame_10_0.jpg',0.40,'/media/test_video/lichao.mp4'),(42,'1','4','13','609','391','333','269','10.2.151.139','men','18','0.733878','/res_img/lichao.mp4/frame_13_0.jpg',0.52,'/media/test_video/lichao.mp4'),(43,'1','4','16','604','400','321','260','10.2.151.139','men','18','0.770172','/res_img/lichao.mp4/frame_16_0.jpg',0.64,'/media/test_video/lichao.mp4'),(44,'1','4','19','603','408','303','247','10.2.151.139','men','18','0.785269','/res_img/lichao.mp4/frame_19_0.jpg',0.76,'/media/test_video/lichao.mp4'),(45,'1','4','22','616','425','281','222','10.2.151.139','men','18','0.858113','/res_img/lichao.mp4/frame_22_0.jpg',0.88,'/media/test_video/lichao.mp4'),(46,'1','4','25','595','422','291','247','10.2.151.139','men','18','0.891328','/res_img/lichao.mp4/frame_25_0.jpg',1.00,'/media/test_video/lichao.mp4'),(47,'1','4','28','600','418','310','241','10.2.151.139','men','18','0.897184','/res_img/lichao.mp4/frame_28_0.jpg',1.12,'/media/test_video/lichao.mp4'),(48,'1','4','31','626','431','284','224','10.2.151.139','men','18','0.822420','/res_img/lichao.mp4/frame_31_0.jpg',1.24,'/media/test_video/lichao.mp4'),(49,'1','4','34','603','423','290','232','10.2.151.139','men','18','0.872761','/res_img/lichao.mp4/frame_34_0.jpg',1.37,'/media/test_video/lichao.mp4'),(50,'1','4','37','595','424','304','235','10.2.151.139','men','18','0.866479','/res_img/lichao.mp4/frame_37_0.jpg',1.49,'/media/test_video/lichao.mp4'),(51,'1','4','40','587','413','315','253','10.2.151.139','men','18','0.816509','/res_img/lichao.mp4/frame_40_0.jpg',1.61,'/media/test_video/lichao.mp4'),(52,'1','4','46','602','430','301','250','10.2.151.139','men','18','0.914061','/res_img/lichao.mp4/frame_46_0.jpg',1.85,'/media/test_video/lichao.mp4'),(53,'1','4','49','607','415','311','238','10.2.151.139','men','18','0.879873','/res_img/lichao.mp4/frame_49_0.jpg',1.97,'/media/test_video/lichao.mp4'),(54,'2','8','1','911','337','160','138','10.2.151.139','men','18','0.832120','/res_img/yl_lc.mp4/frame_1_0.jpg',0.04,'/media/test_video/yl_lc.mp4'),(55,'1','8','1','1266','189','204','168','10.2.151.139','men','18','0.584036','/res_img/yl_lc.mp4/frame_1_1.jpg',0.04,'/media/test_video/yl_lc.mp4'),(56,'2','8','4','906','336','166','147','10.2.151.139','men','18','0.834965','/res_img/yl_lc.mp4/frame_4_0.jpg',0.16,'/media/test_video/yl_lc.mp4'),(57,'1','8','4','1271','195','210','177','10.2.151.139','men','18','0.558069','/res_img/yl_lc.mp4/frame_4_1.jpg',0.16,'/media/test_video/yl_lc.mp4'),(58,'2','8','7','903','330','179','150','10.2.151.139','men','18','0.773159','/res_img/yl_lc.mp4/frame_7_0.jpg',0.28,'/media/test_video/yl_lc.mp4'),(59,'1','8','7','1268','198','175','153','10.2.151.139','men','18','0.554497','/res_img/yl_lc.mp4/frame_7_1.jpg',0.28,'/media/test_video/yl_lc.mp4'),(60,'2','8','10','912','338','162','141','10.2.151.139','men','18','0.835425','/res_img/yl_lc.mp4/frame_10_0.jpg',0.40,'/media/test_video/yl_lc.mp4'),(61,'1','8','10','1267','195','196','169','10.2.151.139','men','18','0.568306','/res_img/yl_lc.mp4/frame_10_1.jpg',0.40,'/media/test_video/yl_lc.mp4'),(62,'2','8','13','905','326','180','153','10.2.151.139','men','18','0.765831','/res_img/yl_lc.mp4/frame_13_0.jpg',0.52,'/media/test_video/yl_lc.mp4'),(63,'1','8','13','1281','193','195','155','10.2.151.139','men','18','0.537782','/res_img/yl_lc.mp4/frame_13_1.jpg',0.52,'/media/test_video/yl_lc.mp4'),(64,'2','8','16','910','334','167','145','10.2.151.139','men','18','0.813006','/res_img/yl_lc.mp4/frame_16_0.jpg',0.64,'/media/test_video/yl_lc.mp4'),(65,'1','8','16','1262','197','192','171','10.2.151.139','men','18','0.563224','/res_img/yl_lc.mp4/frame_16_1.jpg',0.64,'/media/test_video/yl_lc.mp4'),(66,'2','8','19','912','337','162','141','10.2.151.139','men','18','0.824097','/res_img/yl_lc.mp4/frame_19_0.jpg',0.76,'/media/test_video/yl_lc.mp4'),(67,'1','8','19','1273','193','192','160','10.2.151.139','men','18','0.512867','/res_img/yl_lc.mp4/frame_19_1.jpg',0.76,'/media/test_video/yl_lc.mp4'),(68,'2','8','22','913','337','163','140','10.2.151.139','men','18','0.828949','/res_img/yl_lc.mp4/frame_22_0.jpg',0.88,'/media/test_video/yl_lc.mp4'),(69,'1','8','22','1267','187','184','162','10.2.151.139','men','18','0.488657','/res_img/yl_lc.mp4/frame_22_1.jpg',0.88,'/media/test_video/yl_lc.mp4'),(70,'2','8','25','905','336','164','142','10.2.151.139','men','18','0.804608','/res_img/yl_lc.mp4/frame_25_0.jpg',1.00,'/media/test_video/yl_lc.mp4'),(71,'2','8','28','899','335','166','147','10.2.151.139','men','18','0.823555','/res_img/yl_lc.mp4/frame_28_0.jpg',1.12,'/media/test_video/yl_lc.mp4'),(72,'1','8','28','1289','179','200','168','10.2.151.139','men','18','0.538764','/res_img/yl_lc.mp4/frame_28_1.jpg',1.12,'/media/test_video/yl_lc.mp4'),(73,'2','8','31','892','332','169','147','10.2.151.139','men','18','0.795023','/res_img/yl_lc.mp4/frame_31_0.jpg',1.24,'/media/test_video/yl_lc.mp4'),(74,'1','8','31','1303','195','184','154','10.2.151.139','men','18','0.555274','/res_img/yl_lc.mp4/frame_31_1.jpg',1.24,'/media/test_video/yl_lc.mp4'),(75,'2','8','34','886','328','178','150','10.2.151.139','men','18','0.803166','/res_img/yl_lc.mp4/frame_34_0.jpg',1.37,'/media/test_video/yl_lc.mp4'),(76,'1','8','34','1304','194','191','163','10.2.151.139','men','18','0.556402','/res_img/yl_lc.mp4/frame_34_1.jpg',1.37,'/media/test_video/yl_lc.mp4'),(77,'2','8','37','885','332','178','153','10.2.151.139','men','18','0.794906','/res_img/yl_lc.mp4/frame_37_0.jpg',1.49,'/media/test_video/yl_lc.mp4'),(78,'1','8','37','1303','193','191','168','10.2.151.139','men','18','0.570473','/res_img/yl_lc.mp4/frame_37_1.jpg',1.49,'/media/test_video/yl_lc.mp4'),(79,'2','8','40','886','337','168','147','10.2.151.139','men','18','0.817285','/res_img/yl_lc.mp4/frame_40_0.jpg',1.61,'/media/test_video/yl_lc.mp4'),(80,'1','8','40','1323','203','201','164','10.2.151.139','men','18','0.479629','/res_img/yl_lc.mp4/frame_40_1.jpg',1.61,'/media/test_video/yl_lc.mp4'),(81,'2','8','43','886','337','169','147','10.2.151.139','men','18','0.801866','/res_img/yl_lc.mp4/frame_43_0.jpg',1.73,'/media/test_video/yl_lc.mp4'),(82,'1','8','43','1320','182','193','162','10.2.151.139','men','18','0.550809','/res_img/yl_lc.mp4/frame_43_1.jpg',1.73,'/media/test_video/yl_lc.mp4'),(83,'7','15','37','1514','608','75','67','10.2.151.139','men','18','0.545591','/res_img/liupengbo_tangli.mp4/frame_37_0.jpg',1.49,'/media/test_video/liupengbo_tangli.mp4'),(84,'2','8','46','889','334','174','150','10.2.151.139','men','18','0.832513','/res_img/yl_lc.mp4/frame_46_0.jpg',1.85,'/media/test_video/yl_lc.mp4'),(85,'1','8','46','1320','170','202','173','10.2.151.139','men','18','0.584483','/res_img/yl_lc.mp4/frame_46_1.jpg',1.85,'/media/test_video/yl_lc.mp4'),(86,'7','15','40','1517','612','77','68','10.2.151.139','men','18','0.503371','/res_img/liupengbo_tangli.mp4/frame_40_0.jpg',1.61,'/media/test_video/liupengbo_tangli.mp4'),(87,'2','8','49','890','332','171','151','10.2.151.139','men','18','0.787696','/res_img/yl_lc.mp4/frame_49_0.jpg',1.97,'/media/test_video/yl_lc.mp4'),(88,'1','8','49','1327','173','185','159','10.2.151.139','men','18','0.565535','/res_img/yl_lc.mp4/frame_49_1.jpg',1.97,'/media/test_video/yl_lc.mp4'),(89,'7','15','43','1517','613','75','66','10.2.151.139','men','18','0.473241','/res_img/liupengbo_tangli.mp4/frame_43_0.jpg',1.73,'/media/test_video/liupengbo_tangli.mp4'),(90,'7','15','46','1519','612','77','66','10.2.151.139','men','18','0.540547','/res_img/liupengbo_tangli.mp4/frame_46_0.jpg',1.85,'/media/test_video/liupengbo_tangli.mp4'),(91,'7','15','49','1519','612','81','69','10.2.151.139','men','18','0.537895','/res_img/liupengbo_tangli.mp4/frame_49_0.jpg',1.97,'/media/test_video/liupengbo_tangli.mp4'),(92,'1','3','52','1231','119','158','132','10.2.151.139','men','18','0.577964','/res_img/lc_yl.mp4/frame_52_0.jpg',2.09,'/media/test_video/lc_yl.mp4'),(93,'7','13','100','1526','599','71','61','10.2.151.139','men','18','0.657104','/res_img/tl.mp4/frame_100_0.jpg',4.02,'/media/test_video/tl.mp4'),(94,'1','3','55','1201','133','165','145','10.2.151.139','men','18','0.477597','/res_img/lc_yl.mp4/frame_55_0.jpg',2.21,'/media/test_video/lc_yl.mp4'),(95,'7','13','103','1526','597','72','62','10.2.151.139','men','18','0.604844','/res_img/tl.mp4/frame_103_0.jpg',4.14,'/media/test_video/tl.mp4'),(96,'7','13','106','1527','596','73','64','10.2.151.139','men','18','0.633154','/res_img/tl.mp4/frame_106_0.jpg',4.26,'/media/test_video/tl.mp4'),(97,'7','13','109','1527','595','75','65','10.2.151.139','men','18','0.633433','/res_img/tl.mp4/frame_109_0.jpg',4.38,'/media/test_video/tl.mp4'),(98,'1','3','64','1148','247','174','157','10.2.151.139','men','18','0.551646','/res_img/lc_yl.mp4/frame_64_0.jpg',2.57,'/media/test_video/lc_yl.mp4'),(99,'7','13','112','1527','598','74','65','10.2.151.139','men','18','0.655722','/res_img/tl.mp4/frame_112_0.jpg',4.50,'/media/test_video/tl.mp4'),(100,'7','13','115','1527','601','73','63','10.2.151.139','men','18','0.654696','/res_img/tl.mp4/frame_115_0.jpg',4.62,'/media/test_video/tl.mp4'),(101,'1','3','67','1134','266','179','162','10.2.151.139','men','18','0.572133','/res_img/lc_yl.mp4/frame_67_0.jpg',2.69,'/media/test_video/lc_yl.mp4'),(102,'7','13','118','1527','604','73','64','10.2.151.139','men','18','0.634556','/res_img/tl.mp4/frame_118_0.jpg',4.74,'/media/test_video/tl.mp4'),(103,'1','3','70','1109','272','187','165','10.2.151.139','men','18','0.635264','/res_img/lc_yl.mp4/frame_70_0.jpg',2.81,'/media/test_video/lc_yl.mp4'),(104,'7','13','121','1527','605','77','67','10.2.151.139','men','18','0.557518','/res_img/tl.mp4/frame_121_0.jpg',4.86,'/media/test_video/tl.mp4'),(105,'7','13','124','1529','608','75','67','10.2.151.139','men','18','0.523027','/res_img/tl.mp4/frame_124_0.jpg',4.98,'/media/test_video/tl.mp4'),(106,'1','3','73','1105','276','174','155','10.2.151.139','men','18','0.580248','/res_img/lc_yl.mp4/frame_73_0.jpg',2.93,'/media/test_video/lc_yl.mp4'),(107,'7','13','127','1532','609','77','67','10.2.151.139','men','18','0.459254','/res_img/tl.mp4/frame_127_0.jpg',5.10,'/media/test_video/tl.mp4'),(108,'1','3','76','1075','277','174','158','10.2.151.139','men','18','0.595297','/res_img/lc_yl.mp4/frame_76_0.jpg',3.05,'/media/test_video/lc_yl.mp4'),(109,'7','13','130','1533','609','78','68','10.2.151.139','men','18','0.472198','/res_img/tl.mp4/frame_130_0.jpg',5.22,'/media/test_video/tl.mp4'),(110,'1','3','79','1085','298','155','134','10.2.151.139','men','18','0.525367','/res_img/lc_yl.mp4/frame_79_0.jpg',3.17,'/media/test_video/lc_yl.mp4'),(111,'7','13','133','1536','609','78','69','10.2.151.139','men','18','0.518848','/res_img/tl.mp4/frame_133_0.jpg',5.34,'/media/test_video/tl.mp4'),(112,'7','13','136','1538','611','75','67','10.2.151.139','men','18','0.504458','/res_img/tl.mp4/frame_136_0.jpg',5.46,'/media/test_video/tl.mp4'),(113,'7','13','139','1540','612','72','65','10.2.151.139','men','18','0.494307','/res_img/tl.mp4/frame_139_0.jpg',5.58,'/media/test_video/tl.mp4'),(114,'7','13','145','1539','616','71','66','10.2.151.139','men','18','0.495534','/res_img/tl.mp4/frame_145_0.jpg',5.82,'/media/test_video/tl.mp4'),(115,'1','3','97','1074','187','153','129','10.2.151.139','men','18','0.478091','/res_img/lc_yl.mp4/frame_97_0.jpg',3.90,'/media/test_video/lc_yl.mp4'),(116,'7','16','103','1399','508','75','66','10.2.151.139','men','18','0.465481','/res_img/tangli.mp4/frame_103_0.jpg',4.14,'/media/test_video/tangli.mp4'),(117,'7','16','106','1406','509','69','61','10.2.151.139','men','18','0.554260','/res_img/tangli.mp4/frame_106_0.jpg',4.26,'/media/test_video/tangli.mp4'),(118,'7','16','109','1402','506','74','64','10.2.151.139','men','18','0.593317','/res_img/tangli.mp4/frame_109_0.jpg',4.38,'/media/test_video/tangli.mp4'),(119,'7','16','112','1400','505','68','56','10.2.151.139','men','18','0.656797','/res_img/tangli.mp4/frame_112_0.jpg',4.50,'/media/test_video/tangli.mp4'),(120,'7','16','115','1397','501','70','61','10.2.151.139','men','18','0.673837','/res_img/tangli.mp4/frame_115_0.jpg',4.62,'/media/test_video/tangli.mp4'),(121,'7','16','118','1397','505','67','55','10.2.151.139','men','18','0.691395','/res_img/tangli.mp4/frame_118_0.jpg',4.74,'/media/test_video/tangli.mp4'),(122,'7','16','121','1392','506','68','59','10.2.151.139','men','18','0.671703','/res_img/tangli.mp4/frame_121_0.jpg',4.86,'/media/test_video/tangli.mp4'),(123,'7','16','124','1393','506','67','58','10.2.151.139','men','18','0.679853','/res_img/tangli.mp4/frame_124_0.jpg',4.98,'/media/test_video/tangli.mp4'),(124,'7','16','127','1394','506','67','58','10.2.151.139','men','18','0.696737','/res_img/tangli.mp4/frame_127_0.jpg',5.10,'/media/test_video/tangli.mp4'),(125,'7','16','130','1399','504','67','58','10.2.151.139','men','18','0.621853','/res_img/tangli.mp4/frame_130_0.jpg',5.22,'/media/test_video/tangli.mp4'),(126,'7','16','133','1408','504','67','58','10.2.151.139','men','18','0.464134','/res_img/tangli.mp4/frame_133_0.jpg',5.34,'/media/test_video/tangli.mp4'),(127,'7','15','52','1519','612','81','68','10.2.151.139','men','18','0.516247','/res_img/liupengbo_tangli.mp4/frame_52_04',2.09,'/media/test_video/liupengbo_tangli.mp4'),(128,'7','15','55','1517','614','79','68','10.2.151.139','men','18','0.526679','/res_img/liupengbo_tangli.mp4/frame_55_07',2.21,'/media/test_video/liupengbo_tangli.mp4'),(129,'7','15','58','1519','613','76','65','10.2.151.139','men','18','0.495704','/res_img/liupengbo_tangli.mp4/frame_58_0:',2.33,'/media/test_video/liupengbo_tangli.mp4'),(130,'7','15','61','1518','614','79','69','10.2.151.139','men','18','0.502692','/res_img/liupengbo_tangli.mp4/frame_61_0=',2.45,'/media/test_video/liupengbo_tangli.mp4'),(131,'7','15','64','1519','616','77','66','10.2.151.139','men','18','0.514961','/res_img/liupengbo_tangli.mp4/frame_64_0@',2.57,'/media/test_video/liupengbo_tangli.mp4'),(132,'7','15','67','1518','617','78','67','10.2.151.139','men','18','0.527830','/res_img/liupengbo_tangli.mp4/frame_67_0C',2.69,'/media/test_video/liupengbo_tangli.mp4'),(133,'7','15','76','1519','614','77','68','10.2.151.139','men','18','0.467038','/res_img/liupengbo_tangli.mp4/frame_76_0L',3.05,'/media/test_video/liupengbo_tangli.mp4'),(134,'7','15','82','1519','616','75','65','10.2.151.139','men','18','0.479510','/res_img/liupengbo_tangli.mp4/frame_82_0R',3.29,'/media/test_video/liupengbo_tangli.mp4'),(135,'7','15','85','1518','615','79','71','10.2.151.139','men','18','0.468888','/res_img/liupengbo_tangli.mp4/frame_85_0U',3.41,'/media/test_video/liupengbo_tangli.mp4'),(136,'7','15','88','1520','615','76','68','10.2.151.139','men','18','0.543537','/res_img/liupengbo_tangli.mp4/frame_88_0X',3.53,'/media/test_video/liupengbo_tangli.mp4'),(137,'7','15','97','1518','615','78','69','10.2.151.139','men','18','0.475161','/res_img/liupengbo_tangli.mp4/frame_97_0a',3.90,'/media/test_video/liupengbo_tangli.mp4'),(138,'4','1','199','1276','385','80','72','10.2.151.139','men','18','0.512405','/res_img/jwc.mp4/frame_199_0.jpg',7.99,'/media/test_video/jwc.mp4'),(139,'7','15','100','1519','618','79','69','10.2.151.139','men','18','0.463319','/res_img/liupengbo_tangli.mp4/frame_100_d',4.02,'/media/test_video/liupengbo_tangli.mp4'),(140,'7','16','151','1570','522','80','72','10.2.151.139','men','18','0.515287','/res_img/tangli.mp4/frame_151_0.jpg',6.06,'/media/test_video/tangli.mp4'),(141,'7','15','103','1518','617','80','70','10.2.151.139','men','18','0.465885','/res_img/liupengbo_tangli.mp4/frame_103_g',4.14,'/media/test_video/liupengbo_tangli.mp4'),(142,'4','1','205','1267','353','87','75','10.2.151.139','men','18','0.479824','/res_img/jwc.mp4/frame_205_0.jpg',8.23,'/media/test_video/jwc.mp4'),(143,'7','16','154','1574','530','74','66','10.2.151.139','men','18','0.590695','/res_img/tangli.mp4/frame_154_0.jpg',6.18,'/media/test_video/tangli.mp4'),(144,'7','15','106','1517','615','83','73','10.2.151.139','men','18','0.460959','/res_img/liupengbo_tangli.mp4/frame_106_j',4.26,'/media/test_video/liupengbo_tangli.mp4'),(145,'4','1','208','1246','343','93','86','10.2.151.139','men','18','0.508551','/res_img/jwc.mp4/frame_208_0.jpg',8.35,'/media/test_video/jwc.mp4'),(146,'7','16','157','1564','521','84','74','10.2.151.139','men','18','0.571787','/res_img/tangli.mp4/frame_157_0.jpg',6.31,'/media/test_video/tangli.mp4'),(147,'7','15','109','1518','615','78','67','10.2.151.139','men','18','0.534721','/res_img/liupengbo_tangli.mp4/frame_109_m',4.38,'/media/test_video/liupengbo_tangli.mp4'),(148,'4','1','214','1201','330','97','83','10.2.151.139','men','18','0.510832','/res_img/jwc.mp4/frame_214_0.jpg',8.59,'/media/test_video/jwc.mp4'),(149,'7','16','160','1563','533','72','65','10.2.151.139','men','18','0.565908','/res_img/tangli.mp4/frame_160_0.jpg',6.43,'/media/test_video/tangli.mp4'),(150,'7','15','112','1516','609','73','63','10.2.151.139','men','18','0.630602','/res_img/liupengbo_tangli.mp4/frame_112_p',4.50,'/media/test_video/liupengbo_tangli.mp4'),(151,'2','7','172','1478','409','52','45','10.2.151.139','men','18','0.494228','/res_img/yl.mp4/frame_172_0.jpg',6.91,'/media/test_video/yl.mp4'),(152,'4','1','217','1183','302','106','90','10.2.151.139','men','18','0.471471','/res_img/jwc.mp4/frame_217_0.jpg',8.71,'/media/test_video/jwc.mp4'),(153,'7','16','163','1552','530','79','69','10.2.151.139','men','18','0.504347','/res_img/tangli.mp4/frame_163_0.jpg',6.55,'/media/test_video/tangli.mp4'),(154,'7','15','115','1514','605','73','64','10.2.151.139','men','18','0.682208','/res_img/liupengbo_tangli.mp4/frame_115_s',4.62,'/media/test_video/liupengbo_tangli.mp4'),(155,'2','7','175','1479','407','54','49','10.2.151.139','men','18','0.512422','/res_img/yl.mp4/frame_175_0.jpg',7.03,'/media/test_video/yl.mp4'),(156,'4','1','220','1195','283','111','94','10.2.151.139','men','18','0.452107','/res_img/jwc.mp4/frame_220_0.jpg',8.84,'/media/test_video/jwc.mp4'),(157,'7','16','166','1545','543','75','68','10.2.151.139','men','18','0.663343','/res_img/tangli.mp4/frame_166_0.jpg',6.67,'/media/test_video/tangli.mp4'),(158,'7','15','118','1507','600','76','66','10.2.151.139','men','18','0.755160','/res_img/liupengbo_tangli.mp4/frame_118_v',4.74,'/media/test_video/liupengbo_tangli.mp4'),(159,'7','16','169','1538','555','75','67','10.2.151.139','men','18','0.648293','/res_img/tangli.mp4/frame_169_0.jpg',6.79,'/media/test_video/tangli.mp4'),(160,'2','7','181','1500','397','54','45','10.2.151.139','men','18','0.457731','/res_img/yl.mp4/frame_181_0.jpg',7.27,'/media/test_video/yl.mp4'),(161,'7','15','121','1508','600','71','64','10.2.151.139','men','18','0.723254','/res_img/liupengbo_tangli.mp4/frame_121_y',4.86,'/media/test_video/liupengbo_tangli.mp4'),(162,'7','16','172','1534','569','79','64','10.2.151.139','men','18','0.550372','/res_img/tangli.mp4/frame_172_0.jpg',6.91,'/media/test_video/tangli.mp4'),(163,'7','15','124','1507','599','72','66','10.2.151.139','men','18','0.758767','/res_img/liupengbo_tangli.mp4/frame_124_|',4.98,'/media/test_video/liupengbo_tangli.mp4'),(164,'2','7','187','1497','385','61','52','10.2.151.139','men','18','0.502258','/res_img/yl.mp4/frame_187_0.jpg',7.51,'/media/test_video/yl.mp4'),(165,'2','7','190','1486','386','63','54','10.2.151.139','men','18','0.510046','/res_img/yl.mp4/frame_190_0.jpg',7.63,'/media/test_video/yl.mp4'),(166,'7','15','127','1509','597','72','64','10.2.151.139','men','18','0.653070','/res_img/liupengbo_tangli.mp4/frame_127_',5.10,'/media/test_video/liupengbo_tangli.mp4'),(167,'2','7','196','1445','375','62','55','10.2.151.139','men','18','0.450124','/res_img/yl.mp4/frame_196_0.jpg',7.87,'/media/test_video/yl.mp4'),(168,'7','16','181','1540','617','70','63','10.2.151.139','men','18','0.549906','/res_img/tangli.mp4/frame_181_0.jpg',7.27,'/media/test_video/tangli.mp4'),(169,'7','16','184','1538','610','72','62','10.2.151.139','men','18','0.552425','/res_img/tangli.mp4/frame_184_0.jpg',7.39,'/media/test_video/tangli.mp4'),(170,'7','16','187','1532','607','70','60','10.2.151.139','men','18','0.638359','/res_img/tangli.mp4/frame_187_0.jpg',7.51,'/media/test_video/tangli.mp4'),(171,'7','16','190','1526','603','72','62','10.2.151.139','men','18','0.572266','/res_img/tangli.mp4/frame_190_0.jpg',7.63,'/media/test_video/tangli.mp4'),(172,'7','16','193','1520','608','66','59','10.2.151.139','men','18','0.559630','/res_img/tangli.mp4/frame_193_0.jpg',7.75,'/media/test_video/tangli.mp4'),(173,'7','16','196','1513','607','66','56','10.2.151.139','men','18','0.542059','/res_img/tangli.mp4/frame_196_0.jpg',7.87,'/media/test_video/tangli.mp4'),(174,'7','13','202','1542','615','75','62','10.2.151.139','men','18','0.486206','/res_img/tl.mp4/frame_202_0.jpg',8.11,'/media/test_video/tl.mp4'),(175,'7','13','205','1540','616','71','63','10.2.151.139','men','18','0.485410','/res_img/tl.mp4/frame_205_0.jpg',8.23,'/media/test_video/tl.mp4'),(176,'2','7','199','1423','362','67','56','10.2.151.139','men','18','0.456084','/res_img/yl.mp4/frame_199_0.jpg',7.99,'/media/test_video/yl.mp4'),(177,'2','7','202','1416','358','65','57','10.2.151.139','men','18','0.646150','/res_img/yl.mp4/frame_202_0.jpg',8.11,'/media/test_video/yl.mp4'),(178,'2','7','205','1415','354','68','58','10.2.151.139','men','18','0.608187','/res_img/yl.mp4/frame_205_0.jpg',8.23,'/media/test_video/yl.mp4'),(179,'2','7','208','1420','353','69','59','10.2.151.139','men','18','0.604502','/res_img/yl.mp4/frame_208_0.jpg',8.35,'/media/test_video/yl.mp4'),(180,'2','7','211','1431','344','68','58','10.2.151.139','men','18','0.505943','/res_img/yl.mp4/frame_211_0.jpg',8.47,'/media/test_video/yl.mp4'),(181,'2','7','214','1435','333','69','60','10.2.151.139','men','18','0.465183','/res_img/yl.mp4/frame_214_0.jpg',8.59,'/media/test_video/yl.mp4'),(182,'2','7','217','1424','321','73','67','10.2.151.139','men','18','0.599985','/res_img/yl.mp4/frame_217_0.jpg',8.71,'/media/test_video/yl.mp4'),(183,'2','7','220','1413','317','76','69','10.2.151.139','men','18','0.501757','/res_img/yl.mp4/frame_220_0.jpg',8.84,'/media/test_video/yl.mp4'),(184,'2','7','232','1282','285','83','84','10.2.151.139','men','18','0.466203','/res_img/yl.mp4/frame_232_0.jpg',9.32,'/media/test_video/yl.mp4'),(185,'7','13','247','1519','618','71','64','10.2.151.139','men','18','0.470799','/res_img/tl.mp4/frame_247_0.jpg',9.92,'/media/test_video/tl.mp4'),(186,'7','13','250','1517','616','70','65','10.2.151.139','men','18','0.514555','/res_img/tl.mp4/frame_250_0.jpg',10.04,'/media/test_video/tl.mp4'),(187,'7','15','256','1517','594','82','68','10.2.151.139','men','18','0.503702','/res_img/liupengbo_tangli.mp4/frame_256_',10.28,'/media/test_video/liupengbo_tangli.mp4'),(188,'7','13','307','1588','613','70','61','10.2.151.139','men','18','0.511251','/res_img/tl.mp4/frame_307_0.jpg',12.33,'/media/test_video/tl.mp4'),(189,'7','13','310','1587','613','71','62','10.2.151.139','men','18','0.578750','/res_img/tl.mp4/frame_310_0.jpg',12.45,'/media/test_video/tl.mp4'),(190,'7','13','313','1587','613','72','61','10.2.151.139','men','18','0.621580','/res_img/tl.mp4/frame_313_0.jpg',12.57,'/media/test_video/tl.mp4'),(191,'7','13','316','1587','617','73','62','10.2.151.139','men','18','0.549130','/res_img/tl.mp4/frame_316_0.jpg',12.69,'/media/test_video/tl.mp4'),(192,'7','13','319','1586','613','75','63','10.2.151.139','men','18','0.595426','/res_img/tl.mp4/frame_319_0.jpg',12.81,'/media/test_video/tl.mp4'),(193,'7','13','322','1588','616','70','61','10.2.151.139','men','18','0.591627','/res_img/tl.mp4/frame_322_0.jpg',12.93,'/media/test_video/tl.mp4'),(194,'7','13','325','1587','615','74','63','10.2.151.139','men','18','0.530246','/res_img/tl.mp4/frame_325_0.jpg',13.05,'/media/test_video/tl.mp4'),(195,'7','13','328','1584','612','78','65','10.2.151.139','men','18','0.511036','/res_img/tl.mp4/frame_328_0.jpg',13.17,'/media/test_video/tl.mp4'),(196,'7','13','331','1582','612','80','68','10.2.151.139','men','18','0.541102','/res_img/tl.mp4/frame_331_0.jpg',13.29,'/media/test_video/tl.mp4'),(197,'7','13','334','1586','617','74','67','10.2.151.139','men','18','0.539933','/res_img/tl.mp4/frame_334_0.jpg',13.41,'/media/test_video/tl.mp4'),(198,'7','13','337','1589','620','71','62','10.2.151.139','men','18','0.548453','/res_img/tl.mp4/frame_337_0.jpg',13.53,'/media/test_video/tl.mp4'),(199,'7','13','340','1591','620','74','62','10.2.151.139','men','18','0.548574','/res_img/tl.mp4/frame_340_0.jpg',13.65,'/media/test_video/tl.mp4'),(200,'7','13','343','1591','622','77','66','10.2.151.139','men','18','0.459276','/res_img/tl.mp4/frame_343_0.jpg',13.78,'/media/test_video/tl.mp4'),(201,'7','13','349','1595','626','70','62','10.2.151.139','men','18','0.495188','/res_img/tl.mp4/frame_349_0.jpg',14.02,'/media/test_video/tl.mp4'),(202,'7','13','352','1590','618','75','66','10.2.151.139','men','18','0.510395','/res_img/tl.mp4/frame_352_0.jpg',14.14,'/media/test_video/tl.mp4'),(203,'7','13','355','1589','614','75','61','10.2.151.139','men','18','0.557060','/res_img/tl.mp4/frame_355_0.jpg',14.26,'/media/test_video/tl.mp4'),(204,'1','2','319','1417','420','68','54','10.2.151.139','men','18','0.508996','/res_img/lc.mp4/frame_319_0.jpg',12.81,'/media/test_video/lc.mp4'),(205,'1','2','325','1393','417','73','57','10.2.151.139','men','18','0.469044','/res_img/lc.mp4/frame_325_0.jpg',13.05,'/media/test_video/lc.mp4'),(206,'7','13','379','1558','604','74','59','10.2.151.139','men','18','0.493968','/res_img/tl.mp4/frame_379_0.jpg',15.22,'/media/test_video/tl.mp4'),(207,'7','13','382','1558','605','72','56','10.2.151.139','men','18','0.512031','/res_img/tl.mp4/frame_382_0.jpg',15.34,'/media/test_video/tl.mp4'),(208,'7','13','391','1550','605','70','55','10.2.151.139','men','18','0.506375','/res_img/tl.mp4/frame_391_0.jpg',15.70,'/media/test_video/tl.mp4'),(209,'7','13','394','1550','606','70','55','10.2.151.139','men','18','0.510732','/res_img/tl.mp4/frame_394_0.jpg',15.82,'/media/test_video/tl.mp4'),(210,'7','13','397','1547','605','73','58','10.2.151.139','men','18','0.462397','/res_img/tl.mp4/frame_397_0.jpg',15.94,'/media/test_video/tl.mp4'),(211,'1','2','346','1180','354','100','87','10.2.151.139','men','18','0.466079','/res_img/lc.mp4/frame_346_0.jpg',13.90,'/media/test_video/lc.mp4'),(212,'1','2','349','1160','349','109','87','10.2.151.139','men','18','0.456393','/res_img/lc.mp4/frame_349_0.jpg',14.02,'/media/test_video/lc.mp4'),(213,'1','2','352','1125','331','109','92','10.2.151.139','men','18','0.490145','/res_img/lc.mp4/frame_352_0.jpg',14.14,'/media/test_video/lc.mp4'),(214,'2','6','1540','1482','426','49','44','10.2.151.139','men','18','0.462409','/res_img/lpb_yl.mp4/frame_1540_0.jpg',61.85,'/media/test_video/lpb_yl.mp4'),(215,'5','6','1549','1211','358','93','87','10.2.151.139','men','18','0.487008','/res_img/lpb_yl.mp4/frame_1549_0.jpg',62.21,'/media/test_video/lpb_yl.mp4'),(216,'5','6','1552','1211','355','93','86','10.2.151.139','men','18','0.616476','/res_img/lpb_yl.mp4/frame_1552_0.jpg',62.33,'/media/test_video/lpb_yl.mp4'),(217,'2','6','1552','1489','405','54','47','10.2.151.139','men','18','0.478434','/res_img/lpb_yl.mp4/frame_1552_1.jpg',62.33,'/media/test_video/lpb_yl.mp4'),(218,'5','6','1555','1209','334','111','93','10.2.151.139','men','18','0.497411','/res_img/lpb_yl.mp4/frame_1555_0.jpg',62.45,'/media/test_video/lpb_yl.mp4'),(219,'2','6','1555','1496','405','55','48','10.2.151.139','men','18','0.491370','/res_img/lpb_yl.mp4/frame_1555_1.jpg',62.45,'/media/test_video/lpb_yl.mp4'),(220,'5','6','1558','1198','316','98','93','10.2.151.139','men','18','0.524529','/res_img/lpb_yl.mp4/frame_1558_0.jpg',62.57,'/media/test_video/lpb_yl.mp4'),(221,'5','6','1561','1179','302','105','98','10.2.151.139','men','18','0.520483','/res_img/lpb_yl.mp4/frame_1561_0.jpg',62.69,'/media/test_video/lpb_yl.mp4'),(222,'2','6','1561','1512','392','59','50','10.2.151.139','men','18','0.493790','/res_img/lpb_yl.mp4/frame_1561_1.jpg',62.69,'/media/test_video/lpb_yl.mp4'),(223,'5','6','1567','1140','292','108','105','10.2.151.139','men','18','0.495005','/res_img/lpb_yl.mp4/frame_1567_0.jpg',62.93,'/media/test_video/lpb_yl.mp4'),(224,'5','6','1573','1143','232','129','130','10.2.151.139','men','18','0.541316','/res_img/lpb_yl.mp4/frame_1573_0.jpg',63.17,'/media/test_video/lpb_yl.mp4'),(225,'1','16','1','1218','669','331','235','10.2.151.139','men','18','0.472976','/res_img/tangli.mp4/frame_1_0.jpg',0.04,'/media/test_video/tangli.mp4'),(226,'7','16','16','317','520','53','48','10.2.151.139','men','18','0.462497','/res_img/tangli.mp4/frame_16_0.jpg',0.64,'/media/test_video/tangli.mp4'),(227,'7','13','34','1532','602','68','61','10.2.151.139','men','18','0.522990','/res_img/tl.mp4/frame_34_0.jpg',1.37,'/media/test_video/tl.mp4'),(228,'7','13','37','1532','604','66','63','10.2.151.139','men','18','0.593012','/res_img/tl.mp4/frame_37_0.jpg',1.49,'/media/test_video/tl.mp4'),(229,'7','13','40','1531','602','77','67','10.2.151.139','men','18','0.539990','/res_img/tl.mp4/frame_40_0.jpg',1.61,'/media/test_video/tl.mp4'),(230,'1','16','28','1194','665','346','250','10.2.151.139','men','18','0.471404','/res_img/tangli.mp4/frame_28_0.jpg',1.12,'/media/test_video/tangli.mp4'),(231,'7','13','43','1536','609','73','63','10.2.151.139','men','18','0.650889','/res_img/tl.mp4/frame_43_0.jpg',1.73,'/media/test_video/tl.mp4'),(232,'7','13','46','1537','611','78','65','10.2.151.139','men','18','0.567244','/res_img/tl.mp4/frame_46_0.jpg',1.85,'/media/test_video/tl.mp4'),(233,'7','13','49','1540','612','75','64','10.2.151.139','men','18','0.533021','/res_img/tl.mp4/frame_49_0.jpg',1.97,'/media/test_video/tl.mp4'),(234,'1','4','1','615','393','317','258','10.2.151.139','men','18','0.667123','/res_img/lichao.mp4/frame_1_0.jpg',0.04,'/media/test_video/lichao.mp4'),(235,'1','4','4','613','394','317','260','10.2.151.139','men','18','0.669869','/res_img/lichao.mp4/frame_4_0.jpg',0.16,'/media/test_video/lichao.mp4'),(236,'1','4','7','629','406','310','251','10.2.151.139','men','18','0.671815','/res_img/lichao.mp4/frame_7_0.jpg',0.28,'/media/test_video/lichao.mp4'),(237,'1','4','10','621','405','296','247','10.2.151.139','men','18','0.706730','/res_img/lichao.mp4/frame_10_0.jpg',0.40,'/media/test_video/lichao.mp4'),(238,'1','4','13','609','391','333','269','10.2.151.139','men','18','0.733879','/res_img/lichao.mp4/frame_13_0.jpg',0.52,'/media/test_video/lichao.mp4'),(239,'1','4','16','604','400','321','260','10.2.151.139','men','18','0.770172','/res_img/lichao.mp4/frame_16_0.jpg',0.64,'/media/test_video/lichao.mp4'),(240,'1','4','19','603','408','303','247','10.2.151.139','men','18','0.785269','/res_img/lichao.mp4/frame_19_0.jpg',0.76,'/media/test_video/lichao.mp4'),(241,'1','4','22','616','425','281','222','10.2.151.139','men','18','0.858113','/res_img/lichao.mp4/frame_22_0.jpg',0.88,'/media/test_video/lichao.mp4'),(242,'1','4','25','595','422','291','247','10.2.151.139','men','18','0.891328','/res_img/lichao.mp4/frame_25_0.jpg',1.00,'/media/test_video/lichao.mp4'),(243,'7','13','52','1538','605','73','62','10.2.151.139','men','18','0.706901','/res_img/tl.mp4/frame_52_0.jpg',2.09,'/media/test_video/tl.mp4'),(244,'1','4','28','600','418','310','241','10.2.151.139','men','18','0.897184','/res_img/lichao.mp4/frame_28_0.jpg',1.12,'/media/test_video/lichao.mp4'),(245,'7','13','55','1535','600','76','66','10.2.151.139','men','18','0.579494','/res_img/tl.mp4/frame_55_0.jpg',2.21,'/media/test_video/tl.mp4'),(246,'1','4','31','626','431','284','224','10.2.151.139','men','18','0.822420','/res_img/lichao.mp4/frame_31_0.jpg',1.24,'/media/test_video/lichao.mp4'),(247,'7','13','58','1535','599','74','64','10.2.151.139','men','18','0.598448','/res_img/tl.mp4/frame_58_0.jpg',2.33,'/media/test_video/tl.mp4'),(248,'1','4','34','603','423','290','232','10.2.151.139','men','18','0.872761','/res_img/lichao.mp4/frame_34_0.jpg',1.37,'/media/test_video/lichao.mp4'),(249,'7','13','61','1537','600','77','68','10.2.151.139','men','18','0.499067','/res_img/tl.mp4/frame_61_0.jpg',2.45,'/media/test_video/tl.mp4'),(250,'1','4','37','595','424','304','235','10.2.151.139','men','18','0.866480','/res_img/lichao.mp4/frame_37_0.jpg',1.49,'/media/test_video/lichao.mp4'),(251,'7','13','64','1545','602','75','68','10.2.151.139','men','18','0.503038','/res_img/tl.mp4/frame_64_0.jpg',2.57,'/media/test_video/tl.mp4'),(252,'1','4','40','587','413','315','253','10.2.151.139','men','18','0.816509','/res_img/lichao.mp4/frame_40_0.jpg',1.61,'/media/test_video/lichao.mp4'),(253,'1','4','46','602','430','301','250','10.2.151.139','men','18','0.914061','/res_img/lichao.mp4/frame_46_0.jpg',1.85,'/media/test_video/lichao.mp4'),(254,'7','13','79','1539','603','77','68','10.2.151.139','men','18','0.504266','/res_img/tl.mp4/frame_79_0.jpg',3.17,'/media/test_video/tl.mp4'),(255,'1','4','49','607','415','311','238','10.2.151.139','men','18','0.879873','/res_img/lichao.mp4/frame_49_0.jpg',1.97,'/media/test_video/lichao.mp4'),(256,'7','13','82','1534','600','79','69','10.2.151.139','men','18','0.488851','/res_img/tl.mp4/frame_82_0.jpg',3.29,'/media/test_video/tl.mp4'),(257,'7','13','85','1532','604','75','66','10.2.151.139','men','18','0.489606','/res_img/tl.mp4/frame_85_0.jpg',3.41,'/media/test_video/tl.mp4'),(258,'7','13','88','1529','603','71','64','10.2.151.139','men','18','0.637209','/res_img/tl.mp4/frame_88_0.jpg',3.53,'/media/test_video/tl.mp4'),(259,'7','13','91','1526','598','78','67','10.2.151.139','men','18','0.641857','/res_img/tl.mp4/frame_91_0.jpg',3.65,'/media/test_video/tl.mp4'),(260,'7','13','94','1526','599','72','62','10.2.151.139','men','18','0.659820','/res_img/tl.mp4/frame_94_0.jpg',3.78,'/media/test_video/tl.mp4'),(261,'7','13','97','1524','600','70','63','10.2.151.139','men','18','0.706644','/res_img/tl.mp4/frame_97_0.jpg',3.90,'/media/test_video/tl.mp4'),(262,'2','8','1','911','337','160','138','10.2.151.139','men','18','0.832120','/res_img/yl_lc.mp4/frame_1_0.jpg',0.04,'/media/test_video/yl_lc.mp4'),(263,'1','8','1','1266','189','204','168','10.2.151.139','men','18','0.584036','/res_img/yl_lc.mp4/frame_1_1.jpg',0.04,'/media/test_video/yl_lc.mp4'),(264,'2','8','4','906','336','166','147','10.2.151.139','men','18','0.834965','/res_img/yl_lc.mp4/frame_4_0.jpg',0.16,'/media/test_video/yl_lc.mp4'),(265,'1','8','4','1271','195','210','177','10.2.151.139','men','18','0.558069','/res_img/yl_lc.mp4/frame_4_1.jpg',0.16,'/media/test_video/yl_lc.mp4'),(266,'2','8','7','903','330','179','150','10.2.151.139','men','18','0.773159','/res_img/yl_lc.mp4/frame_7_0.jpg',0.28,'/media/test_video/yl_lc.mp4'),(267,'1','8','7','1268','198','175','153','10.2.151.139','men','18','0.554497','/res_img/yl_lc.mp4/frame_7_1.jpg',0.28,'/media/test_video/yl_lc.mp4'),(268,'2','8','10','912','338','162','141','10.2.151.139','men','18','0.835425','/res_img/yl_lc.mp4/frame_10_0.jpg',0.40,'/media/test_video/yl_lc.mp4'),(269,'1','8','10','1267','195','196','169','10.2.151.139','men','18','0.568306','/res_img/yl_lc.mp4/frame_10_1.jpg',0.40,'/media/test_video/yl_lc.mp4'),(270,'2','8','13','905','326','180','153','10.2.151.139','men','18','0.765831','/res_img/yl_lc.mp4/frame_13_0.jpg',0.52,'/media/test_video/yl_lc.mp4'),(271,'1','8','13','1281','193','195','155','10.2.151.139','men','18','0.537782','/res_img/yl_lc.mp4/frame_13_1.jpg',0.52,'/media/test_video/yl_lc.mp4'),(272,'2','8','16','910','334','167','145','10.2.151.139','men','18','0.813006','/res_img/yl_lc.mp4/frame_16_0.jpg',0.64,'/media/test_video/yl_lc.mp4'),(273,'1','8','16','1262','197','192','171','10.2.151.139','men','18','0.563224','/res_img/yl_lc.mp4/frame_16_1.jpg',0.64,'/media/test_video/yl_lc.mp4'),(274,'2','8','19','912','337','162','141','10.2.151.139','men','18','0.824097','/res_img/yl_lc.mp4/frame_19_0.jpg',0.76,'/media/test_video/yl_lc.mp4'),(275,'1','8','19','1273','193','192','160','10.2.151.139','men','18','0.512867','/res_img/yl_lc.mp4/frame_19_1.jpg',0.76,'/media/test_video/yl_lc.mp4');
/*!40000 ALTER TABLE `users_check` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_face`
--

DROP TABLE IF EXISTS `users_face`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_face` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `mobile` varchar(11) CHARACTER SET latin1 NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `email` varchar(254) NOT NULL,
  `flag` int(11) NOT NULL,
  `createDate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_face`
--

LOCK TABLES `users_face` WRITE;
/*!40000 ALTER TABLE `users_face` DISABLE KEYS */;
INSERT INTO `users_face` VALUES (1,'李超','18812341234',0,'lichao-ams@ict.ac.cn',1,'2019-06-27 16:19:26'),(2,'严龙','12345678911',0,'yanlong@test.com',1,'2019-06-27 16:36:58'),(3,'董睿','18812354879',0,'jiaweichuang@ict.ac.cn',1,'2019-06-27 16:44:45'),(4,'贾伟闯','18812354879',0,'jiaweichuang@ict.ac.cn',1,'2019-06-27 16:44:52'),(5,'刘鹏博','13678977897',0,'liupengbo@ict.ac.cn',1,'2019-06-27 16:45:18'),(6,'罗鑫','18845647897',0,'luoxin@ict.ac.cn',1,'2019-06-27 16:45:46'),(7,'唐立','15645644454',0,'tangli@ict.ac.cn',1,'2019-06-27 16:46:31'),(8,'陆倩雯','18896722430',1,'luqianwen@ict.ac.cn',1,'2019-06-28 15:29:33'),(9,'范晓琪','12346551111',0,'fanxiaoqi@sina.com',0,'2019-07-02 16:18:20'),(10,'张三','18812345647',0,'aaa@163.com',1,'2019-07-02 16:53:58'),(11,'李四','11111111111',0,'test@test.com',1,'2019-07-02 16:55:15'),(12,'王五','11111111111',0,'test1@test.com',1,'2019-07-02 17:01:40'),(13,'李大仁','11111111111',1,'test2@test.com',1,'2019-07-02 17:08:16'),(14,'李超','18812341254',0,'a@163.com',1,'2019-07-02 17:25:36'),(15,'周一山','18815647894',0,'fe@163.com',1,'2019-07-05 14:14:57'),(16,'周大福','18846877894',0,'fffe@163.com',1,'2019-07-05 14:15:55'),(17,'周生生','15644577897',0,'aaa@163.com',1,'2019-07-05 14:16:38');
/*!40000 ALTER TABLE `users_face` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_faceimg`
--

DROP TABLE IF EXISTS `users_faceimg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_faceimg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imgurl` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `userid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_faceimg_userid_id_53f4ee7b_fk_users_face_id` (`userid_id`),
  CONSTRAINT `users_faceimg_userid_id_53f4ee7b_fk_users_face_id` FOREIGN KEY (`userid_id`) REFERENCES `users_face` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_faceimg`
--

LOCK TABLES `users_faceimg` WRITE;
/*!40000 ALTER TABLE `users_faceimg` DISABLE KEYS */;
INSERT INTO `users_faceimg` VALUES (4,'http://10.2.151.139:8888/media/image/2/yl.jpg',2),(6,'http://10.2.151.139:8888/media/image/4/jwc.jpg',4),(7,'http://10.2.151.139:8888/media/image/5/lpb.jpg',5),(8,'http://10.2.151.139:8888/media/image/6/lx.jpg',6),(9,'http://10.2.151.139:8888/media/image/7/tl.jpg',7),(11,'http://10.2.151.139:8888/media/image/1/lic.jpg',1),(13,'http://10.2.151.139:8888/media/image/8/luqianwen.jpg',8),(14,'http://10.2.151.139:8888/media/image/1/li.jpg',1),(15,'http://10.2.151.139:8888/media/image/9/timg.jpg',9),(17,'http://10.2.151.139:8888/media/image/3/1.jpg',3),(32,'http://10.2.151.139:8888/media/image/11/7.jpg',11),(35,'http://10.2.151.139:8888/media/image/17/13.jpg',17),(36,'http://10.2.151.139:8888/media/image/12/5.jpg',12),(37,'http://10.2.151.139:8888/media/image/13/15.jpg',13),(38,'http://10.2.151.139:8888/media/image/14/3.jpg',14),(39,'http://10.2.151.139:8888/media/image/15/4.jpg',15),(40,'http://10.2.151.139:8888/media/image/16/20.jpg',16),(41,'http://10.2.151.139:8888/media/image/10/19.jpg',10);
/*!40000 ALTER TABLE `users_faceimg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_stream`
--

DROP TABLE IF EXISTS `users_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_stream` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `streamname` varchar(50) CHARACTER SET latin1 NOT NULL,
  `streamlocation` varchar(100) NOT NULL,
  `streamurl` varchar(100) CHARACTER SET latin1 NOT NULL,
  `streamlat` varchar(24) CHARACTER SET latin1 NOT NULL,
  `streamlon` varchar(24) CHARACTER SET latin1 NOT NULL,
  `flag` int(11) NOT NULL,
  `createDate` datetime NOT NULL,
  `streamtime` varchar(256) DEFAULT NULL,
  `streamfps` varchar(256) DEFAULT NULL,
  `streamstatus` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `streamname` (`streamname`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_stream`
--

LOCK TABLES `users_stream` WRITE;
/*!40000 ALTER TABLE `users_stream` DISABLE KEYS */;
INSERT INTO `users_stream` VALUES (1,'video_jwc','城市学院','http://10.2.151.139:8888/media/test_video/jwc.mp4','39.987299','116.34657',0,'2019-06-27 17:22:22','16.0','25.0','1'),(2,'video_lc','城市学院','http://10.2.151.139:8888/media/test_video/lc.mp4','39.987298','116.35657',0,'2019-06-27 17:23:26','24.0','25.0','1'),(3,'video_lc_yl','城市学院','http://10.2.151.139:8888/media/test_video/lc_yl.mp4','39.987297','116.37657',0,'2019-06-28 11:28:22','7.0','25.0','1'),(4,'video_lichao','城市学院','http://10.2.151.139:8888/media/test_video/lichao.mp4','39.987296','116.34657',0,'2019-06-28 11:32:24','5.0','25.0','1'),(6,'video_lpb_yl','城市学院','http://10.2.151.139:8888/media/test_video/lpb_yl.mp4','39.987295','116.34657',0,'2019-06-28 14:47:27','77.0','25.0','1'),(7,'video_yl','城市学院','http://10.2.151.139:8888/media/test_video/yl.mp4','39.987294','116.34657',0,'2019-06-28 14:47:27','20.0','25.0','1'),(8,'video_yl_lc','城市学院','http://10.2.151.139:8888/media/test_video/yl_lc.mp4','39.987293','116.44657',0,'2019-06-28 14:47:27','5.0','25.0','1'),(11,'video_08_02','环保园','asd','39.987292','116.34657',0,'2019-07-03 18:57:19','10.0','25.0','0'),(12,'video_07_02','城市学院','http://10.2.151.139:8888/media/test_video/video_07_02.mp4','39.787298','116.34657',0,'2019-07-05 11:41:01','27.0','25.0','1'),(13,'video_tl','城市学院','http://10.2.151.139:8888/media/test_video/tl.mp4','39.787288','116.34657',0,'2019-07-15 17:49:00','18.7','25.0','1'),(14,'video_lx','城市学院','http://10.2.151.139:8888/media/test_video/luoxin.mp4','39.787278','116.34668',0,'2019-07-15 17:49:40','8.9','25.0','1'),(15,'video_lpb_tl','城市学院','http://10.2.151.139:8888/media/test_video/liupengbo_tangli.mp4','39.787268','116.34658',0,'2019-07-15 17:50:22','19.8','25.0','1'),(16,'video_tl1','城市学院','http://10.2.151.139:8888/media/test_video/tangli.mp4','39.787258','116.34659',0,'2019-07-15 17:50:52','8.1','25.0','1'),(17,'video_new','北京理工大学','http://10.2.151.139:8888/media/test_video/lpb_yl.mp4','39.156457','119.152313',0,'2019-07-22 15:54:48','77.7','25.0','0'),(18,'video_hellpo','顺义研究院','http://10.2.151.139:8888/media/test_video/lpb_yl.mp4','39.157898','120.148568',0,'2019-07-22 16:00:30','77.7','25.0','0'),(19,'video_yc','盐城高通量研究院','http://10.2.151.139:8888/media/test_video/jwc.mp4','29.135487','114.111567',0,'2019-07-22 16:06:48','17.0','25.0','0'),(20,'video_nanjin','南京分公司','http://10.2.151.139:8888/media/test_video/jwc.mp4','38.1562235','116.123453',0,'2019-07-22 16:09:35','17.0','25.0','0');
/*!40000 ALTER TABLE `users_stream` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile`
--

DROP TABLE IF EXISTS `users_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `users_userprofile_user_id_87251ef1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile`
--

LOCK TABLES `users_userprofile` WRITE;
/*!40000 ALTER TABLE `users_userprofile` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_verifycode`
--

DROP TABLE IF EXISTS `users_verifycode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_verifycode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_verifycode`
--

LOCK TABLES `users_verifycode` WRITE;
/*!40000 ALTER TABLE `users_verifycode` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_verifycode` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-07-23 14:56:08
