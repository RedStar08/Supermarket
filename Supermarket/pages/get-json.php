<?php
    include '../config/dbcon.php';
    // get-json-produce-data
    $sql = 'select * from produce';
    $query = mysqli_query($con, $sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
   // 生成一个PHP数组
    $data = array();
    foreach($rows as $row){
        $data[]=$row;
    }
    
    // 把PHP数组转成JSON字符串
    $produce_json = json_encode($data,JSON_UNESCAPED_UNICODE );
    // file_put_contents('../json/produce.json', $produce_json);


    // get-json-stocks-data
    $sql = 'select * from stocks';
    $query = mysqli_query($con, $sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
   // 生成一个PHP数组
    $data = array();
    foreach($rows as $row){
        $data[]=$row;
    }
 
    // 把PHP数组转成JSON字符串
    $stock_json = json_encode($data,JSON_UNESCAPED_UNICODE );
    

    // get-json-discount-data
    $sql = 'select goodsID,produceID,disPrice,disStart,disEnd from tb_discount';
    $query = mysqli_query($con, $sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
   // 生成一个PHP数组
    $data = array();
    foreach($rows as $row){
        $data[]=$row;
    }
 
    // 把PHP数组转成JSON字符串
    $discount_json = json_encode($data,JSON_UNESCAPED_UNICODE );
 

    // get-json-goods_inf-data
    $sql = 'select goodsID,goodsName,goodsPrice,supplierID,supplierName,produceID from goods_info';
    $query = mysqli_query($con, $sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
   // 生成一个PHP数组
    $data = array();
    foreach($rows as $row){
        $data[]=$row;
    }
 
    // 把PHP数组转成JSON字符串
    $goodsInfo_json = json_encode($data,JSON_UNESCAPED_UNICODE );

 
    // 订单统计
    // get-json-produce-data
    $sql = 'select * from daily_count';
    $query = mysqli_query($con, $sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
   // 生成一个PHP数组
    $data = array();
    foreach($rows as $row){
        $data[]=$row;
    }
    
    // 把PHP数组转成JSON字符串
    $daily_count_json = json_encode($data,JSON_UNESCAPED_UNICODE );
    // file_put_contents('../json/daily_count.json', $produce_json);


    // 订单统计
    // get-json-produce-data
    $sql = 'select * from sales_count  ORDER BY goodsIDName DESC';
    $query = mysqli_query($con, $sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
   // 生成一个PHP数组
    $data = array();
    foreach($rows as $row){
        $data[]=$row;
    }
    
    // 把PHP数组转成JSON字符串
    $sales_count_json = json_encode($data,JSON_UNESCAPED_UNICODE );
    // file_put_contents('../json/sales_count.json', $sales_count_json);


?>
