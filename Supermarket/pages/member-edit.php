<?php
    include '../config/session.php';
?>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>会员编辑-超市后台管理系统</title>
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
                  <span class="x-red">*会员ID</span>
              </label>
              <div class="layui-input-inline">
                  <input type="username" id="userID" name="memberID" disabled=""
                  value="<?php $_SESSION['memberID']= $_GET['0'];echo $_GET['0']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="memberName">
                  <span class="x-red">*</span>姓名
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="memberName" name="memberName" required lay-verify="required"
                  value="<?php echo $_GET['1'];?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="memberSex">
                  <span class="x-red">*</span>性别
              </label>
            <div class="layui-input-block" id="memberSex">
              <input type="radio" name="memberSex" value="男" title="男">
              <input type="radio" name="memberSex" value="女" title="女">
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="memberPhone">
                <span class="x-red">*</span>联系方式
            </label>
            <div class="layui-input-inline">
                <input type="text" id="memberPhone" name="memberPhone" required lay-verify="number|phone"
                value="<?php echo $_GET['3'];?>" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="totalSum">
                <span class="x-red">*</span>累积消费
            </label>
            <div class="layui-input-inline">
                <input type="text" id="totalSum" name="totalSum" required lay-verify="number|goodsPrice"
                value="<?php echo $_GET['4'];?>" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="createDate">
                <span class="x-red">*</span>注册日期
            </label>
            <div class="layui-input-inline">
                <input type="text" id="createDate" name="createDate" required lay-verify="date"
                value="<?php echo $_GET['5'];?>" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
              <label class="layui-form-label" for="note">
                  备注
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="note" name="note" value="<?php echo $_GET['6'];?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="" name='member-edit'>
                  修改
              </button>
          </div>
      </form>
    </div>
    <script type="text/javascript" src="../js/form.js">></script>
  </body>
  <script>
          // 选中性别
    var userSex ="<?php echo $_GET['2'];?>";
    var checked = $('#memberSex').find("input");
    if(userSex == "男"){
      $(checked[0]).attr("checked","");
    } 
    else{
      $(checked[1]).attr("checked","");
    }
  </script>
</html>