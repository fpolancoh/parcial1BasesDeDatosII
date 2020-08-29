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

INSERT INTO `curso` (`id_curso`, `nombre_curso`, `observacion`, `estado`, `fecha_creacion`) VALUES
(1, 'Hogar', 'Muy dificil', 'B', '2020-08-29 02:18:35'),
(2, 'Mate', 'Es muy dificil', 'A', '2020-08-29 01:15:40'),
(3, 'Idioma', 'Es muy dificil', 'B', '2020-08-29 01:17:37'),
(4, 'Deporte', 'Es muy facil', 'A', '2020-08-29 01:17:37'),
(5, 'Sociales', 'Medio Medio', 'B', '2020-08-29 01:17:37'),
(6, 'Ciencias', 'Muy dificil', 'A', '2020-08-29 01:17:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id_curso`);
  
  
INSERT INTO `grado` (`id_grado`, `nombre_grado`, `estado`) VALUES
(1, 'Prekinder1', 'A'),
(2, 'Prekinder2', 'A'),
(3, 'Kinder', 'A'),
(4, 'Preparatoria', 'A');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `grado`
--
ALTER TABLE `grado`
  ADD PRIMARY KEY (`id_grado`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `grado`
--
ALTER TABLE `grado`
  MODIFY `id_grado` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo que identifica al grado', AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `curso`
--
ALTER TABLE `curso`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de curso', AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;




-- Dumping data for table `maestro`
--

INSERT INTO `maestro` (`id_maestro`, `id_identificacion`, `codigo_identificacion`, `direccion`, `correo`, `celular`, `estado`) VALUES
(1, 7, 'DC407888-B044-465A-97EB-59B4A4CC4F4C', '4293 North Bay City Ln.', 'Dolan@aliquet.edu', 756, 'A'),
(2, 6, '8B2ED107-B05C-4BB9-A7A7-53CAD3E08D02', '71155 West Malawi Way', 'Alexa@molestie.us', 754, 'A'),
(3, 4, '1C256326-F87B-4450-A037-4752F670DB5E', '80817  Argentina Ln.', 'Jonah@justo.us', 441, 'B'),
(4, 10, '137020AD-DAB1-4CAF-B355-CD94A4136A14', '97002 East Mount Vernon Way', 'Angela@ante.edu', 187, 'A'),
(5, 9, '59BBFF18-A0FF-4E72-953D-4CE438D71AA4', '58468 West Czech Republic Ct.', 'Macon@et.com', 361, 'A'),
(6, 4, 'C834856C-F413-4EF8-B000-43C584344245', '46249 South Cook Islands St.', 'Derek@Praesent.org', 194, 'B'),
(7, 9, 'D62173A4-854B-4274-80A5-BAE3D02D96D4', '47107 North Taiwan, Province of China Blvd.', 'Odessa@Fusce.com', 513, 'A'),
(8, 6, '0ED26EA3-AFF9-47D2-A4C3-61AE7433FFA9', '4005 North Albania Ave.', 'Alden@Proin.us', 911, 'A'),
(9, 9, '542B335B-4578-4BD9-B433-3FEB025211FC', '70972 West Canada St.', 'Amos@hymenaeos.edu', 211, 'A'),
(10, 3, 'FD333B08-FC14-4E6D-9627-9454E384BF24', '9223 South Virgin Islands, U.S. Ln.', 'Dolan@fringilla.edu', 570, 'B'),
(11, 1, '12896CA1-853B-4CAC-AC5E-6B9E148030D7', '25188 East Estonia St.', 'Bo@Suspendisse.gov', 165, 'B'),
(12, 9, '6844BA91-987D-4127-B8B9-9328C07B1C97', '71997 North Cayman Islands Blvd.', 'Derek@Suspendisse.net', 250, 'A'),
(13, 7, '706CD0FE-E47B-4A7E-899C-E08470C41311', '75197 West Bosnia and Herzegovina Ave.', 'Alvin@nec.org', 588, 'B'),
(14, 3, 'DEFF3DF5-2DEB-47BF-B213-21DB491E6AB9', '17513  Solomon Islands Way', 'Clinton@at.gov', 67, 'A'),
(15, 6, 'FC3DC785-D0F2-4609-AAE2-591DC7965CF3', '72199 South Grand Forks St.', 'Lynn@molestie.us', 341, 'B'),
(16, 4, '7F871B59-24BE-4423-9DAE-FCA40597D969', '97694 South Nigeria Ct.', 'Colt@blandit.net', 990, 'B'),
(17, 6, '7685003E-0DCF-4A61-A1C7-5B7FBF048A3E', '55565 South French Guiana Ave.', 'Justin@nulla.edu', 547, 'A'),
(18, 3, '756A49F6-2457-443A-91C9-3C25ACBF4775', '7749 East Somalia Ln.', 'Deirdre@eget.com', 809, 'A'),
(19, 2, 'EDA39260-9FC2-4046-A0F2-E60544BC99D9', '44198 North Central African Republic St.', 'Ulric@id.us', 407, 'B'),
(20, 5, 'B41F91AC-6B07-4669-8935-C9526FDFD0D6', '63992 North Puerto Rico Ave.', 'Alisa@pretium.gov', 341, 'A'),
(21, 9, 'B31E1FBA-74A7-458D-9ACD-3946E2243CD2', '67176 North Argentina Ln.', 'Delilah@mauris.net', 648, 'B'),
(22, 5, '7DE4D903-24E9-432A-9673-D073737543A5', '75572  Nepal Way', 'Tad@viverra.us', 423, 'A'),
(23, 1, '31876E1A-382F-4353-8A9E-691609E26ED7', '13987 South Argentina Ct.', 'Yuli@luctus.edu', 255, 'A'),
(24, 9, '19F1A6BD-47FF-4BDB-97C1-2A62A9C73BF3', '25946 North Luxembourg Ct.', 'Ivory@Integer.edu', 93, 'A'),
(25, 7, '13E9F160-C9D9-451D-BE79-BF54DD085480', '16880 West Guam St.', 'Richard@non.com', 842, 'A'),
(26, 9, 'CD442C37-FD92-42F2-B536-9366AD30CC34', '71294 South Delta Junction Ct.', 'Autumn@pulvinar.edu', 834, 'B'),
(27, 2, '205A5B36-BB5B-4C71-8FC1-F3B5FD8C2802', '12680 North Burundi Ave.', 'Lane@Phasellus.net', 370, 'A'),
(28, 4, '735C8E12-247D-4E16-89B2-1FDCA39DB862', '45488 North Reunion St.', 'Serina@scelerisque.org', 884, 'B'),
(29, 8, '10938606-2265-4CE0-86E6-CF489B9251C8', '16580 South Costa Rica Ct.', 'Lynn@molestie.com', 671, 'A'),
(30, 10, 'DCB2A8E0-10A2-4567-A464-C79254D4351B', '30133 East Laughlin Ave.', 'Fulton@semper.edu', 685, 'B'),
(31, 2, '60BA4799-FCBD-44E8-84F2-5BAB6AE27698', '47938 South India Ln.', 'Jerry@tristique.net', 572, 'B'),
(32, 3, '9E9E289F-68EF-4D30-AAC6-FF561FFCDD48', '74196  Japan Blvd.', 'Lawrence@faucibus.org', 342, 'A'),
(33, 3, '9102E4DA-0E13-4674-8DFE-FD6F76EC636D', '66929 North Bahrain Way', 'Aileen@ut.us', 405, 'A'),
(34, 2, '938B5F6A-1891-4595-A02B-7E46D55483C6', '53243 North Sweden Ave.', 'Orlando@sed.us', 980, 'A'),
(35, 10, '89CAE30D-C84F-457A-B069-AD31015B1E29', '77031  DuBois Way', 'Steven@feugiat.net', 995, 'B'),
(36, 6, '6B17872B-2AF9-4900-89DE-DD2B9FC1D348', '46580 East Bolivia Way', 'Piper@Donec.net', 846, 'B'),
(37, 5, '3298AE62-002E-4E8A-A119-98DA91B2064E', '40065 South Cayman Islands Ct.', 'Yoshi@sed.org', 119, 'A'),
(38, 3, '010A1FE0-0EE2-42EC-A113-A592AB2FBE32', '3732 East Marshall Ave.', 'Stuart@luctus.us', 679, 'A'),
(39, 5, 'D1F5DC6C-CFCE-4F68-8AC6-BEB6609D9AED', '80277 South Del Rio Ave.', 'Justine@metus.org', 188, 'A'),
(40, 8, 'BAFB3604-1FF8-474A-9513-6F75A341BC62', '5583 East Virgin Islands, British Blvd.', 'Moses@Duis.edu', 992, 'B'),
(41, 9, 'CCB31532-BB8F-4D09-A56B-6780C7BC484C', '8411 South Bowie Way', 'Branden@rutrum.net', 66, 'A'),
(42, 9, 'CF0E8D64-E5E1-4E47-9FA2-D1300F19BE29', '43424 West Botswana Ct.', 'Tanner@conubia.net', 998, 'A'),
(43, 7, 'A7A9E42F-9F44-4957-A612-AF4C7917D7DD', '83908 South Egg Harbor Ct.', 'Veda@mollis.com', 285, 'A'),
(44, 9, 'B2A1F36D-8143-4E4C-B214-EB14C07FBD7A', '13840 South Hong Kong Blvd.', 'Cedric@lectus.gov', 437, 'A'),
(45, 7, '8BA4CCD6-BE73-443D-A34F-5C6AC9B11605', '39178 South Fajardo Ct.', 'Elaine@ultrices.gov', 585, 'B'),
(46, 6, '04391B19-6048-4367-9B03-949862B9E728', '77395 South Barbados Blvd.', 'Camden@vitae.net', 918, 'B'),
(47, 4, 'F0B6DC80-5ACC-45EC-AF80-4ECD6417FB88', '22807 East Cyprus Blvd.', 'Thomas@Vestibulum.edu', 612, 'A'),
(48, 10, 'A0E084E7-A012-4A76-B694-C3FB8266018A', '89739 South Compton Ln.', 'Alexandra@dignissim.us', 118, 'B'),
(49, 10, 'C7EFEEA2-6276-4FE8-8132-582713210CEC', '38124  Slovenia Ct.', 'Felicia@dignissim.org', 177, 'A'),
(50, 2, 'DDD683E1-F7B4-477D-AE90-78634B7F15AA', '4715 South Independence Blvd.', 'Madeline@bibendum.us', 447, 'B'),
(51, 1, 'A57FB824-9E49-47F0-9F35-0B3A45B7F1A8', '60684 North Anchorage Ln.', 'Leila@netus.net', 621, 'B'),
(52, 4, '194A430F-5D56-4C4F-8A31-B653F20905EC', '91060 North South Africa Ct.', 'Amy@est.org', 896, 'B'),
(53, 5, 'DEFEB279-DB0A-4226-8BB1-C7C55059A6F2', '99945 North Norway Ln.', 'Yoshio@cubilia.com', 238, 'B'),
(54, 9, '6230873A-CF3A-49AB-9325-BA59F108840E', '96137 West Holy See (Vatican City State) Ln.', 'Joseph@nonummy.gov', 449, 'A'),
(55, 1, 'F7AD0D06-0A92-45E3-A023-10416155147F', '87569 West Botswana Blvd.', 'Nerea@tempus.gov', 2, 'A'),
(56, 9, '28240692-2C4E-46FF-9EB6-D76F3E977CEA', '54162 South Austin Blvd.', 'Josephine@velit.com', 792, 'A'),
(57, 7, '93658F8B-E6B0-4645-9B02-CD27FD78AC12', '42532  Ghana St.', 'Thane@justo.us', 522, 'A'),
(58, 5, '17EE9760-4F99-458F-A917-F176F5948D01', '23114 South Saint Vincent and The Grenadines Ln.', 'Boris@nibh.us', 599, 'B'),
(59, 6, '01627EE2-2BB8-4579-B562-42864FCC049E', '19368 North Boston Ave.', 'Rajah@Curae.org', 516, 'A'),
(60, 5, '0506E9AD-4626-49F6-B38F-A9EEE048C58C', '18384  Hartland St.', 'Marah@tempus.com', 589, 'B'),
(61, 1, 'D0D10393-0D60-4FC1-9F5C-5A81FF686C3F', '26692 East Brooklyn Park St.', 'Jayme@dictum.com', 653, 'A'),
(62, 8, 'B72B52F8-2CD0-4F4B-B541-1BE215D92C1A', '1233  Hong Kong Ln.', 'Wendy@dis.gov', 491, 'A'),
(63, 4, '4F8F3536-28C0-44A9-BB41-44DEA61A9F0F', '47386 South Samoa Way', 'Hedda@luctus.edu', 292, 'B'),
(64, 9, 'C52649F9-59B6-49BF-957D-B7B81DCE4B61', '25896 West Kingston Ave.', 'Zephania@imperdiet.gov', 455, 'A'),
(65, 6, '9FD8D4D9-28AA-468A-ABD7-065DACD467C2', '41167  Bosnia and Herzegovina Ct.', 'Glenna@neque.net', 355, 'B'),
(66, 6, 'C6A3281D-5979-4931-9D4C-7E9024F10274', '80100 West Barbados St.', 'Garth@arcu.edu', 906, 'B'),
(67, 3, '17A674D5-FE57-4CFE-86F9-8412E3D5670B', '3734 North Malaysia Way', 'Mercedes@adipiscing.us', 560, 'A'),
(68, 10, '2B0B38EC-7D7B-4B4E-A966-50B3B79D0066', '97810 East Cape Verde Ln.', 'Chadwick@leo.com', 66, 'B'),
(69, 4, '582F3EA2-EE22-47D4-857E-AB4B8701B583', '77049 North Afghanistan Ave.', 'Cade@per.org', 341, 'A'),
(70, 2, 'C078BC0F-D7E1-41BF-A05B-7FFC4ECBB3D0', '41206 East British Indian Ocean Territory Blvd.', 'Hilel@nulla.edu', 886, 'B'),
(71, 4, 'AF4B9987-E757-4A5B-BF77-615AE186477C', '8776 North Azusa Way', 'Ayanna@auctor.org', 613, 'B'),
(72, 9, '1596B388-568C-48C5-A038-3487AC7529EF', '96119 South Cook Islands St.', 'Noah@commodo.edu', 616, 'A'),
(73, 4, '5D4F00C9-4A95-4AFE-A1D1-B219ABCC3781', '89344 East Dubuque Blvd.', 'Garth@metus.com', 925, 'A'),
(74, 2, '501C59D1-76F7-4CA8-B2E6-06CA173FDC6A', '54472 North Cayman Islands Ln.', 'Kasper@vestibulum.gov', 494, 'B'),
(75, 7, '2B12AB2C-948D-417F-92E9-91AA0287411C', '8443 South Bahrain Ln.', 'Brielle@ridiculus.edu', 136, 'A'),
(76, 10, 'D10E90CE-4F7F-4218-B381-79EFB0F39E7F', '97971 North Andorra St.', 'Alec@lorem.edu', 416, 'B'),
(77, 6, 'F3286D73-FBAC-450B-8B7B-4963B49731BF', '18469 North Bouvet Island Ln.', 'Aimee@arcu.gov', 581, 'B'),
(78, 8, '29168C82-72C5-4D13-8ABB-B6F45FEEED62', '69536 West Fremont Ct.', 'Amanda@quam.gov', 731, 'B'),
(79, 10, '03CF29EF-F57A-4E3B-85B1-1BBB62778905', '47230 West Chino Ln.', 'Simon@vulputate.edu', 718, 'B'),
(80, 2, '340E09A5-C7E2-405C-AFAC-B16BDE00AB94', '96967  Macedonia Ln.', 'Cameron@sed.gov', 985, 'B'),
(81, 4, '88EA2FB8-C6A1-45C6-B684-E64625358FCE', '61173 South Bulgaria Blvd.', 'Kermit@gravida.com', 345, 'A'),
(82, 6, 'F1B99CEB-8B1D-44FC-85B0-4CF906A0A79B', '55223 East Bolivia Ln.', 'Hector@pede.net', 57, 'B'),
(83, 8, 'E9ADD849-FB71-4B51-8E69-AFF85B140C64', '94169 West Costa Rica Ln.', 'Nita@Morbi.us', 807, 'B'),
(84, 9, 'DCBF09D6-F355-418A-A8B6-059E62C0D0DE', '95949 East Forrest City Ln.', 'Claudia@Morbi.net', 5, 'A'),
(85, 4, 'C72009DA-0817-48F1-BBBD-D566A2EAD6C2', '94757 South Albania Way', 'Germaine@in.edu', 735, 'B'),
(86, 3, 'BCEF639F-3198-4F48-8A49-4ADBA18F0F9C', '80528 West Moldova Ln.', 'MacKensie@adipiscing.net', 374, 'A'),
(87, 10, '25A07B74-0104-423E-BAD1-310A97950D60', '31773 South Oman Ave.', 'Nigel@tincidunt.edu', 660, 'B'),
(88, 4, '62B25FFA-C1E3-49B9-B341-7DB635D48D12', '75735 North Guinea Ln.', 'Kasper@dis.org', 866, 'B'),
(89, 2, '69747967-CA3B-4DF4-B0E3-555D272A5AD1', '45214  Eritrea Way', 'Freya@natoque.com', 447, 'A'),
(90, 6, 'C4071D3B-7E64-42D2-8741-0DA92AA22736', '80482  Derby Way', 'Hyatt@vel.us', 775, 'B'),
(91, 2, 'BADA77B4-8087-4A29-BE83-95E3BA12294D', '88190 North Dothan Ln.', 'Felicia@fermentum.us', 903, 'A'),
(92, 5, '829D8652-843C-4FFC-9D1F-37CB4C8698A4', '21159 South Belarus Ave.', 'Chandler@at.gov', 49, 'B'),
(93, 10, 'E9E72C7B-5FF7-41C8-BD29-535381FBB48F', '81315 South Eugene Way', 'Dexter@hendrerit.com', 674, 'B'),
(94, 3, '7F641FD7-AEA1-41D3-B531-014FF48CB15A', '19396 East Hilo Blvd.', 'Yvonne@ridiculus.gov', 970, 'B'),
(95, 8, 'FEA57016-E937-4841-B608-9C944773002A', '15000  Czech Republic Ct.', 'Alden@Vestibulum.gov', 621, 'B'),
(96, 4, '357BEDBB-A7A1-474C-B10D-69CEECFB894D', '46690 North Areceibo Ln.', 'Burton@porttitor.com', 58, 'A'),
(97, 2, 'F434583D-C389-4D4B-8030-4AD0B38F0FE2', '70944  Norfolk Island Blvd.', 'TaShya@natoque.com', 29, 'A'),
(98, 9, '30010FE1-5A69-4A0B-A036-5019F89FA8C4', '84018 West Newark Blvd.', 'Alden@scelerisque.edu', 141, 'A'),
(99, 2, '9C71AC8F-D95E-43EA-B8E3-132252B48AF2', '34873 East Costa Rica Way', 'Rudyard@iaculis.gov', 319, 'A'),
(100, 8, '35F951ED-C8EC-4FF1-B5B0-25B10EF484A8', '23562 South Norway Ave.', 'Honorato@Etiam.com', 791, 'B'),
(101, 4, '59B0CB89-BEE3-4368-A1A4-99020B9C7B1F', '90868 North Afghanistan Ln.', 'Jena@habitant.gov', 620, 'B'),
(102, 9, 'F9F1C3FE-7452-4834-9540-38A76B5418FE', '34980 South Mayotte Way', 'Amy@netus.gov', 505, 'B'),
(103, 7, 'A8F403E4-32A4-4D86-AE02-06844871DB40', '27999  Comoros Ln.', 'Mohammad@vestibulum.com', 723, 'B'),
(104, 5, 'C870B19C-FF10-4308-A8E1-0FC608936D82', '64831  Afghanistan St.', 'Signe@nascetur.gov', 100, 'B'),
(105, 10, '9EDBD170-A28F-415D-B2D2-D3B384714BC2', '95586  Columbus Way', 'Ingrid@hymenaeos.net', 662, 'B'),
(106, 9, '1DC6BD39-B67E-426E-AC18-4417EEC3CA14', '65982 East Austria Ln.', 'Graham@fermentum.us', 592, 'A'),
(107, 8, '7CD113F1-FB4A-4383-B507-B2E51FDC598E', '31150  Viet Nam St.', 'Kuame@primis.us', 117, 'A'),
(108, 8, '82A8629D-0959-4A6B-8092-07494C0DE487', '92877 West Huntsville Blvd.', 'Hayley@volutpat.edu', 256, 'B'),
(109, 3, 'F54AD7E3-1CCF-41EB-A4BF-06386296EE17', '9152 South Bhutan Ct.', 'Velma@vestibulum.gov', 864, 'A'),
(110, 1, 'EFE5DF0A-6B3C-411B-8579-275D12802D2E', '42711  Cape Girardeau Ct.', 'Hyatt@posuere.net', 657, 'B'),
(111, 10, 'F392B72C-6098-482E-86B8-3AEBA7B04205', '87798 North Czech Republic Blvd.', 'Zelenia@scelerisque.gov', 252, 'A'),
(112, 6, 'DCFB532B-C22E-436E-8B70-0933E00671F8', '16514 West Mozambique Ave.', 'Hayes@magna.org', 521, 'A'),
(113, 9, 'ADC3C30A-ADAF-41FC-9039-EE807598B6D9', '25708  Uzbekistan Ct.', 'Raymond@ullamcorper.org', 395, 'B'),
(114, 6, '6CA66C57-6D84-407B-9816-7544ADF39864', '13341 West Gambia Ct.', 'Julie@dolor.us', 347, 'A'),
(115, 3, 'EA2B8A32-670B-46BD-BCF2-093453432A16', '81863 South Brazil Ave.', 'Peter@mattis.com', 22, 'B'),
(116, 10, '23676E5A-8A01-4D68-89E5-79C733E8903E', '14724 West Armenia Ln.', 'Kylie@nisl.org', 939, 'B'),
(117, 9, '3227CC1C-DD67-40B3-82CC-8FE315C7211D', '91095  British Indian Ocean Territory St.', 'Yasir@eleifend.gov', 500, 'B'),
(118, 3, 'A3A3A13E-7BF5-4234-B153-2314EBF72F22', '51022 South Casper St.', 'Nicole@fermentum.net', 958, 'B'),
(119, 5, 'AB520AEC-4F94-4B84-AB71-C25D9AA584A2', '93098 South Macao St.', 'Lionel@Class.com', 153, 'A'),
(120, 7, '02B0641A-9AD2-4A2A-9E48-1CD41408D4B0', '6724 West Antarctica Way', 'Ignacia@montes.com', 247, 'B'),
(121, 4, 'B369BE18-756A-4D77-9D18-9115B2088293', '31367 East Armenia Way', 'Stuart@commodo.com', 876, 'B'),
(122, 6, '6FFCC8B8-B4B7-4AB7-AEB9-DBD59DC01F60', '72450  Cayman Islands Ave.', 'Olivia@porttitor.org', 442, 'A'),
(123, 9, 'EFA20204-F989-4AA2-92B0-AC9B5980606D', '83777  Bulgaria St.', 'Gay@cursus.gov', 237, 'A'),
(124, 5, 'ABFAEB00-1D5D-486A-97B6-045AFA795796', '80657 East Angola Ct.', 'Venus@Quisque.us', 402, 'A'),
(125, 4, 'CEB51679-75D0-472E-9944-8F4102808CE5', '56149 North Allentown Ln.', 'Ramona@et.com', 902, 'B'),
(126, 8, 'F70EBAA2-13ED-456C-9185-1C7F565F3043', '52897 East Bulgaria Ave.', 'Carissa@vulputate.us', 189, 'A'),
(127, 4, 'BF5C3C43-BE4A-4F9B-8AF4-5D9B6D3832DD', '69635 North New York Blvd.', 'Callum@varius.net', 139, 'B'),
(128, 4, '4C0BC4E9-A2C1-4A4F-B6E5-1D52E9A0C2AE', '62239 East Cameroon St.', 'Thane@aliquam.us', 666, 'A'),
(129, 9, 'EE6CC894-2127-4AE1-9875-DF0DDEF41333', '35606 East Evansville St.', 'Deacon@sociosqu.org', 922, 'A'),
(130, 2, '67FFD3CE-1E8B-41EF-A9EF-DA80C17C1D19', '87795 North Bhutan Blvd.', 'Indira@aliquet.edu', 339, 'B'),
(131, 4, 'FA30EC7A-5485-47C6-8901-D7CF7188E578', '72285 East Maldives Ct.', 'MacKenzie@Cum.edu', 110, 'B'),
(132, 3, '56912AE8-9E9E-4992-AA47-76C3B8CE9E12', '66836 South Belgium Blvd.', 'Baker@litora.com', 577, 'A'),
(133, 4, '3CE493BC-7CE7-4C47-A60C-FFE74E467194', '48335  Madagascar Way', 'Evan@sit.us', 846, 'A'),
(134, 5, '728851E8-479D-40DF-AA29-8C851B7B4E92', '38106 West Singapore Ln.', 'Dorian@primis.com', 730, 'A'),
(135, 10, '94902C57-2C2C-447E-8E30-C79871D32874', '8425  Bahamas St.', 'Chaim@consequat.org', 926, 'A'),
(136, 10, '1D994EEE-61C7-4738-BBA0-42D202843A56', '54978 East Agat St.', 'Alice@consequat.edu', 466, 'A'),
(137, 8, 'BCBED705-2A66-4B5E-AD25-91D71FAAF26C', '98238 West France Way', 'Audra@Cras.com', 774, 'B'),
(138, 4, 'DF3C3151-C0FF-48FA-B502-8836A76EAC38', '46287  Cayman Islands Way', 'John@Nam.org', 581, 'B'),
(139, 8, '6C46BB63-6F47-4617-9637-215ACCF21484', '13095 West Germany Ln.', 'Brittany@Suspendisse.com', 291, 'B'),
(140, 5, '940C3468-608B-4567-A5E0-A3BA731D6EE4', '32486 South Senegal Ln.', 'Hannah@Fusce.us', 646, 'A'),
(141, 10, 'C6CCDEA7-7234-40EF-93AD-519559F225CE', '23115 South Hazleton Ave.', 'Jane@nostra.us', 745, 'A'),
(142, 7, 'F36E7A13-4C0B-46DE-B9C0-AF4D70D81169', '7828 North Namibia Ct.', 'Norman@massa.us', 355, 'B'),
(143, 10, '7D0B58C8-ACE2-4459-AD78-BF391F63C0D4', '31542 South Maldives Way', 'Yael@libero.gov', 445, 'B'),
(144, 1, '0FA0D548-B0A4-4CDA-A27A-1339092174B0', '28909  Cleveland Ln.', 'Ashely@fames.org', 405, 'A'),
(145, 2, '7876B938-9E0D-41FD-B358-6AD3726B8351', '67724 South Comoros Blvd.', 'Kane@hendrerit.com', 159, 'B'),
(146, 3, '8A7BC784-4B97-456B-A6EF-2264A78DDA64', '65190 East Florence Ln.', 'Dorothy@viverra.org', 102, 'B'),
(147, 10, 'B966AD4E-562D-4CD7-9191-8BACCB76A94A', '27146  Trinidad and Tobago Ave.', 'Burke@justo.edu', 287, 'A'),
(148, 5, '8E3F9548-82EB-4D38-A2FA-C3FCC8209B2E', '2837 East Anguilla Blvd.', 'Macon@Aliquam.us', 396, 'B'),
(149, 10, '8C934EE8-F6F8-4032-A27A-74493F58F396', '77854  Bhutan Ave.', 'Alice@consectetuer.gov', 150, 'A'),
(150, 2, '7586DD14-FEB1-447D-A74E-134BAC432175', '65500 North Comoros Ave.', 'Sybil@Nunc.net', 280, 'A'),
(151, 6, '622A27F3-2448-486F-A579-06E387D2D9DB', '88946 North Chickasha Ct.', 'Octavia@dis.org', 412, 'B'),
(152, 5, '565AD308-3E3E-4147-8658-B691269B4468', '99217 West Western Sahara Blvd.', 'Micah@urna.net', 759, 'B'),
(153, 8, '49A0DBDB-A920-4A9E-A664-1FC8B5754603', '165 South Sierra Leone Ln.', 'Joseph@orci.edu', 809, 'A'),
(154, 2, '8D0A2FA2-9B1A-481F-B656-400AB4837E92', '48590 South Bartlesville Ave.', 'Ronan@adipiscing.net', 989, 'A'),
(155, 5, '09DCE788-CC4F-4DC4-9675-2F6623CB0509', '15642 East Bermuda Way', 'Kirk@feugiat.edu', 68, 'B'),
(156, 6, '7A5709CF-D465-46C6-AC63-6B463E164C59', '49978  Chile St.', 'Hakeem@sem.gov', 12, 'A'),
(157, 6, 'D1D42A83-0FA9-4389-8ACE-099B7965EE89', '33849 West Uzbekistan St.', 'Sophia@interdum.org', 219, 'A'),
(158, 1, '8100B383-3523-4427-A8EF-D068DCEFDB35', '4709 South Antarctica Blvd.', 'Bradley@consequat.com', 974, 'A'),
(159, 1, '6FC1DAED-C4C5-4849-ABED-181A974FAD59', '24735 North Colombia Ln.', 'Rhiannon@Suspendisse.com', 393, 'B'),
(160, 3, 'B2049E61-C38F-48E8-8010-3019A89271A7', '55321 West Mankato Ln.', 'Mufutau@in.gov', 421, 'A'),
(161, 4, 'B09E52FE-7ADB-40E9-BF10-0A9B812D773B', '21091 East Viet Nam Blvd.', 'Odessa@dignissim.edu', 717, 'A'),
(162, 3, '49E11D5D-DD74-4E0B-9A21-FC048898D7D8', '15897 North Hastings Ln.', 'Alexa@commodo.com', 522, 'A'),
(163, 10, '4F263E3A-1FF9-4940-98B3-38B4E802721A', '40169 West Bahamas St.', 'Aristotle@Aliquam.net', 209, 'A'),
(164, 1, '53CF93E9-71B5-4D6C-8118-8AF62C686C06', '55934 South Greenland Ct.', 'Zena@rhoncus.net', 796, 'B'),
(165, 10, 'E855C8E1-BFBF-4332-9453-A5950D9C759E', '76860 West Cameroon Blvd.', 'Hoyt@Maecenas.org', 1, 'A'),
(166, 1, 'C63A2F82-43E9-4390-8649-4365EFC9F24E', '23840 South Moorhead Ct.', 'Perry@eleifend.edu', 804, 'B'),
(167, 8, '8E9ECBF2-9EC1-4EA5-AC83-9FD6D4B694E0', '43443  Agoura Hills Ln.', 'Allen@bibendum.gov', 476, 'A'),
(168, 1, '60DC94B9-FCAF-4A56-B2E7-9F24ED2573AF', '75351 East Covington Ave.', 'Merritt@Sed.us', 295, 'B'),
(169, 5, '53F84934-39A9-4250-A2AD-C16907BABC6F', '27261  Grass Valley St.', 'Matthew@purus.net', 660, 'B'),
(170, 5, 'E518D89B-9759-41E7-B1D1-D109E0D694A7', '22207 South Laughlin Ave.', 'Jana@quam.org', 16, 'A'),
(171, 6, 'DF8F1C8E-65C9-433E-8554-09B904802FCE', '95304 East Cyprus Ave.', 'Ethan@vulputate.us', 787, 'A'),
(172, 1, 'CEB5141E-D682-4310-AF5B-D63CD1C1EAC7', '63377 South Belarus Blvd.', 'Adara@ridiculus.org', 521, 'B'),
(173, 10, 'A386CDC9-73DA-4FFC-B146-3046DF502C64', '93549 South American Samoa Way', 'Wynter@lacinia.edu', 568, 'A'),
(174, 3, '373D0112-1217-47FD-9CB8-B2A7A0066396', '74003 South Guinea-bissau Ln.', 'Jordan@faucibus.gov', 358, 'A'),
(175, 3, 'B0DCD616-EE8D-47A4-88C5-D8A39B2016FC', '48515 South Brazil Blvd.', 'Hermione@primis.gov', 571, 'B'),
(176, 10, '32A26540-6F26-413E-A37D-E3FD54EB6753', '79397 East Afghanistan Ave.', 'Travis@malesuada.gov', 165, 'B'),
(177, 2, 'F02B0ADA-B9E8-4A0B-B367-578A5DA9259B', '30140  Garden Grove Ave.', 'Yvette@iaculis.us', 31, 'B'),
(178, 6, 'F457B686-5C62-404A-8E5D-22C8BC4B19AA', '82941 South Austria Ct.', 'Rae@quam.org', 180, 'A'),
(179, 6, '2D48B197-AE64-4ED5-897F-8D2D3B3D817D', '80560 North South Georgia and The South Sandwich Islands Way', 'William@Curabitur.org', 40, 'B'),
(180, 4, '41F0EF23-14D6-410A-8558-F315B2A508A7', '99039 North Fairfax Way', 'Ahmed@nibh.us', 613, 'A'),
(181, 1, '64E74AB4-0E38-405B-94A8-25F592E20D2A', '27757 East Maldives Blvd.', 'Jesse@nostra.com', 106, 'B'),
(182, 4, '44D90D22-F147-49DB-8AD5-55E1095AFD50', '34949 North France Ave.', 'Tamekah@et.org', 464, 'B'),
(183, 3, '790C65BA-7B04-4F49-87FA-274E4AD20A78', '35623 East Beacon Way', 'Destiny@velit.net', 658, 'A'),
(184, 5, '996E5CAE-D50A-4351-BECF-D4174AFC1094', '59442 West Marshall Islands Ln.', 'Ginger@Nulla.net', 254, 'A'),
(185, 9, '4A14BC8C-90DA-48B5-B715-CCB9B3A7D257', '91722 South Biddeford Ct.', 'Alvin@nunc.org', 868, 'B'),
(186, 2, '33A719EF-9ABF-4B62-8606-C54A8F44FA72', '77490 North Barrow Ave.', 'Drake@dolor.gov', 382, 'A'),
(187, 4, 'AEB9624D-DA7A-445D-9535-958C8B05AEEE', '16010 South Austria Way', 'Kylee@elit.us', 292, 'A'),
(188, 10, 'FB2388CD-FCA1-4A15-8CEF-06FA08BA21ED', '59686 South Guánica Ave.', 'Matthew@posuere.us', 803, 'B'),
(189, 10, 'EB2D4436-5150-4D6B-A703-D6201C359939', '36777 West Poland St.', 'Bevis@aliquet.com', 246, 'A'),
(190, 4, '2193BD36-AF87-4B99-8669-3FCEE7997273', '51757 East Azerbaijan Ave.', 'Heidi@mi.us', 835, 'B'),
(191, 8, 'BEEF3692-8481-4AA0-A8C1-620579640044', '27459  Cambodia Ave.', 'Tanya@quam.com', 341, 'A'),
(192, 4, '8112CB1C-2A6C-4DEE-B2BF-2161F4B99AEA', '43306 East Jamaica Blvd.', 'Kuame@Class.net', 41, 'B'),
(193, 9, '8A01CD68-E0F6-417C-BD13-BB86CC504DCC', '93330 North Baton Rouge Ave.', 'Alfonso@consectetuer.org', 651, 'A'),
(194, 4, '09B3AF9C-5B09-49C3-ABE8-E67C8CC1C9EB', '69642 East Turks and Caicos Islands Way', 'Rama@leo.gov', 699, 'B'),
(195, 7, '29C90A26-6CCE-4AC5-B7EE-3AD5057CD209', '29718 East Israel Blvd.', 'Caleb@ac.com', 127, 'B'),
(196, 6, '0AAB60AA-003D-4E53-8849-1B121A2109F3', '63203 South Portugal Way', 'MacKensie@Duis.us', 325, 'B'),
(197, 10, 'A603538D-DA62-48CB-9FC2-15F4011ED212', '12959 South Antarctica Ave.', 'Herrod@sodales.com', 975, 'B'),
(198, 1, '1E9A4F20-9A00-47DC-9DE1-0E917993ED94', '37109 South Hampton Blvd.', 'Kathleen@Phasellus.net', 790, 'A'),
(199, 3, '73C8F61C-B50A-4917-AB8F-40A2BCDC970E', '64672 West Bahrain Ct.', 'Ryder@bibendum.net', 711, 'B'),
(200, 2, '1934E590-A12D-473D-954B-BD99B1BD6D4F', '53370 West Alpharetta Ln.', 'Melodie@nascetur.edu', 86, 'A'),
(201, 2, 'B8426EEB-192E-4488-922F-38035C53763D', '65469 South Madagascar Ave.', 'Olga@Vivamus.net', 426, 'A'),
(202, 6, '35AA42E7-BDB2-4D6B-9D85-AF9687C357AA', '28185 South Afghanistan Ct.', 'Roth@fermentum.com', 957, 'A'),
(203, 4, 'CE6EC908-3B50-4D9A-AF14-A17CF528198A', '45855 East Charleston St.', 'Winifred@cubilia.net', 597, 'B'),
(204, 8, '05E0EDB4-485C-422A-A678-6C5FF2F35A8D', '2437  Champaign Blvd.', 'Chancellor@rutrum.us', 182, 'B'),
(205, 5, 'AE5F808F-A619-442B-8E11-B60CC1065AFF', '48741 East Yemen Ave.', 'Melinda@ridiculus.net', 827, 'B'),
(206, 10, 'BF3A809E-4A30-4035-9603-C28F2CF4DB57', '41494  Columbus Way', 'Christian@litora.org', 815, 'A'),
(207, 1, 'D21C1ADC-9540-45F2-AA0C-36F7561EA7DE', '63759  Benin Ct.', 'Eric@dignissim.com', 386, 'B'),
(208, 7, '32DF7D9D-CDE0-4265-8375-345F5F6CFE45', '98098  Equatorial Guinea Ln.', 'Raya@enim.us', 458, 'B'),
(209, 6, 'D5D46BF0-CBB8-4124-9B53-5880D721A148', '58940  Botswana St.', 'Sylvia@egestas.us', 54, 'B'),
(210, 7, '91A39E11-8B74-4538-90A4-DFC1E15F7C52', '92170  Belgium St.', 'Glenna@penatibus.us', 44, 'A'),
(211, 3, '793DA333-689F-4D96-93CC-1DD12627CB54', '40305 West Yemen Ave.', 'Amal@venenatis.gov', 57, 'A'),
(212, 10, '07985EBA-3D28-4859-8E88-F5F019C6B83D', '82696 East Comoros Blvd.', 'Yoshi@ante.com', 925, 'B'),
(213, 5, '4A7A9724-3985-45B7-8F2B-E9525E6DF43F', '26831 South Atlantic City Ln.', 'Cecilia@urna.net', 582, 'A'),
(214, 4, 'C4BC7AF9-8FD5-41EC-BDCF-7098301B5371', '17707 North Belgium Way', 'Myra@posuere.us', 479, 'A'),
(215, 7, 'E25C0813-0447-4FE2-9562-412546973C57', '40452  Belize St.', 'Wanda@scelerisque.net', 257, 'B'),
(216, 1, '994BDFCC-8A55-426E-A5A0-BEBA8D24F130', '51087 South Australia St.', 'Gemma@Praesent.net', 741, 'B'),
(217, 4, '56293453-5AEB-44AF-A81C-507D0DCFA7B7', '34014 North Belize Ave.', 'Blaze@dictum.edu', 285, 'A'),
(218, 6, 'FEB52401-40F4-4B97-A252-AE4F762417BE', '76429 East Alexandria Ln.', 'Maryam@nostra.org', 873, 'B'),
(219, 4, 'AD41C653-EF55-4881-82EF-FE3F97ADDF97', '63115 East Eritrea Ave.', 'Elmo@molestie.com', 611, 'B'),
(220, 1, 'CBCBA558-7C3B-47BA-8633-6CE055BABBEB', '21072 South Greenland Ave.', 'Wallace@justo.net', 564, 'B'),
(221, 7, '5551A3A2-E78F-45EA-BE2F-D894DDD78B7C', '69579 South Milwaukee Ct.', 'Martena@et.edu', 135, 'A'),
(222, 9, '45477259-C64C-43D8-8A49-0CEEFBAF57CB', '15580 North China Ln.', 'Ray@gravida.gov', 505, 'B'),
(223, 8, 'C22AE93F-6649-453D-9B5E-EDB16C35C0D0', '84644 South Russian Federation St.', 'Ryan@sodales.net', 517, 'B'),
(224, 9, '61D91B61-76E7-4C46-8A55-AEEC1D8D3E09', '87394 East Gallup Ct.', 'Nita@massa.gov', 15, 'B'),
(225, 2, '506AC54C-8540-45B5-8A23-4CAB90D7B307', '34925 East Turks and Caicos Islands Way', 'Charde@Nulla.gov', 373, 'B'),
(226, 10, 'F58E901A-C424-410A-B463-1F1324144144', '13545 North New Rochelle Ave.', 'Xanthus@porttitor.com', 370, 'A'),
(227, 4, '89B205C6-5C00-4498-A558-BFDF27A484B0', '98660 West Mauritius Way', 'Dana@nec.net', 407, 'A'),
(228, 1, '9EF9477B-122B-4FA5-B00C-B451420DBBB7', '10844 North Belize Blvd.', 'Wesley@egestas.org', 860, 'B'),
(229, 2, '9502B3B6-E696-46AA-806B-333C358200AC', '8103 West Chad Blvd.', 'Bert@quis.us', 603, 'B'),
(230, 10, '09E04415-0B53-4CA3-AD12-72158EA8B3F0', '38209 West Antarctica Ave.', 'Jayme@Curabitur.net', 782, 'A'),
(231, 6, '95E7D894-9E75-4267-B8DC-ED041CC2B876', '7138 North Bahrain Blvd.', 'Reagan@montes.edu', 428, 'A'),
(232, 10, '2CE460F0-6B8D-4D63-AFCF-F2AD006C8AAE', '73811 East Iran, Islamic Republic of St.', 'Neve@dignissim.com', 281, 'B'),
(233, 3, '60C64303-6CE0-4AEF-964C-21133C2D6E78', '22796 South Kiribati St.', 'Jonas@urna.net', 396, 'A'),
(234, 2, '10D4E149-DCDC-4415-9C9E-FAF5831E20D7', '47290 North American Samoa Ln.', 'Leo@nostra.us', 307, 'B'),
(235, 9, '6FC8FC33-5D61-4737-9BBF-689D88FB4E7A', '60651 South Cary Blvd.', 'Cassandra@netus.us', 947, 'A'),
(236, 4, 'F34EC2D2-3C88-494A-B8F7-DF2524BBBC03', '8365 West Bahamas Blvd.', 'Kelsie@faucibus.org', 196, 'B'),
(237, 2, '382C8DE9-6648-458B-83FE-5D7CAC4EA7B2', '2968 South Cocos (Keeling) Islands St.', 'Louis@mauris.gov', 788, 'B'),
(238, 4, 'F74A7160-602B-4385-836C-9D887BBCDF6E', '10383 South Armenia St.', 'Belle@aliquam.net', 713, 'B'),
(239, 9, 'C248B745-2797-421D-B0E2-537136B4412C', '12856 West Guadeloupe Blvd.', 'Renee@litora.edu', 351, 'B'),
(240, 1, 'A08687C5-9A87-4E3C-B593-C05D896A7E3E', '76647 East Papua New Guinea Blvd.', 'Anthony@justo.com', 417, 'A'),
(241, 7, '24B636DA-6141-4FFB-83EB-F2102DC49B61', '38740 South Brazil Ave.', 'Mira@tellus.org', 532, 'A'),
(242, 5, 'A540B989-EECA-4636-8DA8-0E93373CB723', '4138 North Nauru Blvd.', 'Deirdre@per.edu', 671, 'B'),
(243, 7, '6956D6F8-A54D-421D-BAC0-F5BA50FE744E', '94317 East Bhutan Way', 'Madeline@Fusce.com', 954, 'A'),
(244, 8, 'D00DEE8F-220C-4AE8-A0F2-F2BCE4D4FFB4', '28155 East Cuba Blvd.', 'Wesley@dui.gov', 186, 'A'),
(245, 9, 'D83E47EC-98C2-498A-AF71-F5B82AAD267B', '81400 West Bahamas Blvd.', 'Chanda@Nam.edu', 781, 'A'),
(246, 5, 'DF6BF60E-A444-4DA0-A023-9984769FBE73', '78317  Equatorial Guinea Ct.', 'Ora@primis.com', 705, 'A'),
(247, 10, '3298EA5E-775F-4DF1-B785-BAE054C1CBF0', '49212 South Goose Creek Blvd.', 'Laith@suscipit.com', 542, 'A'),
(248, 2, '6F9C30FA-128A-4FBF-9DC9-C1926669392C', '66823  Cayman Islands St.', 'Brenna@et.org', 47, 'B'),
(249, 10, '8029F8F7-CCFA-4FA2-B022-28E4864E8D84', '89167 South Norfolk Island Ln.', 'Conan@Aliquam.org', 19, 'B'),
(250, 5, '2DBF9535-1CD5-4871-90A7-9BAC8B9A1F7D', '55244 East Bolivia Way', 'Cailin@ornare.com', 837, 'A'),
(251, 1, '57E15E68-0CD9-4D47-90F0-F0A6B634FC96', '80947 West Melrose Blvd.', 'Nell@ipsum.gov', 242, 'B'),
(252, 2, 'FD5FCDD4-F1E9-4A73-8CC3-28B30469427B', '61219  Bermuda Ln.', 'Rhea@a.org', 937, 'B'),
(253, 6, '8D2EFBD8-F332-4C24-A2A1-09DA07FC7B70', '48088 South Cook Islands St.', 'Maryam@cursus.gov', 913, 'B'),
(254, 2, 'C85306C8-8899-4221-8147-A6C6064DCD8F', '20378 South Ireland St.', 'Randall@porttitor.org', 43, 'B'),
(255, 3, '37C515EB-CE4A-4F1C-B4B1-A3D2DB334046', '51162 West Slovenia Ct.', 'Hall@pharetra.us', 769, 'B'),
(256, 7, 'B7BB6EAD-5A26-40D3-9097-06235F503902', '20844 North Cayman Islands Ave.', 'Cedric@orci.edu', 929, 'B'),
(257, 8, 'AA8B400C-22A4-4103-A628-7DA2495EE789', '83478 West Madagascar Ct.', 'Gannon@ullamcorper.edu', 899, 'B'),
(258, 2, 'E7FCB058-782E-4510-AE2E-D46AF6E4941F', '1039 North Broken Arrow Way', 'Josiah@enim.net', 409, 'B'),
(259, 2, 'C3778E11-FD62-48A5-BA39-DF496A01AEE0', '6659 East Belize Ave.', 'Charles@tempor.us', 183, 'B'),
(260, 6, 'F0A45FC8-CA5E-4452-BA16-5A3EF106713D', '8841 North Compton Ave.', 'Igor@leo.edu', 906, 'A'),
(261, 10, 'DBAB9CBE-914F-4BE2-9807-5129F5CAAB41', '92601  France Ln.', 'Vanna@auctor.us', 359, 'B'),
(262, 3, 'A137F85C-6D25-4339-8E28-38AAE22685DB', '18731 East South Georgia and The South Sandwich Islands Ave.', 'Keegan@blandit.gov', 141, 'A'),
(263, 7, 'A3A22661-6A5E-4D93-9CE6-B0A68DC5A406', '37389  Clovis Blvd.', 'Stella@montes.edu', 838, 'A'),
(264, 3, 'FADB14B4-457C-47A7-8477-64488F0B3E23', '81036 West Cayman Islands Ln.', 'Ashton@bibendum.net', 683, 'A'),
(265, 4, '2E9688AC-4181-45CE-A59E-05D146D49769', '51650  Colombia Ct.', 'Adam@inceptos.gov', 128, 'B'),
(266, 7, '96BC1A26-41D3-4CA0-AB6A-3BC3BB248C87', '502 West Mobile Blvd.', 'Nelle@Maecenas.edu', 236, 'B'),
(267, 10, '4DB9DDF2-9B2F-4FCA-A0C8-3E7D60DB228B', '78009  Niger Ct.', 'Janna@interdum.edu', 304, 'B'),
(268, 7, 'D6426CA6-4526-46A3-99CE-20290130169C', '79740 West Fort Dodge St.', 'Indira@placerat.net', 256, 'B'),
(269, 4, 'CB268822-82EE-4376-8087-AF8F5E8BF1D2', '28290  Panama Ave.', 'Francis@Vestibulum.gov', 779, 'B'),
(270, 3, '45811223-86DB-42C9-BAD0-BE9CBB266CBE', '16137 East Guayanilla Ct.', 'Aphrodite@eget.gov', 993, 'B'),
(271, 2, '1546F166-22E7-41BB-AA2A-BEE2462CA226', '29399 South Peabody Ct.', 'Venus@hymenaeos.net', 686, 'B'),
(272, 5, 'B4851E60-B1F3-4DEE-834E-69383F7F3DCA', '88406  Anguilla Blvd.', 'Jameson@blandit.org', 978, 'B'),
(273, 2, 'BDF7F43B-842D-4757-951B-2C1682FF6517', '25240  Fitchburg Ln.', 'Emerald@pede.net', 367, 'A'),
(274, 4, 'ACFF5C70-6D8B-4241-9086-D524241FC721', '11915 East Guyana St.', 'Keefe@dui.net', 44, 'A'),
(275, 10, '651DFBDF-D867-4C4F-917C-6C31B6C0418C', '13657  Burundi Ave.', 'Axel@tortor.us', 543, 'B'),
(276, 8, 'E43E7A58-04A8-4670-93B1-3859869B02E1', '73971  Benin Ct.', 'Asher@laoreet.gov', 92, 'B'),
(277, 4, '63EAFADD-9AF4-49C3-AF65-8BBDCE011D19', '34945 North Bahrain Ln.', 'Amanda@mattis.gov', 211, 'A'),
(278, 7, '75D9EA3F-AD47-40FF-8FEB-6561F50B7513', '2939 East Antarctica Ln.', 'Madison@mollis.edu', 92, 'B'),
(279, 3, 'C01205C2-94D2-4FB0-A5C6-B099697B5CDE', '13787 East Cayman Islands Ln.', 'Paki@sollicitudin.gov', 218, 'B'),
(280, 2, '7B50E005-8BC1-4163-BA0F-9D279E03C139', '21242 North Clearwater Blvd.', 'Indira@vehicula.net', 416, 'B'),
(281, 10, 'CA57647C-DB49-4FAE-B041-38356AD92B97', '32823 West New Zealand Ln.', 'Georgia@Proin.com', 834, 'A'),
(282, 6, '916FEFB3-EA45-4931-AB47-A9B1EA3C43C3', '90839 East Micronesia Ln.', 'Callum@Lorem.edu', 349, 'A'),
(283, 4, '0D99B8CA-8192-4C04-9D07-9DDEB1CE7342', '75987 South Cedar City Blvd.', 'Wyatt@Class.com', 626, 'A'),
(284, 4, 'CDD769A6-7DCA-477B-B17C-C9018A6D47DC', '95074  Azerbaijan Way', 'Lesley@mattis.edu', 579, 'A'),
(285, 1, '8191293D-AFDD-4562-A852-3E50804F911C', '50820  Oshkosh Ave.', 'Amber@eget.org', 746, 'A'),
(286, 10, '2D24BEE8-E322-497B-A672-6A4711D8DF35', '13046 West Cocos (Keeling) Islands Ave.', 'Adria@lobortis.org', 905, 'A'),
(287, 9, '8B99E439-D8C3-4C7D-B565-170A792BC16B', '97357 North Puerto Rico Ave.', 'Damon@eu.net', 250, 'B'),
(288, 2, '0A348AEC-D223-4235-BE38-2E442D57A908', '10942 East Kenya Ct.', 'Phillip@luctus.org', 988, 'B'),
(289, 4, '1899D604-6B69-49E2-98CA-F4BD8E4C375D', '1670 East Malawi Way', 'Murphy@ullamcorper.us', 562, 'A'),
(290, 4, '7D811721-11E3-4544-B472-106AABD2BDDD', '99450 West Chile Way', 'Geoffrey@Cras.edu', 285, 'B'),
(291, 3, 'AA518C05-D06C-4DB8-8D31-CB75616D0C3F', '73100 South Aruba Way', 'Ryder@sollicitudin.com', 117, 'A'),
(292, 2, '9F96C5F9-1C65-4E34-A7B8-9982B16F166A', '69038 North Central African Republic Blvd.', 'Alan@ullamcorper.edu', 856, 'A'),
(293, 9, '332532AE-F5B6-41A6-BD7E-B75E0BC8EE0E', '54782 South China Way', 'Rose@lacinia.gov', 302, 'B'),
(294, 4, '030F375E-56C7-48AA-942C-176E697FD5BC', '4903 East Saint Helena St.', 'Lucius@Sed.gov', 855, 'A'),
(295, 5, '51B17658-772D-4D0D-A4B9-DDD41E1A7984', '1913 East Brookfield St.', 'Vaughan@Proin.gov', 273, 'B'),
(296, 4, '537DF7D0-159B-468D-8B3F-33840D34CA8D', '20745 North Batavia Ave.', 'Aimee@hendrerit.com', 866, 'B'),
(297, 10, 'E469526E-CFB3-4700-9FAD-8E9D7F3EFFFE', '92456 South Bessemer Ave.', 'Barrett@Etiam.gov', 23, 'B'),
(298, 5, '7DA7C44A-C80D-4F3A-8C44-27CD772F6392', '31197 North Bristol Ave.', 'Alvin@egestas.gov', 349, 'B'),
(299, 6, 'E741EC48-9C25-4705-86DE-AB61561B43EF', '61928  Blacksburg Way', 'Uta@pellentesque.edu', 473, 'A'),
(300, 4, 'C65B5BEC-3FF5-4626-AB11-3B1E54DB8C1E', '34447  Christmas Island Way', 'Sydnee@tempor.org', 247, 'B'),
(301, 5, '32F6C109-CE51-4F26-ABFB-7E1F3F705C4B', '77968 West Mozambique Way', 'Morgan@dolor.us', 734, 'B'),
(302, 8, '2C791ECF-DDB8-4DDD-A3C4-F23517A6B21A', '77643 West Equatorial Guinea St.', 'Keith@egestas.gov', 905, 'B'),
(303, 8, 'AAE8D87A-5773-440A-BEE1-E8E073AD8600', '29233 North Nepal Way', 'Yoko@nisl.gov', 25, 'B'),
(304, 10, 'D3E71882-CDB0-4620-A039-8913931A831D', '67232  Saint Vincent and The Grenadines Ln.', 'Porter@Integer.gov', 291, 'B'),
(305, 6, '8230761C-775F-4379-8410-A78B6390ACD5', '27502  Sri Lanka Ln.', 'Henry@ullamcorper.com', 776, 'B'),
(306, 1, '95EB94D1-DE57-4E70-BCC3-12FDDA106CDD', '94301 North Idaho Falls Ln.', 'Camden@vulputate.net', 994, 'A'),
(307, 4, '1685BD29-9F81-4A57-B314-27A43AA1CE25', '40782 North Heard Island and Mcdonald Islands St.', 'Dane@vitae.com', 362, 'B'),
(308, 4, 'C17A3563-B856-48E5-84DF-D411458F2A36', '56691 North Iran, Islamic Republic of Way', 'Sydney@fermentum.net', 63, 'A'),
(309, 3, '0008A2FE-7905-4D57-AFB6-CFA4A3298D06', '32729  Hong Kong Way', 'Zachary@dapibus.com', 763, 'A'),
(310, 7, 'FD37C0E2-CDF3-4B99-B2FE-9FBB18D5F384', '97629 East Burlington Ct.', 'Fallon@conubia.net', 792, 'B'),
(311, 1, '647C5910-4B38-44A2-8845-E4300D792BDB', '6307 West Cyprus Ave.', 'Haviva@blandit.edu', 134, 'A'),
(312, 1, '09FD73D9-A211-40FD-A9DA-468DD6F41A41', '67451  Bulgaria St.', 'Beau@interdum.edu', 942, 'B'),
(313, 1, '741C2E35-18D9-4415-9F13-5AA2C700FEA5', '22596 East Burundi St.', 'Xenos@orci.com', 296, 'A'),
(314, 1, 'ACCDF425-AE1E-4B5F-BB5D-A0E49398C716', '56504 West Andorra Ct.', 'Wanda@magnis.org', 916, 'B'),
(315, 9, 'D3C48C9B-213A-4827-95E2-0856A7D3B9D2', '11510 West International Falls Ln.', 'Patrick@Praesent.edu', 76, 'A'),
(316, 7, 'A7ABFBE2-C638-409F-96B8-459963BD5479', '64883  Russian Federation Way', 'Quinn@tellus.us', 79, 'A'),
(317, 4, 'C7D181AE-42B4-49DE-8EA9-38CAC93C3D67', '20420 South Norway Way', 'Christopher@Integer.gov', 789, 'A'),
(318, 3, 'AB92489B-7E19-430A-B1FA-6C964727BE70', '49230 South Bosnia and Herzegovina Blvd.', 'Quentin@feugiat.gov', 593, 'A'),
(319, 3, 'A25026EE-A4E5-4C8B-B698-DC58573519B8', '15834 South Netherlands Antilles Ave.', 'Hope@consectetuer.com', 265, 'B'),
(320, 7, '7DEB8972-AD8F-4033-AA02-F9200F20CA6A', '11888 East Syrian Arab Republic Blvd.', 'Ursa@viverra.org', 357, 'B'),
(321, 10, '5184E6BD-B9E0-451E-83F3-5CD0816C5878', '53186 South Macedonia Blvd.', 'Yoko@congue.com', 88, 'A'),
(322, 5, '5FB4CA6C-E4C3-4E14-BA3B-EDED970D7790', '15883 East Council Bluffs Ct.', 'Erich@litora.org', 4, 'A'),
(323, 4, 'E605B5CB-77D3-4E28-BC89-D220499794CB', '14736 East Grafton Blvd.', 'Autumn@tortor.com', 740, 'B'),
(324, 4, '969F917D-12D7-41DE-97F8-9125184B38BB', '9238  Iran, Islamic Republic of St.', 'Erich@Cras.com', 629, 'A'),
(325, 1, '595A7D8C-B73E-49A4-9DFF-91DAE9B73924', '11419 South Duluth Blvd.', 'MacKensie@facilisis.com', 480, 'B'),
(326, 3, '5AB79A43-7E65-473D-BBE9-4611244E00E1', '95427 West Morocco St.', 'Quamar@risus.edu', 766, 'B'),
(327, 1, 'FE50DE95-2DEE-4E30-B3F1-0271D254FBA5', '32388  Barbados Ct.', 'Idona@consequat.edu', 339, 'A'),
(328, 1, 'AB44F295-AF89-4A77-A37B-0461F037E82F', '89198 East Armenia Blvd.', 'Jolie@lacus.gov', 225, 'A'),
(329, 5, '66BBAE1E-E906-438A-BCA4-46B94EC3B7CD', '90269  Colombia Ave.', 'Micah@pulvinar.us', 471, 'B'),
(330, 10, 'ADAF1DB8-4B24-4733-98BE-205D56E62B0A', '54735 West Australia Blvd.', 'Cooper@montes.org', 880, 'B'),
(331, 3, '09D7F7FA-1A99-4EC3-BBC7-912F3804F42E', '36317 East Canada Ct.', 'Candice@ornare.us', 276, 'A'),
(332, 5, '197DDC55-F682-47C0-8DBE-0DF8DF5003E3', '79705 North Falkland Islands (Malvinas) Blvd.', 'Philip@hymenaeos.net', 691, 'B'),
(333, 5, '873E7F8C-DF0E-4F81-ABC9-841CB806644E', '29616  Bahrain Ct.', 'Nissim@porta.us', 551, 'B'),
(334, 3, 'FE2D07D4-70B6-49FD-8009-5DC11F6AECB8', '68019  United Kingdom Ave.', 'Chadwick@ac.gov', 271, 'A'),
(335, 10, '0102B09A-34EF-42D0-91D5-EC4BE8467D1C', '93986 South Western Sahara Ave.', 'Vernon@nisi.com', 296, 'A'),
(336, 1, 'F4592703-2521-462A-9CA2-C1837DBD664F', '24439 East Belarus St.', 'Jason@mattis.gov', 906, 'A'),
(337, 2, '638EADF4-9B3A-42CB-9FA4-5679D7572379', '69888  Cypress Ln.', 'Keane@amet.edu', 174, 'A'),
(338, 1, '090BF3AF-C215-4183-A608-0E1FE818D130', '93992 South Cameroon Blvd.', 'Clarke@bibendum.gov', 273, 'A'),
(339, 1, 'B82ABD7B-8C41-450D-9EA7-570DC3B4A11E', '55608 West Lawton Ln.', 'Chase@nostra.us', 58, 'B'),
(340, 7, '8EB93503-836E-408D-8D0F-9DF1BC35AD00', '18156 South Antarctica Ave.', 'Vernon@et.com', 590, 'A'),
(341, 9, 'A624772D-454A-4CD6-8B40-1F9581CC0E21', '33022 West Cerritos Way', 'Kato@fames.gov', 503, 'A'),
(342, 6, '7CCCE050-8684-4795-B131-832652BF9E7E', '16715 West Turks and Caicos Islands Ln.', 'Grady@cubilia.us', 17, 'B'),
(343, 4, 'E23D9076-70B5-4D95-AB52-7F70171FFA4A', '18463 West Burundi Ln.', 'Hyatt@conubia.edu', 311, 'A'),
(344, 7, '1F7054EA-4019-4620-9B5D-F997F735C861', '51305 South Azerbaijan Way', 'Renee@parturient.us', 347, 'B'),
(345, 2, 'C641B1FF-3265-41B0-B471-D5542F2CCF0C', '17236  Sweden St.', 'Heidi@penatibus.us', 79, 'B'),
(346, 2, '434848CB-953E-4F0B-85EC-922E6F9782F0', '11888 East Latrobe Ave.', 'Ocean@eget.net', 419, 'A'),
(347, 3, '88D988AA-5C01-4464-AE31-613DA8F91879', '71093  Palestinian Territory, Occupied Blvd.', 'Burke@Duis.edu', 232, 'B'),
(348, 6, '909F6707-599C-4F3B-9239-4DFDEF7EF44F', '86635 East Morocco Ln.', 'Perry@conubia.com', 744, 'A'),
(349, 6, 'B64F200D-1F06-4327-81FE-3C84EEFA500A', '65853 North Marshall Islands Blvd.', 'Dorothy@Aenean.net', 17, 'B'),
(350, 9, '8AD60E0D-1493-489A-BADC-123F19251A27', '48778 East Malta Way', 'Keelie@nec.net', 814, 'B'),
(351, 8, 'A5F81116-3AC4-4D0A-8B72-62BC45C95E38', '10111 North Andorra Blvd.', 'Jason@magnis.net', 98, 'B'),
(352, 7, '4CEEE2B0-53C7-4B75-A050-95DADFB3E1CC', '69864 North Hawaiian Gardens Blvd.', 'Sydney@magnis.org', 840, 'B'),
(353, 7, '43862A26-1582-4397-984D-22CD9BA2EEE6', '54655 South Coos Bay Ln.', 'Cheryl@nulla.gov', 930, 'B'),
(354, 6, '6B69C3D9-0F32-42AE-86A7-599F6D88E9AA', '42419 East Cocos (Keeling) Islands St.', 'Brynne@Nullam.org', 537, 'B'),
(355, 8, '115E2B42-9734-4B1C-8317-45D800155BEB', '69334 West Haiti Ave.', 'Branden@consequat.edu', 943, 'A'),
(356, 1, '2327B0F2-B746-4BD0-A8D8-BD9B9A1CB28D', '44111 West Afghanistan Ln.', 'Maya@ornare.us', 278, 'A'),
(357, 5, '4AFF75C1-DAA9-43F6-AE66-987386854C35', '64418 North Poland Ln.', 'Ronan@sagittis.us', 942, 'A'),
(358, 5, '1E9FBD80-F73A-4C99-8B25-7234BE0ADA10', '77535 North Fort Wayne St.', 'Iris@urna.gov', 416, 'B'),
(359, 9, 'CF37A8BF-4BF9-4C24-AD63-2F1D0E2DE9D1', '81897 West Togo Ct.', 'Portia@magna.net', 994, 'A'),
(360, 7, '57882ACC-A55F-462D-A2DB-B18C6391F258', '1935 South Bangladesh Ln.', 'Gillian@egestas.net', 280, 'B'),
(361, 9, '8CBF8E29-64AC-4DD3-8353-872999638452', '53820 North Palestinian Territory, Occupied Blvd.', 'Cleo@viverra.us', 360, 'B'),
(362, 3, 'CB7C6320-7A4B-4889-BEFD-86CFE253E0C5', '76057 East Cairo Way', 'Sage@Vivamus.edu', 987, 'A'),
(363, 6, '6B38D1CF-7AB1-4C3E-8350-21727C54E6E6', '92713 East Mauritania Ln.', 'Deborah@erat.com', 815, 'B'),
(364, 3, '4A848D8F-FF7E-4B06-8AD3-80092A113675', '32980 South Venezuela Ct.', 'Price@malesuada.net', 401, 'A'),
(365, 9, '2DE7B7DF-912D-41BF-80B8-1731CC5CC1BD', '30042 East Grand Island Blvd.', 'Mechelle@Aenean.us', 213, 'B'),
(366, 2, '7001FA10-18D7-4301-8968-057B4A1B4F53', '42497  Easton Ct.', 'Claudia@cursus.net', 189, 'A'),
(367, 9, 'E6CB0D6D-6306-43D2-8D9E-9EBD142EDDAD', '65532 East Chicopee Way', 'Charde@diam.com', 270, 'B'),
(368, 9, '093652BA-A3D1-42AF-8F62-EFE171093C37', '44459 South Kokomo Ln.', 'Ignacia@inceptos.org', 402, 'A'),
(369, 6, '7C8445CB-B5ED-4800-92EB-72492002AB0B', '91274  Eatontown Way', 'Knox@egestas.gov', 264, 'A'),
(370, 1, '25331600-EE73-47F1-8EE2-330C0CEB04C3', '76394 West Bahamas Ct.', 'Serena@cubilia.edu', 55, 'A'),
(371, 2, '5923F0A8-C4DB-4BB7-8EF3-2537C3B45A75', '1956 South Spain Ln.', 'Caesar@tempor.org', 941, 'A'),
(372, 7, '1ED3364B-7722-43F3-AEF9-73EC57457870', '32198  Charlottesville St.', 'Diana@sit.com', 662, 'B'),
(373, 7, 'F5881DDD-AA12-44D5-BE32-26BDC82EADE1', '11241  Montserrat Ln.', 'MacKensie@urna.gov', 479, 'A'),
(374, 1, '0C1C92EA-B6F5-4517-93A0-03239CEF2CB6', '17066  Passaic St.', 'Slade@adipiscing.us', 982, 'B'),
(375, 4, '81CC3369-E064-4B56-BEBC-B088B37ACF6C', '91137 West Burundi Way', 'Savannah@ornare.com', 247, 'B'),
(376, 1, '542CE32F-3B14-4A9A-8CA4-5CDC6789929E', '50496 West Cruz Bay Ln.', 'Aidan@semper.us', 979, 'A'),
(377, 7, '94FFC658-4EC6-4BE2-B9A5-6F4591A0794B', '29160 South Eritrea Ln.', 'Basia@adipiscing.gov', 824, 'A'),
(378, 1, 'A835920D-4FBE-45BC-8212-D82921DE0857', '60735 West Turkmenistan Way', 'Helen@tempor.com', 207, 'A'),
(379, 7, '3462A5AD-2BB8-4CEC-9BFA-619993B6C70D', '50891 West Gibraltar Way', 'Freya@quis.edu', 244, 'B'),
(380, 8, 'CE60B4B3-4B9A-4468-9A17-D7EE80EFF87C', '28337 South Morrison Way', 'Walker@Nunc.gov', 872, 'B'),
(381, 9, 'DF37729C-6A33-4081-AF5D-D921002935B0', '29688 East Houma St.', 'Demetria@velit.us', 212, 'A'),
(382, 10, 'EB257E62-4935-4288-BDEA-539B5C053B39', '13096 West Miami Gardens Blvd.', 'Barbara@consequat.net', 717, 'A'),
(383, 10, '6966DFB3-1396-4923-AF5A-9420DB701AED', '12323  Micronesia St.', 'Buffy@magna.com', 630, 'B'),
(384, 10, '37662DAE-D003-468D-8490-369094883331', '4724 West Burundi Ave.', 'Warren@nibh.org', 957, 'A'),
(385, 10, '62BF9647-B595-41AC-8338-736BF16BD160', '28628 South Liberia Way', 'Harrison@consequat.gov', 437, 'B'),
(386, 8, '978F092B-B237-49CE-BCFE-70CB3CDEA337', '78264  New Caledonia Ln.', 'Kellie@volutpat.edu', 874, 'A'),
(387, 7, 'FD756E8C-09D4-4776-88DE-B6BCB1F6B0A9', '79196 East Anaconda Ln.', 'Owen@ornare.us', 186, 'A'),
(388, 9, 'FA8990BA-AB48-44D2-84BA-54FE025792A7', '77058 West Muncie Ln.', 'Steel@placerat.edu', 727, 'A'),
(389, 10, '6BE64F13-BCAF-4A6E-B3B7-716DB64D92D0', '24356 South Kenya Way', 'Nomlanga@bibendum.org', 493, 'B'),
(390, 10, 'A02C5B13-4FD0-49B4-9391-EBBBA147CA39', '73865  Saint Vincent and The Grenadines Ct.', 'Asher@dis.gov', 649, 'B'),
(391, 4, '19CEBE11-16D6-4460-A18C-87EAF0488E53', '92219 West Morocco Ave.', 'Wylie@volutpat.gov', 326, 'A'),
(392, 8, '29A1A37D-62A3-4C18-AC78-A379E3CAFDCB', '22091  Malaysia Ln.', 'Rahim@ornare.edu', 471, 'A'),
(393, 7, '67AF8213-899D-45C6-8DB5-F73C3EC9548D', '13100 South Fulton Way', 'Jordan@ligula.us', 397, 'A'),
(394, 4, '28AF617E-6688-4E33-A26F-C6F89F352D3D', '37065  Boulder City St.', 'Brynn@blandit.us', 795, 'A'),
(395, 5, '28117ECC-B81C-4653-8830-5811E70D8654', '73020 North Cayman Islands Ct.', 'Tara@dolor.net', 359, 'B'),
(396, 1, 'C7209DA3-5308-47E2-9B3D-F5692B215D36', '34658 West Rwanda Ave.', 'TaShya@id.edu', 974, 'B'),
(397, 4, 'AF1AEBA7-B736-4B4D-8A80-8A584CB765D8', '67222 West Cairo Way', 'Amaya@massa.edu', 569, 'A'),
(398, 2, 'A49A105B-D832-4AA8-B0ED-72F5F1A3DB76', '2799 West Kuwait Way', 'Avye@a.net', 882, 'A'),
(399, 5, 'B4F29042-C906-4ECA-AC00-9A64CA4A88B1', '11868  Malta Ct.', 'Kyla@varius.org', 912, 'B'),
(400, 8, 'E2398B1C-9ECA-4059-B6AB-68DC4604E56C', '88623 West Dover Ct.', 'Rose@dolor.us', 36, 'A'),
(401, 3, 'AEC1345F-C317-40B3-9AF9-82374477D578', '82805 West Merced Way', 'Aidan@velit.com', 818, 'B'),
(402, 4, '1EA1D022-50CA-4A92-A5C3-090F729A0164', '15467 West Cambodia Ct.', 'Knox@Aenean.gov', 403, 'B'),
(403, 3, 'F103CB5F-6B8A-4E6B-968B-167A65EC6431', '29133 West Namibia Way', 'Bernard@egestas.net', 479, 'B'),
(404, 10, 'A9D2EB04-3894-4B6B-BFE0-1C642C971C7B', '87249 West Corpus Christi Ave.', 'Shaine@nunc.org', 249, 'A'),
(405, 8, '4B1AF038-27AD-43AE-98F9-2FD5BBFF0B8D', '90869 East Uruguay Way', 'Clio@auctor.org', 464, 'B'),
(406, 8, '52C4F209-1DA2-419F-B228-D446DFAFA150', '38893 West Djibouti Blvd.', 'Tanek@netus.net', 182, 'B'),
(407, 7, 'D27C43AE-189A-4228-836F-F80195B665AF', '78098 East Antigua and Barbuda Ct.', 'Quemby@neque.org', 699, 'B'),
(408, 4, '5ED6C1D8-44EA-478D-800F-9B0A41C304AA', '24461 East Cayman Islands Way', 'Dennis@Aenean.gov', 422, 'A'),
(409, 2, '849B9C92-7F99-403C-BB39-2A9D21ED6005', '4532 North Philippines Ln.', 'Richard@accumsan.us', 585, 'A'),
(410, 3, '3A8472A1-9869-43AA-AB6F-2974C89CFCE8', '45333 South Guinea-bissau Ave.', 'Thane@sagittis.edu', 774, 'B'),
(411, 5, '61457837-5FC5-443C-9BFB-55BBA43719CC', '21053 East Croatia Ave.', 'Micah@Quisque.edu', 851, 'A'),
(412, 9, 'DEC6E8FC-1160-420A-A549-E41545794E17', '46525  Togo Blvd.', 'Aspen@amet.gov', 166, 'B'),
(413, 10, '58FA1BA9-7C06-4DEC-879D-30DECA871187', '54614  Greensboro Blvd.', 'Jamal@nulla.us', 935, 'A'),
(414, 4, '54976793-8B93-4C4E-A23F-49D8F28D5642', '88818 East Cocos (Keeling) Islands Ct.', 'MacKensie@posuere.com', 577, 'A'),
(415, 2, '6B856037-2B7D-48C5-A458-1634C9B9E6F9', '71137  Rwanda Blvd.', 'Cyrus@pellentesque.edu', 142, 'B'),
(416, 8, '21900E58-365D-4A08-90FD-1A2FB8A81832', '41668 West Guadeloupe Ln.', 'Tatyana@auctor.net', 225, 'B'),
(417, 2, '7204A5F3-DF07-43A6-899D-C80C65F87E76', '1426 South Australia Blvd.', 'Baker@hymenaeos.net', 233, 'A'),
(418, 1, '186A7A2A-C0C4-401E-8A2C-4150C7CEEAF1', '18314 West Guatemala St.', 'Eagan@vel.gov', 714, 'B'),
(419, 4, 'FBFF8303-1BAB-4C0A-8F25-21F961FBC185', '27826 South Lower Burrell Ave.', 'Yoshio@primis.org', 18, 'A'),
(420, 2, '718A693E-CC94-4B0C-9DD7-B7B9E2D7C461', '47128 West Cedar Falls Blvd.', 'Sylvia@litora.gov', 253, 'B'),
(421, 3, 'FDDADEFC-1197-4A59-AEC3-B0815CB3B1F5', '48638 West Cape Verde Ct.', 'Althea@metus.gov', 165, 'A'),
(422, 4, '7ABCC144-B14F-4494-A224-7F1F05ACF62D', '72921 South Belarus Blvd.', 'Meredith@Integer.edu', 291, 'B'),
(423, 4, '932CA85C-1C68-460F-AB20-F3572654CBD8', '86511 North Sudan Blvd.', 'Ella@tempus.gov', 988, 'B'),
(424, 3, '3C70C222-BFAB-4E89-A140-26493163776B', '16839  China Ct.', 'Rebecca@quis.gov', 947, 'A'),
(425, 2, 'E00A437A-A2FA-4E1E-B77D-E1BB6DB238B5', '50493  Central African Republic Way', 'Halee@lectus.us', 718, 'A'),
(426, 3, '5ECFE0D0-5640-4419-B9AF-AC99E40468EF', '12921 North Turks and Caicos Islands Way', 'Thomas@mauris.gov', 187, 'B'),
(427, 5, 'F98A73B6-6483-46C3-9ADB-B5C3C6BF0F87', '48714 North Cape Verde Blvd.', 'Avram@fermentum.com', 821, 'A'),
(428, 4, 'E4D8BF13-35B0-44E0-87B9-06D1AB9D4C3D', '37520 West French Polynesia Blvd.', 'Isaac@ligula.com', 336, 'B'),
(429, 8, '6EC512E3-85FF-40B6-A5B8-45618C6119AE', '51228 West Maldives Ct.', 'Rajah@Cum.us', 121, 'B'),
(430, 9, '37618363-3616-44F8-8959-740460D97F45', '35803 South Honduras St.', 'Ulric@nunc.gov', 893, 'A'),
(431, 5, '1AA06BFC-E71F-472B-B978-44F6AFE2010A', '18409 South Brunei Darussalam St.', 'Kevin@auctor.org', 990, 'B'),
(432, 7, '76E06ECB-91D4-47F0-963C-46771F6E47D2', '86309 North Burkina Faso Ln.', 'Macaulay@arcu.com', 729, 'A'),
(433, 7, '239A53AB-86A9-4E70-80C2-320DC575E1FB', '92242 West Great Falls Ave.', 'Brynne@placerat.gov', 296, 'A'),
(434, 7, '2805B0A9-8FB6-4E61-A1C2-F99566B86302', '35763  Farrell St.', 'Thaddeus@eros.net', 147, 'B'),
(435, 7, 'A60F65EB-41D7-4426-B239-FE808CE5BFEC', '81798 North Gloucester Ln.', 'Jasmine@purus.net', 317, 'B'),
(436, 4, '1230E19B-88B8-497A-8AE0-D7C6E0255238', '74753 East Central African Republic Ave.', 'Porter@tortor.org', 461, 'B'),
(437, 2, 'E4997F08-DC52-4680-A537-0DC9C704CAFA', '4785 West Bouvet Island Ln.', 'Jada@mi.us', 341, 'A'),
(438, 3, '582C6E2D-5548-408C-BD52-CA105BF74DD9', '44211 South Bangladesh Ct.', 'Kelly@lacinia.com', 380, 'B'),
(439, 1, '06C8BB8C-9D34-4906-86AB-4C08D904833E', '63836 North Malta Blvd.', 'Audrey@Curabitur.org', 223, 'A'),
(440, 3, '629F1641-D562-48B2-819D-D09C651F4620', '5830 North Nicaragua Ave.', 'Gil@cubilia.net', 542, 'A'),
(441, 6, '5B24169D-0D0E-44EF-9952-ED4435F56289', '42877 North Cook Islands Ct.', 'Patrick@tristique.com', 371, 'B'),
(442, 1, 'DD24ECA7-5B33-4C9B-9C88-71611A46366B', '69345  United States Minor Outlying Islands Ave.', 'Nathan@tortor.com', 978, 'B'),
(443, 5, 'D8B87CA1-96B4-48F5-84B9-BFF53F6E575B', '79468  British Indian Ocean Territory Ln.', 'Carol@felis.us', 613, 'A'),
(444, 3, '0608FDD7-1F69-421F-AF2C-A0214FFE6F92', '77446  Austria St.', 'Leonard@Curae.us', 185, 'A'),
(445, 3, 'C8E8072B-4C5F-46CB-B2B9-5F28B282491A', '99215 East Faroe Islands St.', 'Branden@taciti.com', 410, 'A'),
(446, 7, '4DF27CCD-B41F-4145-900B-956F035316A4', '63926 South Birmingham Ct.', 'Bertha@posuere.gov', 363, 'A'),
(447, 10, '020DAEDA-38F2-4B06-9B4B-47E57E145501', '21489 West Carbondale Blvd.', 'Palmer@Phasellus.edu', 585, 'A'),
(448, 3, '06FB4858-1422-4691-8D81-7CBC9CF0E7C8', '28929  Pakistan Blvd.', 'Guy@iaculis.gov', 719, 'B'),
(449, 4, 'E24FE43B-E8C1-43B4-B30B-789A6F49F419', '3566 West South Africa St.', 'Carson@neque.com', 670, 'B'),
(450, 5, 'E4913517-C54F-45A6-84C4-06F3CA203971', '57500  Afghanistan Ct.', 'Warren@Class.net', 147, 'B'),
(451, 8, '6B376975-DAC9-4660-BE6E-C593085A8B80', '5417  Gilette Ct.', 'Arthur@condimentum.gov', 398, 'B'),
(452, 3, '801186EA-495F-4E7C-A2EA-3DA920B15062', '81246 West Rwanda Ct.', 'Hedley@diam.us', 645, 'A'),
(453, 2, 'AB55777C-B18E-42A1-A9C8-F905370FE4A0', '27015  South Georgia and The South Sandwich Islands Way', 'Belle@Nullam.org', 628, 'B'),
(454, 1, 'CA0023E1-D768-4E2C-8FB8-B59528C1CBE1', '82339 East Fontana Ave.', 'Daria@tempus.com', 118, 'B'),
(455, 2, '676CF3FE-2FDE-4997-BF0A-D0B708C47937', '40354 West Angola Ct.', 'Kuame@primis.edu', 824, 'B'),
(456, 5, '815D85D5-EA76-484D-A5D8-23DD01DCAAA4', '44555 South Benin Ct.', 'Eve@lacinia.gov', 724, 'A'),
(457, 9, '259BCA0B-AC16-4667-9F60-8DD4C56687B9', '87393 West New Zealand Way', 'Hadley@pede.gov', 922, 'B'),
(458, 9, '73196031-106D-4B59-9D9A-C15F59609666', '54585 East Belize Ln.', 'Barclay@fames.net', 600, 'B'),
(459, 9, '3262E8F9-6881-4ADF-90D7-4BBB68787FE6', '94861 North Barre Ct.', 'John@vestibulum.com', 438, 'B'),
(460, 9, '5F2CB588-CC43-464F-BD66-D212EB338C77', '40734 South Oneonta Ave.', 'Darrel@torquent.org', 999, 'B'),
(461, 5, '1D7C2EE6-AF10-4B5A-A54D-5C2B15811E48', '3619 East Berkeley Ave.', 'Bevis@lorem.com', 395, 'A'),
(462, 4, 'FA32A7C7-009E-4D7D-86D5-F47BA8DDFB58', '4898 North Algeria Ln.', 'Hayes@primis.org', 269, 'B');
INSERT INTO `maestro` (`id_maestro`, `id_identificacion`, `codigo_identificacion`, `direccion`, `correo`, `celular`, `estado`) VALUES
(463, 6, 'E561FDF9-4ED8-4643-B54D-009CA8C22894', '40275 West Lebanon Ave.', 'Illana@conubia.org', 688, 'A'),
(464, 5, 'E9BB1122-01BB-4A0C-A3F8-3AE5A15B69AF', '64527  Hamilton Way', 'Thaddeus@egestas.gov', 81, 'B'),
(465, 5, 'EFFC3D64-9349-49BF-935B-217BF51DC92C', '19460 West Compton Way', 'Claire@auctor.com', 97, 'B'),
(466, 2, 'DD50064B-167F-4EFE-BD36-1F95206DFF60', '99302 North Iran, Islamic Republic of Ln.', 'Wilma@habitant.com', 362, 'A'),
(467, 4, '1582BC45-C8A0-4E11-9CD4-2634BC7680F4', '57987 North Austria Ln.', 'Aileen@egestas.gov', 583, 'B'),
(468, 8, '508E2A01-2190-46E3-81F4-3532E54E3933', '29736 North Netherlands Antilles Ave.', 'Xavier@egestas.com', 628, 'B'),
(469, 8, 'BD5F96A1-0C20-4C66-9A2C-7156138F5AB0', '46530 South Hazleton Ave.', 'Merrill@lacus.com', 456, 'A'),
(470, 3, '1A47F685-2C42-400A-8DF5-4A6DA6CC85E4', '18168 East Greece St.', 'Uriel@Class.edu', 334, 'A'),
(471, 2, '2516D1A4-012C-4976-8FEE-46516D88A9DE', '19886 East Areceibo Ave.', 'Keane@pulvinar.org', 335, 'A'),
(472, 10, 'AF0635DA-5BF9-44CD-9C86-B7D00807D9FC', '12863 East Idabel Ln.', 'Xantha@lectus.com', 622, 'B'),
(473, 8, '50D1A5D2-8723-4A9E-92B0-4D147A2DBD64', '9503 North Fajardo Ct.', 'Britanney@risus.us', 40, 'A'),
(474, 6, 'C4BF0685-9283-4568-A2AF-57EFC277B59E', '98412 North Chicopee Way', 'Yasir@parturient.us', 825, 'A'),
(475, 9, 'C4F4E58C-1DCE-4A41-9B03-376EB84F9CC1', '2315 West Ireland St.', 'Lawrence@nisl.com', 841, 'B'),
(476, 4, 'E8814BE4-8388-4FC3-8861-E807B4F55F3E', '84330 East French Guiana Way', 'Cecilia@purus.edu', 877, 'A'),
(477, 8, '05E31DCB-C3CD-4631-B8ED-BF7B88B61FEA', '5287 West Bhutan Way', 'Belle@egestas.gov', 568, 'B'),
(478, 7, '59F44510-DF41-4F2F-8DA5-518980BADC95', '68336 East Burundi Blvd.', 'Ishmael@tempus.org', 468, 'A'),
(479, 4, '1DF122A0-BEA7-41B2-9EAB-F7D7BC671695', '11441  Grenada Blvd.', 'Regan@pellentesque.org', 61, 'A'),
(480, 8, '95EAEB93-65A3-407F-AC05-C3C06E176FDA', '57 West Mayotte Blvd.', 'Destiny@Donec.gov', 356, 'B'),
(481, 1, '36B03691-A601-41C2-881E-B04F727E38FA', '29901  Swaziland St.', 'Burke@pellentesque.gov', 201, 'A'),
(482, 6, '6F071DE7-B361-4C36-BE10-1ABFFEBB8BC7', '73334 East Nepal Way', 'Lacey@a.edu', 694, 'B'),
(483, 6, '0423A871-4CE1-450C-BD07-0208818088D6', '56778 North Bouvet Island Ave.', 'Renee@auctor.net', 177, 'B'),
(484, 8, 'B82F9442-E8AE-4193-8311-98DFD1937D25', '52940  Chile Way', 'Mara@augue.com', 285, 'A'),
(485, 7, '135DAF17-0AC9-435B-A703-12E0E684411E', '73605 East Tunisia Ln.', 'Ethan@commodo.net', 503, 'B'),
(486, 1, '38EF1A8D-AFA7-44FF-A36F-30AA64EE0962', '17421 East Croatia St.', 'Chastity@pulvinar.net', 41, 'A'),
(487, 1, '455D5336-8902-4BAF-B399-9148A509C5FE', '82232  Central African Republic Ave.', 'Deacon@eu.edu', 932, 'B'),
(488, 2, 'CF217019-F8C1-4F3D-852E-9DF2B395685A', '7385 East Claremore Ct.', 'Dora@mus.com', 836, 'A'),
(489, 9, '659F8FB0-99C4-45F1-9015-69A642DE09E8', '9778 East Algeria Way', 'Raja@lacus.edu', 26, 'B'),
(490, 6, '2D179CFB-459D-4461-BD50-221516C102BF', '97108 North Aruba Ct.', 'Eugenia@Nulla.com', 647, 'A'),
(491, 10, '16C43C4A-BE96-4502-A960-A141C660F3F7', '85683  Costa Rica Way', 'Chelsea@enim.gov', 451, 'A'),
(492, 5, 'A4E51F67-1A3A-4EC7-823F-2005DBDED3CD', '75322  Mauritania Ct.', 'Shelby@sodales.org', 955, 'B'),
(493, 6, 'D40F37FB-A43E-41D5-8224-6348A7A50AC9', '54479 East Afghanistan Way', 'Omar@eget.net', 805, 'A'),
(494, 4, '8DEB54C8-14D4-42D3-BF14-FE3E694BD7DB', '18303  Central African Republic St.', 'Laith@nostra.org', 614, 'A'),
(495, 10, '4D66D53F-3F05-4129-9275-EF238442285D', '79403 South Hollywood Ave.', 'Basil@Vivamus.edu', 8, 'B'),
(496, 6, '7E6B52FE-E826-47F3-A76A-BAA2B5E2C67C', '87729  Niagara Falls Blvd.', 'Kay@eleifend.gov', 94, 'A'),
(497, 1, 'BCCBCC69-E814-4FFF-8FDE-7F3C2284AC97', '96532 North Fayetteville Ave.', 'Dahlia@nisl.com', 780, 'B'),
(498, 4, 'F5482A1B-0832-4C65-84A5-A4B1DCEE2047', '22249 South Virgin Islands, British Ln.', 'Kessie@molestie.org', 809, 'B'),
(499, 2, 'BC9FF55B-62AD-404C-B9BE-7EF6CDCC0B53', '12718  Bangladesh Blvd.', 'Rogan@lorem.gov', 310, 'A'),
(500, 10, 'AE50D876-B85E-4205-A42E-5FF2C1114D77', '14768 South Fairmont Blvd.', 'Gavin@congue.com', 447, 'A');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `maestro`
--
ALTER TABLE `maestro`
  ADD PRIMARY KEY (`id_maestro`),
  ADD KEY `id_identificacion_idx` (`id_identificacion`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `maestro`
--
ALTER TABLE `maestro`
  MODIFY `id_maestro` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo que identifica al maestro', AUTO_INCREMENT=1001;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `maestro`
--
ALTER TABLE `maestro`
  ADD CONSTRAINT `id_identificacion` FOREIGN KEY (`id_identificacion`) REFERENCES `identificacion` (`id_identificacion`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


INSERT INTO `maestro_curso` (`id_maestro_curso`, `id_maestro`, `id_curso`, `id_grado`, `id_aula`, `descripcion`, `fecha_creacion`, `estado`) VALUES
(1, 13, 2, 2, 5, 'FNlFuoNWMx', '2020-08-27', 'A'),
(3, 16, 5, 2, 1, 'aOtsZJugTB', '2020-08-21', 'A'),
(5, 1, 4, 1, 3, 'FCZVUXGdTM', '2020-08-25', 'B'),
(7, 25, 6, 3, 4, 'Gf SDwhQEl', '2020-08-24', 'B'),
(8, 1, 6, 4, 1, 'dyoumVkkQt', '2020-08-22', 'A'),
(9, 8, 6, 3, 3, 'rHSKvbYMnq', '2020-08-24', 'A'),
(12, 15, 5, 2, 1, 'Unk LWI LC', '2020-08-27', 'B'),
(13, 1, 4, 2, 2, 'nKVUKWgeRA', '2020-08-22', 'A'),
(14, 17, 2, 2, 2, 'RSaYxEvjlQ', '2020-08-23', 'A'),
(19, 28, 1, 3, 3, 'b SyhEXAlS', '2020-08-27', 'A'),
(21, 17, 4, 3, 4, 'tSxtyrTGqU', '2020-08-23', 'A'),
(22, 11, 6, 4, 4, 'dKQgJKvxgb', '2020-08-24', 'B'),
(27, 7, 4, 3, 4, 'XiRkuJljJa', '2020-08-25', 'B'),
(28, 27, 3, 3, 4, 'OxXPgOGHIV', '2020-08-24', 'A'),
(29, 29, 5, 4, 1, 'YOwseNfNdL', '2020-08-25', 'B'),
(30, 13, 2, 2, 4, 'qsoICnXYIO', '2020-08-25', 'A'),
(31, 20, 5, 4, 4, 'cUqxRryxCY', '2020-08-24', 'B'),
(32, 11, 2, 3, 4, 'uSAuKxSVZx', '2020-08-23', 'B'),
(33, 29, 2, 1, 3, 'cDIzHJWPGC', '2020-08-25', 'B'),
(35, 6, 1, 2, 1, 'ZTjOuKOvXJ', '2020-08-23', 'B'),
(36, 3, 4, 3, 5, 'eiFaTUvOzW', '2020-08-23', 'A'),
(37, 5, 2, 4, 1, 'GIfTaEQ Xf', '2020-08-25', 'A'),
(38, 29, 3, 1, 1, 'Fx XJFbkON', '2020-08-23', 'A'),
(39, 20, 1, 4, 2, 'CTalPlpDjU', '2020-08-21', 'B'),
(40, 23, 4, 3, 4, 'MiFzZJWCJp', '2020-08-26', 'A'),
(41, 15, 1, 2, 1, 'SeQxJprGHE', '2020-08-23', 'A'),
(43, 19, 1, 4, 2, 'GlIBJbGtaL', '2020-08-24', 'B'),
(45, 27, 4, 2, 2, 'xOABptNvtc', '2020-08-26', 'A'),
(46, 9, 5, 4, 1, 'zDPY ekoUf', '2020-08-23', 'B'),
(47, 28, 2, 3, 4, 'hNODXlOjsf', '2020-08-26', 'A'),
(50, 3, 3, 3, 1, 'OHbGZMJnjk', '2020-08-24', 'A'),
(51, 23, 5, 4, 2, 'JsqvzDRCnp', '2020-08-26', 'B');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `maestro_curso`
--
ALTER TABLE `maestro_curso`
  ADD PRIMARY KEY (`id_maestro_curso`),
  ADD KEY `macu_id_curso_idx` (`id_curso`),
  ADD KEY `macu_id_grado_idx` (`id_grado`),
  ADD KEY `macu_id_aula_idx` (`id_aula`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `maestro_curso`
--
ALTER TABLE `maestro_curso`
  MODIFY `id_maestro_curso` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de asignacion', AUTO_INCREMENT=52;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `maestro_curso`
--
ALTER TABLE `maestro_curso`
  ADD CONSTRAINT `macu_id_aula` FOREIGN KEY (`id_aula`) REFERENCES `aula` (`id_aula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `macu_id_curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `macu_id_grado` FOREIGN KEY (`id_grado`) REFERENCES `grado` (`id_grado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `macu_id_maestro` FOREIGN KEY (`id_maestro_curso`) REFERENCES `maestro` (`id_maestro`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

