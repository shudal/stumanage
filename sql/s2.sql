-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: stumanage
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.18.04.1

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
-- Table structure for table `story`
--

DROP TABLE IF EXISTS `story`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `story` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stuid` varchar(50) NOT NULL,
  `content` text,
  `create_time` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `story`
--

LOCK TABLES `story` WRITE;
/*!40000 ALTER TABLE `story` DISABLE KEYS */;
INSERT INTO `story` VALUES (7,'8888888888888','非常好 ','1565587565000'),(13,'8888888888888','dsgdf','1565679799000'),(10,'fdgj','sdfdsf\ndsfds','1565594658000');
/*!40000 ALTER TABLE `story` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `stuid` varchar(50) NOT NULL,
  `pic` varchar(300) DEFAULT NULL,
  `duty` varchar(300) DEFAULT NULL,
  `idcard` varchar(50) DEFAULT NULL,
  `nation` varchar(30) DEFAULT NULL,
  `politic` varchar(30) DEFAULT NULL,
  `birthday` varchar(18) DEFAULT '915120000000',
  `home` varchar(300) DEFAULT NULL,
  `contact` varchar(300) DEFAULT NULL,
  `place` varchar(150) DEFAULT NULL,
  `sex` varchar(15) DEFAULT '未知',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (21,'小名','8888888888888','20190812/b67443fe29aa8d2a16e812546b79dab0.jpg','班长','444444444444444444','汉','共青团员','1566921600000','武汉市','11111111111','武汉','男'),(22,'ppppsd','fdg','20190812/8a08849bd665ef77c78b5923ed88376a.jpg','dfg','gf','df','g','1565625600000','sdf','sdf','df','女'),(23,'jjj','fdgj','20190812/698642fe6c3a78e3b521f1230dd1f1ab.jpg','dfg','gf','df','g','1565625600000','sdf','sdf','df','未知'),(24,'dfg','klfdg','20190812/a94dd9d75d7d7009efba4dab641d3213.jpg','df','gdf','d','f','1533657600000','vvcb','cvbvc','fd','未知'),(27,'小君','sdf','20190813/0c44c078887cdac9c731a43a8695df5f.jpg','sdf','sdf','sdf','dsf','1565712000000','f','sdfsd','sdf','男');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `super`
--

DROP TABLE IF EXISTS `super`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `super` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(300) NOT NULL,
  `type` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `super`
--

LOCK TABLES `super` WRITE;
/*!40000 ALTER TABLE `super` DISABLE KEYS */;
INSERT INTO `super` VALUES (1,'admin','96e79218965eb72c92a549dd5a330112',3);
/*!40000 ALTER TABLE `super` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-13 15:13:34
