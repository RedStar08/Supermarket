<?php
    include '../config/dbcon.php';
    
    //不同功能，不同查询语句
    if(isset($_POST['buy-search'])){
        //根据采购单号查询
        if($_POST["buyID"]!=""){
            $sql = "select * from buy where buyID='{$_POST['buyID']}'";
        //根据日期查询 
         }else{
            $sql ="select * from buy where buyDate >= '{$_POST['start']}' and buyDate  <= '{$_POST['end']}';";
        }
    }else{
         $sql = "select * from buy";
    }
    $query = mysqli_query($con,$sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
    
    //搜索失败
    if($rows == NULL){
       echo "<script>alert('查询失败，符合条件得采购单不存在');window.location.href='buy-list.php';</script>";  
    }else{
        //传给js
        $new_data = array();
        foreach ($rows as $row) {
            $tem_data = array();
            $tem_data['buyID'] = $row['buyID'];
            $tem_data['buyTotal'] = $row['buyTotal'];
            $tem_data['buyAcount'] = $row['buyAcount'];
            $tem_data['buyDate'] = $row['buyDate'];
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
    <title>商品采购-超市管理系统</title>
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
          <form class="layui-form layui-col-md12" style="text-align: center;" action="buy-list.php" method="post">
          <div class="layui-input-inline">
            <input class="layui-input" name="start" id="start" placeholder="开始日期">
          </div>
          <div class="layui-input-inline">
            <input class="layui-input" name="end" id="end" placeholder="截止日期">
          </div>
          <div class="layui-input-inline">
            <input class="layui-input" name="buyID"  placeholder="采购单号" lay-verify="buyID">
          </div>
          <div class="layui-input-inline">
            <button class="layui-btn" name="buy-search" data-type="reload" id="buy-search"lay-submit lay-filter="buy-search">
            <i class="layui-icon layui-icon-search"></i>
          </button>
          </div>
        </form>
      </div>

      <!-- 自动渲染表格 -->
      <table id="buy-list" lay-filter="buy-list"></table>

      <!-- 表格操作栏 -->
      <script type="text/html" id="buy-detail">
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="buy-detail">
            <i class="layui-icon "></i>采购详细
        </button>
      </script>
      <!-- toolbar -->
      <script type="text/html" id="toolbar">
        <div class="layui-btn-container">
          <button class="layui-btn layui-btn-radius" lay-event="add-buy">
            <i class="layui-icon layui-icon-survey"></i>添加采购清单
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
    var buy_list = <?php echo json_encode($new_data);?>;//[
      //{"buyID":"202003300001","buyTotal":"100","buyAcount":"123.56","buyDate":"2020-03-30","userID":"100000","userName":"小刘","userPhone":"10086","note":"数量准确"}
      //,{"buyID":"202003300001","buyTotal":"100","buyAcount":"123.56","buyDate":"2020-03-30","userID":"100000","userName":"小刘","userPhone":"10086","note":"数量准确"}
      //,{"buyID":"202003300001","buyTotal":"100","buyAcount":"123.56","buyDate":"2020-03-30","userID":"100000","userName":"小刘","userPhone":"10086","note":"数量准确"}
    //];

    //表格设置
    table.render({
      elem: '#buy-list'
      ,totalRow: true
      ,toolbar: '#toolbar'
      ,defaultToolbar: ['filter', 'exports', 'print', {
        title: '帮助'
        ,layEvent: 'LAYTABLE_TIPS'
        ,icon: 'layui-icon-tips'
      }]
      ,initSort: {
        field: 'buyDate' //排序字段，对应 cols 设定的各字段名
        ,type: 'desc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
      }
      //,width: 900
      //,height: 274
      ,cols: [[ //标题栏
        {field: 'buyID', title: '采购单号', sort: true, totalRowText: '合计:'}
        ,{field: 'buyTotal', title: '采购总数', sort: true, totalRow: true}
        ,{field: 'buyAcount', title: '采购总价', sort: true, totalRow: true}
        ,{field: 'buyDate', title: '采购日期', sort: true}
        ,{field: 'userID', title: '员工ID', sort: true}
        ,{field: 'userName', title: '经办人'}
        ,{field: 'userPhone', title: '联系方式'}
        ,{field: 'note', title: '备注'}
        ,{fixed: 'right', title:'操作', toolbar: '#buy-detail'}
      ]]
      ,data: buy_list

      ,skin: 'row' //表格风格
      ,even: true
      // ,size: 'lg' //尺寸
      ,id: 'buy-table'
      ,page: { //详细参数可参考 laypage 组件文档
        layout: ['prev', 'page', 'next', 'count', 'limit', 'skip'] //自定义分页布局
      }
      ,limits: [6,10,20]
      ,limit: 6 //每页默认显示的数量
      //,loading: false //请求数据时，是否显示loading

    });
    //监听行工具事件
    table.on('tool(buy-list)', function(obj){
      var data = obj.data;
      // console.log(data);
      var id = data.buyID;
      var date = data.buyDate;
      if(obj.event == 'buy-detail'){
        // 查看盘点详细
        x_admin_show('采购详细','buy-detail.php?buyID='+id+'&buyTime='+date,'1000','600');
      }

    });
    
    //监听工具栏事件
    table.on('toolbar(buy-list)', function(obj){
      // var checkStatus = table.buyStatus(obj.config.id);
      // console.log(obj);
      switch(obj.event){
        case 'add-buy':
          x_admin_show('添加采购','buy-goods.php','1300','600');
          // window.location.href = "buy-goods.html";
        break;
      };
    });
    

});

</script>

  </body>

</html>