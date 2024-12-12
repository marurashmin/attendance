# Attendance Management System

This is an Attendance Management System built using CodeIgniter framework.

## Setup Instructions

Follow these steps to set up and run the project locally:

### 1. Clone the Repository
Clone the repository to your local machine:
```bash
git clone <your_git_url>
cd attendance
```
### 2. Create the Database
Log into MySQL and create a database named attendance:
```bash
CREATE DATABASE attendance;
```
### 3. Import the Database Schema
Import the database schema from database/attendance.sql:
```bash
mysql -u username -p attendance < database/attendance.sql
```
### 4. Update the Base URL
In the application/config/config.php file, update the base URL to match your folder name:
```bash
$config['base_url'] = 'http://localhost/attendance/';
```
### 5. Run the Project
Open your browser and visit the following URL to access the project:
```bash
http://localhost/attendance/
```

### Requirements
* PHP 7.2 or higher
* MySQL or MariaDB
* CodeIgniter 3.x