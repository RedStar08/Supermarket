<?php   
    include 'get-json.php';
    include 'get-store.php';
?>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>商品盘点-超市管理系统</title>
    <meta name="renderer" content="webkit">
    
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>

  </head>
  <style type="text/css">
    #stockNum,#checkNum {
      width: 110px;
    }
  </style>
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
          <input class="layui-input" name="checkID" placeholder="报表单号" lay-verify="checkID">
          <!-- 商品三级联动 -->
          <div class="layui-input-inline" id="tb_stock">
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
          <div class="layui-input-inline">
            <select name="storeID" lay-verify="required" lay-search>
              <option value="">仓库</option>
              <?php foreach($rows as $row){?>
              <option value="<?php echo $row['storeID'].$row['storeName'];?>"><?php echo $row['storeID'].$row['storeName'];?></option>
              <?php }?>
            </select>
          </div>
          <input class="layui-input" name="stockNum" placeholder="库存数量" disabled id="stockNum">
          <input class="layui-input" name="checkNum" placeholder="盘点数量" lay-verify="checkNum"id="checkNum">
          <input class="layui-input" name="note"  placeholder="备注">
          <button class="layui-btn layui-btn-small" lay-submit lay-filter="add">
            <i class="layui-icon layui-icon-add-circle">添加</i>
          </button>
        </form>  
      </div>

  	<!-- 自动渲染 -->
    <table id="check-goods-list" lay-filter="check-goods-list"></table>
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
        <button class="layui-btn layui-btn-radius" lay-event="checkAll">
          <i class="layui-icon layui-icon-survey"></i>批量盘点
        </button>
      </div>
    </script>
  </div>
  <!-- 商品三级联动 -->
<script type="text/javascript" src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="../js/produce.js"></script>
<script type="text/javascript" src="../js/form.js"></script>
<script type="text/javascript" charset="UTF-8">

  // 盘点商品信息数据
  var check_data = [];

  function deleteData(data){
    for (index in check_data) {
    // console.log(JSON.stringify(check_data[index]));
      if (JSON.stringify(check_data[index])==JSON.stringify(data)) {
        // console.log(index);
        check_data.splice(index, 1);
      }
    }
  }

  // layui-table
  layui.use(['table','form','code'], function(){
    var table = layui.table;
    form = layui.form;
    layui.code();
    // 选择对象
    var obj = $('#tb_stock');
    // 原始数据
    var stockData = <?php echo $stock_json;?>
    // 处理数据
    var goodsList = obj.getList(stockData);
    // 渲染效果
    obj.goodsProduce("","","",goodsList);

    //直接赋值数据
    table.render({
      elem: '#check-goods-list'
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
        ,{field: 'checkID', title: '报表单号', sort: true, width: 130, edit: 'text'}
        ,{field: 'goodsID', title: '商品', sort: true, width: 180}
        ,{field: 'supplierID', title: '供应商', sort: true, width: 180}
        ,{field: 'produceID', title: '生产批号', sort: true, width: 110}
        ,{field: 'storeID', title: '仓库', sort: true, width: 180}
        ,{field: 'stockNum', title: '库存数量', sort: true, width: 110, totalRow: true}
        ,{field: 'checkNum', title: '盘点数量', sort: true, width: 110, edit: 'text', totalRow: true}
        ,{field: 'note', title: '备注', edit: 'text'}
        ,{fixed: 'right', title:'操作', toolbar: '#delete'}
      ]]
      ,data: check_data

      ,skin: 'row' //表格风格
      ,even: true
      //,size: 'lg' //尺寸
      
      ,page: { //详细参数可参考 laypage 组件文档
        layout: ['prev', 'page', 'next', 'count', 'limit', 'skip'] //自定义分页布局
      }
      ,limits: [6,10,20]
      ,limit: 6 //每页默认显示的数量
      //,loading: false //请求数据时，是否显示loading
      ,done: function (res, curr, count) {
        $(".layui-table-total div").each(function (i,item) {
          var div_text = $(item).html();
          var value; //转换后的值
          if(div_text != "") {
            var value = parseInt(div_text);
            if(!isNaN(value)) {
              $(item).html(parseInt(div_text));
            }
          }
        });
      }

    });
    //监听行工具事件，删除单项表格
    table.on('tool(check-goods-list)', function(obj){
      var data = obj.data;
      // console.log(obj);
      if(obj.event == 'delete'){
        layer.confirm('确定删除该项吗？', function(index){
          obj.del();
          // console.log(obj.data);
          deleteData(obj.data);
          // console.log(check_data);
          layer.msg('已删除!',{icon:1,time:1000});
          updateTable();
          layer.close(index);
        });
      }

    });
    table.on('edit(check-goods-list)', function(obj){
      // console.log(obj);
      // console.log(obj.data); //得到所在行所有键值
      // var field = obj.field; //得到字段
      // var value = obj.value; //得到修改后的值
      var data = obj.data;
      // console.log(data);
      for (i in check_data) {
      // console.log(JSON.stringify(check_data[i]));
        var obj = check_data[i];
        if(data.goodsID == obj.goodsID) {
          // 商品相同
          // console.log(obj);
          if(data.supplierID == obj.supplierID) {
            // 供应商相同
            if(data.produceID == obj.produceID){
              if(data.storeID == obj.storeID){
                check_data[i].checkNum = data.checkNum;
                check_data[i].note = data.note;
                break;
              }
            }
          }
        }
      }
      updateTable();
    });
    //监听工具栏事件
    table.on('toolbar(check-goods-list)', function(obj){
      var checkStatus = table.checkStatus(obj.config.id);
      // console.log(obj);
      switch(obj.event){
        case 'deleteAll':
          var data = checkStatus.data;
          // console.log(check_data);
          layer.confirm('确定全部删除吗？', function(index){
            // console.log($(".layui-form-checked").parents('tbody tr'));
            $(".layui-form-checked").parents('tbody tr').remove();
            for(index in data){
              // console.log(data[index]);
              deleteData(data[index]);
            }
            // console.log(check_data);
            updateTable();
            layer.msg('删除成功!',{icon:1,time:1000});
            layer.close(index);
          });
        break;
        case 'checkAll':
          layer.confirm('确定提交报表单吗？', function(index){
            var dataSet = checkStatus.data;
            //显示获取的数据
            // layer.alert(JSON.stringify(dataSet));
            layer.close(index);
            if(dataSet.length == 0){
              document.getElementById('toolbar').action = "javascript:;";
              layer.msg('请添加盘点数据!',{icon: 5,time:1000});
              // console.log(dataSet);
            }
            else{
              // console.log(JSON.stringify(dataSet));
              $.ajax({
                url: "action-add.php",  
                type: "POST",
                data:{"check-data":JSON.stringify(dataSet)},
                error: function(msg){  
                    alert("报表提交失败！");  
                    // window.location.href='check-goods.php';
                },  
                success: function(data){//如果调用php成功            
                    alert(data);
                    // window.location.href='check-goods.php';
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
      
      check_data.push(data.field);
      updateTable();
      // console.log(check_data);
      return false; //阻止表单跳转。
    });
    //更新表格
    function updateTable(){
      table.reload('check-goods-list',{
        data: check_data
      });
    }
    form.on('select', function(){
      // {"goodsID":"000003","goodsName":"农夫山泉","supplierID":"300001","supplierName":"饮品供应商","produceID":"20191212","storeIDName":"400003新仓","stockNum":"1"}
      var data = form.val("goods-data");
      // console.log(data);
      for(i in stockData) {
        var obj = stockData[i];
        // console.log(obj);
        if(data.goodsID == (obj.goodsID+obj.goodsName)){
          // 商品相同
          // console.log(obj);
          if(data.supplierID == (obj.supplierID+obj.supplierName)){
            // 供应商相同
            if(data.produceID == obj.produceID){
              if(data.storeID == obj.storeIDName){
                // 仓库相同
                $('#stockNum').val(obj.stockNum);
                form.render();
              }
            }
          }

        }
      }
    });


});

</script>

  </body>
</html>