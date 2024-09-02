-- MySQL dump 10.13  Distrib 8.4.0, for macos14 (arm64)
--
-- Host: localhost    Database: TrainDatabase
-- ------------------------------------------------------
-- Server version	8.4.0

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
-- Table structure for table `messaging`
--

DROP TABLE IF EXISTS `messaging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messaging` (
  `mid` int NOT NULL AUTO_INCREMENT,
  `user` varchar(50) DEFAULT NULL,
  `subject` varchar(150) DEFAULT NULL,
  `content` text,
  `admin` varchar(50) DEFAULT NULL,
  `answer` text,
  PRIMARY KEY (`mid`),
  KEY `user` (`user`),
  KEY `admin` (`admin`),
  CONSTRAINT `messaging_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`username`) ON DELETE CASCADE,
  CONSTRAINT `messaging_ibfk_2` FOREIGN KEY (`admin`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messaging`
--

LOCK TABLES `messaging` WRITE;
/*!40000 ALTER TABLE `messaging` DISABLE KEYS */;
INSERT INTO `messaging` VALUES (1,'test_user','Test','Test Question','csr_user','Test Answer'),(2,'test_user','Trains','Trains trains','admin_user','Hi');
/*!40000 ALTER TABLE `messaging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `rid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `total_cost` double NOT NULL,
  `origin` int DEFAULT NULL,
  `destination` int DEFAULT NULL,
  `schedule_num` int DEFAULT NULL,
  `date_ticket` date NOT NULL,
  `date_reserved` date NOT NULL,
  `booking_fee` double NOT NULL,
  `discount` enum('Disabled','Senior/Child','Normal') NOT NULL,
  `trip` enum('Round','One') NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `schedule_num` (`schedule_num`),
  KEY `origin` (`origin`),
  KEY `destination` (`destination`),
  KEY `username` (`username`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`schedule_num`) REFERENCES `train_schedule_assignment` (`schedule_num`) ON DELETE CASCADE,
  CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`origin`) REFERENCES `station` (`station_id`),
  CONSTRAINT `reservations_ibfk_3` FOREIGN KEY (`destination`) REFERENCES `station` (`station_id`),
  CONSTRAINT `reservations_ibfk_4` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (4,'test_user',8.5,12,13,1002,'2024-07-21','2024-07-21',3.5,'Normal','One');
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `name` varchar(50) DEFAULT NULL,
  `state_name` varchar(50) DEFAULT NULL,
  `city_name` varchar(50) DEFAULT NULL,
  `station_id` int NOT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES ('Atlantic City','NJ','Atlantic City',11),('Egg Harbor City','NJ','Egg Harbor City',12),('Hammonton','NJ','Atlantic County',13),('Cherry Hill','NJ','Camden',14),('Philadelphia','NJ','Philadelphia',15),('Trenton','NJ','Trenton',16),('Hamilton','NJ','Hamilton',17),('Princeton Junction','NJ','Princeton',18),('Jersey Avenue','NJ','New Brunswick',19),('New Brunswick','NJ','New Brunswick',20),('Edison','NJ','Edison',21),('Metuchen','NJ','Metuchen',22),('Elizabeth','NJ','Elizabeth',23),('Newark Penn Station','NJ','Newark',24),('New York','NY','New York',25),('Teterboro','NJ','Hasbrouck Heights',26),('Secaucus Junction','NJ','Secaucus',27),('Hoboken','NJ','Hoboken',28),('Red Bank','NJ','Red Bank',29),('Woodbridge','NJ','Woodbridge',30),('Linden','NJ','Linden',31);
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `name_of_transit_line` varchar(50) DEFAULT NULL,
  `number_of_seats` int DEFAULT NULL,
  `number_of_cars` int DEFAULT NULL,
  `train_id` int NOT NULL,
  PRIMARY KEY (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (NULL,1,5,101),(NULL,3,5,102),(NULL,2,10,103),(NULL,2,12,104),(NULL,2,8,105),(NULL,4,5,106),(NULL,2,12,107),(NULL,2,10,108),(NULL,8,8,109),(NULL,2,8,110),(NULL,9,7,111),(NULL,2,6,112),(NULL,6,4,113),(NULL,4,3,114),(NULL,5,4,115);
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_schedule_assignment`
--

DROP TABLE IF EXISTS `train_schedule_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_schedule_assignment` (
  `schedule_num` int NOT NULL,
  `tl_id` varchar(5) DEFAULT NULL,
  `train_id` int DEFAULT NULL,
  PRIMARY KEY (`schedule_num`),
  KEY `tl_id` (`tl_id`),
  KEY `train_id` (`train_id`),
  CONSTRAINT `train_schedule_assignment_ibfk_1` FOREIGN KEY (`tl_id`) REFERENCES `transit_line` (`tl_id`),
  CONSTRAINT `train_schedule_assignment_ibfk_2` FOREIGN KEY (`train_id`) REFERENCES `train` (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_schedule_assignment`
--

LOCK TABLES `train_schedule_assignment` WRITE;
/*!40000 ALTER TABLE `train_schedule_assignment` DISABLE KEYS */;
INSERT INTO `train_schedule_assignment` VALUES (1001,'AC',101),(1002,'AC',101),(1003,'AC',101),(1004,'AC',102),(1005,'AC',102),(1006,'AC',102),(1007,'AC',102),(1008,'NE',103),(1009,'NE',103),(1010,'NE',104),(1011,'NE',104),(1012,'NE',104),(1013,'NE',105),(1014,'NE',105),(1015,'NE',105),(1016,'NE',106),(1017,'NE',107),(1018,'NE',107),(1019,'NE',108),(1020,'NE',108),(1021,'PV',101),(1022,'PV',113),(1023,'NJC',114),(1024,'NJC',114),(1025,'NJC',115),(1026,'RV',106),(1027,'RV',113),(1028,'RV',107),(1029,'RV',108),(1030,'PB',109),(1031,'PB',110),(1032,'AC',101);
/*!40000 ALTER TABLE `train_schedule_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_schedule_timings`
--

DROP TABLE IF EXISTS `train_schedule_timings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_schedule_timings` (
  `schedule_num` int NOT NULL,
  `route_id` int NOT NULL,
  `departure_time` time DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  PRIMARY KEY (`route_id`,`schedule_num`),
  KEY `schedule_num` (`schedule_num`),
  CONSTRAINT `train_schedule_timings_ibfk_1` FOREIGN KEY (`schedule_num`) REFERENCES `train_schedule_assignment` (`schedule_num`) ON DELETE CASCADE,
  CONSTRAINT `train_schedule_timings_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `transit_line_route` (`route_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_schedule_timings`
--

LOCK TABLES `train_schedule_timings` WRITE;
/*!40000 ALTER TABLE `train_schedule_timings` DISABLE KEYS */;
INSERT INTO `train_schedule_timings` VALUES (1002,1,'15:47:00','16:11:00'),(1004,1,'10:12:00','10:36:00'),(1006,1,'16:59:00','17:20:00'),(1032,1,'19:14:00','19:15:00'),(1002,2,'16:11:00','16:22:00'),(1004,2,'10:36:00','10:47:00'),(1006,2,'17:20:00','17:31:00'),(1032,2,'19:15:00','19:16:00'),(1002,3,'16:22:00','16:55:00'),(1004,3,'10:47:00','11:20:00'),(1006,3,'17:31:00','18:07:00'),(1032,3,'19:16:00','19:17:00'),(1002,4,'16:55:00','17:27:00'),(1004,4,'11:20:00','11:52:00'),(1006,4,'18:07:00','18:39:00'),(1032,4,'19:17:00','19:18:00'),(1001,5,'11:00:00','11:25:00'),(1003,5,'20:00:00','20:22:00'),(1005,5,'12:58:00','13:26:00'),(1007,5,'21:01:00','21:29:00'),(1001,6,'11:25:00','12:05:00'),(1003,6,'20:22:00','20:55:00'),(1005,6,'13:26:00','13:58:00'),(1007,6,'21:29:00','22:02:00'),(1001,7,'12:05:00','12:19:00'),(1003,7,'20:55:00','21:10:00'),(1005,7,'13:58:00','14:09:00'),(1007,7,'22:02:00','22:12:00'),(1001,8,'12:19:00','12:40:00'),(1003,8,'21:10:00','21:35:00'),(1005,8,'14:09:00','14:32:00'),(1007,8,'22:12:00','22:36:00'),(1008,9,'08:20:00','08:41:00'),(1010,9,'03:55:00','04:10:00'),(1012,9,'08:30:00','08:40:00'),(1014,9,'19:30:00','19:35:00'),(1016,9,'06:00:00','06:10:00'),(1018,9,'11:30:00','11:40:00'),(1020,9,'20:10:00','20:22:00'),(1008,10,'08:41:00','08:55:00'),(1010,10,'04:10:00','04:19:00'),(1012,10,'08:40:00','08:50:00'),(1014,10,'19:35:00','19:50:00'),(1016,10,'06:10:00','06:15:00'),(1018,10,'11:40:00','11:55:00'),(1020,10,'20:22:00','20:35:00'),(1008,11,'08:55:00','09:35:00'),(1010,11,'04:19:00','04:25:00'),(1012,11,'08:50:00','09:10:00'),(1014,11,'19:50:00','20:01:00'),(1016,11,'06:15:00','06:20:00'),(1018,11,'11:55:00','12:10:00'),(1020,11,'20:35:00','20:54:00'),(1008,12,'09:35:00','10:00:00'),(1010,12,'04:25:00','04:40:00'),(1012,12,'09:10:00','09:25:00'),(1014,12,'20:01:00','20:12:00'),(1016,12,'06:20:00','06:30:00'),(1018,12,'12:10:00','12:20:00'),(1020,12,'20:54:00','21:12:00'),(1008,13,'10:00:00','10:10:00'),(1010,13,'04:40:00','04:45:00'),(1012,13,'09:25:00','09:40:00'),(1014,13,'20:12:00','20:19:00'),(1016,13,'06:30:00','06:45:00'),(1018,13,'12:20:00','12:40:00'),(1020,13,'21:12:00','21:30:00'),(1008,14,'10:10:00','10:20:00'),(1010,14,'04:45:00','04:55:00'),(1012,14,'09:40:00','09:50:00'),(1014,14,'20:19:00','20:30:00'),(1016,14,'06:45:00','06:54:00'),(1018,14,'12:40:00','12:55:00'),(1020,14,'21:30:00','21:45:00'),(1008,15,'10:20:00','10:40:00'),(1010,15,'04:55:00','05:10:00'),(1012,15,'09:50:00','09:55:00'),(1014,15,'20:30:00','20:44:00'),(1016,15,'06:54:00','07:00:00'),(1018,15,'12:55:00','13:00:00'),(1020,15,'21:45:00','22:10:00'),(1008,16,'10:40:00','11:00:00'),(1010,16,'05:10:00','05:20:00'),(1012,16,'09:55:00','10:10:00'),(1014,16,'20:44:00','20:55:00'),(1016,16,'07:00:00','07:05:00'),(1018,16,'13:00:00','13:10:00'),(1020,16,'22:10:00','22:30:00'),(1008,17,'11:00:00','11:10:00'),(1010,17,'05:20:00','05:30:00'),(1012,17,'10:10:00','10:25:00'),(1014,17,'20:55:00','21:00:00'),(1016,17,'07:05:00','07:12:00'),(1018,17,'13:10:00','13:20:00'),(1020,17,'22:30:00','23:00:00'),(1009,18,'12:10:00','12:15:00'),(1011,18,'06:00:00','06:10:00'),(1013,18,'10:45:00','10:55:00'),(1015,18,'21:20:00','21:29:00'),(1017,18,'10:00:00','10:15:00'),(1019,18,'15:00:00','15:10:00'),(1009,19,'12:15:00','12:30:00'),(1011,19,'06:10:00','06:25:00'),(1013,19,'10:55:00','11:05:00'),(1015,19,'21:29:00','21:35:00'),(1017,19,'10:15:00','10:23:00'),(1019,19,'15:10:00','15:23:00'),(1009,20,'12:30:00','12:45:00'),(1011,20,'06:25:00','06:35:00'),(1013,20,'11:05:00','11:14:00'),(1015,20,'21:35:00','21:38:00'),(1017,20,'10:23:00','10:30:00'),(1019,20,'15:23:00','15:40:00'),(1009,21,'12:45:00','13:00:00'),(1011,21,'06:35:00','06:55:00'),(1013,21,'11:14:00','11:19:00'),(1015,21,'21:38:00','21:44:00'),(1017,21,'10:30:00','10:35:00'),(1019,21,'15:40:00','15:54:00'),(1009,22,'13:00:00','13:10:00'),(1011,22,'06:55:00','07:10:00'),(1013,22,'11:19:00','11:30:00'),(1015,22,'21:44:00','21:48:00'),(1017,22,'10:35:00','10:40:00'),(1019,22,'15:54:00','16:04:00'),(1009,23,'13:10:00','13:30:00'),(1011,23,'07:10:00','07:20:00'),(1013,23,'11:30:00','11:35:00'),(1015,23,'21:48:00','21:55:00'),(1017,23,'10:40:00','10:45:00'),(1019,23,'16:04:00','16:23:00'),(1009,24,'13:30:00','13:40:00'),(1011,24,'07:20:00','07:35:00'),(1013,24,'11:35:00','11:45:00'),(1015,24,'21:55:00','21:59:00'),(1017,24,'10:45:00','10:50:00'),(1019,24,'16:23:00','16:34:00'),(1009,25,'13:40:00','13:55:00'),(1011,25,'07:35:00','07:50:00'),(1013,25,'11:45:00','11:50:00'),(1015,25,'21:59:00','22:04:00'),(1017,25,'10:50:00','11:05:00'),(1019,25,'16:34:00','16:46:00'),(1009,26,'13:55:00','14:10:00'),(1011,26,'07:50:00','08:00:00'),(1013,26,'11:50:00','12:00:00'),(1015,26,'22:04:00','22:10:00'),(1017,26,'11:05:00','11:20:00'),(1019,26,'16:46:00','17:00:00'),(1021,27,'02:00:00','02:10:00'),(1021,28,'02:10:00','02:20:00'),(1021,29,'02:20:00','02:40:00'),(1022,30,'11:15:00','11:35:00'),(1022,31,'11:35:00','11:45:00'),(1022,32,'11:45:00','11:55:00'),(1023,33,'10:00:00','10:20:00'),(1025,33,'21:45:00','22:10:00'),(1023,34,'10:45:00','10:54:00'),(1025,34,'22:10:00','22:30:00'),(1023,35,'10:54:00','11:15:00'),(1025,35,'22:30:00','23:00:00'),(1024,36,'11:15:00','11:35:00'),(1024,37,'11:35:00','11:45:00'),(1024,38,'11:45:00','11:55:00'),(1026,39,'12:00:00','12:30:00'),(1028,39,'16:00:00','16:30:00'),(1026,40,'12:30:00','12:45:00'),(1028,40,'16:30:00','16:45:00'),(1026,41,'12:45:00','13:00:00'),(1028,41,'16:45:00','17:00:00'),(1027,42,'13:00:00','13:15:00'),(1029,42,'02:00:00','02:15:00'),(1027,43,'13:15:00','13:30:00'),(1029,43,'02:15:00','02:30:00'),(1027,44,'13:30:00','14:00:00'),(1029,44,'02:30:00','03:00:00'),(1030,45,'12:00:00','13:20:00'),(1031,46,'14:00:00','15:20:00');
/*!40000 ALTER TABLE `train_schedule_timings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transit_line`
--

DROP TABLE IF EXISTS `transit_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transit_line` (
  `tl_id` varchar(5) NOT NULL,
  `tl_name` varchar(50) DEFAULT NULL,
  `origin_station_id` int NOT NULL,
  `termin_station_id` int NOT NULL,
  `fare` double DEFAULT NULL,
  PRIMARY KEY (`tl_id`),
  KEY `origin_station_id` (`origin_station_id`),
  KEY `termin_station_id` (`termin_station_id`),
  CONSTRAINT `transit_line_ibfk_1` FOREIGN KEY (`origin_station_id`) REFERENCES `station` (`station_id`),
  CONSTRAINT `transit_line_ibfk_2` FOREIGN KEY (`termin_station_id`) REFERENCES `station` (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transit_line`
--

LOCK TABLES `transit_line` WRITE;
/*!40000 ALTER TABLE `transit_line` DISABLE KEYS */;
INSERT INTO `transit_line` VALUES ('AC','Atlantic City Line',11,15,5),('NE','Northeast Corridor',16,25,2),('NJC','North Jersey Coast Line',29,31,3),('PB','Princeton Branch',18,24,10),('PV','Pascack Valley',25,28,2),('RV','Raritan Valley Line',15,18,3);
/*!40000 ALTER TABLE `transit_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transit_line_route`
--

DROP TABLE IF EXISTS `transit_line_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transit_line_route` (
  `route_id` int NOT NULL,
  `tl_id` varchar(5) DEFAULT NULL,
  `hop_number` int DEFAULT NULL,
  `direction` varchar(10) DEFAULT NULL,
  `start_station_id` int DEFAULT NULL,
  `end_station_id` int DEFAULT NULL,
  PRIMARY KEY (`route_id`),
  KEY `tl_id` (`tl_id`),
  KEY `start_station_id` (`start_station_id`),
  KEY `end_station_id` (`end_station_id`),
  CONSTRAINT `transit_line_route_ibfk_1` FOREIGN KEY (`tl_id`) REFERENCES `transit_line` (`tl_id`),
  CONSTRAINT `transit_line_route_ibfk_2` FOREIGN KEY (`start_station_id`) REFERENCES `station` (`station_id`),
  CONSTRAINT `transit_line_route_ibfk_3` FOREIGN KEY (`end_station_id`) REFERENCES `station` (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transit_line_route`
--

LOCK TABLES `transit_line_route` WRITE;
/*!40000 ALTER TABLE `transit_line_route` DISABLE KEYS */;
INSERT INTO `transit_line_route` VALUES (1,'AC',1,'up',11,12),(2,'AC',2,'up',12,13),(3,'AC',3,'up',13,14),(4,'AC',4,'up',14,15),(5,'AC',5,'down',15,14),(6,'AC',6,'down',14,13),(7,'AC',7,'down',13,12),(8,'AC',8,'down',12,11),(9,'NE',1,'up',16,17),(10,'NE',2,'up',17,18),(11,'NE',3,'up',18,19),(12,'NE',4,'up',19,20),(13,'NE',5,'up',20,21),(14,'NE',6,'up',21,22),(15,'NE',7,'up',22,23),(16,'NE',8,'up',23,24),(17,'NE',9,'up',24,25),(18,'NE',10,'down',25,24),(19,'NE',11,'down',24,23),(20,'NE',12,'down',23,22),(21,'NE',13,'down',22,21),(22,'NE',14,'down',21,20),(23,'NE',15,'down',20,19),(24,'NE',16,'down',19,18),(25,'NE',17,'down',18,17),(26,'NE',18,'down',17,16),(27,'PV',1,'up',26,27),(28,'PV',2,'up',27,25),(29,'PV',3,'up',25,28),(30,'PV',4,'down',28,25),(31,'PV',5,'down',25,27),(32,'PV',6,'down',27,26),(33,'NJC',1,'up',29,30),(34,'NJC',2,'up',30,31),(35,'NJC',3,'up',31,25),(36,'NJC',4,'down',25,31),(37,'NJC',5,'down',31,30),(38,'NJC',6,'down',30,29),(39,'RV',1,'up',15,16),(40,'RV',2,'up',16,17),(41,'RV',3,'up',17,18),(42,'RV',4,'down',18,17),(43,'RV',5,'down',17,16),(44,'RV',6,'down',16,15),(45,'PB',1,'up',18,24),(46,'PB',2,'down',24,18);
/*!40000 ALTER TABLE `transit_line_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) NOT NULL DEFAULT '',
  `email` varchar(50) DEFAULT NULL,
  `ssn` varchar(45) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `telephone` varchar(11) DEFAULT NULL,
  `zipcode` varchar(5) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `role` enum('customer_service_rep','customer','administrator') DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('ac2155','12345',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('admin_user','admin_password','admin@example.com',NULL,'Alice','Johnson','1122334455','67890','Admincity','AD','administrator'),('AndyChen123','password',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('auser','password','sh@gmail.com','123456789','auser','name','12345678','08854','East Brunswick','NJ','customer'),('csr_user','csr_password','csr@example.com',NULL,'John','Doe','1234567890','12345','Anytown','ST','customer_service_rep'),('customer_user','customer_password','customer@example.com','null1','Jane','Smith','0987654321','54321','Othertown','TS','customer'),('Obama','password123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('some','thing','test2@test.com','222334444','Test2','User','7188866715','11234','New York City','NY','customer'),('test_user','password','test@test.com','1111111111','Test','Test','1234567890','08820','Test','NJ','customer'),('wahab','dar','chen84134@gmail.com','123456789','wahab','dar','6094649726','08854','East Brunswick','NJ','customer');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-21 21:20:04
