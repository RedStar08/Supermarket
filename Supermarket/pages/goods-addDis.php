<?php
    include '../config/dbcon.php';
    $sql_goods = "select goodsID,goodsName from tb_goods";
    $sql_sup = "select distinct(produceID) from tb_produce";
    
    $query_goods = mysqli_query($con,$sql_goods);
    $query_produce = mysqli_query($con, $sql_sup);
    
    $res_goods = mysqli_fetch_all($query_goods,MYSQLI_ASSOC);
    $res_produce = mysqli_fetch_all($query_produce,MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>折扣商品添加-超市后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <link rel="stylesheet" href="../css/public.css">
    <link rel="stylesheet" href="../layui/css/layui.css">

    <script type="text/javascript" src="../layui/layui.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>
  </head>
  
  <body>
    <div class="x-body" >
        <form class="layui-form" action="action-add.php" method="post" style="margin-top: 0%;">
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
          <div class="layui-form-item">
              <label class="layui-form-label" for="disPrice">
                  <span class="x-red">*</span>商品价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="disPrice" name="disPrice" required lay-verify="number|goodsPrice"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item" style="width: 50%;">
              <label class="layui-form-label" for="goodsProduce">
                  <span class="x-red">*</span>生产批号
              </label>
              <div class="layui-input-block">
                <select id="goodsProduce" name="goodsProduce" lay-verify="required">
                  <option value="">请选择生产批号</option>
                  <?php foreach($res_produce as $res){?>
                  <option value="<?php echo $res['produceID'];?>"><?php echo $res['produceID'];?></option>
                  <?php }?>
                </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="disStart">
                  <span class="x-red">*</span>促销起始
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input"  id="disStart" name="disStart" required lay-verify="date" 
                  autocomplete="off" placeholder="开始日期" >
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="disEnd">
                  <span class="x-red">*</span>促销截止
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input"  id="disEnd" name="disEnd" required lay-verify="date"
                  autocomplete="off" placeholder="截止日期"  position="static">
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
              <button  class="layui-btn" lay-filter="add" name ="discount-add" lay-submit>
                  添加商品
              </button>
          </div>
      </form>
    </div>
    <script type="text/javascript" src="../js/form.js"></script>
<script>
        layui.use(['form','layer','laydate'], function(){
          var form = layui.form
          ,layer = layui.layer
          ,laydate = layui.laydate;

          //执行一个laydate实例
          laydate.render({
            elem: '#disStart' //指定disStart
            ,min: '2019-11-11'
            ,max: '2020-11-11'
            ,done: function(value, date){
                      var start = new Date(value).getTime();
                      var end = new Date($('#disEnd').val()).getTime();
                      if (end < start) {
                          layer.msg('结束时间不能小于开始时间');
                          $('#disStart').val($('#disEnd').val());
                      }
                    }
          });

          //执行一个laydate实例
          laydate.render({
            elem: '#disEnd' //指定disEnd
            ,showBottom: false
            ,min: '2019-11-11'
            ,max: '2020-11-11'
            ,done: function(value, date){
                      var start = new Date($('#disStart').val()).getTime();
                      var end = new Date(value).getTime();
                      if (end < start) {
                          layer.msg('结束时间不能小于开始时间',{icon: 2});
                          $('#disEnd').val($('#disStart').val());
                      }
                    }
          });
          
          
});
    </script>
  </body>

</html>