<?php      
    session_start();
    if($_SESSION['role'] == 1){

        include('connection.php');
    
        $name = $_POST['name'];  
        $email = $_POST['email'];  
        $password = md5($_POST['pwd']);  
        $phone = $_POST['phone'];  
        if($_POST['admin'] == 'super'){
            $admin = 1;
        } else {
            $admin = 0;
        }
        
        //to prevent from mysqli injection  
        $name = stripcslashes($name);  
        $email = stripcslashes($email);  
        $phone = stripcslashes($phone);  
        $password = stripcslashes($password);
        $name = mysqli_real_escape_string($con, $name); 
        $email = mysqli_real_escape_string($con, $email); 
        $phone = mysqli_real_escape_string($con, $phone); 
        $password = mysqli_real_escape_string($con, $password);  
    
        $sql_INSERT = "INSERT INTO admin (name, email, password, phone, super)
        VALUES ('$name', '$email', '$password', '$phone', '$admin')";

        $sql_SELECT = "select * from admin where email = '$email'";  
        $result = mysqli_query($con, $sql_SELECT);  
        $row = mysqli_fetch_array($result, MYSQLI_ASSOC);  
        $count = mysqli_num_rows($result);
        
        if($count == 0){  
            if ($con->query($sql_INSERT) === TRUE) {
                echo '<script>
                alert("New record created successfully")
                window.location.href="../pages/admin.html"
                </script>';
                // header('location: ../pages/admin.html');
            } else {
                echo "Error: " . $sql_INESRT . "<br>" . $con->error;
            }
        
            $con->close(); 
        }  
        else{ 
            echo '<script>
            alert("The Email is already in use.")
            window.location.href="../pages/admin.html"
            </script>';
        }     
    } else {
        echo '<script>
        alert("You do not have permission to perform the task.")
        window.location.href="../pages/admin.html"
        </script>';
    }
?>