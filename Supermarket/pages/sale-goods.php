<?php   
    include 'get-json.php';
    $sql = "select memberID,memberName from tb_member ";
    $query = mysqli_query($con, $sql);
    $members = mysqli_fetch_all($query,MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>商品销售-超市管理系统</title>
    <meta name="renderer" content="webkit">
    
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>

  </head>
  <style type="text/css">
    #salesPrice,#goodsPrice,#salesNum,#salesSum,#salesMoney {
      width: 80px;
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
          <input class="layui-input" name="salesID" placeholder="销售单号" lay-verify="salesID|required">
          <!-- 商品三级联动 -->
          <div class="layui-input-inline" id="tb_goodsInfo">
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
          <input class="layui-input" name="goodsPrice" placeholder="商品单价" disabled id="goodsPrice">
          <input class="layui-input" name="salesPrice" placeholder="销售单价" disabled id="salesPrice">
          <input class="layui-input" name="salesNum" placeholder="销售数量" id="salesNum" lay-verify="goodsNum|required">
          <input class="layui-input" name="note"  placeholder="备注">
          <button class="layui-btn layui-btn-small" lay-submit lay-filter="add">
            <i class="layui-icon layui-icon-add-circle">添加</i>
          </button>
        </form>  
      </div>
  	<!-- 自动渲染 -->
    <table id="sales-goods-list" lay-filter="sales-goods-list"></table>
    <!-- 操作栏 -->
    <script type="text/html" id="delete">
      <button class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">
          <i class="layui-icon layui-icon-delete"></i>删除
      </button>
    </script>
    <!-- toolbar -->
    <script type="text/html" id="toolbar">
      <div class="layui-input-inline">
        <div class="layui-input-inline">
            <button class="layui-btn layui-btn-danger" lay-event="deleteAll">
              <i class="layui-icon layui-icon-delete"></i>批量删除
            </button>
        </div>
        <div class="layui-input-inline">
          <form class="layui-form" lay-filter="sales-data"> 
            <span>应收款：</span>
            <div class="layui-input-inline">
              <input class="layui-input" name="salesSum" id="salesSum" disabled>
            </div>
            <span>实收款：</span>
            <div class="layui-input-inline">
              <input class="layui-input" name="salesMoney" id="salesMoney" lay-verify="required|salesMoney">
            </div>
            <div class="layui-input-inline">
              <select name="memberID" lay-verify="required" lay-search>
                    <option value="">会员</option>
                    <option value="非会员">非会员</option>
                    <?php foreach($members as $member){?>
                    <option value="<?php echo $member['memberID'];?>"><?php echo $member['memberID'].$member['memberName'];?></option>
                    <?php }?>
              </select>
            </div>
            <div class="layui-input-inline">
              <select name="salesNote" lay-verify="required">
                    <option value="">支付方式</option>
                    <option value="现金支付">现金支付</option>
                    <option value="电子支付">电子支付</option>
              </select>
            </div>
            <div class="layui-input-inline">
              <button class="layui-btn layui-btn-radius" lay-submit lay-filter="submit-sales">
                <i class="layui-icon layui-icon-survey"></i>提交订单
              </button>
            </div>
          </form>
        </div>
      </div>
    </script>
  </div>
  <!-- 商品三级联动 -->
<script type="text/javascript" src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="../js/produce.js"></script>
<script type="text/javascript" src="../js/form.js"></script>
<script type="text/javascript" charset="UTF-8">

  // 销售商品信息数据
  var sales_data = [];
  // 计算总价
  var salesTotal = 0;
  var salesAcount = 0.00;

  function deleteData(data){
    for (i in sales_data) {
    // console.log(JSON.stringify(sales_data[i]));
      if (JSON.stringify(sales_data[i])==JSON.stringify(data)) {
        // console.log(i);
        sales_data.splice(i, 1);
      }
    }
  }

  // layui-table
  layui.use(['table','form','code'], function(){
    var table = layui.table;
    form = layui.form;
    layui.code();
    // 选择对象
    var obj = $('#tb_goodsInfo');
    // 原始数据
    var goodsInfoData = <?php echo $goodsInfo_json; ?>;
    // 处理数据
    var goodsList = obj.getList(goodsInfoData);
    // 渲染效果
    obj.goodsProduce("","","",goodsList);

    //直接赋值数据
    table.render({
      elem: '#sales-goods-list'
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
        ,{field: 'salesID', title: '销售单号', sort: true, width: 130, edit: 'text'}
        ,{field: 'goodsID', title: '商品', sort: true, width: 180}
        ,{field: 'supplierID', title: '供应商', sort: true, width: 180}
        ,{field: 'produceID', title: '生产批号', sort: true, width: 110}
        ,{field: 'goodsPrice', title: '商品单价', sort: true, width: 110}
        ,{field: 'salesPrice', title: '销售单价', sort: true, width: 110}
        ,{field: 'salesNum', title: '销售数量', sort: true, width: 110, edit: 'text'}
        ,{field: 'salesTips', title: '小计', sort: true, width: 80}
        ,{field: 'note', title: '备注', width: 110, edit: 'text'}
        ,{fixed: 'right', title:'操作', toolbar: '#delete'}
      ]]
      ,data: sales_data

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
    //监听行工具事件，编辑单项表格
    table.on('edit(sales-goods-list)', function(obj){
      // console.log(obj);
      // console.log(obj.data); //得到所在行所有键值
      // var field = obj.field; //得到字段
      // var value = obj.value; //得到修改后的值
      var data = obj.data;
      // console.log(data);
      for (i in sales_data) {
      // console.log(JSON.stringify(sales_data[i]));
        var obj = sales_data[i];
        if(data.goodsID == obj.goodsID) {
          // 商品相同
          // console.log(obj);
          if(data.supplierID == obj.supplierID) {
            // 供应商相同
            if(data.produceID == obj.produceID){
              sales_data[i].salesNum = data.salesNum;
              sales_data[i].note = data.note;
              break;
            }
          }
        }
      }
      getCount();
      updateTable();
      $('#salesSum').val(salesAcount.toFixed(2));
      form.render(null, 'sales-data');

    });
    //监听行工具事件，删除单项表格
    table.on('tool(sales-goods-list)', function(obj){
      var data = obj.data;
      // console.log(obj);
      if(obj.event == 'delete'){
        layer.confirm('确定删除该项吗？', function(index){
          obj.del();
          // console.log(obj.data);
          deleteData(obj.data);
          // console.log(sales_data);
          layer.msg('已删除!',{icon:1,time:1000});
          getCount();
          updateTable();
          $('#salesSum').val(salesAcount.toFixed(2));
          form.render(null, 'sales-data');
          layer.close(index);
        });
      }

    });
    
    //监听工具栏事件
    table.on('toolbar(sales-goods-list)', function(obj){
      var checkStatus = table.checkStatus(obj.config.id);
      // console.log(obj);
      switch(obj.event){
        case 'deleteAll':
          var data = checkStatus.data;
          // console.log(sales_data);
          layer.confirm('确定全部删除吗？', function(index){
            $(".layui-form-checkd").parents('tbody tr').remove();
            for(i in data){
              // console.log(data[i]);
              deleteData(data[i]);
            }
            // console.log(sales_data);
            getCount();
            updateTable();
            $('#salesSum').val(salesAcount.toFixed(2));
            form.render(null, 'sales-data');
            layer.msg('删除成功!',{icon:1,time:1000});
            layer.close(index);
          });
          
        break;
      };
    });
    // 添加行
    form.on('submit(add)', function(data){
      // console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
      // console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
      // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
      sales_data.push(data.field);
      // 统计总价
      getCount();
      updateTable();
      // 应收款
      $('#salesSum').val(salesAcount.toFixed(2));
      form.render(null, 'sales-data');
      return false; //阻止表单跳转。
    });
    //更新表格
    function updateTable(){
      $('#salesSum').val(salesAcount.toFixed(2));
      table.reload('sales-goods-list',{
        data: sales_data
        ,cols: [[ //标题栏
          {type: 'checkbox', LAY_CHECKED: true, totalRowText: '合计:'}
          ,{field: 'salesID', title: '销售单号', sort: true, edit: 'text'}
          ,{field: 'goodsID', title: '商品', sort: true}
          ,{field: 'supplierID', title: '供应商', sort: true}
          ,{field: 'produceID', title: '生产批号', sort: true}
          ,{field: 'goodsPrice', title: '商品单价', sort: true,}
          ,{field: 'salesPrice', title: '销售单价', sort: true,}
          ,{field: 'salesNum', title: '销售数量', sort: true, edit: 'text', totalRowText: salesTotal}
          ,{field: 'salesTips', title: '小计', sort: true, totalRowText: salesAcount.toFixed(2)}
          ,{field: 'note', title: '备注', edit: 'text'}
          ,{fixed: 'right', title:'操作', toolbar: '#delete'}
        ]]
      });
    }
    //求总价
    function getCount () {
      salesTotal = 0;
      salesAcount = 0.00;
      for(i in sales_data){
        var obj = sales_data[i];
        //计算价格
        salesPrice = parseFloat(obj.salesPrice);
        salesNum = parseInt(obj.salesNum);
        obj['salesTips'] = salesPrice*salesNum;
        salesTotal += salesNum;
        salesAcount += salesPrice*salesNum;
        // console.log(Math.round(salesAcount*100)/100);
        salesAcount = Math.round(salesAcount*100)/100;
      }
    }
   var discount_json = <?php echo $discount_json; ?>;
    form.on('select', function(){
      // {"goodsID":"000003","goodsName":"农夫山泉","supplierID":"300001","supplierName":"饮品供应商","produceID":"20191212","storeIDName":"400003新仓","stockNum":"1"}
      var data = form.val("goods-data");
      // console.log(data);
      for(i in goodsInfoData) {
        var obj = goodsInfoData[i];
        // console.log(obj);
        if(data.goodsID == (obj.goodsID+obj.goodsName)){
          // 商品相同
          // console.log(obj);
          if(data.supplierID == (obj.supplierID+obj.supplierName)){
            // 供应商相同
            if(data.produceID == obj.produceID){
              $('#goodsPrice').val(obj.goodsPrice);
              form.render();
              break;
            }
          }
        }
      }
      var date = new Date("2019-12-20");
      // console.log(date);
      for(i in discount_json) {
        var obj = discount_json[i];
        // console.log(obj);
        if(data.goodsID.substring(0,6) == obj.goodsID){
          // console.log(data.goodsID.substring(0,6));
          // console.log(obj);
          // 商品相同
          if(data.produceID == obj.produceID){
            // 供应批次相同
            var start = new Date(obj.disStart);
            var end = new Date(obj.disEnd)
            if(date.getTime() > start.getTime() && date.getTime() < end.getTime()){
              // 打折范围内
              $('#salesPrice').val(obj.disPrice);
              form.render();
              break;
            }
          }
        }
        else {
          $('#salesPrice').val($('#goodsPrice').val());
        }
      }
    });
    //监听提交
    form.on('submit(submit-sales)', function(data){
      
      // console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
      // console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
      // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
      var checkStatus = table.checkStatus("sales-goods-list");
      var dataSet = checkStatus.data;
      // console.log(dataSet);
      getCount();
      var salesMoney = data.field.salesMoney;
      if(dataSet.length == 0){
        layer.msg('请添加销售数据!',{icon: 5,time:1000});
      }
      else if( salesMoney < salesAcount){
        layer.msg('收款金额不足!',{icon: 5,time:1000});
      }
      else {

        
        layer.confirm('确定提交销售单吗？', function(index){
          layer.close(index);
          // console.log(JSON.stringify(dataSet));
          getCount();
          var salesSum = salesAcount;
          var salesMoney = data.field.salesMoney;
          var memberID = data.field.memberID;
          var salesNote = data.field.salesNote;
          var salesID = sales_data[0].salesID;
          if(salesNote == "电子支付"){
            showImg();
          }
          $.ajax({
            url: "action-add.php?salesSum="+salesSum+"&salesMoney="+salesMoney+"&memberID="+memberID+"&salesNote="+salesNote,  
            type: "POST",
            data:{"sale-data":JSON.stringify(dataSet)},
            error: function(msg){  
                // alert(JSON.stringify(dataSet));
                alert("销售清单提交失败！");  
                // window.location.href='sale-goods.php';
            },  
            success: function(data){//如果调用php成功            
                if(salesNote == "电子支付"){
                  layer.confirm('电子支付到账？',{
                    title: "支付结果",
                    icon: 3,
                    btn: ['支付完成', '继续支付'] //按钮
                    }, function(index){
                      layer.closeAll();
                      x_admin_show('销售详细','sale-detail.php?salesID='+salesID,'1200','600');
                  });
                }
                alert(data);
                if(salesNote == "现金支付"){
                  x_admin_show('销售详细','sale-detail.php?salesID='+salesID,'1200','600');
                } 
            } 
          });
          
        });
      }

      return false; //阻止表单跳转。
    });
    function showImg(){
      var img = "<img src='../images/ReciveMoney.png' />";  
      layer.open({  
          type: 1,  
          shade: false,  
          title: '电子支付收款码', //不显示标题  
          area:['415px', '525px'],
          content: img, //捕获的元素，注意：最好该指定的元素要存放在body最外层，否则可能被其它的相对元素所影响  
          cancel: function () {  
              //layer.msg('图片查看结束！', { time: 5000, icon: 6 });  
          }  
      });  
    }

});

</script>

  </body>
</html>