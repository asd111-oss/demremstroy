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
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `template` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `folder` varchar(255) CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL DEFAULT '',
  `type` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `header` varchar(200) CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL,
  `max_cache_time` int(10) unsigned NOT NULL DEFAULT 0,
  `reset_cache_time` int(10) unsigned NOT NULL DEFAULT 0,
  `not_cache_nginx` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2494 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template`
--
-- WHERE:  template_id=761

LOCK TABLES `template` WRITE;
/*!40000 ALTER TABLE `template` DISABLE KEYS */;
INSERT INTO `template` VALUES
(761,'demremstroy',0,'demremstroy.designb2b.ru','',0,0,0);
/*!40000 ALTER TABLE `template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_const`
--

DROP TABLE IF EXISTS `template_const`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `template_const` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) DEFAULT NULL,
  `sort` tinyint(1) DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT '',
  `header` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `template_id` (`template_id`),
  CONSTRAINT `template_const_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27633 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_const`
--
-- WHERE:  template_id=761

LOCK TABLES `template_const` WRITE;
/*!40000 ALTER TABLE `template_const` DISABLE KEYS */;
INSERT INTO `template_const` VALUES
(4513,761,NULL,'text','companyname','Название компании'),
(4514,761,NULL,'text','email_for_feedback','E-mail для связи'),
(4515,761,NULL,'textarea','phone','Телефон'),
(4516,761,NULL,'text','copy','Копирайт'),
(4517,761,NULL,'textarea','counter','Счетчики сайта'),
(4518,761,1,'text','footer_phone','Телефоны(подвал)'),
(4519,761,3,'text','perpage_object','Объектов на странице'),
(4520,761,4,'text','perpage_article','Статей на странице'),
(4521,761,5,'text','perpage_review','Вопросов на странице'),
(4522,761,6,'file','watermark','Водный знак(png)'),
(4523,761,7,'text','perpage_search','Результатов поиска'),
(4620,761,2,'text','header_email','Email в шапке');
/*!40000 ALTER TABLE `template_const` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_run_code`
--

DROP TABLE IF EXISTS `url_run_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `url_run_code` (
  `url_run_code_id` int(11) NOT NULL AUTO_INCREMENT,
  `header` text CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL,
  `template_id` int(11) DEFAULT NULL,
  `url_regexp` varchar(200) CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL DEFAULT '',
  `run_code` text CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL,
  `sort` tinyint(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`url_run_code_id`),
  KEY `template_id` (`template_id`),
  CONSTRAINT `url_run_code_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22541 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_run_code`
--
-- WHERE:  template_id=761

LOCK TABLES `url_run_code` WRITE;
/*!40000 ALTER TABLE `url_run_code` DISABLE KEYS */;
INSERT INTO `url_run_code` VALUES
(7094,'*',761,'','# Верхнее меню\r\n&GET_DATA({table=>\'top_menu_tree\',order=>\'sort\',tree_use=>1,to_tmpl=>\'top_menu\',select_fields=>\"top_menu_tree_id, url, header, if(url=?,1,0) as act, \'\'\",}, $params->{PATH_INFO});\r\n\r\n$tv=$params->{TMPL_VARS};\r\n\r\n$tv->{LSIDE}=[\'SERVICE_BOX\',\'OBJECT_BOX\'];\r\n&GET_DATA({struct=>\'service_rubricator\',to_tmpl=>\'SERVICE\',where=>\'enabled=1 AND parent_id is null\',order=>\'sort\',});\r\nforeach(@{$tv->{SERVICE}}){\r\n  $_->{child} = &GET_DATA({struct=>\'service_rubricator\',where=>\'enabled=1 AND parent_id = ?\',order=>\'sort\',},$_->{id});\r\n}\r\n&mk_url($tv->{SERVICE},\'service\');\r\n\r\n&GET_DATA({struct=>\'portfolio\',where=>\'enabled=1 AND specpredl=1\',order=>\'id desc\',to_tmpl=>\'OBJECT\',limit=>4});\r\n&mk_url($tv->{OBJECT},\'object\');\r\n\r\n&GET_DATA({struct=>\'article\',where=>\'enabled=1 AND specpredl=1\',to_tmpl=>\'ARTICLE\',order=>\'id desc\',});\r\n&mk_url($tv->{ARTICLE},\'article\');\r\n\r\n#Для форм обратной связи\r\nif($af = param(\'af\')){\r\n  my $err=$af.\'_err\';\r\n  my $subj = $af eq \'fb\' ? \'Вопрос \' : \'Заявка \';\r\n  my $fields=[\r\n    {name=>\'name\',description=>\'ФИО\',regexp=>\'.+\',},\r\n    {name=>\'phone\',description=>\'Телефон\',regexp=>($af eq \'pfb\' ? \'.+\' : undef),},\r\n    {name=>\'email\',description=>\'E-mail\',regexp=>\'\\w+@[a-zA-Z_]+\\.[a-zA-Z]{2,6}\',},\r\n    {name=>\'message\',description=>\'Сообщение\',regexp=>\'.+\',},\r\n  ];\r\n  my $mail=[\r\n    {to=>$tv->{const}{email_for_feedback},subject=>$subj.\' с сайта http://\'.$params->{project}{domain},message=>&fb_msg($fields),}\r\n  ];\r\n  \r\n  ($tv->{\"$err\"},$tv->{form_vls})=&GET_FORM({\r\n    action_field=>$af,use_capture=>1,fields=>$fields,mail_send=>$mail,\r\n  });\r\n}',1),
(7095,'Главная',761,'^\\/$','$params->{TMPL_VARS}->{promo}->{title}=\'Главная\' unless($params->{TMPL_VARS}->{promo}->{title});\r\n$params->{TMPL_VARS}->{page_type}=\'main\';\r\n\r\n&GET_DATA({table=>\'content\',where=>qq{url=\'/\'},onerow=>1,to_tmpl=>\'content\'});\r\n&GET_DATA({table=>\'content\',where=>qq{url=\'__blago\'},onerow=>1,to_tmpl=>\'blago\'});\r\n\r\n$tv=$params->{TMPL_VARS};\r\n&GET_DATA({struct=>\'article\',where=>\'enabled=1 AND specpredl=1\',to_tmpl=>\'ARTICLE\',order=>\'id desc\',});\r\n&mk_url($tv->{ARTICLE},\'article\');\r\n&GET_DATA({struct=>\'review\',where=>\'enabled=1 AND anons=1\',to_tmpl=>\'FAQ\',order=>\'id desc\',limit=>5});',2),
(7096,'Услуги(рубрикатор)',761,'^\\/service(?(?=\\/(\\d+))\\/(\\d+))$','my $rubricator_id=$2;\r\n$tbl=\'service_rubricator\'; #таблица\r\n\r\nif($rubricator_id=~m/^\\d+$/){ # выбран раздел рубрикатора\r\n  if($params->{TMPL_VARS}{content}=&GET_DATA({struct=>$tbl,where=>\'enabled=1\',onerow=>1,id=>$rubricator_id})){\r\n    $params->{TMPL_VARS}->{page_type}=\'service\';\r\n    &GET_DATA({struct=>$tbl,where=>\'parent_id=? AND enabled=1\',to_tmpl=>\'LIST\',order=>\'sort\',},$rubricator_id);\r\n    unless(scalar(@{$params->{TMPL_VARS}->{LIST}})){$params->{TMPL_VARS}->{page_type}=\'services-in\';}\r\n    else{\r\n      foreach(@{$params->{TMPL_VARS}{LIST}}){\r\n        $_->{child}=&GET_DATA({struct=>$tbl,where=>\'parent_id = ? AND enabled=1\',order=>\'sort\',},$_->{id});\r\n      }\r\n    }\r\n    # хлебные крошки\r\n    &GET_PATH({struct=>$tbl,id=>$rubricator_id,to_tmpl=>\'PATH_INFO\',create_href=>\'/service/[%id%]\'});\r\n    $params->{TMPL_VARS}->{promo}->{title}=$params->{TMPL_VARS}{content}{header} unless($params->{TMPL_VARS}->{promo}->{title});\r\n  }\r\n}\r\nelse{\r\n  $params->{TMPL_VARS}->{page_type}=\'service\';\r\n  $params->{TMPL_VARS}->{promo}->{title}=\'Услуги\' unless($params->{TMPL_VARS}->{promo}->{title});\r\n  &GET_DATA({table=>\'content\',where=>qq{url=\'/service\' AND project_id=$params->{project}{project_id}},onerow=>1,to_tmpl=>\'content\'});\r\n  &GET_DATA({struct=>$tbl,where=>\'enabled=1 AND (parent_id is null or parent_id = 0)\',to_tmpl=>\'LIST\',order=>\'sort\',});\r\n  foreach(@{$params->{TMPL_VARS}{LIST}}){\r\n    $_->{child}=&GET_DATA({struct=>$tbl,where=>\'parent_id = ? AND enabled=1\',order=>\'sort\',},$_->{id});\r\n  }\r\n  $tv->{LSIDE}=[\'OBJECT_BOX\',\'ARTICLE_BOX\'];\r\n}\r\n\r\n&mk_url($params->{TMPL_VARS}{LIST},\'service\');',3),
(7097,'Объекты',761,'^\\/object$','#my $pid=$1;\r\n#if($pid =~ m/^\\d+$/){\r\n#  if($params->{TMPL_VARS}{content}=&GET_DATA({struct=>\'project\',id=>$pid,onerow=>1,})){\r\n#    $params->{TMPL_VARS}->{promo}->{title}=$params->{TMPL_VARS}{content}{header} unless($params->{TMPL_VARS}->{promo}->{title});\r\n#    $params->{TMPL_VARS}->{page_type}=\'project_in\';\r\n#  }\r\n#}\r\n#else{\r\n  $params->{TMPL_VARS}->{promo}->{title}=\'Наши объекты\' unless($params->{TMPL_VARS}->{promo}->{title});\r\n  $params->{TMPL_VARS}->{page_type}=\'objects\';\r\n  &GET_DATA({table=>\'content\',where=>qq{url=\'/object\' AND project_id=$params->{project}{project_id}},onerow=>1,to_tmpl=>\'content\'});\r\n  $params->{TMPL_VARS}{maxpage}=&GET_DATA({struct=>\'portfolio\',to_tmpl=>\'LIST\',where=>\'enabled=1\',order=>\'id desc\',perpage=>$params->{TMPL_VARS}{const}{perpage_object},});\r\n#}',4),
(7098,'Статьи',761,'^\\/article(?(?=\\/(\\d+))\\/(\\d+))$','my $id=$1;\r\nmy $tbl=\'article\';\r\nmy $perpage=$params->{TMPL_VARS}{const}{\"perpage_$tbl\"};\r\nmy $order=\'id desc\';\r\n\r\n\r\nif($id=~ m/^\\d+$/){\r\n  if($params->{TMPL_VARS}{content}=&GET_DATA({struct=>$tbl,where=>\'enabled=1\',id=>$id,onerow=>1,})){\r\n    $params->{TMPL_VARS}{promo}{title}=$params->{TMPL_VARS}{content}{header} unless($params->{TMPL_VARS}{promo}{title});\r\n    $params->{TMPL_VARS}{page_type}=\'article-in\';\r\n  }\r\n}\r\nelse{\r\n  $params->{TMPL_VARS}{promo}{title}=\'Статьи\' unless($params->{TMPL_VARS}{promo}{title});\r\n  $params->{TMPL_VARS}{page_type}=\'article\';\r\n  $params->{TMPL_VARS}{maxpage}=&GET_DATA({struct=>$tbl,to_tmpl=>\'LIST\',where=>\'enabled=1\',perpage=>$perpage,order=>$order,});\r\n  &mk_url($params->{TMPL_VARS}{LIST},\'article\');\r\n}',5),
(7099,'Вопросы и ответы',761,'^\\/faq$','my $id=$1;\r\nmy $tbl=\'review\';\r\nmy $perpage=$params->{TMPL_VARS}{const}{\"perpage_$tbl\"};\r\nmy $order=\'id desc\';\r\n\r\n\r\n#if($id=~ m/^\\d+$/){\r\n#  if($params->{TMPL_VARS}{content}=&GET_DATA({struct=>$tbl,where=>\'enabled=1\',id=>$id,onerow=>1,})){\r\n#    $params->{TMPL_VARS}{promo}{title}=$params->{TMPL_VARS}{content}{header} unless($params->{TMPL_VARS}{promo}{title});\r\n#    $params->{TMPL_VARS}{page_type}=\'list-in\';\r\n#  }\r\n#}\r\n#else{\r\n  $params->{TMPL_VARS}{promo}{title}=\'Вопросы и ответы\' unless($params->{TMPL_VARS}{promo}{title});\r\n  $params->{TMPL_VARS}{page_type}=\'voprosi\';\r\n  &GET_DATA({table=>\'content\',where=>qq{url=\'/faq\' and project_id=4101},onerow=>1,to_tmpl=>\'content\'});\r\n  $params->{TMPL_VARS}{maxpage}=&GET_DATA({struct=>$tbl,to_tmpl=>\'LIST\',where=>\'enabled=1\',perpage=>$perpage,order=>$order,});\r\n#  &mk_url($params->{TMPL_VARS}{LIST},\'TABLE\');\r\n#}',6),
(7100,'Поиск по сайту',761,'^\\/search$','$params->{TMPL_VARS}->{promo}->{title}=\'Поиск по сайту\'	unless($params->{TMPL_VARS}->{promo}->{title});\r\n$params->{TMPL_VARS}->{page_type}=\'search\';\r\n\r\n$params->{TMPL_VARS}{Q}=param(\'search\');\r\n$params->{TMPL_VARS}{add_params}=\'?search=\'.param(\'search\');\r\n\r\nif(param(\'search\')){\r\n  my $pid=\'4101\';\r\n  $params->{TMPL_VARS}{maxpage}=&CONTEXT_SEARCH({\r\n    to_tmpl=>\'LIST\',\r\n    pattern=>param(\'search\'),\r\n    perpage=>$params->{TMPL_VARS}->{const}->{perpage_search},\r\n    mark_tag=>\'<strong>,/\',\r\n    info=>[\r\n      # статика\r\n      {url=>\'url\',header=>\'header\',s_part=>q{concat(header,\' \',body)},table=>\'content\', where=>qq{url LIKE \'/%\' AND project_id=$params->{project}{project_id}},},\r\n      # каталог\r\n      {url=>&filter_get_url(qq{concat(\'/object/\',portfolio_id)}),table=>\'portfolio\',where=>\"project_id=$pid AND enabled=1\",header=>\'header\',s_part=>q{concat(header,\' \',anons,\' \',body)},},		 \r\n      # товары\r\n      {url=>&filter_get_url(qq{concat(\'/article/\',article_id)}),table=>\'struct_4101_article\',where=>\"project_id=$pid AND enabled=1\",header=>\'header\',s_part=>q{concat(header,\' \',anons,\' \',body)},},\r\n      # Услуги\r\n      {url=>&filter_get_url(qq{concat(\'/service/\',id)}),table=>\'service_rubricator\',where=>\"project_id=$pid AND enabled=1\",header=>\'header\',s_part=>q{concat(header,\' \',body)},},\r\n    ]\r\n  });\r\n}',7),
(7101,'Статика',761,'^(.*)$','my $url=$1;\r\nif(!$params->{TMPL_VARS}->{page_type}){ # Проверяем, есть ли текстовая страница по данному url\'у\r\n	if(\r\n		$params->{TMPL_VARS}->{content}=&GET_DATA({\r\n			table=>\'content\',\r\n			url=>$url,\r\n			onerow=>1\r\n		})\r\n	){\r\n		$params->{TMPL_VARS}->{title} = $params->{TMPL_VARS}->{content}->{header};\r\n		$params->{TMPL_VARS}->{page_type}=\'text\';\r\n		$params->{TMPL_VARS}->{promo}->{title}=$params->{TMPL_VARS}->{content}->{header}\r\n			unless($params->{TMPL_VARS}->{promo}->{title});\r\n	}\r\n}',10),
(7102,'Карта сайта',761,'^\\/map$','$params->{TMPL_VARS}->{promo}->{title}=\'Карта сайта\' unless($params->{TMPL_VARS}->{promo}->{title});\r\n$params->{TMPL_VARS}->{page_type}=\'map\';\r\n$tv=$params->{TMPL_VARS};\r\n&GET_DATA({struct=>\'service_rubricator\',tree_use=>\'1\',order=>\'sort\',where=>\'enabled=1\',});\r\n&mk_url($tv->{SERVICE},\'service\');\r\n\r\nforeach(@{$tv->{top_menu}}){\r\n  if($_->{url} eq \'/service\'){$_->{child}=$tv->{SERVICE};}\r\n}',8),
(7103,'Задать вопрос',761,'^\\/feedback$','$params->{TMPL_VARS}->{promo}->{title}=\'Задать вопрос\' unless($params->{TMPL_VARS}->{promo}->{title});\r\n$params->{TMPL_VARS}->{page_type}=\'form\';',9);
/*!40000 ALTER TABLE `url_run_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_rules`
--

DROP TABLE IF EXISTS `url_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `url_rules` (
  `url_rules_id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) DEFAULT NULL,
  `url_regexp` varchar(200) NOT NULL DEFAULT '',
  `template_name` varchar(200) NOT NULL DEFAULT '',
  `header` text NOT NULL,
  `sort` tinyint(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`url_rules_id`),
  KEY `template_id` (`template_id`),
  CONSTRAINT `url_rules_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1246 DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_rules`
--
-- WHERE:  template_id=761

LOCK TABLES `url_rules` WRITE;
/*!40000 ALTER TABLE `url_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `url_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capture_setting`
--

DROP TABLE IF EXISTS `capture_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `capture_setting` (
  `template_id` int(11) NOT NULL DEFAULT 0,
  `width` varchar(3) DEFAULT NULL,
  `height` varchar(3) DEFAULT NULL,
  `deg1_from` varchar(2) DEFAULT NULL,
  `deg1_to` varchar(2) DEFAULT NULL,
  `deg2_from` varchar(2) DEFAULT NULL,
  `deg2_to` varchar(2) DEFAULT NULL,
  `background` varchar(7) DEFAULT NULL,
  `color` varchar(7) DEFAULT NULL,
  `fontsize` varchar(2) DEFAULT NULL,
  `chars_count` tinyint(1) DEFAULT 6,
  `method` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`template_id`),
  CONSTRAINT `capture_setting_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `template` (`template_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capture_setting`
--
-- WHERE:  template_id=761

LOCK TABLES `capture_setting` WRITE;
/*!40000 ALTER TABLE `capture_setting` DISABLE KEYS */;
INSERT INTO `capture_setting` VALUES
(761,'80','50','0','0','0','0','','','',1,1);
/*!40000 ALTER TABLE `capture_setting` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-18 12:16:59
