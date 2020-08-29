-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: escuelita_pancho_27_08_2020
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.11-MariaDB

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
-- Table structure for table `actividad`
--

DROP TABLE IF EXISTS `actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actividad` (
  `id_actividad` int(11) NOT NULL AUTO_INCREMENT COMMENT 'el codigo de la actividad',
  `id_unidad` int(11) NOT NULL COMMENT 'la unidad que esta trabajando',
  `id_asignacion` int(11) NOT NULL COMMENT 'llamamos la asignacion ya que esta definida por el curso y maestro',
  `titulo_actividad` varchar(45) NOT NULL COMMENT 'el nombre que define la actividad',
  `descripcion` varchar(45) NOT NULL COMMENT 'descripcion para definir la actividad ',
  `fecha_creacion` date NOT NULL COMMENT 'fecha de creacion de la actividad',
  `fecha_cierre` date NOT NULL COMMENT 'fecha cuando termine la entrega de la actividad',
  `puntos_zona` int(11) NOT NULL COMMENT 'define los puntos acumulados para la zona',
  `estado` enum('A','B') DEFAULT NULL COMMENT 'estado si esta activa o termino como baja',
  PRIMARY KEY (`id_actividad`),
  KEY `act_id_unidad_idx` (`id_unidad`),
  KEY `act_asignacion_idx` (`id_asignacion`),
  CONSTRAINT `act_asignacion` FOREIGN KEY (`id_asignacion`) REFERENCES `asignacion` (`id_asignacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `act_id_unidad` FOREIGN KEY (`id_unidad`) REFERENCES `unidad` (`id_unidad`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='define si es examen o tarea';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumno`
--

DROP TABLE IF EXISTS `alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alumno` (
  `id_alumno` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de alumno',
  `nombre_alumno` varchar(45) NOT NULL COMMENT 'nombre completo del alumno',
  `id_usuario` int(11) NOT NULL COMMENT 'codigo de usuario para uso del sistema',
  `direccion` varchar(155) NOT NULL COMMENT 'direccion donde vive el alumno',
  `celular` int(11) NOT NULL COMMENT 'numero de telefono para notificaiones',
  `correo` varchar(45) NOT NULL COMMENT 'correo electronico para notificaciones',
  `fecha_creacion` date NOT NULL COMMENT 'fecha que se creo el alumno',
  `id_grado` int(11) NOT NULL COMMENT 'fk codigo de grado',
  PRIMARY KEY (`id_alumno`),
  KEY `id_grado_idx` (`id_grado`),
  CONSTRAINT `id_grado` FOREIGN KEY (`id_grado`) REFERENCES `grado` (`id_grado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_usuario` FOREIGN KEY (`id_alumno`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno`
--

LOCK TABLES `alumno` WRITE;
/*!40000 ALTER TABLE `alumno` DISABLE KEYS */;
/*!40000 ALTER TABLE `alumno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asignacion`
--

DROP TABLE IF EXISTS `asignacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asignacion` (
  `id_asignacion` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de identificacion de asignacion',
  `id_alumno` int(11) NOT NULL COMMENT 'codigo del alumno asignado',
  `id_maestro_curso` int(11) NOT NULL COMMENT 'codigo que define el curso por maestro',
  `estado` enum('A','B') NOT NULL COMMENT 'asignacion activa o inactiva',
  PRIMARY KEY (`id_asignacion`),
  KEY `asig_id_alumno_idx` (`id_alumno`),
  KEY `asig_id_macu_idx` (`id_maestro_curso`),
  CONSTRAINT `asig_id_alumno` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `asig_id_macu` FOREIGN KEY (`id_maestro_curso`) REFERENCES `maestro_curso` (`id_maestro_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='asignacion de alumnos a curso y maestros';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignacion`
--

LOCK TABLES `asignacion` WRITE;
/*!40000 ALTER TABLE `asignacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `asignacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aula`
--

DROP TABLE IF EXISTS `aula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aula` (
  `id_aula` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de identificacion para el aula',
  `nombre_aula` varchar(150) NOT NULL COMMENT 'nombre del aula ',
  `capacidad` int(11) DEFAULT NULL COMMENT 'numero de alumnos que puede contener dicha aula',
  `usuario_creacion` varchar(45) DEFAULT NULL COMMENT 'usuario que crea',
  `fecha_creacion` varchar(45) DEFAULT NULL COMMENT 'fecha en que se crea el aula',
  `usuario_modifica` varchar(45) DEFAULT NULL COMMENT 'usuario que modifica ',
  `fecha_modifica` varchar(45) DEFAULT NULL COMMENT 'fecha en que se le hacen cambios',
  `estado` enum('A','B') DEFAULT NULL COMMENT 'Indica si esta de Alta o de Baja el aula\n',
  PRIMARY KEY (`id_aula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='define las aulas en disposicion y el numero maximo de alumnos que puede contener';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aula`
--

LOCK TABLES `aula` WRITE;
/*!40000 ALTER TABLE `aula` DISABLE KEYS */;
/*!40000 ALTER TABLE `aula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curso` (
  `id_curso` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de curso',
  `nombre_curso` varchar(150) NOT NULL COMMENT 'nombre de curso a impartir',
  `observacion` varchar(155) NOT NULL COMMENT 'algun comentario del curso',
  `estado` enum('A','B') NOT NULL COMMENT 'indica si esta de Alta o Baja ',
  `fecha_creacion` date NOT NULL COMMENT 'indicador de la fecha que se creo ',
  PRIMARY KEY (`id_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='tabla que contendra todos los cursos en general\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_alumno`
--

DROP TABLE IF EXISTS `detalle_alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_alumno` (
  `id_detalle_alumno` int(11) NOT NULL AUTO_INCREMENT,
  `id_alumno` int(11) NOT NULL COMMENT 'codigo del alumno ',
  `lugar_nacimiento` varchar(100) NOT NULL COMMENT 'lugar de nacimiento\n',
  `fecha_nacimiento` date NOT NULL COMMENT 'cuando nacio',
  `genero` enum('A','B') NOT NULL COMMENT 'orientacion sexual del ser',
  `nacionalidad` varchar(100) NOT NULL COMMENT 'de donde es',
  `estatura` int(11) DEFAULT NULL COMMENT 'medicion el metros y centimetros',
  `peso` int(11) DEFAULT NULL COMMENT 'medicion en libras y gramos',
  `religion` varchar(45) DEFAULT NULL COMMENT 'que profesa',
  `fecha_ingreso` date DEFAULT NULL COMMENT 'cuando ingreso ',
  `tipo_sangre` varchar(3) DEFAULT NULL COMMENT 'datos de emergencia ',
  `alergias` varchar(145) DEFAULT NULL COMMENT 'problemas de salud',
  `celular_emergencia` int(11) NOT NULL COMMENT 'celular como datos de contacto ',
  `padre_emergencia` varchar(150) NOT NULL COMMENT 'padre encargado del ser',
  PRIMARY KEY (`id_detalle_alumno`),
  KEY `id_alumno_idx` (`id_alumno`),
  CONSTRAINT `id_alumno_alumno` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='detalle de datos para el alumno';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_alumno`
--

LOCK TABLES `detalle_alumno` WRITE;
/*!40000 ALTER TABLE `detalle_alumno` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_alumno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grado`
--

DROP TABLE IF EXISTS `grado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grado` (
  `id_grado` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo que identifica al grado',
  `nombre_grado` varchar(45) NOT NULL COMMENT 'describe el nombre del grado',
  `estado` enum('A','B') NOT NULL COMMENT 'Se evalua si esta activo o de baja los grados del colegio',
  PRIMARY KEY (`id_grado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Esta tabla contiene los grados del nivel primario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grado`
--

LOCK TABLES `grado` WRITE;
/*!40000 ALTER TABLE `grado` DISABLE KEYS */;
/*!40000 ALTER TABLE `grado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horario`
--

DROP TABLE IF EXISTS `horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horario` (
  `id_horario` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo del horario del dia',
  `descripcion` varchar(155) NOT NULL COMMENT 'descripcion para el horario',
  `id_periodo_dia` int(11) NOT NULL COMMENT 'id del periodo que define la hora y dia del curspo',
  `id_maestro_curso` int(11) NOT NULL COMMENT 'contiene todos los datos necesarios como el maestro curso aula y otros',
  `estado` enum('A','B') NOT NULL COMMENT 'si esta de alta o baja',
  PRIMARY KEY (`id_horario`),
  KEY `ho_id_periodo_dia_idx` (`id_periodo_dia`),
  KEY `ho_id_macu_idx` (`id_maestro_curso`),
  CONSTRAINT `ho_id_macu` FOREIGN KEY (`id_maestro_curso`) REFERENCES `maestro_curso` (`id_maestro_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ho_id_periodo_dia` FOREIGN KEY (`id_periodo_dia`) REFERENCES `periodo_dia` (`id_periodo_dia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='asignacion de los cursos al dia de periodo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario`
--

LOCK TABLES `horario` WRITE;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identificacion`
--

DROP TABLE IF EXISTS `identificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identificacion` (
  `id_identificacion` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de identificacion ',
  `nombre_identificacion` varchar(45) NOT NULL COMMENT 'nombre de la identificacion',
  `estado` enum('A','B') NOT NULL COMMENT 'Indica si esta de Alta o de Baja el aula\n',
  PRIMARY KEY (`id_identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='nos indica el tipo de documento que puede utizar ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identificacion`
--

LOCK TABLES `identificacion` WRITE;
/*!40000 ALTER TABLE `identificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `identificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maestro`
--

DROP TABLE IF EXISTS `maestro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maestro` (
  `id_maestro` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo que identifica al maestro',
  `id_identificacion` int(11) NOT NULL COMMENT 'fk a la tabla de identificacion ',
  `codigo_identificacion` varchar(45) NOT NULL COMMENT 'codigo del tipo de identificacion',
  `direccion` varchar(150) NOT NULL COMMENT 'lugar de residencia del maestro',
  `correo` varchar(75) NOT NULL COMMENT 'correo electronico de contacto del maestro',
  `celular` int(11) NOT NULL COMMENT 'numero de celular ',
  `estado` enum('A','B') NOT NULL COMMENT 'Indica si esta de Alta o de Baja del maestro',
  PRIMARY KEY (`id_maestro`),
  KEY `id_identificacion_idx` (`id_identificacion`),
  CONSTRAINT `id_identificacion` FOREIGN KEY (`id_identificacion`) REFERENCES `identificacion` (`id_identificacion`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='tabla con los datos importantes del maestro';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maestro`
--

LOCK TABLES `maestro` WRITE;
/*!40000 ALTER TABLE `maestro` DISABLE KEYS */;
/*!40000 ALTER TABLE `maestro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maestro_curso`
--

DROP TABLE IF EXISTS `maestro_curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maestro_curso` (
  `id_maestro_curso` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de asignacion',
  `id_maestro` int(11) NOT NULL COMMENT 'id maestro para hacer match',
  `id_curso` int(11) NOT NULL COMMENT 'id del curso asignado al maestro\n',
  `id_grado` int(11) NOT NULL COMMENT 'grado al que le dara clases',
  `id_aula` int(11) NOT NULL COMMENT 'el aula asignada ',
  `descripcion` varchar(155) NOT NULL COMMENT 'descripcion del conjunto',
  `fecha_creacion` date NOT NULL COMMENT 'dia de creacion ',
  `estado` enum('A','B') NOT NULL COMMENT 'esta activo o de baja para funcionar',
  PRIMARY KEY (`id_maestro_curso`),
  KEY `macu_id_curso_idx` (`id_curso`),
  KEY `macu_id_grado_idx` (`id_grado`),
  KEY `macu_id_aula_idx` (`id_aula`),
  CONSTRAINT `macu_id_aula` FOREIGN KEY (`id_aula`) REFERENCES `aula` (`id_aula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `macu_id_curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `macu_id_grado` FOREIGN KEY (`id_grado`) REFERENCES `grado` (`id_grado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `macu_id_maestro` FOREIGN KEY (`id_maestro_curso`) REFERENCES `maestro` (`id_maestro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='match entre maestro y curso ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maestro_curso`
--

LOCK TABLES `maestro_curso` WRITE;
/*!40000 ALTER TABLE `maestro_curso` DISABLE KEYS */;
/*!40000 ALTER TABLE `maestro_curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `papeleria_alumno`
--

DROP TABLE IF EXISTS `papeleria_alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `papeleria_alumno` (
  `id_papeleria_alumno` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de papeleria de alumno\n',
  `id_alumno` int(11) NOT NULL COMMENT 'codigo del alumno ',
  `partida_nacimiento` mediumblob NOT NULL COMMENT 'certificado de nacimiento\n',
  `certificado_vacunas` mediumblob NOT NULL COMMENT 'imagen de certificado de vacunas\n',
  `certificado_preprimaria` mediumblob DEFAULT NULL COMMENT 'certificado de preprimaria',
  `certificado_primero_primaria` mediumblob DEFAULT NULL COMMENT 'certificado de primero primaria',
  `certificacdo_segundo_primaria` mediumblob DEFAULT NULL COMMENT 'certificado de segundo primaria',
  `certificado_tercero_primaria` mediumblob DEFAULT NULL COMMENT 'certificado de tercero primaria',
  `certificado_cuarto_primaria` mediumblob DEFAULT NULL COMMENT 'certificado de cuarto primaria',
  `certificado_quinto_primaria` mediumblob DEFAULT NULL COMMENT 'certificado de quinto primaria',
  `certificado_sexto_primaria` mediumblob DEFAULT NULL COMMENT 'certificado de sexto primaria',
  PRIMARY KEY (`id_papeleria_alumno`),
  KEY `id_alumno_idx` (`id_alumno`),
  CONSTRAINT `id_alumno` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='contiene datos de certificaciones del alumno';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `papeleria_alumno`
--

LOCK TABLES `papeleria_alumno` WRITE;
/*!40000 ALTER TABLE `papeleria_alumno` DISABLE KEYS */;
/*!40000 ALTER TABLE `papeleria_alumno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodo_dia`
--

DROP TABLE IF EXISTS `periodo_dia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periodo_dia` (
  `id_periodo_dia` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo para definir el periodo en el que esta',
  `nombre_periodo` varchar(45) NOT NULL COMMENT 'descripcion o titulo para el periodo',
  `observacion` varchar(145) NOT NULL COMMENT 'algun comentario para la definicion del periodo',
  `dia_horario` varchar(45) DEFAULT NULL COMMENT 'dia para el periodo\n',
  `hora_horario` datetime NOT NULL COMMENT 'la hora del horario para el periodo',
  `estado` enum('A','B') NOT NULL,
  PRIMARY KEY (`id_periodo_dia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='grupo por dias de horario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodo_dia`
--

LOCK TABLES `periodo_dia` WRITE;
/*!40000 ALTER TABLE `periodo_dia` DISABLE KEYS */;
/*!40000 ALTER TABLE `periodo_dia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `respuesta_actividad`
--

DROP TABLE IF EXISTS `respuesta_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `respuesta_actividad` (
  `id_respuesta_actividad` int(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(11) NOT NULL,
  `id_alumno` int(11) NOT NULL,
  `nota` int(11) NOT NULL,
  `descripcion_respuesta` varchar(45) NOT NULL,
  `trabajo_respuesta` mediumblob DEFAULT NULL,
  `fecha_respuesta` varchar(45) NOT NULL COMMENT 'fecha en que subio la actividad',
  `estado` enum('AT','NE','FT') NOT NULL COMMENT 'estados para los trabajos\nAT= a tiempo\nNE = no entrego\nFT = fuera de tiempo\n',
  `respuesta_actividadcol` varchar(45) NOT NULL,
  PRIMARY KEY (`id_respuesta_actividad`),
  KEY `reac_id_actividad_idx` (`id_actividad`),
  KEY `reac_id_alumno_idx` (`id_alumno`),
  CONSTRAINT `reac_id_actividad` FOREIGN KEY (`id_actividad`) REFERENCES `actividad` (`id_actividad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `reac_id_alumno` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='respuesta a la actividad creada';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `respuesta_actividad`
--

LOCK TABLES `respuesta_actividad` WRITE;
/*!40000 ALTER TABLE `respuesta_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `respuesta_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidad`
--

DROP TABLE IF EXISTS `unidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unidad` (
  `id_unidad` int(11) NOT NULL COMMENT 'codigo de identificacion de unidad',
  `nombre_unidad` varchar(45) DEFAULT NULL COMMENT 'nombre de identificacion para unidad',
  `fecha_inicio` date DEFAULT NULL COMMENT 'fecha donde inicia la unidad',
  `fecha_fin` date DEFAULT NULL COMMENT 'fecha donde termina la unidad',
  `estado` enum('A','I') DEFAULT NULL COMMENT 'Unidad activa o inactiva',
  PRIMARY KEY (`id_unidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidad`
--

LOCK TABLES `unidad` WRITE;
/*!40000 ALTER TABLE `unidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `unidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo del usuario',
  `usuario` varchar(45) NOT NULL COMMENT 'nombre del usuario',
  `password` varchar(15) NOT NULL COMMENT 'contraseña definida por usuario',
  `fecha_ultimo_cambio_password` date NOT NULL COMMENT 'ultima fecha de cambio de passowrd',
  `contador_intento_fallidos` varchar(45) NOT NULL COMMENT 'contador de intentos fallidos al acceder',
  `codigo_restauracion` varchar(45) NOT NULL COMMENT 'codigo de nuevo acceso por si se olvido el password',
  `correo` varchar(45) NOT NULL COMMENT 'correo_restauracion_usuario',
  `celular` int(11) NOT NULL COMMENT 'numero_telefono_para_restauracion',
  `status` enum('A','B') NOT NULL COMMENT 'Indica si esta de Alta o de Baja del usuario',
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='tabla que contiene a los usuarios que manejaran la informacion ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'escuelita_pancho_27_08_2020'
--

--
-- Dumping routines for database 'escuelita_pancho_27_08_2020'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-28 13:18:30
