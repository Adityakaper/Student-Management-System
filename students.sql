USE students;

-- Drop existing triggers if they exist
DROP TRIGGER IF EXISTS trg_delete_student;
DROP TRIGGER IF EXISTS trg_insert_student;
DROP TRIGGER IF EXISTS trg_update_student;

-- Set SQL mode and other session settings
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Create tables if they don't exist
CREATE TABLE IF NOT EXISTS `attendence` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `rollno` varchar(20) NOT NULL,
  `attendance` int(100) NOT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `department` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `branch` varchar(50) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rollno` varchar(20) NOT NULL,
  `sname` varchar(50) NOT NULL,
  `sem` int(20) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `branch` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `number` varchar(12) NOT NULL,
  `address` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(52) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `trig` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `rollno` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert statement using INSERT IGNORE to handle duplicates
INSERT IGNORE INTO `test` (`id`, `name`, `email`) VALUES
(1, 'aaa', 'aaa@gmail.com');

-- Create triggers with unique names
DELIMITER $$
CREATE TRIGGER `trg_delete_student` BEFORE DELETE ON `student` FOR EACH ROW 
BEGIN
  INSERT INTO trig (`rollno`, `action`, `timestamp`) VALUES (OLD.rollno, 'STUDENT DELETED', NOW());
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `trg_insert_student` AFTER INSERT ON `student` FOR EACH ROW 
BEGIN
  INSERT INTO trig (`rollno`, `action`, `timestamp`) VALUES (NEW.rollno, 'STUDENT INSERTED', NOW());
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `trg_update_student` AFTER UPDATE ON `student` FOR EACH ROW 
BEGIN
  INSERT INTO trig (`rollno`, `action`, `timestamp`) VALUES (NEW.rollno, 'STUDENT UPDATED', NOW());
END$$
DELIMITER ;

-- Adjust auto_increment values if needed
ALTER TABLE `attendence` MODIFY `aid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `department` MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
ALTER TABLE `student` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `test` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `trig` MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
ALTER TABLE `user` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

-- Commit transaction
COMMIT;

-- Reset session settings
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
