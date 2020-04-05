<?php
    include '../config/session.php';
    $address = explode('-', $_GET['4']);
?>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>供应商编辑-超市管理系统</title>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <link rel="stylesheet" href="../layui/css/layui.css">

    <script type="text/javascript" src="../layui/layui.js"></script>
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>
  </head>
  
  <body>
    <div class="x-body">
        <form class="layui-form" action="action-edit.php" method="post" style="margin-left: 20%">
          <!-- 用户名显示模块 -->
          <!-- 获取用户名放value中 -->
          <div class="layui-form-item" style="color: red;">
              <label for="goodsID" class="layui-form-label">
                  <span class="x-red">*</span>供应商ID
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="supplierID" name="supplierID" disabled="" 
                  value="<?php $_SESSION['supplierID']= $_GET['0'];echo $_GET['0']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="supplierName" class="layui-form-label">
                  <span class="x-red">*</span>供应商名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="supplierName" name="supplierName" required lay-verify="required"
                  value="<?php echo $_GET['1']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="supplierManager" class="layui-form-label">
                  <span class="x-red">*</span>负责人
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="supplierManager" name="supplierManager" required lay-verify="required"
                  value="<?php echo $_GET['2']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="supplierPhone" class="layui-form-label">
                  <span class="x-red">*</span>联系方式
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="supplierPhone" name="supplierPhone" required lay-verify="required"
                  value="<?php echo $_GET['3']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item" id="x-city"  style="width: 70%">
            <label class="layui-form-label" for="supplierPhone">
                  <span class="x-red">*</span>供货商地址
            </label>
            <div class="layui-input-inline" style="width: 20%">
              <select name="province" lay-filter="province" required lay-verify="required"> 
                <option value="">请选择省</option>
              </select>
            </div>
            <div class="layui-input-inline" style="width: 20%">
              <select name="city" lay-filter="city" required lay-verify="required">
                <option value="">请选择市</option>
              </select>
            </div>
            <div class="layui-input-inline" style="width: 20%">
              <select name="area" lay-filter="area" required lay-verify="required">
                <option value="">请选择县/区</option>
              </select>
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
              <label class="layui-form-label" for="road">
                  <span class="x-red">*</span>详细地址
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="road" name="road" required lay-verify="required"
                  value=""  class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="note" class="layui-form-label">
                   备注
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="note" name="note"
                  value="<?php echo $_GET['5']?>" class="layui-input">
              </div>
          </div>
         
          <!-- 修改按钮 -->
          <div class="layui-form-item">
              <label for="goodsEdit" class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="save" name="supplier-edit" lay-submit="">
                  修改
              </button>
          </div>
      </form>
    </div>
    <script type="text/javascript" src="../js/xcity.js"></script>
    <script type="text/javascript" src="../js/form.js"></script>
    <script>
      layui.use(['form','code'], function(){
        form = layui.form;

        layui.code();

        var province = "<?php echo $address[0];?>";
        var city = "<?php echo $address[1];?>";
        var area = "<?php echo $address[2];?>";
        var road = "<?php echo $address[3];?>";
        // console.log(province);
        $('#road').val(road);
        $('#x-city').xcity(province,city,area);

      });
    </script>
  </body>

</html>