<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <link href="css/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="css/bootstrap/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css"/>


</head>
<body>
<div class="container" style="padding-top: 10%">
    <form action="backIndex" method="get" id="registerForm" onsubmit="return login()">
        <div style="margin:0 auto; width:400px;">
            <div class="form-group">
                <label>邮箱：</label>
                <input type="text" name="email" id="txtEmail" class="form-control" />
            </div>
            <div class="form-group">
                <label> 密  码：</label>
                <input type="password" name="password" id="txtRegisterPassword" class="form-control" />
            </div>
            <button type="submit" id="btnRegister1" class="btn btn-primary">登陆</button>
            <button type="reset" class="btn btn-default" id="btnRegister">重置</button>
        </div>
    </form>
</div>
<script>
    //登陆
    function login() {
        var email = $('#txtEmail').val();
        var pwd = $('#txtRegisterPassword').val();
        var flag = 0;
        $.ajax({
            url:'login',
            data:{'email':email,'password':pwd},
            dataType:'json',
            async:false,
            type:'post',
            success:function (data) {
                if(data){
                    flag = 1;
                }
            }
        });

        if (flag==0){
            alert("用户名或密码不正确");
            return false;
        }
        return true;

    }

    //
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
<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="css/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="css/bootstrap/js/bootstrapValidator.min.js" type="text/javascript"></script>
</body>
</html>
