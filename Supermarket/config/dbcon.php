<?php
    $con = mysqli_connect('localhost', 'root', '520808', 'supermarket');
    if(!$con){
        echo "Connection error: " . mysqli_connect_error();
    }
    
?>

