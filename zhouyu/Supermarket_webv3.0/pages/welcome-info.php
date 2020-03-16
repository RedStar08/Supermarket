<?php
    date_default_timezone_set('prc');
    $data="20".date('y-m-d',time());
    include '../config/dbcon.php';
    
    //SQL语句数组
    $sql_array = array();
    //SQL语句逐个添加
    $sql_array[] = "SELECT count(*) FROM `tb_goods`";
    $sql_array[] = "SELECT count(*) FROM `tb_store`";
    $sql_array[] = "SELECT count(*) FROM `tb_supplier`";
    $sql_array[] = "SELECT count(*) FROM `tb_user`";
    $sql_array[] = "SELECT sum(salesSum) FROM `tb_sale` group by salesDate having salesDate='$data'";
    $sql_array[] = "SELECT sum(salesSum) FROM `tb_sale`";
    
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
    if ($res_array[4] == NULL){
        $res_array[4][0] = 0;
    }
    
    //打印结果
   /* foreach($res_array as $res){
        echo $res[0]."</br>";
    }*/
    
?>