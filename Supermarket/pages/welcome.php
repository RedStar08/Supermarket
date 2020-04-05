<?php
    include 'welcome-info.php'
    
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>欢迎-超市后台管理系统</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    
        <link rel="stylesheet" href="../css/font.css">
        <link rel="stylesheet" href="../css/xadmin.css">
        <link rel="stylesheet" href="../layui/css/layui.css">
    
        <script src="../js/jquery.min.js"></script>
        <script type="text/javascript" src="../layui/layui.js"></script>
        <script type="text/javascript" src="../js/xadmin.js"></script>
    </head>
<body>
<div class="x-body layui-anim layui-anim-up">
<!-- 系统通模块 -->
<fieldset class="layui-elem-field">
    <legend>系统通知</legend>
    <div class="layui-row">
        <div class="layui-col-md11">
            <div class="layui-field-box">
                <a class="x-a" >超市管理系统 Web version 3.0 正式上线......</a>
            </div>
        </div>
        <div class="layui-col-md1"  style="margin-bottom:12px;float:right">
          <a class="layui-btn" href="javascript:location.replace(location.href);">
            <i class="layui-icon layui-icon-refresh"></i>
          </a>
        </div>
        
    </div>
</fieldset>
<hr class="layui-bg-green">
<!-- 数据统计模块 -->
<!-- 刷新 -->

<fieldset class="layui-elem-field">
    <legend>数据统计</legend>
    <div class="layui-field-box">
      <div class="layui-col-md12">
        <div class="layui-card">
          <div class="layui-card-body">
            <div class="layui-carousel x-admin-carousel x-admin-backlog" lay-anim="" lay-indicator="inside" lay-arrow="none" style="width: 100%; height: 90px;">
                <div carousel-item="">
                   <ul class="layui-row layui-col-space10 layui-this">
                        <li class="layui-col-xs2">
                        <a  href="javascript:;" onclick="x_admin_show('商品','goods-list.php','1200','600')" class="x-admin-backlog-body">
                          <h3>商品</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[0][0]);?></cite></p>
                        </a>
                        </li>
                        <li class="layui-col-xs2">
                        <a  href="javascript:;" onclick="x_admin_show('商品','goods-discount.php','1200','600')" class="x-admin-backlog-body">
                          <h3>折扣商品</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[1][0]);?></cite></p>
                        </a>
                        </li>
                        <li class="layui-col-xs2">
                        <a href="javascript:;" onclick="x_admin_show('仓库','store-list.php','1200','600')" class="x-admin-backlog-body">
                          <h3>仓库</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[2][0]);?></cite></p>
                        </a>
                        </li>
                        <li class="layui-col-xs2">
                        <a href="javascript:;" onclick="x_admin_show('供应商','supplier-list.php','1200','600')" class="x-admin-backlog-body">
                          <h3>供应商</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[3][0]);?></cite></p>
                        </a>
                        </li>
                        <li class="layui-col-xs2">
                        <a href="javascript:;" onclick="x_admin_show('员工','user-list.php','1200','600')" class="x-admin-backlog-body">
                          <h3>员工</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[4][0]);?></cite></p>
                        </a>
                        </li>
                        <li class="layui-col-xs2">
                        <a href="javascript:;" onclick="x_admin_show('会员','member-list.php','1200','600')" class="x-admin-backlog-body">
                          <h3>会员</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[5][0]);?></cite></p>
                        </a>
                        </li>
                    </ul>
                </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="layui-field-box">
      <div class="layui-col-md12">
        <div class="layui-card">
          <div class="layui-card-body">
            <div class="layui-carousel x-admin-carousel x-admin-backlog" lay-anim="" lay-indicator="inside" lay-arrow="none" style="width: 100%; height: 90px;">
                <div carousel-item="">
                   <ul class="layui-row layui-col-space10 layui-this">
                        <li class="layui-col-xs2">
                        <a href="javascript:;" onclick="x_admin_show('库存状况','stock-status.php','1200','600')"class="x-admin-backlog-body">
                          <h3>库存总数</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[6][0]);?></cite></p>
                        </a>
                        </li>
                        <li class="layui-col-xs2">
                        <a href="javascript:;" class="x-admin-backlog-body">
                          <h3>今日利润</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[7][0]);?></cite></p>
                        </a>
                        </li>
                        <li class="layui-col-xs2">
                        <a href="javascript:;" class="x-admin-backlog-body">
                          <h3>今日销售额</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[8][0]);?></cite></p>
                        </a>
                        </li>
                        <li class="layui-col-xs2">
                        <a href="javascript:;" onclick="x_admin_show('销售订单','sale-list.php','1200','600')"class="x-admin-backlog-body">
                          <h3>利润总额</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[9][0]);?></cite></p>
                        </a>
                        </li>
                        <li class="layui-col-xs2">
                        <a href="javascript:;" onclick="x_admin_show('销售订单','sale-list.php','1200','600')"class="x-admin-backlog-body">
                          <h3>销售总额</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[10][0]);?></cite></p>
                        </a>
                        </li>
                        <li class="layui-col-xs2">
                        <a href="javascript:;" onclick="x_admin_show('采购订单','buy-list.php','1200','600')"class="x-admin-backlog-body">
                          <h3>采购总额</h3>
                          <p><cite><?php echo htmlspecialchars($res_array[11][0]);?></cite></p>
                        </a>
                        </li>
                    </ul>
                </div>
            </div>
          </div>
        </div>
      </div>
    </div>
</fieldset>
        <!-- 开发人员 -->
        <fieldset class="layui-elem-field">
            <legend>开发团队</legend>
            <div class="layui-field-box">
                <table class="layui-table">
                    <tbody>
                        <tr>
                            <th>开发者</th>
                            <td>
                                <pre>@小刘-前端      github@Redstar08</pre>
                                <pre>@小周-后端      github@zyzyzy520</pre>
                                <pre>@小林-数据库   github@ReunionJ</pre>
                            </td>
                        </tr>
                        <tr>
                            <th>开发语言</th>
                            <td>HTML + CSS + JavaScript + PHP + MySQL</td>
                        </tr>
                        <tr>
                            <th>开发环境：</th>
                            <td>XAMPP + Chrome</td>
                        </tr>
                        <tr>
                            <th>版本</th>
                            <td>Supermarket-Web 3.0</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
        <!-- 系统信息模块 -->
        <fieldset class="layui-elem-field">
            <legend>系统信息</legend>
            <div class="layui-field-box">
                <table class="layui-table">
                    <tbody>
                        <tr>
                            <th>操作系统</th>
                            <td>windows 10</td>
                        </tr>
                        <tr>
                            <th>运行环境</th>
                            <td>xampp-windows-x64-7.3.12-0-VC15</td>
                        </tr>
                        <tr>
                            <th>PHP版本</th>
                            <td>7.3.12</td>
                    </tbody>
                </table>
            </div>
        </fieldset>
        <hr class="layui-bg-green">
        <blockquote class="layui-elem-quote layui-quote-nm">
            感谢layui，百度Echarts，jquery，本系统由 @Redstar08 提供技术支持。
        </blockquote>
    </div>
</body>

</html>