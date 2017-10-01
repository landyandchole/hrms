<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<meta charset="utf-8" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<!-- 树形下拉框start -->
	<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
	<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
	<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
	<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/2.6/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">		
							<!-- 检索  -->
						<form action="pca/goview.do" name="Form" id="Form" method="post">
				        <input type="hidden" name="ID" id="ID" value="${pd.ID}"/>申请人信息 
				        <div id="zhongxin" style="padding-top: 13px;"> 
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center">申请人</th>	
									<th class="center">申请日期</th>
									<th class="center">审批流程</th>
									<th class="center">处理状态</th>
									<th class="center">说明</th>
								</tr>
							</thead>
							
							<tbody>
							<!-- 开始循环 -->	
								<tr>
									<td class='center'>${pd.NAME}</td>
									<td class='center'><fmt:formatDate  value="${pd.DATE}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td class='center'>${pd.PROCEDURE}</td>
									<td class='center'>${pd.STATE}</td>
									<td class='center'>${pd.REMARK}</td>											
								</tr>
						</table>
						</div>
						</form>
						<form action="pca/goview.do" name="Form2" id="Form2" method="post">
				        <input type="hidden" name="ID" id="ID" value="${pd.ID}"/>审批记录 
				        <div id="zhongxin" style="padding-top: 13px;"> 
				        <table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center">处理时间</th>	
									<th class="center">处理节点</th>
									<th class="center">处理意见</th>
								</tr>
							</thead>
							
							<tbody>
							<!-- 开始循环 -->	
								<tr>
									<td class='center'><fmt:formatDate  value="${pd2.END_TIME_}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td class='center'>${pd2.NAME_1}</td>
									<td class='center'>${pd2.MESSAGE_}</td>
								</tr>
							<c:choose>
								<c:when test="${not empty varlist}">
									<c:forEach items="${varlist}" var="var" varStatus="vs">
								<tr>
									<td class='center'><fmt:formatDate  value="${var.time}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td class='center'>${var.userId}</td> 
									<td class='center'>${var.message}</td>
								</tr>
									</c:forEach>
								</c:when>
							</c:choose>
								<tr>
									<td class='center'><fmt:formatDate  value="${pd3.END_TIME_}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td class='center'>${pd3.NAME_2}</td>
									<td class='center'>${pd3.MESSAGE_}</td>
								</tr>
							</tbody>
						</table>
						</div>
				        </form>
				        <form action="pca/goview.do" name="Form3" id="Form3" method="post">
				        <input type="hidden" name="ID" id="ID" value="#"/>PC申请信息
				        <div style="max-width:1200px; min-width: 600px;"> 
						<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center">工号</th>
									<th class="center">姓名</th>
									<th class="center">数量</th>
									<th class="center">内存</th>
									<th class="center">硬盘</th>
									<th class="center">类型</th>
									<th class="center">房间</th>
									<th class="center">用途</th>
									<th class="center">申请时间</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty pc}">
										<c:forEach items="${pc}" var="var" varStatus="vs">
											<c:if test="${var.FITTINGS_NAME=='' || var.FITTINGS_NAME==null}">
											<tr>
												<td class='center'>${var.NO}</td>
												<td class='center'>${var.NAME}</td>
												<td class='center'>${var.PCNUMBER}</td>
												<td class='center'>${var.RAM}</td>
												<td class='center'>${var.HDISK}</td>
												<td class='center'>${var.TYPE}</td>
												<td class='center'>${var.ROOM_NAME}</td>
												<td class='center'>${var.PURPOSE}</td>
												<td class='center'><fmt:formatDate  value="${var.DATE}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											</tr>
											</c:if>
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
							<thead>
								<tr>
									<th class="center">工号</th>
									<th class="center">姓名</th>
									<th class="center">数量</th>
									<th class="center">配件</th>
									<th class="center">房间</th>
									<th class="center">申请时间</th>
									<th class="center"></th>
									<th class="center"></th>
									<th class="center"></th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty pc}">
										<c:forEach items="${pc}" var="var" varStatus="vs">
										<c:if test="${var.FITTINGS_NAME!='' && var.FITTINGS_NAME!=null}">
											<tr>
												<td class='center'>${var.NO}</td>
												<td class='center'>${var.NAME}</td>
												<td class='center'>${var.PCNUMBER}</td>
												<td class='center'>${var.FITTINGS_NAME}</td>
												<td class='center'>${var.ROOM_NAME}</td>
												<td class='center'><fmt:formatDate  value="${var.DATE}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
												<td class='center'></td>
												<td class='center'></td>
												<td class='center'></td>
											</tr>
											</c:if>
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
								<%-- <tr>
									<th class="center" width="150px">工号</th>
									<td class='center'>${pc.NO}</td>	
								</tr>
								<tr>
									<th class="center">姓名</th>
									<td class='center'>${pc.NAME}</td>
								</tr>
								<tr>
									<th class="center">内存</th>
									<td class='center'>${pc.RAM}</td>
								</tr>
								<tr>
									<th class="center">硬盘</th>
									<td class='center'>${pc.HDISK}</td>
								</tr>
								<tr>
									<th class="center">类型</th>
									<td class='center'>${pc.TYPE}</td>
								</tr>
								<tr>
									<th class="center">配件</th>
									<td class='center'>${pc.ACCESSORIES}</td>
								</tr>
								<tr>
									<th class="center">房间</th>
									<td class='center'>${pc.ROOM_NAME}</td>
								</tr>
								<tr>
									<th class="center">用途</th>
									<td class='center'>${pc.PURPOSE}</td>
								</tr>
								<tr>
									<th class="center">申请时间</th>
									<td class='center'>${pc.DATE}</td>
								</tr> --%>
						</table>
						</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->

	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		 $(top.hangge());//关闭加载状态
	</script>

</body>
</html>