<?php   
    include 'get-json.php';
?>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>商品采购-超市管理系统</title>
    <meta name="renderer" content="webkit">
    
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>

  </head>
  
  <body>
    <div class="x-nav">
      <a class="layui-btn" style="margin-top:3px;float:right" 
      href="javascript:location.replace(location.href);">
        <i class="layui-icon layui-icon-refresh"></i>
      </a>
    </div>
    <div class="x-body">
      <div class="layui-row" style="text-align: left;">
        <form class="layui-form layui-col-md12 x-so" lay-filter="goods-data">
          <input class="layui-input" name="buyID" placeholder="采购单号" lay-verify="buysID">
          <!-- 商品三级联动 -->
          <div class="layui-input-inline" id="tb_produce">
            <div class="layui-input-inline">
              <select name="goodsID" lay-filter="goods" lay-verify="required" lay-search>
                <option value="">商品</option>
              </select>
            </div>
            <div class="layui-input-inline">
              <select name="supplierID" lay-filter="supplier" lay-verify="required" lay-search>
                <option value="">供应商</option>
              </select>
            </div>
            <div class="layui-input-inline">
              <select name="produceID" lay-filter="produce" lay-verify="required" lay-search>
                <option value="">生产批号</option>
              </select>
            </div>
          </div>
          <input class="layui-input"name="buyPrice"id="buyPrice"placeholder="采购单价"lay-verify="goodsPrice">
          <input class="layui-input" name="buyNum" placeholder="采购数量" lay-verify="goodsNum">
          <input class="layui-input" name="note"  placeholder="备注">
          <button class="layui-btn layui-btn-small" lay-submit lay-filter="add">
            <i class="layui-icon layui-icon-add-circle">添加</i>
          </button>
        </form>  
      </div>

  	<!-- 自动渲染 -->
    <table id="buy-goods-list" lay-filter="buy-goods-list"></table>
    <!-- 操作栏 -->
    <script type="text/html" id="delete">
      <button class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">
          <i class="layui-icon layui-icon-delete"></i>删除
      </button>
    </script>
    <!-- toolbar -->
    <script type="text/html" id="toolbar">
      <div class="layui-btn-container">
        <button class="layui-btn layui-btn-danger" lay-event="deleteAll">
          <i class="layui-icon layui-icon-delete"></i>批量删除
        </button>
        <button class="layui-btn layui-btn-radius" lay-event="buyAll">
          <i class="layui-icon layui-icon-survey"></i>批量采购
        </button>
      </div>
    </script>
  </div>
  <!-- 商品三级联动 -->
<script type="text/javascript" src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="../js/produce.js"></script>
<script type="text/javascript" src="../js/form.js"></script>
<script type="text/javascript" charset="UTF-8">

  // 采购商品信息数据
  var buy_data = [];
  // 计算总价
  var buyTotal = 0;
  var buyAcount = 0.00;

  function deleteData(data){
    for (i in buy_data) {
    // console.log(JSON.stringify(buy_data[i]));
      if (JSON.stringify(buy_data[i])==JSON.stringify(data)) {
        // console.log(i);
        buy_data.splice(i, 1);
      }
    }
  }

  // layui-table
  layui.use(['table','form','code'], function(){
    var table = layui.table;
    form = layui.form;
    layui.code();
    // 选择对象
    var obj = $('#tb_produce');
    // 原始数据
    var produceData = <?php echo $produce_json;?>;
    // 处理数据
    var goodsList = obj.getList(produceData);
    // 渲染效果
    obj.goodsProduce("","","",goodsList);
    // 采购价格联动
    form.on('select(produce)', function(data){
      // console.log(data.elem); //得到select原始DOM对象
      // console.log(data.value); //得到被选中的值
      // console.log(data.othis); //得到美化后的DOM对象
      var produce_Data = <?php echo $produce_json;?>;
      var data = form.val("goods-data");
      // console.log(data);
      for(i in produce_Data){
        var obj = produce_Data[i];
        if(data.goodsID == (obj.goodsID + obj.goodsName)) {
          // 商品相同
          // console.log(obj);
          if(data.supplierID == (obj.supplierID + obj.supplierName) ) {
            // 供应商相同
            if(data.produceID == obj.produceID){
              $('#buyPrice').val(obj.buyPrice);
              // console.log(obj.buyPrice);
              form.render();
              break;
            }
          }
        }
      }

    });  
    

    //直接赋值数据
    table.render({
      elem: '#buy-goods-list'
      ,totalRow: true
      ,toolbar: '#toolbar'
      ,defaultToolbar: ['filter', 'exports', 'print', {
        title: '帮助'
        ,layEvent: 'LAYTABLE_TIPS'
        ,icon: 'layui-icon-tips'
      }]
      //,width: 900
      //,height: 274
      ,cols: [[ //标题栏
        {type: 'checkbox', LAY_CHECKED: true, totalRowText: '合计:'}
        ,{field: 'buyID', title: '采购单号', sort: true, width: 130, edit: 'text'}
        ,{field: 'goodsID', title: '商品', sort: true, width: 200}
        ,{field: 'supplierID', title: '供应商', sort: true, width: 200}
        ,{field: 'produceID', title: '生产批号', sort: true, width: 110}
        ,{field: 'buyPrice', title: '采购单价', edit: 'text', width: 110, sort: true,}
        ,{field: 'buyNum', title: '采购数量', sort: true, width: 110, edit: 'text'}
        ,{field: 'buyTips', title: '小计', sort: true}
        ,{field: 'note', title: '备注', edit: 'text'}
        ,{fixed: 'right', title:'操作', toolbar: '#delete'}
      ]]
      ,data: buy_data

      ,skin: 'row' //表格风格
      ,even: true
      //,size: 'lg' //尺寸
      
      ,page: { //详细参数可参考 laypage 组件文档
        layout: ['prev', 'page', 'next', 'count', 'limit', 'skip'] //自定义分页布局
      }
      ,limits: [6,10,20]
      ,limit: 6 //每页默认显示的数量
      //,loading: false //请求数据时，是否显示loading


    });
    //监听行工具事件，删除单项表格
    table.on('tool(buy-goods-list)', function(obj){
      var data = obj.data;
      // console.log(obj);
      if(obj.event == 'delete'){
        layer.confirm('确定删除该项吗？', function(index){
          obj.del();
          // console.log(obj.data);
          deleteData(obj.data);
          // console.log(buy_data);
          layer.msg('已删除!',{icon:1,time:1000});
          getCount();
          updateTable();
          layer.close(index);
        });
      }

    });
    
        //监听行工具事件，编辑单项表格
    table.on('edit(buy-goods-list)', function(obj){
      // console.log(obj);
      // console.log(obj.data); //得到所在行所有键值
      // var field = obj.field; //得到字段
      // var value = obj.value; //得到修改后的值
      var data = obj.data;
      // console.log(data);
      for (i in buy_data) {
      // console.log(JSON.stringify(buy_data[i]));
        var obj = buy_data[i];
        if(data.goodsID == obj.goodsID) {
          // 商品相同
          // console.log(obj);
          if(data.supplierID == obj.supplierID) {
            // 供应商相同
            if(data.produceID == obj.produceID){
              buy_data[i].buyNum = data.buyNum;
              buy_data[i].note = data.note;
              break;
            }
          }
        }
      }
      getCount();
      updateTable();
    });
    //监听工具栏事件
    table.on('toolbar(buy-goods-list)', function(obj){
      var checkStatus = table.checkStatus(obj.config.id);
      // console.log(obj);
      switch(obj.event){
        case 'deleteAll':
          var data = checkStatus.data;
          // console.log(buy_data);
          layer.confirm('确定全部删除吗？', function(index){
            $(".layui-form-checkd").parents('tbody tr').remove();
            for(i in data){
              // console.log(data[i]);
              deleteData(data[i]);
            }
            // console.log(buy_data);
            getCount();
            updateTable();
            layer.msg('删除成功!',{icon:1,time:1000});
            layer.close(index);
          });
          
        break;
        case 'buyAll':
          layer.confirm('确定提交采购单吗？', function(index){
            var dataSet = checkStatus.data;
            //显示获取的数据
            // layer.alert(JSON.stringify(dataSet));
            layer.close(index);
            if(dataSet.length == 0){
              document.getElementById('toolbar').action = "javascript:;";
              layer.msg('请添加采购数据!',{icon: 5,time:1000});
              // console.log(dataSet);
            }
            else{
              // console.log(JSON.stringify(dataSet));
              $.ajax({
                url: "action-add.php",  
                type: "POST",
                data:{"buy-data":JSON.stringify(dataSet)},
                error: function(msg){  
                    alert("采购清单提交失败！");  
                    // window.location.href='buy-goods.php';
                },  
                success: function(data){//如果调用php成功            
                    alert(data);
                    // window.location.href='buy-goods.php';
                }
              });
            }
          }); 
        break;
      };
    });
    // 添加行
    form.on('submit(add)', function(data){
      // console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
      // console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
      // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
      buy_data.push(data.field);
      // 统计总价
      getCount ();
      updateTable();
      return false; //阻止表单跳转。
    });
    //更新表格
    function updateTable(){
      table.reload('buy-goods-list',{
        data: buy_data
        ,cols: [[ //标题栏
          {type: 'checkbox', LAY_CHECKED: true, totalRowText: '合计:'}
          ,{field: 'buyID', title: '采购单号', sort: true, edit: 'text'}
          ,{field: 'goodsID', title: '商品', sort: true}
          ,{field: 'supplierID', title: '供应商', sort: true}
          ,{field: 'produceID', title: '生产批号', sort: true}
          ,{field: 'buyPrice', title: '采购单价', edit: 'text', sort: true,}
          ,{field: 'buyNum', title: '采购数量', sort: true, edit: 'text', totalRowText: buyTotal}
          ,{field: 'buyTips', title: '小计', sort: true, totalRowText: buyAcount.toFixed(2)}
          ,{field: 'note', title: '备注', edit: 'text'}
          ,{fixed: 'right', title:'操作', toolbar: '#delete'}
        ]]
      });
    }
    //求总价
    function getCount () {
      buyTotal = 0;
      buyAcount = 0.00;
      for(i in buy_data){
        var obj = buy_data[i];
        //计算价格
        buyPrice = parseFloat(obj.buyPrice);
        buyNum = parseInt(obj.buyNum);
        obj['buyTips'] = buyPrice*buyNum;
        buyTotal += buyNum;
        buyAcount += buyPrice*buyNum;
        // console.log(Math.round(buyAcount*100)/100);
        buyAcount = Math.round(buyAcount*100)/100;
      }
    }


});

</script>

  </body>
</html>