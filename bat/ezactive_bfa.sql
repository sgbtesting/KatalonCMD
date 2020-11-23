/*
 Navicat Premium Data Transfer

 Source Server         : phpMyAdmin
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : ezactive_bfa

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 10/10/2020 15:13:19
*/

USE ezactive_bfa;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `season_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` datetime(0) NOT NULL,
  `end_date` datetime(0) NOT NULL,
  `start_register_date` datetime(0) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO `events` VALUES (1, 0, '2020/2021', 'Season', 'Main', '2020-06-15 00:00:00', '2021-08-15 00:00:00', '2020-06-01 00:00:00', 'Active');

-- ----------------------------
-- Table structure for invoices
-- ----------------------------
DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `registration_id` int(10) UNSIGNED NOT NULL,
  `invoice_identification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_date` datetime(0) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `invoices_ibfk_1`(`registration_id`) USING BTREE,
  CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`registration_id`) REFERENCES `registrations` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of invoices
-- ----------------------------
INSERT INTO `invoices` VALUES (3, 3, 'aa64aa22-4ff9-43f2-8a3f-60b7f8abc139', 'BFA2021-3', '2020-10-09 10:49:10', 'AUTHORISED');
INSERT INTO `invoices` VALUES (4, 8, '816c8b79-3ac6-4d0f-8c72-331f58bb1a94', 'BFA2021-8', '2020-10-09 11:53:11', 'AUTHORISED');

-- ----------------------------
-- Table structure for match_coaches
-- ----------------------------
DROP TABLE IF EXISTS `match_coaches`;
CREATE TABLE `match_coaches`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `match_id` int(10) UNSIGNED NOT NULL,
  `pgroup_coach_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `bus` int(10) NOT NULL,
  `timestamp` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `match_coaches_ibfk_1`(`match_id`) USING BTREE,
  INDEX `match_coaches_ibfk_2`(`pgroup_coach_id`) USING BTREE,
  CONSTRAINT `match_coaches_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `match_coaches_ibfk_2` FOREIGN KEY (`pgroup_coach_id`) REFERENCES `pgroup_coaches` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for match_players
-- ----------------------------
DROP TABLE IF EXISTS `match_players`;
CREATE TABLE `match_players`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `match_id` int(10) UNSIGNED NOT NULL,
  `pgroup_player_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `bus` int(10) UNSIGNED NULL DEFAULT NULL,
  `timestamp` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `match_players_ibfk_1`(`match_id`) USING BTREE,
  INDEX `match_players_ibfk_2`(`pgroup_player_id`) USING BTREE,
  CONSTRAINT `match_players_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `match_players_ibfk_2` FOREIGN KEY (`pgroup_player_id`) REFERENCES `pgroup_players` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of match_players
-- ----------------------------
INSERT INTO `match_players` VALUES (9, 1, 1, 'ACCEPTED', '', 0, '2020-10-10 15:08:40');

-- ----------------------------
-- Table structure for matches
-- ----------------------------
DROP TABLE IF EXISTS `matches`;
CREATE TABLE `matches`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pgroup_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `match_date` datetime(0) NOT NULL,
  `start_time` time(0) NOT NULL,
  `end_time` time(0) NOT NULL,
  `bus_size` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bus_depart_time` time(0) NOT NULL,
  `bus_return_time` time(0) NOT NULL,
  `venue_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `tunnel` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N/A',
  `location` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `match_coaches` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `kit_colour` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `file_attached` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `matches_ibfk_1`(`pgroup_id`) USING BTREE,
  INDEX `matches_ibfk_2`(`user_id`) USING BTREE,
  CONSTRAINT `matches_ibfk_1` FOREIGN KEY (`pgroup_id`) REFERENCES `pgroups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `matches_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of matches
-- ----------------------------
INSERT INTO `matches` VALUES (1, 7, 1, 'Match 1', 'Match Player', '2020-10-17 00:00:00', '00:00:00', '00:00:00', '#N/A', '00:00:00', '00:00:00', 1, 'N/A', NULL, NULL, '', '12|44', '', NULL, NULL);

-- ----------------------------
-- Table structure for online_users
-- ----------------------------
DROP TABLE IF EXISTS `online_users`;
CREATE TABLE `online_users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `session_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `time_stamp` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `online_users_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 111 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of online_users
-- ----------------------------
INSERT INTO `online_users` VALUES (99, 22, '9hqme8od9nm7p24p8p7ij8rva2', '2020-09-24 10:00:57');
INSERT INTO `online_users` VALUES (108, 1, '0f6otobhjij53k2mkcqud8iqlv', '2020-10-08 11:17:31');
INSERT INTO `online_users` VALUES (109, 4, 'gd8dooh55351orjp37nhk8e0uh', '2020-10-09 11:31:59');
INSERT INTO `online_users` VALUES (110, 23, 'pothtu5hstrpd86ch6mkv4ej81', '2020-10-09 11:32:27');

-- ----------------------------
-- Table structure for persons
-- ----------------------------
DROP TABLE IF EXISTS `persons`;
CREATE TABLE `persons`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `secondary_contact_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `parent_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `dob` datetime(0) NULL DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `player_photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `school` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `photo_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parental_consent_date` datetime(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of persons
-- ----------------------------
INSERT INTO `persons` VALUES (1, NULL, NULL, 'BFA', 'Singapore', 'bfasingapore@ezactive.com', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-29 23:43:19');
INSERT INTO `persons` VALUES (5, 43, NULL, 'Tien', 'Le', 'tienlq54cntt@gmail.com', '12345678', NULL, NULL, NULL, NULL, NULL, '2020-06-14 18:25:52', '2020-05-27 17:52:36', '2020-06-15 01:25:52');
INSERT INTO `persons` VALUES (12, NULL, 5, 'Cristiano', 'Ronaldo', 'tien@ezactive.com', '12345678', '2007-05-02 00:00:00', 'Male', '5-1591365037-photo.jpg', 'Juventus ', '5-1591365037-hkid_passport_photo.jpg', NULL, '2020-06-06 04:50:37', NULL);
INSERT INTO `persons` VALUES (43, 5, NULL, 'Chau', 'Cao', 'caoquynhchau105@gmail.com', '12345678', NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-24 09:09:53', NULL);
INSERT INTO `persons` VALUES (44, 45, NULL, 'Le', 'Quyet Tien', 'lequyettien.it@gmail.com', '98761234', NULL, NULL, NULL, NULL, NULL, NULL, '2020-10-09 11:31:39', NULL);
INSERT INTO `persons` VALUES (45, 44, NULL, 'Cao', 'Quynh Chau', 'caoquynhchau@gmail.com', '12349876', NULL, NULL, NULL, NULL, NULL, NULL, '2020-10-09 11:33:23', NULL);
INSERT INTO `persons` VALUES (46, NULL, 44, 'Tra', 'My', NULL, NULL, '2010-10-09 00:00:00', 'Female', '44-1602218066-photo.jpg', 'EZ Active', '44-1602218066-photo_id.jpg', NULL, '2020-10-09 11:34:26', NULL);

-- ----------------------------
-- Table structure for pgroup_coaches
-- ----------------------------
DROP TABLE IF EXISTS `pgroup_coaches`;
CREATE TABLE `pgroup_coaches`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pgroup_id` int(10) UNSIGNED NOT NULL,
  `coach_id` int(10) UNSIGNED NOT NULL,
  `is_head` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pgroup_coaches_ibfk_1`(`pgroup_id`) USING BTREE,
  INDEX `pgroup_coaches_ibfk_2`(`coach_id`) USING BTREE,
  CONSTRAINT `pgroup_coaches_ibfk_1` FOREIGN KEY (`pgroup_id`) REFERENCES `pgroups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `pgroup_coaches_ibfk_2` FOREIGN KEY (`coach_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pgroup_coaches
-- ----------------------------
INSERT INTO `pgroup_coaches` VALUES (4, 7, 12, 2);
INSERT INTO `pgroup_coaches` VALUES (5, 7, 44, 1);

-- ----------------------------
-- Table structure for pgroup_player_lists
-- ----------------------------
DROP TABLE IF EXISTS `pgroup_player_lists`;
CREATE TABLE `pgroup_player_lists`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `pgroup_id` int(10) UNSIGNED NOT NULL,
  `pgroup_player_ids` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pgroup_player_lists_ibfk_2`(`pgroup_id`) USING BTREE,
  INDEX `pgroup_player_lists_ibfk_1`(`user_id`) USING BTREE,
  CONSTRAINT `pgroup_player_lists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `pgroup_player_lists_ibfk_2` FOREIGN KEY (`pgroup_id`) REFERENCES `pgroups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pgroup_players
-- ----------------------------
DROP TABLE IF EXISTS `pgroup_players`;
CREATE TABLE `pgroup_players`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pgroup_id` int(10) UNSIGNED NOT NULL,
  `player_id` int(10) UNSIGNED NOT NULL,
  `team_index` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pgroup_id`(`pgroup_id`, `player_id`) USING BTREE,
  INDEX `pgroup_players_ibfk_2`(`player_id`) USING BTREE,
  CONSTRAINT `pgroup_players_ibfk_1` FOREIGN KEY (`pgroup_id`) REFERENCES `pgroups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `pgroup_players_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pgroup_players
-- ----------------------------
INSERT INTO `pgroup_players` VALUES (1, 7, 12, 0);
INSERT INTO `pgroup_players` VALUES (2, 5, 46, 0);

-- ----------------------------
-- Table structure for pgroups
-- ----------------------------
DROP TABLE IF EXISTS `pgroups`;
CREATE TABLE `pgroups`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `event_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `year` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_year_range` tinyint(1) NOT NULL DEFAULT 0,
  `member_price` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `coach_price` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `others_price` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pgroups_ibfk_1`(`event_id`) USING BTREE,
  CONSTRAINT `pgroups_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pgroups
-- ----------------------------
INSERT INTO `pgroups` VALUES (1, 1, 'Under 6', 'Mixed Team', '2014', 0, 1000.00, 1000.00, 1000.00, NULL);
INSERT INTO `pgroups` VALUES (2, 1, 'Under 7', 'Mixed Team', '2013', 0, 1000.00, 1000.00, 1000.00, NULL);
INSERT INTO `pgroups` VALUES (3, 1, 'Under 8', 'Mixed Team', '2012', 0, 1000.00, 1000.00, 1000.00, NULL);
INSERT INTO `pgroups` VALUES (4, 1, 'Under 9', 'Mixed Team', '2011', 0, 1200.00, 1200.00, 1200.00, NULL);
INSERT INTO `pgroups` VALUES (5, 1, 'Under 10', 'Mixed Team', '2010', 0, 1200.00, 1200.00, 1200.00, NULL);
INSERT INTO `pgroups` VALUES (6, 1, 'Under 11', 'Mixed Team', '2009', 0, 1200.00, 1200.00, 1200.00, NULL);
INSERT INTO `pgroups` VALUES (7, 1, 'Under 12', 'Mixed Team', '2008', 0, 1200.00, 1200.00, 1200.00, NULL);

-- ----------------------------
-- Table structure for registrations
-- ----------------------------
DROP TABLE IF EXISTS `registrations`;
CREATE TABLE `registrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `event_id` int(10) UNSIGNED NOT NULL,
  `person_id` int(10) UNSIGNED NOT NULL,
  `prefered_days` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `registered_date` datetime(0) NOT NULL,
  `approved_date` datetime(0) NULL DEFAULT NULL,
  `approval_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `amount` float(10, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `registrations_ibfk_1`(`event_id`) USING BTREE,
  INDEX `registrations_ibfk_2`(`person_id`) USING BTREE,
  CONSTRAINT `registrations_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `registrations_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registrations
-- ----------------------------
INSERT INTO `registrations` VALUES (3, 1, 12, NULL, '2020-06-05 21:52:24', '2020-10-09 10:49:10', 'Registered', 1200.00);
INSERT INTO `registrations` VALUES (8, 1, 46, 'Monday, Wednesday', '2020-10-09 11:40:18', '2020-10-09 11:53:11', 'Registered', 1200.00);

-- ----------------------------
-- Table structure for storages
-- ----------------------------
DROP TABLE IF EXISTS `storages`;
CREATE TABLE `storages`  (
  `id` int(10) NOT NULL,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `expires` int(11) NULL DEFAULT NULL,
  `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of storages
-- ----------------------------
INSERT INTO `storages` VALUES (1, 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE2MDIyMTg0NjgsImV4cCI6MTYwMjIyMDI2OCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiQjI3ODBEQzcyQjJENDc5MEEzQTlFNDM5RUI0NzgzMjgiLCJzdWIiOiIxNzRjOWE1YjVmOTA1MDY4OWIzMWI3MGI1MjgxMTY0MiIsImF1dGhfdGltZSI6MTYwMjAzNzgzOCwieGVyb191c2VyaWQiOiI5MmQxN2ZlMC1jMTcwLTRiMjItYjg1ZC0zZGVmZjNlNjFhYTUiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6IjY2OTU5YTcwMWE3OTRlYmFiZWVmNDM1YTE1NjUxM2FmIiwianRpIjoiZTgxODYwZGE0NTI5NzIzN2FmM2MyNTRjYTMwNjM1YTUiLCJhdXRoZW50aWNhdGlvbl9ldmVudF9pZCI6IjFkODE3YzMzLWU4MzctNDAyOC1iOTU5LTE0YzZlOGZiMTY3MiIsInNjb3BlIjpbImVtYWlsIiwicHJvZmlsZSIsIm9wZW5pZCIsImFjY291bnRpbmcucmVwb3J0cy5yZWFkIiwicHJvamVjdHMiLCJhY2NvdW50aW5nLnNldHRpbmdzIiwiYWNjb3VudGluZy5hdHRhY2htZW50cyIsImFjY291bnRpbmcudHJhbnNhY3Rpb25zIiwiYWNjb3VudGluZy5qb3VybmFscy5yZWFkIiwiYXNzZXRzIiwiYWNjb3VudGluZy5jb250YWN0cyIsIm9mZmxpbmVfYWNjZXNzIl19.qiDXhphVEvUR4Sflfzk0IqgwZE_DtOhGpd-2A0G60pgx5tPMbQI-VYhOpZmttWAjbcjVMHlf1aFQkCz7NmuQoRDX9haFdK3UjhQN2xtWFcp2Cj7W7KEwALm-wVj9QRr4dJxxSmk1Vc_hY1XMC22_4CjbzYdIe9k8jMHkoWIP77wiKT5NrlA7fQId7HmJW27eiF_udQXhPvomIXpIuxtJfeaPa_UZoZlPpz9dsmnMOfJrLpsr83UqgPPbat_uzsMhBEcpoJ4iWTgbwRZV1ExyrHAJuWY2CZba69EFUhkiKanK36MOxUUNsVkU4NrPj3_qApP7lVWwqDPic3aYMnFlbg', 1602220268, '3e0cd96f66af24d72ee20a5464cb4461c284e828bc66513eab98c96cecea7d05', 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE2MDIyMTg0NjgsImV4cCI6MTYwMjIxODc2OCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6IkIyNzgwREM3MkIyRDQ3OTBBM0E5RTQzOUVCNDc4MzI4IiwiaWF0IjoxNjAyMjE4NDY4LCJhdF9oYXNoIjoiTGM1NndoblYxcWo3X0U5c2piSk1NZyIsInN1YiI6IjE3NGM5YTViNWY5MDUwNjg5YjMxYjcwYjUyODExNjQyIiwiYXV0aF90aW1lIjoxNjAyMDM3ODM4LCJ4ZXJvX3VzZXJpZCI6IjkyZDE3ZmUwLWMxNzAtNGIyMi1iODVkLTNkZWZmM2U2MWFhNSIsImdsb2JhbF9zZXNzaW9uX2lkIjoiNjY5NTlhNzAxYTc5NGViYWJlZWY0MzVhMTU2NTEzYWYiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ0aWVubHE1NGNudHRAZ21haWwuY29tIiwiZW1haWwiOiJ0aWVubHE1NGNudHRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6IlRpZW4iLCJmYW1pbHlfbmFtZSI6IkxlIn0.c9meCn5wing4NhiYWWD_9STFgjtKy16jBXydprVAwUXxxQvUeahePACy4zSRzaIjNyHNEUaRmGGLlq-dTyWnS4RJuTD5n4PpnXrcO1a8h_EmFqRpTsoi45cyrd0ZITZ1Pb6iGkht1DLgEX7LflCZ1rTUnucQGKsqkphNnZv9-KQ8wvkTjWGlNqMx2yfbBGJpxRlwj3UieZSPRshvaUZP_Q5id6d4Hmr725izlxgbalFBE67HVJO6sgNhGOeNsoc8_-RaexkGNLhSS-TJIXy1xCmJyjLXOCsEK9A2dKRqxjfA1eKM0Y8Tg6igwZpOxYP7NLfzTJ0ZROeuCwHZqs4fsQ');

-- ----------------------------
-- Table structure for ufiles
-- ----------------------------
DROP TABLE IF EXISTS `ufiles`;
CREATE TABLE `ufiles`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_1` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_2` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_3` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` tinyint(4) NOT NULL,
  `person_id` int(10) UNSIGNED NOT NULL,
  `two_factor_auth` tinyint(1) NOT NULL DEFAULT 0,
  `auth_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `token` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `person_id`(`person_id`) USING BTREE,
  INDEX `index_username`(`username`) USING BTREE,
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'bfasingapore@ezactive.com', '$2y$10$q5tvkAkc5y3i/lHybPXhSOCHy.Bcaf.fcEkqClgaFmqwXWxv1TI86', 9, 1, 0, 'S7Q5PS67JG2TK42L', '', NULL, NULL);
INSERT INTO `users` VALUES (4, 'tien@ezactive.com', '$2y$10$GjR1p1DzQ08wax4AoAcDCe8hAAAJFXfBF9vXcw4unFhN6adDI4/IO', 1, 5, 0, NULL, '', '2020-05-27 17:52:48', NULL);
INSERT INTO `users` VALUES (22, 'caoquynhchau105@gmail.com', '$2y$10$K1zlHUezxG7xFnJiBZdPHe6oegt2IquAF5odJwcE3pabmOlTtsNZa', 1, 43, 0, NULL, '', '2020-09-24 09:10:03', NULL);
INSERT INTO `users` VALUES (23, 'lequyettien.it@gmail.com', '$2y$10$NcM16eIc/YkRwOAQYZoPaOucyKM/vMGON8O0/QSAITPcQDyXr/Wiu', 1, 44, 0, NULL, '', '2020-10-09 11:31:45', NULL);
INSERT INTO `users` VALUES (24, 'caoquynhchau@gmail.com', '$2y$10$WT8BfxMwSFlvTiCYTDA0Sen1FElgzmSckpF05ehQySswocDtmLVYe', 1, 45, 0, NULL, '', '2020-10-09 11:33:27', NULL);

-- ----------------------------
-- Table structure for venues
-- ----------------------------
DROP TABLE IF EXISTS `venues`;
CREATE TABLE `venues`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `latitude` decimal(10, 8) NULL DEFAULT NULL,
  `longitude` decimal(11, 8) NULL DEFAULT NULL,
  `surface` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parking` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bus` int(10) UNSIGNED NULL DEFAULT 1,
  `cross_harbour` int(10) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of venues
-- ----------------------------
INSERT INTO `venues` VALUES (1, 'MERLION SPORTS FIELD', '790A Dunearn Road, 289667', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `venues` VALUES (2, 'DULWICH COLLEGE (Singapore)', '71 Bukit Batok West Ave 8, 65896', NULL, NULL, NULL, NULL, 1, 0);

SET FOREIGN_KEY_CHECKS = 1;
