
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>登录-超市管理系统</title>
<link rel="stylesheet" type="text/css" href="../css/login.css">
</head>
<body>
	<div style="height: 50px;color: #fff;text-align: center;font-size: 45px;font-weight:600;padding: 4% 0 0;">
		超市管理系统
	</div>
	<div id="wrapper" class="login-page">
		<div id="login_form" class="form">
			<form class="login-form" action="login.php" method="post">
 				<h2>账号登录</h2>
				<input type="text" id="userID" name="user_ID" placeholder="用户名" required lay-verify="number|ID">
				<input type="password" id="userPassword" name="user_Password" placeholder="密码" >
				<button id="login">登　录</button>
			</form>
		</div>
	</div>
<script src="../js/jquery.min.js"></script>
</body>
</html>
<?php 
    if(isset($_POST["user_ID"])) {
        include('../config/dbcon.php'); 
        include('../config/session.php');
		$uid = $_POST['user_ID'];
		$pw = $_POST['user_Password'];
        
        //进行查询
		$query =  mysqli_query($con, "SELECT * FROM tb_user WHERE  userID='$uid'") or die($mysqli_error($con));

        //获取查询行
        $row = mysqli_fetch_array($query);
        //hash加密
        $r_pw = hash("sha256", $pw);
		//字符串对比
        $is_True = strcmp($r_pw, $row['userPassword']);
        //查询完毕，释放结果集
        mysqli_free_result($query);
        
        //查询完毕，关闭连接
        mysqli_close($con);      

        //如果查询为空集
		if($row==NULL || $is_True != 0) {
	                //警示框提醒用户信息输入错误，并跳转到登录界面重新输入
	                echo "<script>
	                	alert('用户名或密码不正确!请重新输入');window.location.href='login.php';
	                </script>";           
	    }
		else {
	        //登录用户信息存入session中
			$_SESSION['uid'] = $uid;
	        $_SESSION['uname'] = $row['userName'];
	        $_SESSION['utype'] = $row['userType'];
	        echo "<script>
	        	alert('登录成功!');window.location.href='index.php';
	        </script>"; 
		}   
    }
?>