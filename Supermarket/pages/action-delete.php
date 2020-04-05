<?php
   include '../config/dbcon.php';
    $page = $_POST['page'];
    $pagesize = $_POST['pagesize'];
    
    //单项删除商品表
    if (isset($_POST['goods-delete'])){
        $goodsID = $_POST['goodsID'];
        $sql = "Delete from tb_goods where goodsID ='$goodsID' ";
        $query = mysqli_query($con,$sql);
        if(!$query){
        echo "<script>alert('商品{$goodsID}删除失败!已产生交易订单');</script> ";        
       }else{
        echo"<script>alert('商品删除成功!');</script>"; 
       } 
        echo"<script> window.location.href = 'goods-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }//批量删除商品表
    else if(isset($_POST['goodsSet-delete'])){ 
        $fail_goods = array();
        $goodsIDSet = explode(',', $_POST['goodsIDSet']);
        foreach ($goodsIDSet as $id){
                $sql = "Delete from tb_goods where goodsID ='$id' ";
                $query = mysqli_query($con,$sql);
                if(!$query){
                    $fail_goods [] = $id;
                }    
            }
        if(count($fail_goods)== 0){
            echo "<script>alert('商品删除成功!');</script>"; 
        }else{
            $fail_goods = implode(',', $fail_goods);
            echo "<script> alert('商品{ $fail_goods}删除失败!已产生交易订单'); </script>";
        }  
       echo"<script> window.location.href = 'goods-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }
    
    //单项删除折扣商品表
    else if(isset($_POST['disgoods-delete'])){
        $goodsID = $_POST['disgoodsID'];
        $produceID = $_POST['produceID'];
        $sql = "Delete from tb_discount where goodsID ='$goodsID'and produceID ='$produceID' ";
        $query = mysqli_query($con,$sql);
        if(!$query){
            echo "<script>alert('折扣商品{$goodsID},生产批号{$produceID}删除失败!已产生交易订单');</script> ";        
        }else{
            echo"<script>alert('折扣商品删除成功!');</script>"; 
        } 
            echo"<script> window.location.href = 'goods-discount.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }//批量删除折扣商品表
    else if(isset($_POST['disgoodsSet-delete'])){
        $fail_goodsID = array();
        $fail_pID = array();
        $goodsIDSet = explode(',', $_POST['disgoodsIDSet']);
        $produceSet = explode(',', $_POST['produceSet']);
        $num = count($goodsIDSet);
        for ($i=0 ;$i<$num ;$i++){
                $sql = "Delete from tb_discount where goodsID ='$goodsIDSet[$i]'and produceID ='$produceSet[$i]'  ";
                $query = mysqli_query($con,$sql);
                if(!$query){
                    $fail_goods [] = $goodsIDSet[$i];
                    $fail_pID[] = $produceSet[$i];
                }    
            }
        if(count($fail_goods)== 0){
            echo "<script>alert('折扣商品删除成功!');</script>"; 
        }else{
            $str = "";
            for($j=0 ; $j<count($fail_goods); $j++){
                $str .= "折扣商品".$fail_goods[$j].",生产批号".$fail_pID[$j].";";
            }
            //$fail_goods = implode(',', $fail_goods);
            //$fail_pID = implode(',',$fail_pID);
            echo "<script> alert('{ $str}删除失败!已产生交易订单'); </script>";
        }  
       echo"<script> window.location.href = 'goods-discount.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }
    
    //单项供应商删除
    else if (isset($_POST['supplier-delete'])){
        $supplierID = $_POST['supplierID'];
        $sql = "Delete from tb_supplier where supplierID ='$supplierID' ";
        $query = mysqli_query($con,$sql);
        if(!$query){
        echo "<script>alert('供应商{$supplierID}删除失败!已有采购记录');</script> ";        
       }else{
        echo"<script>alert('供应商删除成功!');</script>"; 
       } 
        echo"<script> window.location.href = 'supplier-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";  
    }//批量供应商删除
    else if(isset ($_POST['supplierSet-delete'])){
        $fail_sup = array();
        $supplierIDSet = explode(',', $_POST['supplierIDSet']);
        foreach ($supplierIDSet as $id){
                $sql = "Delete from tb_supplier where supplierID ='$id' ";
                $query = mysqli_query($con,$sql);
                if(!$query){
                    $fail_sup[] = $id;
                }    
            }
        if(count($fail_sup)== 0){
            echo "<script>alert('供应商删除成功!');</script>"; 
        }else{
            $fail_sup = implode(',', $fail_sup);
            echo "<script> alert('供应商{ $fail_sup}删除失败!已有采购记录'); </script>";
        }  
       echo"<script> window.location.href = 'supplier-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }
    
    //单项供应批次删除,三主码都存在
    else if (isset($_POST['produce-delete'])){
        $goodsID = $_POST['goodsID'];
        $supplierID = $_POST['supplierID'];
        $produceID = $_POST['produceID'];
        $sql = "delete from tb_produce where goodsID = '{$goodsID}' and supplierID='{$supplierID}' and produceID='{$produceID}'; ";
        $query = mysqli_query($con,$sql);
        if(!$query){
        echo "<script>alert('商品编号{$goodsID},供应商编号{$supplierID},生产批号{$produceID}删除失败!已被采购');</script> ";        
       }else{
        echo"<script>alert('供应批次删除成功!');</script>"; 
       } 
        echo"<script> window.location.href = 'produce-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }
    //批量供应批次删除，三主码都存在
    else if(isset($_POST['produceSet-delete'])){
        $fail_goodsID = array();
        $fail_sID = array();
        $fail_pID = array();
        $goodsIDSet = explode(',', $_POST['goodsIDSet']);
        $supplierIDSet = explode(',', $_POST['supplierIDSet']);
        $produceIDSet = explode(',', $_POST['produceIDSet']);

        $num = count($goodsIDSet);
        for ($i=0 ;$i<$num ;$i++){
                $sql = "delete  from tb_produce where goodsID = '{$goodsIDSet[$i]}' and supplierID='{$supplierIDSet[$i]}' and produceID='{$produceIDSet[$i]}';  ";
                $query = mysqli_query($con,$sql);
                if(!$query){
                    $fail_goodsID[] = $goodsIDSet[$i];
                    $fail_sID = $supplierIDSet[$i];
                    $fail_pID[] = $produceIDSet[$i];
                }    
            }
        if(count($fail_goodsID)== 0){
            echo "<script>alert('供应批次删除成功!');</script>"; 
        }else{
            $str = "";
            for($j=0 ; $j<count($fail_goodsID); $j++){
                $str .= "商品编号".$fail_goodsID[$j].",供应商批号".$fail_sID[$j].",生产批号".$fail_pID[$j].";";
            }
            //$fail_goods = implode(',', $fail_goods);
            //$fail_pID = implode(',',$fail_pID);
            echo "<script> alert('{ $str}删除失败!已被采购'); </script>";
        }  
       echo"<script> window.location.href = 'produce-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }

    //单项仓库删除
    else if (isset($_POST['store-delete'])){
        $storeID = $_POST['storeID'];
        $sql = "Delete from tb_store where storeID ='$storeID' ";
        $query = mysqli_query($con,$sql);
        if(!$query){
        echo "<script>alert('仓库{$storeID}删除失败!已有出入库记录');</script> ";        
       }else{
        echo"<script>alert('仓库删除成功!');</script>"; 
       }
        echo"<script> window.location.href = 'store-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }//批量仓库删除
    else if(isset ($_POST['storeSet-delete'])){
        $fail_store = array();
        $storeIDSet = explode(',', $_POST['storeIDSet']);
        foreach ($storeIDSet as $id){
                $sql = "Delete from tb_store where storeID ='$id' ";
                $query = mysqli_query($con,$sql);
                if(!$query){
                    $fail_store [] = $id;
                }    
            }
        if(count($fail_store)== 0){
            echo "<script>alert('仓库删除成功!');</script>"; 
        }else{
            $fail_store = implode(',', $fail_store);
            echo "<script> alert('仓库{ $fail_store}删除失败!已有出入库记录'); </script>";
        }  
       echo"<script> window.location.href = 'store-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }
    
    //单项用户删除
    else if (isset($_POST['user-delete'])){
        $userID = $_POST['userID'];
        $sql = "delete from tb_user where userID='{$userID}'; ";
        $query = mysqli_query($con,$sql);
        if(!$query){
        echo "<script>alert('员工{$userID}删除失败!有工作未交接');</script> ";        
       }else{
        echo"<script>alert('员工删除成功!');</script>"; 
       } 
        echo"<script> window.location.href = 'user-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }//批量用户删除
    else if(isset ($_POST['userSet-delete'])){
        $fail_user = array();
        $userIDSet = explode(',', $_POST['userIDSet']);
        foreach ($userIDSet as $id){
                $sql = "Delete from tb_user where userID ='$id' ";
                $query = mysqli_query($con,$sql);
                if(!$query){
                    $fail_user [] = $id;
                }    
            }
        if(count($fail_user)== 0){
            echo "<script>alert('员工删除成功!');</script>"; 
        }else{
            $fail_user = implode(',', $fail_user);
            echo "<script> alert('员工{ $fail_user}删除失败!有工作未交接'); </script>";
        }  
       echo"<script> window.location.href = 'user-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }

    //单项会员删除
    else if (isset($_POST['member-delete'])){
        $memberID = $_POST['memberID'];
        $sql = "delete from tb_member where memberID='{$memberID}'; ";
        $query = mysqli_query($con,$sql);
        if(!$query){
        echo "<script>alert('会员$memberID}删除失败!有工作未交接');</script> ";        
       }else{
        echo"<script>alert('会员删除成功!');</script>"; 
       } 
        echo"<script> window.location.href = 'member-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }//批量会员删除
    else if(isset ($_POST['memberSet-delete'])){
        $fail_mem = array();
        $memberIDSet = explode(',', $_POST['memberIDSet']);
        foreach ($memberIDSet as $id){
                $sql = "Delete from tb_member where memberID ='$id' ";
                $query = mysqli_query($con,$sql);
                if(!$query){
                    $fail_mem [] = $id;
                }    
            }
        if(count($fail_mem)== 0){
            echo "<script>alert('会员删除成功!');</script>"; 
        }else{
            $fail_mem = implode(',', $fail_mem);
            echo "<script> alert('会员{ $fail_mem}删除失败!有工作未交接'); </script>";
        }  
       echo"<script> window.location.href = 'member-list.php?&page='+{$page}+'&pagesize='+{$pagesize};</script>";
    }

    mysqli_close($con);
  ?>

        
