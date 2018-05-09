<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link
            href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css"
            rel="stylesheet">
    <link
            href="https://cdn.bootcss.com/simple-line-icons/2.4.1/css/simple-line-icons.css"
            rel="stylesheet">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath }/css/bootstrap/css/bootstrap-table.min.css"
          type="text/css" />
    <link rel="stylesheet"
          href="${pageContext.request.contextPath }/css/bootstrap/css/bootstrap.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath }/css/bootstrap/css/bootstrap-dialog.css">
    <title>Title</title>
</head>
<body>

<form action="${pageContext.request.contextPath}/modifyCategory" method="post">
    <div class="container" style="width: 35%">
        <h2><strong>修改类别</strong></h2>

        <div class="dropdown">
            <input type="hidden" id="kindId" name="kindId" value="${category.kindId}">
            <input type="hidden" id="id" name="id" value="${category.id}">
            <label>鲜花种类:</label>
            <select name="kind" disabled="disabled">
                <option value="0">请选择</option>
            </select>
        </div>

        <div class="form-group">
            <label>类别名称</label>
            <input type="text" class="form-control" name="name" value="${category.name}" />
        </div>

        <div class="form-group">
            <div align="center">
                <button type="reset" id="back" class="btn btn-primary">返回</button>
                <button type="submit" name="submit" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</form>

</body>
</html>
<script src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js"
        type="text/javascript"></script>
<script
        src="${pageContext.request.contextPath }/js/moment-with-locales.js"
        type="text/javascript"></script>
<script>
    moment.locale();
</script>
<script>
    //返回
    $("#back").click(function () {
        location.href="${pageContext.request.contextPath}/categoryManager";
    });
    $(function () {
        var kindId = $("#kindId").val();
        //加载商品种类
        $.post('${pageContext.request.contextPath}/loadKind',function (data) {
            var option;
            $.each(data, function(idx, obj) {
                option = $("<option value="+obj.id+">"+obj.name+"</option>");
                $("[name='kind']").append(option);
            });
            $("[name='kind']").val(kindId);
        });
    })
</script>
