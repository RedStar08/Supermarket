<?php
    //解决若有人直接打开index.php，从而获得信息
    include '../config/session.php';
    if(empty($_SESSION['uid'])){
        header('Location:login.php');
    }else{
        $un = $_SESSION['un'];
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>主页-超市管理系统</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Cache-Control" content="no-siteapp" >

    <link rel="shortcut icon" href="favicon.ico" type="../image/x-icon" >
    <link rel="stylesheet" href="../css/font.css">
	<link rel="stylesheet" href="../css/xadmin.css">
    <link rel="stylesheet" href="../css/public.css">
	<link rel="stylesheet" href="../layui/css/layui.css">

    <script src="../js/jquery.min.js"></script>
    <script src="../layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../js/xadmin.js"></script>

</head>
<body>
    <!-- 顶部开始 -->
    <div class="container">
        <!-- logo -->
        <div class="logo">
            <a href="index.php" style="color: #ffd705">
                <i class="iconfont">&#xe698;&nbsp;&nbsp;</i>
                超市管理系统
            </a>
        </div>
        <!-- 菜单 -->
        <div class="left_open">
            <i title="展开左侧栏" class="iconfont">&#xe699;</i>
        </div>
        <!-- 时间 -->
        <div class="publicTime">
            <i class="iconfont">&nbsp;&nbsp;&#xe6bf;&nbsp;&nbsp;</i>
            <span id="time">2020年02月02日 11:11  星期日</span>
            <!-- <span id="hours">欢迎你！</span> -->
        </div>    
        <!-- 右侧欢迎信息 -->
        <ul class="layui-nav right" lay-filter="">
          
          <!-- 时间问候 -->
          <li class="layui-nav-item to-index">
                <span id="hours">下午好！</span>
          </li>
          <li class="layui-nav-item to-index"><i class="iconfont">&nbsp;&nbsp;&nbsp;&#xe6af;</i></li>
           <!-- 用户信息 -->
          <li class="layui-nav-item">
            <a href="javascript:;" style="font-size:16px;color: gold;">
                <?php echo htmlspecialchars($un);?>
            </a>
            <dl class="layui-nav-child">
            <!-- 二级菜单 -->
            <!-- 弹出内嵌页面 -->
              <dd>
                <a onClick="x_admin_show('个人信息','user-info.php','800','600')">
                <i class="iconfont">&#xe6b8;</i>个人信息
                </a>
              </dd>
              <dd>
                <a onClick="x_admin_show('密码修改','user-password.php','800','600')">
                    <i class="iconfont">&#xe6ae;</i>密码修改
                </a>
              </dd>

              <dd><a href="login.php"><i class="iconfont">&#xe6aa;</i>账号切换</a></dd>
              <dd><a href="login.php"><i class="iconfont">&#xe69a;</i>退出登录</a></dd>
            </dl>
          </li>
          <li class="layui-nav-item to-index">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
          <li class="layui-nav-item to-index">欢迎您！</li>
          <li class="layui-nav-item to-index"><a href=""></a></li>
          <li class="layui-nav-item to-index"><a href="logout.php">退出系统</a></li>
        </ul>
        
    </div>
    <!-- 顶部结束 -->
    <!-- 中部开始 -->
     <!-- 左侧菜单开始 -->
    <div class="left-nav">
      <div id="side-nav">
        <ul id="nav">
            <li >
                <a href="javascript:;">
                    <i class="iconfont">&#xe696;</i>
                    <cite>主页</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="welcome.php">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>控制台</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <!-- 商品管理 -->
            <li >
                <a href="javascript:;">
                    <i class="iconfont">&#xe6b5;</i>
                    <cite>商品管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="goods-list.php">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>商品列表</cite>
                        </a>
                    </li >
                    <li>
                        <a _href="goods-info.php">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>销售商品列表</cite>
                        </a>
                    </li >
                    <li>
                        <a _href="goods-discount.php">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>折扣商品</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <!-- 账单管理 -->
            <li >
                <a href="javascript:;">
                    <i class="iconfont">&#xe74e;</i>
                    <cite>账单管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="sales-list.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>销售订单</cite>
                        </a>
                    </li >
                    <li>
                        <a _href="goods-list.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>盈亏状况</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <!-- 收银系统 -->
            <li >
                <a href="javascript:;">
                    <i class="iconfont">&#xe702;</i>
                    <cite>收银系统</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="goods-list.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>前台零售</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <!-- 供应商管理 -->
            <li >
                <a href="javascript:;">
                    <i class="iconfont">&#xe82a;</i>
                    <cite>供应商管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="supplier-list.php">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>供应商列表</cite>
                        </a>
                    </li >
                    <li>
                        <a _href="produce-list.php">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>供应批次</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <!-- 采购管理 -->
            <li >
                <a href="javascript:;">
                    <i class="iconfont">&#xe698;</i>
                    <cite>采购管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="goods-list.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>商品采购</cite>
                        </a>
                    </li >
                    <li>
                        <a _href="goods-list.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>采购记录</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <!-- 库存管理 -->
            <li >
                <a href="javascript:;">
                    <i class="iconfont">&#xe709;</i>
                    <cite>库存管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="store-list.php">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>仓库列表</cite>
                        </a>
                    </li >
                    <li><a _href="goods-list.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>库存状况</cite>
                        </a>
                    </li >
                    <li>
                        <a _href="goods-list.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>商品出库</cite>
                        </a>
                    </li >
                    <li><a _href="goods-list.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>商品入库</cite>
                         </a>
                    </li >
                    <li>
                        <a _href="goods-list.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>库存盘点</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <!-- 管理员管理 -->
            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe726;</i>
                    <cite>管理员管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="user-list.php">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>员工管理</cite>
                        </a>
                    </li >
                    <li>
                        <a _href="member-list.php">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>会员管理</cite>
                        </a>
                    </li >
                </ul>
            </li>   
            <!-- 系统设置 -->
            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe6ae;</i>
                    <cite>系统管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="user-password.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>密码管理</cite>  
                        </a>
                    </li >
                </ul>
            </li>
            <!-- 左侧列表结束 -->
        </ul>
      </div>
    </div>
    <!-- <div class="x-slide_left"></div> -->
    <!-- 左侧菜单结束 -->
    <!-- 右侧主体开始 -->
    <div class="page-content">
        <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
          <ul class="layui-tab-title">
            <li class="home"><i class="layui-icon">&#xe68e;</i>操作面板</li>
          </ul>
          <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='welcome.php' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
            </div>
          </div>
        </div>
    </div>
    <div class="page-content-bg"></div>
    <!-- 右侧主体结束 -->
    <!-- 中部结束 -->
    <!-- 底部开始 -->
    <div class="footer">
        <div class="copyright">Copyright ©2020 RedStar08 All Rights Reserved</div>  
    </div>
    <!-- 底部结束 -->
    <!-- 注意：显示当前时间的time.js连接必须放这里 -->
    <script type="text/javascript" src="../js/time.js"></script>
    <script src="../layui/layui.js"></script>
</body>
</html>