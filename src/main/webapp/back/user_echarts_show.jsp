<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<html lang="en">
<head>
    <script charset="utf-8" src="./kindeditor/lang/zh-CN.js"></script>
</head>
<body>

<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div id="main" style="width: 600px;height:400px;"></div>
<script>
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    var option = {
        title: {
            text: '用户上半年注册量'
        },
        tooltip: {},
        legend: {
            data:['男','女']
        },
        xAxis: {
            data: []
        },
        yAxis: {},
        series: []
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);

    $.ajax({
        url:"${pageContext.request.contextPath}/userMonthSex/findAll",
        tyep:"get",
        datatype:"JSON",
        success:function (data) {
            myChart.setOption({
                xAxis:{
                    data:data.month
                },
                series:[
                    {
                        name: '男',
                        type: 'line',
                        data: data.man
                    },
                    {
                        name: '女',
                        type: 'line',
                        data: data.woman
                    }]

            })
        }
    })

</script>

</body>
</html>