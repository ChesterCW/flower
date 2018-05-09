<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>订单列表</title>

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

<jsp:include page="header.jsp"></jsp:include>

    <div class="container" style="width: 60%">


        <div class="pull" style="margin: 0 auto">
            <div class="box-border">
                <div class="order-wrap">
                    <div class="title">
                        <h3>我的订单</h3>
                    </div>

                    <!-- 订单列表 -->
                    <div class="order-panel">
                        <div class="hd">
                            <ul class="order-title">
                                <li class="number">订单编号</li>
                                <li class="consignee">收货人</li>
                                <li class="order-price">订单金额</li>
                                <li class="date">配送时间</li>
                                <li class="state">
                                    <select class="form-control input-sm" id="zt" onchange="DoSelectZT()">
                                        <option value="0">全部状态</option>
                                        <option value="1">待付款</option>
                                        <option value="2">已完成</option>
                                        <option value="6">已取消</option>
                                    </select>
                                </li>
                                <li class="operate">操作</li>
                            </ul>
                        </div>
                        <div class="bd" id="bd">

                        </div>

                        <div class="digg">

                        </div>
                    </div>
                    <!-- 订单列表 End -->
                </div>
            </div>
        </div>

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

    //根据条件查询订单
    function DoSelectZT() {
        var orderStatus = $("#zt").val();
        $("#bd").empty();
        //加载用户购买的商品
        $.ajax({
            url:"${pageContext.request.contextPath}/orderList",
            type:"post",
            data:{"orderStatus":orderStatus},
            async:false,
            success:function (data) {
                if (data == null){
                    location.href = "${pageContext.request.contextPath}/login"
                }else{

                    $.each(data,function (idx,obj) {
                        $("#bd").append('<ul class="order-list">' +
                            '<li class="img-box">&nbsp;</li>' +
                            '<li class="number"><a href="${pageContext.request.contextPath}/commodityDetail/'+ obj.id+'">'+ obj.id+'</a></li>' +
                            '<li class="consignee">'+obj.name+'</li>' +
                            '<li class="order-price"><span class="price-sign">¥</span> ' +
                            '<span class="price-num">'+obj.payment+'</span></li>' +
                            '<li class="date">'+timeStampExchange(obj.createTime)+'</li>' +
                            '<li class="state">'+ordersStatus(obj.orderStatus)+'</li><li class="operate">' +
                            '<a href="${pageContext.request.contextPath}/lookOrder/'+obj.id+'" target="_blank">查看</a><span>|</span>' +
                            '<a href="javascript:cancelOrder('+obj.id+');"> 取消 ' +
                            '</a><a href="javascript:void(0)" ' +
                            'class="btn btn-primary btn-sm" onclick="'+isDisabled(obj.id,obj.orderStatus)+'">'+isPay(obj.orderStatus)+'</a></li></ul>');
                        return;
                    });

                }
            }
        })
    }
    //取消订单
    function cancelOrder(id) {
        var r = confirm("确认是否取消订单?");
        if (r){
            //加载用户购买的商品
            $.ajax({
                url:"${pageContext.request.contextPath}/modifyOrder/"+id,
                type:"post",
                data:{"orderStatus":6},
                async:false,
                success:function (data) {
                    location.href = "${pageContext.request.contextPath}/orders";
                }
            })
        }
    }
    //跳转到支付页面
    function toPay(id){
        location.href = "${pageContext.request.contextPath}/payment/"+id;
    }
    function toComment(id) {
        location.href = "${pageContext.request.contextPath}/userComment/"+id;
    }
    //判断按钮是否可用
    function isDisabled(id,status) {
        if (status == "2"||status =="4") {
            return "toComment("+id+")";
        }else{
            return "toPay("+id+")"
            //return "${pageContext.request.contextPath}/payment/"+id;
        }
    }
    //判断是否需要支付
    function isPay(status) {
        if (status == "1") {
            return "付款";
        }else if (status == "2" || status=="4"){
                return "去评价";
        }else if (status == "5"){
            return "已完成";
        }else {
            return "未知";
        }
    }
    //判断用户订单状态
    function ordersStatus(status) {
        if (status == "1"){
            return "未付款";
        }else if (status == "2"){
            return "未发货";
        }else if (status == "3"){
            return "未发货";
        }else if (status == "4"){
            return "已发货";
        }else if (status == "5"){
            return "已完成";
        }else {
            return "未知";
        }
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
</script>
