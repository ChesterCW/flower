<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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

<table class="table table-hover" id="cusTable" data-pagination="true"
       data-show-refresh="true" data-show-toggle="true"
       data-showColumns="true" data-url="commodityList">
    <thead>
    </thead>
    <tbody>

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
    //添加页面
    function addItems() {
        location.href="addUser";
    }
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
                        $.post('batchUpdateUser',{'ids':ids},function (data) {
                            alert("删除成功");
                            location.href = "managerUser";
                        })
                    }}
                ]
            });


        }
    }
    $(function () {
        //先销毁表格
        $('#cusTable').bootstrapTable('destroy');
        $('#cusTable').bootstrapTable({
            method: 'get',
            sortable: true,
            silentSort:true,
            url: '${pageContext.request.contextPath}/backOrderList',
            striped: true,
            contentType: "application/x-www-form-urlencoded",//必须要有！！！！
            queryParams: queryParams,//请求服务器时所传的参数
            striped: true, //是否显示行间隔色
            dataField: "rows",//bootstrap table 可以前端分页也可以后端分页，这里
            //我们使用的是后端分页，后端分页时需返回含有total：总记录数,这个键值好像是固定的
            //rows： 记录集合 键值可以修改  dataField 自己定义成自己想要的就好
            pageNumber: 1, //初始化加载第一页，默认第一页
            pagination: true,//是否分页
            queryParamsType: 'limit',//查询参数组织方式
            sidePagination: 'server',//指定服务器端分页
            pageSize: 10,//单页记录数
            search: true,  //是否启用查询
            //searchOnEnterKey: true,
            smartDisplay: false,
            paginationPreText: "上一页",
            paginationNextText: "下一页",
            toolbar: "#toolbar",
            maintainSelected: true,
            showPaginationSwitch:true,//
            clickToSelect: true,
            pageList: [5, 10, 20, 30],//分页步
            columns: [{
                field: 'check',
                checkbox:'true'
            }, {
                field: 'id',
                title: '订单编号',
                sortable: true,

            }, {
                field: 'createTime',
                title: '下单时间',
                width: '10%',
                formatter:function (value,row,index) {
                    return timeStampExchange(row.createTime);
                }
            }, {
                field: 'payment',
                title: '订单总额',
                formatter:function (value,row,index) {
                    return FormatMoney(row.payment);
                }
            },{
                field: 'orderStatus',
                title: '订单状态',
                formatter:function (value,row,index) {
                    if(row.orderStatus==1){
                        return '未付款';
                    }else if(row.orderStatus==2){
                        return '未发货';
                    }else if(row.orderStatus==4){
                        return '已发货';
                    }else if(row.orderStatus==6){
                        return '已取消';
                    }
                }
            },{
                field: "id",
                title: "操作",
                formatter: function (value, row, index) {
                    if (row.orderStatus==2){
                        return ["<a class='btn btn-default' href='${pageContext.request.contextPath}/backOrderDetail/" + row.id + "'>查看</a>",
                            "<a class='btn btn-default' onclick='send(" + row.id + ")'>发货</a>"].join(" ");
                    }
                    return ["<a class='btn btn-default' href='${pageContext.request.contextPath}/backOrderDetail/" + row.id + "'>查看</a>"].join(" ");
                },
                align: "center"
            }

            ]


        });
    });

    //发货
    function send(id) {
        var r = confirm("确认发货?");
        if (r){
            //加载用户购买的商品
            $.ajax({
                url:"${pageContext.request.contextPath}/modifyOrder/"+id,
                type:"post",
                data:{"orderStatus":4},
                async:false,
                success:function (data) {
                    alert("发货成功");
                    location.href = "${pageContext.request.contextPath}/managerOrder";
                }
            })
        }
    }

    //价格格式化
    function FormatMoney(s) {
        if (/[^0-9\.]/.test(s)) return "invalid value";
        s = s.replace(/^(\d*)$/, "$1.");
        s = (s + "00").replace(/(\d*\.\d\d)\d*/, "$1");
        s = s.replace(".", ",");
        var re = /(\d)(\d{3},)/;
        while (re.test(s))
            s = s.replace(re, "$1,$2");
        s = s.replace(/,(\d\d)$/, ".$1");
        return "￥" + s.replace(/^\./, "0.")
    }
    //删除
    function EditViewById(id, view) {
        location.href=view+"/"+id;
    }
    function queryParams(params) {
        return {
            page: (params.offset / params.limit) + 1,
            row: params.limit,
            sort: params.sort,
            order: params.order,
            id:params.search,
        };

    }
    // function deleteOne(row) {
    //     var ids = [];
    //     ids[0] = row;
    //
    //     BootstrapDialog.show({
    //         title:'确认',
    //         message:'是否要删除所选数据',
    //         buttons:[{label:'关闭',cssClass : "btn-primary", action : function(dialog){   //给当前按钮添加点击事件
    //                 dialog.close();
    //             }},{label:'确认',cssClass : "btn-primary",action:function (dialog) {
    //                 dialog.close();
    //                 $.post('batchUpdateUser',{'ids':ids},function (data) {
    //                     alert("删除成功");
    //                     location.href = "managerUser";
    //                 })
    //             }}
    //         ]
    //     });
    // }
    //时间格式化,将返回的时间戳转换为正常时间
    function timeStampExchange(time) {
        var datetime = new Date();
        datetime.setTime(time);
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1 < 10 ? "0"
            + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
        var date = datetime.getDate() < 10 ? "0" + datetime.getDate()
            : datetime.getDate();
        var hour = datetime.getHours() < 10 ? "0" + datetime.getHours()
            : datetime.getHours();
        var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes()
            : datetime.getMinutes();
        var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds()
            : datetime.getSeconds();
        return year + "-" + month + "-" + date + " " + hour + ":" + minute
            + ":" + second;
    }
</script>
<script>

</script>
