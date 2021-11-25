-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.11-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Copiando estrutura do banco de dados para badland
CREATE DATABASE IF NOT EXISTS `badland` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `badland`;

CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `vrp_business` (
  `user_id` int(11) NOT NULL,
  `capital` int(11) DEFAULT NULL,
  `laundered` int(11) DEFAULT NULL,
  `reset_timestamp` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_business_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando estrutura para tabela badland.vrp_estoque
CREATE TABLE IF NOT EXISTS `vrp_estoque` (
  `vehicle` varchar(100) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela badland.vrp_estoque: ~332 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_estoque` DISABLE KEYS */;
REPLACE INTO `vrp_estoque` (`vehicle`, `quantidade`, `user_id`) VALUES
	('adder', 9, 1),
	('alpha', 9, 2),
  ('asea', 9, 3),
	('asterope', 9, 4),
  ('baller', 9, 5),
	('baller2', 9, 6),
  ('baller3', 9, 7),
	('baller4', 9, 8),
  ('baller5', 9, 9),
	('baller6', 9, 10),
  ('banshee', 9, 11),
	('blista', 9, 12),
  ('brioso', 9, 13),
	('buffalo', 9, 14),
  ('bullet', 9, 15),
	('carbonizzare', 9, 16),
  ('cavalcade', 9, 17),
	('cheetah', 9, 18),
  ('cabrio', 9, 19),
	('comet2', 9, 20),
  ('comet5', 9, 21),
	('coquette', 9, 22),
  ('dilettante', 9, 23),
	('dominator', 9, 24),
  ('dubsta', 9, 25),
	('dubsta2', 9, 26),
  ('dukes', 9, 27),
	('elegy', 9, 28),
  ('elegy2', 9, 29),
	('exemplar', 9, 30),
	('emperor', 5, 31),
  ('felon', 9, 32),
	('fugitive', 9, 33),
  ('furoregt', 9, 34),
	('fusilade', 9, 35),
  ('futo', 9, 36),
	('gresley', 9, 37),
  ('granger', 9, 38),
	('habanero', 9, 39),
  ('huntley', 9, 40),
	('infernus', 9, 41),
  ('ingot', 9, 42),
	('intruder', 9, 43),
  ('issi2', 9, 44),
	('jackal', 9, 45),
  ('jester', 9, 46),
	('landstalker', 9, 47),
  ('massacro', 9, 48),
	('manana', 9, 49),
  ('oracle', 9, 50),
	('osiris', 9, 51),
  ('panto', 9, 52),
	('penumbra', 9, 53),
  ('phoenix', 9, 54),
	('picador', 9, 55),

  ('akuma', 9, 56),
  ('avarus', 9, 57),
  ('bagger', 9, 58),
  ('bati', 9, 59),
  ('bf400', 9, 60),
  ('carbonrs', 9, 61),
  ('cliffhanger', 9, 62),
  ('double', 9, 63),
  ('faggio', 9, 64),
  ('faggio2', 9, 65),
  ('faggio3', 9, 66),
  ('fcr2', 9, 67),
  ('hakuchou', 9, 68),
  ('lectro', 9, 69),
  ('manchez', 9, 70),
  ('nemesis', 9, 71),
  ('pcj', 9, 72),
  ('sanchez', 9, 73),
  ('thrust', 9, 74),
  ('vader', 9, 75),
  ('vortex', 9, 76),
  ('blazer', 9, 77),
  ('blazer4', 9, 78),

  ('bmwm3f80', 9, 79),
  ('bmwm4gts', 9, 80),
  ('ferrariitalia', 9, 81),
  ('hondafk8', 9, 82),
  ('lamborghinihuracan', 9, 83),
  ('lancerevolution9', 9, 84),
  ('lancerevolutionx', 9, 85),
  ('mazdarx7', 9, 86),
  ('nissan370z', 9, 87),
  ('nissangtr', 9, 88),
  ('nissanskyliner34', 9, 89),
  ('teslaprior', 9, 90);

/*!40000 ALTER TABLE `vrp_estoque` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `vrp_homes_permissions` (
  `owner` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `garage` int(11) NOT NULL,
  `home` varchar(100) NOT NULL DEFAULT '',
  `tax` varchar(24) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `vrp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `whitelisted` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `vrp_user_homes` (
  `user_id` int(11) NOT NULL,
  `home` varchar(255) NOT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`home`),
  CONSTRAINT `fk_user_homes_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `foto` varchar(200) DEFAULT NULL,
  `foragido` int(1) NOT NULL DEFAULT 0,
  `license` int(1) NOT NULL DEFAULT 1,
  `gunLimit` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  KEY `registration` (`registration`),
  KEY `phone` (`phone`),
  CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `vrp_user_ids` (
  `identifier` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  KEY `fk_user_ids_users` (`user_id`),
  CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `detido` int(1) NOT NULL DEFAULT 0,
  `time` varchar(24) NOT NULL DEFAULT '0',
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100,
  `ipva` varchar(50) DEFAULT NULL,
  `state` int(50) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`vehicle`),
  CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
