-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: vue_face
-- ------------------------------------------------------
-- Server version	5.7.28-0ubuntu0.18.04.4

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add user',2,'add_user'),(5,'Can change user',2,'change_user'),(6,'Can delete user',2,'delete_user'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add permission',4,'add_permission'),(11,'Can change permission',4,'change_permission'),(12,'Can delete permission',4,'delete_permission'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add 人脸图片地址',7,'add_faceimg'),(20,'Can change 人脸图片地址',7,'change_faceimg'),(21,'Can delete 人脸图片地址',7,'delete_faceimg'),(22,'Can add 实时监控数据',8,'add_camerarealtime'),(23,'Can change 实时监控数据',8,'change_camerarealtime'),(24,'Can delete 实时监控数据',8,'delete_camerarealtime'),(25,'Can add 人脸数据',9,'add_face'),(26,'Can change 人脸数据',9,'change_face'),(27,'Can delete 人脸数据',9,'delete_face'),(28,'Can add permission',10,'add_permission'),(29,'Can change permission',10,'change_permission'),(30,'Can delete permission',10,'delete_permission'),(31,'Can add route',11,'add_route'),(32,'Can change route',11,'change_route'),(33,'Can delete route',11,'delete_route'),(34,'Can add interface',12,'add_interface'),(35,'Can change interface',12,'change_interface'),(36,'Can delete interface',12,'delete_interface'),(37,'Can add role',13,'add_role'),(38,'Can change role',13,'change_role'),(39,'Can delete role',13,'delete_role'),(40,'Can add menu',14,'add_menu'),(41,'Can change menu',14,'change_menu'),(42,'Can delete menu',14,'delete_menu'),(43,'Can add function interface',15,'add_functioninterface'),(44,'Can change function interface',15,'change_functioninterface'),(45,'Can delete function interface',15,'delete_functioninterface'),(46,'Can add 录像信息',16,'add_camerastream'),(47,'Can change 录像信息',16,'change_camerastream'),(48,'Can delete 录像信息',16,'delete_camerastream'),(49,'Can add 匹配信息',17,'add_check'),(50,'Can change 匹配信息',17,'change_check'),(51,'Can delete 匹配信息',17,'delete_check'),(52,'Can add 短信验证码',18,'add_verifycode'),(53,'Can change 短信验证码',18,'change_verifycode'),(54,'Can delete 短信验证码',18,'delete_verifycode'),(55,'Can add 对应关系表',19,'add_matchup'),(56,'Can change 对应关系表',19,'change_matchup'),(57,'Can delete 对应关系表',19,'delete_matchup'),(58,'Can add 陌生人脸图片地址',20,'add_stranger'),(59,'Can change 陌生人脸图片地址',20,'change_stranger'),(60,'Can delete 陌生人脸图片地址',20,'delete_stranger'),(61,'Can add role user',21,'add_roleuser'),(62,'Can change role user',21,'change_roleuser'),(63,'Can delete role user',21,'delete_roleuser'),(64,'Can add 流信息',22,'add_stream'),(65,'Can change 流信息',22,'change_stream'),(66,'Can delete 流信息',22,'delete_stream'),(67,'Can add 行人重识别',23,'add_personreid'),(68,'Can change 行人重识别',23,'change_personreid'),(69,'Can delete 行人重识别',23,'delete_personreid'),(70,'Can add 行人检测信息',24,'add_persondetect'),(71,'Can change 行人检测信息',24,'change_persondetect'),(72,'Can delete 行人检测信息',24,'delete_persondetect'),(73,'Can add 摄像头信息',25,'add_camera'),(74,'Can change 摄像头信息',25,'change_camera'),(75,'Can delete 摄像头信息',25,'delete_camera'),(76,'Can add Token',26,'add_token'),(77,'Can change Token',26,'change_token'),(78,'Can delete Token',26,'delete_token'),(79,'Can add captcha store',27,'add_captchastore'),(80,'Can change captcha store',27,'change_captchastore'),(81,'Can delete captcha store',27,'delete_captchastore'),(82,'Can add album',28,'add_album'),(83,'Can change album',28,'change_album'),(84,'Can delete album',28,'delete_album'),(85,'Can add track',29,'add_track'),(86,'Can change track',29,'change_track'),(87,'Can delete track',29,'delete_track'),(88,'Can add user extra info',30,'add_userextrainfo'),(89,'Can change user extra info',30,'change_userextrainfo'),(90,'Can delete user extra info',30,'delete_userextrainfo'),(91,'Can add crontab',31,'add_crontabschedule'),(92,'Can change crontab',31,'change_crontabschedule'),(93,'Can delete crontab',31,'delete_crontabschedule'),(94,'Can add periodic task',32,'add_periodictask'),(95,'Can change periodic task',32,'change_periodictask'),(96,'Can delete periodic task',32,'delete_periodictask'),(97,'Can add interval',33,'add_intervalschedule'),(98,'Can change interval',33,'change_intervalschedule'),(99,'Can delete interval',33,'delete_intervalschedule'),(100,'Can add periodic tasks',34,'add_periodictasks'),(101,'Can change periodic tasks',34,'change_periodictasks'),(102,'Can delete periodic tasks',34,'delete_periodictasks'),(103,'Can add task state',35,'add_taskmeta'),(104,'Can change task state',35,'change_taskmeta'),(105,'Can delete task state',35,'delete_taskmeta'),(106,'Can add saved group result',36,'add_tasksetmeta'),(107,'Can change saved group result',36,'change_tasksetmeta'),(108,'Can delete saved group result',36,'delete_tasksetmeta'),(109,'Can add task',37,'add_taskstate'),(110,'Can change task',37,'change_taskstate'),(111,'Can delete task',37,'delete_taskstate'),(112,'Can add worker',38,'add_workerstate'),(113,'Can change worker',38,'change_workerstate'),(114,'Can delete worker',38,'delete_workerstate'),(115,'Can add 预警事件类型',39,'add_warningtype'),(116,'Can change 预警事件类型',39,'change_warningtype'),(117,'Can delete 预警事件类型',39,'delete_warningtype'),(118,'Can add 预警事件',40,'add_warningevent'),(119,'Can change 预警事件',40,'change_warningevent'),(120,'Can delete 预警事件',40,'delete_warningevent'),(121,'Can add 预警事件历史',41,'add_warninghistory'),(122,'Can change 预警事件历史',41,'change_warninghistory'),(123,'Can delete 预警事件历史',41,'delete_warninghistory'),(124,'Can add 登录日志',42,'add_loginrecord'),(125,'Can change 登录日志',42,'change_loginrecord'),(126,'Can delete 登录日志',42,'delete_loginrecord'),(127,'Can add 操作日志',43,'add_operationrecord'),(128,'Can change 操作日志',43,'change_operationrecord'),(129,'Can delete 操作日志',43,'delete_operationrecord');
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
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (20,'pbkdf2_sha256$36000$Cz4nwePAcFt8$iuOSbfOEBYDONjKr0SKiPRqIxhikosn9T0NLcssxD34=','2019-12-24 12:12:44.655762',0,'test888','','','test115@test.com',0,1,'2019-12-23 16:22:31.947749'),(40,'pbkdf2_sha256$36000$seOOQqB3d39d$Z7SYVh2855w610j6MAHoq100hZiCVig/yxkN0bIhqe4=',NULL,0,'test999','','','test999@test.com',0,1,'2019-12-30 16:26:49.625301'),(42,'pbkdf2_sha256$36000$UNmIrfntTpDh$gB3hquyzgOdPz+k+CU6ZVebMf2CXJx4jtjqjp68GgWc=',NULL,0,'xiaoli','','','997@qq.com',0,1,'2020-01-03 16:48:08.534187'),(43,'pbkdf2_sha256$36000$W3fYkPDxjTz2$Ujvpw5L5t0YSvHIsOii/mRFkZKG2wbTTTEve574+Ubs=',NULL,0,'mingming','','','99@qq.com',0,1,'2020-01-03 16:53:35.176927'),(44,'pbkdf2_sha256$36000$IhdrOEONdaFN$BXX2/RHOU1/E7zbfVYhLJ5Kl/Nw79CLXKl7TWCRVipw=',NULL,0,'jiale','','','9966@qq.com',0,1,'2020-01-03 17:12:50.088038'),(46,'123',NULL,0,'tom','','','tom@test.com',0,1,'2020-01-13 18:04:15.077586'),(47,'pbkdf2_sha256$36000$AhWJjmfsAoGC$r3gPYm6Mxi5O+fqQtLy4aOXvSrJmO58/+FkLTzs40Bk=',NULL,0,'joly','','','joly@qq.com',0,1,'2020-01-13 18:06:02.689779');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('290fc5fe833495d1f801dba2c85b9aa34675ba82','2020-01-03 17:12:50.122137',44),('3ea937f1b62d9ed6566141c3981148206224efca','2020-01-13 18:06:02.734700',47),('70f46b816182df251c4f8bfb66a045a93845d3b5','2020-01-13 18:04:15.120827',46),('84d4c20e0831413fae8715b3288b3747a589eb7c','2020-01-03 16:53:35.219511',43),('8fede064e6b84574952717ed13c2837b0adbcf2b','2019-12-23 16:22:31.982564',20),('bd52e0b7f6e9e889892aece013049cbf99b5c62f','2019-12-30 16:26:49.660196',40),('ce906b637b46839f81b71d488e4154584e8b4d3e','2020-01-03 16:48:08.570263',42);
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
  `expiration` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=461 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_captchastore`
--

LOCK TABLES `captcha_captchastore` WRITE;
/*!40000 ALTER TABLE `captcha_captchastore` DISABLE KEYS */;
INSERT INTO `captcha_captchastore` VALUES (1,'BXMH','bxmh','c92f79b232f4e680ae15363ff4bda0bdcc65cd17','2019-12-05 11:34:30.394245'),(2,'RHFE','rhfe','de965369ea1b5b687249fce0e4b0de959a83ffbd','2019-12-05 11:34:53.979483'),(3,'PXDD','pxdd','a95ad08d07b6c1baa27eaffc704dc074494f60c2','2019-12-05 11:35:31.642713'),(4,'NCXU','ncxu','d83d98d4d55c0280bedb9257a1e28d9a0113fb14','2019-12-05 11:35:42.797622'),(5,'HANQ','hanq','47338eb36ab5ae5e4e7992a3309d2f56df123e43','2019-12-05 11:44:49.247133'),(6,'RKUY','rkuy','579bbb21a39e5a9ff40afa64fd3bfa247c839c77','2019-12-05 11:50:57.242184'),(7,'XXQV','xxqv','911cb9e05c0622469e905ccaecd69f3168664a4f','2019-12-05 11:51:28.611271'),(8,'BEUI','beui','d71e38e02712cd6aaabf6b438e4d486fd11001bf','2019-12-05 11:54:37.524540'),(9,'ICWW','icww','d8279c433fbb76ae51ca82434b3be68af76025d1','2019-12-05 11:54:40.486876'),(10,'TTUA','ttua','e4ef8f39d8c2094fb4b7bd12ce623da0a646d90d','2019-12-05 11:54:52.703765'),(11,'KNQF','knqf','296ceb7f68cd5b7826263c28258f0d5e9f96ed84','2019-12-05 12:02:57.362390'),(12,'ULUB','ulub','7396de02bfb2841e64ef1e17df75fe6108c7d148','2019-12-05 12:03:06.698474'),(13,'IEMK','iemk','548b413bab01b7d8553a0e134273aaaa64214bfd','2019-12-05 14:10:31.329437'),(14,'CSRD','csrd','6c77174f27342ab45b6375ddeb96836fe36638c3','2019-12-05 14:20:30.166595'),(15,'VOXL','voxl','3a283b263aded526e5c61b90afdc56ca19fdb7d7','2019-12-05 14:24:52.315138'),(16,'FACS','facs','be4492e5921d57ba28a4c552001e2d6e9ec5cc54','2019-12-05 14:25:11.186288'),(17,'DMYP','dmyp','bf6b530541fb70f9b12d6d648faea72aa9738009','2019-12-05 14:35:29.135748'),(18,'GUPO','gupo','52943adbd65b0b029f37e73c8a82a0e882c4b499','2019-12-05 14:47:43.844857'),(19,'DZOD','dzod','da3d8190ba78e744be37382b4ff6b14146f9bf9a','2019-12-05 15:02:17.904730'),(20,'WUVN','wuvn','fb02649d6c29253128ded604f1d4a1c0b0bf68ce','2019-12-05 15:03:39.760195'),(21,'AXBJ','axbj','969fd46d464e9a8db9d7aff68eb8a10cabc38c86','2019-12-05 15:05:55.040834'),(22,'PVJV','pvjv','76a2b2fceeb96545f3ce85816e10bafabcfbe840','2019-12-05 15:12:59.066003'),(23,'NVDZ','nvdz','8dfafa7c577ce8620933108b96c7684a1caf3cf0','2019-12-05 15:18:45.831412'),(24,'KVSO','kvso','60c1d4c8c14d841b2dc18eff4853d54830c338c3','2019-12-05 15:19:49.866938'),(25,'JUNW','junw','46d6cb7c177d1acfdbfd1ceea297726c96736b64','2019-12-05 15:22:54.573584'),(26,'TIRE','tire','b6a870f357fac93474deca17cc26109949e240c0','2019-12-05 15:48:29.558142'),(27,'YGSG','ygsg','9abf4ffa7b9396f6736969b21bc7b491217c6d39','2019-12-05 15:52:45.048439'),(28,'VOJE','voje','3e98ea7a46767078c578f86c71c31a365d8b13ae','2019-12-05 15:53:58.819520'),(29,'HGAO','hgao','6b0feeedb7da199a26675b9dc1f4ddfd1e6b71a8','2019-12-05 16:07:20.904737'),(30,'QHRR','qhrr','303e313ccd7bd2102ab0797b1a97d377bb7b1d1f','2019-12-05 16:09:13.903683'),(31,'FKUU','fkuu','4b6d1334763b9fa56cbfbe15c486eb289d320033','2019-12-09 14:00:24.439411'),(32,'CMPT','cmpt','abb51f1e5a529ae186466c81166e0cdde7b2eca4','2019-12-09 14:03:35.885873'),(33,'MZFZ','mzfz','f6ce2619f6b6148db62ec8a79e8506794ec88f40','2019-12-09 14:17:00.600314'),(34,'KFJV','kfjv','bb917f9dc29fdbcad873f4bc8eb1db8710bec461','2019-12-09 14:25:35.861898'),(35,'CKDT','ckdt','0f90fa2fe89960887695c1296ca29fb394dd3f5b','2019-12-09 14:30:17.105811'),(36,'ZTTD','zttd','3a1e7ad8d7570a744ced05906d811cbcd37e9d81','2019-12-09 14:35:38.246030'),(37,'VGNB','vgnb','a82e630d3fd25af6a6b689426f48e8c4385c124f','2019-12-09 14:43:55.016287'),(38,'ABAR','abar','de8afc93d443c3b62ccad595d529bca6e017f474','2019-12-09 14:48:13.213535'),(39,'PIJP','pijp','2e3d080ee2f04c3dcc5406682418541006e87c91','2019-12-09 14:49:05.796459'),(40,'EUAY','euay','60d12505d8b910d21df7393d08b76fe42d3009de','2019-12-09 14:59:15.534814'),(41,'KHLN','khln','ceb7911a2bf6041281d487c8f1d76277b449b838','2019-12-09 15:02:46.458376'),(42,'UBMU','ubmu','53bf9ff44a303d618bf5e9c20d85fba01066bc81','2019-12-09 15:07:21.845893'),(43,'WEBS','webs','8efc298f8061c451c443a22dfa4c51e12a5d8b9a','2019-12-09 15:07:49.628813'),(44,'RGUK','rguk','590d0802ecd0bfce3ae3a2eab9ad95b8ee619ca6','2019-12-09 15:09:45.396161'),(45,'SPWV','spwv','518c9e2f6f66e246d1ac94ce514eb2b666c3c724','2019-12-09 15:11:39.100025'),(46,'NTLI','ntli','63a1dfb56f16893dec4bbd87f05d6962bf531488','2019-12-09 15:13:39.881857'),(47,'RTVO','rtvo','859fb7569957cf6293e1833f0fe4a833a2792c55','2019-12-09 15:15:39.558331'),(48,'NTPT','ntpt','766875416c0e76968323afafea4f71375a3b9c16','2019-12-09 15:17:24.184891'),(49,'WZVK','wzvk','b11bb3596fe78d8701225e54646a7bd349c0e7f8','2019-12-09 15:23:04.596583'),(50,'XOCD','xocd','05dc1610efc57adc3298921b782a90a15ff640ca','2019-12-09 15:24:35.833512'),(51,'DHYE','dhye','319e8ffa8f26e60c93545346f7e8e4ad691bac7f','2019-12-09 15:26:12.266578'),(52,'LDKH','ldkh','23f09e73ba15a9c0a6f4b206045de7074849d8ec','2019-12-09 15:27:14.693352'),(53,'SWVQ','swvq','0c303bf5a3872263fe63763b0c404a43d4c004b5','2019-12-09 15:34:50.963402'),(54,'FZFQ','fzfq','2f338194b9518d9469a663cf9aad6171f78a45c8','2019-12-09 15:39:07.346079'),(55,'PMOL','pmol','d2cbd1c1a060123e54fe649ed03642323b685418','2019-12-09 16:03:52.976713'),(56,'OGLZ','oglz','4da47659965c292f5220a7fa049cdbafe70c63c2','2019-12-09 16:05:06.840837'),(57,'TLXL','tlxl','eb0d4a42f87b1cf35d618c6eb8e2d595285d82c7','2019-12-09 16:06:25.460931'),(58,'EJSS','ejss','93ba105293f1d9ca2453a5a2e49a974ce74a879c','2019-12-09 16:07:22.037706'),(59,'GQHH','gqhh','50e740c5030a28108e9923dbf9cbe832549a2a25','2019-12-09 16:08:09.596732'),(60,'TBMR','tbmr','75c6ca6a361eb90fa8367a3dd37d98725be16fa8','2019-12-09 16:09:21.451770'),(61,'LARL','larl','5873dbe045f015a8a7c8582e115e5d496b21670c','2019-12-09 16:14:56.910979'),(62,'SZMF','szmf','a8e1fe54abab3b183047a3a9a481d5d22fc7c015','2019-12-09 16:18:02.666546'),(63,'TSOI','tsoi','072f46e11d88b3295e633fab138e78cc7e8da8d0','2019-12-09 16:18:54.659280'),(64,'HLRX','hlrx','058170c541e3e5afe2d781c909d201969b51a226','2019-12-09 16:19:10.849756'),(65,'KTFA','ktfa','8bab4145548ff10085ac16f1fd07c5413a7010a8','2019-12-09 16:19:22.290359'),(66,'GGUU','gguu','9d95940b103bce91a7fd54feba0c9ddf24acd005','2019-12-09 16:39:25.195293'),(67,'EAHG','eahg','c4d7fd7c462bfc17e76051eb2fd334ee8f2514b2','2019-12-09 16:44:26.047222'),(68,'HOVB','hovb','81c6e3b5329fa08c371442a26d97c2ac1548ed81','2019-12-09 17:03:35.726083'),(69,'REPC','repc','99bb8b6f3050fbc2e15906afb8dafa41935e561c','2019-12-09 17:06:15.145111'),(70,'ZJIV','zjiv','219cf556fc0225e2216283ef2d90dea09f8c67aa','2019-12-09 17:26:45.705212'),(71,'MQHA','mqha','3be145b1b5faf5b7d097d629d1f72834192dc429','2019-12-09 17:28:20.235880'),(72,'WTBF','wtbf','e65dde3257eefec733e806859cf95ae0856fa4a6','2019-12-09 17:56:37.762491'),(73,'QLAB','qlab','8a28d0bd3915575bd3568e45026fad06cb9580f1','2019-12-09 18:02:55.916772'),(74,'GZYN','gzyn','ce871ff6fb6ae922f5aa9956bce7f480b1d6056c','2019-12-09 18:13:58.038772'),(75,'KXEP','kxep','9efc167b0d97066c317b8e8ee5ceb21f6402be8e','2019-12-09 18:24:03.863116'),(76,'VKAV','vkav','b9963354ae7bb62beeae9b46bd8c8b90c2e7adfc','2019-12-09 18:28:08.993430'),(77,'CYQE','cyqe','70ef5cc94f499a26dbe6df6002e56aa4632cf909','2019-12-09 18:30:35.659333'),(78,'QUXG','quxg','999c4b348720226463d0372e459150734dc9c2e4','2019-12-09 18:32:59.569863'),(79,'LHJO','lhjo','8efb80a1189dac99667e9a7db027cdeb35949f83','2019-12-09 18:37:40.938167'),(80,'XWRC','xwrc','c61995e818ef9e52e4202cecd4835dccbf348385','2019-12-09 18:46:38.902422'),(81,'VAWA','vawa','4e17acf44a92d58aa5f7243bc08a10d5f123b317','2019-12-09 18:58:52.595773'),(82,'ZVYM','zvym','c89424c6a4fd8a72007747f856338fdd18a08b1b','2019-12-09 19:01:55.989752'),(83,'DABB','dabb','857dd2435758867acf8f4bcaa6cc5bcb644edbbe','2019-12-09 19:06:05.265850'),(84,'HNRZ','hnrz','35f5a44b06ef1f49dd97c8c65a2422c246e87776','2019-12-09 19:27:12.866330'),(85,'UWJK','uwjk','d2ccc1591ae0d1319712349d80e910d3d42381dd','2019-12-10 11:46:56.226857'),(86,'ESBF','esbf','ecce302b94959697ffa82903bc57ed95f14e7229','2019-12-10 11:47:16.616106'),(87,'SSAF','ssaf','c92698b76f1f09fb97c0854390030b7d7f892c5f','2019-12-10 11:50:08.982957'),(88,'XVHD','xvhd','932e7aee227db06cec3f81c4bd46cd48133628c8','2019-12-10 14:31:28.006801'),(89,'DAXX','daxx','426c8c0d88a2b07fd7f451b9c69a1e553c1954e5','2019-12-10 14:33:39.574051'),(90,'UHKL','uhkl','4e4a6b1104851d9388fe2cdb7683f38495979d9f','2019-12-10 14:36:04.388015'),(91,'DKPH','dkph','b9dc081b37effe68c13185ffcb9c2d12bc873832','2019-12-10 14:38:31.156940'),(92,'DUZV','duzv','97ad8e423bf0bd7262f3092735a1865dd317ad05','2019-12-10 14:40:06.090781'),(93,'XEFF','xeff','415405adf7074a1ca9d9c299e3f363d17a420a88','2019-12-10 14:40:31.033090'),(94,'OYZY','oyzy','62b8ba7414baf414ba0e65f493349bd471ea23ef','2019-12-10 14:48:13.913648'),(95,'IEIY','ieiy','09fc59ac63b2be0664a66adc2a5cd31061812985','2019-12-10 14:50:12.524849'),(96,'IJSV','ijsv','37bd634054120459d52b2a312b532e28f0e1e768','2019-12-10 14:51:54.769870'),(97,'XCRH','xcrh','0308055c2455b93cdba7c01845a36e8ce647be5e','2019-12-10 15:09:59.312970'),(98,'SVCY','svcy','7cee09fa8e555e97ebc317bcaa65137efad98e67','2019-12-10 15:17:11.862371'),(99,'GIZA','giza','96ff662ac6893d201f6ddf0a7501b65001eab5e8','2019-12-10 15:28:49.239292'),(100,'NPNF','npnf','b3d34ab24d2d01ad8b1fab084c3b20091e6d4b1c','2019-12-10 16:08:04.831863'),(101,'MWGK','mwgk','7843a1f76f9b48eb5bf9167ed3436852f1aa8b57','2019-12-10 16:20:38.822603'),(102,'UWRM','uwrm','cd8a78ebe6eb4a1d809eb66d69594a8a26e1db71','2019-12-10 16:51:11.370936'),(103,'JXRB','jxrb','460d751617035f0f225e1210069ae601d3119cbb','2019-12-11 16:22:51.520322'),(104,'FJTR','fjtr','a7432c59e46bb48e3c73d109f109a7ffbf6b35b8','2019-12-11 16:24:17.023586'),(105,'QIPM','qipm','0be0862d5b562f5ea38bb3f99ed7786d6e592e1a','2019-12-11 16:27:32.648636'),(106,'OZFI','ozfi','a7dff3452240bdcec51d967919d07496f2a4ca1e','2019-12-11 16:27:44.940455'),(107,'YGAZ','ygaz','9b60a70c2d41f71790186dac9744e34dca1617e9','2019-12-11 16:28:04.074674'),(108,'QLPG','qlpg','a9ea276c19f8d8ed6afc4a54fd187d82ad89b8cb','2019-12-12 09:17:27.217095'),(109,'JSQF','jsqf','bb9b5b8fca95ffde45dfbc47ca1e9600a69a0947','2019-12-12 10:46:31.640707'),(110,'MCFV','mcfv','6008acc958b3961c5b577dc1559c8b8bb291c9f5','2019-12-12 10:53:56.395947'),(111,'AQOO','aqoo','393d182a73ad35715f42312cfe20c6f69ea3745b','2019-12-12 10:54:04.317663'),(112,'APFF','apff','37ddd40371491b3cf91d8bd80915ed7fde50ceb7','2019-12-23 10:26:14.812322'),(113,'XWBC','xwbc','e74c35479bdc5597727f4bcedab0992388e3bff8','2019-12-23 11:21:35.928141'),(114,'GXFY','gxfy','b2572fde8ec4322185033479402bb2f029d2613b','2019-12-23 11:55:46.431911'),(115,'YXCP','yxcp','d4f82e58ae0b6429f4305cdfba7fc1afc9b82d39','2019-12-23 13:54:11.419223'),(116,'GWFQ','gwfq','cdcb0664aa12ae5e6f06b455420e22ba649faca1','2019-12-23 14:21:45.866490'),(117,'YTUR','ytur','bd5d22aa83658a8f5e6c7ed1b97a2134e0b173cd','2019-12-23 14:27:12.999182'),(118,'EMVL','emvl','6f2a234bf57a8d855bb4234db87a33e9561ca85f','2019-12-23 14:58:48.382474'),(119,'EOOZ','eooz','0643417bbee0f7ca6a0f8a0d65a7067f2e831d84','2019-12-23 15:53:37.736692'),(120,'CHLE','chle','a53ae5eef55c5e4fa300680e41bb7b70832745b8','2019-12-23 17:00:25.824856'),(121,'ROUE','roue','ad623309b84dd9ae1aec1b0abcbb21fa10c88c2d','2019-12-23 17:02:57.741240'),(122,'NDXM','ndxm','fd8f66240222fa1b20becdd4f75409f22f6ea320','2019-12-23 17:04:10.856873'),(123,'FZQX','fzqx','f7875964a7f5bd088b53bba54188258cf08ab3fc','2019-12-23 17:09:02.460937'),(124,'UYDT','uydt','8c49e72e875e81c9cee28de188d06c97070f7153','2019-12-23 17:10:52.408675'),(125,'LYTL','lytl','3a44edbc2125538f07cd4fbf7baf98af19a8db68','2019-12-23 17:12:35.230835'),(126,'VJHP','vjhp','a6d1cb9518e197ed81f5c24c10674bbb3108f214','2019-12-23 17:22:18.871715'),(127,'QUCW','qucw','8d983a4cd7e2cc182f3d970d4b96af6aac60b4b2','2019-12-23 17:25:38.562854'),(128,'BAUD','baud','7746637883aac36eb5a9024e9f5da203a4ffeb91','2019-12-23 18:07:38.329134'),(129,'UOSZ','uosz','e6e49838eee57a8338cc950d5e3b6300e783e919','2019-12-23 18:10:19.463124'),(130,'ISZX','iszx','55ce0427cad635d16ec3a8e52165aba9d1769307','2019-12-23 18:12:57.752853'),(131,'MXRD','mxrd','b15b01cc52a09e1e5b51b94ad2db411774e4b997','2019-12-24 09:19:35.446693'),(132,'HOVW','hovw','39c28a0fd0c4f96cd195c903e5eeb980991de99c','2019-12-24 09:46:59.056243'),(133,'CUDK','cudk','c8406dec711486725e8bffef52601354de66f515','2019-12-24 09:52:54.030497'),(134,'BZND','bznd','9a507966af4783b63b256b31fe2efd6ac6ad08e9','2019-12-24 09:56:16.758506'),(135,'JATF','jatf','d98340ce34f75ab469308976a73b62a2a6c99129','2019-12-24 09:58:46.413244'),(136,'EXMO','exmo','22719276b9c32364173fc630930f36a77c89b178','2019-12-24 10:04:42.607699'),(137,'SPDW','spdw','f19608043b49893fbab91d5936ec9ef1abad2e1c','2019-12-24 10:11:36.375441'),(138,'ZILT','zilt','6224d47c545e1eed5e000ed0014e1e369f864702','2019-12-24 10:17:38.096366'),(139,'FMXL','fmxl','0bf14b2fe6435094674d558d731c23ba1f49c367','2019-12-24 10:18:16.242805'),(140,'WYFP','wyfp','93ce188d59261d5118fe60ead8313484880544e8','2019-12-24 10:26:27.278260'),(141,'AKJG','akjg','83ecf02f3729eb1df8773b47cc44ff0c9b187ea8','2019-12-24 10:27:07.449442'),(142,'LZXX','lzxx','6cb26f2e3cb0d4660de8bd04f590807de6b19329','2019-12-24 10:49:27.121604'),(143,'UHVN','uhvn','7303dc80fc52628d754741d58b76f7946e0fbf72','2019-12-24 10:50:47.015415'),(144,'ACCB','accb','11f97a0e00ee76c320f94c773341294b891c974e','2019-12-24 10:52:15.625342'),(145,'VISQ','visq','52cfbb1de20e1763c9892f8c88931b2d8b92f2e0','2019-12-24 11:01:35.406773'),(146,'ARTX','artx','2d915bde5bdaeff7ce0949942a4cb16ffa5a9a70','2019-12-24 11:02:41.857460'),(147,'GZYM','gzym','63bae2c635a326f12101b1408db4f17d06739f2d','2019-12-24 11:05:01.988348'),(148,'NEOH','neoh','7c55ad5251e5b07c56bee1eda9bf4fafe0672d2a','2019-12-24 11:13:55.122499'),(149,'IWNL','iwnl','087a2908e4ff567a8d0c2136f640b82e49628050','2019-12-24 11:22:40.696046'),(150,'VLYJ','vlyj','8024ac5e91d04d0c3b7ca902df6e3e962901b987','2019-12-24 14:25:26.176085'),(151,'JXFI','jxfi','6f62a208263cf585158385147a7e00986d44acac','2019-12-24 14:26:26.734036'),(152,'QNIK','qnik','0d5ce21b1ff4788160e3b19113733ca2ea37beb3','2019-12-24 14:45:02.913421'),(153,'UPWZ','upwz','c078ed182787c1c0a0d2004adb88a8ca1362cd01','2019-12-24 14:52:04.762612'),(154,'JGCI','jgci','c9de17aab307306e5753626de31ed0d93af6ee8e','2019-12-24 17:25:32.609305'),(155,'EBRX','ebrx','74d23509d6af389f7bc060deeef6bb138a79c5ae','2019-12-25 09:23:12.468446'),(156,'XKHH','xkhh','c263f09215965b02c58196bf88757f0180c25366','2019-12-25 09:30:05.430437'),(157,'PCCW','pccw','e8224183f09b78b1570ad4a39446f2fcd1e89f6b','2019-12-25 09:54:31.746256'),(158,'IING','iing','127954c9dd1ad37b98df6c027866ee463996bf3e','2019-12-25 10:59:19.730218'),(159,'VPIK','vpik','63695b5e8f2e80dd3b8aeca22e483e58bdb3833c','2019-12-25 10:59:28.651987'),(160,'BLFC','blfc','19bf2c4ac6337119f180a2549375e403f7a6affb','2019-12-25 14:07:21.560741'),(161,'CZPJ','czpj','460f12c09e6bb7710b2479767da54a8f92e9c1ec','2019-12-25 15:22:19.750176'),(162,'SUDF','sudf','b80f7c310c3dec3e3baedecd7a590b64c5c5e29a','2019-12-25 15:24:52.898297'),(163,'KPWO','kpwo','432bd2f03f91fdc1f05f0d16239ce6999a01e7da','2019-12-25 15:48:52.247523'),(164,'OBGJ','obgj','e1a92836dc4a43e6f55e69b9f2b9e1f1aa12d6fb','2019-12-25 15:51:07.987619'),(165,'JVYU','jvyu','b98f8f20b5eb1293b1e258b2b0b52bc3aff0ba67','2019-12-25 17:37:51.834542'),(166,'ARKG','arkg','8d1c66d0595e53a38db4ab9dbd29f61ce498513c','2019-12-27 09:21:03.126682'),(167,'YTES','ytes','0e5e17c8d4bfb2040776e32d2192f62d417423ec','2019-12-27 10:29:52.884727'),(168,'GSWG','gswg','7d87152259266bcad08fa34fba13c63efc6b4e8c','2019-12-27 10:30:48.074922'),(169,'IPCX','ipcx','c67ac31776990f882324cdb96b4948be58d3a0b6','2019-12-27 10:49:26.653049'),(170,'BZTX','bztx','524fe21be7540deba46a4d23020e26766c2ef140','2019-12-27 10:51:36.042313'),(171,'XXFG','xxfg','797494e5708f5971686b4fb7d5ee24fb042be831','2019-12-27 10:54:13.112912'),(172,'FNPU','fnpu','d682945b6f213934fb5cb9d278dde02894bfd1d6','2019-12-27 10:55:06.642096'),(173,'XQZV','xqzv','8656eff7660cfac8f749d2af465842b17c01c296','2019-12-27 10:55:19.392009'),(174,'LENJ','lenj','3965dd06f2e22c411d78630695cafc25e0aaba16','2019-12-27 10:55:43.893723'),(175,'FCEV','fcev','f7813f0e930b88a23933b48611067b05d8e720a6','2019-12-27 10:55:52.452765'),(176,'TCQV','tcqv','8b65ca4eff9a2854046789bce49e37d461cb8ee8','2019-12-27 11:02:53.886856'),(177,'GCAP','gcap','c339eb3aad7245b54771f5e7c9a4d3e3a93f8f0c','2019-12-27 11:03:08.273026'),(178,'OPSJ','opsj','8231b2d56ed9d699dc4fa29ee24ae72434a5cde9','2019-12-27 11:06:58.825409'),(179,'PDUU','pduu','4fbf6ba0aee783d08ba7c7be3687dfbe119bc9da','2019-12-27 11:07:04.808801'),(180,'ONSP','onsp','550d686ef850925c5d8619fc3b1a6a000d33cc16','2019-12-27 11:08:03.342142'),(181,'RSPL','rspl','470f91557b568f6b5cee3f79971acd15b91d4b39','2019-12-27 14:01:08.863141'),(182,'YBTG','ybtg','9b3fc0065ad45650acab0698562c3672bd5ad28a','2019-12-27 14:01:12.128313'),(183,'YWBO','ywbo','32b1bea28daf60b923e6fe9c16857d46fdbd430e','2019-12-27 14:01:24.840762'),(184,'TPGQ','tpgq','11b6ad9d0dd485e7d27fb3cbcecf05b611731f59','2019-12-27 14:01:27.902111'),(185,'YJYR','yjyr','c43eefa8f9e2404e1dc2f96de5fb2a594daba31e','2019-12-27 14:14:14.599433'),(186,'VNSZ','vnsz','6a4119ac674edcf2599083b151ea0bf856c15619','2019-12-27 14:14:18.327986'),(187,'YCRP','ycrp','725418a9afb97a14e4d2d2b657d54153f458ab27','2019-12-27 14:14:30.058087'),(188,'XYDX','xydx','8f02809b834b9d0197ac886cda7e0bf5439b469d','2019-12-27 14:19:50.375045'),(189,'YQJV','yqjv','b52a390acca0c284d5bad2a457045562d9d88ca1','2019-12-27 14:19:53.841641'),(190,'YIIR','yiir','ebeef122c8d8f50a74461588d90b8f9fdd004747','2019-12-27 15:11:40.974160'),(191,'GXSP','gxsp','7432031195e7313c5a6dd02d21e8bcada2825e29','2019-12-27 15:11:44.873520'),(192,'QLNE','qlne','d8356b32f77aaa0468b94e3e5f21cb599638f222','2019-12-27 16:39:11.372788'),(193,'IWBC','iwbc','1e4f3ac7938a5b8644a513b2297efea7e5b910f5','2019-12-27 16:39:14.327717'),(194,'HQDT','hqdt','b661f8a3e50956652fead2a59338aced3603ef53','2019-12-27 18:06:52.442960'),(195,'UBGE','ubge','b8a183c7305694d9ddf72740ed887a1973d977a5','2019-12-27 18:06:57.119266'),(196,'YVRD','yvrd','2f750bcf439e178b2deb54a268f7b7e3a2c41a7e','2019-12-27 18:14:46.547596'),(197,'VCBI','vcbi','6d12988a404d12ce9e2ce31d945e2cc0b5e647b0','2019-12-30 09:47:59.191371'),(198,'REPY','repy','28e8940be94ea9a601f56833715c7734c949d926','2019-12-30 09:48:05.282959'),(199,'GCID','gcid','f0654d3f516c785dd95577432ee71438c57e022d','2019-12-30 11:08:50.743270'),(200,'OKUT','okut','6f6c6bd91102c619ea19791fed288ce18e64ffab','2019-12-30 11:08:54.385009'),(201,'JHRP','jhrp','37c9e850fdaaa860dab1cb85225615b610ebde97','2019-12-30 11:12:40.840373'),(202,'HBRM','hbrm','ea71c49dae40ddbc76ed7e496df05979b1a345a7','2019-12-30 11:12:44.423229'),(203,'YZFE','yzfe','e31e7227d672673a4fc2bcd7c70fb3326126f22a','2019-12-30 11:12:55.819534'),(204,'KBHH','kbhh','460eb1a373543cffe7624f015ee868ad49c83bf8','2019-12-30 11:16:11.554368'),(205,'GWDF','gwdf','b4b4ca98c8fcd4fa2a99d13703c12e77898361e8','2019-12-30 11:50:08.986107'),(206,'PPVH','ppvh','1c15724dfa42a4b24f50cd5c5d6884f21f95ba6d','2019-12-30 12:46:05.630084'),(207,'TEEE','teee','85770bd5177740e2e83e1dd1ade17978564b519a','2019-12-30 12:46:09.370217'),(208,'QDEE','qdee','0a79c89d1a2200fd689cbb0e1bbd0886db5325f4','2019-12-30 14:29:05.014054'),(209,'WQMU','wqmu','6da40eb76a1ca1a67f00df40d563f3e129aff8b0','2019-12-30 14:29:11.042313'),(210,'WHSG','whsg','b6f0a4c872d0c5e020fc7c5bdfb2d89c646681c1','2019-12-30 15:42:15.662370'),(211,'AYWQ','aywq','8ab9a64595b724fa9f30d31da34ae620a977de54','2019-12-30 15:42:26.241015'),(212,'SXIJ','sxij','fa92a5f7c32a6eb018c2eb4a24f5cb61c4293d8f','2019-12-30 15:44:08.953515'),(213,'KJNJ','kjnj','68019a86f60f342b436c3e348ca3d3df6a6b6a1f','2019-12-30 15:44:16.444653'),(214,'RNQG','rnqg','6e0eb42f59247d1afe7dec3c54df97b11710fcaf','2019-12-30 15:44:18.589882'),(215,'MIWF','miwf','35c6b987f28270f397144509e7461b6281924674','2019-12-30 16:28:41.913696'),(216,'KDJQ','kdjq','90ff80b5b0c5f2a51ed914128a158556c102bd5f','2019-12-30 16:28:47.226451'),(217,'MQVF','mqvf','a89997c3592367beb22654ec83019ecfd16f1c3e','2019-12-30 16:29:24.420685'),(218,'OIGN','oign','39ca068993a3358c0b257d15ccddbd42e685be81','2019-12-30 16:29:40.047446'),(219,'KYKG','kykg','0af838461b46cb460cb4df5c2b650050cf1dcc74','2019-12-30 16:32:04.984048'),(220,'WWMM','wwmm','793a8b188572fd4b32dc1f9939c79207bb35f9dd','2019-12-30 16:33:14.292800'),(221,'WKPP','wkpp','0fc32e811351ae0be0dc93495858c7b9c1cf7e54','2019-12-30 16:42:22.094394'),(222,'HNDH','hndh','b2b521b4a57c06111a55121a1fb80a07935c2f12','2019-12-30 16:43:19.042712'),(223,'QAUW','qauw','61205c84af86d7d049c55d6cc5268ea5b4abb95d','2019-12-30 17:22:40.848574'),(224,'QUSR','qusr','97905015a1502f36a47a451ab2483da0cee7b226','2019-12-30 17:22:47.759506'),(225,'AWTE','awte','699627f335212a9f4d63636c03d927929207186d','2019-12-30 17:29:42.110470'),(226,'KOKU','koku','240ca5743382ac5424a68300eba89b92e5e0e336','2019-12-30 17:29:49.875575'),(227,'TXKZ','txkz','b64d96378e8a8b2da75e1d90c8ee5a2a21d9277e','2019-12-30 17:30:46.988917'),(228,'POGR','pogr','0226cf6654590212a9a9f80543f9a9d149cf92e5','2019-12-30 18:26:47.791763'),(229,'NKOF','nkof','5f3a82f2dc7222c6aa60b46caf37ffa31557c7ea','2019-12-30 18:29:16.290939'),(230,'JSRX','jsrx','e227f3993aa36ba252715cc31d9a50f763723397','2019-12-31 09:46:30.558537'),(231,'OOHW','oohw','e744b7df51a30b364338d71ba1790b8f8acd8425','2019-12-31 09:46:43.559161'),(232,'ANRV','anrv','eab930ee1ef5c338c43aa286f4b8b850f62c1599','2019-12-31 10:09:06.839128'),(233,'YYON','yyon','fe96c074ec98731054ccd710a04b1e5d5112f0cd','2019-12-31 10:38:05.538566'),(234,'UYWQ','uywq','2c2274fdf6db5cdf384251764cd0fe9526f24742','2019-12-31 11:08:44.651371'),(235,'DEXT','dext','b571af5c3ac59e3537a7d49abb0fefb8821e18e2','2019-12-31 11:48:40.003898'),(236,'XYPE','xype','36ce6a9de189883e09463447a625916d3b0e7163','2019-12-31 14:23:49.090772'),(237,'VKIF','vkif','d07dc3d53786153441ef80c8cb27e80b40be7547','2019-12-31 14:24:01.590088'),(238,'DUVH','duvh','8bd52f8f90034a28ec4ce23c1d2b27b0ae3e7bd9','2019-12-31 14:29:26.536017'),(239,'ZLOR','zlor','917a705dfa781722cb894f77d1a431ace6f88688','2019-12-31 15:12:35.261776'),(240,'ONOS','onos','59d79c30bd38786c95191b5ddedc4c4ef31b0694','2019-12-31 15:18:35.933863'),(241,'VTCF','vtcf','8e17ea5855c308674ffb4b522957ebf1ee77a5b8','2019-12-31 15:51:19.299948'),(242,'VHRP','vhrp','678fececa411dc2167b4910f9c54b63755df60f1','2019-12-31 16:55:17.973484'),(243,'DEIL','deil','6a46688d8284783cb3c17a2e6e036ff124e78611','2019-12-31 17:07:58.461565'),(244,'JMKS','jmks','cd5350da17cfbe63ea3a7d3ae4c04d0ef87c22c6','2020-01-02 09:45:24.460823'),(245,'XVQH','xvqh','a82091b132517b899cf2780d46af21bf29d44ec2','2020-01-02 09:45:33.654787'),(246,'OVVK','ovvk','84092c637ca714cfc632b5592e87ddb3b3457ca1','2020-01-02 09:45:43.115851'),(247,'TNJQ','tnjq','42f3ac9193d0b240f9bc11ab63c2b2c05362f383','2020-01-02 09:45:58.097073'),(248,'VLAJ','vlaj','03dc9a9a747872bacd63517205e6f2490cc1e37f','2020-01-02 09:47:07.791088'),(249,'TXON','txon','3edb8b58e49c1636401543e557c74fdc0c34c1dc','2020-01-02 09:51:59.651224'),(250,'CMCR','cmcr','2dc92f90ef6a2d2d61e54eab9733c0e36e3026b0','2020-01-02 09:52:08.192823'),(251,'SMRG','smrg','922c099efd44f6b72a9256153554a99bf2caa79b','2020-01-02 09:54:47.862900'),(252,'ICDT','icdt','ee117a920052bde243e7ce938f99d958ba66dc49','2020-01-02 09:57:40.936351'),(253,'CQED','cqed','7a4704dc1c3e2e8f60bb714da61c77af12211eef','2020-01-02 10:03:03.837999'),(254,'RKTQ','rktq','ec2987b4365f9d6e9be6500e67f34518ed4b9ed9','2020-01-02 10:03:58.622155'),(255,'WOGX','wogx','2ca2e49eb803ff831628bfaece64491e9623859f','2020-01-02 10:16:51.266292'),(256,'RXGU','rxgu','1f1494f0802aedc952afab9886070df4096135ce','2020-01-02 11:43:23.132558'),(257,'FKTK','fktk','72348a355460ee02d42fd81f75c826975ea59d11','2020-01-02 12:49:28.992013'),(258,'STKX','stkx','039f9c26904a691903133c92b87f00922b927938','2020-01-02 12:50:10.152171'),(259,'CMZR','cmzr','1dfee861a754759d4c6843d26a37f36fa4ea8a9e','2020-01-02 12:50:58.799954'),(260,'NGTT','ngtt','a76154b1e4784b4e8251917ff517d75b0144e43d','2020-01-02 13:27:32.812304'),(261,'UPXG','upxg','a799521c53130864243895179856d23e6da7b841','2020-01-02 13:27:51.749905'),(262,'LGKC','lgkc','fcaed095bff79aa36846d8a581553debe8deffb5','2020-01-02 13:41:13.219633'),(263,'KIWG','kiwg','de8eeb3b9f2306e07171bc0f13f710021bdc8e5f','2020-01-02 13:51:56.280171'),(264,'ZNUD','znud','fcf0887c2c8dc76726d82b4d3f16bf014ac8c390','2020-01-02 13:53:47.548772'),(265,'MQMD','mqmd','f03e304b991439b2b577d39d8926713b97e0cf8b','2020-01-02 13:57:00.940665'),(266,'ALIA','alia','b97d0c033f853f7365f862c75848972950f3b4a5','2020-01-02 13:58:31.472058'),(267,'WHYR','whyr','8bc4255b858f576d5a0cb2be7e824477d2fa4e6a','2020-01-02 14:03:14.982482'),(268,'BKDS','bkds','523e4a7f328f4835e31cd526e4fa92afbea6532b','2020-01-02 14:09:01.692535'),(269,'DSEA','dsea','11b82b72f7c1055bf09899d9b4fa46d798e2884f','2020-01-02 14:10:23.420318'),(270,'CVGJ','cvgj','b822580ab54e78f7662f98ef56417f1bd8cda2b3','2020-01-02 14:10:44.970355'),(271,'VYBL','vybl','eb87eafc3c166206ff13a0f238ceb6e18edf7bba','2020-01-02 14:13:35.485884'),(272,'TRAB','trab','4f8c779bf43987068e60f96b243e8e9a5f2203c4','2020-01-02 14:14:28.541702'),(273,'HDYZ','hdyz','9b988157f74d354abb96b0661031e2eb27f9a06e','2020-01-02 14:15:39.535978'),(274,'SBTN','sbtn','530f14c50fb5a20d93cb56dcc8317c183f01940a','2020-01-02 14:16:20.926866'),(275,'MGLK','mglk','6c84e0e77292cdcd4e1460a9352efeebdf97d221','2020-01-02 14:18:54.463104'),(276,'TWTC','twtc','8dd9823c045b57c14f8de8795c632d5701b425a1','2020-01-02 14:19:47.656551'),(277,'YGUL','ygul','2e5b5e994bace0b8235ef3c87a5ff2be71e79d1e','2020-01-02 14:19:57.592111'),(278,'ACPO','acpo','8c4342445404f7467af36b83b812bc25b7324e95','2020-01-02 14:20:08.810135'),(279,'GWSX','gwsx','308e10065c14fd7f7676aa763051fe2fbc43b32e','2020-01-02 14:20:37.732271'),(280,'DCJR','dcjr','4281146611ce5a6a041e6e7803fbee81458404ee','2020-01-02 14:26:35.687322'),(281,'PTFK','ptfk','1747cfd544e3e3aad4a60f9eaf175af325c0ae7d','2020-01-02 14:30:36.124616'),(282,'QCZF','qczf','3571d95f72ef56b795a9056c3fa438a849013e2f','2020-01-02 14:39:42.856732'),(283,'QOPU','qopu','ac60c4988628fa710b38012cd7bdf0d399e6dc47','2020-01-02 14:48:20.528920'),(284,'BQVD','bqvd','eaf8ab229e9bd75658a2e17e644a57a0f041d7fc','2020-01-02 14:58:02.610467'),(285,'NSJY','nsjy','8ba736a8bca33c33a03290f83a3c3e245d285a5c','2020-01-02 15:00:43.718477'),(286,'HJRV','hjrv','e27095083ad1a84f580ca626c1b8073f0e8a069a','2020-01-02 15:01:44.284082'),(287,'HVFH','hvfh','294d3463ed280b52b62025ad1392ac2e1d0e390a','2020-01-02 15:01:52.248255'),(288,'AAKG','aakg','a08670fcd14ab85bc9883a1ddcedb89b1ea5e402','2020-01-02 15:06:54.257234'),(289,'GPXF','gpxf','468f096873bd4895d139f7ef741009d29f51c15f','2020-01-02 15:07:32.295941'),(290,'DYZX','dyzx','bdc18461f1eb6762aeb51cca17ced978bc22510e','2020-01-02 15:07:51.937218'),(291,'TLGT','tlgt','1e041148297a60f7a4ca3133e7c9493645e600a6','2020-01-02 15:07:59.954091'),(292,'JZMH','jzmh','279a84488f5bd2be8f02394f050df0389ecb4fd6','2020-01-02 15:09:14.932427'),(293,'KFJQ','kfjq','555701c4a32d279682706bf48c3d890d5c81bd2b','2020-01-02 15:09:30.514514'),(294,'RDOA','rdoa','1c696077e49141e6361a9958a777165264152f91','2020-01-02 15:10:18.630943'),(295,'RKRX','rkrx','9fdcc1511caaa19d97f8c08ee5dd9327c38059e7','2020-01-02 15:10:28.027926'),(296,'WZYZ','wzyz','258564a45fb6ab22246949dfb284f621be79ce22','2020-01-02 15:10:34.519556'),(297,'OWQZ','owqz','55c63582fbd6cda620017c8c765e366f0cab7de9','2020-01-02 15:11:56.750154'),(298,'UMSW','umsw','ee3657296945ab21fb232e370bd65be8925a5990','2020-01-02 15:12:07.771308'),(299,'DKGB','dkgb','47472d24162fe8e5f585f38939bebd8dce343a9b','2020-01-02 15:13:36.807866'),(300,'HPXP','hpxp','eece0617b5565f82bdce37998297010d86c3dc97','2020-01-02 15:44:48.180083'),(301,'EGZO','egzo','65846d10bc304d8713f24d34fdca196e5f7d680a','2020-01-02 16:21:33.762490'),(302,'GHUE','ghue','ef7fac9f646fcc164c2619ef9370f0405fa3122e','2020-01-02 16:32:23.449158'),(303,'KYXB','kyxb','04ed34ba9f990651522f874d846d57636b4c88f1','2020-01-02 16:36:44.548417'),(304,'FPTD','fptd','ccad9033ff31399b530a64143ef100a57aa9c0a4','2020-01-02 16:39:33.130777'),(305,'AJXS','ajxs','de0dc0ee70f896fff3578a68596a4dd2e03a9b3e','2020-01-02 16:40:12.411765'),(306,'EHQL','ehql','23138782b5551d1b8622bd46572251dc0bafc3f2','2020-01-02 16:42:09.972513'),(307,'WYMK','wymk','48e0dc5b6fdb7d25320eef4673822dc0a1a6f2a7','2020-01-02 16:58:30.733461'),(308,'GZXZ','gzxz','2ea543bc575d071c5e54daed84ebc0f182151789','2020-01-02 16:58:40.564479'),(309,'RZSI','rzsi','03f24dd72b76bdeb314350a7aa73123c9a5a98c2','2020-01-03 10:09:29.066408'),(310,'TBTL','tbtl','3b7c84f4fee2e0f55912e8210e438a215cf863b9','2020-01-03 10:25:43.634159'),(311,'TUJZ','tujz','91cab349488c312ea049a2992894bca5fd990e75','2020-01-03 10:26:50.465335'),(312,'WMCY','wmcy','bfa88ee835d753cadcc710f5b78e047a838d454d','2020-01-03 10:30:06.816622'),(313,'UZSH','uzsh','593fc2701925d8f6aaab4599dc62fb07ebf0c925','2020-01-03 10:30:16.480474'),(314,'FUSQ','fusq','2a904c83eca9dbd89a6b057be8f8aef844f7e023','2020-01-03 10:32:23.816004'),(315,'QNLN','qnln','ef26f83d302d61df0d0e546025b9b68c8924ad18','2020-01-03 10:32:35.069810'),(316,'CZPM','czpm','669004989748b517ae75fb136e7fbbc0f20e6d15','2020-01-03 10:32:48.448870'),(317,'CYCA','cyca','2d28037aaa6f3bf460330a3b08bbf90552facd21','2020-01-03 10:51:04.374817'),(318,'SEME','seme','b75df6a1ce616e91cebe34eb5f53ac01fd62e6a8','2020-01-03 12:27:36.635609'),(319,'WVUW','wvuw','0bfc975530456037d54db5b9c813dc9e3b72549a','2020-01-03 12:46:25.340582'),(320,'WZCY','wzcy','b56fb85636b64ba655bfb47e6f3b7098f9483e4f','2020-01-03 12:48:06.871015'),(321,'HUIT','huit','f5dabb0fc31f947d1ef2fe42ab54adc88e9d1ff9','2020-01-03 12:49:11.552805'),(322,'DQZP','dqzp','c6eda9e93229b784462dda3700b78a0e69611936','2020-01-03 12:49:40.967969'),(323,'DJYK','djyk','dd82571b7666c087b4ae012ab75f87b238d8fd86','2020-01-03 14:11:34.370512'),(324,'KEUH','keuh','01107f5bd07b602708077a2d553008c3cbf87919','2020-01-03 14:37:47.025237'),(325,'VCYG','vcyg','4a0f150a37437d3684dd2e7af9b0dcaf6f7d9410','2020-01-03 14:38:06.966096'),(326,'UQHO','uqho','6b65ad9465a47f07ddff13f4e9001a646f3cc29d','2020-01-03 14:38:14.619471'),(327,'JMER','jmer','6ec29427d0f98dc7c11bd09bd6646457bf29a7a7','2020-01-03 14:42:54.873430'),(328,'LIDU','lidu','71478c74e21ca79de59c22c75b20832c46abfb70','2020-01-03 14:43:10.796393'),(329,'YBZQ','ybzq','4c36fc413e07ea549d634354d6b84661a40744b8','2020-01-03 14:43:51.750217'),(330,'FIGM','figm','afaf1da27d23387f890c7a2ef7e94875dcf0940b','2020-01-03 14:43:56.224345'),(331,'IHMU','ihmu','8e263430efa2e77a3cfe262484edd68208ad036d','2020-01-03 14:46:12.479701'),(332,'GNTY','gnty','bfce9e8b61080465d26d57530cf9b99fef3e0131','2020-01-03 16:37:13.742940'),(333,'IPOE','ipoe','10dcfc3c87670d0c82a3afd8ad52c796de3c44ad','2020-01-03 16:49:59.353334'),(334,'NLIQ','nliq','161d2add055dbb2ead92171296da0c68bb2a6697','2020-01-03 16:52:55.401274'),(335,'MFXH','mfxh','dc8bb98e35d9aa7e9f86cd50cdee7639ebf9894e','2020-01-03 16:56:38.000569'),(336,'SQOE','sqoe','61f3b5a5bd45c66b436f263376487d40f5b9cc53','2020-01-03 16:57:14.847651'),(337,'GXEL','gxel','f565c0838774df1f2c88b20a98c56d304088035e','2020-01-03 16:57:56.133848'),(338,'VZKG','vzkg','b3b687fed3c67351ed722e98d3e66bec0c3c4599','2020-01-03 17:00:51.894339'),(339,'ABGM','abgm','6d6c0063e06b31ffd387c9bc2b293ea81a8c70c5','2020-01-03 17:01:26.098746'),(340,'ULKF','ulkf','7d6099ac77c8218fae8090cd05886067f47e41e7','2020-01-03 17:02:06.827041'),(341,'MXVG','mxvg','f40a2e453d5e8b59587e9f22f75ea5038d9f0d55','2020-01-03 17:11:43.922146'),(342,'EEQA','eeqa','952b22899e697abce3226ea36075e07e945dc525','2020-01-03 17:18:40.325869'),(343,'SCKO','scko','d24685195818b263ffda37afd5375f2a40da5ce5','2020-01-03 17:21:31.113850'),(344,'LGVZ','lgvz','b47c6cea5b6cfc3518f07ac21e1860a7c59b34a8','2020-01-03 17:21:33.843592'),(345,'ZOHA','zoha','781e8ff3d05abf4b62935a495512815782ffd69e','2020-01-03 17:21:45.695397'),(346,'LFPO','lfpo','bf5746773659942d706b55d7167c65204a659a58','2020-01-03 17:21:48.362865'),(347,'JVJJ','jvjj','7b9b436e4cbf7f91f7a22a28a6d57e26eccfb38f','2020-01-03 17:22:49.880548'),(348,'QOPD','qopd','c772db060bcad1acc4f3df766ea2223a5d7a1db8','2020-01-03 17:22:52.918862'),(349,'PJSE','pjse','05d5bf83f96e69ba42e319db4292ee8c294f1e47','2020-01-03 17:23:17.042967'),(350,'DOPC','dopc','e38c1f0e8fa63685b6573669bfa8e5162b18f305','2020-01-03 17:23:19.551237'),(351,'YGLF','yglf','bdc432489f4451cb859e879f3de95d7a023dadca','2020-01-03 17:28:54.213114'),(352,'PRIC','pric','961d74b6beebc4f04ab98f0bdf8f405392e4d3ee','2020-01-03 17:36:59.749551'),(353,'ONLN','onln','39242981d680199c23a69fe0be0c95bc5598f471','2020-01-03 17:38:48.595348'),(354,'XVHP','xvhp','a4e5b8c2b8a7760f6c2dfa279bf9ad63f2ea524b','2020-01-03 17:38:51.509838'),(355,'EPBX','epbx','0191a5343651f899c9f57b7750ce989c53d48302','2020-01-03 17:40:24.737728'),(356,'OJSO','ojso','eb00597851d97198aed211f575422043eb841f62','2020-01-03 17:40:27.187896'),(357,'YJYI','yjyi','1808eaf6f23dc6cc4a87bc5a59e28251f5643ad7','2020-01-09 17:53:20.388792'),(358,'MFQE','mfqe','1ab109fa78799f7e99237ea958d51a2b1dff6838','2020-01-09 17:53:26.966268'),(359,'BZOF','bzof','fd5063ded37731eccfd940cda6b090085481ead2','2020-01-09 18:16:37.889437'),(360,'YWMU','ywmu','55fa48404346afde05a4417ce6a28f43f4701b67','2020-01-09 18:16:47.405992'),(361,'HPAA','hpaa','d9cbba30cf078469dd0795990c5a982adc3e89bf','2020-01-09 18:47:38.955633'),(362,'CPKC','cpkc','79abd4fff6b9163a164ee2986998bf48fa2f6ca7','2020-01-09 19:03:36.717266'),(363,'USNP','usnp','18a199427982ffde6384e2e344f2f704529fa072','2020-01-10 10:33:16.690039'),(364,'RVGI','rvgi','45a81e0a444f05c3bece5c663f40da11fad072b2','2020-01-10 11:32:18.461854'),(365,'KMJG','kmjg','afe01ff22216e8790efa3b53d94317388eb0c332','2020-01-10 11:35:14.947750'),(366,'CFLD','cfld','6efbd705dfa272fcc3ff5711abea4d023e4ba360','2020-01-10 11:35:18.060895'),(367,'XFJV','xfjv','00cab8cc49000c11614eec63732700071496c5a6','2020-01-10 11:35:26.621418'),(368,'UELB','uelb','507882a4f3bf21a003857baeff5c9c3f86b6dd02','2020-01-10 11:35:54.844584'),(369,'SCQE','scqe','d7cf25a9dbe440d9cffbad215936eccdfcb4cf0e','2020-01-10 11:36:03.550531'),(370,'QJUN','qjun','ca08bea986da7dd296984c3ac9acf3811771a768','2020-01-10 11:36:46.681739'),(371,'YBTH','ybth','c25a95b66fabd595cd92393573dc416fb5baced6','2020-01-10 11:37:01.588469'),(372,'DXXL','dxxl','ecd294e60a7a46751d24400ef30c4b33e4902c45','2020-01-10 11:37:42.346894'),(373,'FPGT','fpgt','0051be93617e91892cac36d2bfdc7723d8d39829','2020-01-10 11:39:10.854416'),(374,'PVCS','pvcs','1575e623274cebde88a5f910cb45a1db31a1a5ac','2020-01-10 11:39:59.201164'),(375,'WWVG','wwvg','7ab9e5bda0f08b7a7533a9c966f7b8ccc2915181','2020-01-10 11:41:12.530989'),(376,'LUCC','lucc','801116aa672098751b86c10ecc96e246fc391394','2020-01-10 11:41:49.882297'),(377,'UIWM','uiwm','f2ebeac86695f2747c36f82b1aa374065a423e7d','2020-01-10 11:42:00.235094'),(378,'XNGW','xngw','9dae59b58667afd1451f1a6b14a53766e8fb2e45','2020-01-10 11:43:00.722117'),(379,'KQJO','kqjo','3d91afd76c07a0693b8af97257093ba7f6ad14d3','2020-01-10 11:43:09.753992'),(380,'GUTB','gutb','caecea24fbfcb2ff2d13639421a7f010198ae41e','2020-01-10 11:43:23.894357'),(381,'BKIP','bkip','df5cb42a2b873c0aa89f63f418ca68ee220bb2a0','2020-01-10 11:43:57.263811'),(382,'CEXN','cexn','5f19106019a0823f5a55f5cd844d327bb147cabf','2020-01-10 11:43:59.826288'),(383,'KDMN','kdmn','7e93e0366dc1dfdcf934220120f1f1660376c873','2020-01-10 11:44:12.292639'),(384,'CMAD','cmad','def3ebe089dafd9bbfa53c79bf726db5cf6242aa','2020-01-10 11:44:32.621909'),(385,'PLIQ','pliq','fdadaf660a14e4fa228dbbd9311e2972a6967477','2020-01-10 11:44:53.826803'),(386,'VNGH','vngh','b8a430c90b0ad37bf0d6de7f4a20c34275f6558d','2020-01-10 11:44:56.357108'),(387,'GMFF','gmff','5a39aa1d3ba72f023bbcb356d6937e06563efb24','2020-01-10 11:45:17.259472'),(388,'UMXJ','umxj','ec446808f0203574c37422a961a671b575795796','2020-01-10 11:45:19.635986'),(389,'KWOC','kwoc','09504603df32deed3f04be9a33bbca225444042b','2020-01-10 11:46:15.348047'),(390,'DJRT','djrt','d428e87805c8a3f1265542f642ec5ede35b8fec5','2020-01-10 11:46:17.978300'),(391,'USRO','usro','ebb24d73305dc928a63b71f4d209cb8d0a82757c','2020-01-10 11:48:39.151763'),(392,'XPLY','xply','d4d47903e5ed021b5d710880a4729154fdb16f19','2020-01-10 11:50:33.874523'),(393,'IHIE','ihie','7da87eae46b2bbee064e051d5e1a15b7fa235088','2020-01-10 11:50:36.167066'),(394,'SCIR','scir','f03d18fadc45137e872b4b579e3bc02cb730b73d','2020-01-10 11:50:55.044684'),(395,'ZDLR','zdlr','4fe8bded2a175995ae345c0917496ac8cb7cf5b5','2020-01-10 11:52:54.876007'),(396,'AWWC','awwc','20ec2bf3d76930f2b8be13149d3a0eec17a87e34','2020-01-10 11:52:58.082545'),(397,'XIAZ','xiaz','7526997eb069c06954dfe8b772727418d05f64dc','2020-01-10 11:54:06.197510'),(398,'WCMR','wcmr','af989afb4ae8e781e41456363567a022b8c7f9cb','2020-01-10 11:55:55.693679'),(399,'PWHZ','pwhz','18e3a84da4a5525cddaa30ced1963d0d0da0d66d','2020-01-10 11:55:58.937181'),(400,'IBKX','ibkx','19347860ce23929ec2e110675a4ce39dc5eb06bd','2020-01-10 11:56:31.680141'),(401,'KZHQ','kzhq','6eed21be468c99018400d6a7ef11501e2ea368fc','2020-01-10 11:56:34.202337'),(402,'ZMPJ','zmpj','9775489b1c3fae01d8216124ae7707a87f225309','2020-01-13 16:44:26.303407'),(403,'YPCZ','ypcz','96eadbf92e1e650cc36f0274c8689d0c7c088c7b','2020-01-13 17:03:52.312726'),(404,'JDYX','jdyx','33e482a2469bf6133d48178b46075f5aef47499f','2020-01-13 17:12:47.900150'),(405,'FUAD','fuad','84e6787d840134a06e14195f351c80981eddd148','2020-01-13 17:12:55.437111'),(406,'STON','ston','5b4d77b0433b87f8ef2ea8f654f3718259abc68f','2020-01-13 17:13:07.277537'),(407,'XEWD','xewd','7fa4379cf68639046322d1749bd0b407cea498eb','2020-01-13 17:16:37.075656'),(408,'VYPO','vypo','6264ed841cc29680375f3795784f60a012e42714','2020-01-13 17:16:40.194282'),(409,'IGHE','ighe','218744dd4200f52e4ce393ae67a8e4afd40a960a','2020-01-13 17:20:05.434680'),(410,'WQVM','wqvm','6c5542b8f9d8d77fe16b8c3dc2b84478ec1a15cc','2020-01-13 17:38:00.669978'),(411,'HOFO','hofo','be4e91b12e479b41b73c1901ce6102c23f62623a','2020-01-13 17:38:13.042122'),(412,'NMRJ','nmrj','3f1e7942a6b5fde8f4f8e0ca365e6ffceec2eff3','2020-01-13 17:38:26.822356'),(413,'RAAW','raaw','1ca431c72335f571fb8b402b9d37e21defbf3296','2020-01-13 17:48:29.647528'),(414,'PKNB','pknb','495af654fdea2eeafe5836fe3369fe25f0a5c8bf','2020-01-13 17:48:31.921256'),(415,'ZAZL','zazl','7e9059ed3a0df844fdc396050cc576fa0c6c53aa','2020-01-13 17:49:03.160197'),(416,'TBKU','tbku','33e27e0a9ad0de8dbe1cba15051090bef849d499','2020-01-13 17:49:05.481292'),(417,'MDDK','mddk','4f151e540cec4d8ac1ddfe6b07eaa815c3239b5f','2020-01-13 17:49:17.770927'),(418,'SKUT','skut','3da269574f622d1800e9326994d73c20192dd02a','2020-01-13 17:59:34.051618'),(419,'PWWV','pwwv','f1129814314e4902f9ce86cff48c386c79508ab7','2020-01-13 17:59:37.484522'),(420,'DMVV','dmvv','cb4f90ef953378fd13a7104d24cd73325437eb40','2020-01-13 18:05:22.224870'),(421,'DBDK','dbdk','075f6498291a066b3c737c3dd2b81d01cd15bacf','2020-01-13 18:05:26.211112'),(422,'TTCM','ttcm','5c605a0f8e0b3d5897e2ccfce1ff636922f691f6','2020-01-13 18:06:14.205640'),(423,'YTYC','ytyc','d7e373bc923b54b50bf9a4f7b070063428b624c5','2020-01-13 18:06:17.436262'),(424,'LGRN','lgrn','f7981d66cdfcaf1a5d0967216646ca8449ae8cc3','2020-01-13 18:07:15.863756'),(425,'SFFI','sffi','f1777a5a596ca973fef2e561620b4c7a8d8a7e2e','2020-01-13 18:07:18.919589'),(426,'ICVF','icvf','4e2405f1a70035aeb29d814d6c3616dc21f0cd9f','2020-01-13 18:08:40.556954'),(427,'SZQJ','szqj','6f9242f3cdd648a2c979a8198734f2643bced681','2020-01-13 18:08:43.435493'),(428,'HZOO','hzoo','d6aaee4335238ba8ae373d04845f46b5d545e503','2020-01-13 18:09:00.469454'),(429,'JTUJ','jtuj','c74d67197085384cd730faa27b108c95515ca9f0','2020-01-13 18:09:02.731374'),(430,'OJYV','ojyv','e9d454f0322b3f3811b842c70695f043edabfad3','2020-01-13 18:09:27.661563'),(431,'QOTM','qotm','78429a63a54adbe601ee3d7b0b0326d890789204','2020-01-13 18:09:48.738255'),(432,'TXPE','txpe','c46e734eff16b235ac81fcb1f57ee222853860e8','2020-01-13 18:09:51.185516'),(433,'AMVF','amvf','53a0f391b7114877e76400adece0d42ac3e6b603','2020-01-13 18:18:37.370984'),(434,'KRPE','krpe','05669ccacd72a4122551e1b331e9bbe2837f2bee','2020-01-13 18:18:40.679370'),(435,'ANMK','anmk','6ea55df5ac54fafd7b8af3c333561ce3f4661364','2020-01-13 18:19:55.953795'),(436,'SVHM','svhm','b65d9f902875ab774100c46d7e347d6db360b638','2020-01-13 18:19:58.952497'),(437,'TBUZ','tbuz','5aa8f21741c6acbcf5b3a9edfd92ab5ab51d9102','2020-01-13 18:20:45.540159'),(438,'FLHB','flhb','417309dc4a1ddeb5b36045fed3a56255bc2a86ee','2020-01-13 18:20:48.021856'),(439,'HXNZ','hxnz','b1ba316029c0dd62de7b2ae2b7d74c2114e29f7a','2020-01-13 18:20:57.332410'),(440,'NDPP','ndpp','e17b74fd9f623e1945be4555aaf245ac8a3e9e4b','2020-01-13 18:25:14.442870'),(441,'RSRO','rsro','6a6f9d968d3ea75a2105582ed0ac6307c19ea78b','2020-01-13 18:25:24.797614'),(442,'ZOBB','zobb','855bb6e79079a23740abda86becf976989bc0be1','2020-01-13 18:31:38.584471'),(443,'FYXO','fyxo','f8699c3862b5c009247901053df999108f82f2e0','2020-01-13 18:31:41.975199'),(444,'IFEO','ifeo','54356a4ef3bef752443084e188ef076a57e1bc80','2020-01-13 18:31:55.491926'),(445,'OZHJ','ozhj','e2ab18fd90fe1688ee93910c05f707c431e0c284','2020-01-13 18:31:57.845199'),(446,'XWRW','xwrw','943950b6dabc2afe280a10b8ccbeab68bdf4e36a','2020-01-13 18:32:50.769433'),(447,'OXOJ','oxoj','b9384de513188f767baca9f5c2a736dd377033f0','2020-01-13 18:32:53.169901'),(448,'VLGI','vlgi','66187886fdbe07d15f5065d2b04dabf2deff3aaf','2020-01-13 18:33:06.452573'),(449,'TMKM','tmkm','bd974175e0641a87e2df6155821ac0a0dd0099dd','2020-01-13 18:33:37.261150'),(450,'AVGV','avgv','ae43d8a3e0b57b9d22546e7a9f40a69daf0addd8','2020-01-13 18:33:39.688671'),(451,'GJMK','gjmk','579368341ac9ef89bda910252d360d09509d1940','2020-01-13 18:33:50.026078'),(452,'TRAU','trau','3bbaa1e8eb259793db60e9e352cdadaa7e46ecac','2020-01-13 18:48:41.777404'),(453,'OEXE','oexe','5cb90818070f15179f486c44c7c6cb622e50393f','2020-01-13 18:48:52.426953'),(454,'CGYR','cgyr','b95a5d3c59613203e347d1b4a230b2f609087998','2020-01-13 18:49:58.528582'),(455,'BIPI','bipi','1b8b6992fbec9c39f34bbd6d08f6a7b6993d087a','2020-01-13 18:50:01.668425'),(456,'EAIN','eain','67ddb150b6c6afedba38e959b6aca25574224bf6','2020-01-13 18:50:42.373071'),(457,'XQCP','xqcp','7d153071b4411298d8ba23a8e4bcc3e0e8eb9820','2020-01-13 18:50:45.090883'),(458,'TXOC','txoc','87fade78b5acc15638419709edce638ae2836767','2020-01-13 18:51:35.913672'),(459,'CDGB','cdgb','457681473a3551933f98bfc842bf11b2c5b2e083','2020-01-13 18:51:38.386388'),(460,'CYKG','cykg','5240445f7142e09fccb705a2ae430ec512f4314a','2020-01-13 18:51:44.677367');
/*!40000 ALTER TABLE `captcha_captchastore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `celery_taskmeta`
--

DROP TABLE IF EXISTS `celery_taskmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `celery_taskmeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `result` longtext,
  `date_done` datetime(6) NOT NULL,
  `traceback` longtext,
  `hidden` tinyint(1) NOT NULL,
  `meta` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `celery_taskmeta_hidden_23fd02dc` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `celery_taskmeta`
--

LOCK TABLES `celery_taskmeta` WRITE;
/*!40000 ALTER TABLE `celery_taskmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `celery_taskmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `celery_tasksetmeta`
--

DROP TABLE IF EXISTS `celery_tasksetmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `celery_tasksetmeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskset_id` varchar(255) NOT NULL,
  `result` longtext NOT NULL,
  `date_done` datetime(6) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `taskset_id` (`taskset_id`),
  KEY `celery_tasksetmeta_hidden_593cfc24` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `celery_tasksetmeta`
--

LOCK TABLES `celery_tasksetmeta` WRITE;
/*!40000 ALTER TABLE `celery_tasksetmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `celery_tasksetmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(4,'auth','permission'),(2,'auth','user'),(26,'authtoken','token'),(27,'captcha','captchastore'),(5,'contenttypes','contenttype'),(31,'djcelery','crontabschedule'),(33,'djcelery','intervalschedule'),(32,'djcelery','periodictask'),(34,'djcelery','periodictasks'),(35,'djcelery','taskmeta'),(36,'djcelery','tasksetmeta'),(37,'djcelery','taskstate'),(38,'djcelery','workerstate'),(6,'sessions','session'),(28,'users','album'),(25,'users','camera'),(8,'users','camerarealtime'),(16,'users','camerastream'),(17,'users','check'),(9,'users','face'),(7,'users','faceimg'),(15,'users','functioninterface'),(12,'users','interface'),(42,'users','loginrecord'),(19,'users','matchup'),(14,'users','menu'),(43,'users','operationrecord'),(10,'users','permission'),(24,'users','persondetect'),(23,'users','personreid'),(13,'users','role'),(21,'users','roleuser'),(11,'users','route'),(20,'users','stranger'),(22,'users','stream'),(29,'users','track'),(30,'users','userextrainfo'),(18,'users','verifycode'),(40,'users','warningevent'),(41,'users','warninghistory'),(39,'users','warningtype');
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
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-11-28 10:13:39.064936'),(2,'auth','0001_initial','2019-11-28 10:13:40.830014'),(3,'admin','0001_initial','2019-11-28 10:13:41.225676'),(4,'admin','0002_logentry_remove_auto_add','2019-11-28 10:13:41.254588'),(5,'contenttypes','0002_remove_content_type_name','2019-11-28 10:13:41.488475'),(6,'auth','0002_alter_permission_name_max_length','2019-11-28 10:13:41.648075'),(7,'auth','0003_alter_user_email_max_length','2019-11-28 10:13:41.808397'),(8,'auth','0004_alter_user_username_opts','2019-11-28 10:13:41.823851'),(9,'auth','0005_alter_user_last_login_null','2019-11-28 10:13:41.943227'),(10,'auth','0006_require_contenttypes_0002','2019-11-28 10:13:41.951843'),(11,'auth','0007_alter_validators_add_error_messages','2019-11-28 10:13:41.970966'),(12,'auth','0008_alter_user_username_max_length','2019-11-28 10:13:42.129298'),(13,'authtoken','0001_initial','2019-11-28 10:13:42.367547'),(14,'authtoken','0002_auto_20160226_1747','2019-11-28 10:13:42.594895'),(15,'captcha','0001_initial','2019-11-28 10:13:42.672041'),(16,'sessions','0001_initial','2019-11-28 10:13:42.787496'),(17,'users','0001_initial','2019-11-28 10:13:45.752107'),(18,'users','0002_auto_20191128_1107','2019-11-28 11:07:08.985726'),(19,'users','0003_auto_20191128_1751','2019-11-28 17:51:33.856877'),(20,'users','0004_auto_20191129_0904','2019-11-29 09:04:59.704063'),(21,'users','0005_auto_20191129_0948','2019-11-29 09:48:17.218257'),(22,'users','0006_functioninterface_name','2019-11-29 11:38:29.071638'),(23,'users','0007_auto_20191202_1430','2019-12-02 14:30:08.037972'),(24,'users','0008_auto_20191202_1453','2019-12-02 14:53:23.992758'),(25,'users','0009_auto_20191202_1533','2019-12-02 15:33:35.096402'),(26,'users','0002_menu_index','2019-12-09 17:20:35.565316'),(27,'users','0003_auto_20191223_1144','2019-12-23 11:44:49.005212'),(28,'users','0004_auto_20191223_1214','2019-12-23 12:14:42.985678'),(29,'users','0005_userextrainfo','2019-12-23 15:41:57.564342'),(30,'users','0006_userextrainfo_gender','2019-12-23 16:00:18.408075'),(31,'djcelery','0001_initial','2020-01-09 17:44:54.097836');
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
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('u7e6g50qheqxiqqofyqfaosc35as29w7','MTdkMTZmMDNlNTc1YWE3ZWFkMWJhNmU4YzM4YzUzMzc2MTlhYzE1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzdhZGZkZWY2OTU2N2Q5N2U0MmEwNTcxZDM2NGZjM2RiOGJmNmJmOCIsIl9hdXRoX3VzZXJfaWQiOiIyMCJ9','2020-01-07 12:12:44.674094');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_crontabschedule`
--

DROP TABLE IF EXISTS `djcelery_crontabschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_crontabschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minute` varchar(64) NOT NULL,
  `hour` varchar(64) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  `day_of_month` varchar(64) NOT NULL,
  `month_of_year` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_crontabschedule`
--

LOCK TABLES `djcelery_crontabschedule` WRITE;
/*!40000 ALTER TABLE `djcelery_crontabschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_crontabschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_intervalschedule`
--

DROP TABLE IF EXISTS `djcelery_intervalschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_intervalschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_intervalschedule`
--

LOCK TABLES `djcelery_intervalschedule` WRITE;
/*!40000 ALTER TABLE `djcelery_intervalschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_intervalschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_periodictask`
--

DROP TABLE IF EXISTS `djcelery_periodictask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_periodictask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime(6) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime(6) DEFAULT NULL,
  `total_run_count` int(10) unsigned NOT NULL,
  `date_changed` datetime(6) NOT NULL,
  `description` longtext NOT NULL,
  `crontab_id` int(11) DEFAULT NULL,
  `interval_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `djcelery_periodictas_crontab_id_75609bab_fk_djcelery_` (`crontab_id`),
  KEY `djcelery_periodictas_interval_id_b426ab02_fk_djcelery_` (`interval_id`),
  CONSTRAINT `djcelery_periodictas_crontab_id_75609bab_fk_djcelery_` FOREIGN KEY (`crontab_id`) REFERENCES `djcelery_crontabschedule` (`id`),
  CONSTRAINT `djcelery_periodictas_interval_id_b426ab02_fk_djcelery_` FOREIGN KEY (`interval_id`) REFERENCES `djcelery_intervalschedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_periodictask`
--

LOCK TABLES `djcelery_periodictask` WRITE;
/*!40000 ALTER TABLE `djcelery_periodictask` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_periodictask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_periodictasks`
--

DROP TABLE IF EXISTS `djcelery_periodictasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime(6) NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_periodictasks`
--

LOCK TABLES `djcelery_periodictasks` WRITE;
/*!40000 ALTER TABLE `djcelery_periodictasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_periodictasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_taskstate`
--

DROP TABLE IF EXISTS `djcelery_taskstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_taskstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(64) NOT NULL,
  `task_id` varchar(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `tstamp` datetime(6) NOT NULL,
  `args` longtext,
  `kwargs` longtext,
  `eta` datetime(6) DEFAULT NULL,
  `expires` datetime(6) DEFAULT NULL,
  `result` longtext,
  `traceback` longtext,
  `runtime` double DEFAULT NULL,
  `retries` int(11) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  `worker_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `djcelery_taskstate_state_53543be4` (`state`),
  KEY `djcelery_taskstate_name_8af9eded` (`name`),
  KEY `djcelery_taskstate_tstamp_4c3f93a1` (`tstamp`),
  KEY `djcelery_taskstate_hidden_c3905e57` (`hidden`),
  KEY `djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_workerstate_id` (`worker_id`),
  CONSTRAINT `djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_workerstate_id` FOREIGN KEY (`worker_id`) REFERENCES `djcelery_workerstate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_taskstate`
--

LOCK TABLES `djcelery_taskstate` WRITE;
/*!40000 ALTER TABLE `djcelery_taskstate` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_taskstate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_workerstate`
--

DROP TABLE IF EXISTS `djcelery_workerstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_workerstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) NOT NULL,
  `last_heartbeat` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `djcelery_workerstate_last_heartbeat_4539b544` (`last_heartbeat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_workerstate`
--

LOCK TABLES `djcelery_workerstate` WRITE;
/*!40000 ALTER TABLE `djcelery_workerstate` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_workerstate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_album`
--

DROP TABLE IF EXISTS `users_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_album` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `album_name` varchar(100) NOT NULL,
  `artist` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_album`
--

LOCK TABLES `users_album` WRITE;
/*!40000 ALTER TABLE `users_album` DISABLE KEYS */;
INSERT INTO `users_album` VALUES (1,'The Grey Album','Danger Mouse');
/*!40000 ALTER TABLE `users_album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_camera`
--

DROP TABLE IF EXISTS `users_camera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_camera` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cameraName` varchar(256) NOT NULL,
  `cameraLocation` varchar(256) NOT NULL,
  `cameraLat` varchar(24) NOT NULL,
  `cameraLon` varchar(24) NOT NULL,
  `c_ip` varchar(24) DEFAULT NULL,
  `c_username` varchar(100) DEFAULT NULL,
  `c_password` varchar(100) DEFAULT NULL,
  `c_token` varchar(24) DEFAULT NULL,
  `c_detectStatus` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_camera`
--

LOCK TABLES `users_camera` WRITE;
/*!40000 ALTER TABLE `users_camera` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_camera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_camerarealtime`
--

DROP TABLE IF EXISTS `users_camerarealtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_camerarealtime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cameraid` varchar(10) NOT NULL,
  `c_x` varchar(10) DEFAULT NULL,
  `c_y` varchar(10) DEFAULT NULL,
  `c_w` varchar(10) DEFAULT NULL,
  `c_h` varchar(10) DEFAULT NULL,
  `c_threshold` varchar(10) DEFAULT NULL,
  `imgurl` varchar(100) DEFAULT NULL,
  `faceid` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_camerarealtime`
--

LOCK TABLES `users_camerarealtime` WRITE;
/*!40000 ALTER TABLE `users_camerarealtime` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_camerarealtime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_camerastream`
--

DROP TABLE IF EXISTS `users_camerastream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_camerastream` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `streamUrl` varchar(200) DEFAULT NULL,
  `streamTime` varchar(256) DEFAULT NULL,
  `streamFps` varchar(256) DEFAULT NULL,
  `streamStatus` varchar(256) DEFAULT NULL,
  `startTime` varchar(256) DEFAULT NULL,
  `label` varchar(256) DEFAULT NULL,
  `cameraId_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `streamUrl` (`streamUrl`),
  KEY `users_camerastream_cameraId_id_0ce0a5e8_fk_users_camera_id` (`cameraId_id`),
  CONSTRAINT `users_camerastream_cameraId_id_0ce0a5e8_fk_users_camera_id` FOREIGN KEY (`cameraId_id`) REFERENCES `users_camera` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_camerastream`
--

LOCK TABLES `users_camerastream` WRITE;
/*!40000 ALTER TABLE `users_camerastream` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_camerastream` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_check`
--

DROP TABLE IF EXISTS `users_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `faceid` varchar(10) NOT NULL,
  `streamid` varchar(256) NOT NULL,
  `timestap` varchar(100) NOT NULL,
  `time` double DEFAULT NULL,
  `c_x` varchar(10) DEFAULT NULL,
  `c_y` varchar(10) DEFAULT NULL,
  `c_w` varchar(10) DEFAULT NULL,
  `c_h` varchar(10) DEFAULT NULL,
  `c_ip` varchar(15) DEFAULT NULL,
  `c_gender` varchar(10) DEFAULT NULL,
  `c_age` varchar(10) DEFAULT NULL,
  `c_threshold` varchar(10) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `imgurl` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_check`
--

LOCK TABLES `users_check` WRITE;
/*!40000 ALTER TABLE `users_check` DISABLE KEYS */;
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
  `mobile` varchar(11) NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `email` varchar(254) NOT NULL,
  `flag` int(11) NOT NULL,
  `face_flag` int(11) NOT NULL,
  `createDate` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_face`
--

LOCK TABLES `users_face` WRITE;
/*!40000 ALTER TABLE `users_face` DISABLE KEYS */;
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
  `imgurl` varchar(200) DEFAULT NULL,
  `userid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_faceimg_userid_id_53f4ee7b_fk_users_face_id` (`userid_id`),
  CONSTRAINT `users_faceimg_userid_id_53f4ee7b_fk_users_face_id` FOREIGN KEY (`userid_id`) REFERENCES `users_face` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_faceimg`
--

LOCK TABLES `users_faceimg` WRITE;
/*!40000 ALTER TABLE `users_faceimg` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_faceimg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_functioninterface`
--

DROP TABLE IF EXISTS `users_functioninterface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_functioninterface` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interface_id` int(11) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_functioninterf_interface_id_2c892b4c_fk_users_int` (`interface_id`),
  CONSTRAINT `users_functioninterf_interface_id_2c892b4c_fk_users_int` FOREIGN KEY (`interface_id`) REFERENCES `users_interface` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=423 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_functioninterface`
--

LOCK TABLES `users_functioninterface` WRITE;
/*!40000 ALTER TABLE `users_functioninterface` DISABLE KEYS */;
INSERT INTO `users_functioninterface` VALUES (377,378,'大数据分析'),(378,379,'人口数据分析'),(379,380,'企业数据分析'),(380,381,'水电气数据分析'),(381,382,'快递数据分析'),(382,383,'社保数据分析'),(383,384,'周数据分析'),(384,385,'三维立体警务巡防中心'),(385,386,'监控中心'),(386,387,'实时监控'),(387,388,'实时监控显示'),(388,389,'地图布控显示'),(389,390,'监控管理'),(390,391,'历史监控查询'),(391,392,'人车情报研判中心'),(392,393,'轨迹追踪中心'),(393,394,'地图轨迹融合'),(394,395,'人像轨迹搜索'),(395,396,'视频结构化中心'),(396,397,'预警事件中心'),(397,398,'预警事件查询'),(398,399,'预警事件管理'),(399,400,'预警事件类型管理'),(400,401,'信息综合应用平台'),(401,402,'4G指挥调度平台'),(402,403,'天迹'),(403,404,'盐城市数据分析平台'),(404,405,'壹零智慧物业综合管理系统'),(405,406,'公共上网管控系统'),(406,407,'系统管理'),(407,408,'系统用户管理'),(408,409,'用户管理'),(409,410,'权限管理'),(410,411,'菜单管理'),(411,412,'数据库管理'),(412,413,'人口数据库'),(413,414,'摄像头数据库'),(414,415,'车辆数据库'),(415,416,'归档视频'),(416,417,'日志管理'),(417,418,'登录日志'),(418,419,'操作日志'),(419,420,'异常日志'),(420,421,'系统设置'),(421,422,'水印设置'),(422,423,'陌生人口数据库');
/*!40000 ALTER TABLE `users_functioninterface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_interface`
--

DROP TABLE IF EXISTS `users_interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_interface` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `path` varchar(128) NOT NULL,
  `method` varchar(32) DEFAULT NULL,
  `description` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=424 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_interface`
--

LOCK TABLES `users_interface` WRITE;
/*!40000 ALTER TABLE `users_interface` DISABLE KEYS */;
INSERT INTO `users_interface` VALUES (378,'大数据分析','/big',NULL,NULL),(379,'人口数据分析','/people-analyse',NULL,NULL),(380,'企业数据分析','/enterprise-analyse',NULL,NULL),(381,'水电气数据分析','/wea-analyse',NULL,NULL),(382,'快递数据分析','/express-analyse',NULL,NULL),(383,'社保数据分析','/ss-analyse',NULL,NULL),(384,'周数据分析','/week-analyse',NULL,NULL),(385,'三维立体警务巡防中心','/center',NULL,NULL),(386,'监控中心','/',NULL,NULL),(387,'实时监控','/',NULL,NULL),(388,'实时监控显示','/liveview',NULL,NULL),(389,'地图布控显示','/real-video',NULL,NULL),(390,'监控管理','/',NULL,NULL),(391,'历史监控查询','/stream-list',NULL,NULL),(392,'人车情报研判中心','/testws',NULL,NULL),(393,'轨迹追踪中心','/',NULL,NULL),(394,'地图轨迹融合','/multiline',NULL,NULL),(395,'人像轨迹搜索','/face-match',NULL,NULL),(396,'视频结构化中心','/structured_video',NULL,NULL),(397,'预警事件中心','/early',NULL,NULL),(398,'预警事件查询','/warning-query',NULL,NULL),(399,'预警事件管理','/early-warning',NULL,NULL),(400,'预警事件类型管理','/early-warning-type',NULL,NULL),(401,'信息综合应用平台','/demo/frame',NULL,NULL),(402,'4G指挥调度平台','/demo/frame/d2-doc',NULL,NULL),(403,'天迹','/demo/frame/tianji',NULL,NULL),(404,'盐城市数据分析平台','/demo/frame/dataanalyse',NULL,NULL),(405,'壹零智慧物业综合管理系统','/demo/frame/wuye',NULL,NULL),(406,'公共上网管控系统','/demo/frame/ggswgk',NULL,NULL),(407,'系统管理','/manage',NULL,NULL),(408,'系统用户管理','/',NULL,NULL),(409,'用户管理','/user',NULL,NULL),(410,'权限管理','/userPermission',NULL,NULL),(411,'菜单管理','/userMenu',NULL,NULL),(412,'数据库管理','/',NULL,NULL),(413,'人口数据库','/face-list',NULL,NULL),(414,'摄像头数据库','/camera-detect',NULL,NULL),(415,'车辆数据库','/whitelist-database',NULL,NULL),(416,'归档视频','/camera-database',NULL,NULL),(417,'日志管理','/',NULL,NULL),(418,'登录日志','/sys-log-login',NULL,NULL),(419,'操作日志','/sys-log-operation',NULL,NULL),(420,'异常日志','/sys-log-error',NULL,NULL),(421,'系统设置','/',NULL,NULL),(422,'水印设置','/watermark',NULL,NULL),(423,'陌生人口数据库','/stranger-list',NULL,NULL);
/*!40000 ALTER TABLE `users_interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_loginrecord`
--

DROP TABLE IF EXISTS `users_loginrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_loginrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_username` varchar(100) DEFAULT NULL,
  `login_op` varchar(100) DEFAULT NULL,
  `login_status` int(11) DEFAULT NULL,
  `login_ip` varchar(100) DEFAULT NULL,
  `login_useragent` varchar(256) DEFAULT NULL,
  `login_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_loginrecord`
--

LOCK TABLES `users_loginrecord` WRITE;
/*!40000 ALTER TABLE `users_loginrecord` DISABLE KEYS */;
INSERT INTO `users_loginrecord` VALUES (1,'test888','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-09 18:46:46.003526'),(2,'test888','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-09 19:02:40.367365'),(3,'test888','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 10:32:21.924431'),(4,'test888','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:31:22.517835'),(5,'tom','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:34:26.509131'),(6,'tom','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:35:03.374087'),(7,'tom','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:36:01.471459'),(8,'test888','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:36:16.874285'),(9,'xiaoli','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:36:49.281023'),(10,'test888','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:38:28.137750'),(11,'xiaoli','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:39:09.510557'),(12,'xiaoli','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:40:17.450917'),(13,'tom','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:41:00.124323'),(14,'test888','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:41:16.124362'),(15,'tom','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:42:09.631068'),(16,'test888','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:42:27.807431'),(17,'hh','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:43:12.172617'),(18,'lele','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:43:32.458287'),(19,'test999','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:43:48.295980'),(20,'mingming','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:44:07.258578'),(21,'jiale','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:44:36.354556'),(22,'test888','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:45:24.102434'),(23,'test888','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:47:45.257275'),(24,'admin','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:49:54.895825'),(25,'test999','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:50:15.353393'),(26,'mingming','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:52:09.305246'),(27,'test888','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:53:49.417131'),(28,'mingming','登录',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-10 11:55:16.232278'),(29,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 16:57:25.289006'),(30,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 17:02:58.104018'),(31,'test','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 17:11:55.386781'),(32,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 17:12:07.177187'),(33,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 17:12:18.571805'),(34,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 17:15:52.543555'),(35,'test888','登录',1,'192.17.1.30','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/79.0.3945.79 Chrome/79.0.3945.79 Safari/537.36','2020-01-13 17:19:16.735769'),(36,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 17:37:38.686970'),(37,'xiaoli','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 17:47:51.171574'),(38,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 17:48:17.725027'),(39,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 17:48:27.191381'),(40,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 17:58:47.622088'),(41,'tom','登录',1,'192.17.1.30','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/79.0.3945.79 Chrome/79.0.3945.79 Safari/537.36','2020-01-13 18:04:35.430363'),(42,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:05:33.278451'),(43,'joly','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:06:27.695593'),(44,'joly','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:07:52.537776'),(45,'test888','登录',0,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:08:27.623533'),(46,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:08:32.871260'),(47,'joly','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:09:11.466970'),(48,'test999','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:18:38.489036'),(49,'joly','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:19:07.385122'),(50,'joly','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:19:57.282264'),(51,'joly','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:24:24.747433'),(52,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:24:52.888314'),(53,'tom','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:30:51.302304'),(54,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:31:12.147272'),(55,'tom','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:32:06.373403'),(56,'test888','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:32:24.756023'),(57,'tom','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:32:49.944773'),(58,'tom','登录',1,'192.17.1.39','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-13 18:47:52.342977'),(59,'test888','登录',1,'192.17.1.30','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/79.0.3945.79 Chrome/79.0.3945.79 Safari/537.36','2020-01-13 18:49:09.576399'),(60,'test999','登录',1,'192.17.1.30','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/79.0.3945.79 Chrome/79.0.3945.79 Safari/537.36','2020-01-13 18:50:14.041163'),(61,'test999','登录',1,'192.17.1.30','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/79.0.3945.79 Chrome/79.0.3945.79 Safari/537.36','2020-01-13 18:50:44.598657'),(62,'test888','登录',1,'192.17.1.30','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/79.0.3945.79 Chrome/79.0.3945.79 Safari/537.36','2020-01-13 18:51:53.871846');
/*!40000 ALTER TABLE `users_loginrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_matchup`
--

DROP TABLE IF EXISTS `users_matchup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_matchup` (
  `person_id` varchar(24) DEFAULT NULL,
  `faceid` varchar(10) NOT NULL,
  `c_threshold` varchar(10) NOT NULL,
  `dec_img_url` varchar(100) NOT NULL,
  PRIMARY KEY (`faceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_matchup`
--

LOCK TABLES `users_matchup` WRITE;
/*!40000 ALTER TABLE `users_matchup` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_matchup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_menu`
--

DROP TABLE IF EXISTS `users_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `path` varchar(128) NOT NULL,
  `icon` varchar(128) DEFAULT NULL,
  `permission_id` int(11) DEFAULT NULL,
  `mtype` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `isLock` tinyint(1) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `users_menu_parent_id_a950e742_fk_users_menu_id` (`parent_id`),
  KEY `users_menu_permission_id_2f8a2f39` (`permission_id`),
  CONSTRAINT `users_menu_parent_id_a950e742_fk_users_menu_id` FOREIGN KEY (`parent_id`) REFERENCES `users_menu` (`id`),
  CONSTRAINT `users_menu_permission_id_2f8a2f39_fk_users_functioninterface_id` FOREIGN KEY (`permission_id`) REFERENCES `users_functioninterface` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=428 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_menu`
--

LOCK TABLES `users_menu` WRITE;
/*!40000 ALTER TABLE `users_menu` DISABLE KEYS */;
INSERT INTO `users_menu` VALUES (382,'大数据分析','/big','linode',377,NULL,1,0,NULL,1),(383,'人口数据分析','/people-analyse','tint',378,NULL,2,0,382,1),(384,'企业数据分析','/enterprise-analyse','tint',379,NULL,2,0,382,2),(385,'水电气数据分析','/wea-analyse','tint',380,NULL,2,0,382,3),(386,'快递数据分析','/express-analyse','tint',381,NULL,2,0,382,4),(387,'社保数据分析','/ss-analyse','tint',382,NULL,2,0,382,5),(388,'周数据分析','/week-analyse','tint',383,NULL,2,0,382,6),(389,'三维立体警务巡防中心','/center','futbol-o',384,NULL,1,0,NULL,2),(390,'监控中心','/monitor-center','universal-access',385,NULL,2,0,389,1),(391,'实时监控','/real-monitor','television',386,NULL,3,0,390,4),(392,'实时监控显示','/liveview','play',387,NULL,3,0,390,1),(393,'地图布控显示','/real-video','support',388,NULL,3,0,390,2),(394,'监控管理','/monitor-manage','yelp',389,NULL,3,0,390,5),(395,'历史监控查询','/stream-list','magic',390,NULL,3,0,390,3),(396,'人车情报研判中心','/testws','camera',391,NULL,2,0,389,2),(397,'轨迹追踪中心','/tracking-center','paper-plane',392,NULL,2,0,389,3),(398,'地图轨迹融合','/multiline','yelp',393,NULL,3,0,397,1),(399,'人像轨迹搜索','/face-match','newspaper-o',394,NULL,3,0,397,2),(400,'视频结构化中心','/structured_video','gg-circle',395,NULL,2,0,389,4),(401,'预警事件中心','/early','bell-o',396,NULL,1,0,NULL,3),(402,'预警事件查询','/warning-query','share-alt-square',397,NULL,2,0,401,1),(403,'预警事件管理','/early-warning','bell',398,NULL,2,0,401,2),(404,'预警事件类型管理','/early-warning-type','bell',399,NULL,2,0,401,3),(405,'信息综合应用平台','/demo/frame','globe',400,NULL,1,0,NULL,4),(406,'4G指挥调度平台','/demo/frame/d2-doc','dot-circle-o',401,NULL,2,0,405,1),(407,'天迹','/demo/frame/tianji','dot-circle-o',402,NULL,2,0,405,2),(408,'盐城市数据分析平台','/demo/frame/dataanalyse','dot-circle-o',403,NULL,2,0,405,3),(409,'壹零智慧物业综合管理系统','/demo/frame/wuye','dot-circle-o',404,NULL,2,0,405,4),(410,'公共上网管控系统','/demo/frame/ggswgk','dot-circle-o',405,NULL,2,0,405,5),(411,'系统管理','/manage','gear',406,NULL,1,0,NULL,5),(412,'系统用户管理','/system-user','user',407,NULL,2,0,411,1),(413,'用户管理','/user','user',408,NULL,3,0,412,1),(414,'权限管理','/userPermission','user',409,NULL,3,0,412,2),(415,'菜单管理','/userMenu','user',410,NULL,3,0,412,3),(416,'数据库管理','/database-manage','database',411,NULL,2,0,411,2),(417,'人口数据库','/face-list','address-card',412,NULL,3,0,416,1),(418,'摄像头数据库','/camera-detect','video-camera',413,NULL,3,0,416,2),(419,'车辆数据库','/whitelist-database','cubes',414,NULL,3,0,416,3),(420,'归档视频','/camera-database','cubes',415,NULL,3,0,416,4),(421,'日志管理','/log-manage','file-text',416,NULL,2,0,411,3),(422,'登录日志','/sys-log-login','file-word-o',417,NULL,3,0,421,1),(423,'操作日志','/sys-log-operation','file-archive-o',418,NULL,3,0,421,2),(424,'异常日志','/sys-log-error','file-o',419,NULL,3,0,421,3),(425,'系统设置','/system-manage','bookmark',420,NULL,2,0,411,4),(426,'水印设置','/watermark','bookmark',421,NULL,3,0,425,1),(427,'陌生人口数据库','stranger-list','video-camera',422,NULL,3,0,416,4);
/*!40000 ALTER TABLE `users_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_operationrecord`
--

DROP TABLE IF EXISTS `users_operationrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_operationrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation_username` varchar(100) DEFAULT NULL,
  `operation_op` varchar(100) DEFAULT NULL,
  `operation_method` varchar(100) DEFAULT NULL,
  `operation_params` varchar(200) DEFAULT NULL,
  `operation_url` varchar(100) DEFAULT NULL,
  `operation_status` int(11) DEFAULT NULL,
  `operation_ip` varchar(100) DEFAULT NULL,
  `operation_useragent` varchar(200) DEFAULT NULL,
  `operation_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_operationrecord`
--

LOCK TABLES `users_operationrecord` WRITE;
/*!40000 ALTER TABLE `users_operationrecord` DISABLE KEYS */;
INSERT INTO `users_operationrecord` VALUES (1,'test888',NULL,'GET','token=8fede064e6b84574952717ed13c2837b0adbcf2b&order=&orderField=&page=1&limit=10&username=&_t=1578567095451','/api/face',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-09 18:51:37.073160'),(2,'test888',NULL,'GET','token=8fede064e6b84574952717ed13c2837b0adbcf2b&order=&orderField=&page=1&limit=10&creatorName=&status=&_t=1578567163962','/sys/log/login/page',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-09 18:52:46.184660'),(3,'test888',NULL,'GET','token=8fede064e6b84574952717ed13c2837b0adbcf2b&order=&orderField=&page=1&limit=10&status=&_t=1578567165896','/sys/log/operation/page',1,'192.17.1.2','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36','2020-01-09 18:52:47.500344');
/*!40000 ALTER TABLE `users_operationrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_permission`
--

DROP TABLE IF EXISTS `users_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `function_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_permission_function_id_0a75a177_fk_users_fun` (`function_id`),
  KEY `users_permission_role_id_54f94e01_fk_users_role_id` (`role_id`),
  CONSTRAINT `users_permission_function_id_0a75a177_fk_users_fun` FOREIGN KEY (`function_id`) REFERENCES `users_functioninterface` (`id`),
  CONSTRAINT `users_permission_role_id_54f94e01_fk_users_role_id` FOREIGN KEY (`role_id`) REFERENCES `users_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1544 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_permission`
--

LOCK TABLES `users_permission` WRITE;
/*!40000 ALTER TABLE `users_permission` DISABLE KEYS */;
INSERT INTO `users_permission` VALUES (831,377,2),(832,378,2),(833,379,2),(834,380,2),(835,381,2),(836,382,2),(837,383,2),(838,400,2),(839,401,2),(840,402,2),(841,403,2),(842,404,2),(843,405,2),(1500,377,1),(1501,378,1),(1502,379,1),(1503,380,1),(1504,381,1),(1505,382,1),(1506,383,1),(1507,384,1),(1508,385,1),(1509,387,1),(1510,388,1),(1511,390,1),(1512,391,1),(1513,392,1),(1514,393,1),(1515,394,1),(1516,395,1),(1517,396,1),(1518,397,1),(1519,398,1),(1520,399,1),(1521,400,1),(1522,401,1),(1523,402,1),(1524,403,1),(1525,404,1),(1526,405,1),(1527,406,1),(1528,407,1),(1529,408,1),(1530,409,1),(1531,410,1),(1532,411,1),(1533,412,1),(1534,413,1),(1535,414,1),(1536,415,1),(1537,416,1),(1538,417,1),(1539,418,1),(1540,419,1),(1541,420,1),(1542,421,1),(1543,422,1);
/*!40000 ALTER TABLE `users_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_persondetect`
--

DROP TABLE IF EXISTS `users_persondetect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_persondetect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` varchar(24) DEFAULT NULL,
  `c_x` varchar(10) DEFAULT NULL,
  `c_y` varchar(10) DEFAULT NULL,
  `c_w` varchar(10) DEFAULT NULL,
  `c_h` varchar(10) DEFAULT NULL,
  `c_threshold` varchar(10) DEFAULT NULL,
  `url` varchar(100) NOT NULL,
  `timestap` varchar(100) NOT NULL,
  `dec_img_url` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_persondetect`
--

LOCK TABLES `users_persondetect` WRITE;
/*!40000 ALTER TABLE `users_persondetect` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_persondetect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_personreid`
--

DROP TABLE IF EXISTS `users_personreid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_personreid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `faceid` varchar(10) NOT NULL,
  `streamid` varchar(256) NOT NULL,
  `query_imgurl` varchar(100) NOT NULL,
  `timestap` varchar(20) NOT NULL,
  `c_threshold` varchar(10) NOT NULL,
  `imgurl` varchar(100) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `time` double DEFAULT NULL,
  `c_x` varchar(10) DEFAULT NULL,
  `c_y` varchar(10) DEFAULT NULL,
  `c_w` varchar(10) DEFAULT NULL,
  `c_h` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_personreid`
--

LOCK TABLES `users_personreid` WRITE;
/*!40000 ALTER TABLE `users_personreid` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_personreid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_role`
--

DROP TABLE IF EXISTS `users_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `code` varchar(32) NOT NULL,
  `description` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_role`
--

LOCK TABLES `users_role` WRITE;
/*!40000 ALTER TABLE `users_role` DISABLE KEYS */;
INSERT INTO `users_role` VALUES (1,'超级管理员','R_MENUADMIN','管理所有人'),(2,'普通用户','2','普通用户');
/*!40000 ALTER TABLE `users_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roleuser`
--

DROP TABLE IF EXISTS `users_roleuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roleuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_roleuser_role_id_ba2c8bb1_fk_users_role_id` (`role_id`),
  KEY `users_roleuser_user_id_327a86f9_fk_auth_user_id` (`user_id`),
  CONSTRAINT `users_roleuser_role_id_ba2c8bb1_fk_users_role_id` FOREIGN KEY (`role_id`) REFERENCES `users_role` (`id`),
  CONSTRAINT `users_roleuser_user_id_327a86f9_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roleuser`
--

LOCK TABLES `users_roleuser` WRITE;
/*!40000 ALTER TABLE `users_roleuser` DISABLE KEYS */;
INSERT INTO `users_roleuser` VALUES (45,1,20),(98,1,40),(100,2,43),(101,2,44),(106,2,42),(110,2,46),(113,2,47);
/*!40000 ALTER TABLE `users_roleuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_route`
--

DROP TABLE IF EXISTS `users_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `path` varchar(128) DEFAULT NULL,
  `component` varchar(128) DEFAULT NULL,
  `componentPath` varchar(128) DEFAULT NULL,
  `icon` varchar(128) DEFAULT NULL,
  `permission_id` int(11) DEFAULT NULL,
  `mtype` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `isLock` tinyint(1) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `users_route_parent_id_f38f3ecb_fk_users_route_id` (`parent_id`),
  KEY `users_route_permission_id_ce4a492b` (`permission_id`),
  CONSTRAINT `users_route_parent_id_f38f3ecb_fk_users_route_id` FOREIGN KEY (`parent_id`) REFERENCES `users_route` (`id`),
  CONSTRAINT `users_route_permission_id_ce4a492b_fk_users_functioninterface_id` FOREIGN KEY (`permission_id`) REFERENCES `users_functioninterface` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=383 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_route`
--

LOCK TABLES `users_route` WRITE;
/*!40000 ALTER TABLE `users_route` DISABLE KEYS */;
INSERT INTO `users_route` VALUES (345,'信息综合应用平台','/demo/frame','layoutHeaderAside','layoutHeaderAside',NULL,400,0,1,1,NULL,'demo-frame'),(346,'4G指挥调度平台','/demo/frame/d2-doc','d2-doc','d2-doc',NULL,401,0,2,1,345,'d2-doc'),(347,'天迹','/demo/frame/tianji','tianji','tianji',NULL,402,0,2,1,345,'tianji'),(348,'盐城市数据分析平台','/demo/frame/dataanalyse','dataanalyse','dataanalyse',NULL,403,0,2,1,345,'dataanalyse'),(349,'壹零智慧物业综合管理系统','/demo/frame/wuye','wuye','wuye',NULL,404,0,2,1,345,'wuye'),(350,'公共上网管控系统','/demo/frame/ggswgk','ggswgk','ggswgk',NULL,405,0,2,1,345,'ggswgk'),(351,'大数据分析','/big-data','layoutHeaderAside','layoutHeaderAside',NULL,377,0,1,1,NULL,'big-data'),(352,'人口数据分析','/people-analyse','people-analyse','people-analyse',NULL,378,0,2,1,351,'people-analyse'),(353,'企业数据分析','/enterprise-analyse','enterprise-analyse','enterprise-analyse',NULL,379,0,2,1,351,'enterprise-analyse'),(354,'水电气数据分析','/wea-analyse','wea-analyse','wea-analyse',NULL,380,0,2,1,351,'wea-analyse'),(355,'快递数据分析','/express-analyse','express-analyse','express-analyse',NULL,381,0,2,1,351,'express-analyse'),(356,'社保数据分析','/ss-analyse','ss-analyse','ss-analyse',NULL,382,0,2,1,351,'ss-analyse'),(357,'周数据分析','/week-analyse','week-analyse','week-analyse',NULL,383,0,2,1,351,'week-analyse'),(358,'三维立体警务巡防中心','/public-security','layoutHeaderAside','layoutHeaderAside',NULL,384,0,1,1,NULL,'public-security'),(359,'实时监控显示','/liveview','liveview','liveview',NULL,387,0,2,1,358,'liveview'),(360,'地图布控显示','/real-video','real-video','real-video',NULL,388,0,2,1,358,'real-video'),(361,'历史监控查询','/stream-list','stream-list','stream-list',NULL,390,0,2,1,358,'stream-list'),(362,'人车情报研判中心','/testws','testws','testws',NULL,391,0,2,1,358,'testws'),(363,'地图轨迹融合','/multiline','multiline','multiline',NULL,393,0,2,1,358,'multiline'),(364,'人像轨迹搜索','/face-match','face-match','face-match',NULL,394,0,2,1,358,'face-match'),(365,'视频结构化中心','/structured_video','structured_video','structured_video',NULL,395,0,2,1,358,'structured_video'),(366,'预警事件中心','/early-warning','layoutHeaderAside','layoutHeaderAside',NULL,396,0,1,1,NULL,'early-warning'),(367,'预警事件管理','/early-warning','early-warning','early-warning',NULL,398,0,2,1,366,'early-warning-manage'),(368,'预警事件查询','/warning-query','warning-query','warning-query',NULL,397,0,2,1,366,'warning-query'),(369,'预警事件类型管理','/early-warning-type','early-warning-type','early-warning-type',NULL,399,0,2,1,366,'early-warning-type'),(370,'系统管理','/manage-system','layoutHeaderAside','layoutHeaderAside',NULL,406,0,1,1,NULL,'manage-system'),(371,'用户管理','/user','user','user',NULL,408,0,2,1,370,'user'),(372,'权限管理','/userPermission','userPermission','userPermission',NULL,409,0,2,1,370,'userPermission'),(373,'菜单管理','/userMenu','userMenu','userMenu',NULL,410,0,2,1,370,'userMenu'),(374,'人口数据库','/face-list','face-list','face-list',NULL,412,0,2,1,370,'face-list'),(375,'摄像头数据库','/camera-detect','camera-detect','camera-detect',NULL,413,0,2,1,370,'camera-detect'),(376,'车辆数据库','/whitelist-database','whitelist-database','whitelist-database',NULL,414,0,2,1,370,'whitelist-database'),(377,'归档视频','/camera-database','camera-database','camera-database',NULL,415,0,2,1,370,'camera-database'),(378,'登录日志','/sys-log-login','log-login','log-login',NULL,417,0,2,1,370,'log-login'),(379,'操作日志','/sys-log-operation','log-operation','log-operation',NULL,418,0,2,1,370,'log-operation'),(380,'异常日志','/sys-log-error','log-error','log-error',NULL,419,0,2,1,370,'log-error'),(381,'水印设置','/watermark','watermark','watermark',NULL,421,0,2,1,370,'watermark'),(382,'陌生人口数据库','/stranger-list','stranger-list','views/modules/face/stranger',NULL,422,0,2,1,370,'stranger-list');
/*!40000 ALTER TABLE `users_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_stranger`
--

DROP TABLE IF EXISTS `users_stranger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_stranger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `faceid` varchar(10) NOT NULL,
  `c_gender` varchar(10) DEFAULT NULL,
  `c_age` varchar(10) DEFAULT NULL,
  `imgurl` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_stranger`
--

LOCK TABLES `users_stranger` WRITE;
/*!40000 ALTER TABLE `users_stranger` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_stranger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_stream`
--

DROP TABLE IF EXISTS `users_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_stream` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `streamname` varchar(50) NOT NULL,
  `streamlocation` varchar(100) NOT NULL,
  `streamurl` varchar(256) NOT NULL,
  `streamlat` varchar(24) NOT NULL,
  `streamlon` varchar(24) NOT NULL,
  `flag` int(11) NOT NULL,
  `createDate` datetime(6) NOT NULL,
  `streamtime` varchar(256) DEFAULT NULL,
  `streamfps` varchar(256) DEFAULT NULL,
  `streamstatus` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `streamname` (`streamname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_stream`
--

LOCK TABLES `users_stream` WRITE;
/*!40000 ALTER TABLE `users_stream` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_stream` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_track`
--

DROP TABLE IF EXISTS `users_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_track` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `duration` int(11) NOT NULL,
  `album_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_track_album_id_order_f16fc8f3_uniq` (`album_id`,`order`),
  CONSTRAINT `users_track_album_id_0d60aca1_fk_users_album_id` FOREIGN KEY (`album_id`) REFERENCES `users_album` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_track`
--

LOCK TABLES `users_track` WRITE;
/*!40000 ALTER TABLE `users_track` DISABLE KEYS */;
INSERT INTO `users_track` VALUES (1,1,'Public Service Announcement',245,1),(2,2,'What More Can I Say',264,1),(3,3,'Encore',159,1);
/*!40000 ALTER TABLE `users_track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userextrainfo`
--

DROP TABLE IF EXISTS `users_userextrainfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_userextrainfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(128) DEFAULT NULL,
  `real_name` varchar(128) DEFAULT NULL,
  `phone` varchar(128) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `gender` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_userextrainfo_user_id_b4a036e7_fk_auth_user_id` (`user_id`),
  CONSTRAINT `users_userextrainfo_user_id_b4a036e7_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userextrainfo`
--

LOCK TABLES `users_userextrainfo` WRITE;
/*!40000 ALTER TABLE `users_userextrainfo` DISABLE KEYS */;
INSERT INTO `users_userextrainfo` VALUES (8,NULL,'test888','11111111111',20,'man'),(28,NULL,'test999','12345678911',40,'0'),(30,NULL,'Lixiaoli','18896722430',42,'0'),(31,NULL,'Liming','18896722430',43,'0'),(32,NULL,'赵家乐','18896722430',44,'0'),(34,NULL,'tom','11122223333',46,'0'),(35,NULL,'joly','11177778888',47,'0');
/*!40000 ALTER TABLE `users_userextrainfo` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_verifycode`
--

LOCK TABLES `users_verifycode` WRITE;
/*!40000 ALTER TABLE `users_verifycode` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_verifycode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_warningevent`
--

DROP TABLE IF EXISTS `users_warningevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_warningevent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warning_id` varchar(100) DEFAULT NULL,
  `warning_name` varchar(100) DEFAULT NULL,
  `warning_people_max` varchar(100) DEFAULT NULL,
  `warning_car_max` varchar(100) DEFAULT NULL,
  `warning_target_people` varchar(100) DEFAULT NULL,
  `warning_target_car` varchar(100) DEFAULT NULL,
  `warning_target_camera` varchar(100) DEFAULT NULL,
  `warning_event_flag` int(11) DEFAULT NULL,
  `warning_event_time` datetime(6) NOT NULL,
  `warning_type_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_warningevent_warning_type_id_id_45302368_fk_users_war` (`warning_type_id_id`),
  CONSTRAINT `users_warningevent_warning_type_id_id_45302368_fk_users_war` FOREIGN KEY (`warning_type_id_id`) REFERENCES `users_warningtype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_warningevent`
--

LOCK TABLES `users_warningevent` WRITE;
/*!40000 ALTER TABLE `users_warningevent` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_warningevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_warninghistory`
--

DROP TABLE IF EXISTS `users_warninghistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_warninghistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warning_color` int(11) NOT NULL,
  `warning_camera_id` varchar(100) DEFAULT NULL,
  `warning_time` datetime(6) NOT NULL,
  `warning_video_url` varchar(150) DEFAULT NULL,
  `warning_message` varchar(250) DEFAULT NULL,
  `warning_capture_url` varchar(250) DEFAULT NULL,
  `warning_target_url` varchar(250) DEFAULT NULL,
  `warning_event_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_warninghistory_warning_event_id_id_9c5a8d02_fk_users_war` (`warning_event_id_id`),
  CONSTRAINT `users_warninghistory_warning_event_id_id_9c5a8d02_fk_users_war` FOREIGN KEY (`warning_event_id_id`) REFERENCES `users_warningevent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_warninghistory`
--

LOCK TABLES `users_warninghistory` WRITE;
/*!40000 ALTER TABLE `users_warninghistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_warninghistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_warningtype`
--

DROP TABLE IF EXISTS `users_warningtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_warningtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warning_level` int(11) NOT NULL,
  `warning_type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_warningtype`
--

LOCK TABLES `users_warningtype` WRITE;
/*!40000 ALTER TABLE `users_warningtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_warningtype` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-16 10:13:59
