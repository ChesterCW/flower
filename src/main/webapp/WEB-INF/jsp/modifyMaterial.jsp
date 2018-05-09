<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <link href="${pageContext.request.contextPath}/css/bootstrap/fonts/font-awesome.min.css" rel="stylesheet"/>
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/simple-line-icons/2.4.1/css/simple-line-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap-table.min.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap-dialog.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrapValidator.min.css">

    <title>修改商品</title>
</head>

<style>
    .control-label{
        width: 100px;
        height: 50px;
    }
</style>


<form action="${pageContext.request.contextPath}/modifyMaterial" method="post">
    <div class="container" style="width: 35%">
        <h2><strong>修改信息</strong></h2>
        <div class="form-group">
            <input type="hidden" name="id" value="${material.id}">
            <label>材料名称</label>
            <input type="text" class="form-control" name="name" value="${material.name}" />
        </div>
        <div class="form-group">
            <label>数量</label>
            <input type="text" class="form-control" name="count" value="${material.count}" />
        </div>
        <div class="form-group">
            <label>市场价格</label>
            <input type="text" class="form-control" name="marketprice" value="${material.marketprice}" />
        </div>
        <div class="form-group">
            <label>会员价格</label>
            <input type="text" class="form-control" name="vipprice" value="${material.vipprice}" />
        </div>
        <div class="form-group">
            <label>材料描述</label>
            <textarea rows="10" cols="79%" id="description" name="description">${material.description}</textarea>
        </div>
        <div class="dropdown" style="padding-left: 70px">
            <input type="hidden" value="${material.kindId}" id="kindId">
            <input type="hidden" value="${material.colorId}" id="colorId">

            <label>材料种类:</label>
            <select name="kindId">
                <option value="0">请选择</option>
            </select>
            <label>材料颜色:</label>
            <select name="colorId">
                <option value="0">请选择</option>
            </select>

        </div>

        <div class="form-group">
            <div align="center">
                <button type="button" id="back" class="btn btn-primary" onclick="javascript:history.back(-1);">返回</button>
                <button type="submit" name="submit" onclick="" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</form>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="${pageContext.request.contextPath}/text/javascript" src="js/bootstrap-table.min.js"></script>
<script src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrapValidator.min.js" type="text/javascript"></script>
<script>

    //查询全部用途
    $(function () {
        //清空
        var kindId = $("#kindId").val();
        var colorId = $("#colorId").val();
        //加载材料种类
        $.ajax({
            url:'${pageContext.request.contextPath}/loadKind',
            async:false,
            type:"post",
            success:function(data){
                var option;
                $.each(data, function(idx, obj) {
                    option = $("<option value="+obj.id+">"+obj.name+"</option>");
                    $("[name='kindId']").append(option);
                });
                $("[name='kindId']").val(kindId);
            }
        });
        //加载颜色种类
        $.ajax({
            url:'${pageContext.request.contextPath}/loadColor',
            async:false,
            type:"post",
            success:function(data){
                var option;
                $.each(data, function(idx, obj) {
                    option = $("<option value="+obj.id+">"+obj.color+"</option>");
                    $("[name='colorId']").append(option);
                });
                $("[name='colorId']").val(colorId);
            }
        });
    });
</script>