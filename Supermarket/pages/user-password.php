<?php
    include '../config/dbcon.php';
    include '../config/session.php';
    //避免用户直接打开此页面进行密码修改
    if(empty($_SESSION['uid'])){
        header('Location:user-password.php');
    }
?>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>密码修改-超市管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <link rel="stylesheet" href="../css/public.css">

    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>
  </head>
  
  <body>
    <div class="x-body">
        <form class="layui-form" lay-filter="changePass" method="post" action="change-pw.php">
          <!-- 用户名显示模块 -->
          <!-- 获取用户名放value中 -->
          <div class="layui-form-item">
              <label for="userID" class="layui-form-label">
                  用户ID
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="userID" name="username" disabled 
                  value="<?php echo $_SESSION['uid']?>" class="layui-input">
              </div>
          </div>
          <!-- 旧密码 -->
          <div class="layui-form-item">
              <label for="password" class="layui-form-label">
                  <span class="x-red">*</span>旧密码
              </label>
              <div class="layui-input-inline">
                  <input type="password" id="oldpass" name="oldpass" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <!-- 新密码 -->
          <div class="layui-form-item">
              <label for="newpass" class="layui-form-label">
                  <span class="x-red">*</span>新密码
              </label>
              <div class="layui-input-inline">
                  <input type="password" id="newpass" name="newpass" lay-verify="required|pass"
                  autocomplete="off" class="layui-input">
              </div>
              <div class="layui-form-mid layui-word-aux">
                  请输入6到12个字符
              </div>
          </div>
          <!-- 确认密码 -->
          <div class="layui-form-item">
              <label for="repass" class="layui-form-label">
                  <span class="x-red">*</span>确认密码
              </label>
              <div class="layui-input-inline">
                  <input type="password" id="repass" name="repass" required lay-verify="required|pass"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <!-- 修改按钮 -->
          <div class="layui-form-item" style="margin: 5% 0% 0% 5%;">
              <label for="L_repass" class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-submit lay-filter="save">
                  修改
              </button>
          </div>
      </form>
    </div>
    <script type="text/javascript" src="../js/form.js"></script>
<script>
layui.use(['form','layer'], function(){
    var form = layui.form
    ,layer = layui.layer;

    //监听提交
    form.on('submit(save)', function(obj){
      // console.log(obj);
      var data = obj.field;
      //发异步，把数据提交给php
      if(data.newpass == data.oldpass){
        // 密码不相同
       layer.msg('不能与新密码相同!',{icon: 5,time:1000});
          return false;
      }
      else if(data.newpass != data.repass){
        // 密码不相同
       layer.msg('两次密码不相同!',{icon: 5,time:1000});
          return false;
      }

    });
        
});
</script>

  </body>

</html>