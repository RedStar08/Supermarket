<?php
    include '../config/dbcon.php';
    // 查询商品
    //商品表中的商品ID可能不连续，因此需查询数据库，了解其在数据库中的第几行
    if(isset($_POST['goods-search'])){
        $goodsID = $_POST['goodsID'];
        $pagesize = intval($_POST['pagesize']);
        
        $sql = "select count(*) from tb_goods where goodsID = '$goodsID';";
        $query = mysqli_query($con, $sql);
        $count = mysqli_fetch_array($query);
        if($count[0] == 0){
            echo "<script>alert('要查询的商品ID不存在!');window.location.href = 'goods-list.php?&page=1&pagesize=5';</script>"; 

        }else{
            //即使插入数据ID顺序杂乱，数据库会自动排序
            $sql = "select count(*) from tb_goods where goodsID <= '$goodsID';";
            $query = mysqli_query($con, $sql);
            $stage = intval(mysqli_fetch_array($query)[0]);

            if($stage % $pagesize ==0){
                $page = $stage / $pagesize;
            }else{
                $page = intval($stage /$pagesize) + 1;
            }
            echo"<script> window.location.href = 'goods-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
        }
    }
    //查询销售商品列表
    //商品表中的商品ID可能不连续，因此需查询数据库，了解其在数据库中的第几行
    else if(isset($_POST['goodsinfo-search'])){
        $goodsID = $_POST['goodsID'];

        $sql = "select * from goods_info where goodsID = '{$goodsID}';";
        $query = mysqli_query($con, $sql);
        $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
        $pagesize = mysqli_num_rows($query);
        if($pagesize == 0){
            echo "<script>alert('要查询的商品不存在!');window.location.href = 'goods-info.php?&page=1&pagesize=5';</script>"; 
        }else{
           $recordcount = $pagesize; 
           $page = 1; 
        }  
    }
    //查询折扣商品
    else if(isset($_POST['discount-search'])){
        $disStart = "0";
        $disEnd = "3000-5-25";
        $goodsID = $_POST['disgoodsID'];
        
        if($_POST['disStart'] !="" || $_POST['disEnd'] !=""){
            //输入开始日期，截止日期查询    
            if($_POST['disStart']!="" && $_POST['disEnd'] != ""){
                $disStart = $_POST['disStart'];
                $disEnd  = $_POST['disEnd'];        
            //输入开始日期查询
            }else if($_POST['disStart']!=""){
                $disStart = $_POST['disStart'];       
            //输入截止日期查询      
            }else if($_POST['disEnd'] != ""){
                $disEnd = $_POST['disEnd'];           
            }
            $sql = "select * from goods_discount where ((disStart >= '{$disStart}' 
            and disStart <= '{$disEnd}') or (disEnd >= '{$disStart}' and disEnd <= '{$disEnd}'));";
            
         //输入商品编号查询
        }else if($_POST['disgoodsID']!=""){
            $sql = "select * from goods_discount where goodsID = '{$goodsID}';";        
        
        }
        $query = mysqli_query($con, $sql);
        $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
        $pagesize = mysqli_num_rows($query);
        if($pagesize == 0){
            echo "<script>alert('要查询的折扣商品不存在!');window.location.href = 'goods-discount.php?&page=1&pagesize=6';</script>"; 
        }else{
           $recordcount = $pagesize; 
           $page = 1;
        }
    }

    // 查询供应商
    //ID可能不连续，因此需查询数据库，了解其在数据库中的第几行
    else if(isset($_POST['supplier-search'])){
        $supplierID = $_POST['supplierID'];
        $pagesize = intval($_POST['pagesize']);
        
        $sql = "select count(*) from tb_supplier where supplierID = '$supplierID';";
        $query = mysqli_query($con, $sql);
        $count = mysqli_fetch_array($query);
        if($count[0] == 0){
            echo "<script>alert('要查询的供应商ID不存在!');window.location.href = 'supplier-list.php?&page=1&pagesize=5';</script>"; 

        }else{
            //即使插入数据ID顺序杂乱，数据库会自动排序
            $sql = "select count(*) from tb_supplier where supplierID <= '$supplierID';";
            $query = mysqli_query($con, $sql);
            $stage = intval(mysqli_fetch_array($query)[0]);

            if($stage % $pagesize ==0){
                $page = $stage / $pagesize;
            }else{
                $page = intval($stage /$pagesize) + 1;
            }
            echo"<script> window.location.href = 'supplier-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
        }
    }
    //查询供应批次
    //表中的ID可能不连续，因此需查询数据库，了解其在数据库中的第几行
    if(isset($_POST['produce-search'])){
        $goodsID = $_POST['goodsID'];

        $sql = "select * from produce where goodsID='{$goodsID}'";
        $query = mysqli_query($con, $sql);
        $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
        $pagesize = mysqli_num_rows($query);
        if($pagesize == 0){
            echo "<script>alert('要查询的商品不存在!');window.location.href = 'produce-list.php?&page=1&pagesize=5';</script>"; 
        }else{
           $recordcount = $pagesize; 
           $page = 1;
        }
    }
    //查询仓库
    //商品表中的商品ID可能不连续，因此需查询数据库，了解其在数据库中的第几行
    if(isset($_POST['store-search'])){
        $storeID = $_POST['storeID'];
        $pagesize = intval($_POST['pagesize']);
        
        $sql = "select count(*) from tb_store where storeID = '$storeID';";
        $query = mysqli_query($con, $sql);
        $count = mysqli_fetch_array($query);
        if($count[0] == 0){
            echo "<script>alert('要查询的仓库ID不存在!');window.location.href = 'store-list.php?&page=1&pagesize=5';</script>"; 

        }else{
            //即使插入数据ID顺序杂乱，数据库会自动排序
            $sql = "select count(*) from tb_store where storeID <= '$storeID';";
            $query = mysqli_query($con, $sql);
            $stage = intval(mysqli_fetch_array($query)[0]);

            if($stage % $pagesize ==0){
                $page = $stage / $pagesize;
            }else{
                $page = intval($stage /$pagesize) + 1;
            }
            echo"<script> window.location.href = 'store-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
        }
    }
    //查询员工
    //员工表中的ID可能不连续，因此需查询数据库，了解其在数据库中的第几行
    if(isset($_POST['user-search'])){
        $userID = $_POST['userID'];
        $pagesize = intval($_POST['pagesize']);
        
        $sql = "select count(*) from tb_user where userID = '$userID';";
        $query = mysqli_query($con, $sql);
        $count = mysqli_fetch_array($query);
        if($count[0] == 0){
            echo "<script>alert('要查询的员工ID不存在!');window.location.href = 'user-list.php?&page=1&pagesize=5';</script>"; 

        }else{
            //即使插入数据ID顺序杂乱，数据库会自动排序
            $sql = "select count(*) from tb_user where userID <= '$userID';";
            $query = mysqli_query($con, $sql);
            $stage = intval(mysqli_fetch_array($query)[0]);

            if($stage % $pagesize ==0){
                $page = $stage / $pagesize;
            }else{
                $page = intval($stage /$pagesize) + 1;
            }
            echo"<script> window.location.href = 'user-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
        }
    }
    //查询会员
    //会员表中的ID可能不连续，因此需查询数据库，了解其在数据库中的第几行
    if(isset($_POST['member-search'])){
        $memberID = $_POST['memberID'];
        $pagesize = intval($_POST['pagesize']);
        
        $sql = "select count(*) from tb_member where memberID = '$memberID';";
        $query = mysqli_query($con, $sql);
        $count = mysqli_fetch_array($query);
        if($count[0] == 0){
            echo "<script>alert('要查询的会员ID不存在!');window.location.href = 'member-list.php?&page=1&pagesize=5';</script>"; 

        }else{
            //即使插入数据ID顺序杂乱，数据库会自动排序
            $sql = "select count(*) from tb_member where memberID <= '$memberID';";
            $query = mysqli_query($con, $sql);
            $stage = intval(mysqli_fetch_array($query)[0]);

            if($stage % $pagesize ==0){
                $page = $stage / $pagesize;
            }else{
                $page = intval($stage /$pagesize) + 1;
            }
            echo"<script> window.location.href = 'member-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
        }
    }
    mysqli_close($con);
?>
