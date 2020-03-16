<?php
    include '../config/dbcon.php';
    include '../config/session.php';
    if(isset($_POST['goodsinfo-search'])){
      include 'action-search.php';
    }
    else {
    $sql_count = "select count(*) from `tb_goodinfo`;";
    $query_count = mysqli_query($con, $sql_count);
    $count = mysqli_fetch_array($query_count);
    $recordcount = $count[0];
    if(empty($_GET['page'])){
        // 接收当前页，如果没有收到默认是第1页
        $page = 1;
        // 接收当最大显示，如果没有收到默认是6条
        $pagesize = 6;
    }
    else{
        // 接收当前页
        $page = $_GET['page'];
        // 接收当最大显示
        $pagesize = $_GET['pagesize'];
    }
    
    $amount=($page-1)*$pagesize;

    $sql = "select * from goods_info limit {$amount},{$pagesize};";
    $query = mysqli_query($con, $sql);
    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
    //释放链接，结果集
    mysqli_free_result($query_count);
    mysqli_free_result($query);
    mysqli_close($con);
    }
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>销售商品-超市管理系统</title>
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
        <a><cite>销售商品列表</cite></a>
      </span>
      <a class="layui-btn layui-btn-primary layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" 
      href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:1.6em;margin-top:3px;float:right">&#xe669;</i></a>
    </div>
    <!-- 商品查询 -->
    <div class="x-body">
      <div class="layui-row" style="text-align: center;margin: 0 auto;">
        <form class="layui-form layui-col-md12 x-so" action="goods-info.php" method="post">
          <input type="text" name="goodsID"  placeholder="请输入商品编号" required lay-verify="number|goodsID"
          autocomplete="off" class="layui-input">
          <input type="hidden" name="pagesize" value="<?php echo $pagesize; ?>">
          <button class="layui-btn"  lay-submit="" name ='goodsinfo-search' lay-filter="sreach-goods-id">
            <i class="layui-icon">&#xe615;</i>
          </button>
        </form>
      </div>
      <xblock style="float: left;width: 100%;line-height:40px">
        <span style="float: right;line-height:40px">共有数据：<?php echo $recordcount;?> 条</span>
      </xblock>
      <!-- 表格信息 -->
      <table class="layui-table" lay-filter="demo" lay-even lay-skin="nob">
        <!-- 表头 -->
        <thead>
          <tr>
            <th>商品ID</th>
            <th>名称</th>
            <th>分类</th>
            <th>零售价</th>
            <th>规格</th>
            <th>保质期</th>
            <th>供货商</th>
            <th>生产批号</th>
            <th>生产日期</th>
            <th>生产地址</th>
            <th>备注</th>
            <th>状态</th>
            <th>操作</th>
          </tr>
        </thead>
        <!-- 表单条数据 -->
        <!-- 包含图标说明 -->
        <tbody>
          <?php foreach ($rows as $row){ $str="";?>
          <tr>
            <td><?php $str .= "&0=".$row['goodsID'];echo htmlspecialchars($row['goodsID']);?></td>
            <td><?php $str .= "&1=".$row['goodsName'];echo htmlspecialchars($row['goodsName']);?></td>
            <td><?php $str .= "&2=".$row['goodsType'];echo htmlspecialchars($row['goodsType']);?></td>
            <td><?php $str .= "&3=".$row['goodsPrice'];echo htmlspecialchars($row['goodsPrice']);?></td>
            <td><?php $str .= "&4=".$row['goodsSpecs'];echo htmlspecialchars($row['goodsSpecs']);?></td>
            <td><?php $str .= "&5=".$row['goodsSave'];echo htmlspecialchars($row['goodsSave']);?></td>
            <td><?php $str .= "&5=".$row['supplierName'];echo htmlspecialchars($row['supplierName']);?></td>
            <td><?php $str .= "&5=".$row['produceID'];echo htmlspecialchars($row['produceID']);?></td>
            <td><?php $str .= "&5=".$row['produceDate'];echo htmlspecialchars($row['produceDate']);?></td>
            <td><?php $str .= "&5=".$row['produceArea'];echo htmlspecialchars($row['produceArea']);?></td>
            <td><?php $str .= "&6=".$row['note'];echo htmlspecialchars($row['note']);?></td>
            <!-- 商品操作 -->
            <td class="td-status">
              <span class="layui-btn layui-btn-normal layui-btn-sm">正上架</span></td>
            <td class="td-manage">
              <a title="上架" class="layui-btn layui-btn-sm layui-btn-primary" href="javascript:;"
                 onclick="goods_stop(this,'<?php echo htmlspecialchars($row['goodsID']);?>')"
                 style="float: left;">
                上下架
              </a>
            </td>
          </tr> 
          <?php }?>
        </tbody>
         
      </table>
      <!-- 表格信息结束  -->
    </div>
    <!-- 翻页 --> 
    <div id="goods-page" style="text-align: center;margin-top: -20px;"></div>
    <!-- 页面管理结束 -->
    <script type="text/javascript" src="../js/form.js"></script>
    <script>
layui.use('laypage', function(){
    var laypage = layui.laypage;
    //执行一个laypage实例
    //'count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip',
    laypage.render({
      elem: 'goods-page' //注意，这里的是 ID，不用加 # 号
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
                      location.href='goods-info.php?&page='+obj.curr+'&pagesize='+obj.limit;
                  }
              }

    });

});

     /*商品-下架*/
    function goods_stop(obj,id){
      if($(obj).attr('title')=='上架'){
        layer.confirm('确认要下架吗？',function(index){   
              //发异步把用户状态进行更改
              $(obj).attr('title','下架')
              $(obj).find('i').html('&#xe62f;');
              // 提示信息
              $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已下架');
              layer.msg('已下架!',{icon: 5,time:1000});  
        });
      }
      if($(obj).attr('title')=='下架'){
        layer.confirm('确认要上架吗？',function(index){
              //发异步把用户状态进行更改
              $(obj).attr('title','上架')
              $(obj).find('i').html('&#xe601;');

              $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('正上架');
              layer.msg('正上架!',{icon: 6,time:1000})            
        });
      }
    }
    /*商品-删除*/
    function delAll (argument) {

        var idSet = tableCheck.getData();

        if(idSet.length == 0){
            document.getElementById('delAll').action = "javascript:;";
            layer.msg('请勾选ID!',{icon: 5,time:1000});
            // console.log(idSet);
        }
        else {
          document.getElementById('delAll').action = "action-delete.php";
          document.getElementById('goodsIDSet').value=idSet;
        }

    }
    </script>
  </body>

</html>