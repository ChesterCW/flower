<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>订单列表</title>

    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">
</head>
<body class="cart-flow">
<!-- 顶部导航 -->
<jsp:include page="header.jsp"></jsp:include>

<div class="site-nav">

    <table width="45%" align="center" border="1" cellpadding="2" cellspacing="0" bordercolor="#969696"
           style="border-collapse:collapse;line-height:25px;">
        <tbody>
        <tr>
            <td align="center" bgcolor="#cccccc"><span class="STYLE2">订单基本信息</span></td>
        </tr>
        <tr>
            <td align="left">
                <strong><font color="#FF6600">收货人信息：</font></strong>

                <br>
                姓名：${order.name}
                <br>
                手机：${order.phone}
                <br>
                地址：${order.address}
                <br>
                留言：${order.buyerMessage}
            </td>
        </tr>
        </tbody>
    </table>
    <table width="45%" align="center" border="1" cellpadding="2" cellspacing="0" bordercolor="#969696"
           style="border-collapse:collapse">
        <tbody>
        <tr align="center" bgcolor="#969696">
            <td colspan="4" bgcolor="#cccccc"><span class="STYLE2">商品信息</span></td>
        </tr>
        <tr align="center">
            <td>商品名称</td>
            <td>价格</td>
            <td>数量</td>
            <td>小计</td>
        </tr>

        <c:forEach items="${commodityList}" var="commodity">
            <tr align="center">
                <td>
                    <a href="">
                        <img src="//img01.hua.com/uploadpic/newpic/9010011.jpg_80x87.jpg" height="56" width="50">
                    </a>
                    <a href="" target="_blank">
                        ${commodity.title}
                    </a>
                </td>
                <td>${commodity.vipPrice}</td>
                <td>${commodity.num}</td>
                <td>${commodity.num*commodity.vipPrice}</td>
            </tr>
        </c:forEach>



        <tr align="center">
            <td colspan="4">
                <table border="0" cellpadding="2" cellspacing="0" width="90%">
                    <tbody>
                    <tr>
                        <td align="right">
                            订单合计金额：
                            <font color="#cc0000">
                            ${order.payment}
                        </font> RMB
                        </td>
                    </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        </tbody>
    </table>


</div>


</body>
</html>
