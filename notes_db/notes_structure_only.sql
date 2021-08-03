/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `notes` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `notes`;

CREATE TABLE IF NOT EXISTS `dbmaintain_scripts` (
  `file_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `file_last_modified_at` bigint DEFAULT NULL,
  `checksum` varchar(50) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `executed_at` varchar(20) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `succeeded` bigint DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `document` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6246 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `documentnote` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdOn` bigint NOT NULL,
  `deleted` bit(1) NOT NULL,
  `fullSelection` text CHARACTER SET utf8 COLLATE utf8_swedish_ci,
  `lemmaPosition` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `position` int NOT NULL,
  `publishable` bit(1) NOT NULL,
  `revision` bigint DEFAULT NULL,
  `shortenedSelection` varchar(1024) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `document_id` bigint DEFAULT NULL,
  `note_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_DOCUMENTNOTE_NOTEID` (`note_id`),
  KEY `FK_DOCUMENTNOTE_DOCUMENTID` (`document_id`),
  KEY `del_pub_idx` (`deleted`,`publishable`),
  KEY `del_rev` (`deleted`,`revision`),
  CONSTRAINT `documentnote_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`),
  CONSTRAINT `documentnote_ibfk_2` FOREIGN KEY (`note_id`) REFERENCES `note` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53803 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `note` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` text CHARACTER SET utf8 COLLATE utf8_swedish_ci,
  `documentNoteCount` int NOT NULL,
  `editedOn` bigint DEFAULT NULL,
  `format` enum('NOTE','PLACE','PERSON') CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `lemma` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `lemmaMeaning` text CHARACTER SET utf8 COLLATE utf8_swedish_ci,
  `sources` text CHARACTER SET utf8 COLLATE utf8_swedish_ci,
  `subtextSources` text CHARACTER SET utf8 COLLATE utf8_swedish_ci,
  `lastEditedBy_id` bigint DEFAULT NULL,
  `person_id` bigint DEFAULT NULL,
  `place_id` bigint DEFAULT NULL,
  `term_id` bigint DEFAULT NULL,
  `deleted` bit(1) NOT NULL,
  `status` enum('DRAFT','FINISHED') CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_NOTE_LASTEDITEDBYID` (`lastEditedBy_id`),
  KEY `FK_NOTE_PLACEID` (`place_id`),
  KEY `FK_NOTE_PERSONID` (`person_id`),
  KEY `FK_NOTE_TERMID` (`term_id`),
  KEY `count_idx` (`documentNoteCount`),
  KEY `note_format_idx` (`format`),
  KEY `lemmaindex` (`lemma`),
  CONSTRAINT `FK_NOTE_LASTEDITEDBYID` FOREIGN KEY (`lastEditedBy_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_NOTE_PERSONID` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `FK_NOTE_PLACEID` FOREIGN KEY (`place_id`) REFERENCES `place` (`id`),
  CONSTRAINT `FK_NOTE_TERMID` FOREIGN KEY (`term_id`) REFERENCES `term` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47025 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `notecomment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime DEFAULT NULL,
  `message` text CHARACTER SET utf8 COLLATE utf8_swedish_ci,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `note_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_NOTECOMMENT_NOTEID` (`note_id`),
  KEY `created_idx` (`createdAt`),
  CONSTRAINT `FK_NOTECOMMENT_NOTEID` FOREIGN KEY (`note_id`) REFERENCES `note` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `note_types` (
  `Note_id` bigint NOT NULL,
  `types` enum('WORD_EXPLANATION','LITERARY','HISTORICAL','DICTUM','CRITIQUE','TITLE','TRANSLATION','REFERENCE') CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  KEY `FK_NOTETYPES_NOTEID` (`Note_id`),
  KEY `note_types_idx` (`types`),
  CONSTRAINT `FK_NOTETYPES_NOTEID` FOREIGN KEY (`Note_id`) REFERENCES `note` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `note_user` (
  `Note_id` bigint NOT NULL,
  `allEditors_id` bigint NOT NULL,
  PRIMARY KEY (`Note_id`,`allEditors_id`),
  KEY `FK_NOTEUSER_NOTEID` (`Note_id`),
  KEY `FK_NOTEUSER_ALLEDITORSID` (`allEditors_id`),
  CONSTRAINT `FK_NOTEUSER_ALLEDITORSID` FOREIGN KEY (`allEditors_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_NOTEUSER_NOTEID` FOREIGN KEY (`Note_id`) REFERENCES `note` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `person` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `time_of_birth_end` datetime DEFAULT NULL,
  `time_of_birth_start` datetime DEFAULT NULL,
  `time_of_death_end` datetime DEFAULT NULL,
  `time_of_death_start` datetime DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_swedish_ci,
  `first` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `last` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `person_nameform` (
  `person_id` bigint NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_swedish_ci,
  `first` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `last` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  KEY `FK_NAMEFORM_PERSONID` (`person_id`),
  KEY `person_nameform_idx` (`person_id`),
  KEY `person_nameform_last_idx` (`last`),
  CONSTRAINT `FK_NAMEFORM_PERSONID` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `place` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` text CHARACTER SET utf8 COLLATE utf8_swedish_ci,
  `first` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `last` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `place_nameform` (
  `place_id` bigint NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_swedish_ci,
  `first` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `last` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  KEY `FK_NAMEFORM_PLACEID` (`place_id`),
  KEY `place_nameform_idx` (`place_id`),
  KEY `place_nameform_last_idx` (`last`),
  CONSTRAINT `FK_NAMEFORM_PLACEID` FOREIGN KEY (`place_id`) REFERENCES `place` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `term` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `basicForm` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `language` enum('FINNISH','SWEDISH','FRENCH','LATIN','GERMAN','RUSSIAN','ENGLISH','ITALIAN','GREEK','OTHER') CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `meaning` text CHARACTER SET utf8 COLLATE utf8_swedish_ci,
  `otherLanguage` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `basic_form_idx` (`basicForm`),
  KEY `term_lang_idx` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=98752 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `firstName` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `lastName` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `profile` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
