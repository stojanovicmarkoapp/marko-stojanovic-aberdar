-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 25, 2023 at 07:34 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aberdar`
--
CREATE DATABASE IF NOT EXISTS `aberdar` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `aberdar`;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `storyId` int(11) NOT NULL,
  `ipAddress` text NOT NULL,
  `nickname` varchar(30) NOT NULL,
  `changed` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `content`, `storyId`, `ipAddress`, `nickname`, `changed`) VALUES
(2, 'Ја сам на Газиместану.', 1, '203.0.113.44', 'косовка-дјевојка', '2023-06-25 05:31:39'),
(3, 'Прилеп?', 20, '203.0.113.44', 'тоше', '2023-06-25 00:10:25'),
(4, 'Пећ', 20, '203.0.113.43', 'сердар-шћепан', '2023-06-25 00:10:39'),
(5, 'Dostinika', 20, '203.0.113.42', 'upućeni', '2023-06-25 00:10:50'),
(12, 'Не знам ти ја ништа о томе.', 20, '93.86.185.35', 'келнерица', '2023-06-25 05:30:04');

--
-- Triggers `comments`
--
DROP TRIGGER IF EXISTS `trigger_create`;
DELIMITER $$
CREATE TRIGGER `trigger_create` BEFORE INSERT ON `comments` FOR EACH ROW BEGIN
    SET NEW.changed = CURRENT_TIMESTAMP();
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trigger_update`;
DELIMITER $$
CREATE TRIGGER `trigger_update` BEFORE UPDATE ON `comments` FOR EACH ROW BEGIN
    SET NEW.changed = CURRENT_TIMESTAMP();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reaction-occurrences`
--

DROP TABLE IF EXISTS `reaction-occurrences`;
CREATE TABLE `reaction-occurrences` (
  `id` int(11) NOT NULL,
  `reaction-id` int(11) NOT NULL,
  `comment-id` int(11) NOT NULL,
  `ip-address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `reactions`
--

DROP TABLE IF EXISTS `reactions`;
CREATE TABLE `reactions` (
  `id` int(11) NOT NULL,
  `icon` text NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `storyId` (`storyId`,`ipAddress`) USING HASH;

--
-- Indexes for table `reaction-occurrences`
--
ALTER TABLE `reaction-occurrences`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `comment-id_2` (`comment-id`,`ip-address`) USING HASH,
  ADD KEY `reaction-id` (`reaction-id`),
  ADD KEY `comment-id` (`comment-id`);

--
-- Indexes for table `reactions`
--
ALTER TABLE `reactions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `reaction-occurrences`
--
ALTER TABLE `reaction-occurrences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reactions`
--
ALTER TABLE `reactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reaction-occurrences`
--
ALTER TABLE `reaction-occurrences`
  ADD CONSTRAINT `reaction-occurrences_ibfk_1` FOREIGN KEY (`reaction-id`) REFERENCES `reactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reaction-occurrences_ibfk_2` FOREIGN KEY (`comment-id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
