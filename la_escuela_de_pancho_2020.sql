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

INSERT INTO `aula` ( `nombre_aula`, `capacidad`, `usuario_creacion`, `fecha_creacion`, `usuario_modifica`, `fecha_modifica`, `estado`) VALUES
('c-0001', 27, 'coordinador', '7/25/2020', 'maestro', '8/22/2020', 'A'),
('c-0002', 26, 'coordinador', '7/25/2020', 'maestro', '8/24/2020', 'A'),
('c-0003', 21, 'maestro', '7/25/2020', 'maestro', '8/25/2020', 'A'),
('c-0004', 28, 'director', '7/24/2020', 'coordinador', '8/24/2020', 'A'),
('c-0005', 21, 'auxiliar', '7/23/2020', 'director', '8/24/2020', 'B');


ALTER TABLE `aula`
  ADD PRIMARY KEY (`id_aula`);


ALTER TABLE `aula`
  MODIFY `id_aula` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de identificacion para el aula', AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 29, 2020 at 02:54 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `la_escuelita_de_pancho`
--

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL COMMENT 'codigo del usuario',
  `usuario` varchar(45) NOT NULL COMMENT 'nombre del usuario',
  `password` varchar(15) NOT NULL COMMENT 'contraseña definida por usuario',
  `fecha_ultimo_cambio_password` date NOT NULL COMMENT 'ultima fecha de cambio de passowrd',
  `contador_intento_fallidos` varchar(45) NOT NULL COMMENT 'contador de intentos fallidos al acceder',
  `codigo_restauracion` varchar(45) NOT NULL COMMENT 'codigo de nuevo acceso por si se olvido el password',
  `correo` varchar(45) NOT NULL COMMENT 'correo_restauracion_usuario',
  `celular` int(11) NOT NULL COMMENT 'numero_telefono_para_restauracion',
  `status` enum('A','B') NOT NULL COMMENT 'Indica si esta de Alta o de Baja del usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='tabla que contiene a los usuarios que manejaran la informacion ';

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `usuario`, `password`, `fecha_ultimo_cambio_password`, `contador_intento_fallidos`, `codigo_restauracion`, `correo`, `celular`, `status`) VALUES
(1, 'Lyle', 'WJzTv62Fjq', '2020-08-25', '9', 'U5290BZqTY', 'Abra@Phasellus.com', 623, 'B'),
(2, 'Porter', 'hNu03gpeCs', '2020-08-22', '1', 'aNoAPolDUa', 'Ruby@Duis.net', 595, 'B'),
(3, 'Nash', 'jGbjYhYgHw', '2020-08-23', '1', 'MxNhIxaZiD', 'Vanna@Suspendisse.com', 720, 'A'),
(4, 'Elijah', 'n4eEaDCMmk', '2020-08-26', '3', 'qVkqVyn74k', 'Jenna@gravida.com', 777, 'B'),
(5, 'Karyn', 'nGYxTeogwo', '2020-08-22', '1', 'qoN4GSbcY7', 'Savannah@hendrerit.net', 309, 'B'),
(6, 'Brendan', 'PuwvmjWNQ6', '2020-08-23', '5', 'zW2CNvblto', 'Maite@molestie.com', 995, 'A'),
(7, 'Geraldine', 'dZO0Cz41VK', '2020-08-27', '7', 'XzvHcdjiBV', 'Malachi@Duis.com', 805, 'A'),
(8, 'Lael', 'xoO0IEHHtD', '2020-08-24', '8', 'Qnvds2krBa', 'Tamekah@posuere.us', 131, 'B'),
(9, 'Vaughan', 'fgJJgdP0VB', '2020-08-22', '0', 'rSgWa0Lllo', 'Abdul@Mauris.net', 129, 'B'),
(10, 'Charde', 'aCWsnyzvka', '2020-08-23', '5', 'OgZDaDNrEl', 'Holmes@libero.gov', 426, 'A'),
(11, 'Tashya', 'I90Ss DFOP', '2020-08-24', '4', 'zw0HbxGPZR', 'Colleen@Nunc.us', 912, 'B'),
(12, 'Azalia', 'PeKta5iiTu', '2020-08-27', '4', '4FRCv70WVK', 'Rhonda@consequat.org', 393, 'B'),
(13, 'Naomi', 'T0Wkry3bRz', '2020-08-23', '3', 'KObWI4DLOG', 'Renee@dui.gov', 870, 'A'),
(14, 'Beau', 'Lp8v0oBxoL', '2020-08-24', '8', 'cv7eGvg0H1', 'Richard@euismod.com', 792, 'B'),
(15, 'Sigourney', 'B5uZxyz3ah', '2020-08-27', '9', 'd3AZzSYDKt', 'Gillian@luctus.com', 417, 'A'),
(16, 'Kenneth', 'C9yjK9bujN', '2020-08-22', '9', 'CD9ZQe2Kxb', 'Caleb@condimentum.us', 351, 'A'),
(17, 'Rhona', 'FMPEHcOa1h', '2020-08-25', '3', 'iwyXsIKmAw', 'Rajah@nisi.com', 747, 'B'),
(18, 'Whitney', 'TsXGrLas W', '2020-08-25', '10', 'LbLbl6D0dc', 'Walter@dapibus.org', 222, 'A'),
(19, 'Daphne', 'ShLY0kskzk', '2020-08-23', '8', 'qNYWu63Kej', 'Barrett@quam.org', 60, 'A'),
(20, 'Fiona', 'ZKOIistxvr', '2020-08-22', '6', 'yLv4rDvlAv', 'Thane@bibendum.edu', 758, 'A'),
(21, 'Zoe', 'nqrJtMHFBH', '2020-08-24', '9', 'PGqlg7Dhfq', 'Irma@posuere.com', 999, 'B'),
(22, 'Jordan', '6vU5lmND98', '2020-08-22', '8', 'ealrsdBL8I', 'Ann@Phasellus.us', 166, 'B'),
(23, 'Noelle', 't41MQ8uoGa', '2020-08-28', '10', 'oPtrkgPb4y', 'Shelby@justo.org', 231, 'A'),
(24, 'Myra', 'nD5PPUGezu', '2020-08-22', '7', 'KHjowUKI14', 'Stacey@justo.edu', 184, 'B'),
(25, 'Gavin', 'J2uoTemB9g', '2020-08-23', '2', 'wM7dfF3nJp', 'Keiko@per.net', 358, 'B'),
(26, 'Amaya', '6tjDUHEcwz', '2020-08-24', '4', 'FnjO4mrF0G', 'Jermaine@Cras.net', 352, 'B'),
(27, 'Tad', '7V6GByWkhq', '2020-08-25', '7', 'u27D4yLyVH', 'Fatima@pulvinar.com', 481, 'B'),
(28, 'Luke', 'ZwZUsz910a', '2020-08-27', '6', 'XmmioJbnQC', 'Josephine@Duis.com', 159, 'B'),
(29, 'Abigail', 'mBDK8ZHb4j', '2020-08-27', '10', 'r5WqHGYATd', 'Jermaine@Fusce.org', 89, 'A'),
(30, 'Hyatt', 'qfOhK4EjEL', '2020-08-28', '3', 'SdrbVmKyAb', 'Sara@Nunc.us', 470, 'A'),
(31, 'Ray', 'auIhzvUhEv', '2020-08-24', '5', 'lBGYQ1QSq2', 'Thane@varius.com', 475, 'B'),
(32, 'Jocelyn', '0YkOPnNqj6', '2020-08-26', '0', '2q1xfWH3Vz', 'John@Cum.us', 337, 'B'),
(33, 'Yetta', 'yR8bT03Prp', '2020-08-27', '2', '45Gsz4onxN', 'Aurelia@hymenaeos.net', 282, 'B'),
(34, 'Maya', 'jq2kpQoPzo', '2020-08-27', '9', 'A7jduezl7Y', 'Karina@at.net', 199, 'A'),
(35, 'Baker', 'JgpPGaeQLr', '2020-08-22', '7', 'PFzL8CHefj', 'Yardley@sodales.edu', 425, 'A'),
(36, 'Caryn', 'RpSZ7NI5nf', '2020-08-27', '6', 'pGHV5qecYE', 'Scarlet@est.com', 189, 'B'),
(37, 'Lara', 'cRa6m1HBsO', '2020-08-25', '5', 'GVywOa2Fwp', 'Elvis@parturient.net', 778, 'B'),
(38, 'Chaney', '3 nB8Fb4mG', '2020-08-28', '6', 'h0a2W1goSD', 'Ferris@parturient.gov', 60, 'A'),
(39, 'Herrod', 'B3j4DEvaoS', '2020-08-28', '9', 'h5wKPuM8hy', 'Hyacinth@Curabitur.org', 723, 'B'),
(40, 'Carissa', 'BkRVzs276F', '2020-08-23', '7', 'jgDhWRvX2I', 'Dana@in.us', 699, 'B'),
(41, 'Mira', 'JFaP7dQWjj', '2020-08-24', '4', 'MAkHFDJBCT', 'Mufutau@tellus.org', 389, 'A'),
(42, 'Berk', 'Sqc5WlyEN2', '2020-08-24', '6', '4gqDbdjFEB', 'Erich@augue.gov', 443, 'A'),
(43, 'Yasir', 'xR5vH3L5Mi', '2020-08-28', '1', 'ng9eC3XuQI', 'Mufutau@mauris.gov', 147, 'B'),
(44, 'Arthur', 'Sdq5mNw3WT', '2020-08-24', '4', '1EbtUdp3zT', 'Scarlett@Proin.gov', 268, 'B'),
(45, 'Burton', 'tGXqscR4rc', '2020-08-28', '5', '00C12YvTbQ', 'Micah@libero.com', 979, 'A'),
(46, 'Macon', 'MUA2zKfl8L', '2020-08-24', '0', 'vvKfG12M2W', 'Jillian@Proin.com', 653, 'B'),
(47, 'Travis', '2HhYDNLntM', '2020-08-24', '2', '3hfFneUkf0', 'Drake@sem.us', 638, 'B'),
(48, 'Lane', 'nrJMbGSmKd', '2020-08-23', '6', 'CTfs7Dp5Uh', 'Maggie@sit.net', 660, 'A'),
(49, 'Kameko', '7bVuqdnZrp', '2020-08-25', '0', '961NJ30UVQ', 'Kiara@lobortis.org', 423, 'A'),
(50, 'Aline', 'uwBoe15 FP', '2020-08-23', '7', 'nPmw1gWMHF', 'Nash@pulvinar.gov', 961, 'A'),
(51, 'Isaac', 'W4GKHVNCXW', '2020-08-26', '1', 'qEgNVJ96nZ', 'Damian@rutrum.edu', 585, 'B'),
(52, 'Reed', 'g2kthM52Dn', '2020-08-28', '10', 'aPW2imyPzl', 'Rajah@erat.org', 240, 'B'),
(53, 'Whilemina', 'iIW6 C5xTy', '2020-08-26', '5', 'NzTvVXyutN', 'Orson@nibh.us', 171, 'B'),
(54, 'Addison', 't6jsY43TUj', '2020-08-24', '2', 'WZedzjNk0F', 'Brendan@convallis.edu', 58, 'A'),
(55, 'Sandra', 'GolaDhcR5u', '2020-08-28', '10', 'AbOLNx58nL', 'Steven@leo.org', 881, 'A'),
(56, 'Carson', ' HphVeFdkR', '2020-08-25', '9', 'd7vbBjB2CC', 'Wylie@arcu.net', 234, 'B'),
(57, 'Chandler', 'pcykRfwES7', '2020-08-22', '6', 'cb6NxCBsEj', 'Kellie@Curabitur.com', 89, 'B'),
(58, 'Camille', 'Qb8hLmXSWU', '2020-08-27', '2', 'EspXh2Rdwt', 'Yoshi@nibh.org', 741, 'B'),
(59, 'Elmo', 'FahSsmSm9e', '2020-08-25', '2', 'pnDBr9tKRp', 'Arthur@Integer.gov', 65, 'A'),
(60, 'Samuel', 'z6lVveaais', '2020-08-26', '9', 'OratvG5BD4', 'Quemby@ridiculus.gov', 658, 'A'),
(61, 'Kirk', 'Ed TZlSveg', '2020-08-28', '1', 'xlMDrqGdHj', 'Sharon@sapien.com', 65, 'A'),
(62, 'Lilah', 'VtcafEM8IZ', '2020-08-27', '5', '5rbPLwptLh', 'Whoopi@nec.us', 404, 'A'),
(63, 'Armando', 'tvAjvFI9XU', '2020-08-27', '2', '1mPHnZMp1B', 'Dennis@tincidunt.edu', 201, 'B'),
(64, 'Hedwig', 'wR2UwWy1KE', '2020-08-24', '2', 'TBsPJcnLyp', 'Kennedy@consectetuer.edu', 570, 'B'),
(65, 'Imelda', 'JRHMxiUk3G', '2020-08-25', '6', 'DlSy0jAF2x', 'Beverly@sapien.edu', 954, 'B'),
(66, 'Hammett', 'Iay5nsEeC3', '2020-08-25', '2', '6hawZitMqw', 'Elvis@rhoncus.gov', 401, 'A'),
(67, 'Jasmine', 'qfxXdBeCnz', '2020-08-28', '7', 'cCkS7Yx64J', 'Brianna@Phasellus.us', 228, 'A'),
(68, 'Imelda', 'DUIdieSwzQ', '2020-08-26', '3', '7lYkcgXlzd', 'Carla@inceptos.us', 61, 'A'),
(69, 'Tad', 'cCMoOUb4dI', '2020-08-27', '1', 'qUmGjcLPqI', 'Vance@montes.net', 14, 'A'),
(70, 'Linus', 'bw6 dhTtoJ', '2020-08-26', '3', 'GCKqj3cTZ7', 'Tarik@aliquet.org', 787, 'A'),
(71, 'Rudyard', 'OlCWK8e5HG', '2020-08-26', '9', '19CBrGS4a7', 'Armand@vestibulum.us', 827, 'B'),
(72, 'Rajah', 'Ft9EWINKbg', '2020-08-24', '1', 'MXNP6a5UZ5', 'Darius@Lorem.com', 535, 'A'),
(73, 'Anne', 'SiNz7IxHVv', '2020-08-26', '3', '1dQwaeyWPC', 'Martin@nascetur.org', 550, 'B'),
(74, 'Gretchen', 'M7chk99NQZ', '2020-08-28', '6', 'K6XP4NG2fz', 'Lyle@placerat.com', 226, 'B'),
(75, 'Emery', 'VPoDlFlLHO', '2020-08-23', '3', 'AYgUSQjBcO', 'Blake@turpis.org', 795, 'A'),
(76, 'Justin', 'MiM0aIsNON', '2020-08-22', '3', 'FnJ337XGX0', 'Price@Cras.com', 967, 'A'),
(77, 'Walter', 'BnFhxjBpYw', '2020-08-27', '5', 'R38tZXKu2H', 'Raphael@Praesent.gov', 407, 'B'),
(78, 'Alexa', 'F6rMUQQUNA', '2020-08-24', '4', 'Sjx2IaQC5X', 'Bernard@est.net', 554, 'B'),
(79, 'Aaron', 'NUjYQRyUJd', '2020-08-28', '9', 'P3w37vX1zM', 'Lisandra@dis.net', 642, 'B'),
(80, 'Jemima', 'juKxlOK5VQ', '2020-08-25', '7', 'lZ1QRvT3En', 'Cooper@est.edu', 348, 'B'),
(81, 'Rafael', 'lqk5MUswNu', '2020-08-24', '7', '0eGuHjJa7w', 'Jena@feugiat.net', 65, 'B'),
(82, 'Lucas', 'pU9sBRrwHp', '2020-08-22', '3', 'F2FbH1Azsn', 'TaShya@Aliquam.org', 825, 'B'),
(83, 'Mollie', 'P571hRM7EK', '2020-08-24', '10', 'BmTMclhBEa', 'Berk@egestas.com', 820, 'A'),
(84, 'Sheila', 'PCxIZKn6AG', '2020-08-26', '9', 'W0GKbqsiMB', 'Nadine@Aliquam.net', 314, 'A'),
(85, 'Althea', 'gLvNsIyyZp', '2020-08-22', '4', 'oIRAUwnpag', 'Isaac@bibendum.org', 934, 'A'),
(86, 'Ray', 'PLkg9SKwqb', '2020-08-24', '5', 'cN7vLypCWP', 'Ferdinand@Cum.us', 271, 'A'),
(87, 'Duncan', '4HwO8kF 9C', '2020-08-25', '4', '7CmAOMYdlm', 'Kibo@Duis.us', 244, 'B'),
(88, 'Helen', '9Cs0HEruVz', '2020-08-27', '6', 'IGdz9CsA8I', 'Armand@vulputate.com', 701, 'A'),
(89, 'Lillith', 'GYG3r56VL1', '2020-08-24', '6', 'mcGTyLzfKH', 'Germane@dis.org', 98, 'A'),
(90, 'Keely', 'XXWubCQz5R', '2020-08-22', '3', 'ieJnKABwwJ', 'Shafira@primis.gov', 206, 'B'),
(91, 'Jerry', 'hGIePeiEG9', '2020-08-25', '5', 'BI26XjdzUw', 'Joel@Curabitur.org', 492, 'A'),
(92, 'MacKensie', 'EKhSul58za', '2020-08-24', '8', 'q2pTioR4Op', 'Ian@Cum.gov', 161, 'B'),
(93, 'Lillith', 'A4lOgc6gyG', '2020-08-23', '4', 'lTSp8Mgu6I', 'Derek@Duis.us', 481, 'B'),
(94, 'Kadeem', 'S5LSJRLgnr', '2020-08-23', '9', 'QPZOTfQHPK', 'Leandra@Lorem.gov', 180, 'A'),
(95, 'Tanner', 'coWLwhwPzE', '2020-08-23', '7', 'NWW53SPvpC', 'Beau@turpis.com', 891, 'B'),
(96, 'Upton', 'GNUH6XxgFb', '2020-08-23', '4', 'p9Ne75uQXk', 'Aquila@tellus.net', 322, 'B'),
(97, 'Leslie', 'ypFaZeq0TM', '2020-08-24', '10', 'kTw2M8oGn8', 'Unity@porta.com', 657, 'A'),
(98, 'Fallon', 'GhJs2GqvbW', '2020-08-24', '0', 'IbmUrQ49KW', 'Constance@dui.net', 578, 'B'),
(99, 'Miranda', 'aWHeoGOdum', '2020-08-22', '4', 'dT7ChhXeYB', 'Ruth@eleifend.com', 888, 'A'),
(100, 'Cheyenne', 'oUfBgyn0gM', '2020-08-25', '10', 'VdJlpYfxtr', 'Stephanie@tristique.edu', 248, 'B'),
(101, 'Grady', 'U2GLbxXv8w', '2020-08-25', '3', 'dMcYf3PqPu', 'Erich@Vivamus.org', 831, 'A'),
(102, 'Wallace', 'dkIII9gPtq', '2020-08-25', '4', 'gne86LDswG', 'Sierra@semper.com', 912, 'A'),
(103, 'Tate', '4lA54KAwMG', '2020-08-25', '7', 'CNp4qleP3R', 'Andrew@enim.org', 835, 'B'),
(104, 'George', 'aM0USpaYmx', '2020-08-22', '1', '2R7Egltes6', 'Kitra@Etiam.net', 975, 'B'),
(105, 'Briar', 'bLYAcN156N', '2020-08-27', '4', 'BMEpoOaQ06', 'Abbot@suscipit.us', 144, 'B'),
(106, 'Zephr', 'ibw2AlxuNE', '2020-08-28', '6', 'E0mAFl1SV1', 'Aladdin@porttitor.org', 952, 'A'),
(107, 'Preston', '14B9iMtsI1', '2020-08-28', '8', 'qWq1Ex5V2o', 'Paul@lectus.com', 73, 'A'),
(108, 'Lance', 'DuCC7 iIBL', '2020-08-23', '5', 'b8jsuoNDnV', 'Emily@Vestibulum.gov', 207, 'B'),
(109, 'Renee', 'D8nFmnX1wA', '2020-08-24', '8', '7FKcxm7Oeu', 'Zorita@cursus.gov', 191, 'B'),
(110, 'Eric', 'Wd3MbFByJY', '2020-08-26', '0', 'h0ruBbySjC', 'Jerry@felis.org', 380, 'B'),
(111, 'Ignacia', 'XAuyBOGrdq', '2020-08-22', '2', 'X3wNCb9Ik6', 'Chaney@vulputate.edu', 359, 'B'),
(112, 'Lysandra', 'AhCN tbmsJ', '2020-08-22', '4', '5C7Ee6hbyk', 'Whoopi@ipsum.gov', 19, 'B'),
(113, 'Brandon', 'P8GxsVHtoq', '2020-08-25', '7', 'qWE29fGANm', 'Delilah@gravida.gov', 844, 'B'),
(114, 'Benedict', 'FNQ xCZ e6', '2020-08-23', '2', 'IM86eI0dIh', 'Adam@risus.org', 169, 'A'),
(115, 'Tatyana', 'OIqB KJ75M', '2020-08-27', '6', 'X8oktBX8p3', 'Warren@nunc.us', 868, 'B'),
(116, 'Constance', 'ni1nYb7VlQ', '2020-08-27', '3', 'aJkCtAKBRu', 'Hunter@felis.com', 464, 'B'),
(117, 'Quentin', '9X03RmNKZv', '2020-08-27', '5', 'Wb8Bmr3iZj', 'Ayanna@viverra.us', 22, 'A'),
(118, 'Adele', '0D9Sl9FY3i', '2020-08-23', '0', 'NaD94MMkAK', 'Orla@laoreet.edu', 633, 'B'),
(119, 'Kadeem', 'Jf1jnfZsqc', '2020-08-26', '9', 'Drycl7n5Ss', 'Summer@pede.edu', 13, 'A'),
(120, 'Daquan', 'sb9NlEa2vk', '2020-08-27', '8', 'Va2EfeFrXh', 'Natalie@neque.us', 704, 'B'),
(121, 'Pandora', 'vSFqyne1O2', '2020-08-26', '8', 'IwFOvw7WON', 'Flynn@velit.net', 876, 'A'),
(122, 'Lucius', 'Znyqh3QGdP', '2020-08-25', '9', 'ErCSANVLMH', 'Ali@ipsum.gov', 516, 'B'),
(123, 'Ivana', '62g 9UsPNu', '2020-08-28', '4', 's9uivHX78i', 'Madonna@pede.org', 712, 'B'),
(124, 'Sophia', 'eYpzw88H6F', '2020-08-27', '6', 'NuogNXie7b', 'Dexter@hendrerit.org', 413, 'B'),
(125, 'Lee', 'Z16qZjRaSY', '2020-08-27', '9', 'nuuReuIEtS', 'Gil@tincidunt.net', 673, 'B'),
(126, 'Melvin', 'gCu7JnJPed', '2020-08-22', '4', 'QDiNMangbv', 'Susan@est.com', 65, 'A'),
(127, 'Edward', 'tOv9yfAv8I', '2020-08-22', '7', 'AFxZaP7nP4', 'Driscoll@vel.com', 995, 'A'),
(128, 'Tad', 'HalRcmIiEg', '2020-08-25', '9', 'fiKu5ZzRqZ', 'Nicholas@lacus.org', 120, 'A'),
(129, 'Yasir', 'o8 wB5HRLi', '2020-08-28', '3', 'f1CPhZSLZC', 'Kai@id.edu', 985, 'B'),
(130, 'Kirestin', 'jKeM2jJS6p', '2020-08-26', '0', 'CyFWnlDRGb', 'Janna@sociis.org', 452, 'B'),
(131, 'Chase', 'RQ5Oj6oaRh', '2020-08-24', '3', '8ii8SiUHJ5', 'Kelsey@rhoncus.edu', 739, 'B'),
(132, 'Abbot', 'eaazEYCzFz', '2020-08-26', '7', 'anvJYIPxTc', 'Xenos@aliquet.edu', 47, 'A'),
(133, 'Nolan', 'd15YT19WuG', '2020-08-28', '4', 'W6IQYN1R2F', 'Garrett@congue.org', 88, 'A'),
(134, 'Alfonso', 'NNa9GyqzIQ', '2020-08-28', '1', 'U9IESBJkcl', 'Audra@per.gov', 166, 'A'),
(135, 'Zeus', 'ZbS6689mgs', '2020-08-27', '6', 'L8cjhqh1rB', 'Yasir@accumsan.org', 89, 'B'),
(136, 'Julian', '9ZRJfkP9PI', '2020-08-24', '3', 'a1asOJttDj', 'Vladimir@netus.us', 393, 'A'),
(137, 'Shannon', 'DXusIzNnQT', '2020-08-28', '9', 'TMRNu2MDwj', 'Elliott@pretium.net', 299, 'B'),
(138, 'Seth', 'lZaKLA Qop', '2020-08-25', '3', 'RzTqPxUQUa', 'Blaze@lorem.gov', 752, 'B'),
(139, 'Donovan', 'hVl3HHnuHn', '2020-08-27', '2', 'HKmG7MDiVq', 'Jared@feugiat.gov', 816, 'B'),
(140, 'Preston', 'WFqk6hvpkF', '2020-08-27', '2', 'PMk1ULoBVZ', 'Zahir@sed.edu', 92, 'A'),
(141, 'Christopher', 'W Wrjc rOX', '2020-08-25', '1', 'ZYKpwKTbla', 'Holmes@inceptos.gov', 360, 'A'),
(142, 'Nicole', 'SHUNr9p7P9', '2020-08-22', '1', 'sOvzt7qWAJ', 'Jamal@inceptos.org', 739, 'A'),
(143, 'Zeus', 'cUpjxutE1Y', '2020-08-25', '10', 'RMdhaPctqL', 'Astra@Curabitur.org', 143, 'A'),
(144, 'Maisie', 'c88HfSKB5W', '2020-08-23', '3', '3LUGcT9dWh', 'Stacy@Aliquam.com', 473, 'A'),
(145, 'Sarah', '4MH7MlB mY', '2020-08-26', '2', 'ktwB1y1TTf', 'Mara@et.edu', 517, 'B'),
(146, 'Kirsten', 'gEil2 8ZBD', '2020-08-28', '3', 'bNX4vJi790', 'Aphrodite@bibendum.us', 356, 'A'),
(147, 'Eleanor', 'eh8qTGfSwR', '2020-08-24', '9', 'a8zxpbvREl', 'Vivien@pretium.net', 213, 'B'),
(148, 'Suki', 'bByY51aLbV', '2020-08-24', '7', 'bWv3EVBf9S', 'Lamar@eros.gov', 170, 'A'),
(149, 'Murphy', 'ayzHmbdBn6', '2020-08-27', '7', 'aidvEacipM', 'Silas@Sed.gov', 735, 'A'),
(150, 'Chester', 'ceoDWEPnRy', '2020-08-26', '1', 'RL5ALj2Ugl', 'Curran@dis.com', 10, 'A'),
(151, 'Uriah', 'tAT95WyuSd', '2020-08-25', '8', 'svII1oj1Ph', 'Lyle@Class.gov', 665, 'B'),
(152, 'Susan', 'E8JlI5NXxv', '2020-08-27', '2', 'GCvO7B8Axv', 'Dylan@Lorem.com', 315, 'A'),
(153, 'Irma', 'hAGP1B76Ow', '2020-08-26', '4', 'iw3ZHiShcH', 'Reese@venenatis.gov', 28, 'A'),
(154, 'Colin', 'aUCm1ayRmb', '2020-08-23', '5', 'jf3ASa6aiq', 'Constance@torquent.com', 799, 'A'),
(155, 'Andrew', 'SRzzHTUoyD', '2020-08-23', '8', 'sMJUjjlxES', 'Halee@porta.com', 958, 'A'),
(156, 'Evan', 'J0AujwUlNB', '2020-08-25', '3', 'e8YfStgg9Q', 'Kirk@turpis.edu', 529, 'B'),
(157, 'Joshua', '6ypngfFBx2', '2020-08-28', '1', 'dChV3DJjk4', 'Laurel@purus.gov', 650, 'A'),
(158, 'Fallon', '7Whp4TTxoU', '2020-08-24', '1', 'l4By3PQOwb', 'Jenna@purus.gov', 81, 'B'),
(159, 'Samson', 'CQpsIyqOKo', '2020-08-28', '6', 'Y0ewyzPzd8', 'Kiayada@ullamcorper.gov', 273, 'B'),
(160, 'Wayne', 'Iq1LFJnENh', '2020-08-26', '9', 'yNfE8NAA0u', 'Constance@augue.com', 848, 'A'),
(161, 'Jesse', 'CcrKiwVuQd', '2020-08-22', '1', 'hZLuC15kFj', 'Ralph@magnis.edu', 930, 'B'),
(162, 'Grace', 'yacuUGOqm7', '2020-08-27', '3', '3gly8m2GTy', 'Timon@ultrices.edu', 479, 'B'),
(163, 'Naida', 'OHX9npRl7H', '2020-08-25', '4', 'TyiWn8tTPS', 'Katelyn@quis.net', 463, 'B'),
(164, 'Kellie', 'rvIE8EGtRl', '2020-08-25', '0', 'R7szi3qDt6', 'Armand@felis.com', 257, 'A'),
(165, 'Leo', 'l8Vtgiygor', '2020-08-27', '9', '1ReozFOFiy', 'Troy@Nam.com', 388, 'B'),
(166, 'Nadine', '2bH13YUP8b', '2020-08-22', '7', 'l9W2mnF29p', 'Ainsley@sit.com', 655, 'A'),
(167, 'Walker', 'orB45nEaS7', '2020-08-23', '0', '9kg8pQ5kOJ', 'Akeem@inceptos.org', 370, 'A'),
(168, 'Madeline', 'JLOC4a WLv', '2020-08-26', '10', 'ZG1WodibR4', 'Gail@vitae.com', 747, 'B'),
(169, 'Stephanie', 'ish1rM0Gj5', '2020-08-22', '10', '2pZwCizVtI', 'Hunter@turpis.gov', 773, 'A'),
(170, 'Joshua', 'sY 6iiwjZD', '2020-08-24', '2', 'GMjmXYFd4c', 'Megan@sollicitudin.us', 500, 'A'),
(171, 'Cain', 'G0s3 KJNdL', '2020-08-28', '8', 'DknlLFz6O9', 'Lane@parturient.gov', 894, 'A'),
(172, 'Jada', 'y3slsqmTJU', '2020-08-23', '8', 'LOGA0Ls7rQ', 'Chase@sociosqu.org', 119, 'A'),
(173, 'Quyn', 'xdFrYnFTit', '2020-08-26', '7', 'B3nmLYqoi0', 'Dustin@penatibus.gov', 694, 'B'),
(174, 'Medge', 'qkmio8x6UD', '2020-08-26', '7', '7cCKM6Cpzm', 'Theodore@gravida.com', 522, 'A'),
(175, 'Mason', 'o8LcwxXdmh', '2020-08-26', '0', 'SeGCWNKYMg', 'Sandra@facilisi.gov', 501, 'B'),
(176, 'Wing', 'F6jnBMVOxO', '2020-08-22', '10', 'VGZQkijR7S', 'Brianna@vulputate.net', 277, 'A'),
(177, 'Aristotle', 'MzYaHK0n84', '2020-08-22', '0', 'WvKeFZTdUP', 'Hedwig@aptent.gov', 16, 'B'),
(178, 'Scott', 'mGuUxtrgn2', '2020-08-26', '0', '0IfizddRSJ', 'Gabriel@lectus.com', 341, 'A'),
(179, 'Rhonda', 'C0Q M0CD0H', '2020-08-23', '6', 'AGwJ1V5S3P', 'Madaline@cursus.edu', 645, 'B'),
(180, 'Zahir', 'egVIs1s1Yo', '2020-08-25', '3', 'tutasjkdrz', 'Bree@tristique.org', 873, 'B'),
(181, 'Chase', 'PjTNn2HhUL', '2020-08-28', '5', 'N4FKLrlMPf', 'Chase@ipsum.org', 957, 'B'),
(182, 'Shannon', 'AzsqmAIoml', '2020-08-25', '3', 'RA43CIYnSu', 'Carolyn@odio.gov', 321, 'A'),
(183, 'Julie', '2Kc7GTqFn3', '2020-08-24', '5', 'oRfLrn66gD', 'Olivia@nisi.com', 155, 'B'),
(184, 'Rachel', 'lYqXOTCweV', '2020-08-24', '6', 'j3CLWGMWuu', 'Kylie@gravida.org', 650, 'B'),
(185, 'Maggie', 'B5cfWRz78m', '2020-08-28', '6', 'M2EHDr4lMv', 'Jasmine@convallis.gov', 41, 'A'),
(186, 'Maggie', '4T0BEtszkk', '2020-08-24', '5', 'zyvXSwgXAT', 'Samantha@massa.us', 843, 'A'),
(187, 'Carter', 'qZFQjw4vF0', '2020-08-27', '5', 'lN1c1V0djJ', 'Zachery@nec.us', 491, 'B'),
(188, 'Hedy', 'VWy9yDihbC', '2020-08-23', '9', 'CgvREU4Fmb', 'Leilani@mus.net', 558, 'B'),
(189, 'Chadwick', 'noLQFWSOLj', '2020-08-28', '8', 'JSkdgtmO7d', 'Kirk@viverra.gov', 180, 'A'),
(190, 'Marvin', 'jkl3zJ20Xq', '2020-08-27', '1', '7O0eKmm8jJ', 'Tad@id.us', 890, 'B'),
(191, 'Darryl', 'VsQaMUcL2z', '2020-08-26', '1', 'FPHcKpONAS', 'Dawn@natoque.edu', 869, 'A'),
(192, 'Gregory', 'MoCgyaE1kj', '2020-08-22', '1', '78cDRAHXte', 'Cherokee@pellentesque.net', 607, 'B'),
(193, 'Dieter', 'rO6iKntMbH', '2020-08-22', '5', 'uzK6UUQgVj', 'Orlando@laoreet.us', 46, 'A'),
(194, 'Mercedes', 'xHyYJj3FDg', '2020-08-26', '0', 'b8b275MA29', 'Kyle@rutrum.gov', 460, 'A'),
(195, 'Kirsten', 'qOpQCmONRT', '2020-08-26', '0', 'BvT4d77P0R', 'Rana@feugiat.net', 494, 'B'),
(196, 'Cade', 'VfUFvyMnYD', '2020-08-27', '5', 'uLePy7G4nX', 'Odessa@cursus.org', 973, 'A'),
(197, 'Sydney', 'daZUVsqqd1', '2020-08-24', '9', 'wOFOSIh9Dw', 'Ebony@convallis.edu', 819, 'B'),
(198, 'Connor', 'igxq7N1Xpj', '2020-08-27', '10', 'yDQHVLh9Zs', 'Cameron@aptent.us', 691, 'B'),
(199, 'Driscoll', 'm YiuC1P0b', '2020-08-28', '3', 'puTwEQmXd7', 'Stephanie@tellus.net', 331, 'A'),
(200, 'Brett', 'eHeMjmiQwc', '2020-08-27', '3', '6pfRCYKb9Z', 'Lynn@lacus.edu', 62, 'A'),
(201, 'Beck', 'GfNHJFn24z', '2020-08-26', '1', 'HrjcdBGVhc', 'Malik@Nunc.com', 943, 'A'),
(202, 'Jared', 'pI5cxNiCvF', '2020-08-27', '9', '8bO8bTtJ4A', 'Laurel@suscipit.com', 976, 'B'),
(203, 'Rachel', 'Hok3f3OhEH', '2020-08-26', '3', 'X3cPRkQpzL', 'Uriah@neque.net', 952, 'B'),
(204, 'Cole', 'BayFfyWn2K', '2020-08-26', '6', 'BaOWUvmbMG', 'Shana@ante.edu', 849, 'A'),
(205, 'Scarlett', 'T0NFVr4kV7', '2020-08-24', '6', 'rJRyWt0ul1', 'Steven@commodo.net', 536, 'A'),
(206, 'Gavin', 'aaAGpY wY0', '2020-08-28', '3', 'FmhqPX1OOR', 'Nissim@sociis.gov', 66, 'A'),
(207, 'Xandra', 'lQRQf4zIdb', '2020-08-24', '10', 'v0GiYrABou', 'Evelyn@Vivamus.com', 142, 'A'),
(208, 'Forrest', 'qOAQUHMzeA', '2020-08-26', '8', 'D6fO039h3X', 'Alyssa@eleifend.us', 776, 'A'),
(209, 'Jarrod', 'nV3eWmnE0W', '2020-08-22', '1', 'sbajTnDUMv', 'Matthew@posuere.net', 9, 'A'),
(210, 'Hope', 'X3XaWErjkM', '2020-08-26', '5', 'AH8YkO8IE7', 'Rigel@ipsum.gov', 637, 'A'),
(211, 'Alan', 'kH8eFRttje', '2020-08-25', '1', '5wSZ4UbxkA', 'Dana@morbi.us', 999, 'A'),
(212, 'Flynn', 'PvHSXIhSbY', '2020-08-24', '1', 'k0nJkwNzaG', 'Danielle@Curae.org', 856, 'B'),
(213, 'Aline', 'DKiu52hGyy', '2020-08-22', '8', '8wEpVl3fYn', 'Gay@vestibulum.com', 833, 'B'),
(214, 'Henry', 'd9UQtqfwP6', '2020-08-26', '3', 'L98WXuggdq', 'Aimee@primis.gov', 210, 'B'),
(215, 'Holmes', 'PHUZZ70Spf', '2020-08-28', '7', 'pgTEgk5wFk', 'Hollee@In.edu', 341, 'B'),
(216, 'Castor', 'y5oo7wbB4x', '2020-08-24', '1', '4CyONUO7jI', 'Acton@nibh.net', 65, 'B'),
(217, 'Conan', 'MOt88X8EM ', '2020-08-23', '7', 'jJFJcLedds', 'Jarrod@sociis.us', 851, 'A'),
(218, 'Ella', 'D9MFqEgb1R', '2020-08-24', '4', 'qNBez3GDMe', 'Walker@pretium.edu', 120, 'B'),
(219, 'Nina', 'HFpUNbGYGq', '2020-08-24', '5', 'eGVd8B29au', 'Phoebe@Curabitur.com', 879, 'A'),
(220, 'Lillith', 'F44NUhnnsP', '2020-08-28', '4', 'kwnI8anauQ', 'Marny@quis.edu', 665, 'A'),
(221, 'Candace', 'zwlTV94s9O', '2020-08-26', '7', 'odcbFxWwuc', 'Akeem@molestie.net', 288, 'B'),
(222, 'Abdul', 'h6nCDzF5Zs', '2020-08-26', '9', 'D4pCKhj4bL', 'Yoshio@in.com', 698, 'A'),
(223, 'Cullen', 'dPdreYuWXs', '2020-08-26', '6', 'rofz5hzhUt', 'Karyn@mus.net', 355, 'B'),
(224, 'Quon', '4advDn2w H', '2020-08-24', '8', '3InnH9iDPx', 'Fitzgerald@mi.gov', 65, 'B'),
(225, 'Gray', 'zezd8OqPQV', '2020-08-28', '2', 'oB1L51Ag0v', 'Beau@ridiculus.gov', 768, 'A'),
(226, 'Heidi', '9HWBZJBQBr', '2020-08-27', '3', 'nAijId9iK2', 'Kevin@In.gov', 607, 'B'),
(227, 'Caldwell', 'Gp1nMZtPhQ', '2020-08-24', '10', 'wmci5yvCdA', 'Martin@morbi.edu', 876, 'A'),
(228, 'Sacha', 'vdpNoZxevl', '2020-08-27', '4', 'j4FYIZz5yD', 'Xantha@Donec.us', 689, 'B'),
(229, 'Kiayada', '0tEsDG9aM5', '2020-08-28', '2', 'ZklaKMNFL3', 'Levi@ullamcorper.gov', 419, 'B'),
(230, 'Sharon', 'HRKlr F8oG', '2020-08-22', '6', 'OnTXbUp5A0', 'Linus@penatibus.us', 721, 'B'),
(231, 'Dante', 'QoASiUs3Wc', '2020-08-27', '0', 'LYGPOljrBX', 'Dara@neque.org', 793, 'A'),
(232, 'Burke', 'pvT7Rad0BM', '2020-08-22', '6', 'fvLVJGv5Uj', 'Dean@consectetuer.com', 343, 'A'),
(233, 'Zachery', 'VecEEJNfaF', '2020-08-28', '2', 'lbem5Dpwmb', 'Maryam@adipiscing.edu', 712, 'B'),
(234, 'Martena', 'HyjcxA4D1Q', '2020-08-24', '5', '12IzzfPg8o', 'Harding@pharetra.org', 898, 'A'),
(235, 'Kyra', 'ZQsBSB AEb', '2020-08-24', '4', '1qqdEDUu7W', 'Hyacinth@Etiam.edu', 612, 'A'),
(236, 'Illiana', 'H1DBgDDqGk', '2020-08-26', '10', '3FlMm0jfEl', 'Rae@taciti.com', 493, 'A'),
(237, 'Keely', 'oKizhPPw2t', '2020-08-26', '5', 'hfcZJlOkBM', 'Gray@convallis.net', 318, 'B'),
(238, 'Tyrone', 'W2Rk6FxwRz', '2020-08-27', '1', 'EYlbQ4Peh6', 'Whilemina@fames.us', 691, 'B'),
(239, 'Caleb', 'RuR0pDfzxC', '2020-08-26', '0', 'lA6zRatxDa', 'Alden@commodo.edu', 362, 'A'),
(240, 'Nathaniel', 'lzUf18ICxc', '2020-08-23', '8', 'ysJitW4pFQ', 'Elaine@facilisis.net', 544, 'B'),
(241, 'Alvin', '45ThYGAbcw', '2020-08-26', '0', '21OlPHRXoS', 'Lyle@lectus.com', 724, 'B'),
(242, 'Colt', 'Md2gblZ52h', '2020-08-22', '6', '9GJjNLCTtm', 'Zelenia@sapien.edu', 160, 'B'),
(243, 'Hilel', 'jtjZhJbrDh', '2020-08-24', '4', 'QkiCNyRNcA', 'Hannah@imperdiet.org', 396, 'A'),
(244, 'Rhona', 'KTVVypaKih', '2020-08-28', '9', 'GTQLFgjx7U', 'Stewart@nonummy.gov', 553, 'B'),
(245, 'Rana', 'oCk4QuCArR', '2020-08-24', '3', '4GOaKBBKR9', 'Reuben@purus.edu', 947, 'B'),
(246, 'Addison', 'FjiSHFlMnr', '2020-08-24', '0', 'S6XCkd4fyy', 'Vera@nonummy.gov', 803, 'B'),
(247, 'Shaeleigh', 'pIiy4TOJJm', '2020-08-26', '4', 'u0btd8lFa9', 'Rama@sodales.net', 604, 'A'),
(248, 'Gareth', 'ek8gId3 Wj', '2020-08-27', '7', 'e2vYfnZydT', 'Nash@tempus.us', 820, 'B'),
(249, 'Warren', 'PilAgYJztu', '2020-08-27', '6', 'odTVUdUY5c', 'Joshua@ac.gov', 331, 'B'),
(250, 'Dane', 'lz hxrt9xa', '2020-08-22', '5', 'mnfxDb0Kjh', 'Nicholas@auctor.com', 935, 'B'),
(251, 'Bianca', 'jgnnkDXjsE', '2020-08-27', '8', '3rCLnsAqXR', 'Isabella@ultrices.gov', 383, 'A'),
(252, 'Hayden', 'E20TtAFgos', '2020-08-25', '2', 'RkDqwaC5vR', 'Marcia@pulvinar.org', 942, 'A'),
(253, 'Samuel', 'mydHmNs5HE', '2020-08-28', '3', '5rKvjohfOH', 'Heather@nisi.gov', 509, 'A'),
(254, 'Lucian', 'w JdR1WUmn', '2020-08-28', '6', 'BBo7amDNJR', 'Jared@porta.org', 700, 'A'),
(255, 'Colt', 'kCgMW28PCk', '2020-08-22', '9', 'olPANGODST', 'Kato@volutpat.us', 28, 'B'),
(256, 'Hyatt', 'GE763wvnhl', '2020-08-22', '8', 'LaatF0sQF4', 'Ayanna@suscipit.org', 357, 'B'),
(257, 'Astra', 'rN95IjKGWp', '2020-08-22', '2', 'FIdAr6CRk3', 'Dorian@turpis.com', 868, 'A'),
(258, 'Georgia', 'ewkxAUl9Tg', '2020-08-26', '9', 'jpHTs8qEcI', 'Jesse@Curabitur.com', 30, 'B'),
(259, 'Chantale', 'I03Sv4pjeB', '2020-08-24', '4', 'X835eG4Bdi', 'Jakeem@arcu.us', 582, 'A'),
(260, 'Salvador', '0PbCe6axVM', '2020-08-25', '3', 'a3pchcOBaN', 'Brenden@aptent.net', 268, 'A'),
(261, 'Geoffrey', 'hQmo lPbcw', '2020-08-23', '2', 't2myXiZSGx', 'Merritt@orci.org', 744, 'B'),
(262, 'Rachel', 'QdDSm98k5g', '2020-08-28', '5', 're8LVgMBTH', 'Aspen@hymenaeos.gov', 412, 'A'),
(263, 'Anne', 'ADdIcE42qI', '2020-08-22', '5', 'eTnobNLOqm', 'Grady@venenatis.gov', 749, 'B'),
(264, 'Ishmael', '1DawYBAS5y', '2020-08-26', '3', 'vt1JS2NkFW', 'Imelda@congue.gov', 799, 'B'),
(265, 'Deanna', 'CRu3jzGVyg', '2020-08-24', '8', 'U0JqcOgW7t', 'Clinton@hymenaeos.edu', 540, 'B'),
(266, 'Ruby', 'GkqJv4HVoa', '2020-08-28', '1', 'wBFSnMrDwM', 'Christen@parturient.net', 874, 'A'),
(267, 'Carolyn', 'LmQ7TCTw0d', '2020-08-25', '7', 'I6m3RRMtKf', 'Jemima@nostra.edu', 111, 'B'),
(268, 'Hashim', 'XDgFQAGOgM', '2020-08-25', '1', 'rBnVFNmPPy', 'Lacy@in.org', 280, 'A'),
(269, 'Helen', 'gFw9IDEaJJ', '2020-08-22', '9', '17yy1Gvr9U', 'Sopoline@pellentesque.edu', 565, 'A'),
(270, 'Hop', '2KXmI1MA2F', '2020-08-22', '1', 'q2fNAtHZab', 'Nash@iaculis.org', 507, 'B'),
(271, 'Charlotte', 'Vm5Gl62TMu', '2020-08-25', '7', 'eurdLWBXWi', 'Abigail@accumsan.org', 472, 'A'),
(272, 'Megan', '7A3aQQZv2X', '2020-08-22', '9', 'EFsNz3feUE', 'George@feugiat.gov', 311, 'A'),
(273, 'Beverly', 'mKF6XCwEkN', '2020-08-26', '10', '9qD0G5bWDX', 'Knox@facilisi.us', 300, 'B'),
(274, 'Emily', '5SsPLtvUEA', '2020-08-25', '7', 'YJKAtmtfxq', 'Hedy@primis.us', 127, 'A'),
(275, 'Nita', '0ELidAnBpY', '2020-08-23', '5', 'AxXghxtI6d', 'Tamekah@ridiculus.gov', 470, 'B'),
(276, 'Gwendolyn', 'ogvaiyVhJT', '2020-08-25', '10', 'YwRGO3nbP6', 'Jacob@Aliquam.org', 336, 'B'),
(277, 'Chantale', 'jq20R8GsQ9', '2020-08-24', '10', 'CBwe3Td3pa', 'Teegan@eleifend.gov', 185, 'B'),
(278, 'Karina', ' qBldnVH8o', '2020-08-27', '5', '8L5oRj3qS4', 'Fay@lorem.com', 315, 'A'),
(279, 'Herman', 'LypV6cnwVb', '2020-08-25', '5', '6zqWilOJiM', 'Imelda@orci.us', 358, 'B'),
(280, 'Sasha', 'A gDpibitU', '2020-08-27', '6', 'b94zU3J2st', 'Amos@convallis.org', 579, 'B'),
(281, 'Laura', 'dGCin9NJWZ', '2020-08-26', '3', 'gpSdTbXjbp', 'Nell@Pellentesque.org', 715, 'A'),
(282, 'Cassidy', 'dBI8eigrCO', '2020-08-27', '4', 'UOYKJsAKPq', 'Jared@purus.com', 683, 'B'),
(283, 'Adria', '4eW05Wg2Po', '2020-08-27', '6', 'rJ7NNakKga', 'Gil@condimentum.com', 681, 'A'),
(284, 'Deacon', '52v57uCWY0', '2020-08-24', '1', '953bNhTw3e', 'Jarrod@pellentesque.com', 179, 'A'),
(285, 'Mercedes', 'RLK4xtqrzK', '2020-08-28', '10', 'fip0bFbARq', 'Signe@quis.edu', 430, 'B'),
(286, 'Salvador', 'Zy44F0XJJ4', '2020-08-27', '5', 'u7mx5CdNo0', 'Irene@posuere.gov', 250, 'A'),
(287, 'Kieran', 'fcz kaGHtS', '2020-08-28', '0', 'Pu7ldzXJUY', 'Ezra@eu.org', 890, 'B'),
(288, 'Len', '9IWJQUj01I', '2020-08-26', '3', 'LdX72NqBGQ', 'Anastasia@torquent.edu', 770, 'B'),
(289, 'Galena', 'VZCcUbdo3T', '2020-08-28', '8', '4V0fjzdiW4', 'Abra@consectetuer.edu', 19, 'B'),
(290, 'Whoopi', 'YZm1bXhnLa', '2020-08-25', '0', 'FaCzgMoqdL', 'Zane@in.org', 533, 'B'),
(291, 'Penelope', 'QQj0q7Z7dg', '2020-08-24', '4', '3826yF3bj6', 'Jamalia@natoque.net', 515, 'A'),
(292, 'Brent', '3n31kt7S1P', '2020-08-27', '1', 'IPENCOBAeT', 'Keaton@id.org', 910, 'A'),
(293, 'Fulton', '1zMfAMrlUM', '2020-08-22', '9', 'wYWpCBKRqf', 'Aiko@aliquet.org', 598, 'B'),
(294, 'Shelby', 'E3i9w4qUcs', '2020-08-26', '9', '5sOqYfA90D', 'Rama@fermentum.net', 553, 'A'),
(295, 'Warren', 'edZnWc629H', '2020-08-22', '8', 'tRPFJAcU2F', 'Buffy@id.us', 727, 'B'),
(296, 'Jamalia', 'QsJhzfvXKk', '2020-08-27', '4', '7LdluYbvxu', 'Rhoda@ullamcorper.us', 132, 'B'),
(297, 'Hammett', 'LGRXUDDJ1F', '2020-08-23', '5', 'CMAKAkv9c6', 'Erica@Nunc.edu', 639, 'A'),
(298, 'Pascale', 'iOQ8qxoFsr', '2020-08-25', '6', 'axgorY4Smo', 'Rhonda@est.us', 946, 'B'),
(299, 'Yolanda', 'wtMbjYe3tG', '2020-08-22', '6', 'NVl86SEWc1', 'Dexter@Proin.org', 944, 'B'),
(300, 'Fallon', '4CTInE5ZgK', '2020-08-25', '3', 'F9jhyNbjLG', 'Hope@Aliquam.edu', 765, 'A'),
(301, 'Gretchen', 'WnjjfdTd H', '2020-08-27', '6', 'K74E7UI8PP', 'Amy@Phasellus.us', 589, 'A'),
(302, 'Simon', 'K mB2Y6rpU', '2020-08-26', '8', 'nNx5JmNmr8', 'Wyatt@Maecenas.net', 317, 'B'),
(303, 'Grady', 'NXKv AtLGl', '2020-08-26', '2', 'G9huR4t9OR', 'Cadman@diam.edu', 530, 'A'),
(304, 'Dana', 'I2y7XEhNSR', '2020-08-27', '10', 'Cx6Kl5BajF', 'Doris@Etiam.edu', 732, 'B'),
(305, 'Palmer', 'lPlrXnL87x', '2020-08-27', '7', 'btwaMbQpr8', 'Lilah@ipsum.edu', 57, 'A'),
(306, 'Ciara', 'wFtolfMBFm', '2020-08-25', '8', 'SFfMqn6j1e', 'Declan@quam.net', 75, 'B'),
(307, 'Hamish', 'J25TUDAdJY', '2020-08-23', '8', '0FR3obueSF', 'Daryl@ac.org', 65, 'A'),
(308, 'Hedy', 'bq7qMvZjI9', '2020-08-28', '5', '1EUJzmdByM', 'Alec@tellus.edu', 949, 'B'),
(309, 'Victor', 'PnI4AS9LXc', '2020-08-24', '1', 'aeqMZ5GczN', 'Steel@parturient.net', 718, 'A'),
(310, 'Delilah', 'T05AB6Rads', '2020-08-22', '4', 'Lj24oo41JA', 'Candace@turpis.edu', 659, 'B'),
(311, 'Ramona', 'RjRjyHCAQM', '2020-08-27', '3', 'ep0JjAgeea', 'Shafira@adipiscing.gov', 568, 'B'),
(312, 'Merrill', 'T7nMaMrnhm', '2020-08-24', '8', 'SK8Rtzt6o8', 'Jasper@aptent.com', 569, 'B'),
(313, 'Chanda', 'mfNacgquJG', '2020-08-24', '2', 'HQ7YujDReG', 'Emery@nunc.gov', 835, 'B'),
(314, 'Kamal', 'L9ppVvsX46', '2020-08-25', '1', 'QqDnUOsH5n', 'Judith@elementum.edu', 929, 'A'),
(315, 'Cain', 'BNH7WdMgMN', '2020-08-25', '6', 'HpenJBzU8B', 'Aspen@placerat.com', 254, 'B'),
(316, 'Chiquita', '4x7xyhfNKo', '2020-08-26', '2', 'iQZx3ycf75', 'Amela@Nulla.org', 811, 'A'),
(317, 'Lynn', 'idgaT59A4M', '2020-08-27', '9', 'b1GGQViORY', 'Blaze@luctus.com', 733, 'A'),
(318, 'Barbara', '4NJHeeAlAv', '2020-08-25', '7', 'OX4IMviGnK', 'Leah@turpis.com', 962, 'A'),
(319, 'Karleigh', 'O6YlJIZDUt', '2020-08-22', '9', 'v7T3yTimRg', 'Jescie@Lorem.gov', 327, 'B'),
(320, 'Althea', 'X0zBx4sJQS', '2020-08-28', '8', '4cirpFSw4H', 'Ivan@consequat.org', 224, 'B'),
(321, 'Quintessa', 'jHR64hOeZQ', '2020-08-27', '4', 'OEWFuEsPkW', 'Keelie@volutpat.com', 446, 'B'),
(322, 'Quinn', 'S8UF7kRI43', '2020-08-26', '0', 's9MrWPUL65', 'Fletcher@urna.edu', 203, 'A'),
(323, 'Germaine', 's3Reycca1V', '2020-08-23', '8', '9iv6zczBWh', 'Ivor@varius.gov', 564, 'A'),
(324, 'Serina', '99O4qnqs8V', '2020-08-24', '0', 'yYqtg9z975', 'Kristen@iaculis.net', 567, 'B'),
(325, 'Riley', 'AqDhK6anBd', '2020-08-26', '0', 'SJsyQwQ3NZ', 'Calvin@ut.com', 663, 'A'),
(326, 'Grady', 't43V9bkjD4', '2020-08-28', '6', 'OkezN2Swf2', 'Holmes@Integer.gov', 293, 'B'),
(327, 'Jillian', 'zQCMDQ4Jvk', '2020-08-24', '0', 'fxon28mZ3d', 'Sage@ullamcorper.edu', 455, 'A'),
(328, 'Davis', 'NZqfxn2D0i', '2020-08-25', '5', 'VCcq9Csvx6', 'Emery@Vivamus.edu', 336, 'B'),
(329, 'Kadeem', 'K3jF43mvWn', '2020-08-25', '7', 'TauUjcEKEQ', 'Porter@morbi.net', 454, 'A'),
(330, 'Elliott', 'S6bW9K6g2n', '2020-08-27', '0', 'b4FZwdlVBU', 'Shelley@suscipit.edu', 563, 'B'),
(331, 'Acton', 'yZZWSlFvnv', '2020-08-24', '4', '4WMdXJZOLa', 'Genevieve@lacus.edu', 849, 'A'),
(332, 'Brenda', '0OISnTNrLV', '2020-08-24', '7', 'nOxRQfaL20', 'Tanya@mollis.us', 930, 'B'),
(333, 'Bernard', 'D74RSUSo7u', '2020-08-26', '7', 'lIMVF2HQzK', 'Xander@gravida.edu', 301, 'B'),
(334, 'Gay', 'i9o x1DOrb', '2020-08-26', '2', 'BahFhs9WD3', 'Amy@enim.gov', 748, 'A'),
(335, 'Ginger', 'cCXbYs6eMN', '2020-08-28', '2', 'kMLnpoeRNJ', 'Alexis@hymenaeos.edu', 861, 'B'),
(336, 'Oscar', 'hNStNfAQmz', '2020-08-23', '9', 'KynWGlCbbm', 'Kieran@quam.edu', 497, 'A'),
(337, 'Kylynn', 'csvcURIAzO', '2020-08-24', '5', '45BzoL03Ip', 'Leigh@gravida.org', 806, 'B'),
(338, 'Elton', '1R7oIKbKJh', '2020-08-25', '6', 'Uun4gZ3Tia', 'Bruno@Pellentesque.edu', 707, 'A'),
(339, 'Amanda', ' GqVXQURSF', '2020-08-22', '4', 'paQGmn3wOq', 'Upton@Lorem.org', 148, 'B'),
(340, 'Aimee', 'bZEC9m75Km', '2020-08-22', '4', 'E0zxgyzYRf', 'Melissa@tempor.gov', 99, 'B'),
(341, 'Nathan', 'UIbaPoVjx5', '2020-08-25', '7', '8uOXqW3Bpu', 'Sebastian@adipiscing.us', 549, 'B'),
(342, 'Isabelle', 'CQyzu8zwAj', '2020-08-28', '7', 'uv9LwpKlux', 'Jessica@sed.com', 308, 'B'),
(343, 'Bradley', 'ACjyfTU7Fb', '2020-08-22', '5', 'j5E2HB4Ib5', 'Jack@netus.org', 244, 'A'),
(344, 'Micah', 'wz1gWyMyd9', '2020-08-24', '2', 'ibHgJCj2FH', 'Carson@Nunc.org', 314, 'B'),
(345, 'Shad', 'QmrJ0myk8C', '2020-08-22', '7', 'ZQS3ML2QAr', 'Noble@vulputate.us', 519, 'A'),
(346, 'Brennan', 'fsx7OpT WQ', '2020-08-24', '6', 'HJ8GqaeYU9', 'Naomi@commodo.net', 766, 'B'),
(347, 'Kevyn', '3i53Wk7yn9', '2020-08-23', '1', 'khs2rF3eYZ', 'Brandon@sollicitudin.gov', 443, 'B'),
(348, 'Kasimir', 'npQPtnKZfa', '2020-08-27', '9', 'roentzPAP1', 'Chava@per.us', 779, 'B'),
(349, 'Avye', 'vpiwsqszBE', '2020-08-26', '0', 'eF3xq17On9', 'Lance@magna.org', 846, 'A'),
(350, 'Upton', ' C QGND7YU', '2020-08-27', '10', 'PEeblzWDWS', 'Dominique@dolor.com', 537, 'B'),
(351, 'Odessa', 'LCK VdsM8F', '2020-08-26', '1', 'RkbsdKif7T', 'Dane@Class.gov', 977, 'A'),
(352, 'Nyssa', 'NtJYCAtRMn', '2020-08-22', '3', 'ZJGafxQxXq', 'Germane@montes.edu', 906, 'A'),
(353, 'Kelsie', 'eT8mKWDq3e', '2020-08-27', '4', 'zX0Gu4eDy7', 'Regina@Suspendisse.us', 859, 'A'),
(354, 'Thor', 'xyOnmJ1s i', '2020-08-26', '3', 'sBY0N4YrJj', 'Neil@leo.gov', 965, 'A'),
(355, 'Clementine', 'IslVi588ld', '2020-08-25', '8', 'PkQzHj6IvP', 'Kirk@Cras.edu', 184, 'A'),
(356, 'Vance', '5pVxLBmH9o', '2020-08-23', '5', 'pM7iNkTPf0', 'Dacey@erat.gov', 592, 'A'),
(357, 'Tallulah', 'yDr2G24xcI', '2020-08-25', '4', 'nqvxMg5TYC', 'Scott@diam.org', 237, 'B'),
(358, 'Sean', 'YbXar74HDz', '2020-08-28', '4', 'CtlQwA0PV5', 'Eric@sodales.com', 786, 'A'),
(359, 'Lareina', 'EDluW76Id1', '2020-08-28', '4', 'sP7yCDodLo', 'Sandra@leo.us', 630, 'A'),
(360, 'Willow', 'jStGphL0Uq', '2020-08-28', '4', 'LmYoIsD3iz', 'Sopoline@porttitor.org', 720, 'B'),
(361, 'Ivor', 'b69PnBZmSm', '2020-08-28', '8', 'QZWw0QfH3d', 'Nell@nascetur.org', 653, 'A'),
(362, 'Elvis', 'WOBDYQx66w', '2020-08-26', '8', 'iuwUpmar4n', 'Alden@penatibus.com', 314, 'B'),
(363, 'Jael', 'sYA5OwRDB3', '2020-08-25', '6', 'o5xNXLFryh', 'Vance@nonummy.gov', 878, 'A'),
(364, 'Macaulay', 'myirior9fF', '2020-08-24', '8', '3xP3TSNdDu', 'Zephr@tempor.edu', 685, 'B'),
(365, 'Kitra', 'AqKBQS3W3u', '2020-08-22', '9', 'afaZoDjzcr', 'Mufutau@ullamcorper.gov', 710, 'A'),
(366, 'Mari', 'kT7q6S2YSc', '2020-08-28', '5', '05UWjUK0VZ', 'Kermit@porttitor.edu', 791, 'B'),
(367, 'Camille', 'TnZuljXzmN', '2020-08-22', '6', 'VqKx3dVVuB', 'Yasir@Vivamus.us', 425, 'A'),
(368, 'Wilma', 'RQ4BHHuoLQ', '2020-08-28', '6', '8EGgNVMk8P', 'Hoyt@turpis.edu', 355, 'A'),
(369, 'Riley', 'ZfuZrGSxxM', '2020-08-26', '1', 'jsoXsPXk6t', 'Lester@at.edu', 841, 'B'),
(370, 'Destiny', 'hx4B56s2wi', '2020-08-27', '0', 'U8VzMZNs5E', 'Wade@Vestibulum.com', 82, 'B'),
(371, 'Austin', '1 Z6BOjBNh', '2020-08-25', '7', 'VRZbq0VcvL', 'Nelle@libero.org', 611, 'B'),
(372, 'Francis', '0Wa5h9p48x', '2020-08-23', '0', 'bf40i37WKJ', 'Sawyer@libero.gov', 984, 'B'),
(373, 'Zeus', 'JVzZaCueIq', '2020-08-23', '3', 'OArSO8FS5G', 'Myles@Nullam.org', 704, 'B'),
(374, 'Frances', 'uqz5UxfiCQ', '2020-08-27', '10', 'iZnMAvYwdc', 'Arthur@porta.us', 719, 'A'),
(375, 'Cassandra', 'dGj6tTS9 5', '2020-08-25', '1', 'qdRmwARSlh', 'Margaret@eleifend.org', 733, 'B'),
(376, 'Alfreda', 'fqmI6yGTyF', '2020-08-22', '4', 'VKKlG6pezr', 'Hilda@aptent.com', 258, 'A'),
(377, 'Celeste', 'Qq1qVw2RmG', '2020-08-25', '5', '4v9g2KUIdK', 'Ora@mollis.org', 593, 'B'),
(378, 'Tashya', 'cSQuCyXI w', '2020-08-28', '5', 'YjFCQfxtsh', 'Idola@Nulla.net', 956, 'A'),
(379, 'Darryl', 'z2etAltlq0', '2020-08-22', '9', '3XlNAisjrO', 'Cain@hymenaeos.edu', 435, 'A'),
(380, 'Reuben', '18hLLHFqxV', '2020-08-25', '7', '5KE4Nb5oVx', 'Nina@litora.us', 410, 'B'),
(381, 'Denise', 'Nnhj1vY7Sh', '2020-08-23', '2', 'gJDQX6cKvs', 'Kuame@dapibus.us', 152, 'B'),
(382, 'Driscoll', 'NN0UN0BUHZ', '2020-08-24', '1', '1JjtqKK4Ea', 'Yardley@venenatis.gov', 765, 'A'),
(383, 'Ignatius', 'CG KHNqFSU', '2020-08-25', '0', 'XgpxDGHfj9', 'Marcia@justo.gov', 534, 'A'),
(384, 'Kevin', 'moOd1gBha7', '2020-08-22', '9', 'CwCT4Pgi2g', 'Leonard@sagittis.edu', 831, 'B'),
(385, 'Aaron', 'oCpFUCEfqA', '2020-08-28', '1', 'tyu5G6SmpP', 'Carlos@Proin.us', 331, 'A'),
(386, 'Rowan', '4obKEtjGES', '2020-08-27', '0', 'DqXk2YfZrx', 'Hiram@lacus.com', 620, 'A'),
(387, 'Connor', 'zjjniz hK4', '2020-08-24', '1', 'AKTPybtTow', 'Dora@netus.org', 266, 'A'),
(388, 'Guinevere', 'cpG8OROQWa', '2020-08-27', '8', 'TUF6P9kAE7', 'India@aptent.us', 156, 'A'),
(389, 'Nelle', 'OhfpWivp9y', '2020-08-24', '9', '46z3cmIwAS', 'Gannon@Curae.org', 206, 'A'),
(390, 'Ishmael', 'YL 1Q7Pzgv', '2020-08-25', '5', '5qeU23CHL1', 'Orson@velit.org', 711, 'B'),
(391, 'Yuri', 'hdDs4 lAM5', '2020-08-27', '2', 'VQjEVJnwcS', 'Charles@pulvinar.com', 878, 'A'),
(392, 'Kiona', 'RySezHo7lv', '2020-08-23', '8', 'T3ovAjiesm', 'Kenyon@faucibus.us', 741, 'A'),
(393, 'Marny', '2h3NnZhzHE', '2020-08-28', '2', 'wCNLkjEAy8', 'Leslie@consectetuer.org', 294, 'B'),
(394, 'Alexa', 'yO2qH96UQu', '2020-08-28', '4', 'F8SPVmOFgL', 'Carla@penatibus.net', 991, 'A'),
(395, 'Francis', '3SSKwucjqz', '2020-08-24', '10', 'tpY13L3vT1', 'Palmer@volutpat.org', 780, 'B'),
(396, 'Anjolie', '4PmNEyUf2m', '2020-08-25', '4', 'q9vwMwMqhI', 'Cadman@Ut.gov', 812, 'B'),
(397, 'Jeremy', 'vMMsEoR i0', '2020-08-23', '0', 'A0H8jXFh0p', 'Keefe@mattis.net', 464, 'A'),
(398, 'Bree', 'UBUmVvpM48', '2020-08-25', '1', 'E4sVbMQJqT', 'Indigo@ut.net', 369, 'A'),
(399, 'James', 'llnbVkZPRJ', '2020-08-25', '9', 'y6F7hoQtM8', 'Alexa@lectus.org', 190, 'B'),
(400, 'Steven', '2psiVrRy9P', '2020-08-24', '8', 'Nb9A6AxOYG', 'Alma@conubia.net', 608, 'A'),
(401, 'Hector', 'Rr9AxWbJXl', '2020-08-25', '1', 'dMGQhDIEEY', 'Aretha@Donec.us', 856, 'A'),
(402, 'Imelda', 'UuPws8J0Td', '2020-08-27', '4', 'qhpwhlmcAs', 'Kaye@nascetur.com', 67, 'B'),
(403, 'Nigel', 'ozQLIJ3d0R', '2020-08-24', '1', '8Ncf4zaKD2', 'Allistair@semper.org', 139, 'A'),
(404, 'Gary', '1T7OVx4Qc3', '2020-08-23', '9', '6cq0ShSroy', 'Ira@aptent.com', 222, 'B'),
(405, 'Geoffrey', 'GvNaet9dKS', '2020-08-25', '3', 'EUdu5pem3B', 'Ian@purus.com', 814, 'A'),
(406, 'Flynn', '5Ve4ItB0Jk', '2020-08-28', '6', 'dFgiDKJRtj', 'Yen@elementum.edu', 551, 'B'),
(407, 'Kieran', 'pQbe5WS2JG', '2020-08-28', '8', 't1uBUmHTlP', 'Daria@massa.us', 306, 'A'),
(408, 'Isaac', 'W55xPNN0Ch', '2020-08-26', '2', 'KRsxQsR5V9', 'MacKensie@facilisis.us', 192, 'B'),
(409, 'Mark', 'ttcVw1u1pc', '2020-08-23', '1', 'yWRJgko3hO', 'Jana@ultrices.net', 372, 'B'),
(410, 'Kellie', 'Qrq9k0UBsA', '2020-08-25', '5', '4y8Xl0qHC7', 'Zelda@malesuada.net', 315, 'B'),
(411, 'Griffin', 'NAlLp2OuqG', '2020-08-25', '0', 'qpSBHU8ayG', 'Raven@tortor.org', 999, 'A'),
(412, 'Linda', '5RdHjX Icf', '2020-08-28', '1', '6hReQbxUpu', 'Lamar@in.net', 764, 'A'),
(413, 'Sharon', 'ppq2nQcpaD', '2020-08-28', '2', 'xAf4x1V7o0', 'Curran@dignissim.org', 242, 'B'),
(414, 'Palmer', 'nKX Pwz7q4', '2020-08-28', '9', 'rPqeIRlVeV', 'Stuart@vel.us', 869, 'A'),
(415, 'Griffith', 'x68yQ0mvd0', '2020-08-22', '7', 'acSfIVK0SI', 'Hedda@dui.gov', 867, 'A'),
(416, 'Erich', '3rlhkKAMal', '2020-08-23', '4', 'NYswNb1jph', 'Kai@vel.gov', 112, 'A'),
(417, 'Karen', 'YIE9NxhxM9', '2020-08-27', '0', 'AcuhSiSnsR', 'Nola@luctus.edu', 435, 'A'),
(418, 'Abbot', 'm4kRNysHwN', '2020-08-28', '7', '11GcLev04l', 'Amir@Pellentesque.net', 435, 'A'),
(419, 'Echo', '1WrRHanYuy', '2020-08-25', '8', 'iOVXwA11g4', 'Inez@ullamcorper.us', 567, 'A'),
(420, 'Inga', 'T8Bkg9bbQt', '2020-08-27', '9', '8gUwl9exbB', 'Colton@sem.edu', 823, 'A'),
(421, 'Kane', '2CzfPYYYEE', '2020-08-26', '10', 'WSLr4MkRDo', 'Zorita@Aliquam.gov', 990, 'B'),
(422, 'Catherine', '8Wk6UNj36z', '2020-08-24', '6', 'BoMiINeUZE', 'Natalie@venenatis.us', 421, 'A'),
(423, 'Trevor', '5Jaaj8tx6N', '2020-08-24', '10', 'ut6YbI28RI', 'Buckminster@metus.edu', 989, 'A'),
(424, 'Carter', 'sFbvXPhUYK', '2020-08-23', '1', 'zsXemouL6g', 'Benedict@rhoncus.edu', 188, 'A'),
(425, 'Kai', 'nptuejgwzU', '2020-08-23', '6', 'uubOTP3sUB', 'Heather@suscipit.us', 376, 'A'),
(426, 'Dale', 'o5fpF4O15c', '2020-08-28', '7', 'sr4eUbLKWq', 'Kato@parturient.com', 736, 'B'),
(427, 'Upton', 'jSBJ4KfxCl', '2020-08-25', '10', 'ppSqXVI6cM', 'Rachel@Maecenas.com', 609, 'A'),
(428, 'Jonah', 'zpzbwhMaGT', '2020-08-25', '3', 'OqJ0Fzu6Dd', 'Yael@magna.com', 856, 'A'),
(429, 'Zoe', 'tw0GsMGtGY', '2020-08-23', '6', 'AyzJXpmXTU', 'Cameron@egestas.net', 918, 'A'),
(430, 'Dante', 'bkAAErDEc ', '2020-08-26', '5', 'nY7ZyoZTtG', 'Herrod@facilisi.net', 850, 'A'),
(431, 'Caesar', 'uaXeDBY8ny', '2020-08-26', '0', 'd1aL2MqZWc', 'Eaton@In.us', 955, 'B'),
(432, 'Kiona', '4wQddFyTXq', '2020-08-27', '2', 'GQnzCqhneA', 'Vincent@Cum.org', 182, 'A'),
(433, 'Abra', 'ugtS9xb4nl', '2020-08-24', '3', 'bDCBt2y3f8', 'Ulysses@Class.us', 525, 'B'),
(434, 'Reuben', 'mXRXKA0IFe', '2020-08-27', '10', 'xDvff963JE', 'Jakeem@Donec.edu', 869, 'A'),
(435, 'Cassady', 'j45XSHRvAc', '2020-08-25', '5', 'EB87gphZLY', 'Yoshio@purus.net', 123, 'B'),
(436, 'Nasim', 'PxmVbtqoo3', '2020-08-23', '0', 'RmCPBAvNoZ', 'Brynn@lorem.edu', 691, 'B'),
(437, 'Lev', 'z8N dmWTGl', '2020-08-27', '3', 'FQImUgvWVY', 'Andrew@dictum.gov', 127, 'A'),
(438, 'Giselle', 'laPrE5A8d3', '2020-08-26', '6', '6fcRD8uNPV', 'Barry@cursus.us', 418, 'A'),
(439, 'Valentine', 'Z1AhWN4zhs', '2020-08-24', '2', 'jsp06E1gkN', 'Clare@velit.net', 672, 'A'),
(440, 'Amelia', 'af2sZIzRvo', '2020-08-24', '3', 'KwV5fqloqt', 'Quintessa@commodo.com', 218, 'A'),
(441, 'Basil', '9QjsjHf3XW', '2020-08-26', '1', 'uJYyF00tkW', 'Minerva@adipiscing.us', 127, 'B'),
(442, 'Ali', 'bn8UXpVyuC', '2020-08-22', '0', 'C9mA68aDB4', 'Charles@ut.org', 865, 'B'),
(443, 'Alea', 'upxUzVc8Gh', '2020-08-25', '7', '2jccSUgQtI', 'Allen@leo.gov', 100, 'B'),
(444, 'Chloe', 'dyQnJd jWC', '2020-08-24', '8', 'ARDvO9HPL8', 'Zelenia@leo.us', 62, 'B'),
(445, 'Erica', 'dXzkAR8cTN', '2020-08-27', '5', 'tNgOEW2PBe', 'Maile@Curabitur.com', 586, 'A'),
(446, 'Shaeleigh', 'GtMPxSKXKp', '2020-08-24', '4', 'GlXEfsb1mV', 'Whoopi@Praesent.net', 876, 'B'),
(447, 'Dieter', '6WvMAY8F9b', '2020-08-27', '10', '1eNROWFfc5', 'Reece@ornare.edu', 651, 'B'),
(448, 'Berk', 'rik e0A4iS', '2020-08-23', '0', 'LNEn2XrWye', 'Lynn@nulla.net', 925, 'B'),
(449, 'Iona', 'AVYXrL7piQ', '2020-08-24', '4', 'aLDE36dQuc', 'Amethyst@eros.edu', 757, 'B'),
(450, 'Mohammad', 'HcvQhonWIQ', '2020-08-27', '3', 'D6JeQn8w53', 'Harrison@id.org', 198, 'B'),
(451, 'Montana', 'HyyTLxKXbt', '2020-08-23', '2', 'YOTNGgFV6e', 'Hayfa@ullamcorper.com', 814, 'A'),
(452, 'Blake', 'y1U9CUBxkC', '2020-08-27', '1', 'VqWflStKR4', 'Amelia@risus.edu', 841, 'A'),
(453, 'Serena', 'wY9LMUVjgT', '2020-08-28', '0', 'peWj6T8QrI', 'Alec@fringilla.edu', 723, 'A'),
(454, 'Trevor', 'AR CRMtD6g', '2020-08-23', '7', 'ZH2QFXueVM', 'Beverly@blandit.edu', 340, 'A'),
(455, 'Henry', 'UXF4En9qIY', '2020-08-28', '0', 'Nd9qxFjlfy', 'Xanthus@consequat.us', 174, 'A'),
(456, 'Kasimir', 'm2M3eAloJ7', '2020-08-27', '7', 'uo8AWl8xJj', 'Libby@natoque.us', 281, 'A'),
(457, 'Florence', 'TUHG5sOlZE', '2020-08-27', '6', 'e4cxM9P44w', 'Cade@Class.com', 817, 'A'),
(458, 'Kirestin', 'iXPNmYvhtW', '2020-08-24', '10', 'yUS84g4ixo', 'Otto@varius.gov', 573, 'A'),
(459, 'Stacey', 'OfgfhMwViK', '2020-08-24', '8', 'bqgCgmkMGg', 'Tanisha@natoque.edu', 853, 'B'),
(460, 'Ruth', 'QTW avqHGl', '2020-08-23', '8', 'jeXNZJPeTv', 'Lana@eu.org', 789, 'B'),
(461, 'Joan', 'ikdumOVU32', '2020-08-27', '6', 'RjZKW2KuAh', 'Aiko@dis.gov', 373, 'A'),
(462, 'Xaviera', 'sWBTpbrJrR', '2020-08-23', '4', 'HHwIPkZLcm', 'Daniel@ligula.net', 556, 'B'),
(463, 'Glenna', 'ghTRdk6mLu', '2020-08-22', '0', 'oe2bpe7t3a', 'Uta@eleifend.us', 658, 'B'),
(464, 'Carly', 'dXENrxMcMI', '2020-08-28', '10', 'o5MwG4WAa5', 'Riley@mattis.org', 881, 'A'),
(465, 'Hoyt', 'Lo0qh9YUsd', '2020-08-28', '0', 'dQfEFiHWzk', 'Brady@Vestibulum.edu', 911, 'A'),
(466, 'Mallory', 'gwvmpVryDm', '2020-08-24', '5', 'if9vJnXQDp', 'Troy@ullamcorper.net', 263, 'B'),
(467, 'Daniel', 'uPZZRSJCJF', '2020-08-25', '3', '35sJrbV01l', 'Mason@hymenaeos.com', 173, 'B'),
(468, 'Malik', 'fH0YSviuba', '2020-08-26', '6', 'b2iD4W4MxB', 'Idola@mus.us', 746, 'A'),
(469, 'Byron', '3SpjKpSoQy', '2020-08-27', '4', '1z6yFybbEH', 'Ivan@mus.us', 485, 'A'),
(470, 'Gage', 'F0F3LLkVlb', '2020-08-27', '1', 'ZtZiP5V53K', 'Harriet@sed.edu', 143, 'B'),
(471, 'Barclay', 'E88CanFQRc', '2020-08-27', '5', 'fyD8y24KX8', 'Rana@nisi.gov', 893, 'A'),
(472, 'Olga', 'nE5uvBzm0h', '2020-08-23', '5', 'Zsk07folwj', 'Kameko@eleifend.org', 261, 'B'),
(473, 'Kyra', 'cGGkODWRXQ', '2020-08-26', '9', 'vsgalSO7e3', 'Aladdin@vel.net', 670, 'A'),
(474, 'Latifah', 'W19dAD3 O4', '2020-08-26', '8', 'lH7XOjc4jz', 'Keegan@In.us', 648, 'B'),
(475, 'Emerald', '3PuupnUJNs', '2020-08-28', '9', 'K83rDdfJpA', 'Kitra@elit.gov', 97, 'A'),
(476, 'Rinah', 'F3QdejyRH4', '2020-08-22', '6', 't16WRAHjs1', 'Adria@nec.gov', 985, 'B'),
(477, 'Ray', 'tg47jhurNe', '2020-08-25', '10', 'LopVQXu0sJ', 'Abbot@Donec.gov', 988, 'B'),
(478, 'Avram', 'I48k0V4gTi', '2020-08-27', '7', 'q64VpdM4u2', 'Illana@vulputate.com', 775, 'A'),
(479, 'Jin', 'nf5dD8qhTJ', '2020-08-24', '1', 'PSOuuzqweQ', 'Violet@porta.edu', 524, 'A'),
(480, 'Kylan', '6NxmUDDLsR', '2020-08-26', '5', 'PaHDgbvYQ7', 'Celeste@tellus.org', 443, 'B'),
(481, 'Lucas', 'PbAhJXAZTn', '2020-08-23', '9', 'zK0i5xSuyX', 'Quon@mattis.edu', 341, 'A'),
(482, 'Yoshio', 'tedDo4hAOv', '2020-08-28', '5', 'JdDzXC4uWo', 'Upton@vel.org', 302, 'A'),
(483, 'Sawyer', ' RwFGKCP81', '2020-08-28', '10', 'oRvoybq5j1', 'Victoria@nisl.us', 3, 'B'),
(484, 'Macy', '0mGuX4t0Zn', '2020-08-27', '6', 'c3RjgjqoKh', 'Lysandra@Curabitur.gov', 266, 'A'),
(485, 'Nigel', 'C0xdhOniY2', '2020-08-25', '1', 'csuo4a82vd', 'Aiko@ipsum.edu', 107, 'B'),
(486, 'Sage', 'mQhscpkrP ', '2020-08-28', '2', 'cNEfOEjZIZ', 'Hedwig@sapien.org', 163, 'B'),
(487, 'Cally', '3u2gwDrByk', '2020-08-22', '10', 'ptY6ynxODH', 'Cole@nonummy.net', 796, 'B'),
(488, 'Isaiah', 'RcCRLsTk8Y', '2020-08-28', '10', 'KXmP7PayGq', 'Irene@scelerisque.gov', 743, 'B'),
(489, 'Tanek', 'gHuhF6JJdD', '2020-08-24', '2', 'Xwv8YHIZm8', 'Nissim@ac.us', 959, 'A'),
(490, 'Shannon', 'rk9zObR2iv', '2020-08-23', '7', 'yPVM8Snuv8', 'Cleo@sit.org', 314, 'A'),
(491, 'Jamalia', 'UTpuum8ZaO', '2020-08-25', '10', 'M74HMVWI3m', 'Abra@feugiat.net', 843, 'A'),
(492, 'Ivana', 'm4b4yGClLP', '2020-08-23', '3', 'xyJwivCXIB', 'MacKenzie@magna.edu', 80, 'A'),
(493, 'Carl', 'Dr1MnvMoWD', '2020-08-28', '6', 'hxmE9uZS6t', 'Lionel@natoque.us', 680, 'B'),
(494, 'Halee', '0LzlOF6uaY', '2020-08-25', '2', 'QShObpJ4xb', 'Kasimir@Nunc.org', 41, 'A'),
(495, 'Ryder', 'a1E56vtoSb', '2020-08-27', '10', 'iQz0NLyWAm', 'Kalia@eros.us', 331, 'A'),
(496, 'Sybill', 'mmQZKg06nh', '2020-08-26', '2', 'HQMAEDzM8K', 'Walker@pellentesque.gov', 680, 'A'),
(497, 'Colin', 'pkpPovIEZ6', '2020-08-27', '5', 'awpuqhbKD7', 'Zachary@risus.gov', 534, 'B'),
(498, 'Theodore', 'LpILXZop2y', '2020-08-22', '6', 'Ei3Xf9c7zu', 'Quyn@quam.org', 937, 'B'),
(499, 'Melvin', '9TG7iGWhTD', '2020-08-22', '5', '0tjzc6dnec', 'Robert@eros.com', 484, 'A'),
(500, 'Vladimir', 'sAWk3jzRvR', '2020-08-22', '2', 'WhoaywyuK0', 'Simon@Ut.us', 259, 'B');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `usuario`
--
  ALTER TABLE `usuario`
    ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo del usuario', AUTO_INCREMENT=1001;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

INSERT INTO `identificacion` (`id_identificacion`, `nombre_identificacion`, `estado`) VALUES
(1, 'DPI', 'A'),
(2, 'Cadula', 'A'),
(3, 'Licencia', 'A'),
(4, 'CarnetUniversitario', 'A'),
(5, 'CarnetTrabajo', 'A'),
(6, 'DPI', 'B'),
(7, 'Cadula', 'B'),
(8, 'Licencia', 'B'),
(9, 'CarnetUniversitario', 'B'),
(10, 'CarnetTrabajo', 'B');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `identificacion`
--
ALTER TABLE `identificacion`
  ADD PRIMARY KEY (`id_identificacion`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `identificacion`
--
ALTER TABLE `identificacion`
  MODIFY `id_identificacion` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de identificacion ', AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
