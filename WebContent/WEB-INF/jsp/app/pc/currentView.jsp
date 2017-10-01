<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/2.6/zTreeStyle.css" />
<script type="text/javascript"
	src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
<body>

<img  src="<%=basePath%>backlog/showView.action?deploymentId=${deploymentId}&diagramResourceName=${diagramResourceName}">
	<div id = "zhongxin" style="position: absolute;border: 1px solid red;top:${y-3}px;left:${x-3}px;width:${width+3}px;height:${height+3}px;"></div>
<script type="text/javascript">
		$(top.hangge());//关闭加载状态
</script>

</body>
</html>