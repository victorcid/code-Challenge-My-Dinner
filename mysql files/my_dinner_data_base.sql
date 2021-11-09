CREATE DATABASE  IF NOT EXISTS `dinner` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `dinner`;
-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: dinner
-- ------------------------------------------------------
-- Server version	8.0.14

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(65) NOT NULL,
  `nombre` varchar(103) NOT NULL,
  `telefono` bigint(12) NOT NULL,
  `whatsapp` tinyint(1) DEFAULT '0',
  `fecha_creacion` datetime NOT NULL,
  `fecha_ultimo_pedido` datetime DEFAULT NULL,
  `id_ultimo_domicilio` int(11) DEFAULT NULL,
  `estatus` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'cliente1@mail.com','cliente 1',8331112222,0,'2021-10-05 07:27:00','2021-11-08 17:43:07',1,1),(6,'cliente2@mail.com','cliente 2',8331562222,1,'2021-10-05 07:27:00',NULL,NULL,1),(7,'cliente3@mail.com','cliente 3',8330002222,0,'2021-10-05 07:27:00',NULL,NULL,1),(8,'cliente4@mail.com','cliente 4',528331132622,1,'2021-10-05 07:27:00',NULL,NULL,1),(9,'cliente5@mail.com','cliente 5',528331112222,0,'2021-10-05 07:27:00',NULL,NULL,1),(10,'cliente6@mail.com','cliente 6',8331241149,1,'2021-11-08 17:51:40',NULL,NULL,0);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domicilios`
--

DROP TABLE IF EXISTS `domicilios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `domicilios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  `calle` varchar(255) NOT NULL,
  `numero` varchar(6) NOT NULL,
  `numero_interior` varchar(6) DEFAULT NULL,
  `codigo_postal` int(6) NOT NULL,
  `colonia` varchar(255) NOT NULL,
  `municipio` varchar(45) NOT NULL,
  `estado` varchar(45) NOT NULL,
  `pais` varchar(45) DEFAULT NULL,
  `entre_calle_1` varchar(255) DEFAULT NULL,
  `entre_calle_2` varchar(255) DEFAULT NULL,
  `descripcion` text,
  `estatus` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domicilios`
--

LOCK TABLES `domicilios` WRITE;
/*!40000 ALTER TABLE `domicilios` DISABLE KEYS */;
INSERT INTO `domicilios` VALUES (1,1,'1','1001',NULL,89410,'alvaro','jalapa','Veracruz','mexico','A','B','casa verde',1),(2,1,'2','1002','a',89410,'enrique','jalapa','Veracruz','mexico','C','D','casa amarilla',0),(3,1,'3','1003','10',89410,'obrador','jalapa','Veracruz','mexico','E','F','casa roja',1),(4,2,'4','1004',NULL,89410,'cesar','jalapa','Veracruz','mexico','G','H','casa blanca',1),(5,3,'5','1005','1',89410,'flor','jalapa','Veracruz','mexico','calle A','calle B','casa negra',1),(6,3,'6','1006',NULL,89410,'romo','jalapa','Veracruz','mexico','calle  a','calle b','casa gris',1),(7,4,'7','1007',NULL,89410,'laguna','jalapa','Veracruz','mexico',NULL,NULL,NULL,1),(8,4,'8','1008 A',NULL,89410,'anguila','jalapa','Veracruz','mexico',NULL,NULL,NULL,1),(9,4,'9','1009',NULL,89410,'manzano','jalapa','Veracruz','mexico',NULL,NULL,NULL,1),(10,4,'10','2000','5B',89410,'carranza','jalapa','Veracruz','mexico',NULL,NULL,NULL,1),(11,5,'11','1',NULL,89410,'avila','jalapa','Veracruz','mexico',NULL,NULL,NULL,1),(12,5,'11','1','5A',89410,'avila','jalapa','Veracruz','mexico','J','K','departament gris',1),(13,5,'1','1','1',1,'1','1','1','1','1','1','1',1),(14,1,'10','101','',89311,'enrique','jalapa','ver','undefined','uno','dos','undefined',1);
/*!40000 ALTER TABLE `domicilios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista_orden`
--

DROP TABLE IF EXISTS `lista_orden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `lista_orden` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_orden` int(11) NOT NULL,
  `id_platillo` int(11) NOT NULL,
  `cantidad` tinyint(2) NOT NULL,
  `precio_unitario` decimal(6,2) NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  `indicaciones` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista_orden`
--

LOCK TABLES `lista_orden` WRITE;
/*!40000 ALTER TABLE `lista_orden` DISABLE KEYS */;
INSERT INTO `lista_orden` VALUES (1,16,1,2,100.56,201.12,NULL),(2,16,2,2,135.68,271.36,NULL),(3,16,3,2,186.47,372.94,NULL),(4,16,4,3,168.30,504.90,NULL),(5,16,5,1,258.21,258.21,NULL),(6,17,6,1,78.00,78.00,NULL),(7,18,7,2,90.99,181.98,NULL),(8,18,8,1,500.60,500.60,NULL),(9,19,9,1,75.55,75.55,NULL),(10,20,1,1,100.56,100.56,NULL),(11,21,2,1,135.68,135.68,NULL),(12,21,3,1,186.47,186.47,NULL),(13,21,4,1,168.30,168.30,NULL),(14,21,5,1,258.21,258.21,NULL),(15,21,6,1,78.00,78.00,NULL),(16,21,7,1,90.99,90.99,NULL),(17,22,8,2,500.60,1001.20,NULL),(18,22,9,1,75.55,75.55,NULL),(19,23,1,2,100.56,201.12,NULL),(20,23,2,3,135.68,407.04,NULL),(21,24,3,1,186.47,186.47,NULL),(22,24,4,1,168.30,168.30,NULL),(23,24,5,1,258.21,258.21,NULL),(24,24,6,1,78.00,78.00,NULL),(25,24,7,1,90.99,90.99,NULL),(26,35,1,1,100.56,100.56,''),(27,35,2,1,135.68,135.68,'');
/*!40000 ALTER TABLE `lista_orden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes`
--

DROP TABLE IF EXISTS `ordenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ordenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  `id_domicilio` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `fecha_entrega` datetime DEFAULT NULL,
  `monto_total` decimal(10,2) NOT NULL,
  `tipo_pago` tinyint(1) DEFAULT '0',
  `descuento` decimal(9,2) DEFAULT '0.00',
  `propina_repartidor` decimal(9,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes`
--

LOCK TABLES `ordenes` WRITE;
/*!40000 ALTER TABLE `ordenes` DISABLE KEYS */;
INSERT INTO `ordenes` VALUES (16,1,1,'2021-10-05 07:27:00','2021-10-05 08:27:00',1608.53,0,NULL,27.00),(17,1,2,'2021-10-05 07:27:00','2021-10-05 08:27:00',78.00,1,NULL,30.00),(18,1,3,'2021-10-05 07:27:00','2021-10-05 08:27:00',682.58,0,NULL,NULL),(19,2,4,'2021-10-05 07:27:00','2021-10-05 08:27:00',75.55,1,NULL,NULL),(20,3,5,'2021-10-05 07:27:00','2021-10-05 08:27:00',100.56,0,NULL,40.00),(21,3,5,'2021-10-05 07:27:00','2021-10-05 08:27:00',917.65,1,NULL,20.00),(22,4,9,'2021-10-05 07:27:00','2021-10-05 08:27:00',1076.75,0,NULL,NULL),(23,5,11,'2021-10-05 07:27:00','2021-10-05 08:27:00',608.16,1,NULL,NULL),(24,5,11,'2021-10-05 07:27:00',NULL,781.97,1,NULL,NULL),(25,5,11,'2021-10-05 07:27:00',NULL,781.97,1,0.00,30.00),(26,1,1,'2021-11-08 17:20:27',NULL,236.24,1,0.00,20.00),(27,1,1,'2021-11-08 17:21:35',NULL,236.24,1,0.00,20.00),(28,1,1,'2021-11-08 17:21:35',NULL,236.24,1,0.00,20.00),(29,1,1,'2021-11-08 17:23:22',NULL,236.24,1,0.00,20.00),(30,1,1,'2021-11-08 17:24:09',NULL,236.24,1,0.00,20.00),(31,1,1,'2021-11-08 17:24:56',NULL,236.24,1,0.00,20.00),(32,1,1,'2021-11-08 17:25:16',NULL,236.24,1,0.00,20.00),(33,1,1,'2021-11-08 17:28:01',NULL,236.24,1,0.00,20.00),(34,1,1,'2021-11-08 17:41:29',NULL,236.24,1,0.00,20.00),(35,1,1,'2021-11-08 17:43:07',NULL,236.24,1,0.00,20.00);
/*!40000 ALTER TABLE `ordenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platillos`
--

DROP TABLE IF EXISTS `platillos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `platillos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text,
  `precio` decimal(6,2) NOT NULL,
  `tipo_cocina` tinyint(1) NOT NULL,
  `url_imagen` varchar(255) DEFAULT NULL,
  `estatus` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platillos`
--

LOCK TABLES `platillos` WRITE;
/*!40000 ALTER TABLE `platillos` DISABLE KEYS */;
INSERT INTO `platillos` VALUES (1,'mole','mole poblano',100.56,1,'1.jpg',1),(2,'ramen','ramen tradicional',135.68,3,'1.jpg',1),(3,'lasaña','lasaña vegetariana de espinacas',186.47,2,'1.jpg',1),(4,'pitzza','tradicional al orno ',168.30,2,'1.jpg',1),(5,'tacos','de suadero',258.21,1,'1.jpg',1),(6,'oniguiri','fresco pesacdo con arroz blano al vapor',78.00,3,'1.jpg',1),(7,'mondongo','tradicionl',90.99,1,'1.jpg',1),(8,'pasta ','al gusto',500.60,2,'1.jpg',1),(9,'oden','caliente sopa',75.55,3,'1.jpg',1);
/*!40000 ALTER TABLE `platillos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `resumen_platillos_vendidos`
--

DROP TABLE IF EXISTS `resumen_platillos_vendidos`;
/*!50001 DROP VIEW IF EXISTS `resumen_platillos_vendidos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `resumen_platillos_vendidos` AS SELECT 
 1 AS `fecha`,
 1 AS `id_platillo`,
 1 AS `cantidad`,
 1 AS `tipo_cocina`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'dinner'
--

--
-- Dumping routines for database 'dinner'
--
/*!50003 DROP PROCEDURE IF EXISTS `insertar_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_cliente`(
	IN email varchar(255), 
    IN nombre varchar(255), 
    IN telefono bigint, 
    IN whatsapp integer, 
    IN fecha_creacion datetime 
    )
BEGIN


INSERT INTO clientes (`email`, `nombre`, `telefono`, `whatsapp`, `fecha_creacion`)
      VALUES (email, nombre, telefono, whatsapp, fecha_creacion);
-- obtiene el ultimo id
select (select last_insert_id()) as id ;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_domicilio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_domicilio`(
	IN id_cliente integer, 
    IN calle varchar(255), 
    IN numero varchar(255), 
    IN numero_interior varchar(255), 
    IN codigo_postal integer, 
    IN colonia varchar(255), 
    IN municipio varchar(255), 
    IN estado varchar(255), 
    IN pais varchar(255), 
    IN entre_calle_1 varchar(255), 
    IN entre_calle_2 varchar(255), 
    IN descripcion text)
BEGIN


INSERT INTO domicilios (
        `id_cliente`, `calle`, `numero`, `numero_interior`, `codigo_postal`, `colonia`,
        `municipio`, `estado`, `pais`, `entre_calle_1`, `entre_calle_2`, `descripcion`)
      VALUES (
		id_cliente, calle, numero, numero_interior, codigo_postal, colonia,
        municipio, estado, pais, entre_calle_1, entre_calle_2, descripcion
      );
-- obtiene el ultimo id
select (select last_insert_id()) as id ;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_orden` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_orden`(
	IN id_cliente integer, 
    IN id_domicilio integer, 
    IN fecha datetime, 
    IN monto_total decimal(10,2), 
    IN tipo_pago integer, 
    IN descuento decimal(10,2), 
    IN propina_repartidor decimal(10,2)
    )
BEGIN


INSERT INTO ordenes (`id_cliente`, `id_domicilio`, `fecha`, `monto_total`, `tipo_pago`, `descuento`, `propina_repartidor`)
      VALUES (id_cliente, id_domicilio, fecha, monto_total, tipo_pago, descuento, propina_repartidor);
-- obtiene el ultimo id
select (select last_insert_id()) as id ;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `resumen_platillos_vendidos`
--

/*!50001 DROP VIEW IF EXISTS `resumen_platillos_vendidos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `resumen_platillos_vendidos` AS select `ordenes`.`fecha` AS `fecha`,`lista_orden`.`id_platillo` AS `id_platillo`,`lista_orden`.`cantidad` AS `cantidad`,`platillos`.`tipo_cocina` AS `tipo_cocina` from ((`ordenes` join `lista_orden` on((`ordenes`.`id` = `lista_orden`.`id_orden`))) join `platillos` on((`lista_orden`.`id_platillo` = `platillos`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-08 17:59:31
