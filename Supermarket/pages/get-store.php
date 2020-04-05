<?php
    include '../config/dbcon.php';
    
    $sql = "select storeID,storeName from tb_store";
    $query = mysqli_query($con, $sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
?>