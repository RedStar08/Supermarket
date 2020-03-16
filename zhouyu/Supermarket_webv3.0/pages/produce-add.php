<?php
    include '../config/dbcon.php';
    $sql_goods = "select goodsID,goodsName from tb_goods";
    $sql_sup = "select supplierID,supplierName from tb_supplier";
    
    $query_goods = mysqli_query($con,$sql_goods);
    $query_sup = mysqli_query($con, $sql_sup);
    
    $res_goods = mysqli_fetch_all($query_goods,MYSQLI_ASSOC);
    $res_sup = mysqli_fetch_all($query_sup,MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>仓库添加-超市后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <link rel="stylesheet" href="../layui/css/layui.css">

    <script type="text/javascript" src="../layui/layui.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>
  </head>
  
  <body>
    <div class="x-body">
        <form class="layui-form" action="action-add.php" method="post" style="margin:10% 0 0 25%">
          <div class="layui-form-item" style="width: 50%;">
              <label class="layui-form-label" for="goodsID">
                  <span class="x-red">*</span>商品ID
              </label>
              <div class="layui-input-block">
                <select name="goodsID" lay-verify="required" id="goodsID">
                  <option value="">请选择商品ID</option>
                  <?php foreach($res_goods as $res){?>
                  <option value="<?php echo $res['goodsID'];?>"><?php echo $res['goodsID']." ".$res['goodsName'];?></option>
                  <?php }?>
                </select>
              </div>
          </div>
          <div class="layui-form-item" style="width: 50%;">
              <label class="layui-form-label" for="supplierID">
                  <span class="x-red">*</span>供应商ID
              </label>
              <div class="layui-input-block">
                <select name="supplierID" lay-verify="required" id="supplierID">
                  <option value="">请选择供应商ID</option>
                    <?php foreach($res_sup as $res){?>
                  <option value="<?php echo $res['supplierID'];?>"><?php echo $res['supplierID']." ".$res['supplierName'];?></option>
                  <?php }?>
                </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="produceID">
                  <span class="x-red">*</span>生产批次
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="produceID" name="produceID" required lay-verify="number|produceID"
                  value="" class="layui-input">
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
              <button  class="layui-btn" lay-filter="add" lay-submit="" name="produce-add">
                  添加供应批次
              </button>
          </div>
      </form>
    </div>
    <script type="text/javascript" src="../js/xcity.js"></script>
    <script type="text/javascript" src="../js/form.js"></script>
    <script>
    </script>
  </body>

</html>