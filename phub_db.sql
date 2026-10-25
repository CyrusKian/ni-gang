-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: phub_db
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `beds`
--

DROP TABLE IF EXISTS `beds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beds` (
  `Bed_id` varchar(20) NOT NULL,
  `Status` enum('Available','Occupied','Maintenance','Cleaning') NOT NULL,
  `Room_id` varchar(50) NOT NULL,
  PRIMARY KEY (`Bed_id`),
  KEY `Room_id` (`Room_id`),
  CONSTRAINT `beds_ibfk_1` FOREIGN KEY (`Room_id`) REFERENCES `rooms` (`Room_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beds`
--

LOCK TABLES `beds` WRITE;
/*!40000 ALTER TABLE `beds` DISABLE KEYS */;
INSERT INTO `beds` VALUES ('103-A','Available','103'),('103-B','Available','103'),('103-C','Available','103'),('103-D','Available','103'),('104-A','Available','104'),('104-B','Available','104'),('104-C','Available','104'),('104-D','Available','104'),('105-A','Available','105'),('201-A','Available','201'),('202-A','Available','202'),('203-A','Available','203'),('204-A','Available','204'),('204-B','Available','204'),('205-A','Available','205'),('205-B','Available','205'),('206-A','Available','206'),('206-B','Available','206'),('206-C','Available','206'),('206-D','Available','206'),('301-A','Available','301'),('302-A','Available','302'),('303-A','Available','303'),('304-A','Available','304'),('304-B','Available','304'),('305-A','Available','305'),('305-B','Available','305'),('306-A','Available','306'),('306-B','Available','306'),('306-C','Available','306'),('306-D','Available','306');
/*!40000 ALTER TABLE `beds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_assignment`
--

DROP TABLE IF EXISTS `doctor_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_assignment` (
  `DoctorAssignment_id` int NOT NULL AUTO_INCREMENT,
  `Doctor_id` varchar(50) NOT NULL,
  `Patient_id` varchar(50) NOT NULL,
  `Date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`DoctorAssignment_id`),
  KEY `Doctor_id` (`Doctor_id`),
  KEY `Patient_id` (`Patient_id`),
  CONSTRAINT `doctor_assignment_ibfk_1` FOREIGN KEY (`Doctor_id`) REFERENCES `doctors` (`Doctor_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `doctor_assignment_ibfk_2` FOREIGN KEY (`Patient_id`) REFERENCES `patients` (`Patient_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_assignment`
--

LOCK TABLES `doctor_assignment` WRITE;
/*!40000 ALTER TABLE `doctor_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `Doctor_id` varchar(50) NOT NULL,
  `F_name` varchar(50) NOT NULL,
  `M_name` varchar(50) DEFAULT NULL,
  `L_name` varchar(50) NOT NULL,
  `Phone_number` varchar(20) DEFAULT NULL,
  `Email` varchar(150) NOT NULL,
  PRIMARY KEY (`Doctor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse_assignment`
--

DROP TABLE IF EXISTS `nurse_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurse_assignment` (
  `NurseAssignment_id` int NOT NULL AUTO_INCREMENT,
  `Room_id` varchar(50) NOT NULL,
  `Nurse_id` varchar(50) NOT NULL,
  `Date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`NurseAssignment_id`),
  KEY `Room_id` (`Room_id`),
  KEY `Nurse_id` (`Nurse_id`),
  CONSTRAINT `nurse_assignment_ibfk_1` FOREIGN KEY (`Room_id`) REFERENCES `rooms` (`Room_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `nurse_assignment_ibfk_2` FOREIGN KEY (`Nurse_id`) REFERENCES `nurses` (`Nurse_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse_assignment`
--

LOCK TABLES `nurse_assignment` WRITE;
/*!40000 ALTER TABLE `nurse_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `nurse_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses`
--

DROP TABLE IF EXISTS `nurses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurses` (
  `Nurse_id` varchar(50) NOT NULL,
  `F_name` varchar(50) NOT NULL,
  `M_name` varchar(50) DEFAULT NULL,
  `L_name` varchar(50) NOT NULL,
  `Phone_number` varchar(20) DEFAULT NULL,
  `Email` varchar(150) NOT NULL,
  `Shift` enum('Morning','Afternoon','Night') NOT NULL,
  PRIMARY KEY (`Nurse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses`
--

LOCK TABLES `nurses` WRITE;
/*!40000 ALTER TABLE `nurses` DISABLE KEYS */;
/*!40000 ALTER TABLE `nurses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_assignment`
--

DROP TABLE IF EXISTS `patient_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_assignment` (
  `PatientAssignment_id` int NOT NULL AUTO_INCREMENT,
  `Patient_id` varchar(50) NOT NULL,
  `admission` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `discharge` datetime DEFAULT NULL,
  `Bed_id` varchar(20) NOT NULL,
  PRIMARY KEY (`PatientAssignment_id`),
  KEY `Patient_id` (`Patient_id`),
  KEY `Bed_id` (`Bed_id`),
  CONSTRAINT `patient_assignment_ibfk_1` FOREIGN KEY (`Patient_id`) REFERENCES `patients` (`Patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `patient_assignment_ibfk_2` FOREIGN KEY (`Bed_id`) REFERENCES `beds` (`Bed_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_assignment`
--

LOCK TABLES `patient_assignment` WRITE;
/*!40000 ALTER TABLE `patient_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `Patient_id` varchar(50) NOT NULL,
  `F_name` varchar(50) NOT NULL,
  `M_name` varchar(50) DEFAULT NULL,
  `L_name` varchar(50) NOT NULL,
  `B_date` date NOT NULL,
  `Gender` enum('Male','Female','Other') NOT NULL,
  `Address` varchar(150) NOT NULL,
  `Phone_number` varchar(20) DEFAULT NULL,
  `Emergency_contact` varchar(20) NOT NULL,
  PRIMARY KEY (`Patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phub_accounts`
--

DROP TABLE IF EXISTS `phub_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phub_accounts` (
  `username` varchar(30) NOT NULL,
  `full_name` varchar(80) NOT NULL,
  `role` enum('System Admin','Head Nurse','Nurse') NOT NULL,
  `status` enum('active','disabled') NOT NULL DEFAULT 'active',
  `salt` char(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `password_hash` char(128) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `created_at` datetime(3) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phub_accounts`
--

LOCK TABLES `phub_accounts` WRITE;
/*!40000 ALTER TABLE `phub_accounts` DISABLE KEYS */;
INSERT INTO `phub_accounts` VALUES ('headnurse','headnurse','Head Nurse','active','f0d4483be3baa6dce5ed871f02c2682b','9750e49680b65fb1a6867cfbe3d41933e61b381703f9d0050df36a50f8d275ccdce3e0b68600fd93e3d0a955ca709808f5ba251fc549061ed052d7b7fe0f9caa','2026-10-24 08:25:15.952'),('nurse1','nurse1','Nurse','active','f58b091525200cdb73f5e8554e96a416','424399cfa4e5740f37541e017f3c189b2dd7c9d8624ec39353f35b5123e5fd3ef67599f37e9681b2b886deefc56021a94e7541037baba20aa13f7658d0f11639','2026-10-24 08:25:16.012'),('nurse2','nurse2','Nurse','active','be682c870fbfb61308ee5537e6d14c51','298a533988fab963835d76ca753387fc1aeef80c7673a9697f1a03c342bc9f39ca11e563e65bad49dac9e30307ef8cf245ba1964f6467fd2067aa0c496706254','2026-10-24 08:25:16.067'),('nurse3','Narse Ako','Nurse','active','a4d307c1be986d15a2e8a66c23dd6cf4','4f6fa8a0f3d4fa620e8acde299fc1d9e8773e0f5ffea7687b85eeea3c37c57564416c5860aa8bc7e55f467e7b744f364d6c0058b1406a1f26510d45101d0121b','2026-10-24 09:03:56.382'),('urdanetasacredhearthospital','System Administrator','System Admin','active','d27305de337f6d111346743426f3fad5','9d699e8c55d289d4bf213266f637f35e920baf95becf999189dfc346625ef288427ca98eb0675ca20a70dda2be38620c7dd56cf3dea7abd930dd33da1c36e6ae','2026-10-24 08:52:13.329');
/*!40000 ALTER TABLE `phub_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phub_cleaning_schedules`
--

DROP TABLE IF EXISTS `phub_cleaning_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phub_cleaning_schedules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `Bed_id` varchar(20) NOT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `status` varchar(40) NOT NULL DEFAULT 'Cleaning Scheduled',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_phub_cleaning_bed` (`Bed_id`),
  KEY `idx_phub_cleaning_times` (`starts_at`,`ends_at`),
  CONSTRAINT `fk_phub_cleaning_bed` FOREIGN KEY (`Bed_id`) REFERENCES `beds` (`Bed_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phub_cleaning_schedules`
--

LOCK TABLES `phub_cleaning_schedules` WRITE;
/*!40000 ALTER TABLE `phub_cleaning_schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `phub_cleaning_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phub_invitations`
--

DROP TABLE IF EXISTS `phub_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phub_invitations` (
  `token_hash` char(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `expires_at` datetime(3) NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `used_at` datetime(3) DEFAULT NULL,
  `used_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`token_hash`),
  KEY `idx_phub_invitations_expiry` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phub_invitations`
--

LOCK TABLES `phub_invitations` WRITE;
/*!40000 ALTER TABLE `phub_invitations` DISABLE KEYS */;
INSERT INTO `phub_invitations` VALUES ('276cde484b1c710c5d321037a92bc5e74820d5c9eb0e73ceea5945689c54b645','2026-10-24 08:58:26.320','2026-10-26 08:58:26.320','urdanetasacredhearthospital','2026-10-24 08:59:42.091','nurse3'),('d3e96a27ebfd7c6a1d9a6be7e15559e7628bc847045c8e87cc190eb131b195fd','2026-10-24 09:03:22.189','2026-10-26 09:03:22.189','urdanetasacredhearthospital','2026-10-24 09:03:56.384','nurse3');
/*!40000 ALTER TABLE `phub_invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phub_promotion_requests`
--

DROP TABLE IF EXISTS `phub_promotion_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phub_promotion_requests` (
  `id` char(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `requester_username` varchar(30) NOT NULL,
  `requester_name` varchar(80) NOT NULL,
  `requested_role` enum('Head Nurse') NOT NULL,
  `status` enum('Pending','Approved','Rejected') NOT NULL,
  `submitted_at` datetime(3) NOT NULL,
  `reviewed_by` varchar(30) DEFAULT NULL,
  `decision` enum('Approved','Rejected') DEFAULT NULL,
  `decision_date` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_phub_promotion_requester` (`requester_username`,`submitted_at`),
  KEY `idx_phub_promotion_status` (`status`,`submitted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phub_promotion_requests`
--

LOCK TABLES `phub_promotion_requests` WRITE;
/*!40000 ALTER TABLE `phub_promotion_requests` DISABLE KEYS */;
INSERT INTO `phub_promotion_requests` VALUES ('1356b91b-46f3-45b3-9566-09a3fa783c7d','nurse3','Narse Ako','Head Nurse','Rejected','2026-10-24 09:04:21.045','headnurse','Rejected','2026-10-24 09:08:02.603');
/*!40000 ALTER TABLE `phub_promotion_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phub_security_audit`
--

DROP TABLE IF EXISTS `phub_security_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phub_security_audit` (
  `id` char(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `at` datetime(3) NOT NULL,
  `event_type` varchar(80) NOT NULL,
  `details` json NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_phub_audit_at` (`at`),
  KEY `idx_phub_audit_event` (`event_type`,`at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phub_security_audit`
--

LOCK TABLES `phub_security_audit` WRITE;
/*!40000 ALTER TABLE `phub_security_audit` DISABLE KEYS */;
INSERT INTO `phub_security_audit` VALUES ('06ce6817-f726-4e3f-98a4-4ff6fda4bf1d','2026-10-24 10:53:29.891','login-success','{\"ip\": \"::1\", \"role\": \"Nurse\", \"username\": \"nurse1\"}'),('076df35a-8d4a-4214-aec2-1e4ffe0e302d','2026-10-24 10:05:03.377','login-success','{\"ip\": \"::1\", \"role\": \"Nurse\", \"username\": \"nurse1\"}'),('0a2384d2-0614-4ac8-be15-39fae7930fc1','2026-10-24 08:58:31.921','logout','{\"username\": \"urdanetasacredhearthospital\"}'),('1886c21b-fbfe-43de-ac5c-f2f7621fd90f','2026-10-24 08:53:43.771','login-failed','{\"ip\": \"::1\", \"username\": \"urdanetasacredhearthospital\"}'),('1d33780d-0b0c-4d4c-a4b1-129b1c3ddd46','2026-10-24 08:58:26.321','invitation-created','{\"role\": \"Nurse\", \"createdBy\": \"urdanetasacredhearthospital\", \"expiresAt\": \"2026-10-26T08:58:26.320Z\"}'),('2758aca6-753f-437a-87e4-179f293c60b6','2026-10-24 09:08:06.437','logout','{\"username\": \"headnurse\"}'),('2f2a2602-4a06-4dfb-82d6-21f869658722','2026-10-24 08:56:50.900','login-success','{\"ip\": \"::1\", \"role\": \"System Admin\", \"username\": \"urdanetasacredhearthospital\"}'),('31e3ada3-d40d-41a7-80af-8c6f7ad2bceb','2026-10-24 09:08:14.854','login-success','{\"ip\": \"::1\", \"role\": \"Nurse\", \"username\": \"nurse3\"}'),('44f391b5-e95c-40f1-9fde-931ff9ce06d3','2026-10-24 08:59:02.754','logout','{\"username\": \"headnurse\"}'),('4b9f0a11-78c8-4029-af45-9a34e77576d7','2026-10-24 08:41:41.189','login-failed','{\"ip\": \"::1\", \"username\": \"admin\"}'),('4ebaee2a-b456-47bf-a467-3f7655790f90','2026-10-24 09:03:09.867','login-success','{\"ip\": \"::1\", \"role\": \"System Admin\", \"username\": \"urdanetasacredhearthospital\"}'),('53ecf506-0537-4373-a326-831c41fea896','2026-10-24 08:41:14.082','logout','{\"username\": \"headnurse\"}'),('5864cc78-a945-4955-a99a-fe28f4879478','2026-10-25 02:23:54.351','login-success','{\"ip\": \"::1\", \"role\": \"System Admin\", \"username\": \"urdanetasacredhearthospital\"}'),('59bc24e6-a78e-4a87-a66e-1590df2a2417','2026-10-24 14:27:59.513','logout','{\"username\": \"nurse1\"}'),('61747883-5e58-4999-9b45-661b8247b383','2026-10-24 09:04:38.732','login-success','{\"ip\": \"::1\", \"role\": \"Head Nurse\", \"username\": \"headnurse\"}'),('62e245d3-b81b-41b5-b5eb-6ea6e5464ebc','2026-10-24 09:04:34.135','login-failed','{\"ip\": \"::1\", \"username\": \"headnurse\"}'),('6550ca9e-d2b8-44fd-a2ad-bbba466b9411','2026-10-24 09:03:32.263','logout','{\"username\": \"urdanetasacredhearthospital\"}'),('708cc89f-6834-4851-94ba-b716112e3457','2026-10-24 08:54:20.786','login-failed','{\"ip\": \"::1\", \"username\": \"urdanetasacredhearthospital\"}'),('79f69e88-505a-4673-8e12-46842bd47422','2026-10-24 08:59:42.093','account-created','{\"role\": \"Nurse\", \"username\": \"nurse3\", \"invitedBy\": \"urdanetasacredhearthospital\"}'),('7c4ae2ab-75dc-4b73-97df-a46744424a5f','2026-10-24 08:58:58.239','login-success','{\"ip\": \"::1\", \"role\": \"Head Nurse\", \"username\": \"headnurse\"}'),('7fdd2cc2-460b-48ce-b3cc-f57464a2129e','2026-10-24 08:54:51.968','login-blocked','{\"ip\": \"::1\", \"reason\": \"cooldown\", \"username\": \"urdanetasacredhearthospital\"}'),('879281da-7fec-4cc2-b8b2-30bd4283e4c1','2026-10-24 13:34:09.193','login-success','{\"ip\": \"::1\", \"role\": \"Nurse\", \"username\": \"nurse1\"}'),('93f7621b-b8d8-4055-adda-dcc28cc9f2df','2026-10-24 09:08:21.287','logout','{\"username\": \"nurse3\"}'),('a1893dca-4021-4f89-a332-4698a9707186','2026-10-25 03:35:38.025','login-success','{\"ip\": \"::1\", \"role\": \"Nurse\", \"username\": \"nurse1\"}'),('abd8d460-8000-4a7d-b8fe-6d2440ba1704','2026-10-24 08:52:13.331','system-admin-seeded','{\"username\": \"urdanetasacredhearthospital\"}'),('bcb5701f-a37f-4afe-aae2-f0b038a2bf3d','2026-10-24 09:08:02.606','promotion-decision','{\"decision\": \"Rejected\", \"requestId\": \"1356b91b-46f3-45b3-9566-09a3fa783c7d\", \"reviewedBy\": \"headnurse\"}'),('bf6eede2-8d26-4d29-88dc-109d35e87b4c','2026-10-24 08:53:56.791','login-failed','{\"ip\": \"::1\", \"username\": \"urdanetasacredhearthospital\"}'),('c446a3e8-1950-41c9-a835-6c2b416fa209','2026-10-24 08:53:23.423','login-failed','{\"ip\": \"::1\", \"username\": \"urdanetasacredhearthospital\"}'),('cc318206-f716-4388-8ca2-be4595934c6e','2026-10-24 08:40:57.931','login-success','{\"ip\": \"::1\", \"role\": \"Head Nurse\", \"username\": \"headnurse\"}'),('d2c210e0-918d-40b1-b496-0000f67cb03a','2026-10-24 10:06:40.955','login-success','{\"ip\": \"::1\", \"role\": \"Nurse\", \"username\": \"nurse1\"}'),('e0b618bc-3a3c-491a-be58-9dae8ad65155','2026-10-24 09:03:56.385','account-created','{\"role\": \"Nurse\", \"username\": \"nurse3\", \"invitedBy\": \"urdanetasacredhearthospital\"}'),('e1f3939a-c536-4106-871d-9f9742465883','2026-10-24 09:03:20.566','admin-deleted-account','{\"username\": \"nurse3\", \"deletedBy\": \"urdanetasacredhearthospital\"}'),('e2ad9af7-23d7-41f0-850b-1e97333e4eaa','2026-10-24 09:03:22.191','invitation-created','{\"role\": \"Nurse\", \"createdBy\": \"urdanetasacredhearthospital\", \"expiresAt\": \"2026-10-26T09:03:22.189Z\"}'),('ee725078-e841-4bbe-969d-e712cdce0bd0','2026-10-24 09:04:21.047','promotion-requested','{\"username\": \"nurse3\"}'),('ef7e307e-cfef-48a4-90e6-2e1503cc49e7','2026-10-24 08:53:58.341','login-failed','{\"ip\": \"::1\", \"username\": \"urdanetasacredhearthospital\"}'),('fdd3fb73-704a-4f9b-831c-0364b23c49f2','2026-10-24 09:00:22.979','login-success','{\"ip\": \"::1\", \"role\": \"Nurse\", \"username\": \"nurse3\"}'),('ffbc2d84-d4c1-4313-94fe-11870fd1ce84','2026-10-24 09:04:26.557','logout','{\"username\": \"nurse3\"}');
/*!40000 ALTER TABLE `phub_security_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `Room_id` varchar(50) NOT NULL,
  `Room_type` enum('Ward','Private','Semi-Private','Intensive Care Unit (ICU)','Maternity') NOT NULL,
  PRIMARY KEY (`Room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES ('103','Ward'),('104','Ward'),('105','Private'),('201','Private'),('202','Private'),('203','Private'),('204','Semi-Private'),('205','Semi-Private'),('206','Ward'),('301','Private'),('302','Private'),('303','Private'),('304','Semi-Private'),('305','Semi-Private'),('306','Ward');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-25 12:06:08
