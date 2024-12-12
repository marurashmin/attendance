<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Attendance extends MY_Controller {
    /**
     * [__construct description]
     *
     * @method __construct
     */
    public function __construct()
    {
        // Load the constructer from MY_Controller
        parent::__construct();
    }

    /**
     * [index description]
     *
     * @method index
     *
     * @return Fetch the attendance data from model and bind under view file
     */
	public function index()
	{
        //
		$this->load->model('Attendance_model');
		// Get the start and end dates for the report (e.g., for this month)

		$start_date = $this->input->post('start_date');
        $end_date = $this->input->post('end_date');

        // If dates are provided, fetch the report
        if ($start_date && $end_date) {
            $attendance_data = $this->Attendance_model->get_employee_attendance_report($start_date, $end_date);
        } else {
            $attendance_data = [];
        }

		$data['attendance'] = $attendance_data;
		$data['start_date'] = $start_date;
		$data['end_date'] = $end_date;
        $this->load->view('index', $data);
	}
}
