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
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						<br/>
						<br/>
						<br/>
						 <div class="step-content row-fluid position-relative">
									<div style="width:700px;padding-left: 8px;">
										<div style="width:600px;float:right;">
											<!-- <div class="widget-box"> -->
												<div class="widget-body">
												 <div class="widget-main">
												 <c:if test="${pd.name==''|| pd.name == null}">
													  <c:if test="${pd.PG == '0'}">
														<img src="<%=basePath%>static/images/activity/npg.jpg" width="80" height="106" alt=""/>
													 </c:if>
													  <c:if test="${pd.PG == '1'}">
														<img src="<%=basePath%>static/images/activity/pg.jpg" width="80" height="106" alt=""/>
													 </c:if>
	                                                    <img src="<%=basePath%>static/images/activity/jiantou.jpg" width="35" height="106" alt=""/>
	                                                     <c:if test="${pd.SPM == '0'}">
														<img src="<%=basePath%>static/images/activity/nbz.jpg" width="80" height="106" alt=""/>
													 </c:if>
													  <c:if test="${pd.SPM == '1'}">
														<img src="<%=basePath%>static/images/activity/bz.jpg" width="80" height="106" alt=""/>
													 </c:if>
	                                                      <img src="<%=basePath%>static/images/activity/jiantou.jpg" width="35" height="106" alt=""/>
	                                                 <c:if test="${pd.XINGUAN == '0'}">
	                                                    <img src="<%=basePath%>static/images/activity/npinguanbu.jpg" width="80" height="106" alt=""/>
	                                                 </c:if>
	                                                 <c:if test="${pd.XINGUAN == '1'}">
	                                                    <img src="<%=basePath%>static/images/activity/pinguanbu.jpg" width="80" height="106" alt=""/>
	                                                 </c:if>
												 </c:if>
												 <c:if test="${pd.name != '' && pd.name != null}">
													 <c:if test="${pd.PG == '0'}">
														<img src="<%=basePath%>static/images/activity/npg.jpg" width="80" height="106" alt=""/>
													 </c:if>
													  <c:if test="${pd.PG == '1'}">
														<img src="<%=basePath%>static/images/activity/pg.jpg" width="80" height="106" alt=""/>
													 </c:if>
	                                                    <img src="<%=basePath%>static/images/activity/jiantou.jpg" width="35" height="106" alt=""/>
	                                                 <c:if test="${pd.PM == '0'}">
	                                                    <img src="<%=basePath%>static/images/activity/npm.jpg" width="80" height="106" alt=""/>
	                                                 </c:if>
	                                                  <c:if test="${pd.PM == '1'}">
	                                                    <img src="<%=basePath%>static/images/activity/pm.jpg" width="80" height="106" alt=""/>
	                                                 </c:if>
	                                                    <img src="<%=basePath%>static/images/activity/jiantou.jpg" width="35" height="106" alt=""/>
	                                                 <c:if test="${pd.PD == '0'}">
	                                                    <img src="<%=basePath%>static/images/activity/npd.jpg" width="80" height="106" alt=""/>
	                                                 </c:if>
	                                                 <c:if test="${pd.PD == '1'}">
	                                                    <img src="<%=basePath%>static/images/activity/pd.jpg" width="80" height="106" alt=""/>
	                                                 </c:if>
	                                                    <img src="<%=basePath%>static/images/activity/jiantou.jpg" width="35" height="106" alt=""/>
	                                                 <c:if test="${pd.XINGUAN == '0'}">
	                                                    <img src="<%=basePath%>static/images/activity/npinguanbu.jpg" width="80" height="106" alt=""/>
	                                                 </c:if>
	                                                 <c:if test="${pd.XINGUAN == '1'}">
	                                                    <img src="<%=basePath%>static/images/activity/pinguanbu.jpg" width="80" height="106" alt=""/>
	                                                 </c:if>
                                                 </c:if>
												 </div><!--/widget-main-->
												</div><!--/widget-body-->
											<!-- </div>/widget-box -->
										 </div><!--/span-->	
									</div>
						</div>
						 <div class="step-content row-fluid position-relative">
							 <input type="hidden" value="no" id="hasTp1" />
						 </div> 
																
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
	</div>

	<div id = "zhongxin"></div>
<script type="text/javascript">
		$(top.hangge());//关闭加载状态
</script>

</body>
</html>