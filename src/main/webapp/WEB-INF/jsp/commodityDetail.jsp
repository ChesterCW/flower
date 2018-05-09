<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>

<head>
    <meta charset="utf-8">
    <title>鲜花网</title>

    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">

    <style>
        .common {
            margin-bottom: 0;
        }

        .container {
            text-align: center;
            position: relative;
            font-size: 12px;
        }

        .hua {
            text-align: left;
            position: absolute;
            top: 345px;
            left: 190px;
        }

        .hua a {
            color: #f60;
            text-decoration: underline;
        }

        .error_msg {
            text-align: left;
            position: absolute;
            top: 400px;
            left: 190px;
            max-width: 400px;
        }
        dd{
            text-align: left;
        }


    </style>

</head>

<body class="home">
<!-- 顶部导航 -->

<jsp:include page="header.jsp"></jsp:include>


<!-- 导航 -->
<nav class="default">
    <div class="container">
        <div class="categorys">
            <h3 class="categorys-title">
                <a href="${pageContext.request.contextPath}/index" target="">商城首页</a>
            </h3>

        </div>
        <ul class="nav" id="kindList"></ul>
    </div>

</nav>
<!-- 导航 End -->

<!-- 内容 -->
<div class="container">
    <div class="dropdown-cate" align="left">
        <ul class="nav">
            <li><a href=""></a></li>
        </ul>
    </div>
    <!-- 商品 -->
    <div class="product-wrapper">
        <div class="product-l">
            <!-- 商品图片 -->
            <div class="pro-preview">
                <!-- 大图 -->
                <div class="pro-bigimage" id="pro-bigimage">


                </div>
                <!-- 大图 End -->
                <!-- 小图 -->
                <div class="pro-thumb" id="pro-thumb"></div>
                <!-- 小图 End -->
                <!-- 箭头 -->
                <div class="pro-btn">
                    <a class="prev" href="javascript:getNum('prev')" title="上一张"></a>
                    <a class="next" href="javascript:getNum('next')" title="下一张"></a>
                </div>
                <!-- 箭头 End-->
            </div>
            <!-- 商品图片 End -->
        </div>
        <div class="product-r" id="product_title">
            <div class="title" id="title">
                <h3 class="product-title">${commodity.title}</h3>
            </div>
            <div class="attribute" id="attribute">
                <input type="hidden" id="id" value="${commodity.id}"/>
                <dl>
                    <dt>类 别 ：</dt>
                    <dd>${commodity.cateName}</dd>
                </dl>
                <dl>
                    <dt>材 料 ：</dt>
                    <dd>${commodity.mateName}</dd>
                </dl>
                <dl>
                    <dt>花 语 ：</dt>
                    <dd>${commodity.wishes}</dd>
                </dl>
                <dl>
                    <dt>描 述 ：</dt>
                    <dd>${commodity.description}</dd>
                </dl>
                <dl>
                    <dt>附 送 ：</dt>
                    <dd>${commodity.attache}</dd>
                </dl>
            </div>
            <div class="price-wrap flower-sku-box">

            </div>

            <div class="price" id="ajax_pricebox" style="border:none;text-align: left">
                <div class="price-original">市场价：¥${commodity.marketprice}</div>
                <div class="price-sell">会员价：<strong><em class="price-sign">¥</em><em class="price-num">${commodity.vipprice}</em></strong></div>
            </div>
            <div class="btn-buy">
                <a href="${pageContext.request.contextPath}/addToCart/${commodity.id}" class="btn btn-primary btn-lg" id="Btn_AddToCart">
                    <span class="ico ico-cart-white"></span>立即购买</a>
            </div>

            <div id="tips2" style="display:none;">
                <!--价格波动提示-->
            </div>
        </div>
    </div>
    <!-- 商品 End -->
    <div class="wrapper">
        <div class="pull-left w970 l230">
            <!-- 商品详情 -->
            <ul id="Tabs" class="tabs">
                <li class="tabs-item active"><a href="javascript:void (0)" id="detail" onclick="changeDetail()">商品详情</a></li>
                <li class="tabs-item active"><a href="javascript:void (0)" id="comm" onclick="changeComm()">用户评价</a></li>
                <li class="btn-buy-s" style="position:relative;display:none;">
                    <div class="price" style="font-size:24px;">
                        <span class="price-sign" style="font-size:15px;">&yen;</span>
                        <span class="price-num" id="goods_detail_float_price"></span>
                    </div>
                    <a style="font-size: 20px;width: 170px;height: 39px;margin-top: -9px;padding-left:35px;padding-right:10px"
                       href="" class="btn btn-primary btn-sm" id="goods_detail_float_addtocart">立即购买</a>
                    <span class="ico ico-cart-white" style="position: absolute;right:120px;top:7px;"></span>
                </li>
            </ul>
            <div id="Details" class="tabs-panel">

            </div>
            <div id="Comment" class="tabs-panel">
                <div class="comment-bd" id="commentList">

                </div>
                <div class="comment-ft">

                </div>
            </div>
        </div>
        <div class="pull-left w210 r970">
            <!-- 热销推荐 -->
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">热销推荐</h3>
                </div>
                <div class="panel-body" id="side">
                    <!-- 侧边商品 -->

                </div>


            </div>

            <!-- 侧边商品 End -->
        </div>
    </div>
    <!-- 热销推荐 End -->
</div>
</div>
</div>
<!-- 内容 End -->

<!--底部-->
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/statesandright.js"></script>
<script src="${pageContext.request.contextPath}/js/layer.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>

<script>

    //导航条列表
    $(function () {
        $.ajax({
            url: "${pageContext.request.contextPath}/loadKind",
            dataType: 'json',
            async: false,
            success: function (kindData) {
                $.each(kindData, function (idx_kind, obj_kind) {
                    $('#kindList').append('<li><a href="${pageContext.request.contextPath}/commodityByKindId/' + obj_kind.id + '">' + obj_kind.name + '</a></li>');
                });
            }
        });
        //加载热销商品
        $.ajax({
            url: "${pageContext.request.contextPath}/loadHot",
            dataType: 'json',
            success: function (data) {
                $.each(data, function (idx, obj) {
                    $('#side').append('<div class="side-item"><div class="img-box"><a href="${pageContext.request.contextPath}/commodityDetail/'+obj.commId+'" target="_blank">' +
                        '<img src="${pageContext.request.contextPath}'+obj.images+'" height="196" alt="浪漫缤纷"></a></div>' +
                        '<div class="info-cont"><div class="title"><a href="${pageContext.request.contextPath}/commodityDetail/'+obj.commId+'" class="product-title">'+obj.title+'</a></div>' +
                        '<div class="price"><span class="price-sign">￥&nbsp;' +
                        '</span><span class="price-num">'+obj.vipPrice+'</span></div></div>');
                });
            }
        });
    });
    $(function () {
        var commId = $("#id").val();
        //根据商品id查询商品详情图片
        $.ajax({
            url: "${pageContext.request.contextPath}/loadImagesByCommId/"+commId,
            dataType: 'json',
            async: false,
            success: function (kindData) {
                var images;
                $.each(kindData, function (idx, obj) {
                    images = obj.images;
                    $('#Details').append('<p align="center"><img src="${pageContext.request.contextPath}'+images+'" border="0"></p>');
                });
                $("#pro-bigimage").append('<img src="${pageContext.request.contextPath}'+images+'" style="display: inline;">')
            }
        });
        //初始加载10条评价
        searchComment(commId,1,10);
    })
    function searchComment(commId,page,row) {
        //根据商品id查询用户评价
        $.ajax({
            url: "${pageContext.request.contextPath}/commentByCommId/"+commId+"?&page="+page+"&row="+row,
            dataType: "json",
            async: "false",
            success: function (data) {
                $.each(data.rows, function (idx, obj) {
                    $('#commentList').append('<dl><dt><a href="javascript:void(0)">' +
                        '<img src="//img01.hua.com/uploadpic/newpic/9012223.jpg_80x87.jpg" height="63" width="58"></a>' +
                        '<br></dt><dd><div class="hd"><span class="pull-right">评价时间：' +timeStampExchange(obj.createtime)+
                        '</span><img src="" align="absmiddle">\n' +
                        '<img src="" align="absmiddle">\n' +
                        '</div><div class="bd"><p class="text-justify">评价内容：' +obj.content+
                        '</p></div></dd></dl>');
                });
                page = parseInt(page);
                page = page+1;
                $('#commentList').append("<span>&nbsp;本商品评价<font color='red'>"+data.total+"</font>条&nbsp;" +
                    "【<a target='_blank' href='javascript: void(0);' onclick='searchComment("+commId+","+page+","+row+")' " +
                    "title='查看更多评价' class='color_hong2'>查看更多评价</a>】</span>");
            }

        });
    }
    //时间格式化,将返回的时间戳转换为正常时间
    function timeStampExchange(time) {
        var datetime = new Date();
        datetime.setTime(time);
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1 < 10 ? "0"
            + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
        var date = datetime.getDate() < 10 ? "0" + datetime.getDate()
            : datetime.getDate();
        var hour = datetime.getHours() < 10 ? "0" + datetime.getHours()
            : datetime.getHours();
        var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes()
            : datetime.getMinutes();
        var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds()
            : datetime.getSeconds();
        return year + "-" + month + "-" + date + " " + hour + ":" + minute
            + ":" + second;
    }

    function changeComm() {
        $('#Comment').show();
        $('#Details').hide();

    }
    function changeDetail() {
        $('#Details').show();
        $('#Comment').hide();
    }
</script>