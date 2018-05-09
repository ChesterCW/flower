<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<table class="table table-hover" id="cusTable"
       data-pagination="true"
       data-show-refresh="true"
       data-show-toggle="true"
       data-showColumns="true"
       data-url="commodityList">
    <thead>
    <tbody>



    <div class="container-fluid" align="center">
        <div class="row-fluid">
            <div class="span12">
                <%--<form class="form-search" action="" onsubmit="" method="get">--%>
                <%--<input class="input-medium search-query" type="text" id="title" name="title" placeholder="标题或编号搜索" />--%>
                <%--<button id="search" onclick="searchTitle()" class="btn btn-primary">搜索</button>--%>
                <select name="kindId">
                    <option value="0">请选择..</option>
                </select>
                <button class="btn btn-primary" type="button" onclick="addItems()">添加</button>
                <button class="btn btn-primary" type="button" onclick="deleteItems()">删除</button>
                <%--</form>--%>
            </div>
        </div>
    </div>
    </tbody>
</table>

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

    //加载商品种类
    $.post('loadKind',function (data) {
        var option;
        $.each(data, function(idx, obj) {
            option = $("<option value="+obj.id+">"+obj.name+"</option>");
            $("[name='kindId']").append(option);
        });
    });
    //根据种类生成类别
    $("[name='kindId']").change(function () {
        var kindId = $("[name='kindId']").val();
        //先销毁表格
        $('#cusTable').bootstrapTable('destroy');
        $('#cusTable').bootstrapTable({
            method: 'get',
            sortable: true,
            silentSort:true,
            url: 'loadCates/'+kindId,
            contentType: "application/x-www-form-urlencoded",//必须要有！！！！
            //queryParams: queryParams,//请求服务器时所传的参数
            striped: true, //是否显示行间隔色
            search: true,  //是否启用查询
            maintainSelected: true,
            clickToSelect: true,
            columns: [{
                field: 'check',
                checkbox:'true'
            }, {
                field: 'id',
                title: '类别编号',
                sortable: true,
            }, {
                field:'name',
                title:'类别名称',
            },{
                field: 'status',
                title: '类别状态',
                formatter:function (value,row,index) {
                    if(row.status==1){
                        return '正常';
                    }
                }
            },{
                field: "id",
                title: "操作",
                formatter: function (value, row, index) {
                    return ["<a class='btn btn-default' href='modifyCategory/" + row.id + "'>编辑</a>",
                        "<a class='btn btn-default' onclick='deleteOne(" + row.id + ")'>删除</a>"].join(" ");
                },
                align: "center"
            }]
        });
    });
    //添加页面
    function addItems() {
        location.href="addCategory";
    }
    //批量删除
    function deleteItems() {
        var ids = [];
        if($('#cusTable').bootstrapTable('getSelections').length<1){
            BootstrapDialog.show({
                title:'警告',
                message:'请选择要删除的记录',
                buttons:[{label:'关闭',cssClass : "btn-primary", action : function(dialog){   //给当前按钮添加点击事件
                        dialog.close();
                    }}]
            });
            return;

        }else {
            //获取选中的记录的ID
            for (var i =0;i<$('#cusTable').bootstrapTable('getSelections').length;i++){
                ids[i] = $('#cusTable').bootstrapTable('getSelections')[i].id;
            }
            BootstrapDialog.show({
                title:'确认',
                message:'是否要删除所选数据',
                buttons:[{label:'关闭',cssClass : "btn-primary", action : function(dialog){   //给当前按钮添加点击事件
                        dialog.close();
                    }},{label:'确认',cssClass : "btn-primary",action:function (dialog) {
                        dialog.close();
                        $.post('deleteCategory',{'ids':ids},function (data) {
                            alert("删除了"+data+"条记录");
                            $('#cusTable').bootstrapTable('refresh');
                        })
                    }}
                ]
            });
        }
    }
    //删除单条记录
    function deleteOne(row) {
        var ids = [];
        ids[0] = row;
        BootstrapDialog.show({
            title:'确认',
            message:'是否要删除所选数据',
            buttons:[{label:'关闭',cssClass : "btn-primary", action : function(dialog){   //给当前按钮添加点击事件
                    dialog.close();
                }},{label:'确认',cssClass : "btn-primary",action:function (dialog) {
                    dialog.close();
                    $.post('deleteCategory',{'ids':ids},function (data) {
                        alert("删除了"+data+"条记录");
                        $('#cusTable').bootstrapTable('refresh');
                    })
                }}
            ]
        });
    }
</script>
<script>

</script>
