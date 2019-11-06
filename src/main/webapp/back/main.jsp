<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"></c:set>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>持明佛州登录页面</title>
    <link rel="stylesheet" href="${app}/back/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${app}/back/jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
    <script type="text/javascript" src="${app}/back/boot/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${app}/back/assets/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${app}/back/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <script type="text/javascript" src="${app}/back/jqgrid/js/trirand/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="${app}/back/jqgrid/js/ajaxfileupload.js"></script>
    <script charset="utf-8" src="${app}/back/kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="${app}/back/kindeditor/lang/zh-CN.js"></script>
    <script type="text/javascript" src="${app}/back/echarts/echarts.min.js"></script>
    <style>
        .ui-jqgrid .ui-jqgrid-htable .ui-th-div {
        height: 20px;
        margin-top: 5px;
        }
        .ui-jqgrid .ui-jqgrid-title {
            font-weight: bold;
            font-size: large;
        }
        th{text-align:center}
    </style>

</head>
<body>
<!-- 容器-->

    <!-- 导航条-->
    <nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!-- 标头-->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
            </button>
            <a class="navbar-brand" href="#">持明法洲后台管理系统</a>
        </div>
        <!-- 标尾-->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎:${sessionScope.admin.nickname}</a></li>
                <li><a href="${app}/admin/exit">安全退出</a></li>
            </ul>
        </div>
    </div>
    </nav>
    <!-- 内容-->
<div class="container-fluid" >
    <!--左侧-->
    <div class="col-sm-2 " style="padding:0px" >
        <div class="panel-group" id="accordion" role="tablist">
            <div class="panel panel-default">
                <div class="panel-heading" role="tab">
                    <h4 class="panel-title">
                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" >
                            <p class="text-center">轮播图管理</p>
                        </a>
                    </h4>
                </div>
                <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" >
                    <div class="panel-body" align="center">
                        <a class="btn btn-default" href="javascript:$('#centerLayout').load('${app}/back/banner_show.jsp')" role="button">所有轮播图</a>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" >
                    <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" >
                            <p class="text-center">专辑管理</p>
                        </a>
                    </h4>
                </div>
                <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" >
                    <div class="panel-body" align="center">
                        <a class="btn btn-default" href="javascript:$('#centerLayout').load('${app}/back/album_show.jsp')" role="button">所有专辑</a>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" >
                    <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" >
                            <p class="text-center">文章管理</p>
                        </a>
                    </h4>
                </div>
                <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" >
                    <div class="panel-body" align="center">
                        <a class="btn btn-default" href="javascript:$('#centerLayout').load('${app}/back/article_show.jsp')" role="button">所有文章</a>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="用户">
                    <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" >
                            <p class="text-center">用户管理</p>
                        </a>
                    </h4>
                </div>
                <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" >
                    <div class="panel-body" align="center">
                        <a class="btn btn-default" href="javascript:$('#centerLayout').load('${app}/back/user_show.jsp')" role="button">所有用户</a>
                        <br>
                        <a class="btn btn-default" href="javascript:$('#centerLayout').load('${app}/back/user_echarts_show.jsp')" role="button">所有用户</a>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" >
                    <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" >
                            <p class="text-center">明星管理</p>
                        </a>
                    </h4>
                </div>
                <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" >
                    <div class="panel-body" align="center">
                        <a class="btn btn-default" href="javascript:$('#centerLayout').load('${app}/back/star_show.jsp')" role="button">所有专辑</a>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!--右侧-->
    <div class="col-sm-10" id="centerLayout">
        <!--巨幕-->
        <div class="jumbotron">
            <h1 class="text-center">欢迎来到持明法洲后台管理系统</h1>
        </div>
        <!-- 图片-->
        <img src="img/3ff6c1d304b851588cd026c0439f9260.jpg" class="img-rounded" height="450px" width="1375px" alt="Responsive image">
    </div>
</div>
<div class="container-fluid" style="padding:0px">
    <div class="panel panel-default">
        <div class="panel-heading"><p class="text-center">持明法洲后台管理系统@百知教育2019.10.27</p></div>
    </div>
</div>

</body>
</html>