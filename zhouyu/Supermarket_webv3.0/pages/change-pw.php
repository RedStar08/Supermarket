<?php
    include'../config/dbcon.php';
    include'../config/session.php';
    
    //获取form表单信息
    $old = $_POST['oldpass'];
    $new = $_POST['newpass'];
    $re = $_POST['repass'];
    $uid = $_SESSION['uid'];
    
    //查询数据库中密码
    $sql = "Select userPassword from tb_user where userID ='$uid'";
    $query = mysqli_query($con, $sql);
    
    //获取查询行
    $row = mysqli_fetch_array($query);
    
    //密码长度符合要求
    if(strlen($new)>=6 && strlen($new)<=16){
    
    //没查询到相关数据，登录异常
        if($row == NULL){
            echo "<script>alert('登录异常，请重新登录!');window.location.href='login.php';</script>";
        }else{
            //新密码与确认密码不一致
            if($re != $new){
                echo "<script>alert('两次输入密码不一致!请重新输入');window.location.href='user-password.php';</script>";
             }else{
                //旧密码与数据库中密码不一致
                if($old != $row['userPassword']){
                    echo "<script>alert('旧密码输入不正确!请重新输入旧密码!');window.location.href='user-password.php';</script>";
                }else{
                    $sql = "Update tb_user set userPassword ='{$new}' where userID ='{$uid}'";
                    $query = mysqli_query($con, $sql);
                
                    //插入数据异常
                     if(!$query){
                        echo "<script>alert('数据库更新异常!请重新输入相关信息!');window.location.href='user-password.php';</script>";
                     }else{
                        echo "<script>alert('更改密码成功!');window.location.href='user-password.php';</script>";
                     }
                
                }   
            }
        }
       
    }else{
        echo "<script>alert('密码长度不符合要求!请重新输入!');window.location.href='user-password.php';</script>";
    }
?>
