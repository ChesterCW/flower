<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>付款</title>

    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">

    <style>
        .logo1 {
            float: left;
            width: 500px;
            height: 64px;
            margin-top: 28px;
        }
    </style>
</head>
<body class="cart-flow">
<!-- 顶部导航 -->
<div class="site-nav">
    <div class="container">

        <ul class="site-nav-r">
            <!--登陆状态信息显示start-->
            <li class="menu login" id="LoginInfo">
                ${string}
                <c:if test="${empty userInfo}">
                    <a href="${pageContext.request.contextPath}/login" rel="nofollow" id="btn-login">你好，请登录</a>
                </c:if>
                <c:if test="${!empty userInfo}">
                    你好，${userInfo.username}&nbsp;&nbsp;
                    <input type="hidden" id="userId" value="${userInfo.id}">
                    <a href="javascript:void(0)" onclick="logOut()" rel="nofollow" id="btn-login">退出</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/register"
                   rel="nofollow" id="btn-reg">注册</a>
            </li>
            <!--登陆状态信息显示end-->
            <li class="site-nav-pipe">|</li>
            <li class="menu">
                <a href="${pageContext.request.contextPath}/orders" rel="nofollow" target="_blank">订单查询</a>
            </li>

            <li class="menu dropdown">
                <a href="${pageContext.request.contextPath}/cart" data-hover="dropdown" data-delay="0" rel="nofollow">
                    <span class="ico ico-cart"></span>购物车<span class="text-primary" id="gwcCount"></span><span
                        class="glyphicon glyphicon-triangle-bottom"></span></a>
                <div class="dropdown-menu dropdown-cart" id="CartInfo"></div>
            </li><!--购物车信息显示end-->
            <li class="site-nav-pipe">|</li>
        </ul>
    </div>
</div>
<!-- 顶部导航 End -->

<div class="logo1">
</div>
<div class="container">
    <div class="breadcrumbs"><a href="/">首页</a> &gt; 在线补款</div>
    <div class="wrapper help" style="border:1px solid #e0e0e0;">
        <div style="line-height:60px; font-size:24px;font-family: tahoma, arial, 'Hiragino Sans GB', '\5FAE\8F6F\96C5\9ED1', sans-serif; text-align:center; margin-top:20px;">在线补款</div>
        <table style="border-collapse:collapse;" border="1" bordercolor="D9D9D9" cellpadding="0" cellspacing="0" width="76%" align="center">
            <tbody>
            <tr bgcolor="fbfbfb">
                <td colspan="3" height="34" bgcolor="#eeeeee"><strong>国内支付</strong></td>
            </tr>
            <tr>
                <td height="90" width="23%"><strong>支付宝帐户</strong></td>
                <td width="51%" align="center"><a href="/Member/Payment/FillByAlipay?order_no=220135915&amp;total_fee=139" target="_blank" class="ablue">
                    <img src="//img02.hua.com/pc/pimg/zfbzf_02.jpg" alt="支付宝支付"></a></td>
                <td valign="middle" width="26%" align="center">
                    <a href="/Member/Payment/FillByAlipay?order_no=220135915&amp;total_fee=139" target="_blank" class="ablue">支付宝支付 &gt;&gt;</a>
                </td>
            </tr>
            <tr>
                <td height="90"><strong>微信支付</strong></td>
                <td align="center"><a href="/Member/Payment/FillByWeixin?order_no=220135915&amp;total_fee=139" target="_blank" class="ablue"><img src="//img02.hua.com/pc/pimg/wxzf_01.jpg" alt="微信支付"></a></td>
                <td valign="middle" width="26%" align="center"><a href="/Member/Payment/FillByWeixin?order_no=220135915&amp;total_fee=139" target="_blank" class="ablue">微信支付 &gt;&gt;</a></td>
            </tr>
            </tbody>

            <input type="hidden" id="id" value="${id}">
            <tr>
                <td colspan="3"><input type="button" value="确认付款" onclick="pay()"/></td>
            </tr>
        </table>

        <br>
        <br><br><br><br><br>
    </div>
</div>


</body>
</html>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/statesandright.js"></script>
<script src="${pageContext.request.contextPath}/js/layer.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>

<script>
    function pay() {
        var id = $("#id").val();
        $.ajax({
            url:"${pageContext.request.contextPath}/pay/"+id,
            data:{"id":id},
            success:function (data) {
                if (data == "success"){
                    alert("付款成功")
                    location.href ="${pageContext.request.contextPath}/orders";
                }
            }
        })
    }
</script>
