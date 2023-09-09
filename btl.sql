-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: btl
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (13,'Ẩm thực',''),(14,'Quần áo',''),(15,'giày dép',''),(16,'Vật dùng cá nhân',''),(17,'Đồ điện tử',''),(18,'Điện thoại',''),(19,'Đồ chơi','');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_idx` (`product_id`),
  KEY `fk_user_idx` (`user_id`),
  CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (6,'dấda',10,22,'2023-09-09 00:00:00');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `unit_price` decimal(10,0) DEFAULT '0',
  `num` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_ORDERDETAIL_ORDER_idx` (`order_id`),
  KEY `FK_ORDERDETAIL_PRODUCT_idx` (`product_id`),
  CONSTRAINT `FK_ORDERDETAIL_ORDER` FOREIGN KEY (`order_id`) REFERENCES `sale_order` (`id`),
  CONSTRAINT `FK_ORDERDETAIL_PRODUCT` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (26,14,21,15000000,'34'),(27,15,21,15000000,'3'),(28,16,21,15000000,'4'),(29,16,22,10000000,'1'),(30,17,23,NULL,'2');
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_tag`
--

DROP TABLE IF EXISTS `prod_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `f1_idx` (`product_id`),
  KEY `f2_idx` (`tag_id`),
  CONSTRAINT `f1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `f2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_tag`
--

LOCK TABLES `prod_tag` WRITE;
/*!40000 ALTER TABLE `prod_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `price` decimal(10,0) DEFAULT '0',
  `manufacturer` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `image` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `active` bit(1) DEFAULT b'1',
  `category_id` int NOT NULL,
  `shop_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PRODUCE_CATEGORY_idx` (`category_id`),
  KEY `FK_PRODUCE_SHOP_idx` (`shop_id`),
  CONSTRAINT `FK_PRODUCE_CATEGORY` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_PRODUCE_SHOP` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (21,'Iphone 13','iphoneeeeeeeeeee',15000000,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1693929226/bvgpm01dpwtcpigdi3ft.webp',NULL,_binary '',18,1),(22,'Jodan 1','Air Jodan 1',10000000,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1693929416/mlaftaejw9fafc8qbvmc.jpg',NULL,_binary '',15,1),(23,'Chuối','trái cây',15000,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694242288/fkvkcsjzbwdfxsjeos25.jpg',NULL,_binary '',13,1),(24,'Nho','trái cây',10000,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694239496/fja1fbgjl78qcda7q2mj.jpg',NULL,NULL,13,1),(25,'Táo','trái cây',15000,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694241520/pm8nglfvyaa9iekpw0rr.jpg',NULL,_binary '',13,1),(26,'Bàn chải đánh răng','Bàn chải đánh răng',10000,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694242134/l38bsdxftoxdcb68hcyk.png',NULL,_binary '',16,1),(27,'Bàn chải đánh răng','Bàn chải đánh răng',10000,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694242159/kcvoqt2zyvfaanujt0sa.png',NULL,_binary '',16,1),(28,'1','2',12321321,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262366/mw3dtgwu0af8dxtzd4vw.png',NULL,_binary '',13,23),(29,'ưqeq','rưq',131231,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262483/si8s7arfpk0cgssfbgor.png',NULL,_binary '',13,23),(30,'đas','2eeqweq',111111,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262540/aykbncrjrsjbdzsrhasf.jpg',NULL,_binary '',13,23),(31,'xzcxz','xdz',13131311,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262557/thhyfnibrgvgg4ghikw9.jpg',NULL,_binary '',13,23),(32,'dsdsa','aewqeq',13131,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262598/heswfjlgozqeg1apgdh3.jpg',NULL,_binary '',13,24),(33,'dsadsa','2321',1231231,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262628/ekmziwoltxwqlnhzp6o7.jpg',NULL,_binary '',13,24),(34,'dsada','eadcx',54353,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262642/cu3dgrhjrnmdsersazfa.jpg',NULL,_binary '',13,24),(35,'đấ','76575',45747474,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262658/pnlw3f9zw3ih6p33oasc.png',NULL,_binary '',13,24),(36,'vxcvx','gdfgd',18456,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262679/f0rkfy8scgjeyjcbsoba.jpg',NULL,_binary '',13,24),(37,'456','789',123132,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262694/lmfbqi8sgk0liz9hgkun.jpg',NULL,_binary '',13,24),(38,'czxcz','dsada',598998,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262713/vi8cxwpj3y48af4u8gop.jpg',NULL,_binary '',13,24),(39,'dd','q',123,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262732/uthy32a8n4l9dxbyxehi.jpg',NULL,_binary '',13,24),(40,'1','2',321,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262745/fuhf0wfyo17mbramip6k.jpg',NULL,_binary '',13,24),(41,'c','c',123,NULL,'https://res.cloudinary.com/dokoicpvp/image/upload/v1694262766/gpgpjxjojcyccakfc290.jpg',NULL,_binary '',13,24);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_order`
--

DROP TABLE IF EXISTS `sale_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,0) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ORDER_USER_idx` (`user_id`),
  CONSTRAINT `FK_ORDER_USER` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_order`
--

LOCK TABLES `sale_order` WRITE;
/*!40000 ALTER TABLE `sale_order` DISABLE KEYS */;
INSERT INTO `sale_order` VALUES (14,NULL,'2023-09-08 07:57:57',11),(15,NULL,'2023-09-08 21:53:50',16),(16,NULL,'2023-09-08 22:09:34',16),(17,NULL,'2023-09-09 12:41:35',16);
/*!40000 ALTER TABLE `sale_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop`
--

DROP TABLE IF EXISTS `shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` varchar(45) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_SHOP_USER_idx` (`user_id`),
  CONSTRAINT `FK_SHOP_USER` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop`
--

LOCK TABLES `shop` WRITE;
/*!40000 ALTER TABLE `shop` DISABLE KEYS */;
INSERT INTO `shop` VALUES (1,'cửa hàng số 19','cửa hàng',16),(2,'cửa hàng số 2','cửa hàng',16),(3,'a','a',16),(4,'a','a',16),(5,'q','q',16),(6,'q','q',16),(7,'q','q',16),(8,'t','t',16),(9,'k','k',16),(10,'v','v',16),(11,'f','f',16),(12,'a','b',16),(13,'bc','bc',16),(14,'f','f',16),(15,'c','c',16),(16,'1','1',16),(17,'cửa hàng số 18','',16),(18,'cửa hàng số 56','',16),(19,'q','q',16),(20,'cửa hàng số 1','cửa hàng',16),(21,'cửa hàng số 12','cửa hàng 3',16),(22,'c','c',16),(23,'cửa hàng của k1','cửa hàng của k1',18),(24,'Cửa hàng của k1 số 2','Cửa hàng của k1',18);
/*!40000 ALTER TABLE `shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tagcol` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `active` bit(1) DEFAULT b'1',
  `avatar` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_role` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (10,'C','A B','abc@gmail.com','012345678','abc','$2a$10$Bkg8bdtXMEXd8gVDsySMdexkYZReU3Rvzl7pmIEyN/4qBpRctd8jO',_binary '','https://res.cloudinary.com/dokoicpvp/image/upload/v1693927381/h9gr5raa2plemztiuo4d.jpg','ROLE_STAFF'),(11,'Tú','Lê Quốc','1851050175tu@ou.edu.vn','012345678','admin','$2a$10$i7iyrzvAnipHDDVQHyVMJe75/Zn0Rj7YPTEj5JH62O6Aw07t0XT2O',_binary '','https://res.cloudinary.com/dokoicpvp/image/upload/v1693927779/hjlqdlphwnqhdrfmc8p8.webp','ROLE_ADMIN'),(12,'ad','ad','ad@gmail.com','0123456789','ad','$2a$10$dStTp4ADPK4jTHevdDKPSuLmdKOyv1c9I6RpB7QC1ZwF7b3uKTD1W',_binary '','https://res.cloudinary.com/dokoicpvp/image/upload/v1694101283/lxnxjvwvoux2bzkc4dzq.webp','ROLE_USER'),(13,'ab','ab','ab@gmail.com','0123456789','ab','$2a$10$gADPqgiC6Vfy3TxSLqo0q.yC4rg6Jo1zq4UwJkvMZJ4zWnV2RBDT.',_binary '','https://res.cloudinary.com/dokoicpvp/image/upload/v1694101374/rogvhhxtjqtkbqqewxbl.webp','ROLE_USER'),(14,'q','q','q@gmail.com','1','q','$2a$10$rA1IM3nxVWx5zjKvO30mXuLaIPh1LA/9aH9U0l1IEGIuzkTkX6IiK',_binary '','https://res.cloudinary.com/dokoicpvp/image/upload/v1694101501/brzmsnsftosff7ly8hot.webp','ROLE_USER'),(15,'e','e','e@gmail.com','0123','e','$2a$10$KFzL4I80si9FPzlCOfTafeTxjrpLEe4YJX3OEQxZw/bT/kZ4mTCHm',_binary '','https://res.cloudinary.com/dokoicpvp/image/upload/v1694101982/h8c1po7zspcddlpd2lyp.webp','ROLE_USER'),(16,'t','t','t@gmail.com','1','t','$2a$10$hnHTE2SdGzKJVRo2ZZu7LOGR9Ye.DO.BjaHr46WtI.WSVWoSbmRI2',_binary '','https://res.cloudinary.com/dokoicpvp/image/upload/v1694103210/zja1knqepkqgwash5itb.webp','ROLE_SALE'),(17,'f','f','f@gmail.com','1','f','$2a$10$Z.JetU1Dte6vYZc0MKn6HejY86wkut9813HqanL2/IooD56qFb.r.',_binary '','https://res.cloudinary.com/dokoicpvp/image/upload/v1694231520/lblh2nqjs5tbzvhfc9hr.webp','ROLE_USER'),(18,'k1','k1','k1@gmail.com','1','k1','$2a$10$2lBpF35wzTfJLOAmD0RLpuIojHsrLX2V/J9kmBhHH1Y22seqpY3LC',_binary '','https://res.cloudinary.com/dokoicpvp/image/upload/v1694243686/b4plpjr4cbusvvxxc3iw.webp','ROLE_SALE');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-09 19:35:39
