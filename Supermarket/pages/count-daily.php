<?php  
    include 'get-json.php';
    include 'welcome-info.php';
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>系统统计-超市管理系统</title>

    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
</head>
<body>
    <div class="layui-fluid">
        <!-- 刷新 -->
        <div>
            <h1 style="text-align: center;">盈亏状况统计</h1>
          <a class="layui-btn" style="margin-top:3px;float:right" 
          href="javascript:location.replace(location.href);">
            <i class="layui-icon layui-icon-refresh"></i>
          </a>
          <hr class="layui-bg-green">
        </div>
        <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
        <!-- 销售额-利润 -->
        <div class="layui-fluid">
            <div id="daily" style="width: 50%;height:350px;float: left;"></div>
            <div id="total" style="width: 50%;height:350px;float: left;"></div>
            <hr class="layui-bg-green">
        </div>
        <!-- 商品销量-销售额 -->
        <div class="layui-fluid">
            <div id="goods" style="width: 100%;height:1000px;"></div>
            <hr class="layui-bg-green">
        </div>
        <!-- 销售额-利润-采购 -->
        <div class="layui-fluid" style="text-align: 0 auto;">
            <div id="percent" style="width: 60%;height:400px;margin-left: 20%;"></div>
        </div>
        
    </div>
<script src="../js/echarts/echarts.min.js"></script>
<script src="../js/echarts/ecStat.min.js"></script>
<script src="../js/echarts/dataTool.min.js"></script>
<script src="../js/echarts/china.js"></script>
<script src="../js/echarts/world.js"></script>
<script type="text/javascript">
    var daily_count_data = <?php echo $daily_count_json; ?>;
    
    // 日期
    var salesDate = [];
    // 日销售额-日利润
    var dailySum = [];
    var dailyProfit = [];
    // 总销售额-总利润
    var salesSum = [];
    var salesProfit = [];
    var sum = 0.00;
    var profit = 0.00;

    // 数据处理
    for(i in daily_count_data){
        var count = daily_count_data[i];
        salesDate.push(count.salesDate);

        dailySum.push(count.salesSum);
        dailyProfit.push(count.salesProfit);

        sum += parseFloat(count.salesSum);
        profit += parseFloat(count.salesProfit);
        //强制处理四舍五入并保留2位小数
        Math.round(sum*100)/100;
        Math.round(profit*100)/100;
        salesSum.push(sum.toFixed(2));
        salesProfit.push(profit.toFixed(2));
    }
    // console.log(salesDate);
    // console.log(dailySum);
    // console.log(dailyProfit);
    // console.log(salesSum);
    // console.log(salesProfit);


    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('daily'));
    // 指定图表的配置项和数据
    var option = {
        title: {
            text: '每日-销售额-利润-统计'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data:['日销售额','日利润']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            }
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: salesDate
        },
        yAxis: {
            type: 'value'
        },
        series: [
            {
                name:'日销售额',
                type:'line',
                // stack: '总量',
                data: dailySum
            },
            {
                name:'日利润',
                type:'line',
                // stack: '总量',
                data: dailyProfit
            }
        ]
    };

    // 基于准备好的dom，初始化echarts实例
    var myChart1 = echarts.init(document.getElementById('total'));
    var option1 = {
        title: {
            text: '总销售额-利润-统计'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data:['总销售额', '总利润']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            }
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: salesDate
        },
        yAxis: {
            type: 'value'
        },
        series: [
            {
                name:'总销售额',
                type:'line',
                // stack: '总量',
                data: salesSum
            },
            {
                name:'总利润',
                type:'line',
                // stack: '总量',
                data: salesProfit
            }
        ]
    };

        // 基于准备好的dom，初始化echarts实例
        var myChart2 = echarts.init(document.getElementById('percent'));
        var daily_buy = <?php echo htmlspecialchars($res_array[12][0]);?>;
        var daily_sales = <?php echo htmlspecialchars($res_array[8][0]);?>;
        var daily_profits = <?php echo htmlspecialchars($res_array[7][0]);?>;
        var sum_buy = <?php echo htmlspecialchars($res_array[11][0]);?>;
        var sum_sales = <?php echo htmlspecialchars($res_array[10][0]);?>;
        var sum_profits = <?php echo htmlspecialchars($res_array[9][0]);?>;
        // 指定图表的配置项和数据
        var option2 = {
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b}: {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                left: 10,
                data: ['采购总额', '销售总额', '利润总额']
            },
            series: [
                {
                    name: '每日-盈亏状况-统计',
                    type: 'pie',
                    selectedMode: 'single',
                    radius: [0, '30%'],

                    label: {
                        position: 'inner'
                    },
                    labelLine: {
                        show: false
                    },
                data: [
                    {value: daily_buy.toFixed(2), name:'今日采购'},
                    {value: daily_sales.toFixed(2), name:'今日销售',selected: true},
                    {value: daily_profits.toFixed(2), name:'今日利润'}
                ]
                },
                {
                    name: '盈亏状况-统计',
                    type: 'pie',
                    radius: ['40%', '55%'],
                    label: {
                        formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
                        backgroundColor: '#eee',
                        borderColor: '#aaa',
                        borderWidth: 1,
                        borderRadius: 4,
                        shadowBlur:3,
                        shadowOffsetX: 2,
                        shadowOffsetY: 2,
                        shadowColor: '#999',
                        padding: [0, 7],
                        rich: {
                            a: {
                                color: '#999',
                                lineHeight: 22,
                                align: 'center'
                            },
                            // abg: {
                            //     backgroundColor: '#333',
                            //     width: '100%',
                            //     align: 'right',
                            //     height: 22,
                            //     borderRadius: [4, 4, 0, 0]
                            // },
                            hr: {
                                borderColor: '#aaa',
                                width: '100%',
                                borderWidth: 0.5,
                                height: 0
                            },
                            b: {
                                fontSize: 16,
                                lineHeight: 33
                            },
                            per: {
                                color: '#eee',
                                backgroundColor: '#334455',
                                padding: [2, 4],
                                borderRadius: 2
                            }
                        }
                    },
                    data: [
                        {value: sum_buy.toFixed(2), name: '采购总额'},
                        {value: sum_sales.toFixed(2), name: '销售总额'},
                        {value: sum_profits.toFixed(2), name: '利润总额'}
                    ]
                }
            ]
        };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    myChart1.setOption(option1);
    myChart2.setOption(option2);
</script>
<script type="text/javascript">
    var sales_count_data = <?php echo $sales_count_json; ?>;

    // 柱状图
    var all = 0;
    var sum = 0.00;
    var goods = {};
    var price= {};

    var all_max = 0;
    var sum_max = 0.00;

    // 饼状图
    var goodsSumJson = {};
    var goodsTipsJson = {};

    for(i in sales_count_data){
        var data = sales_count_data[i];
        all += parseInt(data.salesNum);
        sum += parseFloat(data.salesTips);

        if(all_max < data.salesNum){
            all_max = data.salesNum;
        }
        if(parseFloat(sum_max) < parseFloat(data.salesTips)) {
            sum_max = data.salesTips;
        }

        var id = data.goodsIDName;
        goods[id] = parseInt(data.salesNum);
        goodsSumJson[id] = parseInt(data.salesNum);

        var money = parseFloat(data.salesTips);
        Math.round(money*100)/100;
        price[id] = money.toFixed(2);
        goodsTipsJson[id] = money.toFixed(2);
    }
    Math.round(sum*100)/100;
    sum.toFixed(2);
    // console.log(goodsSumJson);
    // console.log(goodsTipsJson);
    // console.log(goods);
    // console.log(price);
    
    var dom = document.getElementById("goods");
    var myChart = echarts.init(dom);
    var app = {};
    option = null;
    var goodsJson = {};

    goodsJson["all"] = all;
    goodsJson["sum"] = sum;
    goodsJson["goods"] = goods;
    goodsJson["price"] = price;

    option = {
        tooltip: {},
        title: [{
            text: '销售数量',
            subtext: '总计 ' + goodsJson.all,
            left: '25%',
            textAlign: 'center'
        }, {
            text: '销售总额',
            subtext: '总计 ' + goodsJson.sum.toFixed(2),
            left: '25%',
            top: '50%',
            textAlign: 'center'
        }, {
            text: '销售数量-百分比',
            subtext: '总计 ' + goodsJson.all,
            left: '75%',
            textAlign: 'center'
        }, {
            text: '销售额-百分比',
            subtext: '总计 ' + goodsJson.sum.toFixed(2),
            left: '75%',
            top: '50%',
            textAlign: 'center'
        }],
        grid: [{
            top: 50,
            width: '50%',
            bottom: '50%',
            left: 10,
            containLabel: true
        }, {
            top: '55%',
            width: '50%',
            bottom: 50,
            left: 10,
            containLabel: true
        }],
        xAxis: [{
            type: 'value',
            max: all_max * 1.2,
            splitLine: {
                show: false
            }
        }, {
            type: 'value',
            max: sum_max * 1.2,
            gridIndex: 1,
            splitLine: {
                show: false
            }
        }],
        yAxis: [{
            type: 'category',
            data: Object.keys(goodsJson.goods),
            axisLabel: {
                interval: 0,
                rotate: 30
            },
            splitLine: {
                show: false
            }
        }, {
            gridIndex: 1,
            type: 'category',
            data: Object.keys(goodsJson.price),
            axisLabel: {
                interval: 0,
                rotate: 30
            },
            splitLine: {
                show: false
            }
        }],
        series: [{
            type: 'bar',
            stack: 'chart',
            z: 3,
            label: {
                normal: {
                    position: 'right',
                    show: true
                }
            },
            data: Object.keys(goodsJson.goods).map(function (key) {
                return goodsJson.goods[key];
            })
        }, {
            type: 'bar',
            stack: 'chart',
            silent: true,
            itemStyle: {
                normal: {
                    color: '#eee'
                }
            },
            data: Object.keys(goodsJson.goods).map(function (key) {
                return goodsJson.all - goodsJson.goods[key];
            })
        }, {
            type: 'bar',
            stack: 'component',
            xAxisIndex: 1,
            yAxisIndex: 1,
            z: 3,
            label: {
                normal: {
                    position: 'right',
                    show: true
                }
            },
            data: Object.keys(goodsJson.price).map(function (key) {
                return goodsJson.price[key];
            })
        }, {
            type: 'bar',
            stack: 'component',
            silent: true,
            xAxisIndex: 1,
            yAxisIndex: 1,
            itemStyle: {
                normal: {
                    color: '#eee'
                }
            },
            data: Object.keys(goodsJson.price).map(function (key) {
                return goodsJson.sum - goodsJson.price[key];
            })
        }, {
            type: 'pie',
            radius: [0, '30%'],
            center: ['75%', '25%'],
            data: Object.keys(goodsSumJson).map(function (key) {
                return {
                    name: key.replace('.js', ''),
                    value: goodsSumJson[key]
                }
            })
        }, {
            type: 'pie',
            radius: [0, '30%'],
            center: ['75%', '75%'],
            data: Object.keys(goodsTipsJson).map(function (key) {
                return {
                    name: key.replace('.js', ''),
                    value: goodsTipsJson[key]
                };
            })
        }]
    };;
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }
</script>
    </body>

</html>