<?php
    include '../config/session.php';
?>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>折扣商品编辑-超市管理系统</title>
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
          <div class="layui-form-item">
              <label class="layui-form-label" for="goodsID">
                  <span class="x-red">*商品ID</span>
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsID" name="disgoodsID" disabled="" 
                  value="<?php $_SESSION['disgoodsID']= $_GET['0'];echo $_GET['0']?>" class="layui-input">
              </div>
          </div>
           <div class="layui-form-item">
              <label class="layui-form-label" for="goodsName">
                  <span class="x-red">*商品名称</span>
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsID" name="goodsName" disabled="" 
                  value="<?php $_SESSION['goodsName']= $_GET['1'];echo $_GET['1']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="goodsType">
                  <span class="x-red">*商品分类</span>
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsID" name="goodsType" disabled="" 
                  value="<?php $_SESSION['goodsType']= $_GET['2']; echo $_GET['2']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="disPrice">
                  <span class="x-red">*</span>折扣价
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="disPrice" name="disPrice" required lay-verify="number|goodsPrice"
                  value="<?php echo $_GET['3']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="goodsPrice">
                  <span class="x-red">*原价</span>
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsID" name="goodsPrice" disabled="" 
                  value="<?php $_SESSION['goodsPrice']= $_GET['4']; echo $_GET['4']?>" class="layui-input">
              </div>
          </div>            
          <div class="layui-form-item">
              <label class="layui-form-label" for="goodsProduce">
                  <span class="x-red">*</span>生产批号
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="goodsProduce" name="goodsProduce" required lay-verify="number|goodsProduce"
                  value="<?php echo $_GET['5']?>" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="disStart">
                  <span class="x-red">*</span>促销起始
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input"  id="disStart" name="disStart" required lay-verify="date" 
                  value="<?php echo $_GET['6']?>" placeholder="开始日期" >
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label" for="disEnd">
                  <span class="x-red">*</span>促销截止
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input"  id="disEnd" name="disEnd" required lay-verify="date"
                  value="<?php echo $_GET['7']?>"  placeholder="截止日期" >
              </div>
          </div>         
          <div class="layui-form-item layui-form-text">
              <label class="layui-form-label" for="note">
                  备注
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="note" name="note" 
                  value="<?php echo $_GET['8']?>" autocomplete="off" class="layui-input">
              </div>
          </div>
          <!-- 修改按钮 -->            
          <div class="layui-form-item">
              <label for="goodsEdit" class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="save" lay-submit="" name="discount-edit">
                  修改
              </button>
          </div>
      </form>
    </div>
    <script src="../js/form.js"></script>
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
          
          //自定义验证规则
          form.verify({
            goodsID: function(value){
              if(value >= 100000){
                return '商品ID必须为6位数且在000000-099999之间';
              }
              if(value.length != 6){
                return '商品ID为6个字符';
              }
            }
            ,goodsPrice: function(value){
              if(value <= 0){
                return '商品价格必须大于0';
              }
            }
            ,goodsProduce: function(value){
                if(value <= 20191110){
                  return '商品生产批号过早';
              }
            }
          });


          
          
});
        </script>
  </body>

</html>