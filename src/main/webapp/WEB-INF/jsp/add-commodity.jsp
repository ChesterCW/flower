<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrapValidator.min.css">

    <title>新增商品</title>
</head>

<style>
    .control-label{
        width: 100px;
        height: 50px;
    }
</style>


<form action="${pageContext.request.contextPath}/addCommodity" method="post">
    <div class="container" style="width: 35%">
        <h2><strong>添加鲜花</strong></h2>

        <c:forEach items="${fileUrlList}" var="fileUrl" varStatus="status">
            <input type="hidden" name="images" value="${basePath }${fileUrl }">
        </c:forEach>

        <div class="form-group">
            <label>标题</label>
            <input type="text" class="form-control" name="title"/>
        </div>
        <div class="form-group">
            <label>花语</label>
            <input type="text" class="form-control" name="wishes" />
        </div>
        <div class="form-group">
            <label>市场价格</label>
            <input type="text" class="form-control" name="marketprice"/>
        </div>
        <div class="form-group">
            <label>会员价格</label>
            <input type="text" class="form-control" name="vipprice" />
        </div>
        <div class="form-group">
            <label>商品数量</label>
            <input type="text" class="form-control" name="count"/>
        </div>
        <div class="form-group">
            <label>附送</label>
            <input type="text" class="form-control" name="attache" />
        </div>
        <div class="panel panel-default">
            <div class="panel-heading"><label>商品用途</label></div>
            <div class="panel-body" id="commUse">
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

    </div>

    <div class="form-group">
        <div align="center">
            <button type="button" id="back" onclick="javascript:history.back(-1);" class="btn btn-primary">返回</button>
            <button type="submit" name="submit" class="btn btn-primary">提交</button>
        </div>
    </div>
</form>

<form enctype="multipart/form-data" method="post"  action="upload" >
    <div class="form-group">
        <div align="center">
            <input type="file" class="btn btn-default" name="file" multiple="multiple" value="上传图片"/>
            <c:forEach items="${fileUrlList}" var="fileUrl" varStatus="status">
                <img class="img-responsive" alt="" src="${pageContext.request.contextPath}/${basePath }${fileUrl }" />
                <input type="hidden" name="images" value="${basePath }${fileUrl }">
            </c:forEach>
            <input type="submit" value="上传"/>
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


    $(function () {
        //清空
        var kindId = $("#kindId").val();

        //加载商品种类
        $.post('${pageContext.request.contextPath}/loadKind',function (data) {
            var option;
            $.each(data, function(idx, obj) {
                option = $("<option value="+obj.id+">"+obj.name+"</option>");
                $("[name='kindId']").append(option);
            });
            $("[name='kindId']").val(kindId);
            loadCateId(kindId)
        });
    });
    //
    // //表单非空验证
    // $('form').bootstrapValidator({
    //     message: 'This value is not valid',
    //     feedbackIcons: {
    //         valid: 'glyphicon glyphicon-ok',
    //         invalid: 'glyphicon glyphicon-remove',
    //         validating: 'glyphicon glyphicon-refresh'
    //     },
    //     fields: {
    //         title: {
    //             validators: {
    //                 notEmpty: {
    //                     message: '标题不能为空'
    //                 }
    //             }
    //         },
    //         marketprice: {
    //             validators: {
    //                 notEmpty: {
    //                     message: '价格不能为空'
    //                 }
    //             }
    //         },
    //         vipprice: {
    //             validators: {
    //                 notEmpty: {
    //                     message: '价格不能为空'
    //                 }
    //             }
    //         },
    //         count: {
    //             validators: {
    //                 notEmpty: {
    //                     message: '数量不能为空'
    //                 }
    //             }
    //         },
    //         attache: {
    //             validators: {
    //                 notEmpty: {
    //                     message: '附送不能为空'
    //                 }
    //             }
    //         }
    //     }
    // });
</script>

<script>
    UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
    UE.Editor.prototype.getActionUrl = function(action) {
        if (action == 'uploadimage') {
            return 'http://localhost:8081/flower/file/upload';
        }else {
            return this._bkGetActionUrl.call(this, action);
        }
    }
</script>