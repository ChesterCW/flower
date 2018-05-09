<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <meta charset="utf-8">
    <title>鲜花网</title>
    <meta name="description" content="鲜花网"/>
    <meta name="keywords" content="鲜花网"/>
    <meta name="renderer" content="webkit|ie-comp">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/mbar.css"/>
    <style>
        body {
            min-width: 1200px;
        }

        .categorys .dropdown-cate {
            height: 440px;
        }
    </style>
    <style>
        .app-wx-wrapper .app-download {
            width: 334px;
            text-align: left;
            padding-left: 0;
        }

        .app-wx-wrapper .app-download img {
            margin-left: 13px;
            margin-right: 19px;
        }

        .app-wx-wrapper .cartoon {
            width: 466px;
        }

        .app-wx-wrapper .weixin {
            width: 390px;
        }

        .app-wx-wrapper .cartoon img {
            margin: 13px auto;
        }

        .app-wx-wrapper .weixin img {
            margin-right: 20px;
            margin-left: 18px;
        }

        .app-wx-wrapper .app-download, .app-wx-wrapper .weixin {
            padding: 25px 0px 20px 20px;
        }
    </style>

</head>
<body class="home">
<!-- 顶部导航 -->


<jsp:include page="header.jsp"></jsp:include>
<!-- 头部 -->
<header>
    <div class="logo1">

    </div>
        <div class="search">
            <div class="input-group">
                    <input name="keyword" id="searchInput" type="text" class="form-control" placeholder="商品关键词">
                    <span class="input-group-btn">
                        <button class="btn btn-primary" type="button" onclick="search()">搜索</button>
                    </span>
            </div>

            <span class="help-block"> </span>

        </div>


</header>
<!-- 头部 End -->
<!-- 导航 -->
<!-- 导航 -->
<nav class="default">
    <div class="container">
        <div class="categorys">
            <h3 class="categorys-title">
                <a href="" target="">全部商品导购</a>
            </h3>
            <div class="dropdown-cate">
                <h4>鲜花种类</h4>
                <ul class="cate-list list-inline" id="ul-kind"></ul>

                <h4>鲜花材料</h4>
                <ul class="cate-list list-inline" id="ul-mate"></ul>

                <h4>鲜花用途</h4>
                <ul class="cate-list list-inline" id="ul-use"></ul>

            </div>
        </div>
        <ul class="nav"></ul>
    </div>
    <!-- 大图轮翻 -->

    <div id="fullCarousel" class="carousel slide carousel-fade">
        <ol class="carousel-indicators">
            <li data-target="#fullCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#fullCarousel" data-slide-to="1" class=""></li>
            <li data-target="#fullCarousel" data-slide-to="2" class=""></li>
        </ol>
        <div class="carousel-inner">
            <div class="item active">
                <div class="fill" style="background-image:url('//img02.hua.com/slider/18_jinniu_pc.jpg');"></div>
            </div>
            <div class="item">
                <div class="fill" style="background-image:url('//img02.hua.com/slider/18_youflower_pc.jpg');"></div>
            </div>
            <div class="item">
                <div class="fill" style="background-image:url('${pageContext.request.contextPath}/images/index/banner_.jpg');"></div>
            </div>
        </div>
        <div class="control-wrapper">
            <a class="left carousel-control" href="#fullCarousel" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#fullCarousel" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
        </div>
    </div>
    <!-- 大图轮翻 -->

    <!-- 内容 -->
    <div class="container" id="floortop"></div>

    <!-- 商品列表 -->
    <div class="container" style="width: 75%" id="searchComm">
        <div class="wrapper">
            <div class="pull-left w970 l230" style="margin: 0px auto">
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
                <input type="hidden" value="${kindId}" id="kindId">
                <input type="hidden" id="page">
                <input type="hidden" id="totalPage">

            </div>
        </div>
    </div>
    <!-- 商品列表 End -->
</nav>


<!-- 通用尾部 -->
<jsp:include page="footer.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common_index.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.lazyload.min.js" type="text/javascript"></script>

<script>

    //分页搜索
    function pageSearch() {
        var searchVal = $('#searchInput').val();

        var page = parseInt($("#page").val());
        var totalPage = parseInt($("#page").val());
        if (page == 1 || page == totalPage){
            alert("没有商品啦！")
            return ;
        }
        loadCommodity(searchVal,1,48);
    }
    //模糊查询
    function search() {
        var searchVal = $('#searchInput').val();

        loadCommodity(searchVal,1,48);
    }
    //加载商品列表
    function loadCommodity(title,page,row) {
        $("#floortop").empty();
        if (title == ""){
            $("#searchComm").hide();

            // 商品列表
            $.ajax({
                url: "${pageContext.request.contextPath}/loadKind",
                dataType: 'json',
                async: false,
                success: function (data) {
                    $.each(data, function (idx, obj) {

                        var f = $('  <div class="floor f1" id="ff"><div class="hd">' +
                            '<a class="more" href="${pageContext.request.contextPath}/toKindCommodity/' + obj.id + '" target="_blank">更多' + obj.name + '&gt;&gt;</a>' +
                            '<h3><a href="${pageContext.request.contextPath}/toKindCommodity/' + obj.id + '" target="_blank">' + obj.name + '</a>' +
                            '<span>送·让你怦然心动的人</span></h3></div>' + ' <div class="bd"><div class="bd-l"><div class="banner-box">' +
                            '<a href="${pageContext.request.contextPath}/toKindCommodity/' + obj.id + '" target="_blank">' +
                            '<img data-original="" src="${pageContext.request.contextPath}/images/index/left'+idx+'.jpeg" height="438" width="243"></a>' +
                            '</div><a class="banner-link" href="${pageContext.request.contextPath}/toKindCommodity/' + obj.id + '" target="_blank">' + obj.name + '专区&gt;&gt;</a>' +
                            '</div><ul class="floor-products" id="ul' + obj.id + '"></ul>');
                        $("#floortop").append(f);

                        // 根据种类迭代商品
                        $.ajax({
                            url: "${pageContext.request.contextPath}/commodityByKindId/" + obj.id,
                            dataType: 'json',
                            data:{"page":page,"row":row,"title":title},
                            async: false,
                            success: function (data2) {
                                $.each(data2.rows, function (idx2, obj2) {
                                    //动态显示商品
                                    $("#ul" + obj.id + "").append(' <li>\n' +
                                        '<a href="${pageContext.request.contextPath}/commodityDetail/' + obj2.id + '" target="_blank">\n' +
                                        '<span class="img-box" href="">\n' +
                                        '<img src="${pageContext.request.contextPath}' + obj2.images + '" height="240" width="220">\n' +
                                        '</span>\n' +
                                        '<span class="product-title">' + obj.name + '· ' + obj2.title + '</span>\n' +
                                        '<p class="price">\n' +
                                        '<span class="price-sign">&yen;</span>\n' +
                                        '<span class="price-num">' + obj2.vipprice + '</span>\n</p>\n</a>\n</li>');
                                });
                            }
                        });
                    });
                }
            });
        }else{

            $("#list").empty();
            $("#searchComm").show();
            $("#default").hide();

            // 商品列表
            $.ajax({
                url: "${pageContext.request.contextPath}/backCommodityList",
                dataType: 'json',
                data:{"page":page,"row":row,"title":title},
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
    }


    //导航条列表
    $(function () {
        //加载商品
        loadCommodity("",1,6)
        //轮播图
        <%--$.ajax({--%>
            <%--url: "",--%>
            <%--dataType: 'json',--%>
            <%--async: false,--%>
            <%--success: function (data) {--%>
                <%--$('#carousel-inner').append('<div class="item active">' +--%>
                    <%--'<div class="fill" style=" background-image:url("${pageContext.request.contextPath}/images/' + data.images + '");">' +--%>
                    <%--'<a href="" target="_blank"></a></div>' +--%>
                    <%--' </div>');--%>
            <%--}--%>
        <%--});--%>

        $.ajax({
            url: "${pageContext.request.contextPath}/loadKind",
            dataType: 'json',
            async: false,
            success: function (kindData) {
                $.each(kindData, function (idx_kind, obj_kind) {
                    $('.nav').append('<li><a href="${pageContext.request.contextPath}/toKindCommodity/' +
                        obj_kind.id + '"  target="_blank">' + obj_kind.name + '</a></li>');
                });
            }
        });
    });

    //左侧导航 种类列表
    $(function () {
        $.ajax({
            url: "${pageContext.request.contextPath}/loadKind",
            dataType: 'json',
            async: false,
            success: function (catData) {
                $.each(catData, function (idx_cat, obj_cat) {
                    $('#ul-kind').append(' <li><a href="${pageContext.request.contextPath}/toKindCommodity/'+obj_cat.id+'"  target="_blank">' + obj_cat.name + '</a></li>');
                });
            }
        });
    });

    //左侧导航 用途列表
    $(function () {
        $.ajax({
            url: "${pageContext.request.contextPath}/searchMaterials",
            dataType: 'json',
            async: false,
            success: function (useData) {
                $.each(useData, function (idx_use, obj_use) {
                    $('#ul-mate').append(' <li><a href="${pageContext.request.contextPath}/toMateCommodity/' +
                        obj_use.id + '"  target="_blank">' + obj_use.name + '</a></li>');
                });
            }
        });
    });

    //左侧导航 材料列表
    $(function () {
        $.ajax({
            url: "${pageContext.request.contextPath}/searchUse",
            dataType: 'json',
            async: false,
            success: function (matData) {
                $.each(matData, function (idx_mat, obj_mat) {
                    $('#ul-use').append(' <li><a href="${pageContext.request.contextPath}/toUseCommodity/' +
                        obj_mat.id + '" target="_blank">' + obj_mat.title + '</a></li>');
                });
            }
        });
    });

    // //异步加载图片
    // $("img[data-original]").lazyload({
    //     effect: "fadeIn",
    //     threshold: 400,
    //     placeholder: "img\\indexImage\\375x409.png"
    // });


    // 大图轮翻(5秒)
    $('#fullCarousel').carousel({interval: 5000});

    // 大图鼠标移到小圆点轮翻
    $("#fullCarousel ol li").hover(function () {
        var index = $("#fullCarousel ol li").index(this);
        $("#fullCarousel").carousel(index);
    });

    // 大图右侧banner鼠标移上左移动
    $('.focus-wrapper a').hover(
        function () {
            $(this).animate({
                left: '-5px'
            }, 300);
        },
        function () {
            $(this).animate({
                left: '0'
            }, 300);
        }
    );

    // 漫画选花放大
    // $('.comic-choose img').hover(
    //     function () {
    //         $(this).animate({
    //             width: '270px',
    //             height: '216px',
    //             margin: '-10px 0 0 -8px'
    //         }, 100);
    //     },
    //     function () {
    //         $(this).animate({
    //             width: '250px',
    //             height: '200px',
    //             margin: '0'
    //         }, 100);
    //     }
    // );
    // // 花粉晒幸福(3秒)
    // $('#showCarousel').carousel({interval: 3000});
</script>

<%--<script src="${pageContext.request.contextPath}/js/layer.js"></script>--%>
<%--<script type="text/javascript">--%>
    <%--var userId = 0;--%>

    <%--function reqUrlParam(paras) {--%>
        <%--var url = location.href;--%>
        <%--var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");--%>
        <%--var paraObj = {}--%>
        <%--for (i = 0; j = paraString[i]; i++) {--%>
            <%--paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);--%>
        <%--}--%>
        <%--var returnValue = paraObj[paras.toLowerCase()];--%>
        <%--if (typeof (returnValue) == "undefined") {--%>
            <%--return "";--%>
        <%--} else {--%>
            <%--return returnValue;--%>
        <%--}--%>
    <%--}--%>

    <%--// function setCurUrlClass() {--%>
    <%--//     // css : class = "color_tj"--%>
    <%--//     var pathname1 = window.location.pathname;--%>
    <%--//     $("a[href='" + pathname1 + "'").addClass("color_tj");--%>
    <%--// }--%>
    <%--//--%>
    <%--// if ($("#pjCount").length > 0) {--%>
    <%--//     $.get("/productpj/GetPJCount", function (data) {--%>
    <%--//         $("#pjCount").text(data);--%>
    <%--//     });--%>
    <%--// }--%>
    <%--// $(function () {--%>
    <%--//     $.get("/Home/GetLoginUserId", null, function (data) {--%>
    <%--//         userId = data;--%>
    <%--//     }, "json");--%>
    <%--// });--%>

    <%--// $("#kefu").click(function () {--%>
    <%--//     $.post("/Home/ZhiChiCustomerLog", null, function (data) {--%>
    <%--//         window.open('https://www.sobot.com/chat/pc/index.html?sysNum=d22b0bfa87fd42258397365c95bc5e08&partnerId=' + data + '', '在线客服', 'height=800,width=650,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');--%>
    <%--//     });--%>
    <%--//--%>
    <%--// });--%>
    <%--// $("#kefu1").click(function () {--%>
    <%--//     $.post("/Home/ZhiChiCustomerLog", null, function (data) {--%>
    <%--//         window.open('https://www.sobot.com/chat/pc/index.html?sysNum=d22b0bfa87fd42258397365c95bc5e08&partnerId=' + data + '', '在线客服', 'height=800,width=650,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');--%>
    <%--//     });--%>
    <%--//--%>
    <%--// });--%>
<%--</script>--%>
<%--<!-- Global site tag (gtag.js) - Google Analytics -->--%>
<%--<script async src="js/js-id=UA-1701714-3.js"></script>--%>
<%--<script>--%>
    <%--window.dataLayer = window.dataLayer || [];--%>

    <%--function gtag() {--%>
        <%--dataLayer.push(arguments);--%>
    <%--}--%>

    <%--gtag('js', new Date());--%>

    <%--gtag('config', 'UA-1701714-3');--%>
<%--</script>--%>
</body>
