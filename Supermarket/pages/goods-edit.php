<?php
    include '../config/session.php';
?>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>商品编辑-超市管理系统</title>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <link rel="stylesheet" href="../css/public.css">

    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>
  </head>
  
  <body>
    <div class="x-body">
        <form class="layui-form" action="action-edit.php" method="post">
          <!-- 用户名显示模块 -->
          <!-- 获取用户名放value中 -->
          <div class="layui-form-item" style="color: red;">
              <label for="goodsID" class="layui-form-label">
                  <span class="x-red">*</span>商品ID
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsID" name="goodsID" disabled="" 
                  value="<?php $_SESSION['goodsID']= $_GET['0'];echo $_GET['0']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="goodsName" class="layui-form-label">
                  <span class="x-red">*</span>商品名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsName" name="goodsName" required
                  value="<?php echo $_GET['1']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="goodsType" class="layui-form-label">
                  <span class="x-red">*</span>商品分类 
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsType" name="goodsType" required
                  value="<?php echo $_GET['2']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="goodsPrice" class="layui-form-label">
                  <span class="x-red">*</span>零售价
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsPrice" name="goodsPrice" required lay-verify="number|goodsPrice"
                  value="<?php echo $_GET['3']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="goodsSpecs" class="layui-form-label">
                  <span class="x-red">*</span>规格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsSpecs" name="goodsSpecs" required
                  value="<?php echo $_GET['4']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="goodsSave" class="layui-form-label">
                  <span class="x-red">*</span>保质期
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsSave" name="goodsSave" required lay-verify="number|goodsSave"
                  value="<?php echo $_GET['5']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="note" class="layui-form-label">
                   备注
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="note" name="note"
                  value="<?php echo $_GET['6']?>" class="layui-input">
              </div>
          </div>
         
          <!-- 修改按钮 -->
          <div class="layui-form-item">
              <label for="goodsEdit" class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="save" lay-submit="" name ="goods-edit">
                  修改
              </button>
          </div>
      </form>
    </div>
        <script src="../js/form.js"></script>
  </body>

</html>