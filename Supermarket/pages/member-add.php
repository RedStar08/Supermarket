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
              <label class="layui-form-label" for="memberID">
                  <span class="x-red">*</span>会员ID
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="memberID" name="memberID" required lay-verify="memberID"
                  autocomplete="off" placeholder="请输入用户ID" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="memberName">
                  <span class="x-red">*</span>姓名
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="memberName" name="memberName" required lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="memberName">
                  <span class="x-red">*</span>性别
              </label>
            <div class="layui-input-block">
              <input type="radio" name="memberSex" value="男" title="男" checked>
              <input type="radio" name="memberSex" value="女" title="女">
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="memberPhone">
                <span class="x-red">*</span>联系方式
            </label>
            <div class="layui-input-inline">
                <input type="text" id="memberPhone" name="memberPhone" required lay-verify="number|phone"
                autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="totalSum">
                <span class="x-red">*</span>累积消费
            </label>
            <div class="layui-input-inline">
                <input type="text" id="totalSum" name="totalSum" required lay-verify="number|goodsPrice"
                autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="createDate">
                <span class="x-red">*</span>注册日期
            </label>
            <div class="layui-input-inline">
                <input type="text" id="createDate" name="createDate" required lay-verify="date"
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
              <button  class="layui-btn" lay-filter="add" name='member-add' lay-submit="">
                  添加会员
              </button>
          </div>
      </form>
    </div>
    <script type="text/javascript" src="../js/form.js">></script>
  </body>
  <script type="text/javascript">
    layui.use(['form','layer','laydate'], function(){
          var form = layui.form
          ,layer = layui.layer
          ,laydate = layui.laydate;

          //执行一个laydate实例
          laydate.render({
            elem: '#createDate' //指定disStart
            ,showBottom: false
          });   
          
});
  </script>
</html>