<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/simple-line-icons/2.4.1/css/simple-line-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrapValidator.min.css">

    <title>用户信息</title>
</head>

<style>
    .control-label{
        width: 100px;
        height: 50px;
    }
</style>


<form action="${pageContext.request.contextPath}/modifyUser" method="post">
    <div class="container" style="width: 35%">
        <h2 style="padding-bottom: 5%"><strong>用户信息</strong></h2>
        <div class="form-group">
            <input type="hidden" name="id" value="${user.id}">
            <input type="hidden" name="password" value="${user.password}">
            <label>用户名:</label>
            <input type="text" class="form-control" name="username" value="${user.username}" />
        </div>
        <div class="form-group">
            <label>邮箱:</label>
            <input type="text" class="form-control" name="email" value="${user.email}" />
        </div>
        <div class="form-group">
            <label>电话:</label>
            <input type="text" class="form-control" name="phone" value="${user.phone}" />
        </div>
        <div class="form-group">
            <label>性别:</label>
            <div class="form-group">
                <c:if test="${user.gender ==1 }">
                    <input type="radio" checked="checked" name="gender" value="1"/>男
                    <input type="radio" name="gender" value="2"/>女
                </c:if>
                <c:if test="${user.gender ==2 }">
                    <input type="radio" name="gender" value="1"/>男
                    <input type="radio" checked="checked" name="gender" value="2"/>女
                </c:if>
            </div>
        </div>
        <div class="form-group">
            <label>用户类型:</label>
            <div class="form-group">
                <c:if test="${user.level ==2 }">
                    <input type="radio" checked="checked" name="level" value="2"/>管理员
                    <input type="radio" name="level" value="3"/>普通会员
                    <input type="radio" name="level" value="4"/>高级会员
                </c:if>
                <c:if test="${user.level ==3 }">
                    <input type="radio" name="level" value="2"/>管理员
                    <input type="radio" checked="checked" name="level" value="3"/>普通会员
                    <input type="radio" name="level" value="4"/>高级会员
                </c:if>
                <c:if test="${user.level ==4 }">
                    <input type="radio" name="level" value="2"/>管理员
                    <input type="radio" name="level" value="3"/>普通会员
                    <input type="radio" checked="checked" name="level" value="4"/>高级会员
                </c:if>
            </div>
        </div>


        <div class="form-group">
            <div align="center">
                <button type="button" onclick="javascript:history.back(-1);" id="back" class="btn btn-primary">返回</button>
                <button type="submit" name="submit" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</form>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="${pageContext.request.contextPath}/text/javascript" src="js/bootstrap-table.min.js"></script>
<script src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrapValidator.min.js" type="text/javascript"></script>

