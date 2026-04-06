/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: svcms
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0+deb12u1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `struct_public`
--

DROP TABLE IF EXISTS `struct_public`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `struct_public` (
  `struct_public_id` int(11) NOT NULL AUTO_INCREMENT,
  `header` varchar(200) NOT NULL DEFAULT '',
  `link` text NOT NULL,
  `json` varchar(1024) NOT NULL DEFAULT '' COMMENT 'JSON для crm VUE',
  PRIMARY KEY (`struct_public_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `struct_public`
--

LOCK TABLES `struct_public` WRITE;
/*!40000 ALTER TABLE `struct_public` DISABLE KEYS */;
INSERT INTO `struct_public` VALUES
(1,'Promo','./admin_table.pl?config=promo','{\"header\":\"Promo\",\"value\":\"admin-table\",\"type\":\"vue\",\"child\":[],\"params\":{\"config\":\"promo\"}}'),
(2,'Новости','./admin_table.pl?config=news',''),
(3,'Статичные текстовые страницы','./admin_table.pl?config=content','{\"header\":\"Статичные текстовые страницы\",\"value\":\"admin-table\",\"type\":\"vue\",\"child\":[],\"params\":{\"config\":\"content\"}}'),
(4,'Константы','./admin_table.pl?config=const',''),
(5,'Верхнее меню','./admin_tree.pl?config=top_menu_tree','{\r\n\"header\":\"Верхнее меню\",\r\n\"value\":\"admin-tree\",\r\n\"type\":\"vue\",\r\n\"child\":[],\r\n\"params\":{\"config\":\"top_menu_tree\"}\r\n}'),
(6,'Рубрикатор товаров','./admin_tree.pl?config=rubricator',''),
(7,'Товары (с привязкой к рубрикатору)','./admin_table.pl?config=good',''),
(8,'Статьи','./admin_table.pl?config=article',''),
(9,'Левое меню','./admin_tree.pl?config=left_menu_tree','{\r\n  \"header\":\"Левое меню\",\r\n  \'value\':\"admin-tree\",\r\n  \"type\":\"vue\",\r\n  \"child\":[],\r\n  \"params\":{\"config\":\"left_menu_tree\"}\r\n}'),
(10,'Нижнее меню','./admin_tree.pl?config=bottom_menu','{ \"header\":\"Нижнее меню\", \"value\":\"admin-tree\", \"type\":\"vue\", \"child\":[], \"params\":{\"config\":\"bottom_menu\"} }	'),
(11,'Коды счётчиков','./admin_table.pl?config=js_code',''),
(12,'Мульти-Меню','./admin_table.pl?config=multimenu',''),
(13,'Галерея','./admin_table.pl?config=galery',''),
(14,'Банеры','./admin_table.pl?config=banner',''),
(15,'Файловый менеджер','/manager/plugin_upload/upload2.pl',''),
(16,'Товары (типовые проекты)','./admin_table.pl?config=good_ct1',''),
(17,'Файлы для поисковиков','./admin_table.pl?config=files','{\"header\":\"Файлы для поисковиков\",\"value\":\"admin-table\",\"type\":\"vue\",\"child\":[],\"params\":{\"config\":\"files\"}}'),
(18,'Рубрикатор услуг + услуги','./admin_tree.pl?config=service_rubricator_ct1',''),
(19,'Константы шаблона','./template_const.pl','{\r\n\"header\":\"Константы шаблона\",\r\n\"value\":\"const\",\r\n\"type\":\"vue\",\r\n\"child\":[],\r\n\"params\":{\"config\":\"template_const\"}\r\n}'),
(20,'Система документооборота','./admin_table.pl?config=document_blank',''),
(21,'Слайдер','./admin_tree.pl?config=slider',''),
(22,'<b>Сохраненные данные с форм</b>','./admin_table.pl?config=savedformdata','{\r\n  \"header\":\"Cохранённые данные с форм\",\r\n  \"value\":\"admin-table\",\r\n  \"type\":\"vue\",\r\n  \"child\":[],\r\n  \"params\":{\"config\":\"savedformdata\"}\r\n}'),
(23,'Нижнее меню с подразделами','./admin_tree.pl?config=bottom_menu_tree','{ \"header\":\"Нижнее меню\", \"value\":\"admin-tree\", \"type\":\"vue\", \"child\":[], \"params\":{\"config\":\"bottom_menu_tree\"} }	'),
(24,'Блоки','./admin_table.pl?config=block','');
/*!40000 ALTER TABLE `struct_public` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-18 12:16:58
/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: svcms
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0+deb12u1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `manager_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `full_access` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'доступ во все проекты',
  `role` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Роль, для некоторых проектов',
  PRIMARY KEY (`manager_id`),
  UNIQUE KEY `login` (`login`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5788 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--
-- WHERE:  manager_id=4063

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES
(4063,'demremstroy','Rg3Dw3bOIVzrw',4101,0,0);
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-18 12:16:58
/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: svcms
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0+deb12u1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `manager_menu`
--

DROP TABLE IF EXISTS `manager_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `header` varchar(200) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `manager_id` int(10) unsigned DEFAULT NULL,
  `sort` tinyint(1) NOT NULL DEFAULT 0,
  `photo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `manager_menu_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`manager_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager_menu`
--
-- WHERE:  manager_id=4063

LOCK TABLES `manager_menu` WRITE;
/*!40000 ALTER TABLE `manager_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `manager_menu` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-18 12:16:58
/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: svcms
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0+deb12u1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `project_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `header` varchar(255) CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL,
  `registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `city` int(10) unsigned NOT NULL DEFAULT 0,
  `otrasl_id` int(11) DEFAULT NULL,
  `files_size` varchar(100) CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL DEFAULT '',
  `template_size` varchar(100) CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL DEFAULT '',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `server_type` tinyint(1) NOT NULL DEFAULT 3 COMMENT '1-CGI; 2-FACTCGI; 3-PSGI',
  `comment` varchar(512) NOT NULL DEFAULT '',
  `share_server` tinyint(4) NOT NULL DEFAULT 0,
  `upstream` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT 'откуда upstream-ить файлы',
  `port` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`project_id`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=5827 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--
-- WHERE:  project_id=4101

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES
(4101,'demremstroy.designb2b.ru','','2013-12-23 20:00:00',0,NULL,'14M','1.1M',1,1,'',0,1,0);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_data`
--

DROP TABLE IF EXISTS `form_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `enabled` tinyint(1) DEFAULT 1,
  `name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `form_type` varchar(64) NOT NULL DEFAULT '',
  `remote_addr` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=910824 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_data`
--
-- WHERE:  project_id=4101

LOCK TABLES `form_data` WRITE;
/*!40000 ALTER TABLE `form_data` DISABLE KEYS */;
INSERT INTO `form_data` VALUES
(7722,4101,'2014-07-28 17:34:21',1,'dzagoev dmiti pavlovich','kachmazov@inbox.ru','9888769280','Ремонтно-отделочные работы Выравнивание стен гипсовой штукатуркой\r\n','','217.10.45.22'),
(11202,4101,'2014-10-27 02:27:23',1,'ирина','ninna-m@yandex.ru','89533201756','Ремонтно-отделочные работы \\r\\n','','213.87.134.1'),
(11203,4101,'2014-10-27 02:28:32',1,'ирина','ninna-m@yandex.ru','89533201756','Ремонтно-отделочные работы \\r\\n','','213.87.134.1'),
(11341,4101,'2014-10-29 11:56:23',1,'Маргарян Вардгез Багратович','svetablin62@mail.ru','89058245693','Ремонтно-отделочные работы \\r\\n','','212.76.168.85'),
(11709,4101,'2014-11-08 14:55:35',1,'гусева наталья степановна','natali05.05.65@mail.ru','89371452428','специалист по укладке кафельной плитки\\r\\n','','88.147.199.81'),
(12702,4101,'2014-11-28 09:08:43',1,'арютин владимир александрович','VLADIMIR@MAIL.RU','89879942046','Ремонтно-отделочные работы \\r\\n','','213.87.128.252'),
(13154,4101,'2014-12-08 15:12:16',1,'Оксана','NeretinaO@zavodelastic.com','8555383099','Здравствуйте, закупает ли ваше предприятие нетканые материалы:спанбонд, если да, то какие плотности, ширина полотна,цвет, объемы закупок в месяц? Предлагаем ознакомиться с собственной продукцией нетканых материалов типа \"Спанбонд\" - ООО \"Завод Эластик\" Респ.Татарстан, г.Нижнекамск.Мы производим белый и голубой спанбонд различных плотностей в данный момент - от 25 - 100гр/м2. Для нас важен каждый клиент, ваши пожелания и предложения с удовольствием будут рассмотрены.\\r\\n','','178.206.239.59'),
(13191,4101,'2014-12-09 10:10:15',1,'нураев артур рашидович','artur1985@mail.ru','89878717220','Ремонтно-отделочные работы \\r\\n','','31.13.144.16'),
(14373,4101,'2015-01-04 13:27:02',1,'Комаров С.Н.','dendy.club@inbox.ru','89616824501','Ремонтно-отделочные работы \\r\\n','','88.87.68.131'),
(14487,4101,'2015-01-07 16:05:59',1,'гониволк игорь александрович','igonivolk@mail.ru','9615347988','Ремонтно-отделочные работы \\r\\n','','95.153.179.38'),
(14591,4101,'2015-01-11 15:43:58',1,'Ткачев Виктор Виктрович','viktor.tkachev74@mail.ru','89058987811','Ремонтно-отделочные работы \\r\\n','','83.149.19.198'),
(15490,4101,'2015-01-23 11:33:05',1,'Сидорченко Виктор Яковлевич','viktor.belyy.64@mail.ru','89208527458','Ремонтно-отделочные работы \\r\\n','','37.19.35.45'),
(16187,4101,'2015-02-01 11:20:20',1,'Петрос Аракелян Арменакович','pp9383pp@mail.ru','89164757017','Ремонтно-отделочные работы \\r\\n','','178.69.147.203'),
(16778,4101,'2015-02-09 21:19:27',1,'Нурышев Феликс Вилевич','150478fff@mail.com','+79371613731','Общестроительные работы\\r\\n','','109.187.22.77'),
(16892,4101,'2015-02-11 08:42:19',1,'Ворожцов Алесей Рудольфович','69551a@rambler.ru','89519272204','Ремонтно-отделочные работы \\r\\n','','5.141.193.229, 5.45.255.68'),
(16893,4101,'2015-02-11 09:12:18',1,'Ворнонов Дмитрий Викторович','voronofff2015@yandex.ru','+7 (962) 059-1987','ООО ЛесПлюс предлагает сотрудничество в сфере строительства! Мы бы хотели выступать в лице субподрядчиков!\\r\\n','','85.26.231.79'),
(16939,4101,'2015-02-11 12:27:34',1,'Ворнонов Дмитрий Викторович','voronofff2015@yandex.ru','+7 (962) 059-19-87','Возможно ли сотрудничество с вашей компанией в лице выступающим как субподрядчик?\\r\\n','','85.26.231.79'),
(17983,4101,'2015-02-26 23:42:33',1,'Костя','chirica.costel@mail.ru','89660102035','Я ищу работу в Пензе . Сам ложу плитку любую\\r\\n','','195.16.110.141'),
(18611,4101,'2015-03-08 16:56:57',1,'Литвин Александр Станиславович','lite48@mail.ru','89005967354','Ремонтно-отделочные работы \\r\\n','','81.20.205.221'),
(18941,4101,'2015-03-13 07:34:52',1,'Кунакбаев Амир Исканьярович','kamis55@mail.ru','89610401935','Устройство наружных электрических сетей\\r\\n','','95.110.96.157'),
(19576,4101,'2015-03-21 05:33:20',1,'бубенова ольга александровна','bubenova1976@mail.ru','89059308579','Ремонтно-отделочные работы 2 человека, русские ищем работу штукатур-маляр. опыт имеется по штукатурке, шпаклеванию, окрашиванию, наклеивание обоев. вытяжке стен по маякам.наш возраст 22 и 38 ответсвенность, пунктуальность,умение работать.\\r\\n','','37.193.221.181'),
(20685,4101,'2015-04-07 03:58:29',1,'Слепцов Афанасий Христофорович','afen70@mail.ru','89142610854','Ремонтно-отделочные работы \\r\\n','','91.185.252.4'),
(21037,4101,'2015-04-13 09:35:02',1,'табачнов александр павлович','at070977@mail.ru','9372403480','Ремонтно-отделочные работы .жёсткая кровля.заборы.фасадные работы\\r\\n','','31.29.172.81'),
(22150,4101,'2015-05-02 16:15:02',1,'голотюк юрий геогиевич','senior.golotiuk@yandex.ru','8 906 660-26-91',' КОМПАНИЯ ИЩЕТ РАБОТУ В СТРОИТЕЛЬСТВЕ РЕМОНТ КВАРТИР ЗДАНИЙ А ТАКЖЕ ПОСТРОЙКА ДОМОВ МРАМОР ФАСАДЫ моноли КАЧЕСТВО ГАРАНТИЯ РАБОТАЕтМ ПО ДОГОВОРУ И ПРЕДОПЛАТЕ РФ ЕСТЬ СВОЯ ТЕХНИКА ДО 200 ЧЕЛОВЕК БРИГАДЫ\\r\\n','','109.61.194.196'),
(22227,4101,'2015-05-05 01:19:52',1,'Марючин Александр Сергеевич','ale-maryuchin@yandex.ru','+79118018755','Ремонтно-отделочные работы \\r\\n','','217.66.152.69'),
(22431,4101,'2015-05-08 16:24:05',1,'Бексеитов Алимжан Сансызбаевич','alim-2905@mail.ru','89325316043','Ремонтно-отделочные работы \\r\\n','','82.145.208.131, 82.145.217.222'),
(22596,4101,'2015-05-12 17:52:44',1,'Хамраев Даниил','davron.khamraev@mail.ru','89605132499','Ремонтно-отделочные работы \\r\\n','','2.93.54.86'),
(22597,4101,'2015-05-12 17:53:52',1,'Хамраев Даниил','davron.khamraev@mail.ru','89605132499','Общестроительные работы\\r\\n','','2.93.54.86'),
(22834,4101,'2015-05-16 04:01:25',1,'конищев евгений алексеевич','15elena65@mail.ru','9516101315','сварщик\\r\\n','','5.44.172.95'),
(23317,4101,'2015-05-25 01:21:16',1,'Тодоров Николай Федорович','79nikolay@paduga.ru','89068850814','Ремонтно-отделочные работы \\r\\n','','5.141.215.133'),
(23662,4101,'2015-05-30 07:07:07',1,'Иванов Юрий Григорьевич','ttrakktorr@yandex.ru','8-913-364-72-35','Ремонтно-отделочные работы \\r\\n','','178.186.59.109'),
(23663,4101,'2015-05-30 07:08:05',1,'Иванов Юрий Григорьевич','ttrakktorr@yandex.ru','8-913-364-72-35','Общестроительные работы\\r\\n','','178.186.59.109'),
(24034,4101,'2015-06-06 14:41:08',1,'Багиров Рафик Рафикович','alican_b@mail.ru','+7904 172 39 32','Здраствуйте хотел узнать услуги подрядчика. Я с предложением открываю фирму по строителсво Хотелезбы своми работать\\r\\n','','213.176.231.152'),
(24054,4101,'2015-06-07 03:54:18',1,'Банщиков Иван Иванович','banshikov.2013@mail.ru','+79086451415','Общестроительные работы\\r\\n','','91.226.121.11'),
(24527,4101,'2015-06-16 17:47:53',1,'anna','anti49.4@mail.ru','89633302225','Здравствуйте .Есть 3 участка на продажу по 15 сот в Деревне Новое Кунино с газом ,дорогой и электричество под строительсво коттеджей 5 км от Новгорода .что позволит жить в лесу и работать в Новгороде.тел . Чистый воздух ,лес ,грибы ,наслаждаться жизнью .89633302224 Анна\\r\\n','','178.57.114.58'),
(24685,4101,'2015-06-18 12:28:07',1,'Руслан','info.fiksius@gmail.com','+79380358283','Добрый день! Меня зовут Руслан, я с г. Черкесска. Скажите, с кем я могу поговорить по вопросу земельных участков под строительство недвижимости в нашем регионе?\\r\\n','','178.34.244.92'),
(25268,4101,'2015-06-30 16:51:57',1,'Алексей Полунин','apolunin1@yandex.ru','+79313703992','Общестроительные работы Требуется строительство площадки для стоянки автомобилей (50-100 шт.) со щебеночным покрытием, интересуют цены и сроки.\\r\\n','','93.153.175.94'),
(25561,4101,'2015-07-06 14:29:25',1,'Менеджер Юлия','info@altablock.ru','+79263055505','КОММЕРЧЕСКОЕ ПРЕДЛОЖЕНИЕ ООО «АЛЬТА-БЛОК» - компания-производитель газобетонных блоков. Газобетон – это новейший строительный материал, представляет собой вид ячеистого бетона, обладающий множеством преимуществ: - высокая шумо- и теплоизоляция; - высокая морозостойкость; - огнеустойчивость; - экологичность; - точность геометрических форм; - малый вес; - легкость обработки; - не подвержен гниению, воздействию насекомых и грызунов. Преимущества газобетона позволяют построить надежный дом, способный сохранить все свои характеристики в течение долгого времени. Продукция сертифицирована. Наш завод предлагает стеновые и перегородочные газобетонные блоки марки плотности D500 различных размеров: - 600х295х195; - 600х295х245; - 600х295х145; - 600х295х95 и другие. Для торгующих организаций и при больших объемах предлагаем цену 2 950 руб. за кубометр. Мы открыты для диалога, готовы обсудить все условия. Местонахождение производства и склада: Московская обл., г.Серпухов, ул.Полевая, д.1 Местонахождение офиса: Московская обл., г.Серпухов, переулок Центральный, д.29. Стройте легко, быстро и недорого вместе с нами! Мы стремимся к долгосрочному и взаимовыгодному сотрудничеству и предоставляем нашим клиентам гибкую систему скидок. Телефоны для связи: 8-926-305-55-05, 8-495-255-28-25.\\r\\n','','188.164.136.117'),
(25795,4101,'2015-07-09 12:47:26',1,'Оксана Евгеньевна','prom-info2014@mail.ru','','Добрый день! Наша компания изготовляет и реализует балку опалубки перекрытий и комплектующие. Предлагаем Вашему вниманию коммерческое предложение с прайс-листом.\\r\\n','','195.16.111.96'),
(26629,4101,'2015-07-23 12:37:18',1,'Биченова Валерия Викторовна','lerik555@inbox.ru','+79280122966','Добрый день. Ваше объявление было на сайте предоставления вакансий среди предложений на вакансию управляющий. Эта вакансия актуальна?\\r\\n','','46.63.151.249'),
(26750,4101,'2015-07-25 12:55:56',1,'Миронов Евгений Александрович','mironovea81@yandex.ru','89372443409','Ремонтно-отделочные работы \\r\\n','','188.232.59.245, 82.145.208.130'),
(27222,4101,'2015-08-02 11:32:49',1,'Бодаевский Владимир Александрович','bodaevskiy08@mail.ru','89833064213','Устройство наружных сетей водоснабжения и канализации\\r\\n','','37.192.253.34'),
(27223,4101,'2015-08-02 11:34:19',1,'Бодаевский Владимир Александрович','bodaevskiy08@mail.ru','89833064213','Общестроительные работы\\r\\n','','37.192.253.34'),
(27741,4101,'2015-08-10 08:30:47',1,'Кикава Эдуард Ревазович','kikavaviktoriy2009@gmail.com','89224001712','Здравствуйте. Имеются ли вакансии на ремонтно- отделочные работы? Спасибо!\\r\\n','','83.149.35.129'),
(29510,4101,'2015-09-02 14:38:27',1,'1','1@mail.ru','2968025','Размещаете рекламу в Яндекс Директ? Бесплатно внедрю 5 нововведений, которые помогут сократить затраты на рекламу до 40% и помогут стабильно привлекать по 3-5 заявок в день! Если интересно сократить расходы на Директ и увеличить число заявок, закажите бесплатный аудит вашей рекламной компании до 10 сентября по телефону (391) 296-80-25\\r\\n','','171.33.250.249'),
(30300,4101,'2015-09-11 11:33:27',1,'Тузов А.А.','aleks-tuzov@yandex.ru','8-9217783377','Устройство наружных сетей водоснабжения и канализации в поселке Молькино Краснодарского края\\r\\n','','37.77.135.2'),
(34451,4101,'2015-10-29 13:41:21',1,'Виталий','witala228@yandex.ru','8 964 973-82-90','Доброго времени суток! Вопрос такой возможно ли сотрудничество по ремонтным и строительным работам?\\r\\n','','62.106.106.221'),
(35784,4101,'2015-11-17 09:53:24',1,'Получаете с Яндекс Директа меньше 5 заявок в день? Бесплатно внедрю 5 нововведений, которые помогут сократить затраты на рекламу до 40% и помогут стабильно привлекать по 5 заявок в день! Если интересно пишите на почту прямо сейчас s1slv@yandex.ru (Количес','s@yandex.ru','000000000','Получаете с Яндекс Директа меньше 5 заявок в день? Бесплатно внедрю 5 нововведений, которые помогут сократить затраты на рекламу до 40% и помогут стабильно привлекать по 5 заявок в день! Если интересно пишите на почту прямо сейчас s1slv@yandex.ru (Количество бесплатных мест ограничено!)\\r\\n','','195.218.182.94'),
(35852,4101,'2015-11-17 17:37:25',1,'гулиев али аслан оглы','kuzia_l@mail.ru','89247728805','Общестроительные работы\\r\\n','','85.115.243.124'),
(36124,4101,'2015-11-20 18:23:00',1,'Адиев Рустам Абдулвахидович','rustam5630x@mail.ru','89382000955','Ремонтно-отделочные работы .Мастера отделочники. Опыт работы 8лет.Нанесению декоративных покрытий.Лепнина.Озолочение.Шпаклевка.Покраска.Ламинат.ГКЛ.Любой сложности.Качество гарантируем.Профессионалы!\\r\\n','','85.26.183.215'),
(36184,4101,'2015-11-22 08:55:45',1,'белоусова наталья борисовна','ily.00@bk.ru','89233062718','Ремонтно-отделочные работы \\r\\n','','46.43.217.125'),
(36328,4101,'2015-11-24 12:06:00',1,'Садуллаев Файзулла Болтаевич','shoxa269@gmail.com','+79662939329','Ремонтно-отделочные работы \\r\\n','','217.118.64.62'),
(38058,4101,'2015-12-16 12:06:53',1,'Меликян Рафик Геворгович','rafik.melikian@yandex.ru','8 906 619-90-61','Ремонтно-отделочные работы \\r\\n','','2.94.139.43'),
(38101,4101,'2015-12-16 21:01:44',1,'Безгинова Елена','bezginova2012@yandex.ru','89081374988','Здравствуйте.Мне бы хотелось узнать .Имеется ли у Вас вакансия маляра. Спасибо\\r\\n','','109.106.141.173'),
(39589,4101,'2016-01-13 09:06:00',1,'Андрей','Lebed7983@mail.ru','89632551371','Предлагаем услуги буронабивных свай\\r\\n','','89.105.158.248'),
(39790,4101,'2016-01-15 10:47:54',1,'Оганезов Александр Владимирович','89187777771@mail.ru','89187777771','Меня интересует, Вы занимаетесь строительными работами в г, Новоалександрвск Ставропольского края, и обьязательно с НДС ?\\r\\n','','77.73.48.30'),
(39969,4101,'2016-01-18 11:50:05',1,'Артём','220-365@mail.ru','+79674450365','Кто поставляет вашим клиентам наружную рекламу?\\r\\n','','93.124.123.129'),
(40812,4101,'2016-01-27 12:18:08',1,'Алешина Татьяна Александровна','aljoshina83@mail.ru','8 920 886-10-20','Здравствуйте! В вашей строительной компании есть вакансия инженер-сметчик?\\r\\n','','62.148.144.113'),
(40969,4101,'2016-01-28 15:06:42',1,'Сергей','v7group@yandex.ru','89648534214','Доброго дня. Рекомендую сменить специалиста по ведению рекламной компании в яндексе. Лишние деньги теряете. Подробности могу пояснить. Успехов в бизнесе.\\r\\n','','217.118.90.239'),
(41186,4101,'2016-01-30 17:51:06',1,'давтян марзпет дживанович','marzpet-davtian@mail.ru','89130840369','Ремонтно-отделочные работы \\r\\n','','176.50.209.68'),
(41905,4101,'2016-02-07 17:44:05',1,'Трунилов Ростислав Сергеевич','trunilov.1994@mail.ru','89101944643','не желаете ли приобрести земельные участки под строительство ИЖС в Ярославской области, рядом с участками протекает река Волга, проведены свет, газ, вода\\r\\n','','46.228.108.165'),
(42699,4101,'2016-02-15 20:23:45',1,'Сысолятин','ann010160@ya.ru','89519296834','Ремонтно-отделочные работы  коммерческое помещение ООО\\r\\n','','128.73.63.109'),
(42725,4101,'2016-02-16 01:12:06',1,'Алексей Савин','alexrw@spartak.ru','','Надоело сливать впустую рекламный бюджет в Яндекс Директ? Могу выполнить профессиональную настройку Вашей кампании!\\r\\n','','5.164.221.103'),
(47291,4101,'2016-04-01 10:34:37',1,'Елена','wolna@inbox.ru','89177444200','вы показываетесь по всей россии, настройте нормально директ, сливаете деньги\\r\\n','','37.122.35.175, 37.140.189.224'),
(48124,4101,'2016-04-10 13:30:40',1,'Гавриловский Дмитрий Александрович','Dimastroika83@mail.ru','+79656932885','Ремонтно-отделочные работы \\r\\n','','176.212.230.41'),
(50654,4101,'2016-04-30 15:55:34',1,'александр','alexsandrbabin@mail.ru','89049623984','Ремонтно-отделочные работы \\r\\n','','91.233.94.9'),
(55487,4101,'2016-06-07 11:46:06',1,'Кадримбекова Данна','danna09122010@gmail.com','9681246929','продам доску обрезную, 1,2 сорт,сосна цена 4800 р.м3 под заказ, крупный опт, минимальная партия вагон или еврофура. доставка по всей России и СНГ. мелкий опт по цене 5900 р.м3 Надеемся на плодотворное сотрудничество,в наш холдинг входит четыре компании-лесозаготовительное,производственное, предприятие грузоотправитель и брокерская компания. Мы работаем под брендом \" Строймаш\".\\r\\n','','37.140.123.183'),
(55488,4101,'2016-06-07 11:46:23',1,'Кадримбекова Данна','danna09122010@gmail.com','9681246929','продам доску обрезную, 1,2 сорт,сосна цена 4800 р.м3 под заказ, крупный опт, минимальная партия вагон или еврофура. доставка по всей России и СНГ. мелкий опт по цене 5900 р.м3 Надеемся на плодотворное сотрудничество,в наш холдинг входит четыре компании-лесозаготовительное,производственное, предприятие грузоотправитель и брокерская компания. Мы работаем под брендом \" Строймаш\".\\r\\n','','37.140.123.183'),
(77677,4101,'2016-12-26 18:53:55',1,'Алексей','www.megail.com@mail.ru','','Здравствуйте, скажите пожалуйста какие у вас требования к работнику: стаж, опыт работы, и в том же духе\\r\\n','','134.255.147.23'),
(84780,4101,'2017-02-10 18:34:38',1,'AndrewmeaLl','andrewsamk@mail.ru','84693471761','Фирма работает с конструированием, конструированием и монтажом очистительных конструкций «Танк» (септик). &lt;a href=http://cinema-24.online/hd-filmy/&gt;Фильмы смотреть онлайн&lt;/a&gt;\\r\\n','','193.169.144.42'),
(84973,4101,'2017-02-10 21:04:53',1,'cltofami','hamg66hd@mail.ru','83249577374','patronizing rra vibrates mauled &lt;a href=\"http://krankheiten0vpya.xyz\"&gt;isahe&lt;/a&gt; odd guessed &lt;a href=http://mygesundheitadg9g.xyz&gt;rmzofxlz&lt;/a&gt; plumes ratan http://gesundheitonline74o0m.xyz consisted trust fruitless\\r\\n','','93.182.171.4'),
(84993,4101,'2017-02-10 21:23:19',1,'AndroidScem','androidsergeaw@mail.ru','83417323953','Вот-вот наступит Новый год – самый долгожданный для многих праздник. Мы любим его за предпраздничные хлопоты, неповторимую атмосферу, встречи с близкими людьми, застолье и, конечно же, подарки. Мы, в свою очередь, подготовили подборку приложений, которые помогут вам во всей этой новогодней суете. &lt;a href=http://androids-games-apps.blogspot.ru/&gt;&lt;img&gt;http://www.playcast.ru/uploads/2014/12/31/11378966.png&lt;/img&gt;&lt;/a&gt; Для всех любителей анимированных обоев рекомендуем также обратить внимание на «живые» новогодние обои с красивой елкой, а также с эффектным 3D-таймером обратного отсчета времени до Нового 2017 года. &lt;a href=http://androids-games-apps.blogspot.ru/&gt;&lt;img&gt;http://https://screenshots.en.sftcdn.net/en/scrn/3332000/3332373/2011-11-03-03-700x437.jpg&lt;/img&gt;&lt;/a&gt; Вот такой получился у нас набор приложений к Новому году. А какие программы пригодятся к празднику по вашему мнению? &lt;a href=http://androids-games-apps.blogspot.ru/&gt;Все Android-приложения&lt;/a&gt;\\r\\n','','85.192.162.173'),
(85110,4101,'2017-02-10 22:57:04',1,'Sckoktchisa','sckoktaniny@mail.ru','84173188433','buy diflucan http://file24.tk/buy-diflucan.html &lt;a href=http://file24.tk/buy-diflucan.html&gt;buy diflucan&lt;/a&gt;\\r\\n','','185.2.101.31'),
(520593,4101,'2020-12-04 09:04:50',1,'ООО \"Техно-Р\" г. Калуга','ldpr1000@yandex.ru','89206176175','Добрый день! Имеется большая задолженность за ЖКУ по помещениям г. Калуга ул. Пролетарская, 40 в сумме 67 902,16 руб. по состоянию на 01.12.2020. Вынуждены 07.12.2020 обратиться в суд. Просьба урегулировать вопрос с задолженностью. С уважением, УК ООО ТЕХНО-Р\\r\\n','','93.80.4.151'),
(598196,4101,'2021-08-04 10:23:36',1,'Анна Каменщикова','kamenschikovaanna@yandex.ru','','Добрый день ,бухгалтер тк афоня ,я вам на почту писала .помочь нам с требование с налоговой .Заранее благодарим за понимание.\\r\\n','','178.252.111.60'),
(607422,4101,'2021-09-21 12:34:30',1,'Передненко Алексей Олегович','a.perednenko@rocketjump.ru','89778241142','Необходимо построить стену из гипсокартона, сделать дверной проём, поставить дверь и перенести эл.щитки на другую сторону стены. Более подробно могу показать на месте.\\r\\n','','195.91.154.244');
/*!40000 ALTER TABLE `form_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portfolio`
--

DROP TABLE IF EXISTS `portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `portfolio` (
  `portfolio_id` int(11) NOT NULL AUTO_INCREMENT,
  `header` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(255) NOT NULL DEFAULT '',
  `parent_id` int(11) DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `anons` text NOT NULL,
  `body` text NOT NULL,
  `photo` varchar(20) NOT NULL DEFAULT '',
  `enabled` tinyint(1) DEFAULT 1,
  `specpredl` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`portfolio_id`),
  KEY `parent_id` (`parent_id`),
  KEY `path` (`path`),
  KEY `enabled` (`enabled`),
  KEY `specpredl` (`specpredl`),
  KEY `project_id` (`project_id`,`path`),
  CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `portfolio` (`portfolio_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `portfolio_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3902 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portfolio`
--
-- WHERE:  project_id=4101

LOCK TABLES `portfolio` WRITE;
/*!40000 ALTER TABLE `portfolio` DISABLE KEYS */;
INSERT INTO `portfolio` VALUES
(259,'Проект','',NULL,259,4101,'','<p style=\"text-align: justify;\">Группа компаний &laquo;Демремстрой&raquo; - это профессионал в организации управления процессами поставок строительных материалов</p>','1389705891_1.jpg',1,1),
(260,'Проект','',NULL,260,4101,'','<p style=\"text-align: justify;\">Группа компаний &laquo;Демремстрой&raquo; - это профессионал в организации управления процессами поставок строительных материалов</p>','1389705905_1.jpg',1,1),
(261,'Проект','',NULL,261,4101,'','<p style=\"text-align: justify;\">Группа компаний &laquo;Демремстрой&raquo; - это профессионал в организации управления процессами поставок строительных материалов</p>','1389705934_1.jpg',1,1),
(262,'Проект','',NULL,262,4101,'','<p style=\"text-align: justify;\">Группа компаний &laquo;Демремстрой&raquo; - это профессионал в организации управления процессами поставок строительных материалов</p>','1389705951_1.jpg',1,1),
(263,'Проект','',NULL,263,4101,'','<p style=\"text-align: justify;\">Группа компаний &laquo;Демремстрой&raquo; - это профессионал в организации управления процессами поставок строительных материалов</p>','1389706032_1.jpg',1,0),
(264,'Проект','',NULL,264,4101,'','<p style=\"text-align: justify;\">Группа компаний &laquo;Демремстрой&raquo; - это профессионал в организации управления процессами поставок строительных материалов</p>','1389706199_1.jpg',1,0);
/*!40000 ALTER TABLE `portfolio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `session` (
  `session_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `auth_id` int(11) NOT NULL DEFAULT 0,
  `registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `session_key` varchar(200) NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `project_id` (`project_id`),
  KEY `project_id_2` (`project_id`,`auth_id`,`session_key`),
  CONSTRAINT `session_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31494 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--
-- WHERE:  project_id=4101

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domain`
--

DROP TABLE IF EXISTS `domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `domain` (
  `domain_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(200) CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL DEFAULT '',
  `template_id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(10) unsigned DEFAULT NULL,
  `dns_serial` bigint(20) unsigned NOT NULL DEFAULT 2017050915,
  `dns_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `is_ssl` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '0 - not ssl ; 1 - paid_ssl ; 3 - lets encrypt',
  `lets_encrypt_status` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `paid_till` date NOT NULL DEFAULT '0000-00-00',
  `last_paid_till_update` date NOT NULL DEFAULT '0000-00-00',
  `our_domain` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Домен у нас в reg.ru',
  `not_cache_nginx` tinyint(4) NOT NULL DEFAULT 0,
  `server_type` tinyint(1) NOT NULL DEFAULT 3 COMMENT '1-CGI; 2-FACTCGI; 3-PSGI',
  `need_clean_cache` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Нужно очистить кэш',
  `is_adaptive` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1 - да ; 2 - нет',
  `not_crm_server` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'не создавать его в списке доменов на сервере',
  `dkim_enabled` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `port` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`domain_id`),
  UNIQUE KEY `domain` (`domain`),
  KEY `project_id` (`project_id`),
  KEY `dns_enabled` (`dns_enabled`),
  KEY `need_clean_cache` (`need_clean_cache`)
) ENGINE=InnoDB AUTO_INCREMENT=9681 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domain`
--
-- WHERE:  project_id=4101

LOCK TABLES `domain` WRITE;
/*!40000 ALTER TABLE `domain` DISABLE KEYS */;
INSERT INTO `domain` VALUES
(7735,'xn--d1acaqnboncjl.xn--p1ai',761,4101,2025122315,1,2,5,'2026-11-28','2026-02-12',0,0,1,0,1,0,0,0,32147);
/*!40000 ALTER TABLE `domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_struct_public`
--

DROP TABLE IF EXISTS `project_struct_public`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_struct_public` (
  `project_id` int(11) NOT NULL DEFAULT 0,
  `struct_public_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`project_id`,`struct_public_id`),
  KEY `struct_public_id` (`struct_public_id`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_struct_public`
--
-- WHERE:  project_id=4101

LOCK TABLES `project_struct_public` WRITE;
/*!40000 ALTER TABLE `project_struct_public` DISABLE KEYS */;
INSERT INTO `project_struct_public` VALUES
(4101,1),
(4101,3),
(4101,5),
(4101,17),
(4101,19);
/*!40000 ALTER TABLE `project_struct_public` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capture`
--

DROP TABLE IF EXISTS `capture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `capture` (
  `capture_id` int(11) NOT NULL AUTO_INCREMENT,
  `str` varchar(10) NOT NULL DEFAULT '',
  `str_key` varchar(32) NOT NULL DEFAULT '',
  `registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`capture_id`),
  KEY `project_id` (`project_id`),
  KEY `registered` (`registered`),
  KEY `str_key` (`str_key`),
  CONSTRAINT `capture_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10750435 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capture`
--
-- WHERE:  project_id=4101

LOCK TABLES `capture` WRITE;
/*!40000 ALTER TABLE `capture` DISABLE KEYS */;
INSERT INTO `capture` VALUES
(4438794,'6+3=','45c48cce2e2d7fbdea1afc51c7c6ad26','2025-12-23 16:58:33',4101),
(4438911,'8+6=','aab3238922bcc25a6f606eb525ffdc56','2025-12-23 16:59:32',4101),
(4438925,'2+3=','e4da3b7fbbce2345d7772b0674a318d5','2025-12-23 16:59:40',4101),
(4446944,'8+3=','6512bd43d9caa6e02c990b0a82652dca','2025-12-23 18:19:16',4101),
(4452720,'9+3=','c20ad4d76fe97759aa27a0c99bff6710','2025-12-23 19:20:40',4101),
(4522665,'8+3=','6512bd43d9caa6e02c990b0a82652dca','2025-12-24 06:08:48',4101),
(4557381,'7+4=','6512bd43d9caa6e02c990b0a82652dca','2025-12-24 10:50:22',4101),
(4561653,'2+1=','eccbc87e4b5ce2fe28308fd9f2a7baf3','2025-12-24 11:19:36',4101),
(4561678,'2+6=','c9f0f895fb98ab9159f51fd0297e236d','2025-12-24 11:19:45',4101),
(4561682,'5+2=','8f14e45fceea167a5a36dedd4bea2543','2025-12-24 11:19:46',4101),
(4635209,'5+4=','45c48cce2e2d7fbdea1afc51c7c6ad26','2025-12-25 04:21:59',4101),
(4635235,'8+9=','70efdf2ec9b086079795c442636b55fb','2025-12-25 04:22:15',4101),
(4635236,'4+7=','6512bd43d9caa6e02c990b0a82652dca','2025-12-25 04:22:18',4101),
(4635239,'3+9=','c20ad4d76fe97759aa27a0c99bff6710','2025-12-25 04:22:23',4101),
(4635242,'9+1=','d3d9446802a44259755d38e6d163e820','2025-12-25 04:22:28',4101),
(4635245,'5+5=','d3d9446802a44259755d38e6d163e820','2025-12-25 04:22:33',4101),
(4635249,'6+6=','c20ad4d76fe97759aa27a0c99bff6710','2025-12-25 04:22:43',4101),
(4635255,'8+8=','c74d97b01eae257e44aa9d5bade97baf','2025-12-25 04:22:52',4101),
(4635257,'4+3=','8f14e45fceea167a5a36dedd4bea2543','2025-12-25 04:22:54',4101),
(4635267,'2+8=','d3d9446802a44259755d38e6d163e820','2025-12-25 04:22:59',4101),
(4635271,'1+8=','45c48cce2e2d7fbdea1afc51c7c6ad26','2025-12-25 04:23:04',4101),
(4635291,'3+6=','45c48cce2e2d7fbdea1afc51c7c6ad26','2025-12-25 04:23:15',4101),
(4635316,'3+9=','c20ad4d76fe97759aa27a0c99bff6710','2025-12-25 04:23:31',4101),
(4635370,'5+5=','d3d9446802a44259755d38e6d163e820','2025-12-25 04:24:12',4101),
(4648911,'1+1=','c81e728d9d4c2f636f067f89cc14862c','2025-12-25 07:19:34',4101),
(4751732,'7+3=','d3d9446802a44259755d38e6d163e820','2025-12-26 20:51:20',4101),
(4751741,'4+6=','d3d9446802a44259755d38e6d163e820','2025-12-26 20:51:28',4101),
(4751750,'5+2=','8f14e45fceea167a5a36dedd4bea2543','2025-12-26 20:51:41',4101),
(4751756,'1+4=','e4da3b7fbbce2345d7772b0674a318d5','2025-12-26 20:51:51',4101),
(4751761,'5+7=','c20ad4d76fe97759aa27a0c99bff6710','2025-12-26 20:52:02',4101),
(4751763,'6+1=','8f14e45fceea167a5a36dedd4bea2543','2025-12-26 20:52:07',4101),
(4751765,'3+1=','a87ff679a2f3e71d9181a67b7542122c','2025-12-26 20:52:10',4101),
(5003379,'9+3=','c20ad4d76fe97759aa27a0c99bff6710','2026-01-04 03:46:20',4101),
(5003401,'2+7=','45c48cce2e2d7fbdea1afc51c7c6ad26','2026-01-04 03:46:45',4101),
(5003402,'3+7=','d3d9446802a44259755d38e6d163e820','2026-01-04 03:46:45',4101),
(5003416,'2+7=','45c48cce2e2d7fbdea1afc51c7c6ad26','2026-01-04 03:47:05',4101),
(5003422,'7+5=','c20ad4d76fe97759aa27a0c99bff6710','2026-01-04 03:47:10',4101),
(5003433,'1+4=','e4da3b7fbbce2345d7772b0674a318d5','2026-01-04 03:47:27',4101),
(5003440,'9+9=','6f4922f45568161a8cdf4ad2299f6d23','2026-01-04 03:47:46',4101),
(5003443,'3+3=','1679091c5a880faf6fb5e6087eb1b2dc','2026-01-04 03:47:50',4101),
(5003527,'7+7=','aab3238922bcc25a6f606eb525ffdc56','2026-01-04 03:49:23',4101),
(5207911,'6+5=','6512bd43d9caa6e02c990b0a82652dca','2026-01-06 12:11:41',4101),
(5207935,'6+1=','8f14e45fceea167a5a36dedd4bea2543','2026-01-06 12:11:53',4101),
(5207939,'8+8=','c74d97b01eae257e44aa9d5bade97baf','2026-01-06 12:11:55',4101),
(5256715,'5+1=','1679091c5a880faf6fb5e6087eb1b2dc','2026-01-06 19:53:32',4101),
(5595729,'9+9=','6f4922f45568161a8cdf4ad2299f6d23','2026-01-09 04:31:20',4101),
(5655053,'6+5=','6512bd43d9caa6e02c990b0a82652dca','2026-01-09 12:58:16',4101),
(5655091,'7+1=','c9f0f895fb98ab9159f51fd0297e236d','2026-01-09 12:58:41',4101),
(5665090,'2+4=','1679091c5a880faf6fb5e6087eb1b2dc','2026-01-09 14:11:10',4101),
(5679744,'3+7=','d3d9446802a44259755d38e6d163e820','2026-01-09 16:09:52',4101),
(5727067,'3+2=','e4da3b7fbbce2345d7772b0674a318d5','2026-01-09 22:47:53',4101),
(5765158,'1+2=','eccbc87e4b5ce2fe28308fd9f2a7baf3','2026-01-10 05:18:43',4101),
(5795714,'8+2=','d3d9446802a44259755d38e6d163e820','2026-01-10 11:42:15',4101),
(5836684,'7+5=','c20ad4d76fe97759aa27a0c99bff6710','2026-01-10 18:14:18',4101),
(6066954,'1+5=','1679091c5a880faf6fb5e6087eb1b2dc','2026-01-12 11:48:13',4101),
(6067101,'6+5=','6512bd43d9caa6e02c990b0a82652dca','2026-01-12 11:49:06',4101),
(6605914,'4+3=','8f14e45fceea167a5a36dedd4bea2543','2026-01-15 13:11:59',4101),
(6605933,'2+3=','e4da3b7fbbce2345d7772b0674a318d5','2026-01-15 13:12:07',4101),
(7073179,'7+7=','aab3238922bcc25a6f606eb525ffdc56','2026-01-18 03:16:33',4101),
(7487816,'4+5=','45c48cce2e2d7fbdea1afc51c7c6ad26','2026-01-20 09:44:39',4101),
(7532962,'1+9=','d3d9446802a44259755d38e6d163e820','2026-01-20 13:40:26',4101),
(7579230,'3+4=','8f14e45fceea167a5a36dedd4bea2543','2026-01-20 19:21:12',4101),
(7663152,'8+3=','6512bd43d9caa6e02c990b0a82652dca','2026-01-21 07:17:21',4101),
(7684525,'4+7=','6512bd43d9caa6e02c990b0a82652dca','2026-01-21 09:13:03',4101),
(7684596,'7+9=','c74d97b01eae257e44aa9d5bade97baf','2026-01-21 09:13:19',4101),
(7684645,'2+9=','6512bd43d9caa6e02c990b0a82652dca','2026-01-21 09:13:29',4101),
(7684916,'7+8=','9bf31c7ff062936a96d3c8bd1f8f2ff3','2026-01-21 09:14:47',4101),
(7684951,'3+3=','1679091c5a880faf6fb5e6087eb1b2dc','2026-01-21 09:14:56',4101),
(7685021,'5+6=','6512bd43d9caa6e02c990b0a82652dca','2026-01-21 09:15:12',4101),
(7685031,'1+4=','e4da3b7fbbce2345d7772b0674a318d5','2026-01-21 09:15:14',4101),
(7685079,'7+3=','d3d9446802a44259755d38e6d163e820','2026-01-21 09:15:28',4101),
(7685091,'4+8=','c20ad4d76fe97759aa27a0c99bff6710','2026-01-21 09:15:31',4101),
(7685117,'9+8=','70efdf2ec9b086079795c442636b55fb','2026-01-21 09:15:38',4101),
(7685121,'2+1=','eccbc87e4b5ce2fe28308fd9f2a7baf3','2026-01-21 09:15:41',4101),
(7685195,'7+8=','9bf31c7ff062936a96d3c8bd1f8f2ff3','2026-01-21 09:16:00',4101),
(8294346,'7+8=','9bf31c7ff062936a96d3c8bd1f8f2ff3','2026-01-24 13:40:28',4101),
(8294527,'7+4=','6512bd43d9caa6e02c990b0a82652dca','2026-01-24 13:41:54',4101),
(8294542,'9+4=','c51ce410c124a10e0db5e4b97fc2af39','2026-01-24 13:42:00',4101),
(8294558,'1+1=','c81e728d9d4c2f636f067f89cc14862c','2026-01-24 13:42:06',4101),
(8294577,'4+4=','c9f0f895fb98ab9159f51fd0297e236d','2026-01-24 13:42:12',4101),
(8294588,'4+3=','8f14e45fceea167a5a36dedd4bea2543','2026-01-24 13:42:18',4101),
(8294590,'2+9=','6512bd43d9caa6e02c990b0a82652dca','2026-01-24 13:42:19',4101),
(8988814,'7+1=','c9f0f895fb98ab9159f51fd0297e236d','2026-01-28 09:22:29',4101),
(8988818,'9+2=','6512bd43d9caa6e02c990b0a82652dca','2026-01-28 09:22:29',4101),
(9452569,'8+2=','d3d9446802a44259755d38e6d163e820','2026-01-31 18:00:53',4101),
(9463888,'2+5=','8f14e45fceea167a5a36dedd4bea2543','2026-02-01 02:13:47',4101),
(9464725,'3+9=','c20ad4d76fe97759aa27a0c99bff6710','2026-02-01 03:00:09',4101),
(9464726,'8+7=','9bf31c7ff062936a96d3c8bd1f8f2ff3','2026-02-01 03:00:12',4101),
(9464727,'1+8=','45c48cce2e2d7fbdea1afc51c7c6ad26','2026-02-01 03:00:14',4101),
(9464728,'7+6=','c51ce410c124a10e0db5e4b97fc2af39','2026-02-01 03:00:15',4101),
(9464729,'9+9=','6f4922f45568161a8cdf4ad2299f6d23','2026-02-01 03:00:16',4101),
(9464730,'8+9=','70efdf2ec9b086079795c442636b55fb','2026-02-01 03:00:18',4101),
(9464732,'8+5=','c51ce410c124a10e0db5e4b97fc2af39','2026-02-01 03:00:20',4101),
(9464733,'1+3=','a87ff679a2f3e71d9181a67b7542122c','2026-02-01 03:00:20',4101),
(9464734,'4+9=','c51ce410c124a10e0db5e4b97fc2af39','2026-02-01 03:00:20',4101),
(9464736,'7+6=','c51ce410c124a10e0db5e4b97fc2af39','2026-02-01 03:01:08',4101),
(9464737,'5+6=','6512bd43d9caa6e02c990b0a82652dca','2026-02-01 03:01:11',4101),
(9464738,'1+5=','1679091c5a880faf6fb5e6087eb1b2dc','2026-02-01 03:01:12',4101),
(9464739,'4+6=','d3d9446802a44259755d38e6d163e820','2026-02-01 03:01:15',4101),
(9464745,'3+9=','c20ad4d76fe97759aa27a0c99bff6710','2026-02-01 03:01:15',4101),
(9464746,'4+3=','8f14e45fceea167a5a36dedd4bea2543','2026-02-01 03:01:18',4101),
(9464750,'8+9=','70efdf2ec9b086079795c442636b55fb','2026-02-01 03:01:29',4101),
(9464751,'8+2=','d3d9446802a44259755d38e6d163e820','2026-02-01 03:01:34',4101),
(9464752,'5+3=','c9f0f895fb98ab9159f51fd0297e236d','2026-02-01 03:01:39',4101),
(9464753,'3+8=','6512bd43d9caa6e02c990b0a82652dca','2026-02-01 03:01:40',4101),
(9464754,'5+8=','c51ce410c124a10e0db5e4b97fc2af39','2026-02-01 03:01:48',4101),
(9464760,'1+7=','c9f0f895fb98ab9159f51fd0297e236d','2026-02-01 03:01:57',4101),
(9464766,'3+8=','6512bd43d9caa6e02c990b0a82652dca','2026-02-01 03:02:05',4101),
(9464767,'4+8=','c20ad4d76fe97759aa27a0c99bff6710','2026-02-01 03:02:14',4101),
(9478754,'9+2=','6512bd43d9caa6e02c990b0a82652dca','2026-02-01 10:06:23',4101),
(9498539,'4+4=','c9f0f895fb98ab9159f51fd0297e236d','2026-02-01 17:33:40',4101),
(9596467,'1+9=','d3d9446802a44259755d38e6d163e820','2026-02-03 04:29:05',4101),
(9657551,'6+7=','c51ce410c124a10e0db5e4b97fc2af39','2026-02-03 19:22:28',4101),
(9657553,'9+7=','c74d97b01eae257e44aa9d5bade97baf','2026-02-03 19:22:28',4101),
(9789415,'1+5=','1679091c5a880faf6fb5e6087eb1b2dc','2026-02-05 11:42:01',4101),
(9880677,'6+2=','c9f0f895fb98ab9159f51fd0297e236d','2026-02-06 15:33:48',4101),
(9891689,'9+7=','c74d97b01eae257e44aa9d5bade97baf','2026-02-06 19:29:53',4101),
(9891706,'9+3=','c20ad4d76fe97759aa27a0c99bff6710','2026-02-06 19:30:10',4101),
(9891726,'6+2=','c9f0f895fb98ab9159f51fd0297e236d','2026-02-06 19:30:29',4101),
(9891747,'1+8=','45c48cce2e2d7fbdea1afc51c7c6ad26','2026-02-06 19:30:51',4101),
(9891769,'1+4=','e4da3b7fbbce2345d7772b0674a318d5','2026-02-06 19:31:25',4101),
(9891792,'2+9=','6512bd43d9caa6e02c990b0a82652dca','2026-02-06 19:31:49',4101),
(9891847,'7+3=','d3d9446802a44259755d38e6d163e820','2026-02-06 19:32:47',4101),
(9891850,'7+2=','45c48cce2e2d7fbdea1afc51c7c6ad26','2026-02-06 19:33:05',4101),
(9891853,'4+1=','e4da3b7fbbce2345d7772b0674a318d5','2026-02-06 19:33:08',4101),
(9893502,'5+1=','1679091c5a880faf6fb5e6087eb1b2dc','2026-02-06 20:20:23',4101),
(9893617,'5+8=','c51ce410c124a10e0db5e4b97fc2af39','2026-02-06 20:21:55',4101),
(9893618,'8+6=','aab3238922bcc25a6f606eb525ffdc56','2026-02-06 20:21:56',4101),
(9893622,'7+7=','aab3238922bcc25a6f606eb525ffdc56','2026-02-06 20:22:08',4101),
(9930939,'6+2=','c9f0f895fb98ab9159f51fd0297e236d','2026-02-07 14:16:50',4101),
(10059479,'5+7=','c20ad4d76fe97759aa27a0c99bff6710','2026-02-09 07:25:13',4101),
(10170028,'1+4=','e4da3b7fbbce2345d7772b0674a318d5','2026-02-10 10:33:14',4101),
(10228368,'5+2=','8f14e45fceea167a5a36dedd4bea2543','2026-02-11 05:22:42',4101),
(10228371,'6+3=','45c48cce2e2d7fbdea1afc51c7c6ad26','2026-02-11 05:22:43',4101),
(10258544,'8+3=','6512bd43d9caa6e02c990b0a82652dca','2026-02-11 10:53:42',4101),
(10296152,'3+7=','d3d9446802a44259755d38e6d163e820','2026-02-11 20:02:54',4101),
(10315208,'7+9=','c74d97b01eae257e44aa9d5bade97baf','2026-02-12 05:53:23',4101),
(10502686,'2+1=','eccbc87e4b5ce2fe28308fd9f2a7baf3','2026-02-14 23:24:39',4101),
(10502687,'9+4=','c51ce410c124a10e0db5e4b97fc2af39','2026-02-14 23:24:40',4101),
(10546930,'3+3=','1679091c5a880faf6fb5e6087eb1b2dc','2026-02-15 15:24:24',4101),
(10547010,'6+5=','6512bd43d9caa6e02c990b0a82652dca','2026-02-15 15:25:30',4101),
(10738841,'1+7=','c9f0f895fb98ab9159f51fd0297e236d','2026-02-18 06:40:53',4101),
(10749977,'2+6=','c9f0f895fb98ab9159f51fd0297e236d','2026-02-18 09:09:14',4101),
(10749987,'8+2=','d3d9446802a44259755d38e6d163e820','2026-02-18 09:09:20',4101);
/*!40000 ALTER TABLE `capture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `header` varchar(255) NOT NULL DEFAULT '',
  `anons` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `photo` varchar(20) NOT NULL DEFAULT '',
  `enabled` tinyint(1) DEFAULT 1,
  `sort` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`review_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2262 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--
-- WHERE:  project_id=4101

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES
(167,'Насколько необходимо независимое сопровождение ремонта?','1','<p style=\"text-align: justify;\">Чаще всего хозяин квартиры является основным заказчиком, контролером и &laquo;сопроводителем&raquo; ремонта собственной квартиры. Такое положение дел оправдывается себя при небольших площадях ремонта и наличии надежных и грамотных исполнителей.</p>',4101,'2014-01-14 12:56:10','',1,0),
(168,'Насколько необходимо независимое сопровождение ремонта?','1','<p style=\"text-align: justify;\">Чаще всего хозяин квартиры является основным заказчиком, контролером и &laquo;сопроводителем&raquo; ремонта собственной квартиры. Такое положение дел оправдывается себя при небольших площадях ремонта и наличии надежных и грамотных исполнителей.</p>',4101,'2014-01-14 12:56:49','',1,0),
(169,'Насколько необходимо независимое сопровождение ремонта?','1','<p style=\"text-align: justify;\">Чаще всего хозяин квартиры является основным заказчиком, контролером и &laquo;сопроводителем&raquo; ремонта собственной квартиры. Такое положение дел оправдывается себя при небольших площадях ремонта и наличии надежных и грамотных исполнителей.</p>',4101,'2014-01-14 12:57:05','',1,0),
(170,'Насколько необходимо независимое сопровождение ремонта?','1','<p style=\"text-align: justify;\">Чаще всего хозяин квартиры является основным заказчиком, контролером и &laquo;сопроводителем&raquo; ремонта собственной квартиры. Такое положение дел оправдывается себя при небольших площадях ремонта и наличии надежных и грамотных исполнителей.</p>',4101,'2014-01-14 12:57:37','',1,0);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bottom_menu`
--

DROP TABLE IF EXISTS `bottom_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `bottom_menu` (
  `bottom_menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `header` varchar(255) NOT NULL DEFAULT '',
  `sort` int(11) NOT NULL DEFAULT 0,
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `url` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`bottom_menu_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `bottom_menu_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1335 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bottom_menu`
--
-- WHERE:  project_id=4101

LOCK TABLES `bottom_menu` WRITE;
/*!40000 ALTER TABLE `bottom_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `bottom_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ecommerce`
--

DROP TABLE IF EXISTS `ecommerce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ecommerce` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `good_table` varchar(200) NOT NULL DEFAULT 'good',
  `gid_field` varchar(255) NOT NULL DEFAULT 'good_id',
  `fields` varchar(255) NOT NULL DEFAULT 'header as name, good_id as id, price',
  `counter` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ecommerce`
--
-- WHERE:  project_id=4101

LOCK TABLES `ecommerce` WRITE;
/*!40000 ALTER TABLE `ecommerce` DISABLE KEYS */;
/*!40000 ALTER TABLE `ecommerce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `const`
--

DROP TABLE IF EXISTS `const`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `const` (
  `const_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `read_only` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`const_id`),
  UNIQUE KEY `name` (`name`,`project_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `const_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=736189 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `const`
--
-- WHERE:  project_id=4101

LOCK TABLES `const` WRITE;
/*!40000 ALTER TABLE `const` DISABLE KEYS */;
INSERT INTO `const` VALUES
(219522,'watermark','const_watermark.png',4101,0),
(507501,'companyname','ДемРемСтрой. Строительная компания.',4101,0),
(507502,'email_for_feedback','demremstroy@inbox.ru',4101,0),
(507503,'phone','<p><span class=\"code\">(4842)</span> <span class=\"number\">54-20-33</span></p>\r\n<p><span class=\"code\">(4842)</span> <span class=\"number\">22-01-70</span></p>',4101,0),
(507504,'copy','ДЕМРЕМСТРОЙ © 2013',4101,0),
(507505,'counter','<!-- Yandex.Metrika counter -->\r\n<script type=\"text/javascript\" >\r\n    (function (d, w, c) {\r\n        (w[c] = w[c] || []).push(function() {\r\n            try {\r\n                w.yaCounter46877508 = new Ya.Metrika({\r\n                    id:46877508,\r\n                    clickmap:true,\r\n                    trackLinks:true,\r\n                    accurateTrackBounce:true,\r\n                    webvisor:true,\r\n                    trackHash:true\r\n                });\r\n            } catch(e) { }\r\n        });\r\n\r\n        var n = d.getElementsByTagName(\"script\")[0],\r\n            s = d.createElement(\"script\"),\r\n            f = function () { n.parentNode.insertBefore(s, n); };\r\n        s.type = \"text/javascript\";\r\n        s.async = true;\r\n        s.src = \"https://mc.yandex.ru/metrika/watch.js\";\r\n\r\n        if (w.opera == \"[object Opera]\") {\r\n            d.addEventListener(\"DOMContentLoaded\", f, false);\r\n        } else { f(); }\r\n    })(document, window, \"yandex_metrika_callbacks\");\r\n</script>\r\n<noscript><div><img src=\"https://mc.yandex.ru/watch/46877508\" style=\"position:absolute; left:-9999px;\" alt=\"\" /></div></noscript>\r\n<!-- /Yandex.Metrika counter -->',4101,0),
(507506,'footer_phone','<p>(4842) 54-20-33</p><p>(4842) 22-01-70</p>',4101,0),
(507507,'header_email','E-mail: demremstroy@inbox.ru,, demremstroy@mail.ru',4101,0),
(507508,'perpage_object','6',4101,0),
(507509,'perpage_article','3',4101,0),
(507510,'perpage_review','10',4101,0),
(507511,'perpage_search','15',4101,0);
/*!40000 ALTER TABLE `const` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_ext_url`
--

DROP TABLE IF EXISTS `in_ext_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_ext_url` (
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `in_url` varchar(255) NOT NULL DEFAULT '',
  `ext_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`project_id`,`in_url`),
  CONSTRAINT `in_ext_url_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_ext_url`
--
-- WHERE:  project_id=4101

LOCK TABLES `in_ext_url` WRITE;
/*!40000 ALTER TABLE `in_ext_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_ext_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_group_site`
--

DROP TABLE IF EXISTS `project_group_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_group_site` (
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `options` text DEFAULT NULL,
  `logo` varchar(20) NOT NULL DEFAULT '',
  `promoblock_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  CONSTRAINT `project_group_site_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_group_site`
--
-- WHERE:  project_id=4101

LOCK TABLES `project_group_site` WRITE;
/*!40000 ALTER TABLE `project_group_site` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_group_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager_project_access`
--

DROP TABLE IF EXISTS `manager_project_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager_project_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `manager_id` int(10) DEFAULT NULL,
  `project_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `manager_id` (`manager_id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8440 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager_project_access`
--
-- WHERE:  project_id=4101

LOCK TABLES `manager_project_access` WRITE;
/*!40000 ALTER TABLE `manager_project_access` DISABLE KEYS */;
INSERT INTO `manager_project_access` VALUES
(3445,4063,4101);
/*!40000 ALTER TABLE `manager_project_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pxls`
--

DROP TABLE IF EXISTS `pxls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pxls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `header` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `pxls_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pxls`
--
-- WHERE:  project_id=4101

LOCK TABLES `pxls` WRITE;
/*!40000 ALTER TABLE `pxls` DISABLE KEYS */;
/*!40000 ALTER TABLE `pxls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `top_menu_tree`
--

DROP TABLE IF EXISTS `top_menu_tree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `top_menu_tree` (
  `top_menu_tree_id` int(11) NOT NULL AUTO_INCREMENT,
  `header` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(255) NOT NULL DEFAULT '',
  `parent_id` int(11) DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `url` varchar(100) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `icon` varchar(20) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`top_menu_tree_id`),
  KEY `parent_id` (`parent_id`),
  KEY `path` (`path`),
  KEY `project_id` (`project_id`),
  KEY `project_id_2` (`project_id`,`path`),
  CONSTRAINT `top_menu_tree_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `top_menu_tree` (`top_menu_tree_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `top_menu_tree_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68600 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `top_menu_tree`
--
-- WHERE:  project_id=4101

LOCK TABLES `top_menu_tree` WRITE;
/*!40000 ALTER TABLE `top_menu_tree` DISABLE KEYS */;
INSERT INTO `top_menu_tree` VALUES
(21236,'О компании','',NULL,21236,4101,'/about','','',1),
(21237,'Услуги','',NULL,21237,4101,'/service','','',1),
(21238,'Наши объекты','',NULL,21238,4101,'/object','','',1),
(21239,'Статьи','',NULL,21239,4101,'/article','','',1),
(21240,'Вопросы и ответы','',NULL,21240,4101,'/faq','','',1),
(21241,' Контакты','',NULL,21241,4101,'/contacts','','',1),
(21321,'Благодарности','',NULL,21321,4101,'/blago','','',1),
(21322,'Документы СРО','/21236',21236,21322,4101,'/dokuments','','',1);
/*!40000 ALTER TABLE `top_menu_tree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promo`
--

DROP TABLE IF EXISTS `promo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `promo` (
  `promo_id` int(11) NOT NULL AUTO_INCREMENT,
  `promo_title` varchar(255) NOT NULL DEFAULT '',
  `promo_description` text NOT NULL,
  `promo_keywords` text NOT NULL,
  `promo_body` text NOT NULL,
  `url` varchar(200) NOT NULL DEFAULT '',
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `add_tags` text NOT NULL,
  `h1` varchar(200) NOT NULL,
  PRIMARY KEY (`promo_id`),
  UNIQUE KEY `url` (`url`,`project_id`),
  KEY `project_id` (`project_id`),
  KEY `project_id_2` (`project_id`,`url`),
  CONSTRAINT `promo_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=69828 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promo`
--
-- WHERE:  project_id=4101

LOCK TABLES `promo` WRITE;
/*!40000 ALTER TABLE `promo` DISABLE KEYS */;
/*!40000 ALTER TABLE `promo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_rubricator`
--

DROP TABLE IF EXISTS `service_rubricator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_rubricator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `header` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(255) NOT NULL DEFAULT '',
  `parent_id` int(11) DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `anons` varchar(512) NOT NULL DEFAULT '',
  `body` longtext DEFAULT NULL,
  `photo` varchar(255) NOT NULL DEFAULT '',
  `enabled` tinyint(1) DEFAULT 1,
  `price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `price_str` varchar(100) NOT NULL DEFAULT '',
  `top` tinyint(1) NOT NULL DEFAULT 0,
  `icon` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `path` (`path`),
  KEY `project_id` (`project_id`),
  KEY `enabled` (`enabled`),
  CONSTRAINT `service_rubricator_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `service_rubricator` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `service_rubricator_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8277 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_rubricator`
--
-- WHERE:  project_id=4101

LOCK TABLES `service_rubricator` WRITE;
/*!40000 ALTER TABLE `service_rubricator` DISABLE KEYS */;
INSERT INTO `service_rubricator` VALUES
(3065,'Ремонтно-отделочные работы ','',NULL,2357,4101,'','<p><img style=\"float: left;\" src=\"/files/project_4101/Risunok1.jpg\" alt=\"\" /><img src=\"/files/project_4101/Risunok1.jpg\" alt=\"\" /></p>','',1,0.00,'',0,''),
(3066,'Общестроительные работы','',NULL,2358,4101,'','<p style=\"text-align: justify;\"><strong><span style=\"font-size: small;\">1.&nbsp;&nbsp;&nbsp; Подготовительные работы</span></strong></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.1&nbsp; Строительство временных: дорог; площадок; инженерных сетей и&nbsp;сооружений </span></p>\r\n<p style=\"text-align: justify;\"></p>\r\n<p style=\"text-align: justify;\"><strong><span style=\"font-size: small;\">2.&nbsp;&nbsp;&nbsp; Земляные работы</span></strong></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">2.1&nbsp; Разработка грунта и&nbsp;устройство дренажей в&nbsp;водохозяйственном строительстве</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">2.2&nbsp; Работы по&nbsp;водопонижению, организации поверхностного стока и&nbsp;водоотвода</span></p>\r\n<p style=\"text-align: justify;\"></p>\r\n<p style=\"text-align: justify;\"><strong><span style=\"font-size: small;\">3.&nbsp;&nbsp;&nbsp; Свайные работы. Закрепление грунтов</span></strong></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">3.1&nbsp; Устройство ростверков</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">3.2&nbsp; Устройство забивных и&nbsp;буронабивных свай</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">3.3&nbsp; Работы по&nbsp;возведению сооружений способом &laquo;стена в&nbsp;грунте&raquo;</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">&nbsp;</span></p>\r\n<p style=\"text-align: justify;\"><strong><span style=\"font-size: small;\">4.&nbsp;&nbsp;&nbsp; Устройство бетонных и&nbsp;железобетонных монолитных конструкций</span></strong></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">4.1&nbsp; Опалубочные работы</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">4.2&nbsp; Арматурные работы</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">4.3&nbsp; Устройство монолитных бетонных и&nbsp;железобетонных конструкций</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">&nbsp;</span></p>\r\n<p style=\"text-align: justify;\"><strong><span style=\"font-size: small;\">5.&nbsp;&nbsp;&nbsp; Монтаж сборных бетонных и&nbsp;железобетонных конструкций</span></strong></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">5.1&nbsp; Монтаж фундаментов и&nbsp;конструкций подземной части зданий и&nbsp;сооружений</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">5.2&nbsp; Монтаж элементов конструкций надземной части зданий и&nbsp;сооружений, в&nbsp;том числе колонн, рам, ригелей, ферм, балок, плит, поясов, панелей стен и&nbsp;перегородок</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">5.3&nbsp; Монтаж объемных блоков, в&nbsp;том числе вентиляционных блоков, шахт лифтов и&nbsp;мусоропроводов, санитарно-технических кабин</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">&nbsp;</span></p>\r\n<p style=\"text-align: justify;\"><strong><span style=\"font-size: small;\">6.&nbsp;&nbsp;&nbsp; Монтаж металлических конструкций</span></strong></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">6.1&nbsp; Монтаж, усиление и демонтаж конструктивных элементов и ограждающих конструкций зданий и сооружений</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">6.2&nbsp; Монтаж, усиление и демонтаж конструкций транспортных галерей</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">6.3&nbsp; Монтаж, усиление и демонтаж резервуарных конструкций</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">6.4&nbsp; Монтаж, усиление и демонтаж мачтовых сооружений, башен, вытяжных труб</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">6.5&nbsp; Монтаж, усиление и демонтаж технологических конструкций</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">6.6&nbsp; Монтаж и демонтаж тросовых несущих конструкций (растяжки, вантовые конструкции и прочие)</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">&nbsp;</span></p>\r\n<p style=\"text-align: justify;\"><strong><span style=\"font-size: small;\">7. Защита строительных конструкций, трубопроводов и оборудования (кроме магистральных и промысловых трубопроводов)</span></strong></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">7.1&nbsp; Футеровочные работы</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">7.2&nbsp; Кладка из кислотоупорного кирпича и фасонных кислотоупорных керамических изделий</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">7.3&nbsp; Гуммирование (обкладка листовыми резинами и жидкими резиновыми смесями)</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">7.4&nbsp; Устройство оклеечной изоляции</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">7.5&nbsp; Устройство металлизационных покрытий</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">7.6&nbsp; Нанесение лицевого покрытия при устройстве монолитного пола в помещениях с агрессивными средами</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">7.7 Антисептирование деревянных конструкций</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">7.8&nbsp; Гидроизоляция строительных конструкций</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">7.9&nbsp; Работы по теплоизоляции зданий, строительных конструкций и оборудования</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">7.10&nbsp; Работы по огнезащите строительных конструкций и оборудования</span></p>','',1,0.00,'',0,''),
(3067,'Устройство наружных сетей водоснабжения и канализации','',NULL,2359,4101,'','<p style=\"text-align: justify;\"><strong><span style=\"font-size: small;\">Устройство наружных сетей водопровода</span></strong></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.1&nbsp; Укладка трубопроводов водопроводных</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.2&nbsp; Монтаж и демонтаж запорной арматуры и оборудования водопроводных сетей</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.3&nbsp; Устройство водопроводных колодцев, оголовков, гасителей водосборов</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.4&nbsp; Очистка полости и испытание трубопроводов водопровода</span></p>\r\n<p style=\"text-align: justify;\"><strong><span style=\"font-size: small;\">Устройство наружных сетей канализации</span></strong></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.1&nbsp; Укладка трубопроводов канализационных безнапорных</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.2&nbsp; Укладка трубопроводов канализационных напорных</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.3&nbsp; Монтаж и демонтаж запорной арматуры и оборудования канализационных сетей</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.4&nbsp; Устройство канализационных и водосточных колодцев</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.5&nbsp; Устройство фильтрующего основания под иловые площадки и поля фильтрации</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.6&nbsp; Укладка дренажных труб на иловых площадках</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.7&nbsp; Очистка полости и испытание трубопроводов канализации</span></p>','',1,0.00,'',0,''),
(3068,'Устройство наружных сетей теплоснабжения','',NULL,2360,4101,'','<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.1 Укладка трубопроводов теплоснабжения с температурой теплоносителя до 115 градусов Цельсия</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.2 Укладка трубопроводов теплоснабжения с температурой теплоносителя 115 градусов Цельсия и выше</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.3 Монтаж и демонтаж запорной арматуры и оборудования сетей теплоснабжения</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.4 Устройство колодцев и камер сетей теплоснабжения</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.5 Очистка полости и испытание трубопроводов теплоснабжения</span></p>','',1,0.00,'',0,''),
(3069,'Устройство наружных электрических сетей ','',NULL,2361,4101,'','<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.1 Устройство сетей электроснабжения напряжением до 35 кВ включительно</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.2 Устройство сетей электроснабжения напряжением до 330 кВ включительно</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.3 Монтаж и демонтаж опор для воздушных линий электропередачи напряжением до 35 кВ</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.4 Монтаж и демонтаж опор для воздушных линий электропередачи напряжением до 500 кВ</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.5 Монтаж и демонтаж проводов и грозозащитных тросов воздушных линий электропередачи напряжением до 35 кВ включительно</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.6 Монтаж и демонтаж проводов и грозозащитных тросов воздушных линий электропередачи напряжением свыше 35 кВ</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.7 Монтаж и демонтаж трансформаторных подстанций и линейного электрооборудования напряжением до 35 кВ включительно</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.8 Монтаж и демонтаж трансформаторных подстанций и линейного электрооборудования напряжением свыше 35 кВ</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">1.9 Установка распределительных устройств, коммутационной аппаратуры, устройств защиты и т.д.</span></p>','',1,0.00,'',0,''),
(3070,'Пусконаладочные работы','',NULL,2362,4101,'','<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы синхронных генераторов и систем возбуждения</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы силовых и измерительных трансформаторов</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы коммутационных аппаратов</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы устройств релейной защиты</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы систем напряжения и оперативного тока</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы электрических машин и электроприводов</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы компрессорных установок</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы технологических установок топливного хозяйства</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы общекотельных систем и инженерных коммуникаций</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы сушильных установок</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы сооружений водоснабжения</span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: small;\">Пусконаладочные работы сооружений канализации</span></p>','',1,0.00,'',0,'');
/*!40000 ALTER TABLE `service_rubricator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `struct`
--

DROP TABLE IF EXISTS `struct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `struct` (
  `struct_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `header` varchar(200) NOT NULL DEFAULT '',
  `table_name` varchar(50) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `admin_script` varchar(150) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `struct_type` int(11) DEFAULT NULL,
  `struct_icon` int(11) DEFAULT NULL,
  `url_tool` varchar(255) NOT NULL DEFAULT '' COMMENT 'ссылка на инструмент',
  PRIMARY KEY (`struct_id`),
  KEY `project_id` (`project_id`),
  KEY `project_id_2` (`project_id`,`table_name`),
  CONSTRAINT `struct_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12716 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `struct`
--
-- WHERE:  project_id=4101

LOCK TABLES `struct` WRITE;
/*!40000 ALTER TABLE `struct` DISABLE KEYS */;
INSERT INTO `struct` VALUES
(3086,4101,'Рубрикатор услуг','service_rubricator','our %form=(\n	title => \'Рубрикатор услуг\',\n	work_table => \'service_rubricator\',\n	work_table_id => \'id\',\n	make_delete => \'1\',\n	default_find_filter => \'header\',\n	read_only => \'0\',\n	tree_use => \'1\',\n	sort=>1,\n	events=>{\n		before_insert=>q{\n			push @{$form->{fields}}, {\n				name=>project_id,\n				type=>\"hidden\",\n				value=>$form->{project}->{project_id}\n			};\n		},\n		permissions=>q{\n			# Уникальные УРЛ\'ы\n			&{$form->{PLUGINIT}->{ex_links}}(\'/service/[%id%]\') if($form{project}->{options}->{ex_links});\n			\n			# promo в карточке\n			#&{$form->{PLUGINIT}->{ex_promo}}(\'/service/[%id%]\');\n		}\n	},\n	max_level=>\'0\',\n	work_table_foreign_key=>\'project_id\',\n	work_table_foreign_key_value=>4101,\n	fields =>\n	[\n		{\n			name => \'header\',\n			description => \'Наименование\',\n			type => \'text\',\n		},\n		{\n			description=>\'Фото\',\n			name=>\'photo\',\n			type=>\'file\',\n			converter=>q{./plugins/picture/resize.pl [%filename%]  --output_file=\'[%input%]_mini1.[%input_ext%]\' --size=\'212x0\' --output_file=\'[%input%]_mini2.[%input_ext%]\' --size=\'800x0\' && ./plugins/wm_n.pl --project_id=4101 --src=\'[%input%]_mini1.[%input_ext%]\' && ./plugins/wm_n.pl --project_id=4101 --src=\'[%input%]_mini2.[%input_ext%]\'},\n			filedir=>\'../files/project_4101/service_rubricator\',\n			before_delete_code=>q{\n				if($element->{file_for_del} =~m/^(.+)\\.([^\\.]+)$/){\n					unlink(\"$element->{filedir}/$1\\_mini1.$2\");\n					unlink(\"$element->{filedir}/$1\\_mini2.$2\");\n\n				}\n			}\n		},\n#		{name=>\'anons\',description=>\'Анонс\',type=>\'textarea\',style=>\'width: 300px; height: 100px;\',},\n		{name=>\'body\',type=>\'wysiwyg\',description=>\'Описание/Анонс\',},\n		{name=>\'enabled\',type=>\'checkbox\',description=>\'Вкл\',value=>1,},\n	]\n);','admin_tree.pl',1,NULL,NULL,''),
(3087,4101,'Статьи','struct_4101_article','our %form=(\n	title => \'Статьи\',\n	work_table => \'struct_4101_article\',\n	work_table_id => \'article_id\',\n	make_delete => \'1\',\n	default_find_filter => \'header\',\n	read_only => \'0\',\n	tree_use => \'0\',\n	events=>{\n		before_insert=>q{\n			push @{$form->{fields}}, {\n				name=>project_id,\n				type=>\"hidden\",\n				value=>$form->{project}->{project_id}\n			};\n		},\n		permissions=>q{\n			# Уникальные УРЛ\'ы\n			&{$form->{PLUGINIT}->{ex_links}}(\'/article/[%id%]\') if($form{project}->{options}->{ex_links});\n			\n			# promo в карточке\n			#&{$form->{PLUGINIT}->{ex_promo}}(\'/service/[%id%]\');\n		}\n	},\n	fields =>\n	[\n		{\n			name => \'header\',\n			description => \'Заголовок\',\n			type => \'text\',\n		},\n		{\n			name => \'anons\',\n			description => \'Анонс\',\n			type => \'wysiwyg\',\n		},\n		{ \n			name => \'photo\',\n			description => \'photo\',\n			type => \'file\',\n			converter=>q{./plugins/picture/resize.pl [%filename%]  --output_file=\'[%input%]_mini1.[%input_ext%]\' --size=\'52x0\' --output_file=\'[%input%]_mini2.[%input_ext%]\' --size=\'212x0\' --output_file=\'[%input%]_mini3.[%input_ext%]\' --size=\'800x0\' && ./plugins/wm_n.pl --project_id=4101 --src=\'[%input%]_mini1.[%input_ext%]\' && ./plugins/wm_n.pl --project_id=4101 --src=\'[%input%]_mini2.[%input_ext%]\' && ./plugins/wm_n.pl --project_id=4101 --src=\'[%input%]_mini3.[%input_ext%]\'},\n			filedir=>\'../files/project_4101/article\',\n			before_delete_code=>q{\n				if($element->{file_for_del} =~m/^(.+)\\.([^\\.]+)$/){\n					unlink(\"$element->{filedir}/$1\\_mini1.$2\");\n					unlink(\"$element->{filedir}/$1\\_mini2.$2\");\n					unlink(\"$element->{filedir}/$1\\_mini3.$2\");\n\n				}\n			}\n		},\n		{\n			name => \'body\',\n			description => \'текст\',\n			type => \'wysiwyg\',\n		},\n		{name=>\'specpredl\',type=>\'checkbox\',description=>\'В топ\',},\n		{name=>\'enabled\',type=>\'checkbox\',description=>\'Вкл\',value=>1,},\n	]\n);','admin_table.pl',1,NULL,NULL,''),
(3088,4101,'Объекты','portfolio','our %form=(\n	title => \'Объекты\',\n	work_table => \'portfolio\',\n	work_table_id => \'portfolio_id\',\n	make_delete => \'1\',\n	default_find_filter => \'header\',\n	read_only => \'0\',\n	tree_use => \'0\',\n	sort=>0,\n	events=>{\n		before_insert=>q{\n			push @{$form->{fields}}, {\n				name=>project_id,\n				type=>\"hidden\",\n				value=>$form->{project}->{project_id}\n			};\n		},\n		permissions=>q{\n			# Уникальные УРЛ\'ы\n			&{$form->{PLUGINIT}->{ex_links}}(\'/object/[%id%]\') if($form{project}->{options}->{ex_links});\n			\n			# promo в карточке\n			#&{$form->{PLUGINIT}->{ex_promo}}(\'/service/[%id%]\');\n		}\n	},\n	max_level=>\'0\',\n	work_table_foreign_key=>\'project_id\',\n	work_table_foreign_key_value=>4101,\n	fields =>\n	[\n		{\n			name => \'header\',\n			description => \'Наименование\',\n			type => \'text\',\n		},\n		{\n			description=>\'Фото\',\n			name=>\'photo\',\n			type=>\'file\',\n			converter=>q{./plugins/picture/resize.pl [%filename%]  --output_file=\'[%input%]_mini1.[%input_ext%]\' --size=\'212x135\' --output_file=\'[%input%]_mini2.[%input_ext%]\' --size=\'212x0\' --output_file=\'[%input%]_mini3.[%input_ext%]\' --size=\'800x0\' && ./plugins/wm_n.pl --project_id=4101 --src=\'[%input%]_mini1.[%input_ext%]\' && ./plugins/wm_n.pl --project_id=4101 --src=\'[%input%]_mini2.[%input_ext%]\' && ./plugins/wm_n.pl --project_id=4101 --src=\'[%input%]_mini3.[%input_ext%]\' },\n			filedir=>\'../files/project_4101/portfolio\',\n			before_delete_code=>q{\n				if($element->{file_for_del} =~m/^(.+)\\.([^\\.]+)$/){\n					unlink(\"$element->{filedir}/$1\\_mini1.$2\");\n					unlink(\"$element->{filedir}/$1\\_mini2.$2\");\n					unlink(\"$element->{filedir}/$1\\_mini3.$2\");\n\n				}\n			}\n		},\n#		{name=>\'anons\',description=>\'Анонс\',type=>\'textarea\',style=>\'width: 300px; height: 100px;\',},\n		{name=>\'body\',type=>\'wysiwyg\',description=>\'Описание\',},\n		{name=>\'specpredl\',type=>\'checkbox\',description=>\'В топ\',},\n		{name=>\'enabled\',type=>\'checkbox\',description=>\'Вкл\',value=>1,},\n	]\n);','admin_table.pl',1,NULL,NULL,''),
(3089,4101,'Вопросы и ответы','review','our %form=(\n	title => \'Вопросы и ответы\',\n	work_table => \'review\',\n	work_table_id => \'review_id\',\n	make_delete => \'1\',\n	default_find_filter => \'header\',\n	read_only => \'0\',\n	tree_use => \'0\',\n	events=>{\n		before_insert=>q{\n			push @{$form->{fields}}, {\n				name=>project_id,\n				type=>\"hidden\",\n				value=>$form->{project}->{project_id}\n			};\n		}\n	},\n	fields =>\n	[\n		{name => \'header\',description => \'Вопрос\',type => \'text\',},\n#		{name => \'anons\',description => \'Анонс\',type => \'textarea\',},\n		{\n			name => \'body\',\n			description => \'Ответ\',\n			type => \'wysiwyg\',\n		},\n		{name=>\'anons\',type=>\'checkbox\',description=>\'В топ\',},\n		{name=>\'enabled\',type=>\'checkbox\',description=>\'Вкл\',value=>1,},\n	]\n);','admin_table.pl',1,NULL,NULL,'');
/*!40000 ALTER TABLE `struct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `content` (
  `content_id` int(11) NOT NULL AUTO_INCREMENT,
  `header` varchar(200) NOT NULL DEFAULT '',
  `body` longtext DEFAULT NULL,
  `url` varchar(200) NOT NULL DEFAULT '',
  `project_id` int(10) unsigned NOT NULL DEFAULT 0,
  `read_only` tinyint(1) NOT NULL DEFAULT 0,
  `lastmod` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `enabled` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `promo_title` varchar(200) NOT NULL DEFAULT '',
  `promo_description` varchar(200) NOT NULL DEFAULT '',
  `promo_keywords` varchar(200) NOT NULL DEFAULT '',
  `h1` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`),
  UNIQUE KEY `url` (`url`,`project_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `content_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58338 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--
-- WHERE:  project_id=4101

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES
(28481,'Главная','<table border=\"0\" align=\"left\">\r\n<tbody>\r\n<tr>\r\n<td>\r\n<p>\r\n<script type=\"text/javascript\" src=\"http://dunsregistered.dnb.com\">// <![CDATA[\r\n</p>\r\n// ]]></script>\r\n</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p style=\"font-size: small; color: #b86597;\"><span style=\"font-size: small; color: #800080;\"><strong>ООО &laquo;Демремстрой&raquo;</strong> &mdash; это компания-профессионал строительного рынка, осуществляющая комплекс работ от нулевого цикла до сдачи объектов в эксплуатацию. Уже более 10 лет мы успешно осуществляем функции Генерального подрядчика, а так же ремонтируем и реконструируем промышленные и коммерческие здания. В 2010 году компания внедрила систему менеджмента качества в соответствии со стандартами <span class=\"layout layout_size_xl layout_type_2pane layout_vertical-fit layout_letter\" style=\"max-width: 2150px; --left-column-width: 252px; --right-column-width: 252px; --sidebar-column-width: 400px;\"><span style=\"color: #800080; font-family: Tahoma, Geneva, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">ГОСТ Р ИСО 9001-2015.&nbsp;ООО &laquo;Демремстрой&raquo; состоит в </span><span style=\"background-color: #ffffff; color: #636363; float: none; font-family: \'tahoma\' , \'geneva\' , sans-serif; font-size: 12px; font-style: normal; font-weight: 400; text-align: left; text-decoration-style: initial; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;\"><span style=\"font-family: tahoma, arial, helvetica, sans-serif; font-size: small; color: #800fa7;\">Ассоциации&nbsp;&laquo;Саморегулируемая&nbsp;организация&nbsp;\"Объединение строителей Калужской области\" (Ассоциация СРО&nbsp;\"ОСКО\")</span>,</span><span style=\"color: #800080; font-family: Tahoma, Geneva, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">с правом заключать договора на строительство, стоимость одного из которых не превышает 500 000 000&nbsp;рублей.</span></span> <br /></span></p>','/',4101,0,'2022-06-30 13:06:19',1,'','','',''),
(28482,'Благодарности','<table style=\"width: 230px;\" border=\"0\">\r\n<tbody>\r\n<tr>\r\n<td><a class=\"js-lightbox\" href=\"/files/project_4101/pisima/blag3.jpg\" target=\"_parent\"><img src=\"/files/project_4101/pisima/blag3.jpg\" alt=\"\" width=\"75\" /></a></td>\r\n<td><a class=\"js-lightbox\" href=\"/files/project_4101/pisima/blag5.jpg\" target=\"_parent\"><img src=\"/files/project_4101/pisima/blag5.jpg\" alt=\"\" width=\"75\" /></a></td>\r\n<td><a class=\"js-lightbox\" href=\"/files/project_4101/pisima/blag_6.jpg\"><img src=\"/files/project_4101/pisima/blag_6.jpg\" alt=\"\" width=\"75\" /></a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p></p>\r\n<p><a class=\"more\" href=\"/dokuments\">Подробнее</a></p>','__blago',4101,0,'2021-01-15 05:33:44',1,'','','',''),
(28483,'О компании','<p><span style=\"font-family: \'arial black\', \'avant garde\'; font-size: large; color: #800080;\">МИССИЯ И ЦЕЛИ КОМПАНИИ</span></p>\r\n<p style=\"text-align: left;\"><span style=\"font-family: \'comic sans ms\', sans-serif; font-size: medium; color: #800080;\">&nbsp; <span style=\"font-family: \'andale mono\', times;\">&nbsp; <strong>Основная миссия компании</strong> &mdash;&nbsp;</span></span><span style=\"font-family: \'andale mono\', times;\"><span style=\"color: #800080; font-size: medium;\">строительство объектов для бизнеса&nbsp;</span><span style=\"color: #800080; font-size: medium;\">и&nbsp; жизни, </span></span></p>\r\n<p style=\"text-align: left;\"><span style=\"font-family: \'andale mono\', times;\"><span style=\"color: #800080; font-size: medium;\">&nbsp; &nbsp; &nbsp; &nbsp;используя лучший мировой&nbsp;</span><span style=\"color: #800080; font-size: medium;\">и отечественный опыт.</span></span></p>\r\n<p><span style=\"font-family: \'andale mono\', times; font-size: medium; color: #800080;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<strong>Как мы этого добиваемся?&nbsp;</strong></span></p>\r\n<p><span style=\"color: #800080; font-family: \'andale mono\', times;\"><span style=\"font-size: medium;\"><strong>&nbsp;</strong><strong> 1)</strong>&nbsp; Обеспечиваем качественное возведение объектов любой сложности в&nbsp;</span><span style=\"font-size: medium;\">установленный </span></span></p>\r\n<p><span style=\"color: #800080; font-family: \'andale mono\', times;\"><span style=\"font-size: medium;\">&nbsp; &nbsp; &nbsp; &nbsp; срок с рациональным использованием материалов&nbsp;</span><span style=\"font-size: medium;\">и&nbsp;</span><span style=\"font-size: medium;\">человеческих </span><span style=\"font-size: medium;\">ресурсов.</span></span></p>\r\n<p><span style=\"color: #800080; font-family: \'andale mono\', times;\"><span style=\"font-size: medium;\">&nbsp; <strong>2)</strong>&nbsp;&nbsp;</span><span style=\"font-size: medium;\">Неизменно повышаем качество строительства путём&nbsp;</span></span><span style=\"font-size: medium; color: #800080; font-family: \'andale mono\', times;\">адаптации, внедрения и</span></p>\r\n<p><span style=\"color: #800080; font-family: \'andale mono\', times;\"><span style=\"font-size: medium;\">&nbsp; &nbsp; &nbsp; &nbsp; использования&nbsp;</span><span style=\"font-size: medium;\">передовых технологий </span><span style=\"font-size: medium;\">строительства.</span></span></p>\r\n<p style=\"background-image: url(\'/files/project_4101/const_watermark.png\');\"><span style=\"font-family: \'andale mono\', times; font-size: medium; color: #800080;\"><strong>&nbsp; 3)</strong></span><span style=\"color: #800080; font-family: \'andale mono\', times; font-size: medium;\">&nbsp; Повышаем уровень конкурентоспособности строительства за счёт высоких стандартов&nbsp;</span></p>\r\n<p style=\"background-image: url(\'/files/project_4101/const_watermark.png\');\"><span style=\"color: #800080; font-family: \'andale mono\', times;\"><span style=\"font-size: medium;\">&nbsp; &nbsp; &nbsp; &nbsp; планирования,&nbsp;</span><span style=\"font-size: medium;\">организации, мотивации, контроля и учёта внутри компании.</span></span></p>\r\n<p style=\"background-image: url(\'/files/project_4101/const_watermark.png\');\">&nbsp;</p>\r\n<p><span style=\"font-size: large; font-family: \'arial black\', \'avant garde\'; color: #800080;\">МЫ ГАРАНТИРУЕМ СВОИМ КЛИЕНТАМ</span><span style=\"color: #800080; font-family: \'arial black\', \'avant garde\'; font-size: large;\">:</span></p>\r\n<p style=\"text-align: left;\"><span style=\"color: #800080;\"><span style=\"font-family: \'arial black\', \'avant garde\'; font-size: large;\"><span style=\"font-size: medium; font-family: \'andale mono\', times;\"><strong>&nbsp;1</strong></span><span style=\"font-size: medium; font-family: \'andale mono\', times;\"><strong>)</strong></span><span style=\"font-family: \'andale mono\', times;\">&nbsp;<span style=\"font-size: medium; font-family: \'andale mono\', times;\">&nbsp;</span></span></span><span style=\"font-family: \'andale mono\', times; font-size: medium;\">Профессиональное осуществление своих обязательств по договорам, чёткое управление на площадке&nbsp;</span><span style=\"font-family: \'andale mono\', times; font-size: medium;\">эффективное взаимодействие с&nbsp;</span><span style=\"font-family: \'andale mono\', times; font-size: medium;\">&nbsp;подрядными&nbsp;&nbsp;и&nbsp;</span><span style=\"font-family: \'andale mono\', times; font-size: medium;\">субподрядными организациями.&nbsp;</span></span></p>\r\n<p style=\"text-align: left;\"><span style=\"color: #800080;\"><span style=\"font-size: medium; font-family: \'andale mono\', times;\"><strong>&nbsp;2)</strong> &nbsp;</span><span style=\"font-family: \'andale mono\', times; font-size: medium;\">Рациональное использование финансовых ресурсов клиентов за счёт использования&nbsp;</span><span style=\"font-family: \'andale mono\', times; font-size: medium;\">ресурсо- и энергосберегающих технологий&nbsp;</span><span style=\"font-family: \'andale mono\', times; font-size: medium;\">строительства, высокопроизводительной техники</span><span style=\"font-family: \'andale mono\', times; font-size: medium;\">&nbsp;и высококвалифицированной рабочей силы.</span></span><span style=\"font-family: \'andale mono\', times; font-size: medium;\">&nbsp;</span></p>\r\n<p style=\"text-align: left;\"><span style=\"color: #800080;\"><span style=\"font-family: \'andale mono\', times; font-size: medium;\"><strong>&nbsp;3)</strong> &nbsp;Индивидуальный подход к каждому клиенту, включающий полную информационную поддержку проекта</span><span style=\"font-family: \'andale mono\', times; font-size: medium;\">&nbsp;и выполнение других необходимых условий комфортного партнёрства.</span><span style=\"font-family: \'andale mono\', times; font-size: medium;\">&nbsp;&nbsp;</span></span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"font-family: \'arial black\', \'avant garde\'; font-size: large; color: #800080;\">7 ПРИЧИН РАБОТАТЬ С НАМИ</span></p>\r\n<p><span style=\"font-family: \'arial black\', \'avant garde\'; font-size: large; color: #800080;\"><br /></span></p>\r\n<p><span style=\"font-family: \'andale mono\', times; color: #800080; font-size: large;\"><strong>Качество</strong></span></p>\r\n<p><span style=\"font-size: medium; color: #800080; font-family: \'andale mono\', times;\">Мы располагаем&nbsp;всеми необходимыми оборудованием, контактами и кадрами,позволяющими выполнять проекты любой сложности на высоком уровне.</span></p>\r\n<p><span style=\"font-size: large;\"><strong><span style=\"font-family: \'andale mono\', times; color: #800080;\"><br /></span></strong></span></p>\r\n<p><span style=\"font-size: large;\"><strong><span style=\"font-family: \'andale mono\', times; color: #800080;\">Честность</span></strong></span></p>\r\n<p><span style=\"color: #800080; font-family: \'andale mono\', times; font-size: medium;\">Фирма не рискует репутацией надёжного партнёра и гарантирует комфортное, честное и результативное сотрудничество.</span></p>\r\n<p><span style=\"color: #800080; font-family: \'andale mono\', times; font-size: medium;\"><br /></span></p>\r\n<p><strong style=\"font-size: large;\"><span style=\"font-family: \'andale mono\', times; color: #800080;\">Компетенция</span></strong></p>\r\n<p><span style=\"color: #800080; font-family: \'andale mono\', times; font-size: medium;\">Сотрудники нашей компании &mdash; это опытные, честные и надёжные люди, готовые решать ваши задачи профессионально и с душой.</span></p>\r\n<p><span style=\"color: #800080; font-family: \'andale mono\', times; font-size: medium;\"><br /></span></p>\r\n<p><span style=\"font-size: large;\"><strong><span style=\"font-family: \'andale mono\', times; color: #800080;\">Безопасность</span></strong></span></p>\r\n<p><span style=\"font-size: medium; font-family: \'andale mono\', times; color: #800080;\">Мы ответственно относимся к окружающей среде, поэтому работаем только с высокотехнологичными стройматериалами и придерживаемся философии чистой стройки.</span></p>\r\n<p><span style=\"font-size: medium; font-family: \'andale mono\', times; color: #800080;\"><br /></span></p>\r\n<p><strong><span style=\"font-size: large; font-family: \'andale mono\', times; color: #800080;\">Ответственность</span></strong></p>\r\n<p><span style=\"font-size: medium; font-family: \'andale mono\', times; color: #800080;\">Мы знаем, что ожидания и&nbsp;</span><span style=\"color: #800080; font-family: \'andale mono\', times; font-size: medium;\">реальность должны совпадать, поэтому строго соблюдаем&nbsp;</span><span style=\"color: #800080; font-family: \'andale mono\', times; font-size: medium;\">сметы, техническую документацию&nbsp;</span><span style=\"color: #800080; font-family: \'andale mono\', times; font-size: medium;\">и сроки.</span></p>\r\n<p><span style=\"color: #800080; font-family: \'andale mono\', times; font-size: medium;\"><br /></span></p>\r\n<p><strong><span style=\"font-size: large; font-family: \'andale mono\', times; color: #800080;\">Индивидуальный подход</span></strong></p>\r\n<p><span style=\"font-size: medium; font-family: \'andale mono\', times; color: #800080;\">Выбирая нас, вы получаете персонального менеджера, сопровождающего проект с момента принятия решения и до сдачи объекта в режиме 24/7/365.</span></p>\r\n<p><span style=\"font-size: medium; font-family: \'andale mono\', times; color: #800080;\"><br /></span></p>\r\n<p><span style=\"font-size: large;\"><strong><span style=\"font-family: \'andale mono\', times; color: #800080;\">Инновации</span></strong></span></p>\r\n<p><span style=\"font-size: medium; font-family: \'andale mono\', times; color: #800080;\">Мы смотрим в будущее и постоянно адаптируем, внедряем и совершенствуем технологии строительства, менеджмента качества и управления человеческими ресурсами.</span></p>\r\n<p>&nbsp;</p>\r\n<p><span style=\"font-family: \'arial black\', \'avant garde\'; font-size: large; color: #800080;\">НАМ ДОВЕРЯЮТ</span></p>\r\n<p><span style=\"font-family: \'andale mono\', times; font-size: medium;\"><img src=\"/files/project_4101/brendy/Risunok3.jpg\" alt=\"магнит\" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img style=\"font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px;\" src=\"/files/project_4101/brendy/Risunok7.jpg\" alt=\"мегафон\" /></span></p>\r\n<p><span style=\"font-family: \'andale mono\', times; font-size: medium;\"><img src=\"/files/project_4101/brendy/Risunok15.jpg\" alt=\"арсенал\" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img src=\"/files/project_4101/brendy/Risunok6.jpg\" alt=\"cpf\" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span></p>\r\n<p><span style=\"font-family: \'andale mono\', times; font-size: medium;\">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<img src=\"/files/project_4101/brendy/Risunok14.jpg\" alt=\"ашан\" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"/files/project_4101/brendy/Risunok5.jpg\" alt=\"1\" /></span></p>\r\n<p><span style=\"font-family: \'andale mono\', times; font-size: medium;\"><img src=\"/files/project_4101/brendy/Risunok11.jpg\" alt=\"1\" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"/files/project_4101/brendy/Risunok8.jpg\" alt=\"1\" /></span></p>\r\n<p><span style=\"font-family: \'andale mono\', times; font-size: medium;\"><img src=\"/files/project_4101/brendy/Risunok12.jpg\" alt=\"1\" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <img src=\"/files/project_4101/brendy/Risunok4.jpg\" alt=\"1\" /></span></p>\r\n<p><span style=\"font-family: \'andale mono\', times; font-size: medium;\"><img src=\"/files/project_4101/brendy/Risunok9.jpg\" alt=\"1\" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"/files/project_4101/brendy/Risunok10.jpg\" alt=\"1\" /></span></p>\r\n<p><span style=\"font-family: \'andale mono\', times; font-size: medium;\">&nbsp;<img src=\"/files/project_4101/brendy/Risunok13.jpg\" alt=\"1\" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img src=\"/files/project_4101/brendy/Risunok18.jpg\" alt=\"\" /></span></p>\r\n<p><span style=\"font-family: \'andale mono\', times; font-size: medium;\"><img src=\"/files/project_4101/brendy/Risunok16.jpg\" alt=\"1\" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img src=\"/files/project_4101/brendy/Risunok17.jpg\" alt=\"1\" /></span></p>','/about',4101,0,'2021-01-15 05:33:44',1,'','','',''),
(28484,'Услуги','<p style=\"text-align: justify;\">Группа компаний &laquo;Демремстрой&raquo; - это профессионал в организации управления процессами поставок строительных материалов, производит все виды строительных работ, выступает на объектах заказчика в качестве Генерального подрядчика, помогает снизить оперативные издержки и минимизирует финансовые риски. Компания входит в саморегулируемую организацию \"Объединение строителей Калужской области\" НП \"ОСКО\", имеет свидетельство о допуске к работам, которые оказывают влияние на безопасность объектов капитального строительства.</p>\r\n<p style=\"text-align: justify;\"></p>','/service',4101,0,'2021-01-15 05:33:44',1,'','','',''),
(28485,'Наши объекты','<p style=\"text-align: justify;\"><span style=\"font-family: tahoma, arial, helvetica, sans-serif; font-size: small;\">Группа компаний &laquo;Демремстрой&raquo; - это профессионал в организации управления процессами поставок строительных материалов, производит все виды строительных работ , выступает на объектах заказчика в качестве Генерального подрядчика, помогает снизить оперативные издержки и минимизирует финансовые риски.<span class=\"layout layout_size_xl layout_type_2pane layout_vertical-fit layout_letter\" style=\"max-width: 2150px; --left-column-width: 252px; --right-column-width: 252px; --sidebar-column-width: 400px; color: #000000;\"><span style=\"background-color: #ffffff; float: none; font-style: normal; font-weight: 400; text-align: left; text-decoration-style: initial; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;\"> </span></span></span></p>\r\n<p style=\"text-align: justify;\"><span style=\"font-family: tahoma, arial, helvetica, sans-serif; font-size: small;\"><span class=\"layout layout_size_xl layout_type_2pane layout_vertical-fit layout_letter\" style=\"max-width: 2150px; --left-column-width: 252px; --right-column-width: 252px; --sidebar-column-width: 400px; color: #000000;\"><span style=\"background-color: #ffffff; float: none; font-style: normal; font-weight: 400; text-align: left; text-decoration-style: initial; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;\">Компания входит в Ассоциацию &laquo;Саморегулируемая&nbsp;организация&nbsp;\"Объединение строителей Калужской области\" (Ассоциация СРО&nbsp;\"ОСКО\"), имеет&nbsp;допуск&nbsp;к работам, которые оказывают</span></span><span class=\"layout layout_size_xl layout_type_2pane layout_vertical-fit layout_letter\" style=\"max-width: 2150px; --left-column-width: 252px; --right-column-width: 252px; --sidebar-column-width: 400px; color: #000000;\"><span style=\"background-color: #ffffff; float: none; font-style: normal; font-weight: 400; text-align: left; text-decoration-style: initial; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;\"> влиян</span></span><span class=\"layout layout_size_xl layout_type_2pane layout_vertical-fit layout_letter\" style=\"max-width: 2150px; --left-column-width: 252px; --right-column-width: 252px; --sidebar-column-width: 400px; color: #000000;\"><span style=\"background-color: #ffffff; float: none; font-style: normal; font-weight: 400; text-align: left; text-decoration-style: initial; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;\">ие</span></span><span class=\"layout layout_size_xl layout_type_2pane layout_vertical-fit layout_letter\" style=\"max-width: 2150px; --left-column-width: 252px; --right-column-width: 252px; --sidebar-column-width: 400px; color: #000000;\"><span style=\"background-color: #ffffff; float: none; font-style: normal; font-weight: 400; text-align: left; text-decoration-style: initial; text-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;\"> на безопасность объектов капитального строительства.</span></span></span></p>','/object',4101,0,'2022-06-30 13:43:37',1,'','','',''),
(28486,'Вопросы и ответы','<p>Здесь можно разместить общий текст</p>','/faq',4101,0,'2021-01-15 05:33:44',1,'','','',''),
(28625,'Вакансии','','/vacancy',4101,0,'2021-01-15 05:33:44',1,'','','',''),
(28626,'Контакты','<p><strong><span style=\"font-size: small;\">ООО \"Демремстрой\" </span></strong></p>\r\n<p><span style=\"font-size: small;\">тел.(4842) 22-01-70</span></p>\r\n<p><span style=\"font-size: small;\">т/ф (4842) 54-20-33</span></p>\r\n<p><span style=\"font-size: small;\">E-mail: demremstroy@inbox.ru</span></p>\r\n<p><span size=\"2\" style=\"font-size: small;\">Юридический адрес: г. Калуга ул. Кирова зд.2. помещение 3 офис 524</span></p>\r\n<p><span size=\"2\" style=\"font-size: small;\">Фактический адрес:&nbsp;<span>г. Калуга ул. Кирова зд.2. помещение 3 офис 524</span></span></p>\r\n<p><strong><span style=\"font-size: small;\">Расположение на карте:</span></strong></p>\r\n<script type=\"text/javascript\" src=\"//api-maps.yandex.ru/services/constructor/1.0/js/?sid=MJbbqif-vpoXUyndKqk2G-1Ggob4Pnw7&amp;width=600&amp;height=430\"></script>','/contacts',4101,0,'2025-05-29 14:12:34',1,'','','',''),
(28627,'Благодарности','<table style=\"width: 710px;\" border=\"0\">\r\n<tbody>\r\n<tr>\r\n<td><a class=\"js-lightbox\" href=\"/files/project_4101/pisima/blag3.jpg\" target=\"_parent\"><!-- pagebreak --><img style=\"margin: 5px;\" src=\"/files/project_4101/pisima/blag3.jpg\" alt=\"\" width=\"230\" /></a></td>\r\n<td><a class=\"js-lightbox\" href=\"/files/project_4101/pisima/blag5.jpg\" target=\"_parent\"><img style=\"margin: 5px;\" src=\"/files/project_4101/pisima/blag5.jpg\" alt=\"\" width=\"230\" /></a></td>\r\n<td><a class=\"js-lightbox\" href=\"/files/project_4101/pisima/blag_6.jpg\" target=\"_parent\"><img style=\"margin: 5px;\" src=\"/files/project_4101/pisima/blag_6.jpg\" alt=\"\" width=\"230\" /></a></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;<a class=\"js-lightbox\" href=\"/files/project_4101/pisima/blag1.jpg\" target=\"_parent\"><img style=\"margin: 5px;\" src=\"/files/project_4101/pisima/blag1.jpg\" alt=\"\" width=\"230\" /></a></td>\r\n<td><a class=\"js-lightbox\" href=\"/files/project_4101/pisima/blag2.jpg\" target=\"_parent\"><img style=\"margin: 5px;\" src=\"/files/project_4101/pisima/blag2.jpg\" alt=\"\" width=\"230\" /></a>&nbsp;</td>\r\n<td><a class=\"js-lightbox\" href=\"/files/project_4101/pisima/blag4.jpg\" target=\"_parent\"><img style=\"margin: 5px;\" src=\"/files/project_4101/pisima/blag4.jpg\" alt=\"\" width=\"230\" /></a>&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td colspan=\"3\">&nbsp;&nbsp; <a class=\"js-lightbox\" href=\"/files/project_4101/pisima/blag6.jpg\" target=\"_parent\"><img style=\"margin: 5px auto; display: block;\" src=\"/files/project_4101/pisima/blag6.jpg\" alt=\"\" /></a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><img src=\"/files/project_4101/Blagodarstvennoe_pisimo_Ashan.jpg\" width=\"436\" height=\"600\" /></p>\r\n<p><img src=\"/files/project_4101/Blagodarnosti_MTS.jpg\" width=\"500\" height=\"600\" /></p>','/blago',4101,0,'2022-06-30 13:24:40',1,'','','',''),
(28628,'Документы','<p></p>\r\n<p><img src=\"/files/project_4101/Vipiska_Associacii_SRO_OSKO_page-0001.jpg\" width=\"500\" height=\"709\" /><img src=\"/files/project_4101/Vipiska_Associacii_SRO_OSKO_page-0002.jpg\" width=\"500\" height=\"709\" /><img src=\"/files/project_4101/Vipiska_Associacii_SRO_OSKO_page-0003.jpg\" width=\"500\" height=\"709\" /><img src=\"/files/project_4101/Vipiska_Associacii_SRO_OSKO_page-0004.jpg\" width=\"500\" height=\"709\" /></p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>','/dokuments',4101,0,'2022-06-30 13:34:56',1,'','','',''),
(30154,'УСЛУГИ ГЕНЕРАЛЬНОГО ПОДРЯДЧИКА','','/genpodryad',4101,0,'2021-01-15 05:33:44',1,'','','',''),
(30155,'УСЛУГИ УПРАВЛЯЮЩЕЙ КОМПАНИИ','','/uk',4101,0,'2021-01-15 05:33:44',1,'','','',''),
(38185,'','<p>56</p>','',4101,0,'2021-01-15 05:33:44',1,'','','',''),
(44890,'Принципы и условия обработки персональных данных','<p>Политика конфиденциальности сайта<br />Настоящая Политика конфиденциальности персональной информации (далее &mdash; Политика) действует в отношении всей информации, которую Сайт (могут получить о пользователе во время использования им сайта. Согласие пользователя на предоставление персональной информации, данное им в соответствии с настоящей Политикой в рамках отношений с одним из лиц, входящих, распространяется на все лица.</p>\r\n<p>Использование<br />Сайта означает безоговорочное согласие пользователя с настоящей Политикой и указанными в ней условиями обработки его персональной информации; в случае несогласия с этими условиями пользователь должен воздержаться от использования Сервисов.<br />1. Персональная информация пользователей, которую получает и обрабатывает Сайт<br />1.1. В рамках настоящей Политики под &laquo;персональной информацией пользователя&raquo; понимаются:<br />1.1.1. Персональная информация, которую пользователь предоставляет о себе самостоятельно заполнении форм обратной связи, включая персональные данные пользователя.<br />Обязательная для предоставления Сервисов (оказания услуг) информация помечена специальным образом. Иная информация предоставляется пользователем на его усмотрение.<br />1.1.2 Данные, которые автоматически передаются в процессе их использования с помощью установленного на устройстве пользователя программного обеспечения, в том числе IP - адрес, информация из cookie, информация о браузере пользователя (или иной программе, с помощью которой осуществляется доступ к Сервисам), время доступа, адрес запрашиваемой страницы.<br />1.2. Настоящая Политика применима только к Сайт . Сайт не контролирует и не несет ответственность за сайты третьих лиц, на которые пользователь может перейти по ссылкам, доступным на сайтах<br />Сайт, в том числе в результатах поиска. На таких сайтах у пользователя может собираться или запрашиваться иная персональная<br />информация, а также могут совершаться иные действия.<br />1.3. Сайт в общем случае не проверяет достоверность персональной информации, предоставляемой пользователями, и не осуществляет контроль за их дееспособностью. Однако<br />Сайт исходит из того, что пользователь предоставляет достоверную и достаточную персональную информацию по вопросам, предлагаемым в форме регистрации, и поддерживает эту информацию в актуальном состоянии.<br />2. Цели сбора и обработки персональной информации пользователей<br />2.1. Сайт собирает и хранит только те персональные данные, которые необходимы для предоставления и оказания услуг (исполнения соглашений и договоров с пользователем).<br />2.2. Персональную информацию пользователя<br />Сайт может использовать в следующих целях:<br />2.2.1. Идентификация стороны в рамках соглашений и договоров с Сайт<br />2.2.2. Предоставление пользователю персонализированных услуг;<br />2.2.3. Связь с пользователем, в том числе направление уведомлений, запросов и информации, касающихся использования Сервисов, оказания услуг, а также обработка запросов и заявок от пользователя;<br />2.2.4. Улучшение качества, удобства их использования, разработка услуг;<br />2.2.5. Таргетирование рекламных материалов;<br />2.2.6. Проведение статистических и иных исследований на основе обезличенных данных.<br />3. Условия обработки персональной информации пользователя и её передачи третьим лицам<br />3.1. Сайт хранит персональную информацию пользователей в соответствии с внутренними регламентами конкретных сервисов.<br />3.2. В отношении персональной информации пользователя сохраняется ее конфиденциальность, кроме случаев добровольного предоставления пользователем информации о себе для общего доступа неограниченному кругу лиц.<br />При использовании отдельных Сервисов пользователь соглашается с тем, что определённая часть его персональной информации становится общедоступной.<br />3.3. Сайт вправе передать персональную информацию пользователя третьим лицам в следующих случаях:<br />3.3.1. Пользователь выразил свое согласие на такие действия;<br />3.3.2. Передача необходима в рамках использования пользователем определенного Сервиса либо для оказания услуги пользователю;<br />3.3.3. Передача предусмотрена российским или иным применимым законодательством в рамках установленной законодательством процедуры;<br />3.3.4. Такая передача происходит в рамках продажи или иной передачи бизнеса (полностью или в части), при этом к приобретателю переходят все обязательства по соблюдению условий настоящей Политики применительно к полученной им персональной информации;<br />3.3.5. В целях обеспечения возможности защиты прав и законных интересов Сайт или третьих лиц в случаях, когда пользователь нарушает Пользовательское соглашение сервисов Сайт.<br />3.4. При обработке персональных данных пользователей Сайт руководствуется Федеральным законом РФ &laquo;О персональных данных&raquo;.<br />4. Изменение пользователем персональной информации<br />4.1. Пользователь может в любой момент изменить (обновить, дополнить) предоставленную им персональную информацию и ли её часть, а также параметры её конфиденциальности.<br />5. Меры, применяемые для защиты персональной информации пользователей<br />Сайт принимает необходимые и достаточные организационные и технические меры для защиты персональной информации пользователя от неправомерного или случайного доступа, уничтожения, изменения, блокирования, копирования, распространения, а также от иных неправомерных действий с ней третьих лиц.<br />6. Изменение Политики конфиденциальности. Применимое законодательство<br />6.1. Сайт имеет право вносить изменения в настоящую Политику конфиденциальности. При внесении изменений в актуальной редакции указывается дата последнего обновления. Новая редакция Политики вступает в силу с момента ее размещения, если иное не предусмотрено новой редакцией Политики.<br />6.2. К настоящей Политике и отношениям между пользователем и Сайт, возникающим в связи с применением Политики конфиденциальности, подлежит применению право Российской Федерации.</p>','/securitypolicy',4101,0,'2021-01-15 05:33:44',1,'','','','');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL DEFAULT '',
  `body` longtext DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`,`url`),
  KEY `url` (`url`)
) ENGINE=MyISAM AUTO_INCREMENT=2237 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--
-- WHERE:  project_id=4101

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-18 12:16:58

CREATE TABLE `site_redirect` (
  `site_redirect_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url_from` varchar(255) NOT NULL DEFAULT '',
  `url_to` varchar(512) NOT NULL DEFAULT '',
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `code` varchar(200) NOT NULL DEFAULT '',
  `status` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`site_redirect_id`),
  UNIQUE KEY `url_from` (`url_from`,`project_id`),
  KEY `project_id` (`project_id`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=cp1251;

CREATE TABLE `h1_tags` (
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `table_name` varchar(255) NOT NULL DEFAULT '',
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `h1` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`project_id`,`table_name`,`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

CREATE TABLE `redirect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_f` varchar(150) NOT NULL DEFAULT '',
  `domain_t` varchar(150) NOT NULL DEFAULT '',
  `protocol_f` tinyint(1) NOT NULL DEFAULT '1',
  `protocol_t` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain_f` (`domain_f`,`protocol_f`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=cp1251;

CREATE TABLE `basket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bkey` varchar(255) NOT NULL DEFAULT '',
  `registered` datetime DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bkey` (`bkey`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `basket_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basket_id` int(11) DEFAULT NULL,
  `good_id` int(11) DEFAULT NULL,
  `price` decimal(12,2) DEFAULT '0.00',
  `cnt` int(11) DEFAULT NULL,
  `attr` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `basket_id_2` (`basket_id`,`good_id`,`attr`),
  CONSTRAINT `basket_list_ibfk_1` FOREIGN KEY (`basket_id`) REFERENCES `basket` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

	