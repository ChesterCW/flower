<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户评论</title>

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
                    <span class="ico ico-cart"></span>购物车<span class="text-primary" id="gwcCount"></span>
                    <span class="glyphicon glyphicon-triangle-bottom"></span></a>
                <div class="dropdown-menu dropdown-cart" id="CartInfo"></div>
            </li><!--购物车信息显示end-->
            <li class="site-nav-pipe">|</li>
        </ul>
    </div>

    <table width="45%" align="center" border="1" cellpadding="2" cellspacing="0" bordercolor="#969696" style="border-collapse:collapse;line-height:25px;">
        <tbody id="tableBody">
        <tr>
            <td align="center" bgcolor="#cccccc" colspan="3"><span class="STYLE2">订单商品列表</span></td>
        </tr>

        </tbody>
    </table>
    <input type="hidden" value="${orderId}" id="orderId">

</div>
</body>
</html>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/statesandright.js"></script>
<script src="${pageContext.request.contextPath}/js/layer.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
    $(function () {
        DoSelectZT();
    })

    function commit(commId,i) {
        var content = $("#content"+i).val();
        $.ajax({
            url:"${pageContext.request.contextPath}/addComment",
            type:"post",
            data:{"content":content,"commId":commId},
            async:false,
            success:function (data) {
                if (data == "success"){
                    alert("评论成功！");

                }else{
                    alert("评论失败！")
                }
            }

        })
    }
    //根据条件查询订单
    function DoSelectZT() {
        var orderId = $("#orderId").val();
        $("#bd").empty();
        //加载用户购买的商品
        $.ajax({
            url:"${pageContext.request.contextPath}/orderCommodity/"+orderId,
            type:"post",
            async:false,
            success:function (data) {
                var i = 0;
                $.each(data.commodityList,function (idx,obj) {
                    i++;
                    $("#tableBody").append('<tr><td align="left" width="30%">商品名称：'+obj.title+'</td>' +
                        '<td width="75%"><input width="100%" placeholder="请输入评论内容" type="text" id="content'+i+'" size="20" id="content></td>' +
                        '<td width="10%"><input type="button" value="确定" onclick="commit('+obj.commId+','+i+')"></td></tr>');
                });
            }
        })
    }
</script>
