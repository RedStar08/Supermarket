<?php
    include'../config/dbcon.php';
    if(isset($_GET['checkID'])){
        //查询详情
        $sql = "select * from checks where checkID = '{$_GET['checkID']}'";
        $query = mysqli_query($con,$sql);
        $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
        
        //商品数
        $sql = "select count(distinct goodsIDName) from checks where checkID='{$_GET['checkID']}';";
        $query = mysqli_query($con, $sql);
        $nums = mysqli_fetch_array($query)[0];
        
        //查看详情失败
        if($rows == NULL){
            echo "<script>alert('查看详情失败!请检查数据库');window.location.href='check-list.php';</script>";  
        }else{
            //传给js
            $new_data = array();
            foreach ($rows as $row) {
                $tem_data = array();
                $tem_data['goodsID'] = $row['goodsIDName'];
                $tem_data['supplierID'] = $row['supplierIDName'];
                $tem_data['produceID'] = $row['produceID'];
                $tem_data['storeID'] = $row['storeIDName'];
                $tem_data['stockNum'] = $row['stockNum'];
                $tem_data['checkNum'] = $row['checkNum'];
                $tem_data['note'] = $row['note'];
                $new_data[]=$tem_data;
            }
        }
    }
 
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>盘点详细-商品盘点</title>
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
      <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
          <legend>报表单号：<?php echo $_GET['checkID'];?></legend>
          <legend>日期：<?php echo $_GET['checkTime'];?></legend>
      </fieldset>
      <!-- 自动渲染表格 -->
      <table id="check-list" lay-filter="check-list"></table>
    </div>

<script type="text/javascript" src="../layui/layui.js"></script>

<script>

  // layui-use
  layui.use(['table'], function(){
    var table = layui.table;
    
    // 表格数据接口 
    var check_detail =<?php echo json_encode($new_data);?>;

    //表格设置
    table.render({
      elem: '#check-list'
      ,totalRow: true
      ,defaultToolbar: ['filter', 'exports', 'print', {
        title: '帮助'
        ,layEvent: 'LAYTABLE_TIPS'
        ,icon: 'layui-icon-tips'
      }]
      //,width: 900
      //,height: 274
      ,cols: [[ //标题栏
        {field: 'goodsID', title: '商品', sort: true,width:180, totalRowText: '合计:<?php echo $nums;?>'}
        ,{field: 'supplierID', sort: true,width:180, title: '供应商'}
        ,{field: 'produceID', title: '生产批号', sort: true,width:110}
        ,{field: 'storeID', title: '仓库', sort: true, width:150}
        ,{field: 'stockNum', title: '库存数量', sort: true, width:110, totalRow: true}
        ,{field: 'checkNum', title: '盘点数量', sort: true, width:110, totalRow: true}
        ,{field: 'note', title: '备注'}
      ]]
      ,data: check_detail

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
  

});

</script>

  </body>

</html>