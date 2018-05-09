<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>商品列表</title>

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
<body class="yongshenghua">
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


    <div class="container" style="width: 75%">
        <div class="wrapper">
            <div class="pull-left w970 l230" style="margin: 0px auto">
                <!-- 大图轮播 -->
                <div id="flowerCarousel" class="carousel slide carousel-fade">
                    <ol class="carousel-indicators">
                        <li data-target="#flowerCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#flowerCarousel" data-slide-to="1"></li>
                        <li data-target="#flowerCarousel" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <!-- <div class="item">
                            <a href="/product/9012165.html" target="_bank"><img src="//img02.hua.com/banner/xianhua03_20170212.jpg" alt="爱在巴黎"></a>
                        </div> -->

                        <!--天天天晴-->
                        <div class="item active">
                            <a href="/product/9012240.html" target="_bank"><img src="//img02.hua.com/slider/xianhua01_20180224.jpg" alt="天天天晴"></a>
                        </div>
                        <div class="item">
                            <a href="/product/9012228.html" target="_bank"><img src="//img02.hua.com/slider/xianhua02_20180224.jpg" alt="浪漫心情"></a>
                        </div>
                        <div class="item">
                            <a href="/product/9012161.html" target="_bank"><img src="//img02.hua.com/slider/xianhua03_20180224.jpg" alt="爱的诺言"></a>
                        </div>
                    </div>
                    <a class="left carousel-control" href="#flowerCarousel" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                        <span class="sr-only">上一页</span>
                    </a>
                    <a class="right carousel-control" href="#flowerCarousel" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                        <span class="sr-only">下一页</span>
                    </a>
                </div>
                <!-- 大图轮播 End -->
                <!-- 筛选 -->
                <div class="filterbar">
                </div>
                <!-- 筛选 End -->
                <!-- 商品列表 -->
                <div class="grid-wrapper" id="list">


                </div>
                <!-- 商品列表 End -->
                <!-- 分页 -->
                <div class="page-wrapper">

                    <ul class="pagination" id="rows">



                        <li id="prev"><a href="javascript:void(0)" onclick="pageSearch()"><span class="glyphicon glyphicon-menu-left"></span> 上一页</a></li>
                        <li id="next"><a href="javascript:void(0)" onclick="pageSearch()">下一页 <span class="glyphicon glyphicon-menu-right"></span></a></li>
                    </ul>
                </div>
                <!-- 分页 End -->
                <input type="hidden" value="${useId}" id="useId">
                <input type="hidden" id="page">
                <input type="hidden" id="totalPage">

            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
    <!-- 通用尾部 -->


</body>
</html>



<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common_index.js"></script>

<script>

    //分页搜索
    function pageSearch() {
        var page = parseInt($("#page").val());
        var totalPage = parseInt($("#page").val());
        if (page == 1 || page == totalPage){
            alert("没有商品啦！")
            return ;
        }
        loadCommodity(1,48);
    }
    $(function () {
        loadCommodity(1,48);
    })

    function loadCommodity(page,row) {
        $("#list").empty();
        var id = $("#useId").val();
        // 迭代商品
        $.ajax({
            url: "${pageContext.request.contextPath}/commodityByUseId/"+id,
            dataType: 'json',
            data:{"page":page,"row":row,"useId":id},
            async: false,
            success: function (data) {
                $.each(data.rows, function (idx, obj) {
                    //动态显示商品
                    $("#list").append('<div class="grid-item"><div class="grid-panel"><div class="img-box">' +
                        '<a href="${pageContext.request.contextPath}/commodityDetail/' + obj.id + '" target="_blank">' +
                        '<img width="220" height="240" src="${pageContext.request.contextPath}'+obj.images+'"></a>' +
                        '</div><div class="info-cont"><div class="price"><span class="price-sign">¥&nbsp;</span><span class="price-num">'+obj.vipprice+'</span>' +
                        '</div><div class="title"><a href="${pageContext.request.contextPath}/commodityDetail/' + obj.id + '" target="_blank">' +
                        '<span class="product-title">'+obj.title+'</span></a></div></div></div>');
                });
                $("#page").val(page);
                $("#totalPage").val(Math.ceil(data.total/row));
            }
        });
    }

</script>