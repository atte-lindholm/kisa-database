CREATE DATABASE  IF NOT EXISTS `uintikilpailu` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `uintikilpailu`;
-- MariaDB dump 10.19  Distrib 10.4.27-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: uintikilpailu
-- ------------------------------------------------------
-- Server version	10.4.27-MariaDB

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
-- Table structure for table `kilpailu`
--

DROP TABLE IF EXISTS `kilpailu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kilpailu` (
  `id` int(11) NOT NULL,
  `osoite` varchar(255) DEFAULT NULL,
  `järjestäjä` varchar(45) DEFAULT NULL,
  `allas` varchar(45) DEFAULT NULL,
  `päivämäärä` varchar(45) DEFAULT NULL,
  `nimi` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kilpailu`
--

LOCK TABLES `kilpailu` WRITE;
/*!40000 ALTER TABLE `kilpailu` DISABLE KEYS */;
INSERT INTO `kilpailu` VALUES (1,'Kisakatu 123, Helsinki','Helsingin Uimaseura','25 metriä','2023-06-15','SM-Kilpailut'),(2,'Kilpailutie 456, Tampere','Tampereen Uintiseura','50 metriä','2023-07-10','Tampereen Avoimet'),(3,'Uimalantie 789, Turku','Turun Uimaklubi','25 metriä','2023-08-05','Turun Uintikilpailu');
/*!40000 ALTER TABLE `kilpailu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kilpailunlaji`
--

DROP TABLE IF EXISTS `kilpailunlaji`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kilpailunlaji` (
  `id` int(11) NOT NULL,
  `lajiId` int(11) DEFAULT NULL,
  `kilpailuId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lajiId` (`lajiId`),
  KEY `kilpailuId` (`kilpailuId`),
  CONSTRAINT `kilpailunlaji_ibfk_1` FOREIGN KEY (`lajiId`) REFERENCES `laji` (`id`),
  CONSTRAINT `kilpailunlaji_ibfk_2` FOREIGN KEY (`kilpailuId`) REFERENCES `kilpailu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kilpailunlaji`
--

LOCK TABLES `kilpailunlaji` WRITE;
/*!40000 ALTER TABLE `kilpailunlaji` DISABLE KEYS */;
INSERT INTO `kilpailunlaji` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),(6,6,1),(7,7,1),(8,8,1),(9,9,1),(10,10,1),(11,11,1),(12,12,1),(13,1,2),(14,3,2),(15,5,2),(16,7,2),(17,9,2),(18,11,2),(19,2,3),(20,4,3),(21,6,3),(22,8,3),(23,10,3),(24,12,3);
/*!40000 ALTER TABLE `kilpailunlaji` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laji`
--

DROP TABLE IF EXISTS `laji`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `laji` (
  `id` int(11) NOT NULL,
  `nimi` varchar(25) DEFAULT NULL,
  `matka` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laji`
--

LOCK TABLES `laji` WRITE;
/*!40000 ALTER TABLE `laji` DISABLE KEYS */;
INSERT INTO `laji` VALUES (1,'Vapaauinti','50m'),(2,'Selkäuinti','50m'),(3,'Rintauinti','50m'),(4,'Perhosuinti','50m'),(5,'Vapaauinti','100m'),(6,'Selkäuinti','100m'),(7,'Rintauinti','100m'),(8,'Perhosuinti','100m'),(9,'Vapaauinti','200m'),(10,'Selkäuinti','200m'),(11,'Rintauinti','200m'),(12,'Perhosuinti','200m');
/*!40000 ALTER TABLE `laji` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osallistuja`
--

DROP TABLE IF EXISTS `osallistuja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osallistuja` (
  `id` int(11) NOT NULL,
  `uimariId` int(11) DEFAULT NULL,
  `kilpailunlajiId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uimariId` (`uimariId`),
  KEY `kilpailunlajiId` (`kilpailunlajiId`),
  CONSTRAINT `osallistuja_ibfk_1` FOREIGN KEY (`uimariId`) REFERENCES `uimari` (`id`),
  CONSTRAINT `osallistuja_ibfk_2` FOREIGN KEY (`kilpailunlajiId`) REFERENCES `kilpailunlaji` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osallistuja`
--

LOCK TABLES `osallistuja` WRITE;
/*!40000 ALTER TABLE `osallistuja` DISABLE KEYS */;
INSERT INTO `osallistuja` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10),(11,11,11),(12,12,12),(13,13,13),(14,14,14),(15,15,15),(16,16,16),(17,17,17),(18,18,18),(19,19,19),(20,20,20),(21,21,21),(22,22,22),(23,23,23),(24,24,24),(25,25,13),(26,26,14),(27,27,15),(28,28,16),(29,29,17),(30,30,18),(31,1,2),(32,1,3),(33,2,4),(34,2,5),(35,3,6),(36,3,7),(37,4,8),(38,4,9),(39,5,10),(40,5,11),(41,6,12),(42,6,13),(43,7,14),(44,7,15),(45,8,16),(46,8,17),(47,9,18),(48,9,19),(49,10,20),(50,10,21),(51,11,22),(52,11,23),(53,12,24),(54,12,1),(55,13,2),(56,13,3),(57,14,4),(58,14,5),(59,15,6),(60,15,7),(61,16,8),(62,16,9),(63,17,10),(64,17,11),(65,18,12),(66,18,13),(67,19,14),(68,19,15),(69,20,16),(70,20,17),(71,21,18),(72,21,19),(73,22,20),(74,22,21),(75,23,22),(76,23,23),(77,24,24),(78,24,1),(79,25,2),(80,25,3),(81,26,4),(82,26,5),(83,27,6),(84,27,7),(85,28,8),(86,28,9),(87,29,10),(88,29,11),(89,30,12),(90,30,13);
/*!40000 ALTER TABLE `osallistuja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seura`
--

DROP TABLE IF EXISTS `seura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seura` (
  `id` int(11) NOT NULL,
  `nimi` varchar(45) DEFAULT NULL,
  `toimipiste` varchar(45) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `puhelinnumero` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seura`
--

LOCK TABLES `seura` WRITE;
/*!40000 ALTER TABLE `seura` DISABLE KEYS */;
INSERT INTO `seura` VALUES (1,'Tähtiseura','Helsinki','tahtiseura@example.com','123-456789'),(2,'Liikuntaseura X','Tampere','liikuntaseuraX@example.com','987-654321'),(3,'Urheiluseura Y','Turku','urheiluseuraY@example.com','456-789123'),(4,'Kulttuuriseura Z','Oulu','kulttuuriseuraZ@example.com','321-654987'),(5,'Harrastusseura A','Jyväskylä','harrastusseuraA@example.com','789-123456'),(6,'Kerhoseura B','Vaasa','kerhoseuraB@example.com','654-987321');
/*!40000 ALTER TABLE `seura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uimari`
--

DROP TABLE IF EXISTS `uimari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uimari` (
  `id` int(11) NOT NULL,
  `etunimi` varchar(25) DEFAULT NULL,
  `sukunimi` varchar(25) DEFAULT NULL,
  `syntymäaika` date DEFAULT NULL,
  `seuraId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seuraId` (`seuraId`),
  CONSTRAINT `uimari_ibfk_1` FOREIGN KEY (`seuraId`) REFERENCES `seura` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uimari`
--

LOCK TABLES `uimari` WRITE;
/*!40000 ALTER TABLE `uimari` DISABLE KEYS */;
INSERT INTO `uimari` VALUES (1,'Matti','Korhonen','1990-02-15',1),(2,'Anna','Virtanen','1992-06-22',2),(3,'Jukka','Mäkinen','1995-11-10',3),(4,'Sara','Lehtonen','1998-03-05',4),(5,'Petri','Järvinen','1991-09-18',5),(6,'Laura','Koskinen','1993-12-25',6),(7,'Timo','Niemi','1994-08-07',1),(8,'Hanna','Laine','1997-01-30',2),(9,'Antti','Hämäläinen','1992-04-12',3),(10,'Emilia','Salonen','1996-07-20',4),(11,'Elina','Laaksonen','1993-02-28',5),(12,'Jari','Rantanen','1996-05-14',3),(13,'Sofia','Kallio','1999-08-02',2),(14,'Markus','Hakala','1991-11-20',4),(15,'Tiina','Koivisto','1997-03-15',1),(16,'Pasi','Mäkelä','1994-06-06',6),(17,'Satu','Vainio','1998-09-24',3),(18,'Ville','Leppänen','1995-12-10',2),(19,'Kati','Nurmi','1990-04-28',4),(20,'Juho','Korpi','1993-07-16',1),(21,'Paula','Kinnunen','1996-10-04',6),(22,'Eero','Rautiainen','1999-01-22',5),(23,'Noora','Heikkilä','1992-04-09',2),(24,'Janne','Lindroos','1997-07-27',3),(25,'Inka','Nieminen','1990-10-15',4),(26,'Teemu','Koskela','1994-01-02',1),(27,'Helena','Virtanen','1998-04-20',6),(28,'Riku','Koivula','1991-07-08',5),(29,'Maria','Salmi','1996-09-26',2),(30,'Olli','Karjalainen','1993-12-14',4);
/*!40000 ALTER TABLE `uimari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'uintikilpailu'
--

--
-- Dumping routines for database 'uintikilpailu'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-31 10:20:31
