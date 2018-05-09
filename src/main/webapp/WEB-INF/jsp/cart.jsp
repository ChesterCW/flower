<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>购物车</title>

    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">

</head>
<body class="cart-flow">
<!-- 头部 -->
<jsp:include page="header.jsp"></jsp:include>
<!-- 商品列表 -->
<div class="container">
    <!-- 订单列表 -->
    <div class="cart-panel">
        <div class="hd">
            <ul class="order-title">
                <li class="selecter"></li>
                <li class="product">商品名称</li>
                <li class="market-price">市场价</li>
                <li class="order-price">订购价</li>
                <li class="num">数量</li>
                <li class="operate">操作</li>
            </ul>
        </div>
        <div class="bd">


        </div>
    </div>
    <%--<c:forEach items="${cartList}" var="item" varStatus="i">--%>

    <%--<ul class="order-list" id="9012223">--%>
    <%--<li class="selecter">--%>
    <%--<i class="icon-select active"></i>--%>
    <%--<input type="hidden" name="commId" value="${item.id}">--%>
    <%--</li>--%>
    <%--<li class="img-box"><a href="" target="_blank">--%>
    <%--<img src="//img01.hua.com/uploadpic/newpic/9012223.jpg_80x87.jpg" height="56" width="50"></a>--%>
    <%--</li>--%>
    <%--<li class="product">--%>
    <%--<a href="${pageContext.request.contextPath}/commodityDetail/${item.id}" target="_blank">--%>
    <%--<span class="product-title">${item.title}</span>--%>
    <%--<span class="feature"></span>--%>
    <%--</a>--%>
    <%--</li>--%>
    <%--<li class="market-price">--%>
    <%--<span class="price-sign">¥</span>--%>
    <%--<span class="price-num">${item.marketPrice}</span>--%>
    <%--<input type="hidden" class="marketPrice" name="marketPrice" value="${item.marketPrice}">--%>
    <%--</li>--%>
    <%--<li class="order-price">--%>
    <%--<span class="price-sign">¥</span>--%>
    <%--<span class="price-num">${item.vipPrice}</span>--%>
    <%--<input type="hidden" class="vipPrice" name="vipPrice" value="${item.vipPrice}">--%>
    <%--</li>--%>
    <%--<li class="num">--%>
    <%--<div class="input-num">--%>
    <%--<a href="javascript:void(0);" onclick="minusCount(${i.count},${item.id})" class="btn btn-default no">--%>
    <%--<i class="ico ico-minus" style="margin-top: 0"></i>--%>
    <%--</a>--%>
    <%--<input type="text" class="form-control input-sm" name="count" value="${item.count}" maxlength="3">--%>
    <%--<a href="javascript:void(0)" onclick="addCount(${i.count},${item.id})" class="btn btn-default">--%>
    <%--<i class="ico ico-add" style="margin-top: 0"></i>--%>
    <%--</a>--%>
    <%--</div>--%>
    <%--</li>--%>
    <%--<li class="operate">--%>
    <%--<a href="javascript:void(0)" class="delBtn" style="margin-top: 0" onclick="deleteItems()">删除</a><br>--%>
    <%--</li>--%>
    <%--</ul>--%>

    <%--</c:forEach>--%>
    <div class="set-bar">
        <div class="set-info">
            <a class="back" href="${pageContext.request.contextPath}/index" style="width:90px;"><span
                    class="ico ico-back"></span>继续挑选</a>
            <div class="set-stat">
                应付金额:
                <div class="price">
                    <span class="price-sign">¥</span>
                    <span class="price-num" id="totalMoney"></span>
                </div>
            </div>
        </div>
        <button class="btn btn-primary btn-lg" type="button" onclick="balance()" id="balance">去结算</button>
    </div>
    <!-- 结算 End -->
</div>
</body>
</html>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/statesandright.js"></script>
<script src="${pageContext.request.contextPath}/js/layer.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>

<script>
    function logOut() {
        if(confirm("確定退出?")){
            $.ajax({
                url:"${pageContext.request.contextPath}/logOut",
                type:"post",
                success:function (data) {
                    location.href="${pageContext.request.contextPath}/cart";
                }
            })
        }else{
            return;
        }

    }

    //点击结算
    function balance() {
        var user = $("#userId").val();
        if (user.length > 0){
            location.href = "${pageContext.request.contextPath}/sendInfo";
        }else{
            location.href = "${pageContext.request.contextPath}/login";
        }

    }
    //删除购物车中商品
    function deleteItem(commId) {
        $.ajax({
            url: "${pageContext.request.contextPath}/deleteCart/"+commId,
            dataType: "json",
            type: "post",
            success: function (data) {
                alert(data);
                location.href = "${pageContext.request.contextPath}/cart"
            }
        })
    }

    //加载购物车列表
    $(function () {

        var ul = '<ul class="order-list"><li class="selecter"><i class="icon-select active"></i><li class="img-box">' +
            '<a href=""><img src="//img01.hua.com/uploadpic/newpic/9012223.jpg_80x87.jpg" height="56" width="50"></a></li>' +
            '<li class="product">' +
            '<a href="${pageContext.request.contextPath}/commodityDetail/';
        $.ajax({
            url: "${pageContext.request.contextPath}/cartList",
            async: false,
            dataType: "json",
            type: "post",
            success: function (data) {
                $.each(data, function (idx, obj) {
                    var div = ul + obj.id + '" target="_blank">' + '<span class="product-title">' + obj.title + '</span><span class="feature"></span></a></li><li class="market-price">' +
                        '<span class="price-sign">¥&nbsp;</span><span class="price-num">' + obj.marketprice + '</span></li><input type="hidden" class="marketPrice" name="marketPrice" value="'+obj.marketprice+'">' +
                        '<li class="order-price"><span class="price-sign">¥&nbsp;</span><span class="price-num">' +
                        obj.vipprice + '</span><input type="hidden" class="vipPrice" name="vipPrice" value="'+obj.vipprice+'"></li><li class="num"><div class="input-num">' +
                        '<a href="javascript:void(0);" onclick="minusCount(' + idx + ',' + obj.id + ')" class="btn btn-default no">' +
                        '<i class="ico ico-minus" style="margin-top: 0"></i></a><input type="text" class="form-control input-sm" name="count" value="'+obj.count+'" maxlength="3">' +
                        '<a href="javascript:void(0)" onclick="addCount(' + idx + ',' + obj.id + ')" class="btn btn-default"><i class="ico ico-add" style="margin-top: 0"></i></a></div>' +
                        '</li><li class="operate"><a href="javascript:void(0)" onclick="deleteItem(' + obj.id + ')" class="delBtn" style="margin-top: 0">删除</a><br></li></ul>';
                    $('.bd').append(div);
                });
            }

        })
        totalPrice()
    })

    //计算总价
    function totalPrice() {
        $("#totalMoney").text(0);
        /*追加总价*/
        var num = 0;
        var price = 0;
        var i = 0;

        $("input[name='count']").each(function () {
            var vipPrice = $(".vipPrice").eq(i).val();
            var count = $(this).val();
            i++;
            price = price + (count * vipPrice)
        });

        $("#totalMoney").text(price);
    }

    //添加数量
    function addCount(i, commId) {
        var count = parseInt($('.input-sm').eq(i).val());

        updateCount(i, commId, count + 1)
    }

    //减少数量
    function minusCount(i, commId) {
        var count = parseInt($('.input-sm').eq(i).val());

        if (count == 1) {
            return;
        }
        updateCount(i, commId, count - 1)
    }

    //修改数量
    function updateCount(i, commId, count) {
        $.ajax({
            url: "${pageContext.request.contextPath}/addCount",
            dataType: "json",
            type: "post",
            async: false,
            data: {"count": count, "commId": commId},
            success: function (data) {
                $('.input-sm').eq(i).val(data);
            }
        });
        totalPrice();
    }


</script>