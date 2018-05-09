<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Frame left</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${pageContext.request.contextPath }/css/bootstrap/css/bootstrap.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/css/style.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/css/mainLeft.css" rel="stylesheet" />

<script src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js"></script>

</head>

<body id="bg">

	<div class="container">

		<div class="leftsidebar_box">
			<div class="line"></div>
			<dl class="system_log">
				<dt>
					商品管理
				</dt>
				<dd class="first_dd">
					<a href="${pageContext.request.contextPath }/managerCommodity" target="right">商品列表</a>
				</dd>
				<dd>
					<a href="${pageContext.request.contextPath }/kindManager" target="right">种类管理</a>
				</dd>
				<dd>
					<a href="${pageContext.request.contextPath }/materialsManager" target="right">材料管理</a>
				</dd>
				<dd>
					<a href="${pageContext.request.contextPath }/useManager" target="right">用途管理</a>
				</dd>
				<dd>
					<a href="${pageContext.request.contextPath }/categoryManager" target="right">类别管理</a>
				</dd>
				<dd>
					<a href="${pageContext.request.contextPath }/colorManager" target="right">颜色管理</a>
				</dd>
			</dl>

			<dl class="custom">
				<dt>
					用户管理
				</dt>
				<dd>
					<a href="${pageContext.request.contextPath }/managerUser" target="right">用户列表</a>
				</dd>
				<dd>
					<a href="${pageContext.request.contextPath }/managerComment" target="right">评论列表</a>
				</dd>
			</dl>

			<dl class="channel">
				<dt>
					订单管理
				</dt>
				<dd class="first_dd" target="right">
					<a href="${pageContext.request.contextPath }/managerOrder" target="right">订单列表</a>
				</dd>
			</dl>

			<%--<dl class="app">--%>
				<%--<dt onClick="changeImage()">--%>
					<%--APP管理--%>
				<%--</dt>--%>
				<%--<dd class="first_dd">--%>
					<%--<a href="#" target="right">App运营商管理</a>--%>
				<%--</dd>--%>
				<%--<dd>--%>
					<%--<a href="#" target="right">开放接口管理</a>--%>
				<%--</dd>--%>
				<%--<dd>--%>
					<%--<a href="#" target="right">接口类型管理</a>--%>
				<%--</dd>--%>
			<%--</dl>--%>

			<%--<dl class="cloud">--%>
				<%--<dt>--%>
					<%--大数据云平台--%>
				<%--</dt>--%>
				<%--<dd class="first_dd">--%>
					<%--<a href="#" target="right">平台运营商管理</a>--%>
				<%--</dd>--%>
			<%--</dl>--%>

			<%--<dl class="syetem_management">--%>
				<%--<dt>--%>
					<%--系统管理--%>
				<%--</dt>--%>
				<%--<dd class="first_dd">--%>
					<%--<a href="#" target="right">后台用户管理</a>--%>
				<%--</dd>--%>
				<%--<dd>--%>
					<%--<a href="#" target="right">角色管理</a>--%>
				<%--</dd>--%>
				<%--<dd>--%>
					<%--<a href="#" target="right">客户类型管理</a>--%>
				<%--</dd>--%>
				<%--<dd>--%>
					<%--<a href="#" target="right">栏目管理</a>--%>
				<%--</dd>--%>
				<%--<dd>--%>
					<%--<a href="#" target="right">微官网模板组管理</a>--%>
				<%--</dd>--%>
				<%--<dd>--%>
					<%--<a href="#" target="right">商城模板管理</a>--%>
				<%--</dd>--%>
				<%--<dd>--%>
					<%--<a href="#" target="right">微功能管理</a>--%>
				<%--</dd>--%>
				<%--<dd>--%>
					<%--<a href="#" target="right">修改用户密码</a>--%>
				<%--</dd>--%>
			<%--</dl>--%>

			<%--<dl class="source">--%>
				<%--<dt>--%>
					<%--素材库管理--%>
				<%--</dt>--%>
				<%--<dd class="first_dd">--%>
					<%--<a href="#" target="right">图片库</a>--%>
				<%--</dd>--%>
				<%--<dd>--%>
					<%--<a href="#" target="right">链接库</a>--%>
				<%--</dd>--%>
				<%--<dd>--%>
					<%--<a href="#" target="right">推广管理</a>--%>
				<%--</dd>--%>
			<%--</dl>--%>

			<%--<dl class="statistics">--%>
				<%--<dt>--%>
					<%--统计分析--%>
				<%--</dt>--%>
				<%--<dd class="first_dd">--%>
					<%--<a href="#" target="right">客户统计</a>--%>
				<%--</dd>--%>
			<%--</dl>--%>

		</div>

	</div>

	<script src="http://www.jq22.com/jquery/1.11.1/jquery.min.js"></script>
	<script type="text/javascript">
$(".leftsidebar_box dt").css({"background-color":"#3992d0"});
$(".leftsidebar_box dt img").attr("src","images/left/select_xl01.png");
$(function(){
	$(".leftsidebar_box dd").hide();
	$(".leftsidebar_box dt").click(function(){
		$(".leftsidebar_box dt").css({"background-color":"#3992d0"})
		$(this).css({"background-color": "#317eb4"});
		$(this).parent().find('dd').removeClass("menu_chioce");
		$(".leftsidebar_box dt img").attr("src","images/left/select_xl01.png");
		$(this).parent().find('img').attr("src","images/left/select_xl.png");
		$(".menu_chioce").slideUp(); 
		$(this).parent().find('dd').slideToggle();
		$(this).parent().find('dd').addClass("menu_chioce");
	});
})
</script>


</body>
</html>