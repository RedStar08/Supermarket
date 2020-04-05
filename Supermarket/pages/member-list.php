<?php
    include '../config/dbcon.php';
    include '../config/session.php';
    
    $sql_count = "select count(*) from tb_member;";
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

    $sql = "select * from tb_member limit {$amount},{$pagesize};";
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
    <title>会员-超市管理系统</title>
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
        <a><cite>会员列表</cite></a>
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
          <input type="text" name="memberID"  placeholder="请输入会员编号" required lay-verify="number|memberID"
          autocomplete="off" class="layui-input">
          <input type="hidden" name="pagesize" value="<?php echo $pagesize; ?>">
          <button class="layui-btn"  lay-submit="" name ='member-search' lay-filter="sreach-member-id">
            <i class="layui-icon">&#xe615;</i>
          </button>
        </form>
      </div>
      <xblock style="float: left;width: 100%;line-height:40px">
          <form id = "delAll" action = 'action-delete.php' method= "post">
          <input type="hidden" name="memberIDSet" id ="memberIDSet" >
          <input type="hidden" name="page" value="<?php echo $page; ?>">
          <input type="hidden" name="pagesize" value="<?php echo $pagesize; ?>">
          <button class="layui-btn layui-btn-danger" name='memberSet-delete' onclick = 'delAll()'
                  style="float: left;margin-right: 10px">
            <i class="iconfont">&#xe69d;</i>批量删除
          </button>
        </form>
        <span>
        <button class="layui-btn" onclick="x_admin_show('添加会员','member-add.php',800,600)"
                style="float: left;">
          <i class="iconfont">&#xe6b9;</i>添加会员
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
            <th style="font-size: 18px">会员ID</th>
            <th style="font-size: 18px">姓名</th>
            <th style="font-size: 18px">性别</th>
            <th style="font-size: 18px">联系方式</th>
            <th style="font-size: 18px">累积消费金额</th>
            <th style="font-size: 18px">注册日期</th>
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
                   data-id= "<?php echo htmlspecialchars($row['memberID']);?>" >
                <i class="layui-icon">&#xe605;</i>
              </div>
            </td>
            <td><?php $str.="&0=".$row['memberID'];echo htmlspecialchars($row['memberID']);?></td>
            <td><?php $str.="&1=".$row['memberName'];echo htmlspecialchars($row['memberName']);?></td>
            <td><?php $str.="&2=".$row['memberSex'];echo htmlspecialchars($row['memberSex']);?></td>
            <td><?php $str.="&3=".$row['memberPhone'];echo htmlspecialchars($row['memberPhone']);?></td>
            <td><?php $str.="&4=".$row['totalSum'];echo htmlspecialchars($row['totalSum']);?></td>
            <td><?php $str.="&5=".$row['createDate'];echo htmlspecialchars($row['createDate']);?></td>
            <td><?php $str.="&6=".$row['note'];echo htmlspecialchars($row['note']);?></td>
            <!-- 商品操作 -->
            <td class="td-manage">
              <a title="编辑" class="layui-btn layui-btn-sm layui-btn-normal" href="javascript:;"
                 onclick="x_admin_show('编辑商品','member-edit.php?<?php echo $str;?>',800,600)"
                 style="float: left;">
                编辑
              </a>
              <a style="float: left;margin-left: 8px;" href="javascript:;">
              <form action="action-delete.php" method="post">
                   <input type="hidden" name="pagesize" value="<?php echo $pagesize; ?>">
                   <input type="hidden" name="memberID"  value="<?php echo $row['memberID']; ?>">
                   <input type="hidden" name="page"     value="<?php echo $page; ?>"> 
                   <button class="layui-btn layui-btn-sm layui-btn-danger" name="member-delete">删除</button>
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
    <div id="member-page" style="text-align: center;margin-top: -20px;"></div>
    <!-- 页面管理结束 -->
    <script type="text/javascript" src="../js/form.js"></script>
    <script>
layui.use('laypage', function(){
    var laypage = layui.laypage;
    //执行一个laypage实例
    //'count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip',
    laypage.render({
      elem: 'member-page' //注意，这里的是 ID，不用加 # 号
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
                      location.href='member-list.php?&page='+obj.curr+'&pagesize='+obj.limit;
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
          document.getElementById('memberIDSet').value=idSet;
        }

    }
    
    </script>
  </body>

</html>