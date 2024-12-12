-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 12, 2024 at 05:58 PM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `attendance`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `GetEmployeeAttendanceReport`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmployeeAttendanceReport` (IN `startDate` DATE, IN `endDate` DATE)   BEGIN
    -- Declare variables for the cursor and row data
    DECLARE done INT DEFAULT FALSE;
    DECLARE empID INT;
    DECLARE firstName VARCHAR(50);
    DECLARE lastName VARCHAR(50);
    DECLARE dept VARCHAR(50);
    DECLARE attendDate DATE;
    DECLARE status VARCHAR(20);
    
    -- Declare a cursor to select employee and attendance data
    DECLARE attendance_cursor CURSOR FOR
        SELECT e.EmployeeID, e.FirstName, e.LastName, e.Department, a.Date, a.Status
        FROM Employee e
        JOIN Attendance a ON e.EmployeeID = a.EmployeeID
        WHERE 
            (startDate IS NULL OR a.Date >= startDate)  -- If startDate is NULL, ignore it
            AND (endDate IS NULL OR a.Date <= endDate)  -- If endDate is NULL, ignore it
        ORDER BY e.EmployeeID, a.Date;
    
    -- Declare CONTINUE HANDLER to close the cursor when no more records are found
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Create a temporary table to store the results
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_attendance (
        EmployeeID INT,
        FirstName VARCHAR(50),
        LastName VARCHAR(50),
        Department VARCHAR(50),
        Date DATE,
        AttendanceStatus VARCHAR(20)
    );

    -- Open the cursor
    OPEN attendance_cursor;

    -- Loop through the records
    read_loop: LOOP
        FETCH attendance_cursor INTO empID, firstName, lastName, dept, attendDate, status;
        
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Insert the current row into the temporary table
        INSERT INTO temp_attendance (EmployeeID, FirstName, LastName, Department, Date, AttendanceStatus)
        VALUES (empID, firstName, lastName, dept, attendDate, status);
    END LOOP;

    -- Close the cursor
    CLOSE attendance_cursor;

    -- Return the results from the temporary table
    SELECT * FROM temp_attendance;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_attendance;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
CREATE TABLE IF NOT EXISTS `attendance` (
  `AttendanceID` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AttendanceID`),
  KEY `EmployeeID` (`EmployeeID`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`AttendanceID`, `EmployeeID`, `Date`, `Status`) VALUES
(1, 1, '2024-12-01', 'Present'),
(2, 2, '2024-12-01', 'Absent'),
(3, 3, '2024-12-01', 'Present'),
(4, 4, '2024-12-01', 'Leave'),
(5, 5, '2024-12-01', 'Present'),
(6, 6, '2024-12-01', 'Present'),
(7, 7, '2024-12-01', 'Absent'),
(8, 8, '2024-12-01', 'Leave'),
(9, 9, '2024-12-01', 'Present'),
(10, 10, '2024-12-01', 'Absent'),
(11, 1, '2024-12-02', 'Present'),
(12, 2, '2024-12-02', 'Absent'),
(13, 3, '2024-12-02', 'Present'),
(14, 4, '2024-12-02', 'Leave'),
(15, 5, '2024-12-02', 'Present'),
(16, 6, '2024-12-02', 'Present'),
(17, 7, '2024-12-02', 'Absent'),
(18, 8, '2024-12-02', 'Leave'),
(19, 9, '2024-12-02', 'Present'),
(20, 10, '2024-12-02', 'Absent'),
(21, 1, '2024-12-05', 'Present'),
(22, 2, '2024-12-05', 'Absent'),
(23, 3, '2024-12-05', 'Present'),
(24, 4, '2024-12-05', 'Leave'),
(25, 5, '2024-12-05', 'Present'),
(26, 6, '2024-12-05', 'Present'),
(27, 7, '2024-12-05', 'Absent'),
(28, 8, '2024-12-05', 'Leave'),
(29, 9, '2024-12-05', 'Present'),
(30, 10, '2024-12-05', 'Absent'),
(31, 1, '2024-12-15', 'Present'),
(32, 2, '2024-12-15', 'Absent'),
(33, 3, '2024-12-15', 'Present'),
(34, 4, '2024-12-15', 'Leave'),
(35, 5, '2024-12-15', 'Present'),
(36, 6, '2024-12-15', 'Present'),
(37, 7, '2024-12-15', 'Absent'),
(38, 8, '2024-12-15', 'Leave'),
(39, 9, '2024-12-15', 'Present'),
(40, 10, '2024-12-15', 'Absent'),
(41, 1, '2024-12-20', 'Present'),
(42, 2, '2024-12-20', 'Absent'),
(43, 3, '2024-12-20', 'Present'),
(44, 4, '2024-12-20', 'Leave'),
(45, 5, '2024-12-20', 'Present'),
(46, 6, '2024-12-20', 'Present'),
(47, 7, '2024-12-20', 'Absent'),
(48, 8, '2024-12-20', 'Leave'),
(49, 9, '2024-12-20', 'Present'),
(50, 10, '2024-12-20', 'Absent');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `EmployeeID` int NOT NULL,
  `FirstName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LastName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Department` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`EmployeeID`, `FirstName`, `LastName`, `Department`, `HireDate`) VALUES
(1, 'John', 'Doe', 'HR', '2020-01-15'),
(2, 'Jane', 'Smith', 'Finance', '2018-03-20'),
(3, 'Michael', 'Johnson', 'IT', '2019-05-10'),
(4, 'Emily', 'Davis', 'Sales', '2021-07-01'),
(5, 'William', 'Brown', 'Marketing', '2020-09-25'),
(6, 'Olivia', 'Taylor', 'HR', '2017-11-30'),
(7, 'James', 'Moore', 'IT', '2016-02-15'),
(8, 'Sophia', 'Wilson', 'Sales', '2015-08-22'),
(9, 'David', 'Martinez', 'Finance', '2022-06-18'),
(10, 'Isabella', 'Anderson', 'Marketing', '2014-12-05');
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
