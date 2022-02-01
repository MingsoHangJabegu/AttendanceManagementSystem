<?php
session_start();

if (!$_SESSION['name']) {
    echo ' <script>
            alert("Please login first.")
            window.location.href="../pages/index.html"
            </script>';
} else {
    $name = $_SESSION['name'];
    $role = $_SESSION['role'];
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-firestore.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-database.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-functions.js"></script>
    <link rel="stylesheet" href="../css/view.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <script>
        var username = '<?php echo $name; ?>'
        var role = '<?php echo $role; ?>'
        sessionStorage.setItem('name', username)
        sessionStorage.setItem('role', role)
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="../js/include.js"></script>

    <title>Home</title>
</head>

<body>
    <div w3-include-html="header.html"></div>
    <script>
        includeHTML()
    </script>
    <h1 style="text-align:center">Today's Attendance</h1>
    <table class="flat-table" id="attendance-table">
        <tr>
            <th onclick="sortTable(0)">Roll No.</th>
            <th onclick="sortTable(1)">Name</th>
            <th onclick="sortTable(2)">Faculty</th>
            <th onclick="sortTable(3)">Year</th>
            <th>Phone Number</th>
            <th onclick="sortTable(5)">Attendance</th>
            <th onclick="sortTable(6)">Time</th>
            <th class="edit">Options</th>
        </tr>
    </table>
    <script src="../js/auth.js"></script>
    <script src="../js/view.js"></script>
</body>

</html>