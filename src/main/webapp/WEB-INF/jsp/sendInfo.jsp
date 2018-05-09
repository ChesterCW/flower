<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>结算</title>

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
<jsp:include page="header.jsp"></jsp:include>

<form method="POST" action="${pageContext.request.contextPath}/addOrder" onsubmit="return checkOrder()" id="form1" name="form1">
    <div class="container">
        <!-- 填写订单信息 -->
        <div class="cart-panel">
            <div class="hd"><h3>填写订单信息</h3></div>
            <div class="bd">
                <!-- 收货人信息 -->

                <div class="order-item" id="order-item">
                    <div class="item-hd">
                        <h5>收货人信息</h5>
                        <a class="j-consignee" href="javascript:void(0); " onclick="AddressOper( '1' , '11')">管理收货人</a>
                    </div>

                </div>
                <!-- 收货人信息 End -->
                <!-- 订购人信息 -->
                <!-- 配送日期/配送时段 End -->
                <!-- 支付方式 -->
                <div class="order-item">
                    <div class="item-hd">
                        <h5>支付方式</h5>
                    </div>
                    <div class="item-bd">
                        <ul class="selects-list" id="payWay">
                            <li class="active" id="payway0" data-popover="true" data-content="支持：支付宝、微信扫码、财付通、易宝支付、PayPal；以及工行、农行、建行、中行、招行、交行等10多家主要银行直付。">网上支付<i class="ico ico-pop"></i><i class="ico ico-check"></i></li>
                        </ul>
                    </div>
                </div>
                <input name="pays" type="hidden" id="pays" value="网上支付">
                <!-- 支付方式 End -->
                <!-- 特殊要求 -->
                <div class="checkbox-wrap form-inline" style="margin-bottom:6px;">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" class="special-checkbox" id="tsYaoQiu" name="tsYaoQiu"> 备注
                        </label>
                    </div>
                    <div class="form-group special-form hidden">
                        <input type="text" class="form-control input-sm" name="buyerMessage" placeholder="选填，如有其他要求请注明,我们尽量满足，120字以内:)" style="width:500px;" maxlength="120">
                    </div>
                </div>
            </div>
        </div>
        <!-- 填写订单信息 End -->
        <!-- 核对购物清单 -->
        <div class="cart-panel check">
            <div class="hd"><h3>核对购物清单</h3></div>
            <div class="bd" id="Products">


            </div>
        </div>
        <!-- 核对购物清单 End -->
        <!-- 提交订单 -->
        <div class="submit-order">
            <div class="stat" id="stat">

                <div class="price">
                    <span class="price-sign">¥</span>
                    <span class="price-num" id="product_money"></span>
                </div>
            </div>
            <div class="stat total">
                实付款：
                <div class="price">
                    <span class="price-sign">¥</span>
                    <span class="price-num" id="order_total_money"></span>
                </div>
            </div>
            <input type="hidden" name="receiverId" id="receiverId" value="">
            <input type="hidden" name="tt_flag" id="tt_flag" value="1">
            <input type="hidden" name="totalMoney" id="totalMoney">
            <button class="btn btn-primary btn-lg" type="submit" id="DoSubmit">提交订单</button>

            <button class="btn btn-primary btn-lg" type="button" id="Submiting" disabled="disabled" style="display:none">提交中,请等待...</button>

        </div>
        <!-- 提交订单 End -->
    </div>
</form>

</body>
</html>


<script type="text/javascript" src="${pageContext.request.contextPath}/js/statesandright.js"></script>
<script src="${pageContext.request.contextPath}/js/layer.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
    //校验订单
    function checkOrder() {
        var receiverId = $("#receiverId").val();
        if (receiverId.length > 0){
            return true;
        }else{
            alert("请设置一个默认收货地址");
            return false;
        }
    }
    $(function () {
        $('#consigneeModal').hide();


        var userId = $("#userId").val();
        //加载用户购买的商品
        $.ajax({
            url:"${pageContext.request.contextPath}/getCart",
            type:"post",
            async:false,
            success:function (data) {
                $(".submit-order").append('<input type="hidden" name="cartId" value="'+data.cartId+'">')
                $.each(data.list,function (idx,obj) {
                   $("#Products").append('<ul class="order-list">' +
                       '<li class="img-box"><a href="<a href="${pageContext.request.contextPath}/commodityDetail/'+ obj.id+'" target="_blank">' +
                       '<img src="//img01.hua.com/uploadpic/newpic/9010011.jpg_80x87.jpg" height="56" width="50"></a></li>'+
                    '<li class="product">' +
                    '<a href="${pageContext.request.contextPath}/commodityDetail/'+ obj.id+'">' +
                    '<span class="product-title">'+obj.title+'</span></a>' +
                    '<div class="price"><span class="price-sign">¥</span><span class="price-num">'+obj.vipprice+'</span></div>x'+obj.count+'</li></ul>' +
                       '<input type="hidden" class="form-control input-sm" name="count" value="'+obj.count+'">' +
                       '<input type="hidden" class="vipPrice" name="vipPrice" value="'+obj.vipprice+'">');
                });
            }
        })

        totalPrice();
        //加载收货人信息
        $.ajax({
            url:"${pageContext.request.contextPath}/loadReceiver/"+userId,
            type:"post",
            async:false,
            success:function (data) {
                if (data.length > 0){
                    $.each(data,function (idx,obj) {
                        if (obj.status=="1") {
                            $("#order-item").append(
                                '<div class="item-bd"><div id="showAddress"><div class="address-bar">' +
                                '<div class="name active" id="address0">' + obj.name + '<i class="ico ico-check"></i></div>' +
                                '<div class="address">' +
                                '<i id="address0_0">' + obj.name + '</i><i><span id="address0_2">' + obj.address + '</span>' +
                                '<i><span id="address0_4">' + obj.phone + '</span><span id="address0_5"></span></i>' +
                                '<span id="address0_6" style="display:none;">0</span></div></div></div>');
                            $("#receiverId").val(obj.id);
                            $(".j-consignee").show();
                        }
                    })
                }
            }
        })

        // 特殊要求显示/隐藏
        $(".special-checkbox").on('change', function () {
            if($(this).is(':checked')) {
                $('.special-form').removeClass('hidden');
            }
            else {
                $('.special-form').addClass('hidden');
            }
        });

        // var ttFlag='1';
        // //窗口操作开始
        // $('#consigneeModal').modal({backdrop: 'static', keyboard: false, show: false});
        // $('#consigneeModal').on('shown.bs.modal', function () {
        //     var $this = $(this);
        //     var $modal_dialog = $this.find('.modal-dialog');
        //     $this.css('display', 'block');
        //     $modal_dialog.css({'margin-top': Math.max(0, ($(window).height() - $modal_dialog.height()) / 2) });
        // });
        // $('#consigneeModal').on('hidden.bs.modal', function () {
        //     $("#attPage").attr("src","");
        // });
    })
    //计算总价
    function totalPrice() {

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

        $("#order_total_money").text(price);
        $("#totalMoney").val(price);
        $("#stat").prepend(i+"件商品，商品总金额:");
        $("#product_money").text(price);
        $(".submit-order").append('<input type="hidden" name="payment" value="'+price+'">')
    }


    function AddressOper(ids,op)
    {
        if(op==11)
        {
            location.href = "${pageContext.request.contextPath}/managerReceiver";
        }
    }
    //关闭窗口
    function modalClose() {
        $('#consigneeModal').hide();
    }



</script>