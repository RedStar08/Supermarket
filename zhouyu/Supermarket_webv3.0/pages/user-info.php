<?php
    include '../config/dbcon.php';
    include '../config/session.php';
    $uid = $_SESSION['uid'];
    $sql = "Select * from tb_user where userID ='$uid'";
    $query = mysqli_query($con,$sql);
    $row = mysqli_fetch_array($query);
    mysqli_free_result($query);
    mysqli_close($con);
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>用户信息-超市管理系统</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
        <link rel="stylesheet" href="../css/font.css">
        <link rel="stylesheet" href="../css/xadmin.css">
    </head>
<body>
    <div class="x-body layui-anim layui-anim-up" style="text-align: center;">
        <!-- 用户信息模块 -->
        <fieldset class="layui-elem-field" >
            <legend style="text-align: center;">用户信息</legend>
            <div class="layui-field-box">
                <table class="layui-table">
                    <tbody>
                        <tr>
                            <th>用户ID</th>
                            <td><?php echo htmlspecialchars($row['userID']);?></td>
                        </tr>
                        <tr>
                            <th>姓名</th>
                            <td><?php echo htmlspecialchars($row['userName']);?></td>
                        </tr>
                        <tr>
                            <th>性别</th>
                            <td><?php echo htmlspecialchars($row['userSex']);?></td>
                        </tr>
                        <tr>
                            <th>年龄</th>
                            <td><?php echo htmlspecialchars($row['userAge']);?></td>
                        </tr>
                        <tr>
                            <th>级别</th>
                            <td><?php echo htmlspecialchars($row['userType']);?></td>
                        </tr> 
                        <tr>
                            <th>职称</th>
                            <td><?php echo htmlspecialchars($row['userJob']);?></td>
                        </tr> 
                        <tr>
                            <th>联系方式</th>
                            <td><?php echo htmlspecialchars($row['userPhone']);?></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
        </fieldset>
    </div>
</body>

</html>