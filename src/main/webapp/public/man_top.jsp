<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Frame top</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
   	 <%--function logOut(){--%>
		<%--if(confirm("確定退出?")){--%>
			<%--top.location.href="${pageContext.request.contextPath }/manager/logOut.action";--%>
		<%--}else{--%>
			<%--return;--%>
		<%--}--%>
	<%--}--%>
     //退出登录
     function logOut() {
		 if (confirm("确定退出？")){
			 $.ajax({
				 url:"${pageContext.request.contextPath}/logOut",
				 type:"post",
				 success:function (data) {
					 if (data == "success"){
					     alert("退出成功")
                         parent.location.reload();
					 }
				 }
			 })
		 }
     }
    </script>
    
	<style type="text/css">
body {
margin: 0;
}
#Head_1 {
    height: 64px;
    margin: 0 auto;
    width: 100%;
}
#Head_1 #Head_1_Logo {
	float: left;
    left: 20px;
    position: absolute;
    top: 12px;
	color: #F1F9FE;
    font-family: Arial Black,Arial;
    font-size: 28px;
}
#Head_1 #Head_1_UserWelcome {
    float: right;
    color: #B3E1FF;
    font-family: "宋体";
    font-size: 12px;
    height: 25px;
	padding-top: 11px;
	margin-right: 20px;
}
#Head_1 #Head_1_FunctionButton {
    float: left;
    position: absolute;
    right: 5px;
    top: 35px;
	margin-right: 15px;
}
#Head_1 #Head_1_FunctionButton img {
margin-left: 10px;
}
#Head_2 {
    border-bottom: 1px solid #FFFFFF;
    border-top: 1px solid #A0C6E1;
    height: 36px;
    margin: 0;
    width: 100%;
}
#Head_2 #Head2_Awoke {
	float: left;
    height: 100%;
    padding-left: 19px;
    padding-top: 2px;
}
#Head_2 #Head2_Awoke #AwokeNum {
	position: absolute;
	left: 20px;
	top: 68px;	
	width: 406px;
	/*height: 21px;*/
	margin-top: 0;
	padding: 0;
	padding-top: 2px;
	list-style-type: none;
	margin-bottom: 0;
	margin-left: 0;
}
#Head_2 #Head2_Awoke #AwokeNum li {
  float: left;
    margin: 3px;
	display: inline;
}
#Head_2 #Head2_Awoke #AwokeNum a {
   color: #FFFFFF;
    font-family: "宋体";
    font-size: 12px;
    text-decoration: none;
}
#Head_2 #Head2_Awoke #AwokeNum .Line {
    border-left: 1px solid #005A98;
    border-right: 1px solid #A0C6E1;
    height: 17px;
    width: 0px;
}
#Head_2 #Head2_FunctionList, .Head2_FunctionList {
    color: #FFFFFF;
    float: right;
    font-family: "宋体";
    font-size: 13px;
    height: 100%;
    padding-right: 26px;
    padding-top: 10px;
}

	</style>
</head>

<body>
 	
	<!-- 上部 -->
	<div id="Head_1">
		<!-- 标题 -->
		<div id="Head_1_Logo">
			<span><img src="" style="width: 50px; height: 50;"/></span>
			<span><b style="font-family: '黑体';color: black;">鲜花商城后台管理系统</b> </span>
			
		</div>
		<!-- 欢迎用户的文字 -->
		<div id="Head_1_UserWelcome">
			<%-- <img border="0" width="13" height="14" src="${pageContext.request.contextPath}/style/images/user.gif" /> <!--  --> --%>
			您好，<b>管理员&nbsp;${sessionScope.managerInfo.manName }</b>
		</div>
		<!-- 一些链接按钮 -->
		<div id="Head_1_FunctionButton">
			<a href="javascript:logOut()" target="_parent">退出系统</a>
		</div>
	</div>
	<!-- 下部 -->
    <div id="Head_2">
		<!-- 任务提醒 -->
        <div id="Head2_Awoke">
			<ul id="AwokeNum">
				
            </ul>
		</div>
		
		<div class="Head2_FunctionList" style="float:left">
			<a href="javascript: window.parent.right.history.back();">
				<!-- <img src="" width="24" height="24" style="margin-top: -8px;"/> -->
				<b style="font-size: 14px; text-decoration: none;">后退</b>
			</a>
			
        </div>
	</div>
</body>
</html>