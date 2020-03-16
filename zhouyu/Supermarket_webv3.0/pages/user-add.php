<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>用户添加-超市后台管理系统</title>
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
        <form class="layui-form" action="action-add.php" method="post" style="margin-left: 25%">
          <div class="layui-form-item">
              <label class="layui-form-label" for="userID">
                  <span class="x-red">*</span>用户ID
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="userID" name="userID" required lay-verify="userID|username"
                   placeholder="请输入用户ID" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="userPassword">
                  <span class="x-red">*</span>密码
              </label>
              <div class="layui-input-inline">
                  <input type="password" id="userPassword" name="userPassword" required lay-verify="required"
                  autocomplete="off" placeholder="请输入密码" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="Name">
                  <span class="x-red">*</span>姓名
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="Name" name="Name" required lay-verify="required"
                  autocomplete='off' class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="userSex">
                  <span class="x-red">*</span>性别
            </label>
            <div class="layui-input-block" id="userSex" >
              <input type="radio" name="userSex" value="男" title="男" >
              <input type="radio" name="userSex" value="女" title="女" >
            </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="userAge">
                  <span class="x-red">*</span>年龄
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="userAge" name="userAge" required lay-verify="number|userAge"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item" style="width: 50%;">
              <label class="layui-form-label" for="userType">
                  <span class="x-red">*</span>级别
              </label>
              <div class="layui-input-block" >
                <select id="userType" name="userType" lay-verify="required" >
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
                <select name="userJob" lay-verify="required">
                  <option value="">请选择用户职称</option>
                  <option value="1">数据库管理员</option>
                  <option value="2">店长</option>
                  <option value="3">采购员</option>
                  <option value="4">仓库管理员</option>
                  <option value="5">收银员</option>
                </select>
              </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="userPhone">
                <span class="x-red">*</span>联系方式
            </label>
            <div class="layui-input-inline">
                <input type="text" id="userPhone" name="userPhone" required lay-verify="number|phone"
                autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
              <label class="layui-form-label" for="note">
                  备注
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="note" name="note" autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" name='user-add' lay-submit="">
                  添加员工
              </button>
          </div>
      </form>
    </div>
    <script type="text/javascript" src="../js/form.js">></script>
  </body>
  
</html>