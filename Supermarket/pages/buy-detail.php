<?php
    include'../config/dbcon.php';
    if(isset($_GET['buyID'])){
        //查询详情
        $sql = "select * from buys where buyID = '{$_GET['buyID']}'";
        $query = mysqli_query($con,$sql);
        $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
        
        //商品数
        $sql = "select count(distinct goodsIDName) from buys where buyID='{$_GET['buyID']}';";
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
                $tem_data['buyPrice'] = $row['buyPrice'];
                $tem_data['buyNum'] = $row['buyNum'];
                $tem_data['buyTips'] = $row['buyTips'];
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
    <title>采购详细-商品采购</title>
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
          <legend>采购单号：<?php echo $_GET['buyID'];?></legend>
          <legend>日期：<?php echo $_GET['buyTime'];?></legend>
      </fieldset>
      <!-- 自动渲染表格 -->
      <table id="buy-list" lay-filter="buy-list"></table>
    </div>

<script type="text/javascript" src="../layui/layui.js"></script>

<script>

  // layui-use
  layui.use(['table'], function(){
    var table = layui.table;
    
    // 表格数据接口 
    var buy_detail = <?php echo json_encode($new_data);?>;

    //表格设置
    table.render({
      elem: '#buy-list'
      ,totalRow: true
      ,defaultToolbar: ['filter', 'exports', 'print', {
        title: '帮助'
        ,layEvent: 'LAYTABLE_TIPS'
        ,icon: 'layui-icon-tips'
      }]
      //,width: 900
      //,height: 274
      ,cols: [[ //标题栏
        {field: 'goodsID', title: '商品',width:200, sort: true, totalRowText: '合计:<?php echo $nums;?>'}
        ,{field: 'supplierID', sort: true,width:200, title: '供应商'}
        ,{field: 'produceID', title: '生产批号', sort: true}
        ,{field: 'buyPrice', title: '采购单价', sort: true}
        ,{field: 'buyNum', title: '采购数量', sort: true, totalRow: true}
        ,{field: 'buyTips', title: '小计', sort: true, totalRow: true}
        ,{field: 'note', title: '备注'}
      ]]
      ,data: buy_detail

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
  

});

</script>

  </body>

</html>