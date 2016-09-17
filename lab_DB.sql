/*
SQLyog v10.2 
MySQL - 5.1.71-community : Database - lab
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`lab` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `lab`;

/*Table structure for table `announce` */

DROP TABLE IF EXISTS `announce`;

CREATE TABLE `announce` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) DEFAULT NULL,
  `content` text,
  `userName` varchar(30) DEFAULT NULL,
  `addTime` varchar(60) DEFAULT NULL,
  `url` varchar(120) DEFAULT NULL,
  `fileName` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Table structure for table `course` */

DROP TABLE IF EXISTS `course`;

CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courseNumber` varchar(11) DEFAULT NULL,
  `courseName` varchar(30) DEFAULT NULL,
  `term` varchar(10) DEFAULT NULL,
  `userId` varchar(30) DEFAULT NULL,
  `addTime` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `material` */

DROP TABLE IF EXISTS `material`;

CREATE TABLE `material` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL,
  `url` varchar(120) DEFAULT NULL,
  `userId` varchar(30) DEFAULT NULL,
  `addTime` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=431 DEFAULT CHARSET=utf8;

/*Table structure for table `register` */

DROP TABLE IF EXISTS `register`;

CREATE TABLE `register` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(30) NOT NULL,
  `userName` varchar(30) NOT NULL,
  `academy` varchar(30) DEFAULT NULL,
  `grade` varchar(30) DEFAULT NULL,
  `discipline` varchar(60) DEFAULT NULL,
  `cls` varchar(30) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `password` varchar(30) NOT NULL,
  `teacherId` varchar(30) DEFAULT NULL,
  `state` varchar(30) DEFAULT 'no',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`),
  UNIQUE KEY `userId_2` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `software` */

DROP TABLE IF EXISTS `software`;

CREATE TABLE `software` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(30) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  `uuid` varchar(60) DEFAULT NULL,
  `url` varchar(120) DEFAULT NULL,
  `addTime` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;

/*Table structure for table `studentcourse` */

DROP TABLE IF EXISTS `studentcourse`;

CREATE TABLE `studentcourse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teacherCourseId` int(11) DEFAULT NULL,
  `studentId` varchar(30) DEFAULT NULL,
  `addTime` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teacherCourseId` (`teacherCourseId`,`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `task` */

DROP TABLE IF EXISTS `task`;

CREATE TABLE `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teacherCourseId` int(11) DEFAULT NULL,
  `fileNameF` varchar(60) DEFAULT NULL,
  `uuid` varchar(60) DEFAULT NULL,
  `url` varchar(120) DEFAULT NULL,
  `workDir` varchar(120) DEFAULT NULL,
  `taskName` varchar(30) DEFAULT NULL,
  `addTime` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `teachercourse` */

DROP TABLE IF EXISTS `teachercourse`;

CREATE TABLE `teachercourse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courseId` int(11) DEFAULT NULL,
  `teacherId` varchar(30) DEFAULT NULL,
  `addTime` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courseId` (`courseId`,`teacherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tem` */

DROP TABLE IF EXISTS `tem`;

CREATE TABLE `tem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(120) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `addTime` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(30) DEFAULT NULL,
  `userName` varchar(30) DEFAULT NULL,
  `academy` varchar(30) DEFAULT NULL,
  `grade` varchar(30) DEFAULT NULL,
  `discipline` varchar(30) DEFAULT NULL,
  `cls` varchar(30) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `securityQuestion` varchar(10) DEFAULT NULL,
  `answer` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`),
  UNIQUE KEY `userId_2` (`userId`),
  UNIQUE KEY `userId_3` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=14099 DEFAULT CHARSET=utf8;

/*Table structure for table `work` */

DROP TABLE IF EXISTS `work`;

CREATE TABLE `work` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskId` int(11) DEFAULT NULL,
  `studentCourseId` int(11) DEFAULT NULL,
  `studentId` varchar(30) DEFAULT NULL,
  `workName` varchar(60) DEFAULT NULL,
  `url` varchar(120) DEFAULT NULL,
  `addTime` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
