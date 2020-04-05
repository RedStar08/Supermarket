<?php
    include '../config/session.php';
?>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>用户编辑-超市后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <link rel="stylesheet" href="../layui/css/layui.css">

    <script type="text/javascript" src="../layui/layui.js"></script>
    <script type="text/javascript" src="../js/form.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>
  </head>
  
  <body>
    <div class="x-body">
        <form class="layui-form" action="action-edit.php" method="post" style="margin-left: 25%">
          <div class="layui-form-item">
              <label class="layui-form-label" for="username">
                  <span class="x-red">*用户ID</span>
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="userID" name="userID" disabled=""
                  value="<?php $_SESSION['userID']= $_GET['0'];echo $_GET['0']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="userPassword">
                  <span class="x-red">*</span>密码
              </label>
              <div class="layui-input-inline">
                  <input type="password" id="userPassword" name="userPassword" required lay-verify="required"
                  value="<?php echo $_GET['1']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="Name">
                  <span class="x-red">*</span>姓名
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="Name" name="Name" required lay-verify="required"
                  value="<?php echo $_GET['2']?>" autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="userSex">
                  <span class="x-red">*</span>性别
              </label>
            <div class="layui-input-block" id="userSex">
              <input type="radio" name="userSex" value="男" title="男">
              <input type="radio" name="userSex" value="女" title="女">
            </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="userAge">
                  <span class="x-red">*</span>年龄
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="userAge" name="userAge" required lay-verify="number|userAge"
                  value="<?php echo $_GET['4']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item" style="width: 50%;">
              <label class="layui-form-label" for="userType">
                  <span class="x-red">*</span>级别
              </label>
              <div class="layui-input-block">
                <select name="userType" lay-verify="required" id="userType">
                  <option value="">请选择用户级别</option>
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                  <option value="5">5</option>
                </select>
              </div>
          </div>
          <div class="layui-form-item" style="width: 50%;">
              <label class="layui-form-label" for="userJob">
                  <span class="x-red">*</span>职称
              </label>
              <div class="layui-input-block">
                <select name="userJob" lay-verify="required" id="userJob">
                  <option value="">请选择用户职称</option>
                  <option value="数据库管理员">数据库管理员</option>
                  <option value="店长">店长</option>
                  <option value="采购员">采购员</option>
                  <option value="仓库管理员">仓库管理员</option>
                  <option value="收银员">收银员</option>
                </select>
              </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="userPhone">
                <span class="x-red">*</span>联系方式
            </label>
            <div class="layui-input-inline">
                <input type="text" id="userPhone" name="userPhone" required lay-verify="number|phone"
                value="<?php echo $_GET['7']?>" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
              <label class="layui-form-label" for="note">
                  备注
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="note" name="note" value="<?php echo $_GET['8']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="" name='user-edit'>
                  修改
              </button>
          </div>
      </form>
    </div>
    <script type="text/javascript" src="../js/form.js">></script>
  </body>
<script type="text/javascript">
    // 选中性别
    var userSex ="<?php echo $_GET['3'];?>";
    var checked = $('#userSex').find("input");
    if(userSex == "男"){
      $(checked[0]).attr("checked","");
    } 
    else{
      $(checked[1]).attr("checked","");
    }
    // 选中级别
    var userType = "<?php echo $_GET['5'];?>";
    var selected = $('#userType').find("option");
    for(var i=0;i<selected.length;i++){
      if(selected[i].value == userType)
        $(selected[i]).attr("selected","");
    }
    
    // 选中职称
    var userJob = "<?php echo $_GET['6'];?>";
    var job = $('#userJob').find("option");
    for(var i=0;i<job.length;i++){
      if(job[i].value == userJob)
        $(job[i]).attr("selected","");
    }

  </script>
</html>