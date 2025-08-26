-- Alumni Management System (Spring Boot + MySQL)
-- Compatible with your existing column names and FKs.
-- NOTE: Sample data is different from the one you shared.

-- ===== Fresh DB =====
DROP DATABASE IF EXISTS `alumni-mgt-sys-spb`;
CREATE DATABASE `alumni-mgt-sys-spb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `alumni-mgt-sys-spb`;

SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
SET @@foreign_key_checks = 0;

-- ===== Core tables (parents first to satisfy FKs) =====

-- Admin (you had DROP admin but no CREATE—adding a minimal table)
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(225) NOT NULL,
  `email`    VARCHAR(225) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Alumni
DROP TABLE IF EXISTS `alumni`;
CREATE TABLE `alumni` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `address`     VARCHAR(225) DEFAULT NULL,
  `contact_no`  VARCHAR(225) DEFAULT NULL,
  `course_name` VARCHAR(225) DEFAULT NULL,
  `dob`         DATE DEFAULT NULL,
  `email_id`    VARCHAR(225) DEFAULT NULL,
  `gender`      VARCHAR(225) DEFAULT NULL,
  `message`     VARCHAR(225) DEFAULT NULL,
  `name`        VARCHAR(225) DEFAULT NULL,
  `occupation`  VARCHAR(225) DEFAULT NULL,
  `password`    VARCHAR(225) DEFAULT NULL,
  `region`      VARCHAR(225) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Staff (note: keeping your original column name typo `eamil` for compatibility)
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `address`      VARCHAR(755) DEFAULT NULL,
  `contact_no`   VARCHAR(755) DEFAULT NULL,
  `designation`  VARCHAR(755) DEFAULT NULL,
  `dob`          DATE DEFAULT NULL,
  `eamil`        VARCHAR(755) DEFAULT NULL,
  `join_date`    DATE DEFAULT NULL,
  `name`         VARCHAR(225) DEFAULT NULL,
  `password`     VARCHAR(755) DEFAULT NULL,
  `qualification`VARCHAR(755) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Event
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `admin_id`  BIGINT DEFAULT NULL,
  `alumni_id` BIGINT DEFAULT NULL,
  `description` VARCHAR(755) DEFAULT NULL,
  `event_date`  DATE DEFAULT NULL,
  `event_time`  VARCHAR(255) DEFAULT NULL,
  `location`    VARCHAR(755) DEFAULT NULL,
  `staff_id`    BIGINT DEFAULT NULL,
  `status`      VARCHAR(755) DEFAULT NULL,
  `title`       VARCHAR(225) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Job
DROP TABLE IF EXISTS `job`;
CREATE TABLE `job` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `alumni_id` BIGINT NOT NULL,
  `company_name`        VARCHAR(755) DEFAULT NULL,
  `description`         VARCHAR(2000) DEFAULT NULL,
  `experience_required` VARCHAR(755) DEFAULT NULL,
  `job_package`         VARCHAR(755) DEFAULT NULL,
  `last_date`           DATE DEFAULT NULL,
  `location`            VARCHAR(1500) DEFAULT NULL,
  `no_of_vaccancy`      VARCHAR(755) DEFAULT NULL,
  `qualification`       VARCHAR(755) DEFAULT NULL,
  `reference_email`     VARCHAR(755) DEFAULT NULL,
  `skills`              VARCHAR(755) DEFAULT NULL,
  `title`               VARCHAR(755) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ===== Child tables (with FKs) =====

-- Apply Job (keeps both your `job_id`/`job_name` columns AND the FK column `job`)
DROP TABLE IF EXISTS `apply_job`;
CREATE TABLE `apply_job` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `contact_no` VARCHAR(225) DEFAULT NULL,
  `email`      VARCHAR(225) DEFAULT NULL,
  `resume_file` LONGBLOB,
  `job_id` BIGINT DEFAULT NULL,
  `job_name` VARCHAR(225) DEFAULT NULL,
  `name` VARCHAR(225) DEFAULT NULL,
  `job` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_apply_job_job` (`job`),
  CONSTRAINT `FK_apply_job_job` FOREIGN KEY (`job`) REFERENCES `job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Gallary (sic) – image(s) per event
DROP TABLE IF EXISTS `gallary`;
CREATE TABLE `gallary` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `event_id` BIGINT DEFAULT NULL,
  `event_image` LONGBLOB,
  `event` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_gallary_event` (`event`),
  CONSTRAINT `FK_gallary_event` FOREIGN KEY (`event`) REFERENCES `event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Participant
DROP TABLE IF EXISTS `participant`;
CREATE TABLE `participant` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `contact_no` VARCHAR(225) DEFAULT NULL,
  `event_id` BIGINT DEFAULT NULL,
  `event_name` VARCHAR(225) DEFAULT NULL,
  `name` VARCHAR(225) DEFAULT NULL,
  `user_id` BIGINT DEFAULT NULL,
  `event` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_participant_event` (`event`),
  CONSTRAINT `FK_participant_event` FOREIGN KEY (`event`) REFERENCES `event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Feed Back
DROP TABLE IF EXISTS `feed_back`;
CREATE TABLE `feed_back` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `feed_back` VARCHAR(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Placement
DROP TABLE IF EXISTS `placement`;
CREATE TABLE `placement` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `company_name`  VARCHAR(225) DEFAULT NULL,
  `placement_date` DATE DEFAULT NULL,
  `image` LONGBLOB,
  `job_package` VARCHAR(225) DEFAULT NULL,
  `location` VARCHAR(255) DEFAULT NULL,
  `name` VARCHAR(225) DEFAULT NULL,
  `post` VARCHAR(225) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET @@foreign_key_checks = 1;

-- ===== Sample Data (different from your original) =====

-- Admin
INSERT INTO `admin` (`username`,`password`,`email`)
VALUES ('superadmin','Admin@123','admin@example.com');

-- Alumni
INSERT INTO `alumni`
(`address`,`contact_no`,`course_name`,`dob`,`email_id`,`gender`,`message`,`name`,`occupation`,`password`,`region`)
VALUES
('221B Baker Street, London','9876543210','B.Tech CSE','1998-05-20','alice.wong@alumni.test','Female','Excited to reconnect!','Alice Wong','Software Engineer','Alumni@123','Europe');

-- Staff
INSERT INTO `staff`
(`address`,`contact_no`,`designation`,`dob`,`eamil`,`join_date`,`name`,`password`,`qualification`)
VALUES
('Campus Block A','9123456789','Coordinator','1990-02-14','staff.coordinator@ams.test','2023-08-01','Rahul Mehta','Staff@123','MBA');

-- Event
INSERT INTO `event`
(`admin_id`,`alumni_id`,`description`,`event_date`,`event_time`,`location`,`staff_id`,`status`,`title`)
VALUES
(1, NULL, 'Annual alumni reunion with networking sessions', '2025-12-15', '17:30', 'Main Auditorium', 1, 'Active', 'Alumni Reunion 2025');

-- Job
INSERT INTO `job`
(`alumni_id`,`company_name`,`description`,`experience_required`,`job_package`,`last_date`,`location`,`no_of_vaccancy`,`qualification`,`reference_email`,`skills`,`title`)
VALUES
(1,'Nimbus Tech Pvt Ltd','Backend role in Spring Boot microservices','1-2 Years','6 LPA','2025-10-30','Remote / Pune','3','B.Tech CS/IT','ref@nimbustech.test','Java, Spring Boot, MySQL','Junior Java Developer');

-- Apply Job (resume_file left NULL for portability)
INSERT INTO `apply_job`
(`contact_no`,`email`,`resume_file`,`job_id`,`job_name`,`name`,`job`)
VALUES
('9000001111','alice.wong@alumni.test',NULL,1,'Junior Java Developer','Alice Wong',1);

-- Gallary (image left NULL)
INSERT INTO `gallary` (`event_id`,`event_image`,`event`)
VALUES (1, NULL, 1);

-- Participant
INSERT INTO `participant`
(`contact_no`,`event_id`,`event_name`,`name`,`user_id`,`event`)
VALUES
('9876543210',1,'Alumni Reunion 2025','Alice Wong',1,1);

-- Feed Back
INSERT INTO `feed_back` (`feed_back`)
VALUES ('Loving the new AMS portal layout and features!');

-- Placement (image left NULL)
INSERT INTO `placement`
(`company_name`,`placement_date`,`image`,`job_package`,`location`,`name`,`post`)
VALUES
('Aquila Systems','2024-07-15',NULL,'14 LPA','Bengaluru','Rohit Sharma','SDE-1');
