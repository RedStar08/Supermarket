<?php
    date_default_timezone_set('prc');
    $data="20".date('y-m-d',time());
    include '../config/dbcon.php';
    
    //SQL语句数组
    $sql_array = array();
    //SQL语句逐个添加
    $sql_array[] = "SELECT count(*) FROM `tb_goods`";
    $sql_array[] = "SELECT count(*) FROM `tb_discount`";
    $sql_array[] = "SELECT count(*) FROM `tb_store`";
    $sql_array[] = "SELECT count(*) FROM `tb_supplier`";
    $sql_array[] = "SELECT count(*) FROM `tb_user`";
    $sql_array[] = "SELECT count(*) FROM `tb_member`";
    $sql_array[] = "SELECT sum(stockTotal) FROM `stock`";
    $sql_array[] = "SELECT salesProfit FROM `daily_count` where salesDate='$data'";
    $sql_array[] = "SELECT salesSum FROM `daily_count` where salesDate='$data'";
    $sql_array[] = "SELECT sum(salesProfit) FROM `daily_count`";
    $sql_array[] = "SELECT sum(salesSum) FROM `daily_count`";
    $sql_array[] = "SELECT sum(buyAcount) FROM `buy_count`";
    $sql_array[] = "SELECT buyAcount FROM `buy_count` where buyDate='$data'";   
    
    //查询数组
    $query_array = array();
    //添加查询
    foreach($sql_array as $sql){
        $query_array[] = mysqli_query($con, $sql);
    }
    
    //结果数组
    $res_array = array();
    //添加结果
    foreach($query_array as $query){
        $res_array[] = mysqli_fetch_array($query);
    }
    
    //处理今日销售额(特殊)
    if ($res_array[7] == NULL){
        $res_array[7][0] = 0;
    }
    if ($res_array[8] == NULL){
        $res_array[8][0] = 0;
    }
    
    if ($res_array[12] == NULL){
        $res_array[12][0] = 0;
    }
    //打印结果
   /* foreach($res_array as $res){
        echo $res[0]."</br>";
    }*/
    
?>