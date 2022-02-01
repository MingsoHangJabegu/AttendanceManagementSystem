
<?php      

    session_start();

    include('connection.php');

    $email = $_POST['email'];  
    $password = md5($_POST['pwd']);  
      
        //to prevent from mysqli injection  
        $email = stripcslashes($email);  
        $password = stripcslashes($password);
        $email = mysqli_real_escape_string($con, $email); 
        $password = mysqli_real_escape_string($con, $password);  
      
        $sql = "select * from admin where email = '$email' and password = '$password'";  
        $result = mysqli_query($con, $sql);  
        $row = mysqli_fetch_array($result, MYSQLI_ASSOC);  
        $count = mysqli_num_rows($result);
          
        if($count == 1){  
            $_SESSION['name'] = $row['name'];
            $_SESSION['role'] = $row['super'];
            echo "$_SESSION[name]";
            header('location: ../pages/home.php');
        }  
        else{ 
            echo' <script>
            alert("Login Failed. Invalid Email or Password")
            window.location.href="../pages/index.html"
            </script>';
        }     
?>