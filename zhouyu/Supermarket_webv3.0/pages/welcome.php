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

        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
        <link rel="stylesheet" href="../css/font.css">
        <link rel="stylesheet" href="../css/xadmin.css">
    </head>
<body>
    <div class="x-body layui-anim layui-anim-up">
        <!-- 系统通模块 -->
        <fieldset class="layui-elem-field">
            <legend>系统通知</legend>
            <div class="layui-field-box">
                <table class="layui-table" lay-skin="line">
                    <tbody>
                        <tr>
                            <td >
                                <a class="x-a" >超市管理系统 Web 3.0 上线ing......</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
        <!-- 数据统计模块 -->
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
                                            <a href="goods-list.php" class="x-admin-backlog-body">
                                                <h3>商品数</h3>
                                                <p><cite><?php echo htmlspecialchars($res_array[0][0]);?></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs2">
                                            <a href="store-list.php" class="x-admin-backlog-body">
                                                <h3>仓库</h3>
                                                <p><cite><?php echo htmlspecialchars($res_array[1][0]);?></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs2">
                                            <a href="supplier-list.php" class="x-admin-backlog-body">
                                                <h3>供应商</h3>
                                                <p><cite><?php echo htmlspecialchars($res_array[2][0]);?></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs2">
                                            <a href="user-list.php" class="x-admin-backlog-body">
                                                <h3>员工</h3>
                                                <p><cite><?php echo htmlspecialchars($res_array[3][0]);?></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs2">
                                            <a href="javascript:;" class="x-admin-backlog-body">
                                                <h3>今日销售额</h3>
                                                <p><cite><?php echo htmlspecialchars($res_array[4][0]);?></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs2">
                                            <a href="javascript:;" class="x-admin-backlog-body">
                                                <h3>总销售额</h3>
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
                                <p>@小刘-前端&nbsp;&nbsp;&nbsp;github@Redstar08<br></p>
                                <p>@小周-后端&nbsp;&nbsp;&nbsp;github@zyzyzy520<br></p>
                                @小林-数据库<br>
                            </td>
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
        
        <blockquote class="layui-elem-quote layui-quote-nm">
            感谢layui，百度Echarts，jquery，本系统由 @Redstar08 提供技术支持。
        </blockquote>
    </div>
</body>

</html>