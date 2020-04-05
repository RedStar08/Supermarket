<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>商品添加-超市后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <link rel="stylesheet" href="../css/public.css">
    <link rel="stylesheet" href="../layui/css/layui.css">

    <script type="text/javascript" src="../layui/layui.js"></script>
    <script type="text/javascript" src="../js/form.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>
  </head>
  
  <body>
    <div class="x-body">
        <form class="layui-form" action="action-add.php" method="post">
          <div class="layui-form-item">
              <label class="layui-form-label" for="goodsID">
                  <span class="x-red">*</span>商品ID
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsID" name="goodsID" required lay-verify="number|goodsID"
                  autocomplete="off" placeholder="请输入商品ID" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="goodsName">
                  <span class="x-red">*</span>商品名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsName" name="goodsName" required lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="goodsPrice">
                  <span class="x-red">*</span>商品价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsPrice" name="goodsPrice" required lay-verify="number|goodsPrice"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="goodsType">
                  <span class="x-red">*</span>商品类别
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsType" name="goodsType" required lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label" for="goodsSpecs">
                  <span class="x-red">*</span>商品规格
              </label>
            <div class="layui-input-inline">
                  <input type="text" id="goodsSpecs" name="goodsSpecs" required lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="goodsSave">
                  <span class="x-red">*</span>保质期
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsSave" name="goodsSave" required lay-verify="number|goodsSave"
                  autocomplete="off" placeholder="请输入商品保质期（天）" class="layui-input">
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
              <button  class="layui-btn" lay-filter="add" lay-submit="" name='goods-add'>
                  添加商品
              </button>
          </div>
      </form>
    </div>
    <script type="text/javascript" src="../js/form.js">></script>
  </body>

</html>