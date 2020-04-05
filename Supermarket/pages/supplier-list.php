<?php
    include '../config/dbcon.php';
    include '../config/session.php';
    
    $sql_count = "select count(*) from tb_supplier;";
    $query_count = mysqli_query($con, $sql_count);
    $count = mysqli_fetch_array($query_count);
    $recordcount = $count[0];
    if(empty($_GET['page'])){
        // 接收当前页，如果没有收到默认是第1页
        $page = 1;
        // 接收当最大显示，如果没有收到默认是6条
        $pagesize = 5;
    }
    else{
        // 接收当前页
        $page = $_GET['page'];
        // 接收当最大显示
        $pagesize = $_GET['pagesize'];
    }
    
    $amount=($page-1)*$pagesize;

    $sql = "select * from tb_supplier limit {$amount},{$pagesize};";
    $query = mysqli_query($con, $sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
    //释放链接，结果集
    mysqli_free_result($query_count);
    mysqli_free_result($query);
    mysqli_close($con);
?> 
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>商品-超市管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <link rel="stylesheet" href="../layui/css/layui.css">

    <script src="../layui/layui.js"></script>
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>
  </head>
  
  <body class="layui-anim">
    <!-- 商品刷新 -->
    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a><cite>供货商列表</cite></a>
      </span>
      <a class="layui-btn layui-btn-primary layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" 
      href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:1.6em;margin-top:3px;float:right">&#xe669;</i>
      </a>
    </div>
    <!-- 商品查询 -->
    <div class="x-body">
      <div class="layui-row" style="text-align: center;margin: 0 auto;">
        <form class="layui-form layui-col-md12 x-so" action="action-search.php" method="post">
          <input type="text" name="supplierID"  placeholder="请输入供应商编号" required lay-verify="number|supplierID"
          autocomplete="off" class="layui-input">
          <input type="hidden" name="pagesize" value="<?php echo $pagesize; ?>">
          <button class="layui-btn"  lay-submit="" name ='supplier-search' lay-filter="sreach-supplier-id">
            <i class="layui-icon">&#xe615;</i>
          </button>
        </form>
      </div>
      <xblock style="float: left;width: 100%;line-height:40px">
          <form id = "delAll" action = 'action-delete.php' method= "post">
          <input type="hidden" name="supplierIDSet" id ="supplierIDSet" >
          <input type="hidden" name="page" value="<?php echo $page; ?>">
          <input type="hidden" name="pagesize" value="<?php echo $pagesize; ?>">
          <button class="layui-btn layui-btn-danger" name='supplierSet-delete' onclick = 'delAll()'
                  style="float: left;margin-right: 10px">
            <i class="iconfont">&#xe69d;</i>批量删除
          </button>
        </form>
        <span>
        <button class="layui-btn" onclick="x_admin_show('添加商品','supplier-add.php',800,600)"
                style="float: left;">
          <i class="iconfont">&#xe6b9;</i>添加供应商
        </button>
        </span>
        <span style="float: right;line-height:40px">共有数据：<?php echo $recordcount;?> 条</span>
      </xblock>
      <!-- 表格信息 -->
      <table class="layui-table" lay-filter="demo" lay-even lay-skin="nob">
        <!-- 表头 -->
        <thead>
          <tr>
            <th>
              <div class="layui-unselect header layui-form-checkbox" lay-skin="primary">
                <i class="layui-icon">&#xe605;</i>
              </div>
            </th>
            <th style="font-size: 18px">供应商ID</th>
            <th style="font-size: 18px">供应商名称</th>
            <th style="font-size: 18px">负责人</th>
            <th style="font-size: 18px">联系方式</th>
            <th style="font-size: 18px">地址</th>
            <th style="font-size: 18px">备注</th>
            <th style="font-size: 18px">操作</th>
          </tr>
        </thead>
        <!-- 表单条数据 -->
        <!-- 包含图标说明 -->
        
        <tbody>
          <?php foreach ($rows as $row){ $str="";?>
          <tr>
            <td>
              <div class="layui-unselect layui-form-checkbox" lay-skin="primary" 
                   data-id= "<?php echo htmlspecialchars($row['supplierID']);?>" >
                <i class="layui-icon">&#xe605;</i>
              </div>
            </td>
            <td><?php $str .= "&0=".$row['supplierID'];echo htmlspecialchars($row['supplierID']);?></td>
            <td><?php $str .= "&1=".$row['supplierName'];echo htmlspecialchars($row['supplierName']);?></td>
            <td><?php $str .= "&2=".$row['supplierManager'];echo htmlspecialchars($row['supplierManager']);?></td>
            <td><?php $str .= "&3=".$row['supplierPhone'];echo htmlspecialchars($row['supplierPhone']);?></td>
            <td><?php $str .= "&4=".$row['supplierAddress'];echo htmlspecialchars(str_replace('-', '', $row['supplierAddress']));?></td>
            <td><?php $str .= "&5=".$row['note'];echo htmlspecialchars($row['note']);?></td>
            <!-- 商品操作 -->
            <td class="td-manage">
              <a title="编辑" class="layui-btn layui-btn-sm layui-btn-normal" href="javascript:;"
                 onclick="x_admin_show('编辑商品','supplier-edit.php?<?php echo $str;?>',800,600)"
                 style="float: left;">
                编辑
              </a>
              <a style="float: left;margin-left: 8px;" href="avascript:;">
              <form action="action-delete.php" method="post">
                   <input type="hidden" name="pagesize" value="<?php echo $pagesize; ?>">
                   <input type="hidden" name="supplierID"  value="<?php echo $row['supplierID']; ?>">
                   <input type="hidden" name="page"     value="<?php echo $page; ?>"> 
                   <button class="layui-btn layui-btn-sm layui-btn-danger" name="supplier-delete">删除</button>
              </form>
              </a>
            </td>
          </tr> 
        <?php }?>
        </tbody>
         
      </table>
      <!-- 表格信息结束  -->
    </div>
    <!-- 翻页 --> 
    <div id="supplier-page" style="text-align: center;margin-top: -20px;"></div>
    <!-- 页面管理结束 -->
    <script type="text/javascript" src="../js/form.js"></script>
    <script>
layui.use('laypage', function(){
    var laypage = layui.laypage;
    //执行一个laypage实例
    //'count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip',
    laypage.render({
      elem: 'supplier-page' //注意，这里的是 ID，不用加 # 号
      ,count: <?php echo $recordcount;?> //数据总数，从服务端得到
      ,skin: 'row' //表格风格
      ,even: true
      ,size: 'lg' //尺寸
      ,page: true //是否显示分页
      ,limits: [5,10,20]
      ,curr:<?php echo $page;?>
      ,limit: <?php echo $pagesize;?> //每页默认显示的数量
      ,layout: ['prev', 'page', 'next', 'count', 'limit', 'skip']
      ,jump: function(obj,first){
                  //obj包含了当前分页的所有参数，比如：
                  // console.log(obj.curr);  //得到当前页，以便向服务端请求对应页的数据。
                  // console.log(obj.limit); //得到每页显示的条数
                  //首次不执行,使用原始的curr,后面需要自己通过回传来更新
                  if(!first){
                      location.href='supplier-list.php?&page='+obj.curr+'&pagesize='+obj.limit;
                  }
              }

    });

});
    /*商品-删除*/
    function delAll (argument) {

        var idSet = tableCheck.getData();

        if(idSet.length == 0){
            document.getElementById('delAll').action = "javascript:;";
            layer.msg('请勾选ID!',{icon: 5,time:1000});
            console.log(idSet);
        }
        else {
          document.getElementById('delAll').action = "action-delete.php";
          document.getElementById('supplierIDSet').value=idSet;
        }

    }
    
    </script>
  </body>

</html>