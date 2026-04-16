-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 111.230.212.169    Database: blog
-- ------------------------------------------------------
-- Server version	9.0.1

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
-- Table structure for table `about`
--

DROP TABLE IF EXISTS `about`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `about` (
  `id` bigint NOT NULL,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name_zh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `about`
--

LOCK TABLES `about` WRITE;
/*!40000 ALTER TABLE `about` DISABLE KEYS */;
INSERT INTO `about` VALUES (1,'title','标题','关于Kcbjt'),(2,'musicId','网易云歌曲ID','1874972712'),(3,'content','正文Markdown',''),(4,'commentEnabled','评论开关','true');
/*!40000 ALTER TABLE `about` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章标题',
  `first_picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章首图，用于随机文章展示',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章正文',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '描述',
  `is_published` bit(1) NOT NULL COMMENT '公开或私密',
  `is_recommend` bit(1) NOT NULL COMMENT '推荐开关',
  `is_appreciation` bit(1) NOT NULL COMMENT '赞赏开关',
  `is_comment_enabled` bit(1) NOT NULL COMMENT '评论开关',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `views` int NOT NULL COMMENT '浏览次数',
  `words` int NOT NULL COMMENT '文章字数',
  `read_time` int NOT NULL COMMENT '阅读时长(分钟)',
  `category_id` bigint NOT NULL COMMENT '文章分类',
  `is_top` bit(1) NOT NULL COMMENT '是否置顶',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码保护',
  `user_id` bigint DEFAULT NULL COMMENT '文章作者',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_id` (`category_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
INSERT INTO `blog` VALUES (1,'test','https://cdn.naccl.top/blog/blogHosting/2025/01/B01/daeb470d-8829-45a2-b5a3-beea8ab2e5a8.jpg','Test','![daeb470d-8829-45a2-b5a3-beea8ab2e5a8.jpg](https://cdn.naccl.top/blog/blogHosting/2025/01/B01/daeb470d-8829-45a2-b5a3-beea8ab2e5a8.jpg)',_binary '',_binary '\0',_binary '\0',_binary '','2026-04-14 20:34:25','2026-04-15 01:13:03',1,6,0,1,_binary '\0','',1),(3,'test1','http://111.230.212.169:9000/kcbjt/blog/web.png','test1','![web.png](http://111.230.212.169:9000/kcbjt/blog/web.png)',_binary '',_binary '',_binary '\0',_binary '\0','2026-04-15 11:54:56','2026-04-15 13:47:48',1,6,0,1,_binary '\0','',1);
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_tag`
--

DROP TABLE IF EXISTS `blog_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_tag` (
  `blog_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_tag`
--

LOCK TABLES `blog_tag` WRITE;
/*!40000 ALTER TABLE `blog_tag` DISABLE KEYS */;
INSERT INTO `blog_tag` VALUES (1,1),(3,1);
/*!40000 ALTER TABLE `blog_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'test');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city_visitor`
--

DROP TABLE IF EXISTS `city_visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city_visitor` (
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '城市名称',
  `uv` int NOT NULL COMMENT '独立访客数量',
  PRIMARY KEY (`city`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city_visitor`
--

LOCK TABLES `city_visitor` WRITE;
/*!40000 ALTER TABLE `city_visitor` DISABLE KEYS */;
/*!40000 ALTER TABLE `city_visitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论内容',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像(图片路径)',
  `create_time` datetime DEFAULT NULL COMMENT '评论时间',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '评论者ip地址',
  `is_published` bit(1) NOT NULL COMMENT '公开或回收站',
  `is_admin_comment` bit(1) NOT NULL COMMENT '博主回复',
  `page` int NOT NULL COMMENT '0普通文章，1关于我页面，2友链页面',
  `is_notice` bit(1) NOT NULL COMMENT '接收邮件提醒',
  `blog_id` bigint DEFAULT NULL COMMENT '所属的文章',
  `parent_comment_id` bigint NOT NULL COMMENT '父评论id，-1为根评论',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '个人网站',
  `qq` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '如果评论昵称为QQ号，则将昵称和头像置为QQ昵称和QQ头像，并将此字段置为QQ号备份',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exception_log`
--

DROP TABLE IF EXISTS `exception_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exception_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求参数',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作描述',
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '异常信息',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exception_log`
--

LOCK TABLES `exception_log` WRITE;
/*!40000 ALTER TABLE `exception_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `exception_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend`
--

DROP TABLE IF EXISTS `friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '描述',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '站点',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像',
  `is_published` bit(1) NOT NULL COMMENT '公开或隐藏',
  `views` int NOT NULL COMMENT '点击次数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend`
--

LOCK TABLES `friend` WRITE;
/*!40000 ALTER TABLE `friend` DISABLE KEYS */;
/*!40000 ALTER TABLE `friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_log`
--

DROP TABLE IF EXISTS `login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名称',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器',
  `status` bit(1) DEFAULT NULL COMMENT '登录状态',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作描述',
  `create_time` datetime NOT NULL COMMENT '登录时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_log`
--

LOCK TABLES `login_log` WRITE;
/*!40000 ALTER TABLE `login_log` DISABLE KEYS */;
INSERT INTO `login_log` VALUES (1,'Visitor','192.168.237.1','内网IP|内网IP','Windows >=10','Edge 146',_binary '\0','nested exception is org.apache.ibatis.exceptions.P','2026-04-14 20:20:12','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),(2,'Admin','192.168.237.1','内网IP|内网IP','Windows >=10','Edge 146',_binary '','登录成功','2026-04-14 20:27:45','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),(3,'Admin','192.168.237.1','内网IP|内网IP','Windows >=10','Edge 147',_binary '','登录成功','2026-04-15 17:56:35','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0'),(4,'Admin','192.168.237.1','内网IP|内网IP','Windows >=10','Edge 147',_binary '','登录成功','2026-04-16 12:33:54','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0');
/*!40000 ALTER TABLE `login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moment`
--

DROP TABLE IF EXISTS `moment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '动态内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `likes` int DEFAULT NULL COMMENT '点赞数量',
  `is_published` bit(1) NOT NULL COMMENT '是否公开',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moment`
--

LOCK TABLES `moment` WRITE;
/*!40000 ALTER TABLE `moment` DISABLE KEYS */;
/*!40000 ALTER TABLE `moment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation_log`
--

DROP TABLE IF EXISTS `operation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operation_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作者用户名',
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求参数',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作描述',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器',
  `times` int NOT NULL COMMENT '请求耗时（毫秒）',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_log`
--

LOCK TABLES `operation_log` WRITE;
/*!40000 ALTER TABLE `operation_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `operation_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_job`
--

DROP TABLE IF EXISTS `schedule_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '方法名',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数',
  `cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint DEFAULT NULL COMMENT '任务状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_job`
--

LOCK TABLES `schedule_job` WRITE;
/*!40000 ALTER TABLE `schedule_job` DISABLE KEYS */;
INSERT INTO `schedule_job` VALUES (1,'redisSyncScheduleTask','syncBlogViewsToDatabase','','0 0 1 * * ?',1,'每天凌晨一点，从Redis将博客浏览量同步到数据库','2020-11-17 23:45:42'),(2,'visitorSyncScheduleTask','syncVisitInfoToDatabase','','0 0 0 * * ?',1,'清空当天Redis访客标识，记录当天的PV和UV，更新当天所有访客的PV和最后访问时间，更新城市新增访客UV数','2021-02-05 08:14:28');
/*!40000 ALTER TABLE `schedule_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_job_log`
--

DROP TABLE IF EXISTS `schedule_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule_job_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint NOT NULL COMMENT '任务id',
  `bean_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '方法名',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数',
  `status` tinyint NOT NULL COMMENT '任务执行结果',
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '异常信息',
  `times` int NOT NULL COMMENT '耗时（单位：毫秒）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_job_log`
--

LOCK TABLES `schedule_job_log` WRITE;
/*!40000 ALTER TABLE `schedule_job_log` DISABLE KEYS */;
INSERT INTO `schedule_job_log` VALUES (1,2,'visitorSyncScheduleTask','syncVisitInfoToDatabase','',1,NULL,266,'2026-04-15 00:00:00'),(2,2,'visitorSyncScheduleTask','syncVisitInfoToDatabase','',0,'java.util.concurrent.ExecutionException: java.lang.RuntimeException: 执行定时任务失败',19155,'2026-04-16 00:00:00'),(3,1,'redisSyncScheduleTask','syncBlogViewsToDatabase','',0,'java.util.concurrent.ExecutionException: java.lang.RuntimeException: 执行定时任务失败',19170,'2026-04-16 01:00:00'),(4,2,'visitorSyncScheduleTask','syncVisitInfoToDatabase','',1,NULL,197,'2026-04-16 08:00:00'),(5,1,'redisSyncScheduleTask','syncBlogViewsToDatabase','',1,NULL,108,'2026-04-16 09:00:00');
/*!40000 ALTER TABLE `schedule_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_setting`
--

DROP TABLE IF EXISTS `site_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_setting` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name_zh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `type` int DEFAULT NULL COMMENT '1基础设置，2页脚徽标，3资料卡，4友链信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_setting`
--

LOCK TABLES `site_setting` WRITE;
/*!40000 ALTER TABLE `site_setting` DISABLE KEYS */;
INSERT INTO `site_setting` VALUES (1,'blogName','博客名称','kcbjt\'s Blog',1),(2,'webTitleSuffix','网页标题后缀',' - kcbjt\'s Blog',1),(3,'footerImgTitle','页脚图片标题','手机看本站',1),(4,'footerImgUrl','页脚图片路径','/img/qr.png',1),(5,'copyright','Copyright','{\"title\":\"Copyright © 2026 - 2026\",\"siteName\":kcbjt\'S BLOG\"}',1),(6,'beian','ICP备案号','',1),(7,'reward','赞赏码','/img/reward.jpg',1),(8,'commentAdminFlag','博主评论标识','咕咕',1),(9,'playlistServer','播放器平台','netease',1),(10,'playlistId','播放器歌单','376781229',1),(11,'avatar','头像','/img/avatar.jpg',2),(12,'name','昵称','kcbjt',2),(13,'rollText','滚动个签','\"花有重开日，人无在少年\",\"春分若有怜花意，可否许我再少年\"',2),(14,'github','GitHub','https://github.com/kcbjt',2),(15,'telegram','Telegram','https://t.me/NacclOfficial',2),(16,'qq','QQ','http://sighttp.qq.com/authd?IDKEY=',2),(17,'bilibili','bilibili','https://space.bilibili.com/85643610',2),(18,'netease','网易云音乐','https://music.163.com/#/user/home?id=274633164',2),(19,'email','email','11@qq.com',2),(20,'favorite','自定义','{\"title\":\"最喜欢的动漫 📺\",\"content\":\"狐妖小红娘、鬼灭之刃、剑来、凡人修仙传\"}',2),(22,'favorite','自定义','{\"title\":\"在玩游戏 🎮\",\"content\":\"王者荣耀\"}',2),(23,'badge','徽标','{\"title\":\"本博客已开源于 GitHub\",\"url\":\"https://github.com/Naccl/NBlog\",\"subject\":\"NBlog\",\"value\":\"Open Source\",\"color\":\"brightgreen\"}',3),(24,'badge','徽标','{\"title\":\"由 Spring Boot 强力驱动\",\"url\":\"https://spring.io/projects/spring-boot/\",\"subject\":\"Powered\",\"value\":\"Spring Boot\",\"color\":\"blue\"}',3),(25,'badge','徽标','{\"title\":\"Vue.js 客户端渲染\",\"url\":\"https://cn.vuejs.org/\",\"subject\":\"SPA\",\"value\":\"Vue.js\",\"color\":\"brightgreen\"}',3),(26,'badge','徽标','{\"title\":\"UI 框架 Semantic-UI\",\"url\":\"https://semantic-ui.com/\",\"subject\":\"UI\",\"value\":\"Semantic-UI\",\"color\":\"semantic-ui\"}',3),(27,'badge','徽标','{\"title\":\"阿里云提供服务器及域名相关服务\",\"url\":\"https://www.aliyun.com/\",\"subject\":\"VPS & DNS\",\"value\":\"Aliyun\",\"color\":\"blueviolet\"}',3),(28,'badge','徽标','{\"title\":\"静态资源托管于 GitHub\",\"url\":\"https://github.com/\",\"subject\":\"OSS\",\"value\":\"GitHub\",\"color\":\"github\"}',3),(29,'badge','徽标','{\"title\":\"jsDelivr 加速静态资源\",\"url\":\"https://www.jsdelivr.com/\",\"subject\":\"CDN\",\"value\":\"jsDelivr\",\"color\":\"orange\"}',3),(30,'badge','徽标','{\"color\":\"lightgray\",\"subject\":\"CC\",\"title\":\"本站点采用 CC BY 4.0 国际许可协议进行许可\",\"url\":\"https://creativecommons.org/licenses/by/4.0/\",\"value\":\"BY 4.0\"}',3),(31,'friendContent','友链页面信息','随机排序，不分先后。欢迎交换友链~(￣▽￣)~*\n\n* 昵称：kcbjt\n* 一句话：游龙当归海，海不迎我自来也。\n* 网址：[kcbjt\'s blog](http://kcbjt.com/blog)\n* 头像：[avatar.jpg](http://111.230.212.169:9000/kcbjt/blog/avatar.jpg)\n\n仅凭个人喜好添加友链，请在收到我的回复邮件后再于贵站添加本站链接。原则上已添加的友链不会删除，如果你发现自己被移除了，恕不另行通知，只需和我一样做就好。\n\n',4),(32,'friendCommentEnabled','友链页面评论开关','1',4);
/*!40000 ALTER TABLE `site_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标签颜色(可选)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'test',NULL);
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像地址',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色访问权限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Admin','$2a$10$4wnwMW8Z4Bn6wR4K1YlbquQunlHM/4rvudVBX8oyfx16xeVtI6i7C','Admin','/img/avatar.jpg','admin@naccl.top','2020-09-21 16:47:18','2020-09-21 16:47:22','ROLE_admin');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_log`
--

DROP TABLE IF EXISTS `visit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '访客标识码',
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求参数',
  `behavior` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '访问行为',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '访问内容',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器',
  `times` int NOT NULL COMMENT '请求耗时（毫秒）',
  `create_time` datetime NOT NULL COMMENT '访问时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_log`
--

LOCK TABLES `visit_log` WRITE;
/*!40000 ALTER TABLE `visit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_record`
--

DROP TABLE IF EXISTS `visit_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pv` int NOT NULL COMMENT '访问量',
  `uv` int NOT NULL COMMENT '独立用户',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日期"02-23"',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_record`
--

LOCK TABLES `visit_record` WRITE;
/*!40000 ALTER TABLE `visit_record` DISABLE KEYS */;
INSERT INTO `visit_record` VALUES (1,0,0,'04-14'),(2,52,2,'04-15');
/*!40000 ALTER TABLE `visit_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitor`
--

DROP TABLE IF EXISTS `visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '访客标识码',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器',
  `create_time` datetime NOT NULL COMMENT '首次访问时间',
  `last_time` datetime NOT NULL COMMENT '最后访问时间',
  `pv` int DEFAULT NULL COMMENT '访问页数统计',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_uuid` (`uuid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitor`
--

LOCK TABLES `visitor` WRITE;
/*!40000 ALTER TABLE `visitor` DISABLE KEYS */;
INSERT INTO `visitor` VALUES (1,'120013a3-2497-35ca-be6c-483d2d197d6b','192.168.237.1','内网IP|内网IP','Windows >=10','Edge 146','2026-04-14 20:31:30','2026-04-15 18:03:08',51,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),(2,'4da31e19-1fa7-36ad-b02c-cbf460017cb0','192.168.237.1','内网IP|内网IP','Windows >=10','Edge 147','2026-04-15 19:15:09','2026-04-15 19:15:09',1,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0');
/*!40000 ALTER TABLE `visitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'blog'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-16 12:44:14
