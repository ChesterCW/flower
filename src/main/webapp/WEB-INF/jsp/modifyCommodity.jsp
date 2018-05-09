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


<form action="${pageContext.request.contextPath}/modifyCommodity" method="post">
    <div class="container" style="width: 35%">
        <h2><strong>修改信息</strong></h2>
        <div class="form-group">
            <input type="hidden" name="id" value="${commodity.id}">
            <label>标题</label>
            <input type="text" class="form-control" name="title" value="${commodity.title}" />
        </div>
        <div class="form-group">
            <label>花语</label>
            <input type="text" class="form-control" name="wishes" value="${commodity.wishes}" />
        </div>
        <div class="form-group">
            <label>市场价格</label>
            <input type="text" class="form-control" name="marketprice" value="${commodity.marketprice}" />
        </div>
        <div class="form-group">
            <label>会员价格</label>
            <input type="text" class="form-control" name="vipprice" value="${commodity.vipprice}" />
        </div>
        <div class="form-group">
            <label>商品数量</label>
            <input type="text" class="form-control" name="count"value="${commodity.count}" />
        </div>
        <div class="form-group">
            <label>附送</label>
            <input type="text" class="form-control" name="attache" value="${commodity.attache}" />
        </div>

        <div class="panel panel-default">
            <div class="panel-heading"><label>商品用途</label></div>
            <div class="panel-body" id="commUse">
                <c:forEach var="item" items="${useList}">
                    <p class="text-info">${item.title}</p>
                    <input type="hidden" name="commUse" value="${item.id}"/>
                </c:forEach>
            </div>
        </div>
        <div class="form-group">
            <label><a onclick="searchUse()">添加用途</a></label>
            <label><a onclick="hiddenUse()">隐藏用途</a></label>
        </div>

        <div id='addUse'>

        </div>
        <div class="form-group">
            <label>商品描述</label>
            <textarea rows="10" cols="79%" id="description" name="description">${commodity.description}</textarea>
        </div>
        <div class="dropdown" style="padding-left: 70px">
            <input type="hidden" value="${commodity.kindId}" id="kindId">
            <input type="hidden" value="${commodity.cateId}" id="cateId">
            <input type="hidden" value="${commodity.mateId}" id="mateId">

            <label>鲜花种类:</label>
            <select name="kindId">
                <option value="0">请选择</option>
            </select>
            <label>鲜花类别:</label>
            <select name="cateId">
                <option value="0">请选择</option>
            </select>
            <label>商品材料:</label>
            <select name="mateId">
                <option value="0">请选择</option>
            </select>

        </div>

        <div class="form-group">
            <div align="center">
                <button type="button" id="back" class="btn btn-primary" onclick="">返回</button>
                <button type="submit" name="submit" class="btn btn-primary">提交</button>
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
    function searchUse() {
        var child = "<div class='panel panel-default'>" +
            "</div><div class='panel panel-default'><div class='panel-heading'><label>商品用途</label>" +
            "</div><div class='panel-body' id='useList'></div>";
        $("#addUse").empty();
        $("#addUse").append(child);
        $.ajax({
            url:'${pageContext.request.contextPath}/searchUse',
            async:false,
            success:function (data) {
                var p,input;
                $.each(data, function(idx, obj) {
                    p = $("<p class='text-info'>"+obj.title+"</p>");
                    input = $('<input type="hidden" value="'+obj.id+'"/>');
                    $("#useList").append(p);
                    $("#useList").append(input);
                });
            }
        });
        $(function () {
            //点击用途添加进入商品用途
            $("#useList > p").each(function(idx,obj){
                $(this).click(function () {
                    var p,input,pValue,value,flag=1;
                    value = $(this).text();
                    var id = $(this).next('input').val();
                    p = $("<p class='text-info'>"+value+"</p>");
                    input = $('<input type="hidden" name="commUse" value="'+id+'"/>');

                    $('#commUse > p').each(function (idx,obj) {
                        pValue = $(this).text();
                        // 迭代已有的用途，如果与当前选中的相同，改变flag的值
                        if(value == pValue) {
                            flag=0;
                            return;
                        }
                    });
                    //如果flag=0，该用途已经存在，不添加
                    if(flag == 0){return;}
                    $("#commUse").append(p);
                    $("#commUse").append(input);
                })
            });
        });
    }
    //移除
    $("#commUse").click(function () {

        $('#commUse > p').each(function (idx,obj) {
            $(this).click(function () {
                $(this).next('input').remove();
                $(this).remove();
            });
        });
    });
    //隐藏用途
    function hiddenUse() {
        $("#addUse").empty();
    }


    //查询全部用途
    $(function () {
        //清空
        var kindId = $("#kindId").val();
        var cateId = $("#cateId").val();
        $("#back").click(function () {
            location.href="javascript:history.go(-1)";
        });

        //加载商品种类
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
                loadCateId(kindId)
                loadMateId(kindId)
            }
        });
    });

    //根据种类生成类别
    $(function () {
        $("[name='kindId']").change(function (){
            $("[name='cateId']").empty();
            $("[name='mateId']").empty();
            var kindId = $("[name='kindId']").val();
            $.ajax({
                url:'${pageContext.request.contextPath}/loadCates/'+kindId,
                async:false,
                success:function(data) {
                    var option;
                    $.each(data, function(idx, obj) {
                        option = $("<option value="+obj.id+">"+obj.name+"</option>");
                        $("[name='cateId']").append(option);
                    });
                }});
            $.ajax({
                url:'${pageContext.request.contextPath}/loadMates/'+kindId,
                async:false,
                success:function(data) {
                    var option;
                    $.each(data, function(idx, obj) {
                        option = $("<option value="+obj.id+">"+obj.name+"</option>");
                        $("[name='mateId']").append(option);
                    });
                }});
        })
    })

    function loadCateId(kindId) {
        var cateId = $("#cateId").val();
        $.ajax({
            url:'${pageContext.request.contextPath}/loadCates/'+kindId,
            async:false,
            success:function(data) {
                var option;
                $.each(data, function(idx, obj) {
                    option = $("<option value="+obj.id+">"+obj.name+"</option>");
                    $("[name='cateId']").append(option);
                });
            }});
        $("[name='cateId']").val(cateId);
    }
    function loadMateId(kindId) {
        var mateId = $("#mateId").val();
        $.ajax({
            url:'${pageContext.request.contextPath}/loadMates/'+kindId,
            async:false,
            success:function(data) {
                var option;
                $.each(data, function(idx, obj) {
                    option = $("<option value="+obj.id+">"+obj.name+"</option>");
                    $("[name='mateId']").append(option);
                });
            }});
        $("[name='mateId']").val(mateId);
    }

</script>


<%-- $.post('${pageContext.request.contextPath}/loadKindId',function (data) {
            var option;
            $.each(data, function(idx, obj) {
                option = $("<option value="+obj.id+">"+obj.name+"</option>");
                $("[name='kindId']").append(option);
            });
            $("[name='kindId']").val(kindId);
            loadCateId(kindId)
        });


         //根据种类生成类别
        $(function () {
            $("[name='kindId']").change(function (){
                $("[name='cateId']").empty();
                $("[name='mateId']").empty();
                var kindId = $("[name='kindId']").val();
                $.get('${pageContext.request.contextPath}/loadCates/'+kindId,function (data) {
                    var option;
                    $.each(data.cate, function(idx, obj) {
                        option = $("<option value="+obj.id+">"+obj.name+"</option>");
                        $("[name='cateId']").append(option);
                    });
                    $.each(data.mate, function(idx, obj) {
                        option = $("<option value="+obj.id+">"+obj.name+"</option>");
                        $("[name='mateId']").append(option);
                    });
                });
            })
        }) --%>
