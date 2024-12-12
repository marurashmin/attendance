<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Attendance Report</title>

    <!-- Include jQuery and DataTables CSS/JS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>

    <div class="container mt-5">
        <div class="row">
            <div class="col-md-12 mb-4">
                <h1 class="display-4">Employee Attendance Report</h1>  
                <!-- Date Range Form -->
                <form method="post" action="<?php echo site_url('attendance/index'); ?>" class="form-inline justify-content-center mb-4">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group mx-2">
                                <label for="start_date" class="form-label">Start Date:</label>
                                <input type="date" id="start_date" name="start_date" class="form-control" value="<?= $start_date;?>" required>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group mx-2">
                                <label for="end_date" class="form-label">End Date:</label>
                                <input type="date" id="end_date" name="end_date" class="form-control" value="<?= $end_date;?>" required>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary mx-2">Generate Report</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Display the Attendance Table if Data Exists -->
        <?php if (!empty($attendance)): ?>
            <div class="table-responsive">
                <table id="attendanceTable" class="table table-striped table-bordered table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Sr No</th>
                            <th>Employee ID</th>
                            <th>Employee Name</th>
                            <th>Department</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($attendance as $key => $row): ?>
                            <tr>
                                <td><?php echo ++$key; ?></td>
                                <td><?php echo 'EMP'.sprintf("%04d", $row['EmployeeID']); ?></td>
                                <td><?php echo $row['FirstName'].' '.$row['LastName']; ?></td>
                                <td><?php echo $row['Department']; ?></td>
                                <td><?php echo $row['Date']; ?></td>
                                <td><?php echo $row['AttendanceStatus']; ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        <?php else: ?>
            <div class="alert alert-warning" role="alert">
                No attendance data available.
            </div>
        <?php endif; ?>

    </div>

    <!-- Initialize DataTable -->
    <script>
        $(document).ready(function() {
            // Initialize the DataTable
            $('#attendanceTable').DataTable();
        });
    </script>
</body>
</html>
