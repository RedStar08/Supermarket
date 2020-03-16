<?php
    include '../config/session.php';
    $address = explode('-', $_GET['6']);
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
          <div class="layui-form-item">
              <label class="layui-form-label" for="storeID">
                  <span class="x-red">*仓库ID</span>
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="storeID" name="storeID" disabled="" 
                  value="<?php $_SESSION['storeID']= $_GET['0'];echo $_GET['0']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="storeName">
                  <span class="x-red">*</span>仓库名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="storeName" name="storeName" required lay-verify="required"
                  value="<?php echo $_GET['1']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="storeNum">
                  <span class="x-red">*</span>已用容量
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="storeNum" name="storeNum" required lay-verify="storeNum|required"
                  value="<?php echo $_GET['2']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="storeMax">
                  <span class="x-red">*</span>仓库容量
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="storeMax" name="storeMax" required lay-verify="storeMax|required"
                  value="<?php echo $_GET['3']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="storeManager">
                  <span class="x-red">*</span>负责人ID
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="storeManager" name="storeManager" required lay-verify="userID|required"
                  value="<?php echo $_GET['4']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="storePhone">
                  <span class="x-red">*</span>联系方式
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="storePhone" name="storePhone" required lay-verify="required|phone"
                  value="<?php echo $_GET['5']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item" id="x-city"  style="width: 70%">
            <label class="layui-form-label">
                  <span class="x-red">*</span>仓库地址
            </label>
            <div class="layui-input-inline" style="width: 20%">
              <select id="province" name="province" lay-filter="province" required lay-verify="required"> 
                <option value="">请选择省</option>
              </select>
            </div>
            <div class="layui-input-inline" style="width: 20%">
              <select id="city" name="city" lay-filter="city" required lay-verify="required">
                <option value="">请选择市</option>
              </select>
            </div>
            <div class="layui-input-inline" style="width: 20%">
              <select id="area" name="area" lay-filter="area" required lay-verify="required">
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
          <div class="layui-form-item layui-form-text">
              <label class="layui-form-label" for="note">
                  备注
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="note" name="note" value="<?php echo $_GET['7']?>" class="layui-input">
              </div>
          </div>
         
          <!-- 修改按钮 -->
          <div class="layui-form-item">
              <label for="goodsEdit" class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="save" name="store-edit" lay-submit="">
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
        // 选中的值
        var province = "<?php echo $address[0];?>";
        var city = "<?php echo $address[1];?>";
        var area = "<?php echo $address[2];?>";
        var road = "<?php echo $address[3];?>";

        $('#road').val(road);
        $('#x-city').xcity(province,city,area);


});
    </script>
  </body>

</html>