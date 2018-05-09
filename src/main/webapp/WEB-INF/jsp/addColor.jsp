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

<form action="addColor" method="post">
    <div class="container" style="width: 35%">
        <h2><strong>新增颜色</strong></h2>

        <div class="form-group">
            <label>颜色名称</label>
            <input type="text" class="form-control" name="color" />
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
        src="${pageContext.request.contextPath }/css/bootstrap/js/bootstrap-table.js"
        type="text/javascript"></script>
<script
        src="${pageContext.request.contextPath }/css/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
<script
        src="${pageContext.request.contextPath }/css/bootstrap/js/bootstrap-dialog.min.js"
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
        location.href="${pageContext.request.contextPath}/colorManager";
    });
</script>
