<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <link href="${pageContext.request.contextPath}/css/font-awesome.css" rel="stylesheet"/>
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/simple-line-icons/2.4.1/css/simple-line-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-table.min.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap-dialog.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrapValidator.min.css">

    <title>用户信息</title>
</head>

<style>
    .control-label{
        width: 100px;
        height: 50px;
    }
</style>


<form action="${pageContext.request.contextPath}/modifyCommodity" method="post">
    <div class="container" style="width: 35%">
        <h2 style="padding-bottom: 5%"><strong>用户信息</strong></h2>
        <div class="form-group">
            <input type="hidden" name="id" value="${user.id}">
            <label>用户名:</label>&nbsp;&nbsp;&nbsp;
            <label style="font-size: large">${user.username}</label>
        </div>
        <div class="form-group">
            <label>邮箱:</label>&nbsp;&nbsp;&nbsp;
            <label style="font-size: large">${user.email}</label>
        </div>
        <div class="form-group">
            <label>电话:</label>&nbsp;&nbsp;&nbsp;
            <label style="font-size: large">${user.phone}</label>
        </div>
        <div class="form-group">
            <label>性别:</label>&nbsp;&nbsp;&nbsp;
            <c:if test="${user.gender ==1 }">
                <label style="font-size: large">男</label>
            </c:if>
            <c:if test="${user.gender ==2 }">
                <label style="font-size: large">女</label>
            </c:if>
        </div>
        <div class="form-group">
            <label>用户类型:</label>&nbsp;&nbsp;&nbsp;
            <c:if test="${user.level ==2 }">
                <label style="font-size: large">管理员</label>
            </c:if>
            <c:if test="${user.level ==3 }">
                <label style="font-size: large">普通用户</label>
            </c:if>
            <c:if test="${user.level ==4 }">
            <label style="font-size: large">高级会员</label>
        </c:if>
        </div>


        <div class="form-group">
            <div align="center">
                <button type="button" onclick="javascript:history.back(-1);" id="back" class="btn btn-primary">返回</button>
            </div>
        </div>
    </div>
</form>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="${pageContext.request.contextPath}/text/javascript" src="js/bootstrap-table.min.js"></script>
<script src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrapValidator.min.js" type="text/javascript"></script>

