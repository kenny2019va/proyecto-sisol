-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: db_hospital_v3
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `atencion_medica`
--

DROP TABLE IF EXISTS `atencion_medica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atencion_medica` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cita_id` bigint NOT NULL,
  `medico_id` bigint NOT NULL,
  `motivo_consulta` text NOT NULL,
  `diagnostico` text NOT NULL,
  `tratamiento` text NOT NULL,
  `recomendaciones` text NOT NULL,
  `fecha_atencion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('PENDIENTE','ANULADO','REALIZADO') NOT NULL DEFAULT 'REALIZADO',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cita_id_UNIQUE` (`cita_id`) /*!80000 INVISIBLE */,
  KEY `idx_atencion_medica_medico` (`medico_id`) /*!80000 INVISIBLE */,
  KEY `idx_atencion_medica_fecha_atencion` (`fecha_atencion`) /*!80000 INVISIBLE */,
  KEY `idx_atencion_medica_estado` (`estado`),
  CONSTRAINT `fk_atencion_medica_cita` FOREIGN KEY (`cita_id`) REFERENCES `cita` (`id`),
  CONSTRAINT `fk_atencion_medica_medico` FOREIGN KEY (`medico_id`) REFERENCES `medico` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atencion_medica`
--

LOCK TABLES `atencion_medica` WRITE;
/*!40000 ALTER TABLE `atencion_medica` DISABLE KEYS */;
INSERT INTO `atencion_medica` VALUES (4,71,16,'Dolor de cabeza persistente','Migraña crónica','Analgésicos y reposo','Evitar el estrés, mantener hidratación','2025-07-01 01:33:26','REALIZADO'),(5,72,15,'Dolor abdominal agudo','Gastritis','Inhibidores de bomba de protones','Dieta blanda por 7 días, evitar café y picantes','2025-07-01 01:33:26','REALIZADO');
/*!40000 ALTER TABLE `atencion_medica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cita`
--

DROP TABLE IF EXISTS `cita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cita` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `paciente_id` bigint NOT NULL,
  `disponibilidad_id` bigint NOT NULL,
  `pago_id` bigint NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('CONFIRMADA','CANCELADA','ATENDIDA','NO_ASISTIO') NOT NULL DEFAULT 'CONFIRMADA',
  PRIMARY KEY (`id`),
  UNIQUE KEY `disponibilidad_id_UNIQUE` (`disponibilidad_id`),
  UNIQUE KEY `pago_id_UNIQUE` (`pago_id`),
  KEY `idx_cita_paciente` (`paciente_id`),
  KEY `idx_cita_fecha_creacion` (`fecha_creacion`),
  CONSTRAINT `fk_cita_disponibilidad` FOREIGN KEY (`disponibilidad_id`) REFERENCES `disponibilidad` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cita_paciente` FOREIGN KEY (`paciente_id`) REFERENCES `paciente` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_cita_pago` FOREIGN KEY (`pago_id`) REFERENCES `pago` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita`
--

LOCK TABLES `cita` WRITE;
/*!40000 ALTER TABLE `cita` DISABLE KEYS */;
INSERT INTO `cita` VALUES (71,4,567,29,'2025-07-01 01:20:55','2025-07-01 01:20:55','CONFIRMADA'),(72,10,765,30,'2025-07-01 01:20:55','2025-07-01 01:20:55','CONFIRMADA'),(73,11,478,31,'2025-07-01 01:20:55','2025-07-01 01:20:55','CONFIRMADA'),(74,12,768,32,'2025-07-01 01:20:55','2025-07-01 01:20:55','CONFIRMADA'),(75,13,654,33,'2025-07-01 01:20:55','2025-07-01 01:20:55','CONFIRMADA');
/*!40000 ALTER TABLE `cita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disponibilidad`
--

DROP TABLE IF EXISTS `disponibilidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disponibilidad` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `medico_id` bigint NOT NULL,
  `fecha_disponibilidad` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `disponible` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_disponibilidad_medico` (`medico_id`),
  KEY `idx_disponibilidad_fecha` (`fecha_disponibilidad`),
  CONSTRAINT `fk_disponibilidad_medico` FOREIGN KEY (`medico_id`) REFERENCES `medico` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=838 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibilidad`
--

LOCK TABLES `disponibilidad` WRITE;
/*!40000 ALTER TABLE `disponibilidad` DISABLE KEYS */;
INSERT INTO `disponibilidad` VALUES (478,5,'2025-07-02','07:00:00','08:00:00',0),(479,5,'2025-07-02','08:00:00','09:00:00',1),(480,5,'2025-07-02','09:00:00','10:00:00',1),(481,5,'2025-07-02','10:00:00','11:00:00',1),(482,5,'2025-07-02','11:00:00','12:00:00',1),(483,5,'2025-07-02','12:00:00','13:00:00',1),(484,5,'2025-07-02','13:00:00','14:00:00',1),(485,15,'2025-07-02','07:00:00','08:00:00',1),(486,15,'2025-07-02','08:00:00','09:00:00',1),(487,15,'2025-07-02','09:00:00','10:00:00',1),(488,15,'2025-07-02','10:00:00','11:00:00',1),(489,15,'2025-07-02','11:00:00','12:00:00',1),(490,15,'2025-07-02','12:00:00','13:00:00',1),(491,15,'2025-07-02','13:00:00','14:00:00',1),(492,16,'2025-07-02','13:00:00','14:00:00',1),(493,16,'2025-07-02','14:00:00','15:00:00',1),(494,16,'2025-07-02','15:00:00','16:00:00',1),(495,16,'2025-07-02','16:00:00','17:00:00',1),(496,16,'2025-07-02','17:00:00','18:00:00',1),(497,16,'2025-07-02','18:00:00','19:00:00',1),(498,17,'2025-07-02','07:00:00','08:00:00',1),(499,17,'2025-07-02','08:00:00','09:00:00',1),(500,17,'2025-07-02','09:00:00','10:00:00',1),(501,17,'2025-07-02','10:00:00','11:00:00',1),(502,17,'2025-07-02','11:00:00','12:00:00',1),(503,17,'2025-07-02','12:00:00','13:00:00',1),(504,17,'2025-07-02','13:00:00','14:00:00',1),(505,18,'2025-07-02','13:00:00','14:00:00',1),(506,18,'2025-07-02','14:00:00','15:00:00',1),(507,18,'2025-07-02','15:00:00','16:00:00',1),(508,18,'2025-07-02','16:00:00','17:00:00',1),(509,18,'2025-07-02','17:00:00','18:00:00',1),(510,18,'2025-07-02','18:00:00','19:00:00',1),(511,19,'2025-07-02','07:00:00','08:00:00',1),(512,19,'2025-07-02','08:00:00','09:00:00',1),(513,19,'2025-07-02','09:00:00','10:00:00',1),(514,19,'2025-07-02','10:00:00','11:00:00',1),(515,19,'2025-07-02','11:00:00','12:00:00',1),(516,19,'2025-07-02','12:00:00','13:00:00',1),(517,19,'2025-07-02','13:00:00','14:00:00',1),(518,5,'2025-07-03','07:00:00','08:00:00',1),(519,5,'2025-07-03','08:00:00','09:00:00',1),(520,5,'2025-07-03','09:00:00','10:00:00',1),(521,5,'2025-07-03','10:00:00','11:00:00',1),(522,5,'2025-07-03','11:00:00','12:00:00',1),(523,5,'2025-07-03','12:00:00','13:00:00',1),(524,5,'2025-07-03','13:00:00','14:00:00',1),(525,15,'2025-07-03','07:00:00','08:00:00',1),(526,15,'2025-07-03','08:00:00','09:00:00',1),(527,15,'2025-07-03','09:00:00','10:00:00',1),(528,15,'2025-07-03','10:00:00','11:00:00',1),(529,15,'2025-07-03','11:00:00','12:00:00',1),(530,15,'2025-07-03','12:00:00','13:00:00',1),(531,15,'2025-07-03','13:00:00','14:00:00',1),(532,16,'2025-07-03','13:00:00','14:00:00',1),(533,16,'2025-07-03','14:00:00','15:00:00',1),(534,16,'2025-07-03','15:00:00','16:00:00',1),(535,16,'2025-07-03','16:00:00','17:00:00',1),(536,16,'2025-07-03','17:00:00','18:00:00',1),(537,16,'2025-07-03','18:00:00','19:00:00',1),(538,17,'2025-07-03','07:00:00','08:00:00',1),(539,17,'2025-07-03','08:00:00','09:00:00',1),(540,17,'2025-07-03','09:00:00','10:00:00',1),(541,17,'2025-07-03','10:00:00','11:00:00',1),(542,17,'2025-07-03','11:00:00','12:00:00',1),(543,17,'2025-07-03','12:00:00','13:00:00',1),(544,17,'2025-07-03','13:00:00','14:00:00',1),(545,18,'2025-07-03','13:00:00','14:00:00',1),(546,18,'2025-07-03','14:00:00','15:00:00',1),(547,18,'2025-07-03','15:00:00','16:00:00',1),(548,18,'2025-07-03','16:00:00','17:00:00',1),(549,18,'2025-07-03','17:00:00','18:00:00',1),(550,18,'2025-07-03','18:00:00','19:00:00',1),(551,19,'2025-07-03','07:00:00','08:00:00',1),(552,19,'2025-07-03','08:00:00','09:00:00',1),(553,19,'2025-07-03','09:00:00','10:00:00',1),(554,19,'2025-07-03','10:00:00','11:00:00',1),(555,19,'2025-07-03','11:00:00','12:00:00',1),(556,19,'2025-07-03','12:00:00','13:00:00',1),(557,19,'2025-07-03','13:00:00','14:00:00',1),(558,5,'2025-07-04','07:00:00','08:00:00',1),(559,5,'2025-07-04','08:00:00','09:00:00',1),(560,5,'2025-07-04','09:00:00','10:00:00',1),(561,5,'2025-07-04','10:00:00','11:00:00',1),(562,5,'2025-07-04','11:00:00','12:00:00',1),(563,5,'2025-07-04','12:00:00','13:00:00',1),(564,5,'2025-07-04','13:00:00','14:00:00',1),(565,15,'2025-07-04','07:00:00','08:00:00',1),(566,15,'2025-07-04','08:00:00','09:00:00',1),(567,15,'2025-07-04','09:00:00','10:00:00',1),(568,15,'2025-07-04','10:00:00','11:00:00',1),(569,15,'2025-07-04','11:00:00','12:00:00',1),(570,15,'2025-07-04','12:00:00','13:00:00',1),(571,15,'2025-07-04','13:00:00','14:00:00',1),(572,16,'2025-07-04','13:00:00','14:00:00',1),(573,16,'2025-07-04','14:00:00','15:00:00',1),(574,16,'2025-07-04','15:00:00','16:00:00',1),(575,16,'2025-07-04','16:00:00','17:00:00',1),(576,16,'2025-07-04','17:00:00','18:00:00',0),(577,16,'2025-07-04','18:00:00','19:00:00',1),(578,17,'2025-07-04','07:00:00','08:00:00',1),(579,17,'2025-07-04','08:00:00','09:00:00',1),(580,17,'2025-07-04','09:00:00','10:00:00',1),(581,17,'2025-07-04','10:00:00','11:00:00',1),(582,17,'2025-07-04','11:00:00','12:00:00',1),(583,17,'2025-07-04','12:00:00','13:00:00',1),(584,17,'2025-07-04','13:00:00','14:00:00',1),(585,18,'2025-07-04','13:00:00','14:00:00',1),(586,18,'2025-07-04','14:00:00','15:00:00',1),(587,18,'2025-07-04','15:00:00','16:00:00',1),(588,18,'2025-07-04','16:00:00','17:00:00',1),(589,18,'2025-07-04','17:00:00','18:00:00',1),(590,18,'2025-07-04','18:00:00','19:00:00',1),(591,19,'2025-07-04','07:00:00','08:00:00',1),(592,19,'2025-07-04','08:00:00','09:00:00',1),(593,19,'2025-07-04','09:00:00','10:00:00',1),(594,19,'2025-07-04','10:00:00','11:00:00',1),(595,19,'2025-07-04','11:00:00','12:00:00',1),(596,19,'2025-07-04','12:00:00','13:00:00',1),(597,19,'2025-07-04','13:00:00','14:00:00',1),(598,5,'2025-07-05','07:00:00','08:00:00',1),(599,5,'2025-07-05','08:00:00','09:00:00',1),(600,5,'2025-07-05','09:00:00','10:00:00',1),(601,5,'2025-07-05','10:00:00','11:00:00',1),(602,5,'2025-07-05','11:00:00','12:00:00',1),(603,5,'2025-07-05','12:00:00','13:00:00',1),(604,5,'2025-07-05','13:00:00','14:00:00',1),(605,15,'2025-07-05','07:00:00','08:00:00',1),(606,15,'2025-07-05','08:00:00','09:00:00',1),(607,15,'2025-07-05','09:00:00','10:00:00',1),(608,15,'2025-07-05','10:00:00','11:00:00',1),(609,15,'2025-07-05','11:00:00','12:00:00',1),(610,15,'2025-07-05','12:00:00','13:00:00',1),(611,15,'2025-07-05','13:00:00','14:00:00',1),(612,16,'2025-07-05','13:00:00','14:00:00',1),(613,16,'2025-07-05','14:00:00','15:00:00',1),(614,16,'2025-07-05','15:00:00','16:00:00',1),(615,16,'2025-07-05','16:00:00','17:00:00',1),(616,16,'2025-07-05','17:00:00','18:00:00',1),(617,16,'2025-07-05','18:00:00','19:00:00',1),(618,17,'2025-07-05','07:00:00','08:00:00',1),(619,17,'2025-07-05','08:00:00','09:00:00',1),(620,17,'2025-07-05','09:00:00','10:00:00',1),(621,17,'2025-07-05','10:00:00','11:00:00',1),(622,17,'2025-07-05','11:00:00','12:00:00',1),(623,17,'2025-07-05','12:00:00','13:00:00',1),(624,17,'2025-07-05','13:00:00','14:00:00',1),(625,18,'2025-07-05','13:00:00','14:00:00',1),(626,18,'2025-07-05','14:00:00','15:00:00',1),(627,18,'2025-07-05','15:00:00','16:00:00',1),(628,18,'2025-07-05','16:00:00','17:00:00',1),(629,18,'2025-07-05','17:00:00','18:00:00',1),(630,18,'2025-07-05','18:00:00','19:00:00',1),(631,19,'2025-07-05','07:00:00','08:00:00',1),(632,19,'2025-07-05','08:00:00','09:00:00',1),(633,19,'2025-07-05','09:00:00','10:00:00',1),(634,19,'2025-07-05','10:00:00','11:00:00',1),(635,19,'2025-07-05','11:00:00','12:00:00',1),(636,19,'2025-07-05','12:00:00','13:00:00',1),(637,19,'2025-07-05','13:00:00','14:00:00',1),(638,5,'2025-07-07','07:00:00','08:00:00',1),(639,5,'2025-07-07','08:00:00','09:00:00',1),(640,5,'2025-07-07','09:00:00','10:00:00',1),(641,5,'2025-07-07','10:00:00','11:00:00',1),(642,5,'2025-07-07','11:00:00','12:00:00',1),(643,5,'2025-07-07','12:00:00','13:00:00',1),(644,5,'2025-07-07','13:00:00','14:00:00',1),(645,15,'2025-07-07','07:00:00','08:00:00',1),(646,15,'2025-07-07','08:00:00','09:00:00',1),(647,15,'2025-07-07','09:00:00','10:00:00',1),(648,15,'2025-07-07','10:00:00','11:00:00',1),(649,15,'2025-07-07','11:00:00','12:00:00',1),(650,15,'2025-07-07','12:00:00','13:00:00',1),(651,15,'2025-07-07','13:00:00','14:00:00',1),(652,16,'2025-07-07','13:00:00','14:00:00',1),(653,16,'2025-07-07','14:00:00','15:00:00',1),(654,16,'2025-07-07','15:00:00','16:00:00',0),(655,16,'2025-07-07','16:00:00','17:00:00',1),(656,16,'2025-07-07','17:00:00','18:00:00',1),(657,16,'2025-07-07','18:00:00','19:00:00',1),(658,17,'2025-07-07','07:00:00','08:00:00',1),(659,17,'2025-07-07','08:00:00','09:00:00',1),(660,17,'2025-07-07','09:00:00','10:00:00',1),(661,17,'2025-07-07','10:00:00','11:00:00',1),(662,17,'2025-07-07','11:00:00','12:00:00',1),(663,17,'2025-07-07','12:00:00','13:00:00',1),(664,17,'2025-07-07','13:00:00','14:00:00',1),(665,18,'2025-07-07','13:00:00','14:00:00',1),(666,18,'2025-07-07','14:00:00','15:00:00',1),(667,18,'2025-07-07','15:00:00','16:00:00',1),(668,18,'2025-07-07','16:00:00','17:00:00',1),(669,18,'2025-07-07','17:00:00','18:00:00',1),(670,18,'2025-07-07','18:00:00','19:00:00',1),(671,19,'2025-07-07','07:00:00','08:00:00',1),(672,19,'2025-07-07','08:00:00','09:00:00',1),(673,19,'2025-07-07','09:00:00','10:00:00',1),(674,19,'2025-07-07','10:00:00','11:00:00',1),(675,19,'2025-07-07','11:00:00','12:00:00',1),(676,19,'2025-07-07','12:00:00','13:00:00',1),(677,19,'2025-07-07','13:00:00','14:00:00',1),(678,5,'2025-07-08','07:00:00','08:00:00',1),(679,5,'2025-07-08','08:00:00','09:00:00',1),(680,5,'2025-07-08','09:00:00','10:00:00',1),(681,5,'2025-07-08','10:00:00','11:00:00',1),(682,5,'2025-07-08','11:00:00','12:00:00',1),(683,5,'2025-07-08','12:00:00','13:00:00',1),(684,5,'2025-07-08','13:00:00','14:00:00',1),(685,15,'2025-07-08','07:00:00','08:00:00',1),(686,15,'2025-07-08','08:00:00','09:00:00',1),(687,15,'2025-07-08','09:00:00','10:00:00',1),(688,15,'2025-07-08','10:00:00','11:00:00',1),(689,15,'2025-07-08','11:00:00','12:00:00',1),(690,15,'2025-07-08','12:00:00','13:00:00',1),(691,15,'2025-07-08','13:00:00','14:00:00',1),(692,16,'2025-07-08','13:00:00','14:00:00',1),(693,16,'2025-07-08','14:00:00','15:00:00',1),(694,16,'2025-07-08','15:00:00','16:00:00',1),(695,16,'2025-07-08','16:00:00','17:00:00',1),(696,16,'2025-07-08','17:00:00','18:00:00',1),(697,16,'2025-07-08','18:00:00','19:00:00',1),(698,17,'2025-07-08','07:00:00','08:00:00',1),(699,17,'2025-07-08','08:00:00','09:00:00',1),(700,17,'2025-07-08','09:00:00','10:00:00',1),(701,17,'2025-07-08','10:00:00','11:00:00',1),(702,17,'2025-07-08','11:00:00','12:00:00',1),(703,17,'2025-07-08','12:00:00','13:00:00',1),(704,17,'2025-07-08','13:00:00','14:00:00',1),(705,18,'2025-07-08','13:00:00','14:00:00',1),(706,18,'2025-07-08','14:00:00','15:00:00',1),(707,18,'2025-07-08','15:00:00','16:00:00',1),(708,18,'2025-07-08','16:00:00','17:00:00',1),(709,18,'2025-07-08','17:00:00','18:00:00',1),(710,18,'2025-07-08','18:00:00','19:00:00',1),(711,19,'2025-07-08','07:00:00','08:00:00',1),(712,19,'2025-07-08','08:00:00','09:00:00',1),(713,19,'2025-07-08','09:00:00','10:00:00',1),(714,19,'2025-07-08','10:00:00','11:00:00',1),(715,19,'2025-07-08','11:00:00','12:00:00',1),(716,19,'2025-07-08','12:00:00','13:00:00',1),(717,19,'2025-07-08','13:00:00','14:00:00',1),(718,5,'2025-07-09','07:00:00','08:00:00',1),(719,5,'2025-07-09','08:00:00','09:00:00',1),(720,5,'2025-07-09','09:00:00','10:00:00',1),(721,5,'2025-07-09','10:00:00','11:00:00',1),(722,5,'2025-07-09','11:00:00','12:00:00',1),(723,5,'2025-07-09','12:00:00','13:00:00',1),(724,5,'2025-07-09','13:00:00','14:00:00',1),(725,15,'2025-07-09','07:00:00','08:00:00',1),(726,15,'2025-07-09','08:00:00','09:00:00',1),(727,15,'2025-07-09','09:00:00','10:00:00',1),(728,15,'2025-07-09','10:00:00','11:00:00',1),(729,15,'2025-07-09','11:00:00','12:00:00',1),(730,15,'2025-07-09','12:00:00','13:00:00',1),(731,15,'2025-07-09','13:00:00','14:00:00',1),(732,16,'2025-07-09','13:00:00','14:00:00',1),(733,16,'2025-07-09','14:00:00','15:00:00',1),(734,16,'2025-07-09','15:00:00','16:00:00',1),(735,16,'2025-07-09','16:00:00','17:00:00',1),(736,16,'2025-07-09','17:00:00','18:00:00',1),(737,16,'2025-07-09','18:00:00','19:00:00',1),(738,17,'2025-07-09','07:00:00','08:00:00',1),(739,17,'2025-07-09','08:00:00','09:00:00',1),(740,17,'2025-07-09','09:00:00','10:00:00',1),(741,17,'2025-07-09','10:00:00','11:00:00',1),(742,17,'2025-07-09','11:00:00','12:00:00',1),(743,17,'2025-07-09','12:00:00','13:00:00',1),(744,17,'2025-07-09','13:00:00','14:00:00',1),(745,18,'2025-07-09','13:00:00','14:00:00',1),(746,18,'2025-07-09','14:00:00','15:00:00',1),(747,18,'2025-07-09','15:00:00','16:00:00',1),(748,18,'2025-07-09','16:00:00','17:00:00',1),(749,18,'2025-07-09','17:00:00','18:00:00',1),(750,18,'2025-07-09','18:00:00','19:00:00',1),(751,19,'2025-07-09','07:00:00','08:00:00',1),(752,19,'2025-07-09','08:00:00','09:00:00',1),(753,19,'2025-07-09','09:00:00','10:00:00',1),(754,19,'2025-07-09','10:00:00','11:00:00',1),(755,19,'2025-07-09','11:00:00','12:00:00',1),(756,19,'2025-07-09','12:00:00','13:00:00',1),(757,19,'2025-07-09','13:00:00','14:00:00',1),(758,5,'2025-07-10','07:00:00','08:00:00',1),(759,5,'2025-07-10','08:00:00','09:00:00',1),(760,5,'2025-07-10','09:00:00','10:00:00',1),(761,5,'2025-07-10','10:00:00','11:00:00',1),(762,5,'2025-07-10','11:00:00','12:00:00',1),(763,5,'2025-07-10','12:00:00','13:00:00',1),(764,5,'2025-07-10','13:00:00','14:00:00',1),(765,15,'2025-07-10','07:00:00','08:00:00',0),(766,15,'2025-07-10','08:00:00','09:00:00',1),(767,15,'2025-07-10','09:00:00','10:00:00',1),(768,15,'2025-07-10','10:00:00','11:00:00',0),(769,15,'2025-07-10','11:00:00','12:00:00',1),(770,15,'2025-07-10','12:00:00','13:00:00',1),(771,15,'2025-07-10','13:00:00','14:00:00',1),(772,16,'2025-07-10','13:00:00','14:00:00',1),(773,16,'2025-07-10','14:00:00','15:00:00',1),(774,16,'2025-07-10','15:00:00','16:00:00',1),(775,16,'2025-07-10','16:00:00','17:00:00',1),(776,16,'2025-07-10','17:00:00','18:00:00',1),(777,16,'2025-07-10','18:00:00','19:00:00',1),(778,17,'2025-07-10','07:00:00','08:00:00',1),(779,17,'2025-07-10','08:00:00','09:00:00',1),(780,17,'2025-07-10','09:00:00','10:00:00',1),(781,17,'2025-07-10','10:00:00','11:00:00',1),(782,17,'2025-07-10','11:00:00','12:00:00',1),(783,17,'2025-07-10','12:00:00','13:00:00',1),(784,17,'2025-07-10','13:00:00','14:00:00',1),(785,18,'2025-07-10','13:00:00','14:00:00',1),(786,18,'2025-07-10','14:00:00','15:00:00',1),(787,18,'2025-07-10','15:00:00','16:00:00',1),(788,18,'2025-07-10','16:00:00','17:00:00',1),(789,18,'2025-07-10','17:00:00','18:00:00',1),(790,18,'2025-07-10','18:00:00','19:00:00',1),(791,19,'2025-07-10','07:00:00','08:00:00',1),(792,19,'2025-07-10','08:00:00','09:00:00',1),(793,19,'2025-07-10','09:00:00','10:00:00',1),(794,19,'2025-07-10','10:00:00','11:00:00',1),(795,19,'2025-07-10','11:00:00','12:00:00',1),(796,19,'2025-07-10','12:00:00','13:00:00',1),(797,19,'2025-07-10','13:00:00','14:00:00',1),(798,5,'2025-07-11','07:00:00','08:00:00',1),(799,5,'2025-07-11','08:00:00','09:00:00',1),(800,5,'2025-07-11','09:00:00','10:00:00',1),(801,5,'2025-07-11','10:00:00','11:00:00',1),(802,5,'2025-07-11','11:00:00','12:00:00',1),(803,5,'2025-07-11','12:00:00','13:00:00',1),(804,5,'2025-07-11','13:00:00','14:00:00',1),(805,15,'2025-07-11','07:00:00','08:00:00',1),(806,15,'2025-07-11','08:00:00','09:00:00',1),(807,15,'2025-07-11','09:00:00','10:00:00',1),(808,15,'2025-07-11','10:00:00','11:00:00',1),(809,15,'2025-07-11','11:00:00','12:00:00',1),(810,15,'2025-07-11','12:00:00','13:00:00',1),(811,15,'2025-07-11','13:00:00','14:00:00',1),(812,16,'2025-07-11','13:00:00','14:00:00',1),(813,16,'2025-07-11','14:00:00','15:00:00',1),(814,16,'2025-07-11','15:00:00','16:00:00',1),(815,16,'2025-07-11','16:00:00','17:00:00',1),(816,16,'2025-07-11','17:00:00','18:00:00',1),(817,16,'2025-07-11','18:00:00','19:00:00',1),(818,17,'2025-07-11','07:00:00','08:00:00',1),(819,17,'2025-07-11','08:00:00','09:00:00',1),(820,17,'2025-07-11','09:00:00','10:00:00',1),(821,17,'2025-07-11','10:00:00','11:00:00',1),(822,17,'2025-07-11','11:00:00','12:00:00',1),(823,17,'2025-07-11','12:00:00','13:00:00',1),(824,17,'2025-07-11','13:00:00','14:00:00',1),(825,18,'2025-07-11','13:00:00','14:00:00',1),(826,18,'2025-07-11','14:00:00','15:00:00',1),(827,18,'2025-07-11','15:00:00','16:00:00',1),(828,18,'2025-07-11','16:00:00','17:00:00',1),(829,18,'2025-07-11','17:00:00','18:00:00',1),(830,18,'2025-07-11','18:00:00','19:00:00',1),(831,19,'2025-07-11','07:00:00','08:00:00',1),(832,19,'2025-07-11','08:00:00','09:00:00',1),(833,19,'2025-07-11','09:00:00','10:00:00',1),(834,19,'2025-07-11','10:00:00','11:00:00',1),(835,19,'2025-07-11','11:00:00','12:00:00',1),(836,19,'2025-07-11','12:00:00','13:00:00',1),(837,19,'2025-07-11','13:00:00','14:00:00',1);
/*!40000 ALTER TABLE `disponibilidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidad`
--

DROP TABLE IF EXISTS `especialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especialidad` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  KEY `idx_especialidad_nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidad`
--

LOCK TABLES `especialidad` WRITE;
/*!40000 ALTER TABLE `especialidad` DISABLE KEYS */;
INSERT INTO `especialidad` VALUES (2,'Cardiología','Diagnóstico y tratamiento de enfermedades del corazón y el sistema circulatorio.','2025-07-01 00:29:55'),(3,'Pediatría','Atención médica integral a niños, desde el nacimiento hasta la adolescencia.','2025-07-01 00:29:55'),(4,'Dermatología','Diagnóstico y tratamiento de enfermedades de la piel, cabello y uñas.','2025-07-01 00:29:55'),(5,'Ginecología y Obstetricia','Salud reproductiva femenina, embarazo, parto y puerperio.','2025-07-01 00:29:55'),(6,'Oftalmología','Diagnóstico y tratamiento de enfermedades y trastornos de los ojos.','2025-07-01 00:29:55'),(7,'Traumatología y Ortopedia','Diagnóstico y tratamiento de lesiones y enfermedades del sistema musculoesquelético.','2025-07-01 00:29:55'),(8,'Medicina General','Atención primaria de salud, prevención, diagnóstico y tratamiento de enfermedades comunes.','2025-07-01 00:29:55'),(9,'Odontología','Diagnóstico, prevención y tratamiento de enfermedades bucodentales.','2025-07-01 00:29:55');
/*!40000 ALTER TABLE `especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historia_clinica`
--

DROP TABLE IF EXISTS `historia_clinica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historia_clinica` (
  `id` bigint NOT NULL,
  `grupo_sanguineo` enum('A+','A-','B+','B-','AB+','AB-','O-','O+') NOT NULL,
  `alergias` text NOT NULL,
  `enfermedades_cronicas` text NOT NULL,
  `antecedentes_personales` text NOT NULL,
  `antecedentes_familiares` text NOT NULL,
  `medicacion_actual` text NOT NULL,
  `discapacidad` text NOT NULL,
  `vacunacion` text NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_historia_clinica_paciente` FOREIGN KEY (`id`) REFERENCES `paciente` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historia_clinica`
--

LOCK TABLES `historia_clinica` WRITE;
/*!40000 ALTER TABLE `historia_clinica` DISABLE KEYS */;
INSERT INTO `historia_clinica` VALUES (4,'O+','Penicilina','Hipertensión Arterial','Apéndice extirpado a los 15 años','Diabetes tipo 2 (padre)','Losartán 50mg','Ninguna','Influenza, Tétanos','2025-07-01 01:36:39','2025-07-01 01:36:39'),(10,'A-','Ninguna conocida','Asma','Fractura de clavícula a los 20 años','Cáncer (abuela materna)','Salbutamol inhalador','Ninguna','COVID-19 (dosis completa)','2025-07-01 01:36:50','2025-07-01 01:36:50'),(11,'B+','Ácaros del polvo','Ninguna','Amigdalectomía en la infancia','Enfermedad cardíaca (abuelo paterno)','Ninguna','Leve deficiencia auditiva','Hepatitis B (dosis completa)','2025-07-01 01:36:50','2025-07-01 01:36:50');
/*!40000 ALTER TABLE `historia_clinica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medico`
--

DROP TABLE IF EXISTS `medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medico` (
  `id` bigint NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `numero_colegiado` varchar(6) NOT NULL,
  `turno` enum('MANANA','TARDE') CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `hora_inicio_turno` time NOT NULL,
  `hora_fin_turno` time NOT NULL,
  `especialidad_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_colegiado_UNIQUE` (`numero_colegiado`) /*!80000 INVISIBLE */,
  KEY `fk_medico_especialidad_idx` (`especialidad_id`),
  CONSTRAINT `fk_medico_usuario` FOREIGN KEY (`id`) REFERENCES `usuario` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `chk_medico_horario_fin_turno` CHECK ((`hora_fin_turno` in ('14:00:00','19:00:00'))),
  CONSTRAINT `chk_medico_horario_inicio_turno` CHECK ((`hora_inicio_turno` in ('07:00:00','13:00:00')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medico`
--

LOCK TABLES `medico` WRITE;
/*!40000 ALTER TABLE `medico` DISABLE KEYS */;
INSERT INTO `medico` VALUES (5,'Marco','Velarde Rojas','345612','MANANA','07:00:00','14:00:00',2),(15,'Andrés','López García','054321','MANANA','07:00:00','14:00:00',2),(16,'Sofía','Gómez Ruiz','345678','TARDE','13:00:00','19:00:00',3),(17,'Ricardo','Fernández Díaz','069423','MANANA','07:00:00','14:00:00',4),(18,'Valeria','Rodríguez Soto','567823','TARDE','13:00:00','19:00:00',5),(19,'Gabriel','Martínez Chávez','063312','MANANA','07:00:00','14:00:00',8);
/*!40000 ALTER TABLE `medico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paciente` (
  `id` bigint NOT NULL,
  `dni` varchar(8) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `estado_civil` enum('SOLTERO','CASADO','DIVORCIADO','VIUDO') NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `contacto_emergencia_nombre` varchar(100) NOT NULL,
  `contacto_emergencia_telefono` varchar(11) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `sexo` enum('MASCULINO','FEMENINO') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dni_UNIQUE` (`dni`),
  CONSTRAINT `fk_paciente_usuario` FOREIGN KEY (`id`) REFERENCES `usuario` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
INSERT INTO `paciente` VALUES (4,'12345678','Victor','Hugo','345612569','SOLTERO','calla falsa 123','Maria','457890341','2002-03-21','MASCULINO'),(10,'12345672','Juan','Perez Garcia','987654321','SOLTERO','Av. Las Flores 123, Miraflores','Maria Lopez','912345678','1990-05-15','MASCULINO'),(11,'87654321','Maria','Gonzalez Ramirez','976543210','CASADO','Calle Los Jazmines 456, San Isidro','Carlos Perez','987654321','1985-11-20','FEMENINO'),(12,'45678901','Carlos','Rodriguez Soto','965432109','SOLTERO','Jr. La Paz 789, Barranco','Ana Diaz','912345678','1992-03-10','MASCULINO'),(13,'01234567','Ana','Lopez Torres','954321098','DIVORCIADO','Av. El Sol 101, Santiago de Surco','Pedro Sanchez','987654321','1978-08-25','FEMENINO'),(14,'78901234','Pedro','Sanchez Vargas','943210987','CASADO','Calle Real 202, Lince','Laura Fernandez','976543210','1980-01-01','MASCULINO');
/*!40000 ALTER TABLE `paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pago`
--

DROP TABLE IF EXISTS `pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pago` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `monto` decimal(10,0) NOT NULL,
  `fecha_pago` datetime NOT NULL,
  `codigo_transaccion` bigint NOT NULL,
  `estado` enum('PENDIENTE','CONFIRMADO','RECHAZADO') NOT NULL DEFAULT 'CONFIRMADO',
  `comprobante` enum('BOLETA_VENTA','FACTURA') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_transaccion_UNIQUE` (`codigo_transaccion`),
  KEY `idx_pago_fecha` (`fecha_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pago`
--

LOCK TABLES `pago` WRITE;
/*!40000 ALTER TABLE `pago` DISABLE KEYS */;
INSERT INTO `pago` VALUES (29,76,'2025-07-01 09:30:00',1,'CONFIRMADO','BOLETA_VENTA'),(30,120,'2025-07-01 10:15:00',2,'CONFIRMADO','FACTURA'),(31,46,'2025-07-01 11:00:00',3,'CONFIRMADO','BOLETA_VENTA'),(32,200,'2025-07-01 12:45:00',4,'CONFIRMADO','FACTURA'),(33,90,'2025-07-01 13:30:00',5,'CONFIRMADO','BOLETA_VENTA');
/*!40000 ALTER TABLE `pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_administrativo`
--

DROP TABLE IF EXISTS `personal_administrativo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_administrativo` (
  `id` bigint NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `cargo` enum('ADMINISTRADOR_SISTEMAS','ASISTENTE_ADMINISTRATIVO','JEFE_DE_AREA') NOT NULL,
  `tipo_contrato` enum('NOMBRADO','CONTRATADO','TERCERIZADO') NOT NULL,
  `area` enum('RECURSOS_HUMANOS','SISTEMAS','DIRECCION') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_personal_administrativo_usuario` FOREIGN KEY (`id`) REFERENCES `usuario` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_administrativo`
--

LOCK TABLES `personal_administrativo` WRITE;
/*!40000 ALTER TABLE `personal_administrativo` DISABLE KEYS */;
INSERT INTO `personal_administrativo` VALUES (6,'Belen','Molly','JEFE_DE_AREA','NOMBRADO','RECURSOS_HUMANOS');
/*!40000 ALTER TABLE `personal_administrativo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicio`
--

DROP TABLE IF EXISTS `servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicio` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `precio_servicio` decimal(10,2) NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `especialidad_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  KEY `idx_servicio_especialidad` (`especialidad_id`),
  KEY `idx_servicio_nombre` (`nombre`),
  CONSTRAINT `fk_especialidad_servicio` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio`
--

LOCK TABLES `servicio` WRITE;
/*!40000 ALTER TABLE `servicio` DISABLE KEYS */;
INSERT INTO `servicio` VALUES (2,'Consulta Cardiológica General','Evaluación médica del corazón y sistema circulatorio.',50.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',2),(3,'Electrocardiograma (ECG)','Registro de la actividad eléctrica del corazón.',35.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',2),(4,'Consulta Pediátrica de Niño Sano','Control de crecimiento y desarrollo del niño.',45.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',3),(5,'Vacunación (Aplicación)','Administración de vacunas según calendario.',20.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',3),(6,'Consulta Dermatológica','Diagnóstico y tratamiento de afecciones de la piel.',55.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',4),(7,'Crioterapia de Verrugas','Tratamiento de verrugas con nitrógeno líquido.',70.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',4),(8,'Consulta Ginecológica','Control y prevención de enfermedades ginecológicas.',50.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',5),(9,'Ecografía Pélvica/Transvaginal','Estudio ecográfico de los órganos reproductores femeninos.',80.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',5),(10,'Consulta Oftalmológica General','Examen de la vista y detección de problemas oculares.',50.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',6),(11,'Medida de la Vista y Receta','Determinación de la graduación para lentes.',40.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',6),(12,'Consulta Traumatológica','Evaluación de lesiones óseas y musculares.',60.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',7),(13,'Infiltración de Articulación','Aplicación de medicamento en una articulación.',90.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',7),(14,'Consulta Médica General','Evaluación y tratamiento de enfermedades comunes.',35.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',8),(15,'Control de Presión Arterial','Monitoreo y seguimiento de la presión arterial.',15.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',8),(16,'Consulta Odontológica General','Revisión y diagnóstico de la salud bucal.',40.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',9),(17,'Limpieza Dental (Profilaxis)','Remoción de placa y sarro.',65.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',9),(18,'Curación Simple (Resina)','Restauración de una pieza dental con resina.',85.00,'2025-07-01 00:37:39','2025-07-01 00:37:39',9);
/*!40000 ALTER TABLE `servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rol` enum('ROLE_PACIENTE','ROLE_MEDICO','ROLE_PERSONAL_ADMINISTRATIVO') NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activo` tinyint NOT NULL DEFAULT '1',
  `correo` varchar(100) NOT NULL,
  `contrasenia` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `correo_UNIQUE` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (4,'ROLE_PACIENTE','2025-06-30 14:03:34','2025-06-30 14:03:34',1,'dummy@gmail.com','123'),(5,'ROLE_MEDICO','2025-06-30 14:05:49','2025-06-30 14:05:49',1,'medico@sisol.com','123'),(6,'ROLE_PERSONAL_ADMINISTRATIVO','2025-06-30 14:06:49','2025-06-30 14:06:49',1,'administrador@sisol.com','322'),(10,'ROLE_PACIENTE','2025-07-01 00:21:07','2025-07-01 00:21:07',1,'juan.perez@gmail.com','contrasenaPaciente1'),(11,'ROLE_PACIENTE','2025-07-01 00:21:07','2025-07-01 00:21:07',1,'maria.gonzalez@gmail.com','contrasenaPaciente2'),(12,'ROLE_PACIENTE','2025-07-01 00:21:07','2025-07-01 00:21:07',1,'carlos.rodriguez@gmail.com','contrasenaPaciente3'),(13,'ROLE_PACIENTE','2025-07-01 00:21:07','2025-07-01 00:21:07',1,'ana.lopez@gmail.com','contrasenaPaciente4'),(14,'ROLE_PACIENTE','2025-07-01 00:21:07','2025-07-01 00:21:07',1,'pedro.sanchez@gmail.com','contrasenaPaciente5'),(15,'ROLE_MEDICO','2025-07-01 00:40:38','2025-07-01 00:40:38',1,'dr.lopez@sisol.com.pe','medicoSecure1'),(16,'ROLE_MEDICO','2025-07-01 00:40:38','2025-07-01 00:40:38',1,'dra.gomez@sisol.com.pe','medicoSecure2'),(17,'ROLE_MEDICO','2025-07-01 00:40:38','2025-07-01 00:40:38',1,'dr.fernandez@sisol.com.pe','medicoSecure3'),(18,'ROLE_MEDICO','2025-07-01 00:40:38','2025-07-01 00:40:38',1,'dra.rodriguez@sisol.com.pe','medicoSecure4'),(19,'ROLE_MEDICO','2025-07-01 00:40:38','2025-07-01 00:40:38',1,'dr.martinez@sisol.com.pe','medicoSecure5');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_hospital_v3'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_generar_disponibilidades_proximos_10_dias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_generar_disponibilidades_proximos_10_dias`()
BEGIN
    DECLARE v_id BIGINT;
    DECLARE v_turno VARCHAR(20);
    DECLARE v_inicio TIME;
    DECLARE v_fin TIME;
    DECLARE v_hora TIME;
    DECLARE v_fecha DATE;
    DECLARE v_dia INT DEFAULT 1;
    DECLARE done INT DEFAULT FALSE;

    DECLARE cur CURSOR FOR SELECT id, turno FROM medico;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    dias_loop: WHILE v_dia <= 10 DO
        SET v_fecha = CURDATE() + INTERVAL v_dia DAY;

        -- Saltar domingos
        IF DAYOFWEEK(v_fecha) = 1 THEN
            SET v_dia =v_dia+1;
            ITERATE dias_loop;
        END IF;

        OPEN cur;

        read_loop: LOOP
            FETCH cur INTO v_id, v_turno;
            IF done THEN
                LEAVE read_loop;
            END IF;

            IF v_turno = 'MANANA' THEN
                SET v_inicio = '07:00:00';
                SET v_fin = '14:00:00';
            ELSEIF v_turno = 'TARDE' THEN
                SET v_inicio = '13:00:00';
                SET v_fin = '19:00:00';
            ELSE
                ITERATE read_loop;
            END IF;

            SET v_hora = v_inicio;

            WHILE v_hora < v_fin DO
                IF NOT EXISTS (
                    SELECT 1 FROM disponibilidad 
                    WHERE medico_id = v_id 
                    AND fecha_disponibilidad = v_fecha 
                    AND hora_inicio = v_hora
                ) THEN
                    INSERT INTO disponibilidad (
                        medico_id, fecha_disponibilidad, hora_inicio, hora_fin, disponible
                    ) VALUES (
                        v_id, v_fecha, v_hora, ADDTIME(v_hora, '01:00:00'), TRUE
                    );
                END IF;
                SET v_hora = ADDTIME(v_hora, '01:00:00');
            END WHILE;
        END LOOP;

        CLOSE cur;
        SET done = FALSE;
        SET v_dia = v_dia + 1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_limpiar_disponibilidades_pasadas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_limpiar_disponibilidades_pasadas`()
BEGIN
    DELETE FROM disponibilidad 
    WHERE fecha_disponibilidad < CURDATE() AND disponible = 1 and id is not null LIMIT 1000;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_cita` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_cita`(
in p_idPaciente bigint,
in p_idDisponibilidad bigint,
in p_idPago bigint
)
begin
Declare v_estadoDisp tinyint;
-- validaciones de los parametros
if p_idpaciente is null then
signal sqlstate '45000' set message_text = 'idPaciente  null';
end if;
if p_idDisponibilidad is null then
signal sqlstate '45000' set message_text = 'idDisponibilidad null';
end if;
if p_idPago is null then
signal sqlstate '45000' set message_text = 'idPago  null';
end if;

-- obtener el estado
select d.disponible into v_estadoDisp from disponibilidad as d where d.id = p_idDisponibilidad;
-- validar si el slot esta ocupado
IF v_estadoDisp = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No puede reservar en un slot ocupado';
END IF;

-- registrar una cita
insert into cita(paciente_id, disponibilidad_id, pago_id, fecha_creacion, fecha_actualizacion,estado)
values(p_idPaciente, p_idDisponibilidad, p_idPago,current_timestamp(), current_timestamp(),'CONFIRMADA');
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_pago` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_pago`(
in p_codTransaccion bigint,
in p_tipoComprobante Varchar(20),
in p_montoPagado Decimal(10,2),
out p_idPago bigint
)
BEGIN

-- validar que el codigo no sea null
if p_codTransaccion is null then
	signal sqlstate '45000' set message_text = 'El codigo de transaccion null';
end if;

-- validar tipo comprobante 
if p_tipoComprobante is null  then
	signal sqlstate '45000' set message_text = 'tipo de comprobante null';
end if;

if  p_tipoComprobante not in ('BOLETA_VENTA', 'FACTURA') then
	signal sqlstate '45000' set message_text = 'tipo de comprobante invalido';
end if;
-- validar comprobante
if p_montoPagado is null then
	signal sqlstate '45000' set message_text = 'monto null';
end if;

if p_montoPagado < 0 then
	signal sqlstate '45000' set message_text = 'monto invalido';
end if;

-- se inicia la creacion del registro de pago
insert into pago(monto, fecha_pago, codigo_transaccion, estado, comprobante) values (p_montoPagado, current_timestamp(), p_codTransaccion,'CONFIRMADO',p_tipoComprobante );
set p_idPago = last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reporte_citas_paciente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_citas_paciente`(
in p_idPaciente bigint,
in p_estadoCita varchar(25),
in p_fechaCita date
)
begin
SELECT
	-- campos necesarios
    c.id AS idCita, 
    d.fecha_disponibilidad AS fechaCita, 
    CONCAT(d.hora_inicio, ' - ', d.hora_fin) AS horaCita,
    e.nombre AS especialidadNombre,
    s.nombre AS nombreServicio, 
    c.estado
    --
FROM cita AS c
JOIN disponibilidad AS d ON c.disponibilidad_id = d.id
JOIN medico AS m ON m.id = d.medico_id
JOIN especialidad AS e ON e.id = m.especialidad_id
JOIN servicio AS s ON s.especialidad_id = e.id
-- busqueda personalizada
WHERE 
(c.paciente_id = p_idPaciente or p_idPaciente is null) and
(c.estado = p_estadoCita or p_estadoCita is null) and
(d.fecha_disponibilidad<= p_fechaCita or p_fechaCita is null)
order by d.fecha_disponibilidad desc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_verificacion_correo_activo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_verificacion_correo_activo`(
in p_correo varchar(80)
)
begin
    declare v_rol varchar(50) default "";
    
    if not exists ( select 1 from usuario where correo = p_correo) then
		signal sqlstate '45000' set message_text = 'Correo incorrecto';
    end if;
    if not exists ( select 1 from usuario where activo = 1 and correo = p_correo) then
		signal sqlstate '45000' set message_text = 'Su cuenta esta inactiva';
    end if;
    select rol into v_rol from usuario where correo = p_correo;
	if v_rol ='ROLE_PACIENTE' then
		select u.id, u.correo, u.contrasenia, u.rol, u.activo, p.nombres from usuario as u join paciente as p on u.id=p.id;
	elseif v_rol ='ROLE_MEDICO' then
		select u.id, u.correo, u.contrasenia, u.rol, u.activo, m.nombres from usuario as u join medico as m on u.id=m.id;
	elseif v_rol ='ROLE_PERSONAL_ADMINISTRATIVO' then
		select u.id, u.correo, u.contrasenia, u.rol, u.activo, pa.nombres from usuario as u join personal_administrativo as pa on u.id=pa.id;
	else 
		signal sqlstate '45000' set message_text = 'Rol no identificado';
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-01  1:44:11
