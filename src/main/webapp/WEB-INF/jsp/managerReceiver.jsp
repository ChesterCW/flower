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

<table width="45%" align="center" border="1" cellpadding="2" cellspacing="0" bordercolor="#969696">
    <tbody id="tBody">
    <tr align="center" bgcolor="#969696">
        <td colspan="4" bgcolor="#cccccc"><span class="STYLE2">商品信息</span></td>
    </tr>
    <tr align="center">
        <td>姓名</td>
        <td>电话</td>
        <td>地址</td>
        <td>操作</td>
    </tr>



</table>

</body>
</html>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/statesandright.js"></script>
<script src="${pageContext.request.contextPath}/js/layer.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
    //设置为默认地址
    function setDefault(id) {
        $.ajax({
            url:"${pageContext.request.contextPath}/setDefault/"+id,
            async:false,
            success:function (data) {
                if (data == "success"){
                    alert("设置成功");
                }
            }
        })
    }
    function toModifyReceiver(id) {
        location.href = "${pageContext.request.contextPath}/toModifyReceiver/"+id;
    }
    function deleteReceiver(id) {
        if(confirm("确认是否删除")){
            $.ajax({
                url:"${pageContext.request.contextPath}/deleteReceiver/"+id,
                async:false,
                success:function (data) {
                    if (data == "success"){
                        alert("删除成功");
                        location.href = "${pageContext.request.contextPath}/managerReceiver"
                    }else{
                        alert("删除失败")
                    }
                }
            })
        }
    }
    $(function () {
        var userId = $("#userId").val();
        //加载收货人信息
        $.ajax({
            url:"${pageContext.request.contextPath}/loadReceiver/"+userId,
            type:"post",
            async:false,
            success:function (data) {
                if (data.length > 0) {

                    $.each(data, function (idx, obj) {
                        $("#tBody").append('<tr align="center"><td width="20%">'+obj.name+'</td><td width="20%">'+obj.phone+'</td><td width="35%">'+obj.address+'</td>' +
                            '<td width="25%"><a href="javascript:void(0)" onclick="setDefault('+obj.id+')">设置为默认</a>&nbsp;|&nbsp;' +
                            '<a href="javascript:void(0)" onclick="toModifyReceiver('+obj.id+')">修改</a>&nbsp;|&nbsp;' +
                            '<a href="javascript:void(0)" onclick="deleteReceiver('+obj.id+')">删除</a></td></tr>');
                    })
                }
                $("#tBody").append('<tr align="center"><td colspan="4"><a href="${pageContext.request.contextPath}/addReceiver">添加收货人</a></td></tr>');
            }
        });
    })
</script>