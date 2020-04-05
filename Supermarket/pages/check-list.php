<?php
    include '../config/dbcon.php';
    
    //不同功能，不同查询语句
    if(isset($_POST['check-search'])){
        //根据盘点单号查询
        if($_POST["checkID"]!=""){
            $sql = "select * from check_list  where checkID='{$_POST['checkID']}'";
        //根据日期查询 
         }else{
            $sql ="select * from check_list where checkTime >= '{$_POST['start']}' and checkTime <= '{$_POST['end']}';";
        }
    }else{
         $sql = "select * from check_list";
    }
    $query = mysqli_query($con,$sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
    
    //搜索失败
    if($rows == NULL){
       echo "<script>alert('查询失败，符合条件得入库单不存在');window.location.href='check-list.php';</script>";  
    }else{
        //传给js
        $new_data = array();
        foreach ($rows as $row) {
            $tem_data = array();
            $tem_data['checkID'] = $row['checkID'];
            $tem_data['stockTotal'] = $row['stockTotal'];
            $tem_data['checkTotal'] = $row['checkTotal'];
            $tem_data['checkTime'] = $row['checkTime'];
            $tem_data['userID'] = $row['userID'];
            $tem_data['userName'] = $row['userName'];
            $tem_data['userPhone'] = $row['userPhone'];
            $tem_data['note'] = $row['note'];
            $new_data[]=$tem_data;
        }
    }
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>库存盘点-超市管理系统</title>
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
          <form class="layui-form layui-col-md12" style="text-align: center;" action="check-list.php" method="post">
          <div class="layui-input-inline">
            <input class="layui-input" name="start" id="start" placeholder="开始日期">
          </div>
          <div class="layui-input-inline">
            <input class="layui-input" name="end" id="end" placeholder="截止日期">
          </div>
          <div class="layui-input-inline">
            <input class="layui-input" name="checkID"  placeholder="报表单号" >
          </div>
          <div class="layui-input-inline">
            <button class="layui-btn" name="check-search" data-type="reload" id="check-search"lay-submit lay-filter="check-search">
            <i class="layui-icon layui-icon-search"></i>
          </button>
          </div>
        </form>
      </div>

      <!-- 自动渲染表格 -->
      <table id="check-list" lay-filter="check-list"></table>

      <!-- 表格操作栏 -->
      <script type="text/html" id="check-detail">
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="check-detail">
            <i class="layui-icon "></i>盘点详细
        </button>
      </script>
      <!-- toolbar -->
      <script type="text/html" id="toolbar">
        <div class="layui-btn-container">
          <button class="layui-btn layui-btn-radius" lay-event="add-check">
            <i class="layui-icon layui-icon-survey"></i>添加报表单
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
    var check_list = <?php echo json_encode($new_data);?>;

    //表格设置
    table.render({
      elem: '#check-list'
      ,totalRow: true
      ,toolbar: '#toolbar'
      ,defaultToolbar: ['filter', 'exports', 'print', {
        title: '帮助'
        ,layEvent: 'LAYTABLE_TIPS'
        ,icon: 'layui-icon-tips'
      }]
      ,initSort: {
        field: 'inDate' //排序字段，对应 cols 设定的各字段名
        ,type: 'desc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
      }
      //,width: 900
      //,height: 274
      ,cols: [[ //标题栏
        {field: 'checkID', title: '报表单号', sort: true, totalRowText: '合计:'}
        ,{field: 'stockTotal', title: '库存总数', sort: true, totalRow: true}
        ,{field: 'checkTotal', title: '盘点总数', sort: true, totalRow: true}
        ,{field: 'checkTime', title: '盘点日期', sort: true}
        ,{field: 'userID', title: '员工ID', sort: true}
        ,{field: 'userName', title: '经办人'}
        ,{field: 'userPhone', title: '联系方式'}
        ,{field: 'note', title: '备注'}
        ,{fixed: 'right', title:'操作', toolbar: '#check-detail'}
      ]]
      ,data: check_list

      ,skin: 'row' //表格风格
      ,even: true
      // ,size: 'lg' //尺寸
      ,id: 'check-table'
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
    //监听行工具事件
    table.on('tool(check-list)', function(obj){
      var data = obj.data;
      // console.log(data);
      var id = data.checkID;
      var date = data.checkTime;
      if(obj.event == 'check-detail'){
        // 查看盘点详细
        x_admin_show('盘点详细','check-detail.php?checkID='+id+'&checkTime='+date,'1000','600');
      }

    });
    
    //监听工具栏事件
    table.on('toolbar(check-list)', function(obj){
      var checkStatus = table.checkStatus(obj.config.id);
      // console.log(obj);
      switch(obj.event){
        case 'add-check':
          x_admin_show('添加报表单','check-goods.php','1300','600');
          // window.location.href = "check-goods.html";
        break;
      };
    });
    

});

</script>

  </body>

</html>