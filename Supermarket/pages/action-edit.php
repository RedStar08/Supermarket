<?php
    include '../config/dbcon.php';    
    include '../config/session.php';
    //编辑商品表信息,url附加信息为了编辑表能够用get既可以得到从折扣表传来的信息，也可以得到从修改表传来的信息
    if(isset($_POST['goods-edit'])){
        $goodsID = $_SESSION['goodsID'];
        $goodsName = $_POST['goodsName'];
        $goodsType = $_POST['goodsType'];
        $goodsPrice = $_POST['goodsPrice'];
        $goodsSpecs = $_POST['goodsSpecs'];
        $goodsSave = $_POST['goodsSave'];
        $note = $_POST['note'];
        
        $sql = "update tb_goods set goodsName ='$goodsName',goodsPrice='$goodsPrice',goodsType ='$goodsType',goodsSpecs = '$goodsSpecs',goodsSave='$goodsSave',note='$note' where goodsID='$goodsID'";
        
        $query = mysqli_query($con, $sql);
        $str = "&0=".$goodsID."&1=".$goodsName."&2=".$goodsType."&3=".$goodsPrice."&4=".$goodsSpecs."&5=".$goodsSave."&6=".$note; 
        if($query){  
            echo " <script>alert('修改成功!');window.location.href='goods-edit.php?{$str}';</script>"; 
        }else{
            echo"<script>alert('修改失败!请检查信息是否填写正确');window.location.href='goods-edit.php?{$str}';</script>";   
            
        }
    }
    //编辑折扣商品表信息,url附加信息为了编辑表能够用get既可以得到从折扣表传来的信息，也可以得到从修改表传来的信息
    else if(isset($_POST['discount-edit'])){
        $goodsID = $_SESSION['disgoodsID'];
        $goodsName = $_SESSION['goodsName'];
        $goodsType = $_SESSION['goodsType'];
        $disPrice = $_POST['disPrice'];
        $goodsPrice = $_SESSION['goodsPrice'];
        $produceID= $_POST['goodsProduce'];
        $disStart = $_POST['disStart'];
        $disEnd = $_POST['disEnd'];
        $note = $_POST['note'];
        
        
        $sql = "update tb_discount set goodsID ='$goodsID',produceID='$produceID',disPrice ='$disPrice',disStart = '$disStart',disEnd='$disEnd',note='$note' where goodsID='$goodsID' and produceID = '$produceID'";
        
        $query = mysqli_query($con, $sql);
        $str = "&0=".$goodsID."&1=".$goodsName."&2=".$goodsType."&3=".$disPrice."&4=".$goodsPrice."&5=".$produceID."&6=".$disStart."&7=".$disEnd."&8=".$note ;
        if($query){  
            echo " <script>alert('修改成功!');window.location.href='goods-editDis.php?{$str}';</script>"; 
        }else{
            echo"<script>alert('修改失败!请检查信息是否填写正确');window.location.href='goods-editDis.php?{$str}';</script>";      
        }
    }

    //编辑供应商表信息
    else if(isset($_POST['supplier-edit'])){
        $supplierID= $_SESSION['supplierID'];
        $supplierName = $_POST['supplierName'];
        $supplierManager = $_POST['supplierManager'];
        $supplierPhone= $_POST['supplierPhone'];
        $province = $_POST['province'];
        $city = $_POST['city'];
        $area = $_POST['area'];
        $road = $_POST['road'];
        $supplierAddress = $province."-".$city."-".$area."-".$road;
        $note = $_POST['note'];
        
        $sql = "update tb_supplier set supplierID='{$supplierID}' ,supplierName='{$supplierName}' ,supplierManager='{$supplierManager}' ,
                        supplierPhone='{$supplierPhone}' ,supplierAddress='{$supplierAddress}' ,note='{$note}' where supplierID='{$supplierID}';";
        $query = mysqli_query($con, $sql);
        $str = "&0=".$supplierID."&1=".$supplierName."&2=".$supplierManager."&3=".$supplierPhone."&4=".$supplierAddress."&5=".$note; 
        if($query){  
            echo " <script>alert('修改成功!');window.location.href='supplier-edit.php?{$str}';</script>"; 
        }else{
            echo"<script>alert('修改失败!请检查信息是否填写正确');window.location.href='supplier-edit.php?{$str}';</script>";       
        }
    }
    // 编辑仓库表
    else if(isset($_POST['store-edit'])){
        $storeID = $_SESSION['storeID'];
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
        $storeAddress = $province."-".$city."-".$area."-".$road;

        $sql = "update tb_store set storeID= '{$storeID}',storeName='{$storeName}' ,storeNum='{$storeNum}' ,storeMax='{$storeMax}' ,storeManager='{$storeManager}' ,storePhone='{$storePhone}',storeAddress='{$storeAddress}' ,note='{$note}' where storeID='{$storeID}';";
        
        $query = mysqli_query($con, $sql);
        $str = "&0=".$storeID."&1=".$storeName."&2=".$storeNum."&3=".$storeMax."&4=".$storeManager."&5=".$storePhone."&6=".$storeAddress."&7=".$note; 
        if($query){  
            echo " <script>alert('修改成功!');window.location.href='store-edit.php?{$str}';</script>"; 
        }else{
            echo"<script>alert('修改失败!请检查信息是否填写正确');window.location.href='store-edit.php?{$str}';</script>";
        }
    }
    //编辑员工表
    else if(isset($_POST['user-edit'])){
        $userID = $_SESSION['userID'];
        $userPassword = hash("sha256",$_POST['userPassword']);
        $userName = $_POST['Name'];
        $userSex = $_POST['userSex'];
        $userAge = $_POST['userAge'];
        $userType = $_POST['userType'];
        $userJob = $_POST['userJob'];
        $userPhone = $_POST['userPhone'];
        $note = $_POST['note'];
        
        $sql = "update tb_user set userID='{$userID}' ,userPassword='{$userPassword}' ,
        userName='{$userName}' ,userSex='{$userSex}' ,userAge='{$userAge}' ,
        userType='{$userType}' ,userJob='{$userJob}' ,userPhone='{$userPhone}' ,
        note='{$note}' where userID='{$userID}';";
        
        $query = mysqli_query($con, $sql);
        $str = "&0=".$userID."&1=".$userPassword."&2=".$userName."&3=".$userSex."&4=".$userAge."&5=".$userType."&6=".$userJob."&7=".$userPhone."&8=".$note; 
        if($query){  
            echo " <script>alert('修改成功!');window.location.href='user-edit.php?{$str}';</script>"; 
        }else{
            echo"<script>alert('修改失败!请检查信息是否填写正确');window.location.href='user-edit.php?{$str}';</script>";
        }
    }
    //编辑会员表
    else if(isset($_POST['member-edit'])){
        $memberID= $_SESSION['memberID'];
        $memberName = $_POST['memberName'];
        $memberSex = $_POST['memberSex'];
        $memberPhone = $_POST['memberPhone'];
        $totalSum = $_POST['totalSum'];
        $createDate = $_POST['createDate'];
        $note = $_POST['note'];
        
        $sql = "update tb_member set memberID='{$memberID}' ,memberName='{$memberName}' ,
        memberSex='{$memberSex}',memberPhone='{$memberPhone}' ,totalSum='{$totalSum}' ,
	    createDate='{$createDate}' ,note='{$note}'where memberID='{$memberID}';";
        
        $query = mysqli_query($con, $sql);
        $str = "&0=".$memberID."&1=".$memberName."&2=".$memberSex."&3=".$memberPhone."&4=".$totalSum."&5=".$createDate."&6=".$note; 
        if($query){  
            echo " <script>alert('修改成功!');window.location.href='member-edit.php?{$str}';</script>"; 
        }else{
            echo"<script>alert('修改失败!请检查信息是否填写正确');window.location.href='member-edit.php?{$str}';</script>";
        }
    } 
    //更新库存
    else if(isset($_GET['instock-update'])){
        $dataSet = json_decode($_GET['instock-update'],true);
        $dataSet['storeID'] = substr($dataSet['storeID'], 0,6);
        $dataSet['supplierID'] = substr($dataSet['supplierID'], 0,6);
        
        $sql = "update tb_stock set stockNum='{$dataSet['stockNum']}'where storeID='{$dataSet['storeID']}' and goodsID ='{$_GET['goodsID']}' and supplierID='{$dataSet['supplierID']}' and produceID ='{$dataSet['produceID']}'";
        $query = mysqli_query($con, $sql);
        if($query){
            echo"<script>alert('修改成功!');window.location.href='stock-detail.php?goodsID={$_GET['goodsID']}';</script>";
        }else{
            echo"<script>alert('修改失败!请检查信息是否填写正确');window.location.href='stock-detail.php?goodsID={$_GET['goodsID']}';</script>";
        }
      
    }
    mysqli_close($con);
?>
  