<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap Login Form Template</title>
    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/assets/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/assets/css/form-elements.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/assets/css/style.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/back/assets/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath}/back/assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/back/assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath}/back/assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/back/assets/ico/apple-touch-icon-57-precomposed.png">
    <script src="${pageContext.request.contextPath}/back/assets/js/jquery-2.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/back/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/back/assets/js/jquery.backstretch.min.js"></script>
    <script src="${pageContext.request.contextPath}/back/assets/js/scripts.js"></script>
    <script src="${pageContext.request.contextPath}/back/assets/js/jquery.validate.min.js"></script>
    <script>

        $(function () {
            $("#captchaImage").click(function () {
                $("#captchaImage").prop("src", "${pageContext.request.contextPath}/code/getCode?time=" + new Date().getTime());
            });
        });

        $(function () {
            $("#loginButtonId").click(function () {
                var username = $("#form-username").val;
                var password = $("#form-password").val;
                var code = $("#form-code").val;
                if(username&&password&&code){
                    $.ajax({
                        url: "${pageContext.request.contextPath}/admin/login",
                        type: "POST",
                        data: $("#loginForm").serialize(),
                        dataType: "json",
                        success: function (data) {
                            if (data.status){
                                location.href = "${pageContext.request.contextPath}/back/main.jsp"
                            }else{
                                $("#error-message").html("<font color='red'>"+data.message+"</font>");
                            }
                        }
                    })
                }else {
                    $("#error-message").html("<font color='red'>请填写正确的信息</font>");
                }
            })
        })
    </script>
</head>

<body>

<!-- Top content -->
<div class="top-content">

    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text">
                    <h1><strong>CMFZ</strong> Login Form</h1>
                    <div class="description">
                        <p>
                            <a href="#"><strong>CMFZ</strong></a>
                        </p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top" style="width: 450px">
                        <div class="form-top-left">
                            <h3>Login to showall</h3>
                            <p>请输入你的用户名和密码：</p>
                        </div>
                        <div class="form-top-right">
                            <i class="fa fa-key"></i>
                        </div>
                    </div>
                    <div class="form-bottom" style="width: 450px">
                        <form role="form" action=".." method="post"
                              class="login-form" id="loginForm">
                            <span id="error-message"></span>
                            <span id="msgDiv"></span>
                            <div class="form-group">
                                <label class="sr-only" for="form-username">Username</label>
                                <input type="text" name="username" placeholder="请输入用户名..."
                                       class="form-username form-control" id="form-username" required>
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-password">Password</label>
                                <input type="password" name="password" placeholder="请输入密码..."
                                       minlength="2" class="form-password form-control" id="form-password" required>
                            </div>
                            <div class="form-group">
                                <img id="captchaImage" style="height: 48px" class="captchaImage"
                                     src="${pageContext.request.contextPath}/code/getCode">
                                <input placeholder="请输入验证码..."  style=" padding-left:20px;width: 287px;height: 50px;border:3px solid #ddd;border-radius: 4px;"
                                       type="test" name="code" id="form-code" required>
                            </div>
                            <input type="button" style="width: 400px;border:1px solid #9d9d9d;border-radius: 4px;"
                                   id="loginButtonId" value="登录">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>


</body>

</html>
