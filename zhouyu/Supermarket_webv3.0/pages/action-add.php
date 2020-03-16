<?php
    include '../config/dbcon.php';
        //插入商品表信息
    if(isset($_POST['goods-add'])){
        $goodsID = $_POST['goodsID'];
        $goodsName = $_POST['goodsName'];
        $goodsPrice = $_POST['goodsPrice'];
        $goodsType = $_POST['goodsType'];
        $goodsSpecs = $_POST['goodsSpecs'];
        $goodsSave = $_POST['goodsSave'];
        $note = $_POST['note'];
        
        //商品ID重复，提示用户
        $sql_re = "Select count(*) from tb_goods where goodsID = '$goodsID'";
        $query_re = mysqli_query($con, $sql_re);
        //取结果集行数
        $res_re = mysqli_fetch_array($query_re);
        
        if($res_re[0] == 1){
            echo "<script>alert('商品ID重复！请重新输入商品信息');window.location.href='goods-add.php';</script>";   
        }else{
            $sql = "INSERT INTO `tb_goods` VALUES ('{$goodsID}', '{$goodsName}',    '{$goodsPrice}',  '{$goodsType}',     '{$goodsSpecs}', '{$goodsSave}', '{$note}');";
            $query = mysqli_query($con, $sql);
            if($query){
                echo "<script>alert('添加商品成功!请刷新查看。');window.location.href='goods-add.php';</script>";   
            }else{
                echo "<script>alert('添加商品失败!请重新输入。');window.location.href='goods-add.php';</script>";
            }
        }   
    }
        //插入折扣商品表信息
    else if(isset($_POST['discount-add'])){
        $goodsID = $_POST['disgoodsID'];
        $disPrice = $_POST['disPrice'];
        $produceID= $_POST['goodsProduce'];
        $disStart = $_POST['disStart'];
        $disEnd = $_POST['disEnd'];
        $note = $_POST['note'];
        
        //判断商品ID与生产批号是否重复
        $sql_re = "select count(*) from tb_discount where goodsID = '{$goodsID}' and produceID ='{$produceID}'";
        $query_re = mysqli_query($con, $sql_re);
        $res_re = mysqli_fetch_array($query_re)[0];
        
        if($res_re != 0){
            echo "<script>alert('折扣商品已存在！请重新输入。');window.location.href='goods-addDis.php';</script>";
        }else{
            $sql = "INSERT INTO `tb_discount` VALUES ('{$goodsID}', '$produceID', '{$disPrice}','{$disStart}','{$disEnd}','{$note}');";
            $query = mysqli_query($con, $sql);
            if($query){
                echo "<script>alert('添加折扣商品成功!请按刷新查看。');window.location.href='goods-addDis.php';</script>";   
            }else{
                echo "<script>alert('添加折扣商品失败!请重新输入。');window.location.href='goods-addDis.php';</script>";
            }        
        }
    }
    //插入供应商表信息
    else if(isset($_POST['supplier-add'])){
        $supplierID = $_POST['supplierID'];
        $supplierName = $_POST['supplierName'];
        $supplierManager= $_POST['supplierManager'];
        $supplierPhone = $_POST['supplierPhone'];
        $province = $_POST['province'];
        $city = $_POST['city'];
        $area = $_POST['area'];
        $road = $_POST['road'];
        $supplierAddress = $province."-".$city."-".$area."-".$road;
        $note = $_POST['note'];
        //判断供应商ID是否重复
        $sql_re = "select count(*) from tb_supplier where supplierID = '{$supplierID}'";
        $query_re = mysqli_query($con, $sql_re);
        $res_re = mysqli_fetch_array($query_re)[0];
        
        if($res_re != 0){
            echo "<script>alert('供应商已存在！请重新输入。');window.location.href='supplier-add.php';</script>";
        }else{
            $sql = "INSERT INTO `tb_supplier` VALUES ('{$supplierID}', '{$supplierName}','{$supplierManager}','{$supplierPhone}','{$supplierAddress}','{$note}');";
            $query = mysqli_query($con, $sql);
            if($query){
                echo "<script>alert('添加供应商成功!请刷新查看。');window.location.href='supplier-add.php';</script>";   
            }else{
                echo "<script>alert('添加供应商失败!请重新输入。');window.location.href='supplier-add.php';</script>";
            }        
        }
    }
    //插入供应批次信息,三个主码
    elseif(isset($_POST['produce-add'])){
        $goodsID = $_POST['goodsID'];
        $supplierID = $_POST['supplierID'];
        $produceID = $_POST['produceID'];
        $note = $_POST['note'];
        
        //供应批次重复，提示用户
        $sql_re = "select count(*) from tb_produce where goodsID = '{$goodsID}' and supplierID='{$supplierID}' and produceID='{$produceID}';";
        $query_re = mysqli_query($con, $sql_re);
        //取结果集行数
        $res_re = mysqli_fetch_array($query_re);
 
       if($res_re[0] == 1){
            echo "<script>alert('供应批次重复！请重新输入。');window.location.href='produce-add.php';</script>";   
        }else{
            $sql = "INSERT INTO `tb_produce` VALUES ('{$goodsID}' ,'{$supplierID}' ,'{$produceID}' ,'{$note}' );";
            $query = mysqli_query($con, $sql);
            if($query){
                echo "<script>alert('添加供应批次成功!请刷新供应批次表查看。');window.location.href='produce-add.php';</script>";   
            }else{
                echo "<script>alert('添加供应批次失败!请重新输入。');window.location.href='produce-add.php';</script>";
            }
        }          
    }
    //插入仓库表
    else if(isset($_POST['store-add'])){
        $storeID = $_POST['storeID'];
        $storeName = $_POST['storeName'];
        $storeNum = $_POST['storeNum'];
        $storeMax = $_POST['storeMax'];
        $storeManager = $_POST['storeManager'];
        $storePhone = $_POST['storePhone'];
        $province = $_POST['province'];
        $city = $_POST['city'];
        $area = $_POST['area'];
        $road = $_POST['road'];
        $note = $_POST['note'];
         
        
        //商品ID重复，提示用户
        $sql_re = "Select count(*) from tb_store where storeID = '$storeID'";
        $query_re = mysqli_query($con, $sql_re);
        //取结果集行数
        $res_re = mysqli_fetch_array($query_re);
 
       if($res_re[0] == 1){
            echo "<script>alert('仓库ID重复！请重新输入。');window.location.href='store-add.php';</script>";   
        }else{
            $storeAddress = $province."-".$city."-".$area."-".$road;
            $sql = "INSERT INTO `tb_store` VALUES ('{$storeID}', '{$storeName}', '{$storeNum}', '{$storeMax}', '{$storeManager}', '{$storePhone}', '{$storeAddress}', '{$note}');";
            $query = mysqli_query($con, $sql);
            if($query){
                echo "<script>alert('添加仓库成功!请刷新商品查看。');window.location.href='store-add.php';</script>";   
            }else{
                echo "<script>alert('添加仓库失败!请重新输入。');window.location.href='store-add.php';</script>";
            }
        }  
    }

    //插入员工表信息
    else if(isset($_POST['user-add'])){
        $userID = $_POST['userID'];
        $userPassword = $_POST['userPassword'];
        $userName = $_POST['Name'];
        $userSex = $_POST['userSex'];
        $userAge = $_POST['userAge'];
        $userType = $_POST['userType'];
        $userJob = $_POST['userJob'];
        $userPhone = $_POST['userPhone'];
        $note = $_POST['note'];
         
        //用户ID重复，提示
        $sql_re = "Select count(*) from tb_user where userID = '$userID'";
        $query_re = mysqli_query($con, $sql_re);
        //取结果集行数
        $res_re = mysqli_fetch_array($query_re);
 
       if($res_re[0] == 1){
            echo "<script>alert('员工ID重复！请重新输入。');window.location.href='user-add.php';</script>";   
        }else{
            $sql = "INSERT INTO `tb_user` VALUES ('{$userID}', '{$userPassword}', '{$userName}', '{$userSex}', '{$userAge}', '{$userType}', '{$userJob}','{$userPhone}', '{$note}');";
            $query = mysqli_query($con, $sql);
            if($query){
                echo "<script>alert('添加员工成功!请刷新查看。');window.location.href='user-add.php';</script>";   
            }else{
                echo "<script>alert('添加员工失败!请重新输入。');window.location.href='user-add.php';</script>";
            }
        }         
    }
    //插入会员表信息
    else if(isset($_POST['member-add'])){
        $memberID= $_POST['memberID'];
        $memberName = $_POST['memberName'];
        $memberSex = $_POST['memberSex'];
        $memberPhone = $_POST['memberPhone'];
        $totalSum = $_POST['totalSum'];
        $createDate = $_POST['createDate'];
        $note = $_POST['note'];
         
        //会员ID重复，提示
        $sql_re = "Select count(*) from tb_member where memberID= '$memberID'";
        $query_re = mysqli_query($con, $sql_re);
        //取结果集行数
        $res_re = mysqli_fetch_array($query_re);
 
       if($res_re[0] == 1){
            echo "<script>alert('会员ID重复！请重新输入。');window.location.href='member-add.php';</script>";   
        }else{
            $sql = "INSERT INTO `tb_member` VALUES ('{$memberID}', '{$memberName}', '{$memberSex}', '{$memberPhone}','{$totalSum} ','{$createDate}',  '{$note}');";
            $query = mysqli_query($con, $sql);
            if($query){
                echo "<script>alert('添加会员成功!请刷新会员表查看。');window.location.href='member-add.php';</script>";   
            }else{
                echo "<script>alert('添加会员失败!请重新输入。');window.location.href='member-add.php';</script>";
            }
        }         
    }

    mysqli_close($con);
       
?>

