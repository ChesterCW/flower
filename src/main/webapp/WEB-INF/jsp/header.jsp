<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <title>Title</title>
</head>
<style>
    .logo1{
        float: left;
        width: 500px;
        height: 64px;
        margin-top: 28px;
    }
</style>
<body>
<div style="background-color: peachpuff;height:40px;"></div>
<div class="site-nav">
    <div class="container">

        <ul class="site-nav-r">
            <!--登陆状态信息显示start-->
            <li class="menu login" id="LoginInfo">
                ${string}
                <c:if test="${empty userInfo}">
                    <a href="${pageContext.request.contextPath}/login" rel="nofollow"
                       id="btn-login">你好，请登录</a>
                </c:if>
                <c:if test="${!empty userInfo}">
                    你好，${userInfo.username}&nbsp;&nbsp;
                    <a href="javascript:void(0)" onclick="logOut()" rel="nofollow"
                       id="btn-login">退出</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/register"
                   rel="nofollow" id="btn-reg">注册</a>
            </li>
            <input type="hidden" id="userId" value="${userInfo.id}">
            <!--登陆状态信息显示end-->
            <li class="site-nav-pipe">|</li>
            <li class="menu">
                <a href="${pageContext.request.contextPath}/orders" rel="nofollow" target="_blank">订单查询</a>
            </li>

            <li class="menu dropdown">
                <a href="${pageContext.request.contextPath}/cart" data-hover="dropdown" data-delay="0" rel="nofollow" target="_blank">
                    <span class="ico ico-cart"></span>购物车<span class="text-primary" id="gwcCount"></span>
                    <span class="glyphicon glyphicon-triangle-bottom"></span></a>
                <div class="dropdown-menu dropdown-cart" id="CartInfo"></div>
            </li><!--购物车信息显示end-->
            <li class="site-nav-pipe">|</li>
        </ul>
    </div>
</div>
<!-- 顶部导航 End -->

</body>
</html>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script>
    //退出登录
    function logOut() {

        $.ajax({
            url:"${pageContext.request.contextPath}/logOut",
            type:"post",
            success:function (data) {
                if (data == "success"){
                    location.href = "${pageContext.request.contextPath}/index"
                }
            }
        })
    }
</script>
