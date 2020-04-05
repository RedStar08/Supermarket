<?php
    include '../config/dbcon.php';
    
    //不同功能，不同查询语句
    if(isset($_POST['sales-search'])){
        //根据销售单号查询
        if($_POST["salesID"]!=""){
            $sql = "select * from sale where salesID='{$_POST['salesID']}'";
        //根据日期查询 
         }else{
            $sql ="select * from sale where salesDate >= '{$_POST['start']}' and salesDate <= '{$_POST['end']}';";
        }
    }else{
        $sql = "select * from sale";
    }
    $query = mysqli_query($con,$sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
    
    //搜索失败
    if($rows == NULL){
       echo "<script>alert('查询失败，符合条件的销售清单不存在');window.location.href='sale-list.php';</script>";  
    }else{
        //传给js
        $new_data = array();
        foreach ($rows as $row) {
            $tem_data = array();
            $tem_data['salesID'] = $row['salesID'];
            $tem_data['salesTotal'] = $row['salesTotal'];
            $tem_data['salesSum'] = $row['salesSum'];
            $tem_data['salesMoney'] = $row['salesMoney'];
            $tem_data['salesChange'] = $row['salesChange'];
            $tem_data['salesProfit'] = $row['salesProfit'];
            $tem_data['salesDate'] = $row['salesDate'];
            $tem_data['salesTime'] = $row['salesTime'];
            $tem_data['userID'] = $row['userID'];
            $tem_data['userName'] = $row['userName'];
            $tem_data['memberID'] = $row['memberID'];
            $tem_data['note'] = $row['note'];
            $new_data[]=$tem_data;
        }
    }
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>商品销售-超市管理系统</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>
  </head>
  
  <body class="layui-layout-body">
    <!-- 刷新 -->
    <div>
      <a class="layui-btn" style="margin-top:3px;float:right" 
      href="javascript:location.replace(location.href);">
        <i class="layui-icon layui-icon-refresh"></i>
      </a>
      <hr class="layui-bg-green">
    </div>
    <!-- 主体 -->
    <div class="layui-fluid">
      <!-- 查询 -->
      <div class="layui-row">
          <form class="layui-form layui-col-md12" style="text-align: center;" action="sale-list.php" method="post">
          <div class="layui-input-inline">
            <input class="layui-input" name="start" id="start" placeholder="开始日期">
          </div>
          <div class="layui-input-inline">
            <input class="layui-input" name="end" id="end" placeholder="截止日期">
          </div>
          <div class="layui-input-inline">
            <input class="layui-input" name="salesID"  placeholder="销售单号" >
          </div>
          <div class="layui-input-inline">
            <button class="layui-btn" name="sales-search" data-type="reload" id="sales-search"lay-submit lay-filter="sales-search">
            <i class="layui-icon layui-icon-search"></i>
          </button>
          </div>
        </form>
      </div>

      <!-- 自动渲染表格 -->
      <table id="sales-list" lay-filter="sales-list" lay-size="sm"></table>

      <!-- 表格操作栏 -->
      <script type="text/html" id="sales-detail">
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="sales-detail">
            <i class="layui-icon "></i>详细
        </button>
      </script>
      <!-- toolbar -->
      <script type="text/html" id="toolbar">
        <div class="layui-btn-container">
          <button class="layui-btn layui-btn-radius" lay-event="add-sales">
            <i class="layui-icon layui-icon-survey"></i>添加销售清单
          </button>
        </div>
      </script>
    </div>

<script type="text/javascript" src="../layui/layui.js"></script>
<script type="text/javascript" src="../js/form.js"></script>

<script>

// layui-use
layui.use(['table','form','laydate'], function(){
    var table = layui.table;
    var form = layui.form;
    var laydate = layui.laydate;

    //执行laydate实例
    laydate.render({
      elem: '#start' //指定元素
    });
    laydate.render({
      elem: '#end' //指定元素
    });

    // 表格数据接口 
    var sales_list = <?php echo json_encode($new_data);?>;
    
    //];

    //表格设置
    table.render({
      elem: '#sales-list'
      ,totalRow: true
      ,toolbar: '#toolbar'
      ,defaultToolbar: ['filter', 'exports', 'print', {
        title: '帮助'
        ,layEvent: 'LAYTABLE_TIPS'
        ,icon: 'layui-icon-tips'
      }]
      ,initSort: {
        field: 'salesDate' //排序字段，对应 cols 设定的各字段名
        ,type: 'desc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
      }
      //,width: 900
      //,height: 274
      ,cols: [[ //标题栏
        {field: 'salesID', title: '销售单号', sort: true, totalRowText: '合计:', width:130}
        ,{field: 'salesTotal', title: '总数', sort: true, totalRow: true, width:75}
        ,{field: 'salesSum', title: '应收款', sort: true, totalRow: true, width:90}
        ,{field: 'salesMoney', title: '实收款', sort: true, totalRow: true, width:90}
        ,{field: 'salesChange', title: '找零', sort: true, totalRow: true, width:90}
        ,{field: 'salesProfit', title: '利润', sort: true,width:90}
        ,{field: 'salesDate', title: '销售日期', sort: true, width:110}
        ,{field: 'salesTime', title: '销售时间', sort: true, width:110}
        ,{field: 'memberID', title: '会员', sort: true, width:80}
        ,{field: 'userID', title: '员工ID', sort: true, width:90}
        ,{field: 'userName', title: '经办人', width:90}
        ,{field: 'note', title: '备注', width:100}
        ,{fixed: 'right', title:'操作', toolbar: '#sales-detail'}
      ]]
      ,data: sales_list

      ,skin: 'row' //表格风格
      ,even: true
      // ,size: 'lg' //尺寸
      ,id: 'sales-table'
      ,page: { //详细参数可参考 laypage 组件文档
        layout: ['prev', 'page', 'next', 'count', 'limit', 'skip'] //自定义分页布局
      }
      ,limits: [6,10,20]
      ,limit: 6 //每页默认显示的数量
      //,loading: false //请求数据时，是否显示loading

    });
    //监听行工具事件
    table.on('tool(sales-list)', function(obj){
      var data = obj.data;
      // console.log(data);
      var id = data.salesID;;
      if(obj.event == 'sales-detail'){
        // 查看盘点详细
        x_admin_show('销售详细','sale-detail.php?salesID='+id,'1200','600');
      }

    });
    
    //监听工具栏事件
    table.on('toolbar(sales-list)', function(obj){
      // var checkStatus = table.salesStatus(obj.config.id);
      // console.log(obj);
      switch(obj.event){
        case 'add-sales':
          x_admin_show('添加销售','sale-goods.php','1300','600');
          // window.location.href = "sales-goods.html";
        break;
      };
    });
    

});

</script>

  </body>

</html>