<?php
    $con = mysqli_connect('localhost', 'root', '', 'supermarket');
    if(!$con){
        echo "Connection error: " . mysqli_connect_error();
    }
    
?>

