/*
MySQL Backup
Source Server Version: 5.6.38
Source Database: issue
Date: 2018/4/9 星期一 22:39:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `department`
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `code_number` int(11) NOT NULL,
  `edate` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_department_edate` (`edate`),
  KEY `ix_department_code_number` (`code_number`),
  KEY `ix_department_name` (`name`),
  KEY `ix_department_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `hosts`
-- ----------------------------
DROP TABLE IF EXISTS `hosts`;
CREATE TABLE `hosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hoatname` varchar(32) NOT NULL,
  `ip` varchar(32) NOT NULL,
  `port` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_hosts_ip` (`ip`),
  KEY `ix_hosts_hoatname` (`hoatname`),
  KEY `ix_hosts_project_id` (`project_id`),
  KEY `ix_hosts_port` (`port`),
  KEY `ix_hosts_id` (`id`),
  CONSTRAINT `hosts_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `project`
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `git_addr` varchar(120) NOT NULL,
  `online_path` varchar(120) NOT NULL,
  `introduce` text NOT NULL,
  `edatetime` datetime NOT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  KEY `ix_project_git_addr` (`git_addr`),
  KEY `ix_project_online_path` (`online_path`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `release`
-- ----------------------------
DROP TABLE IF EXISTS `release`;
CREATE TABLE `release` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `types` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `ix_release_status` (`status`),
  KEY `ix_release_project_id` (`project_id`),
  KEY `ix_release_types` (`types`),
  KEY `ix_release_id` (`id`),
  CONSTRAINT `release_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `release_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `releaselog`
-- ----------------------------
DROP TABLE IF EXISTS `releaselog`;
CREATE TABLE `releaselog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logdatetime` datetime NOT NULL,
  `release_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_releaselog_release_id` (`release_id`),
  KEY `ix_releaselog_logdatetime` (`logdatetime`),
  KEY `ix_releaselog_id` (`id`),
  CONSTRAINT `releaselog_ibfk_1` FOREIGN KEY (`release_id`) REFERENCES `release` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `pwd` varchar(32) NOT NULL,
  `department_id` int(11) NOT NULL,
  `rdatetime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  KEY `ix_user_name` (`name`),
  KEY `ix_user_id` (`id`),
  KEY `ix_user_rdatetime` (`rdatetime`),
  KEY `ix_user_pwd` (`pwd`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `department` VALUES ('1','python','1001','2018-04-09');
INSERT INTO `project` VALUES ('1','博客系统','https://www.project_1.com','D:\\s7\\day150\\issue\\views','这是一个我自己都不知道的无含量的项目','2018-04-09 21:22:23','1'), ('2','crm','https://www.crm.com','D:\\s7\\day150\\issue\\views','这个稍微有些技术含量，比博客系统强多了','2018-04-09 21:48:53','1');
INSERT INTO `release` VALUES ('1','1','1','1','1'), ('2',NULL,'2','2','2');
INSERT INTO `releaselog` VALUES ('1','2018-04-09 21:57:23','1'), ('2','2018-04-09 21:57:32','2');
INSERT INTO `user` VALUES ('1','海燕','520','1','2018-04-09 21:19:55');
