<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrapValidator.min.css">

    <title>用户信息</title>
</head>

<style>
    .control-label{
        width: 100px;
        height: 50px;
    }
</style>


<form action="managerUser" onsubmit="return addUser()">
    <div class="container" style="width: 35%">
        <h2><strong>用户信息</strong></h2>
        <div class="form-group">
            <label>用户名</label>
            <input type="text" class="form-control" id="username" name="username" />
        </div>
        <div class="form-group">
            <label>邮箱</label>
            <input type="text" class="form-control" id="email" name="email" />
        </div>
        <div class="form-group">
            <label>密码</label>
            <input type="password" class="form-control" id="password" name="password" />
        </div>
        <div class="form-group">
            <label>确认密码</label>
            <input type="password" class="form-control" id="password2" name="password2" />
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
        <div class="form-group">
            <label>用户类型</label>
            <div class="form-group">
                <input type="radio" name="level" value="2" />管理员
                <input type="radio" name="level" value="3" />普通会员
                <input type="radio" name="level" value="4" />高级会员
            </div>
        </div>


        <div class="form-group">
            <div align="center">
                <button type="button" id="back" class="btn btn-primary">返回</button>
                <button type="submit" name="submit" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</form>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="${pageContext.request.contextPath}/text/javascript" src="js/bootstrap-table.min.js"></script>
<script src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrapValidator.min.js" type="text/javascript"></script>
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
                    alert(data)
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
    //添加用户
    function addUser() {
        var email = $('#email').val();
        var username = $('#username').val();
        var password = $('#password').val();
        var password1 = $('#password1').val();
        var phone = $('#phone').val();
        var gender = $("input[name='gender']").val();
        var level = $("input[name='level']").val();

        var flag = 0;
        $.ajax({
            url:'${pageContext.request.contextPath}/register',
            data:{'username':username,'email':email,'password':password,'phone':phone,'gender':gender,'level':level},
            dataType:'json',
            async:false,
            type:'post',
            success:function (data) {
                if(data){
                    flag = 1;
                    location.href = "${pageContext.request.contextPath}/userManager";
                }
            }
        });
    }


//查询全部用途
    <%--$(function () {--%>
    <%--//清空--%>
    <%--var kindId = $("#kindId").val();--%>
    <%--$("#back").click(function () {--%>
    <%--location.href="${pageContext.request.contextPath}/commodity-list";--%>
    <%--});--%>

    <%--//加载商品种类--%>
    <%--$.post('${pageContext.request.contextPath}/loadKindId',function (data) {--%>
    <%--var option;--%>
    <%--$.each(data, function(idx, obj) {--%>
    <%--option = $("<option value="+obj.id+">"+obj.name+"</option>");--%>
    <%--$("[name='kindId']").append(option);--%>
    <%--});--%>
    <%--$("[name='kindId']").val(kindId);--%>
    <%--loadCateId(kindId)--%>
    <%--});--%>
    <%--//根据种类生成类别--%>
    <%--$(function () {--%>
    <%--$("[name='kindId']").change(function (){--%>
    <%--$("[name='cateId']").empty();--%>
    <%--$("[name='mateId']").empty();--%>
    <%--var kindId = $("[name='kindId']").val();--%>
    <%--$.get('${pageContext.request.contextPath}/loadCates/'+kindId,function (data) {--%>
    <%--var option;--%>
    <%--$.each(data.cate, function(idx, obj) {--%>
    <%--option = $("<option value="+obj.id+">"+obj.name+"</option>");--%>
    <%--$("[name='cateId']").append(option);--%>
    <%--});--%>
    <%--$.each(data.mate, function(idx, obj) {--%>
    <%--option = $("<option value="+obj.id+">"+obj.name+"</option>");--%>
    <%--$("[name='mateId']").append(option);--%>
    <%--});--%>
    <%--});--%>
    <%--})--%>
    <%--})--%>

    <%--});--%>
    <%--function loadCateId(kindId) {--%>
    <%--var cateId = $("#cateId").val();--%>
    <%--var mateId = $("#mateId").val();--%>
    <%--$.ajax({--%>

    <%--url:'${pageContext.request.contextPath}/loadCates/'+kindId,--%>
    <%--async:false,--%>
    <%--success:function (data) {--%>
    <%--var option;--%>
    <%--$.each(data.cate, function(idx, obj) {--%>
    <%--option = $("<option value="+obj.id+">"+obj.name+"</option>");--%>
    <%--$("[name='cateId']").append(option);--%>
    <%--});--%>
    <%--$.each(data.mate, function(idx, obj) {--%>
    <%--option = $("<option value="+obj.id+">"+obj.name+"</option>");--%>
    <%--$("[name='mateId']").append(option);--%>
    <%--});--%>
    <%--}});--%>
    <%--$("[name='cateId']").val(cateId);--%>
    <%--$("[name='mateId']").val(mateId);--%>

    <%--}--%>
</script>
