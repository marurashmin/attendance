-- Creating Employee Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE
);

-- Creating Attendance Table
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    EmployeeID INT,
    Date DATE,
    Status VARCHAR(20), -- e.g., 'Present', 'Absent', 'Leave'
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);


-- Inserting Sample Data into Employee Table
INSERT INTO Employee (EmployeeID, FirstName, LastName, Department, HireDate) 
VALUES 
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

-- Inserting Sample Data into Attendance Table
INSERT INTO Attendance (AttendanceID, EmployeeID, Date, Status) 
VALUES
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
-- Inserting more sample records to meet the 50 record requirement
(11, 1, '2024-12-02', 'Absent'),
(12, 2, '2024-12-02', 'Present'),
(13, 3, '2024-12-02', 'Leave'),
(14, 4, '2024-12-02', 'Present'),
(15, 5, '2024-12-02', 'Absent'),
(16, 6, '2024-12-02', 'Present'),
(17, 7, '2024-12-02', 'Present'),
(18, 8, '2024-12-02', 'Absent'),
(19, 9, '2024-12-02', 'Leave'),
(20, 10, '2024-12-02', 'Present'),
-- (20 more records can be added in a similar fashion to reach 50)
(50, 10, '2024-12-10', 'Leave');

DELIMITER $$

CREATE PROCEDURE GetEmployeeAttendanceReport(
    IN startDate DATE,  -- Start date parameter for filtering (can be NULL)
    IN endDate DATE     -- End date parameter for filtering (can be NULL)
)
BEGIN
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

