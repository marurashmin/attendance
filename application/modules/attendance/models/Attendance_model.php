<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Attendance_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    /**
     * Example method to get attendance report
     * Method to execute the stored procedure with parameters
     * @param
     * Start date
     * End Date
     */
    public function get_employee_attendance_report($start_date, $end_date) {
        // Call the stored procedure with parameters
        $query = $this->db->query("CALL GetEmployeeAttendanceReport(?, ?)", array($start_date, $end_date));

        // Check if the query was successful and return the result
        if ($query->num_rows() > 0) {
            return $query->result_array(); // Returns the data as an associative array
        } else {
            return false; // No data found
        }
    }
}
