-- Create application user and grant privileges
CREATE USER IF NOT EXISTS 'ecommerceapp'@'localhost' IDENTIFIED BY 'ecommerceapp';
GRANT ALL PRIVILEGES ON `full-stack-ecommerce`.* TO 'ecommerceapp'@'localhost';
FLUSH PRIVILEGES;

CREATE DATABASE  IF NOT EXISTS `full-stack-ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `full-stack-ecommerce`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: full-stack-ecommerce
-- ------------------------------------------------------
-- Server version	8.4.7

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Wiesbaden','Deutschland','Hessen','Musterstraße 72','65201'),(2,'Linz','Österreich','Oberösterreich','Hauptstraße 1','4030'),(3,'Bad Kreuznach','Deutschland','Rheinland-Pfalz','Sonnenstraße 28','55543'),(4,'Mainz','Deutschland','Rheinland-Pfalz','Mondstraße 13','55118'),(5,'Berlin','Deutschland','Berlin','cc','12345'),(6,'Berlin','Deutschland','Berlin','dd','12345'),(7,'dd','Schweiz','Aargau','cc','11111'),(8,'Teststadt','Österreich','Steiermark','ee','2222'),(9,'bb','Österreich','Burgenland','aa','9999'),(10,'dd','Schweiz','Aargau','cc','8888');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` smallint unsigned NOT NULL,
  `code` varchar(2) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'DE','Deutschland'),(2,'AT','Österreich'),(3,'CH','Schweiz');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `email_2` (`email`),
  UNIQUE KEY `email_3` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Dustin','Vetter','dustinvetter@icloud.com','$2a$10$mXJGVFllMLOmoXkCObc6K.QciI9f1kmeRIT75Koi/4JNzxUY7DhWq','ROLE_ADMIN'),(2,'Dustin','Vetter','dustinvetter@icloud.om','$2a$10$4L0o/AuLMapwg6n9/TApNuIt3/z7./lLR6118eBS/HqXDd8oDhilC','ROLE_USER'),(3,'Dustin','Vetter','dustinvetter@icloud','$2a$10$FQ4ymtwmeGLgJw26UaF0xOrYKRIlvqrxWBVXkMDt2YollvJS6LRha','ROLE_USER');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(19,2) DEFAULT NULL,
  `order_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `K_order_id` (`order_id`),
  KEY `FK_product_id` (`product_id`),
  CONSTRAINT `FK_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `FK_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,'assets/images/products/art-blau-3020.png',1,99.99,1,70),(2,'assets/images/products/art-gruen-2003.png',2,99.99,1,28),(3,'assets/images/products/art-gruen-2005.png',1,249.99,1,30),(4,'assets/images/products/art-rot-1002.png',1,149.99,1,2),(5,'assets/images/products/art-bunt-4014.png',1,89.99,1,89),(6,'assets/images/products/art-rot-1004.png',1,79.99,2,4),(7,'assets/images/products/art-rot-1003.png',1,99.99,2,3),(8,'assets/images/products/art-rot-1002.png',1,149.99,2,2),(9,'assets/images/products/art-rot-1001.png',1,79.99,2,1),(10,'assets/images/products/art-gruen-2011.png',1,79.99,3,36),(11,'assets/images/products/art-blau-3023.png',1,99.99,3,73),(12,'assets/images/products/art-bunt-4025.png',1,279.99,3,100),(13,'assets/images/products/art-blau-3023.png',1,99.99,4,73),(14,'assets/images/products/art-bunt-4025.png',1,279.99,4,100),(15,'assets/images/products/art-gruen-2011.png',1,79.99,4,36),(16,'assets/images/products/art-gruen-2011.png',1,79.99,5,36),(17,'assets/images/products/art-bunt-4025.png',1,279.99,5,100),(18,'assets/images/products/art-gruen-2018.png',1,249.99,5,43),(19,'assets/images/products/art-blau-3023.png',1,99.99,5,73),(20,'assets/images/products/art-gruen-2017.png',1,79.99,5,42);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_tracking_number` varchar(255) DEFAULT NULL,
  `total_price` decimal(19,2) DEFAULT NULL,
  `total_quantity` int DEFAULT NULL,
  `billing_address_id` bigint DEFAULT NULL,
  `customer_id` bigint DEFAULT NULL,
  `shipping_address_id` bigint DEFAULT NULL,
  `status` varchar(128) DEFAULT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_billing_address_id` (`billing_address_id`),
  UNIQUE KEY `UK_shipping_address_id` (`shipping_address_id`),
  KEY `K_customer_id` (`customer_id`),
  CONSTRAINT `FK_billing_address_id` FOREIGN KEY (`billing_address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `FK_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'8c7f5003-9b40-453d-9c8f-ab0faaa6d018',739.94,6,1,1,2,NULL,'2026-04-02 18:38:38.374000','2026-04-02 18:38:38.374000'),(2,'b8e966ca-d5b3-4386-b01a-cf37cbd36ac7',399.96,4,3,1,4,NULL,'2026-04-02 18:46:46.484000','2026-04-02 18:46:46.484000'),(3,'8275e166-8a17-42e7-b781-acf888d4e43e',459.97,3,5,1,6,NULL,'2026-04-02 18:57:35.315000','2026-04-02 18:57:35.315000'),(4,'9d282d91-0157-4807-9bf0-df9f7ed1d729',459.97,3,7,1,8,NULL,'2026-04-02 19:02:41.553000','2026-04-02 19:02:41.553000'),(5,'0d4c33d1-6285-45ca-ac01-9cb3e3133d5b',739.95,5,9,1,10,NULL,'2026-04-03 12:22:37.412000','2026-04-03 12:22:37.412000');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `unit_price` decimal(13,2) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `active` bit(1) DEFAULT b'1',
  `units_in_stock` int DEFAULT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  `category_id` bigint NOT NULL,
  `sale_price` decimal(13,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'ART-ROT-1001','Feuer & Leidenschaft 30x30cm','Energiegeladene rote Abstraktion',79.99,'assets/images/products/art-rot-1001.png',_binary '',5,'2026-01-23 20:37:59.000000','2026-03-24 08:48:32.666000',1,69.99),(2,'ART-ROT-1002','Feuer & Leidenschaft 70x70cm','Energiegeladene rote Abstraktion - Großformat',149.99,'assets/images/products/art-rot-1002.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,1,NULL),(3,'ART-ROT-1003','Rote Dynamik 50x50cm','Kraftvolle Bewegung in Rot',99.99,'assets/images/products/art-rot-1003.png',_binary '',4,'2026-01-23 20:37:59.000000',NULL,1,NULL),(4,'ART-ROT-1004','Sonnenuntergang 30x30cm','Warme Rottöne und Orange',79.99,'assets/images/products/art-rot-1004.png',_binary '',6,'2026-01-23 20:37:59.000000',NULL,1,NULL),(5,'ART-ROT-1005','Sonnenuntergang 100x100cm','Warme Rottöne und Orange - XXL',249.99,'assets/images/products/art-rot-1005.png',_binary '',2,'2026-01-23 20:37:59.000000',NULL,1,NULL),(6,'ART-ROT-1006','Karminrot 50x50cm','Tiefe rote Nuancen',99.99,'assets/images/products/art-rot-1006.png',_binary '',5,'2026-01-23 20:37:59.000000',NULL,1,NULL),(7,'ART-ROT-1007','Rote Explosion 70x70cm','Intensive Farbexplosion',149.99,'assets/images/products/art-rot-1007.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,1,NULL),(8,'ART-ROT-1008','Koralle & Ziegel 30x30cm','Sanfte Rottöne',79.99,'assets/images/products/art-rot-1008.png',_binary '',7,'2026-01-23 20:37:59.000000',NULL,1,NULL),(9,'ART-ROT-1009','Rubinrot 50x50cm','Edle rote Komposition',99.99,'assets/images/products/art-rot-1009.png',_binary '',4,'2026-01-23 20:37:59.000000','2026-03-29 16:59:00.960000',1,NULL),(10,'ART-ROT-1010','Rote Geometrie 70x70cm','Klare Formen in Rot',149.99,'assets/images/products/art-rot-1010.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,1,NULL),(11,'ART-ROT-1011','Burgunderrot 30x30cm','Dunkle rote Eleganz',79.99,'assets/images/products/art-rot-1011.png',_binary '',6,'2026-01-23 20:37:59.000000',NULL,1,NULL),(12,'ART-ROT-1012','Feuerwerk 100x100cm','Spektakuläre rote Komposition',249.99,'assets/images/products/art-rot-1012.png',_binary '',2,'2026-01-23 20:37:59.000000','2026-03-24 10:06:12.110000',1,199.99),(13,'ART-ROT-1013','Rote Wellen 50x50cm','Fließende rote Formen',99.99,'assets/images/products/art-rot-1013.png',_binary '',5,'2026-01-23 20:37:59.000000',NULL,1,NULL),(14,'ART-ROT-1014','Scharlachrot 30x30cm','Leuchtendes Rot',79.99,'assets/images/products/art-rot-1014.png',_binary '',8,'2026-01-23 20:37:59.000000',NULL,1,NULL),(15,'ART-ROT-1015','Rote Harmonie 70x70cm','Ausgewogene rote Komposition',149.99,'assets/images/products/art-rot-1015.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,1,NULL),(16,'ART-ROT-1016','Roserot 50x50cm','Romantische Rottöne',99.99,'assets/images/products/art-rot-1016.png',_binary '',4,'2026-01-23 20:37:59.000000',NULL,1,NULL),(17,'ART-ROT-1017','Rote Energie 30x30cm','Kraftvolle rote Abstraktion',79.99,'assets/images/products/art-rot-1017.png',_binary '',7,'2026-01-23 20:37:59.000000',NULL,1,NULL),(18,'ART-ROT-1018','Purpur & Rot 100x100cm','Königliche Farbkomposition',249.99,'assets/images/products/art-rot-1018.png',_binary '',2,'2026-01-23 20:37:59.000000',NULL,1,NULL),(19,'ART-ROT-1019','Rote Strukturen 70x70cm','Texturierte rote Flächen',149.99,'assets/images/products/art-rot-1019.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,1,NULL),(20,'ART-ROT-1020','Ziegelrot 50x50cm','Erdige Rottöne',99.99,'assets/images/products/art-rot-1020.png',_binary '',5,'2026-01-23 20:37:59.000000',NULL,1,NULL),(21,'ART-ROT-1021','Rote Kreise 30x30cm','Spielerische rote Formen',79.99,'assets/images/products/art-rot-1021.png',_binary '',6,'2026-01-23 20:37:59.000000',NULL,1,NULL),(22,'ART-ROT-1022','Rote Symphonie 70x70cm','Harmonische rote Komposition',149.99,'assets/images/products/art-rot-1022.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,1,NULL),(23,'ART-ROT-1023','Rotes Mosaik 50x50cm','Fragmentierte rote Formen',99.99,'assets/images/products/art-rot-1023.png',_binary '',4,'2026-01-23 20:37:59.000000',NULL,1,NULL),(24,'ART-ROT-1024','Rote Perspektive 30x30cm','Tiefe durch Rottöne',79.99,'assets/images/products/art-rot-1024.png',_binary '',7,'2026-01-23 20:37:59.000000',NULL,1,NULL),(25,'ART-ROT-1025','Rote Meditation 100x100cm','Beruhigende rote Flächen',249.99,'assets/images/products/art-rot-1025.png',_binary '',2,'2026-01-23 20:37:59.000000',NULL,1,NULL),(26,'ART-GRUEN-2001','Waldgrün 30x30cm','Natürliche grüne Komposition',79.99,'assets/images/products/art-gruen-2001.png',_binary '',5,'2026-01-23 20:37:59.000000',NULL,2,NULL),(27,'ART-GRUEN-2002','Waldgrün 70x70cm','Natürliche grüne Komposition - Großformat',149.99,'assets/images/products/art-gruen-2002.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,2,NULL),(28,'ART-GRUEN-2003','Smaragd 50x50cm','Edle grüne Töne',99.99,'assets/images/products/art-gruen-2003.png',_binary '',4,'2026-01-23 20:37:59.000000',NULL,2,NULL),(29,'ART-GRUEN-2004','Frühlingsgrün 30x30cm','Frische helle Grüntöne',79.99,'assets/images/products/art-gruen-2004.png',_binary '',6,'2026-01-23 20:37:59.000000',NULL,2,NULL),(30,'ART-GRUEN-2005','Frühlingsgrün 100x100cm','Frische helle Grüntöne - XXL',249.99,'assets/images/products/art-gruen-2005.png',_binary '',2,'2026-01-23 20:37:59.000000','2026-03-24 20:33:16.015000',2,219.99),(31,'ART-GRUEN-2006','Jade 50x50cm','Kraftvolles Grün',99.99,'assets/images/products/art-gruen-2006.png',_binary '',5,'2026-01-23 20:37:59.000000',NULL,2,NULL),(32,'ART-GRUEN-2007','Grüne Oase 70x70cm','Beruhigende grüne Flächen',149.99,'assets/images/products/art-gruen-2007.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,2,NULL),(33,'ART-GRUEN-2008','Mintgrün 30x30cm','Sanfte Pastellgrüntöne',79.99,'assets/images/products/art-gruen-2008.png',_binary '',7,'2026-01-23 20:37:59.000000',NULL,2,NULL),(34,'ART-GRUEN-2009','Olivgrün 50x50cm','Erdige grüne Nuancen',99.99,'assets/images/products/art-gruen-2009.png',_binary '',4,'2026-01-23 20:37:59.000000',NULL,2,NULL),(35,'ART-GRUEN-2010','Grüne Geometrie 70x70cm','Strukturierte grüne Formen',149.99,'assets/images/products/art-gruen-2010.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,2,NULL),(36,'ART-GRUEN-2011','Tannengrün 30x30cm','Dunkles sattes Grün',79.99,'assets/images/products/art-gruen-2011.png',_binary '',6,'2026-01-23 20:37:59.000000',NULL,2,NULL),(37,'ART-GRUEN-2012','Grüne Explosion 100x100cm','Lebendige grüne Dynamik',249.99,'assets/images/products/art-gruen-2012.png',_binary '',2,'2026-01-23 20:37:59.000000',NULL,2,NULL),(38,'ART-GRUEN-2013','Grüne Wellen 50x50cm','Fließende grüne Bewegung',99.99,'assets/images/products/art-gruen-2013.png',_binary '',5,'2026-01-23 20:37:59.000000',NULL,2,NULL),(39,'ART-GRUEN-2014','Limettengrün 30x30cm','Frisches helles Grün',79.99,'assets/images/products/art-gruen-2014.png',_binary '',8,'2026-01-23 20:37:59.000000',NULL,2,NULL),(40,'ART-GRUEN-2015','Grüne Harmonie 70x70cm','Ausgewogene grüne Komposition',149.99,'assets/images/products/art-gruen-2015.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,2,NULL),(41,'ART-GRUEN-2016','Moosgrün 50x50cm','Natürliche grüne Töne',99.99,'assets/images/products/art-gruen-2016.png',_binary '',4,'2026-01-23 20:37:59.000000',NULL,2,NULL),(42,'ART-GRUEN-2017','Grüne Energie 30x30cm','Vitale grüne Abstraktion',79.99,'assets/images/products/art-gruen-2017.png',_binary '',7,'2026-01-23 20:37:59.000000',NULL,2,NULL),(43,'ART-GRUEN-2018','Türkisgrün 100x100cm','Grün mit Blautönen',249.99,'assets/images/products/art-gruen-2018.png',_binary '',2,'2026-01-23 20:37:59.000000','2026-03-24 20:33:46.390000',2,199.99),(44,'ART-GRUEN-2019','Grüne Strukturen 70x70cm','Texturierte grüne Flächen',149.99,'assets/images/products/art-gruen-2019.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,2,NULL),(45,'ART-GRUEN-2020','Apfelgrün 50x50cm','Fruchtige Grüntöne',99.99,'assets/images/products/art-gruen-2020.png',_binary '',5,'2026-01-23 20:37:59.000000',NULL,2,NULL),(46,'ART-GRUEN-2021','Grüne Kreise 30x30cm','Spielerische grüne Formen',79.99,'assets/images/products/art-gruen-2021.png',_binary '',6,'2026-01-23 20:37:59.000000',NULL,2,NULL),(47,'ART-GRUEN-2022','Grüne Symphonie 70x70cm','Harmonische grüne Komposition',149.99,'assets/images/products/art-gruen-2022.png',_binary '',3,'2026-01-23 20:37:59.000000',NULL,2,NULL),(48,'ART-GRUEN-2023','Grünes Mosaik 50x50cm','Fragmentierte grüne Formen',99.99,'assets/images/products/art-gruen-2023.png',_binary '',4,'2026-01-23 20:37:59.000000',NULL,2,NULL),(49,'ART-GRUEN-2024','Grüne Perspektive 30x30cm','Tiefe durch Grüntöne',79.99,'assets/images/products/art-gruen-2024.png',_binary '',7,'2026-01-23 20:38:00.000000',NULL,2,NULL),(50,'ART-GRUEN-2025','Grüne Meditation 100x100cm','Beruhigende grüne Flächen',249.99,'assets/images/products/art-gruen-2025.png',_binary '',2,'2026-01-23 20:38:00.000000',NULL,2,NULL),(51,'ART-BLAU-3001','Ozeanblau 30x30cm','Tiefe blaue Komposition',79.99,'assets/images/products/art-blau-3001.png',_binary '',5,'2026-01-23 20:38:00.000000',NULL,3,NULL),(52,'ART-BLAU-3002','Ozeanblau 70x70cm','Tiefe blaue Komposition - Großformat',149.99,'assets/images/products/art-blau-3002.png',_binary '',3,'2026-01-23 20:38:00.000000',NULL,3,NULL),(53,'ART-BLAU-3003','Saphirblau 50x50cm','Edle blaue Töne',99.99,'assets/images/products/art-blau-3003.png',_binary '',4,'2026-01-23 20:38:00.000000',NULL,3,NULL),(54,'ART-BLAU-3004','Himmelblau 30x30cm','Helle freundliche Blautöne',79.99,'assets/images/products/art-blau-3004.png',_binary '',6,'2026-01-23 20:38:00.000000',NULL,3,NULL),(55,'ART-BLAU-3005','Himmelblau 100x100cm','Helle freundliche Blautöne - XXL',249.99,'assets/images/products/art-blau-3005.png',_binary '',2,'2026-01-23 20:38:00.000000',NULL,3,NULL),(56,'ART-BLAU-3006','Kobaltblau 50x50cm','Kraftvolles intensives Blau',99.99,'assets/images/products/art-blau-3006.png',_binary '',5,'2026-01-23 20:38:00.000000',NULL,3,NULL),(57,'ART-BLAU-3007','Blaue Tiefe 70x70cm','Beruhigende blaue Flächen',149.99,'assets/images/products/art-blau-3007.png',_binary '',3,'2026-01-23 20:38:00.000000',NULL,3,NULL),(58,'ART-BLAU-3008','Eisblau 30x30cm','Kühle helle Blautöne',79.99,'assets/images/products/art-blau-3008.png',_binary '',7,'2026-01-23 20:38:00.000000',NULL,3,NULL),(59,'ART-BLAU-3009','Indigoblau 50x50cm','Dunkle geheimnisvolle Blautöne',99.99,'assets/images/products/art-blau-3009.png',_binary '',4,'2026-01-23 20:38:00.000000',NULL,3,NULL),(60,'ART-BLAU-3010','Blaue Geometrie 70x70cm','Strukturierte blaue Formen',149.99,'assets/images/products/art-blau-3010.png',_binary '',3,'2026-01-23 20:38:00.000000',NULL,3,NULL),(61,'ART-BLAU-3011','Nachtblau 30x30cm','Tiefes dunkles Blau',79.99,'assets/images/products/art-blau-3011.png',_binary '',6,'2026-01-23 20:38:00.000000',NULL,3,NULL),(62,'ART-BLAU-3012','Blaue Explosion 100x100cm','Dynamische blaue Komposition',249.99,'assets/images/products/art-blau-3012.png',_binary '',2,'2026-01-23 20:38:00.000000',NULL,3,NULL),(63,'ART-BLAU-3013','Blaue Wellen 50x50cm','Fließende blaue Bewegung',99.99,'assets/images/products/art-blau-3013.png',_binary '',5,'2026-01-23 20:38:00.000000',NULL,3,NULL),(64,'ART-BLAU-3014','Azurblau 30x30cm','Strahlende Blautöne',79.99,'assets/images/products/art-blau-3014.png',_binary '',8,'2026-01-23 20:38:00.000000',NULL,3,NULL),(65,'ART-BLAU-3015','Blaue Harmonie 70x70cm','Ausgewogene blaue Komposition',149.99,'assets/images/products/art-blau-3015.png',_binary '',3,'2026-01-23 20:38:00.000000',NULL,3,NULL),(66,'ART-BLAU-3016','Türkisblau 50x50cm','Blau mit grünen Akzenten',99.99,'assets/images/products/art-blau-3016.png',_binary '',4,'2026-01-23 20:38:00.000000',NULL,3,NULL),(67,'ART-BLAU-3017','Blaue Energie 30x30cm','Vitale blaue Abstraktion',79.99,'assets/images/products/art-blau-3017.png',_binary '',7,'2026-01-23 20:38:00.000000',NULL,3,NULL),(68,'ART-BLAU-3018','Violettblau 100x100cm','Blau mit lila Nuancen',249.99,'assets/images/products/art-blau-3018.png',_binary '',2,'2026-01-23 20:38:00.000000',NULL,3,NULL),(69,'ART-BLAU-3019','Blaue Strukturen 70x70cm','Texturierte blaue Flächen',149.99,'assets/images/products/art-blau-3019.png',_binary '',3,'2026-01-23 20:38:00.000000',NULL,3,NULL),(70,'ART-BLAU-3020','Stahlblau 50x50cm','Kühle metallische Blautöne',99.99,'assets/images/products/art-blau-3020.png',_binary '',5,'2026-01-23 20:38:00.000000','2026-03-24 20:32:59.530000',3,79.99),(71,'ART-BLAU-3021','Blaue Kreise 30x30cm','Spielerische blaue Formen',79.99,'assets/images/products/art-blau-3021.png',_binary '',6,'2026-01-23 20:38:00.000000',NULL,3,NULL),(72,'ART-BLAU-3022','Blaue Symphonie 70x70cm','Harmonische blaue Komposition',149.99,'assets/images/products/art-blau-3022.png',_binary '',3,'2026-01-23 20:38:00.000000',NULL,3,NULL),(73,'ART-BLAU-3023','Blaues Mosaik 50x50cm','Fragmentierte blaue Formen',99.99,'assets/images/products/art-blau-3023.png',_binary '',4,'2026-01-23 20:38:00.000000',NULL,3,NULL),(74,'ART-BLAU-3024','Blaue Perspektive 30x30cm','Tiefe durch Blautöne',79.99,'assets/images/products/art-blau-3024.png',_binary '',7,'2026-01-23 20:38:00.000000',NULL,3,NULL),(75,'ART-BLAU-3025','Blaue Meditation 100x100cm','Beruhigende blaue Flächen',249.99,'assets/images/products/art-blau-3025.png',_binary '',2,'2026-01-23 20:38:00.000000',NULL,3,NULL),(76,'ART-BUNT-4001','Regenbogen 30x30cm','Fröhliche Farbexplosion',89.99,'assets/images/products/art-bunt-4001.png',_binary '',5,'2026-01-23 20:38:00.000000',NULL,4,NULL),(77,'ART-BUNT-4002','Regenbogen 70x70cm','Fröhliche Farbexplosion - Großformat',169.99,'assets/images/products/art-bunt-4002.png',_binary '',3,'2026-01-23 20:38:00.000000',NULL,4,NULL),(78,'ART-BUNT-4003','Farbenfroh 50x50cm','Lebendige bunte Komposition',119.99,'assets/images/products/art-bunt-4003.png',_binary '',4,'2026-01-23 20:38:00.000000',NULL,4,NULL),(79,'ART-BUNT-4004','Konfetti 30x30cm','Spielerischer Farbmix',89.99,'assets/images/products/art-bunt-4004.png',_binary '',6,'2026-01-23 20:38:00.000000',NULL,4,NULL),(80,'ART-BUNT-4005','Konfetti 100x100cm','Spielerischer Farbmix - XXL',279.99,'assets/images/products/art-bunt-4005.png',_binary '',2,'2026-01-23 20:38:00.000000',NULL,4,NULL),(81,'ART-BUNT-4006','Farbspektrum 50x50cm','Alle Farben vereint',119.99,'assets/images/products/art-bunt-4006.png',_binary '',5,'2026-01-23 20:38:00.000000',NULL,4,NULL),(82,'ART-BUNT-4007','Bunte Dynamik 70x70cm','Energiegeladene Farbvielfalt',169.99,'assets/images/products/art-bunt-4007.png',_binary '',3,'2026-01-23 20:38:00.000000',NULL,4,NULL),(83,'ART-BUNT-4008','Pastelltraum 30x30cm','Sanfte bunte Töne',89.99,'assets/images/products/art-bunt-4008.png',_binary '',7,'2026-01-23 20:38:00.000000',NULL,4,NULL),(84,'ART-BUNT-4009','Farbexplosion 50x50cm','Intensive Farbenmischung',119.99,'assets/images/products/art-bunt-4009.png',_binary '',4,'2026-01-23 20:38:00.000000',NULL,4,NULL),(85,'ART-BUNT-4010','Bunte Geometrie 70x70cm','Strukturierte Farbformen',169.99,'assets/images/products/art-bunt-4010.png',_binary '',3,'2026-01-23 20:38:00.000000',NULL,4,NULL),(86,'ART-BUNT-4011','Farbpalette 30x30cm','Künstlerische Farbvielfalt',89.99,'assets/images/products/art-bunt-4011.png',_binary '',6,'2026-01-23 20:38:00.000000',NULL,4,NULL),(87,'ART-BUNT-4012','Buntes Feuerwerk 100x100cm','Spektakuläre Farbkomposition',279.99,'assets/images/products/art-bunt-4012.png',_binary '',2,'2026-01-23 20:38:00.000000',NULL,4,NULL),(88,'ART-BUNT-4013','Bunte Wellen 50x50cm','Fließende Farbübergänge',119.99,'assets/images/products/art-bunt-4013.png',_binary '',5,'2026-01-23 20:38:00.000000',NULL,4,NULL),(89,'ART-BUNT-4014','Leuchtende Farben 30x30cm','Strahlende bunte Komposition',89.99,'assets/images/products/art-bunt-4014.png',_binary '',8,'2026-01-23 20:38:00.000000',NULL,4,NULL),(90,'ART-BUNT-4015','Bunte Harmonie 70x70cm','Ausgewogene Farbkomposition',169.99,'assets/images/products/art-bunt-4015.png',_binary '',3,'2026-01-23 20:38:00.000000',NULL,4,NULL),(91,'ART-BUNT-4016','Farbenmeer 50x50cm','Vielfältige Farbtöne',119.99,'assets/images/products/art-bunt-4016.png',_binary '',4,'2026-01-23 20:38:00.000000',NULL,4,NULL),(92,'ART-BUNT-4017','Bunte Energie 30x30cm','Vitale Farbabstraktion',89.99,'assets/images/products/art-bunt-4017.png',_binary '',7,'2026-01-23 20:38:00.000000',NULL,4,NULL),(93,'ART-BUNT-4018','Farbsymphonie 100x100cm','Orchestrale Farbkomposition',279.99,'assets/images/products/art-bunt-4018.png',_binary '',2,'2026-01-23 20:38:00.000000','2026-03-24 20:34:29.513000',4,269.99),(94,'ART-BUNT-4019','Bunte Strukturen 70x70cm','Texturierte Farbflächen',169.99,'assets/images/products/art-bunt-4019.png',_binary '',3,'2026-01-23 20:38:00.000000',NULL,4,NULL),(95,'ART-BUNT-4020','Farbkontraste 50x50cm','Spannende Farbgegensätze',119.99,'assets/images/products/art-bunt-4020.png',_binary '',5,'2026-01-23 20:38:00.000000','2026-03-24 20:32:02.853000',4,115.00),(96,'ART-BUNT-4021','Bunte Kreise 30x30cm','Spielerische bunte Formen',89.99,'assets/images/products/art-bunt-4021.png',_binary '',6,'2026-01-23 20:38:00.000000',NULL,4,NULL),(97,'ART-BUNT-4022','Farbmelodien 70x70cm','Harmonische Farbkomposition',169.99,'assets/images/products/art-bunt-4022.png',_binary '',3,'2026-01-23 20:38:00.000000','2026-03-24 20:34:02.547000',4,149.99),(98,'ART-BUNT-4023','Buntes Mosaik 50x50cm','Fragmentierte Farbformen',119.99,'assets/images/products/art-bunt-4023.png',_binary '',4,'2026-01-23 20:38:00.000000',NULL,4,NULL),(99,'ART-BUNT-4024','Bunte Perspektive 30x30cm','Tiefe durch Farben',89.99,'assets/images/products/art-bunt-4024.png',_binary '',7,'2026-01-23 20:38:00.000000',NULL,4,NULL),(100,'ART-BUNT-4025','Bunte Meditation 100x100cm','Beruhigende Farbvielfalt',279.99,'assets/images/products/art-bunt-4025.png',_binary '',2,'2026-01-23 20:38:00.000000',NULL,4,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,'Rote Bilder'),(2,'Grüne Bilder'),(3,'Blaue Bilder'),(4,'Bunte Bilder');
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `country_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_country` (`country_id`),
  CONSTRAINT `fk_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES (1,'Baden-Württemberg',1),(2,'Bayern',1),(3,'Berlin',1),(4,'Brandenburg',1),(5,'Bremen',1),(6,'Hamburg',1),(7,'Hessen',1),(8,'Mecklenburg-Vorpommern',1),(9,'Niedersachsen',1),(10,'Nordrhein-Westfalen',1),(11,'Rheinland-Pfalz',1),(12,'Saarland',1),(13,'Sachsen',1),(14,'Sachsen-Anhalt',1),(15,'Schleswig-Holstein',1),(16,'Thüringen',1),(17,'Burgenland',2),(18,'Kärnten',2),(19,'Niederösterreich',2),(20,'Oberösterreich',2),(21,'Salzburg',2),(22,'Steiermark',2),(23,'Tirol',2),(24,'Vorarlberg',2),(25,'Wien',2),(26,'Aargau',3),(27,'Appenzell Ausserrhoden',3),(28,'Appenzell Innerrhoden',3),(29,'Basel-Landschaft',3),(30,'Basel-Stadt',3),(31,'Bern',3),(32,'Freiburg',3),(33,'Genf',3),(34,'Glarus',3),(35,'Graubünden',3),(36,'Jura',3),(37,'Luzern',3),(38,'Neuenburg',3),(39,'Nidwalden',3),(40,'Obwalden',3),(41,'Schaffhausen',3),(42,'Schwyz',3),(43,'Solothurn',3),(44,'St. Gallen',3),(45,'Tessin',3),(46,'Thurgau',3),(47,'Uri',3),(48,'Waadt',3),(49,'Wallis',3),(50,'Zug',3),(51,'Zürich',3);
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-11  8:05:20
