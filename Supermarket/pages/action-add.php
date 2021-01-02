<?php
    include '../config/dbcon.php';
    include '../config/session.php';
    //设置时区，否则时分秒不对
    date_default_timezone_set('prc');
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
        $goodsID = $_POST['goodsID'];
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
        $buyPrice = $_POST['buyPrice'];
        $note = $_POST['note'];
        
        //供应批次重复，提示用户
        $sql_re = "select count(*) from tb_produce where goodsID = '{$goodsID}' and supplierID='{$supplierID}' and produceID='{$produceID}';";
        $query_re = mysqli_query($con, $sql_re);
        //取结果集行数
        $res_re = mysqli_fetch_array($query_re);
 
       if($res_re[0] == 1){
            echo "<script>alert('供应批次重复！请重新输入。');window.location.href='produce-add.php';</script>";   
        }else{
            $sql = "INSERT INTO `tb_produce` VALUES ('{$goodsID}','{$supplierID}','{$produceID}','{$buyPrice}','{$note}' );";
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
        $userPassword = hash("sha256", $_POST['userPassword']);
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
    //插入入库状况表
    else if(isset($_POST['instock-data'])){     
        $dataSet = json_decode($_POST['instock-data'],true);
        
        //一次性全入库,入库单号统一，备注统一
        $instockID =$dataSet[0]['instockID'];
        $instockDate = date('Y-m-d');
        $note = $dataSet[0]['note'];
        $userID= $_SESSION['uid'];
        
        //插入容量总数
        $instockTotal = 0;
        
        //记录插入失败的数组
        $num = 1;
        $fail_arr =array();
       foreach ($dataSet as $data){
            $data['storeID'] = substr($data['storeID'],0,6);
            $data['goodsID'] = substr($data['goodsID'],0,6);
            $data['supplierID'] = substr($data['supplierID'],0,6);
            $instockTotal += intval($data['instockNum']) ;
            $sql = "INSERT INTO tb_instocks VALUES ('{$data['instockID']}', '{$data['storeID']}', '{$data['goodsID']}', '{$data['supplierID']}', '{$data['produceID']}', '{$data['instockNum']}', '{$data['note']}');";
            $query = mysqli_query($con, $sql);
            if(!$query){
                $fail_arr[]=$num;
            }
            $num +=1;       
        }
        //因为入库单号是统一的，要么全错,要么全对
        if(count($fail_arr)==0){
            echo "入库单添加成功";
            //更新tb_instock表
            $sql = "INSERT INTO `tb_instock` VALUES ('{$instockID}', '{$instockTotal}', '{$instockDate}', '{$userID}', '{$note}');";
            $query = mysqli_query($con, $sql);
            //更新成功不提醒，失败是数据库自身问题
            if(!$query){
                echo '入库单出现问题，请检查入库单或数据库!';
            }
        }else{
            $fail = implode(",", $fail_arr);
            echo "第".$fail."行数据入库失败，请重新输入相关数据";
        }
        
    }

    //插入出库状况表
    else if(isset($_POST['outstock-data'])){
        $dataSet = json_decode($_POST['outstock-data'],true);
        
        //一次性全入库,入库单号统一，备注统一
        $outstockID =$dataSet[0]['outstockID'];
        $outstockDate = date('Y-m-d');
        $note = $dataSet[0]['note'];
        $userID= $_SESSION['uid'];
        
        //插入容量总数
        $outstockTotal = 0;
        
        //记录插入失败的数组
        $num = 1;
        $fail_arr =array();

       foreach ($dataSet as $data){
        
            $data['storeID'] = substr($data['storeID'],0,6);
            $data['goodsID'] = substr($data['goodsID'],0,6);
            $data['supplierID'] = substr($data['supplierID'],0,6);
            $outstockTotal += intval($data['outstockNum']) ;
            $sql = "INSERT INTO tb_outstocks VALUES ('{$data['outstockID']}', '{$data['storeID']}', '{$data['goodsID']}', '{$data['supplierID']}', '{$data['produceID']}', '{$data['outstockNum']}', '{$data['note']}');";
            $query = mysqli_query($con, $sql);
            if(!$query){
                $fail_arr[]=$num;
            }
            $num +=1;       
        }
        if(count($fail_arr)==0){
            echo "出库单添加成功";
            //更新tb_outstock表
            $sql = "INSERT INTO `tb_outstock` VALUES ('{$outstockID}', '{$outstockTotal}', '{$outstockDate}', '{$userID}', '{$note}');";
            $query = mysqli_query($con, $sql);
            //更新成功不提醒，失败是数据库自身问题
            if(!$query){
                echo '出库单出现问题，请检查出库单或数据库!';
            }
        }else{
            $fail = implode(",", $fail_arr);
            echo "第".$fail."行数据出库失败，请重新输入相关数据";
        }
        
    }
    //插入盘点状况表
    else if(isset($_POST['check-data'])){
        $dataSet = json_decode($_POST['check-data'],true);
        
        //一次性全盘点,盘点单号统一，备注统一
        $checkID =$dataSet[0]['checkID'];
        $checkTime = date('Y-m-d');
        $note = "库存数量准确";
        $userID= $_SESSION['uid'];
        
        //插入容量总数
        $stockTotal = 0;
        $checkTotal = 0;
        
        //记录插入失败的数组
        $num = 1;
        $fail_arr =array();
      
       foreach ($dataSet as $data){
        
            $data['storeID'] = substr($data['storeID'],0,6);
            $data['goodsID'] = substr($data['goodsID'],0,6);
            $data['supplierID'] = substr($data['supplierID'],0,6);
            $checkTotal += intval($data['checkNum']);
            $stockTotal += intval($data['stockNum']);
            
            if($data['checkNum'] != $data['stockNum']){
                $note = "库存数量有误";
            }
            
            $sql = "INSERT INTO `tb_checks` VALUES ('{$data['checkID']}', '{$data['storeID']}', '{$data['goodsID']}', '{$data['supplierID']}', '{$data['produceID']}', '{$data['stockNum']}', '{$data['checkNum']}', '{$data['note']}');";
            $query = mysqli_query($con, $sql);
            if(!$query){
                $fail_arr[]=$num;
            }
            $num +=1;       
        }
        if(count($fail_arr)==0){
            echo "盘点报表添加成功";
            //更新tb_check表
            $sql = "INSERT INTO `tb_check` VALUES ('{$checkID}', '{$stockTotal}', '{$checkTotal}', '{$checkTime}', '{$userID}', '{$note}');";
            $query = mysqli_query($con, $sql);
            //更新成功不提醒，失败是数据库自身问题
            if(!$query){
                echo '盘点报表出现问题，请检查盘点报表或数据库!';
            }
        }else{
            $fail = implode(",", $fail_arr);
            echo "第".$fail."行数据盘点报表失败，请重新输入相关数据";
        }
        
    }
    //插入采购状况表
    else if(isset ($_POST['buy-data'])){
        $dataSet = json_decode($_POST['buy-data'],true);
        
        //一次性全采购,采购单号统一
        $buyID =$dataSet[0]['buyID'];
        $buyDate = date('Y-m-d');
        $note = $dataSet[0]['note'];
        $userID= $_SESSION['uid'];
        
        //插入容量总数
        $buyTotal = 0;
        $buyAcount = 0;
        
        //记录插入失败的数组
        $num = 1;
        $fail_arr =array();
      
       foreach ($dataSet as $data){
        
            $data['goodsID'] = substr($data['goodsID'],0,6);
            $data['supplierID'] = substr($data['supplierID'],0,6);
            $buyTotal += intval($data['buyNum']);
            $buyAcount += $data['buyTips'];
            
            
            $sql = "INSERT INTO `tb_buys` VALUES ('{$data['buyID']}',  '{$data['goodsID']}', '{$data['supplierID']}', '{$data['produceID']}', '{$data['buyPrice']}', '{$data['buyNum']}', '{$data['note']}');";
            $query = mysqli_query($con, $sql);
            if(!$query){
                $fail_arr[]=$num;
            }
            $num +=1;       
        }
        if(count($fail_arr)==0){
            echo "采购订单添加成功";
            //更新tb_buy表
            $sql = "INSERT INTO `tb_buy` VALUES ('{$buyID}', '{$buyTotal}', '{$buyAcount}', '{$buyDate}', '{$userID}', '{$note}');";
            $query = mysqli_query($con, $sql);
            //更新成功不提醒，失败是数据库自身问题
            if(!$query){
                echo '采购订单出现问题，请检查采购订单或数据库!';
            }
        }else{
            $fail = implode(",", $fail_arr);
            echo "第".$fail."行数据采购输入失败，请重新输入相关数据";
        }
    }
    //添加销售订单
    else if(isset ($_POST['sale-data'])){
        $dataSet = json_decode($_POST['sale-data'],true);

        //一次性全采购,采购单号统一
        $salesID =$dataSet[0]['salesID'];
        $salesDate = date('Y-m-d');
        $salesTime  = date('H:i:s');
        $note = $_GET['salesNote'];
        $userID= $_SESSION['uid'];
        $salesChange = floatval($_GET['salesMoney'])- floatval($_GET['salesSum']);
        
        //商品数量
        $salesTotal = 0;
        // 成本、利润
        $salesCost = 0;
        $salesProfit = 0;
        //记录插入失败的数组
        $num = 1;
        $fail_arr =array();
        // get-json-produce-data
        $sql_produce = 'select * from produce';
        $produce_query = mysqli_query($con, $sql_produce);
        $produce_rows = mysqli_fetch_all($produce_query,MYSQLI_ASSOC);
       // 生成一个PHP数组
        $produce_data = array();
        foreach($produce_rows as $row){
            $produce_data[]=$row;
        }
        
        // 把PHP数组转成JSON字符串
        // $produce_json = json_encode($produce_data,JSON_UNESCAPED_UNICODE );

       foreach ($dataSet as $data){
            $data['goodsID'] = substr($data['goodsID'],0,6);
            $data['supplierID'] = substr($data['supplierID'],0,6);
            $salesTotal += intval($data['salesNum']);
            // 求成本
            foreach($produce_data as $buy){
                if($buy['goodsID'] == $data['goodsID'])
                {
                    if($buy['supplierID'] == $data['supplierID']){
                        if($buy['produceID']==$data['produceID']){
                            $salesCost += floatval($data['salesNum'])*floatval($buy['buyPrice']);
                            break;
                        }
                    }
                    
                }
            }

            $sql = "INSERT INTO `tb_sales` VALUES ('{$data['salesID']}',  '{$data['goodsID']}', '{$data['supplierID']}', '{$data['produceID']}', '{$data['salesPrice']}', '{$data['salesNum']}', '{$data['note']}');";
            $query = mysqli_query($con, $sql);
            if(!$query){
                $fail_arr[]=$num;
            }
            $num +=1;

        }

        if(count($fail_arr)==0){
            echo "销售订单添加成功";
            //更新tb_sale表
            $salesProfit = floatval($_GET['salesSum']) - floatval($salesCost);
           $sql = "INSERT INTO `tb_sale` VALUES ('{$salesID}', '{$salesTotal}', '{$_GET['salesSum']}', '{$_GET['salesMoney']}', '{$salesChange}', '{$salesProfit}', '{$salesDate}', '{$salesTime}','{$userID}','{$_GET['memberID']}','{$note}');";
          
           $query = mysqli_query($con, $sql);
            //更新成功不提醒，失败是数据库自身问题
            if(!$query){
                echo '销售订单出现问题，请检查销售订单或数据库!';
            }
        }
        else{
            $fail = implode(",", $fail_arr);
            echo "第".$fail."行销售数据输入失败，请重新输入相关数据";
        }
 
    }
    mysqli_close($con);
       
?>

