<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理</title>

<link href="css/bootstrap/css/bootstrap.css" rel="stylesheet" />
<link href="css/style.css" rel="stylesheet" />

<script src="js/jquery-1.9.1.min.js"></script>

</head>

	<frameset rows="100px,*,19px" framespacing="0" border="0" frameborder="0">
	<frame src="${pageContext.request.contextPath }/public/man_top.jsp" scrolling="no" noresize /> 
		<frameset cols="178px,*">
			<frame noresize src="${pageContext.request.contextPath }/public/man_left.jsp" scrolling="yes" /> 
			<frame noresize name="right" src="${pageContext.request.contextPath }/public/man_right.jsp" scrolling="yes" /> 
		</frameset>
		<frame noresize name="status_bar" scrolling="no" src="${pageContext.request.contextPath }/public/man_bottom.jsp" />
	</frameset>
	<noframes>
	</noframes>

</html>

