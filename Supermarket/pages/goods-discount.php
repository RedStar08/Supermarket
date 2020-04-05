<?php
    include '../config/dbcon.php';
    include '../config/session.php';
    
    //搜索功能
    if(isset($_POST['discount-search'])){
        include 'action-search.php';
        //echo "<script>window.location.href='goods-dis-search.php';</script>";
    }else{
        $sql_count = "select count(*) from `tb_discount`;";
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
    
        $sql = "select * from goods_discount limit {$amount},{$pagesize}";     
        $query = mysqli_query($con, $sql);
        $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);
    
        mysqli_free_result($query_count);
        mysqli_free_result($query);
        mysqli_close($con);
    }
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>商品折扣-超市管理系统</title>
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
        <a><cite>商品折扣清单</cite></a>
      </span>
      <a class="layui-btn layui-btn-primary layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新" >
        <i class="layui-icon" style="line-height:38px">&#xe669;</i></a>
    </div>
    <!-- 商品查询 -->
    <div class="x-body">
      <div class="layui-row" style="text-align: center;">
          <form class="layui-form layui-col-md12 x-so" action="goods-discount.php" method="post">
          <input class="layui-input" placeholder="开始日期" id="disStart" name="disStart">
          <input class="layui-input" placeholder="截止日期" id="disEnd" name="disEnd">
          <input class="layui-input" type="text" name="disgoodsID"  placeholder="请输入商品编号" autocomplete="off" >
          <button class="layui-btn"  lay-submit="" lay-filter="sreach" name = "discount-search">
            <i class="layui-icon">&#xe615;</i>
          </button>
        </form>
      </div>
      <xblock style="float: left;width: 100%;line-height:40px">
        <form id = "delAll" action = 'action-delete.php' method= "post">
          <input type="hidden" name="disgoodsIDSet" id ="disgoodsIDSet" >
          <input type="hidden" name="produceSet" id ="produceSet" >
          <input type="hidden" name="page" value="<?php echo $page; ?>">
          <input type="hidden" name="pagesize" value="<?php echo $pagesize; ?>">
          <button class="layui-btn layui-btn-danger" name='disgoodsSet-delete' onclick ='delAll()'
                  style="float: left;margin-right: 10px">
            <i class="iconfont">&#xe69d;</i>批量删除
          </button>
        </form>
        <span>
        <button class="layui-btn" onclick="x_admin_show('添加折扣商品','./goods-addDis.php',800,600)"
                style="float: left;">
          <i class="iconfont">&#xe6b9;</i>添加折扣商品
        </button>
        </span>
        <span style="float: right;line-height:40px">共有数据：<?php echo $recordcount ;?> 条</span>
      </xblock>
      <!-- 表格信息 -->
      <table class="layui-table" lay-even lay-skin="nob">
        <!-- 表头 -->
        <thead>
          <tr>
            <th>
              <div class="layui-unselect header layui-form-checkbox" lay-skin="primary">
                <i class="layui-icon">&#xe605;</i>
              </div>
            </th>
            <th style="font-size: 18px">商品ID</th>
            <th style="font-size: 18px">商品名称</th>
            <th style="font-size: 18px">商品分类</th>
            <th style="font-size: 18px">折扣价</th>
            <th style="font-size: 18px">原价</th>
            <th style="font-size: 18px">生产批号</th>
            <th style="font-size: 18px">起始日</th>
            <th style="font-size: 18px">截止日</th>
            <th style="font-size: 18px">过期日期</th>
            <th style="font-size: 18px">备注</th>
            <th style="font-size: 18px">操作</th>
          </tr>
        </thead>
        <!-- 表单条数据 -->
        <!-- 包含图标说明 -->
        
        <tbody>
          <?php foreach ($rows as $row){$str="";?>
          <tr>
            <td>
              <div class="layui-unselect layui-form-checkbox" lay-skin="primary"
              data-id="<?php echo htmlspecialchars($row['goodsID']);?>"
              produce-id="<?php echo htmlspecialchars($row['produceID']);?>">
                <i class="layui-icon">&#xe605;</i>
              </div>
            </td>
            <td><?php $str .= "&0=".$row['goodsID'];echo htmlspecialchars($row['goodsID']);?></td>
            <td><?php $str .= "&1=".$row['goodsName'];echo htmlspecialchars($row['goodsName']);?></td>
            <td><?php $str .= "&2=".$row['goodsType'];echo htmlspecialchars($row['goodsType']);?></td>
            <td><?php $str .= "&3=".$row['disPrice'];echo htmlspecialchars($row['disPrice']);?></td>
            <td><?php $str .= "&4=".$row['goodsPrice'];echo htmlspecialchars($row['goodsPrice']);?></td>
            <td><?php $str .= "&5=".$row['produceID'];echo htmlspecialchars($row['produceID']);?></td>
            <td><?php $str .= "&6=".$row['disStart'];echo htmlspecialchars($row['disStart']);?></td>
            <td><?php $str .= "&7=".$row['disEnd'];echo htmlspecialchars($row['disEnd']);?></td>
            <td><?php echo htmlspecialchars($row['expirationDate']);?></td>
            <td><?php $str .= "&8=".$row['note'];echo htmlspecialchars($row['note']);?></td>
            <!-- 商品操作 -->
            <td class="td-manage">
             <a title="编辑" class="layui-btn layui-btn-sm layui-btn-normal" href="javascript:;"
                 onclick="x_admin_show('编辑折扣商品','goods-editDis.php?<?php echo $str;?>',800,600)"
                 style="float: left;">
                编辑
              </a>
              <a style="float: left;margin-left: 8px;" href="avascript:;">
              <form action="action-delete.php" method="post">
                   <input type="hidden" name="pagesize" value="<?php echo $pagesize; ?>">
                   <input type="hidden" name="disgoodsID"  value="<?php echo $row['goodsID']; ?>">
                   <input type="hidden" name="produceID"  value="<?php echo $row['produceID']; ?>">
                   <input type="hidden" name="page"     value="<?php echo $page; ?>">
                   <button class="layui-btn layui-btn-sm layui-btn-danger" name="disgoods-delete">删除</button>
              </form>
              </a>
            </td>
          </tr>
        <?php }?>
        </tbody>
        
      </table>
      <!-- 表格信息结束  -->
      <!-- 翻页 -->
      <div id="dis-list" style="text-align: center;"></div>
      <!-- 页面管理结束 -->
    </div>
    <script>
      layui.use(['laypage','laydate'],function(){
      var laypage = layui.laypage;
      var laydate = layui.laydate;
      //执行一个laydate实例
        laydate.render({
          elem: '#disStart' //指定打折开始日期元素
        });

        //执行一个laydate实例
        laydate.render({
          elem: '#disEnd' //指定结束日期元素
        });
      //执行一个laypage实例
      //'count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip',
      laypage.render({
        elem: 'dis-list' //注意，这里的是 ID，不用加 # 号
        ,count: <?php echo $recordcount;?>  //数据总数，从服务端得到
        ,skin: 'row' //表格风格
        ,even: true
        ,size: 'lg' //尺寸
        ,page: true //是否显示分页
        ,limits: [6,10,20]
        ,curr:<?php echo $page;?>
        ,limit: <?php echo $pagesize;?> //每页默认显示的数量
        ,layout: ['prev', 'page', 'next', 'count', 'limit', 'skip']
        ,jump: function(obj,first){
                    //obj包含了当前分页的所有参数，比如：
                    // console.log(obj.curr);  //得到当前页，以便向服务端请求对应页的数据。
                    // console.log(obj.limit); //得到每页显示的条数
                    //首次不执行,使用原始的curr,后面需要自己通过回传来更新
                    if(!first){
                         location.href='goods-discount.php?&page='+obj.curr+'&pagesize='+obj.limit;
                    }
                }

      });


});
    function getProduce () {
          var obj = $(".layui-form-checked").not('.header');
          var arr=[];
          obj.each(function(index, el) {
              arr.push(obj.eq(index).attr('produce-id'));
          });
          return arr;
    }
      /*商品-删除*/
    function delAll(argument) {

        var idSet = tableCheck.getData();
        var produceSet = getProduce();

        if(idSet.length == 0){
            document.getElementById('delAll').action = "javascript:;";
            layer.msg('请勾选ID!',{icon: 5,time:1000});
            // console.log(idSet);
        }
        else {
          document.getElementById('delAll').action = "action-delete.php";
          document.getElementById('disgoodsIDSet').value=idSet;
          document.getElementById('produceSet').value=produceSet;
        }

    }

    </script>
  </body>

</html>