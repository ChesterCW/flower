<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>管理收货人</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">

</head>
<body>

<jsp:include page="header.jsp"></jsp:include>


<div class="modal fade com-modal in" id="consigneeModal" aria-hidden="false" style="display: block; padding-top: 5%">
    <div class="modal-dialog" style="margin-top: 0px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="attNotice">修改收货人信息</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal form-group-sm" id="receiverForm" onsubmit="return confirmForm()"
                      action="${pageContext.request.contextPath}/modifyReceiver" method="post">
                    <div class="form-group">
                        <input type="hidden" name="id" value="${receiver.id}">
                        <input type="hidden" name="userId" value="${userInfo.id}">
                        <label class="col-xs-2 control-label">收货人姓名:</label>
                        <div class="col-xs-2">
                            <input type="text" class="form-control" id="name" name="name" value="${receiver.name}" maxlength="15" autofocus="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">收货人手机:</label>
                        <div class="col-xs-5">
                            <input type="text" class="form-control" id="phone" name="phone" value="${receiver.phone}" maxlength="25">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">详细地址:</label>
                        <div class="col-xs-10" style="position:relative;">
                            <input type="text" class="form-control" placeholder="请输入详细地址" id="address" name="address"
                                   value="${receiver.address}" maxlength="120">
                            <span class="had_area"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-offset-2 col-xs-10">
                            <button type="submit" class="btn btn-default btn-tinge">保存收货人信息</button>
                            <button type="button" class="btn btn-default btn-tinge" disabled="disabled"
                                    style="display:none">保存中...
                            </button>&nbsp;&nbsp;&nbsp;&nbsp;
                            <button type="reset" class="btn btn-default btn-tinge">清除</button>
                        </div>
                    </div>
                </form>
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

    //添加收货人校验
    function confirmForm() {
        var name = $("#name").val();
        var address = $("#address").val();
        var phone = $("#phone").val();
        if ((name.length > 0) && (address.length > 0) && (phone.length > 0)) {
            return true;
        } else {
            alert("信息不完整");
            return false;
        }
    }
</script>