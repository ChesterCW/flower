<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <link href="css/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="css/bootstrapValidator/dist/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css"/>


</head>
<body style="background-color: pink">
<div class="container">
    <div style="background-color: pink;padding-top: 10%;padding-bottom: 15%">

        <form action="" method="get" id="registerForm">

            <div style="margin:0 auto; width:400px;">
                <div class="form-group">
                    <label>邮箱：</label>
                    <input type="text" name="email" id="txtEmail" class="form-control" />
                </div>
                <div class="form-group">
                    <label>用户名：</label>
                    <input type="text" name="email" id="username" class="form-control" />
                </div>
                <div class="form-group">
                    <label> 密  码：</label>
                    <input type="password" name="password" id="txtRegisterPassword" class="form-control" />
                    <label> 确认密码：</label>
                    <input type="password" name="submitPassword" id="submitPassword" class="form-control" />
                </div>
                <div class="form-group">
                    <label>电话</label>
                    <input type="text" class="form-control" id="phone" name="phone" />
                </div>
                <div class="form-group">
                    <label>性别</label>
                    <div class="form-group">
                        <input type="radio" name="gender" value="1" />男
                        <input type="radio" name="gender" value="2" />女
                    </div>
                </div>

                <button type="button" id="btnRegister1" onclick="register()" class="btn btn-primary">注册</button>
                <button type="reset" class="btn btn-default" id="btnRegister">重置</button>
            </div>
        </form>
    </div>
</div>
<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="css/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="css/bootstrapValidator/dist/js/bootstrapValidator.min.js" type="text/javascript"></script>
<script>
    //判断用户是否存在
    $("#txtEmail").blur(function () {
        var email = $("#txtEmail").val();
        if (email.length >0){
            $.ajax({
                url: '${pageContext.request.contextPath}/userExist',
                data: {'email': email},
                dataType: 'json',
                async: false,
                type: 'post',
                success: function (data) {
                    if (data == true) {
                        alert("用户已被注册")
                        $("#btnRegister1").attr("disabled", true);
                    }else {
                        $("#btnRegister1").attr("disabled", false);
                    }
                }
            });
        }
    })

    //登陆
    function register() {
        var email = $('#txtEmail').val();
        var pwd = $('#txtRegisterPassword').val();
        var subPwd = $('#submitPassword').val();
        var username=$('#username').val();
        var phone = $('#phone').val();
        var gender = $("input[name='gender']").val();
        if (pwd==subPwd) {
            if(username.length>0 && email.length>0 && gender.length>0 && phone.length>0){
                var flag = 0;
                $.ajax({
                    url: '${pageContext.request.contextPath}/register',
                    data: {'email': email,'username':username, 'password': pwd,'phone':phone,'gender':gender},
                    dataType: 'json',
                    async: false,
                    type: 'post',
                    success: function (data) {
                        if (data == true) {
                            alert("注册成功");
                            location.href = "${pageContext.request.contextPath}/login";
                        }
                    }
                });
            }else {
                alert("值不能为空")
                return false;
            }
        }else{
            alert("两次输入密码不一致")
            return false;
        }
        return true;
    }
    // $('#registerForm').bootstrapValidator({
    //     fields: {
    //         email: {
    //             validators: {
    //                 notEmpty: {
    //                     message: '邮箱是必填项'
    //                 },
    //                 emailAddress: {
    //                     message: '邮箱格式正确'
    //                 }
    //             }
    //         },
    //
    //         password: {
    //             message: '密码还没有验证',
    //             validators: {
    //                 notEmpty: {
    //                     message: '密码不能为空'
    //                 },
    //                 stringLength: {
    //                     min: 6,
    //                     max: 16,
    //                     message: '密码长度在6到16之间'
    //                 },
    //                 different: {
    //                     field: 'Username',
    //                     message: '密码不能和用户名相同'
    //                 }
    //             }
    //         },
    //         Confirm: {
    //             message: '密码重复还没有验证',
    //             validators: {
    //                 notEmpty: {
    //                     message: '密码重复不能为空'
    //                 },
    //                 stringLength: {
    //                     min: 6,
    //                     max: 16,
    //                     message: '密码长度在6到16之间'
    //                 },
    //                 identical: {
    //                     field: 'password',
    //                     message: '两次密码不同请重新输入'
    //                 }
    //             }
    //         }
    //     }
    //
    // });
</script>

</body>
</html>
