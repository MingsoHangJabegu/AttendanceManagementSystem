<?php

$roll = $_POST['roll'];
$faculty = strtolower($_POST['faculty']);

$attDate = $_POST['attDate'];
$attTime = $_POST['attTime'];
$status = $_POST['status'];
$remarks = $_POST['remarks'];
$semester = $_POST['semester'];

$host = "localhost";
$user = "root";
$password = '';
$db_name = $faculty;

$conn = mysqli_connect($host, $user, $password, $db_name);
if (mysqli_connect_errno()) {
    die("Failed to connect with MySQL: " . mysqli_connect_error());
}


$sql = "CREATE TABLE IF NOT EXISTS $roll (
    semester varchar(10),
    attDate varchar(15),
    attTime varchar(15),
    `status` varchar(20),
    remarks varchar(100)
    )";

if ($conn->query($sql) === TRUE) {
    print_r("Table $roll created successfully");
} else {
    print_r("Error creating table: " . $conn->error);
    return;
}

if ($remarks == 'undefined') {
    $remarks = '-';
}

if ($attTime == 'undefined') {
    $attTime = '-';
}

$sql = "INSERT INTO $roll (semester, attDate, attTime, `status`, remarks)
VALUES ('$semester', '$attDate', '$attTime', '$status', '$remarks')";

if ($conn->query($sql) === TRUE) {
    print_r("\nNew record created successfully");
} else {
    print_r("\nError: " . $sql . "<br>" . $conn->error);
}

$conn->close();
