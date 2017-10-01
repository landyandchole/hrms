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
<meta charset="utf-8" />
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="static/js/jquery.tips.js"></script>	
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
							<form action="backlog/approval.do" name="Form" id="Form"
								method="post">
								<input type="hidden" name="TASKID" id="TASKID"
									value="${pd.TASKID}" />
									<input type="hidden" name="NAME" id="NAME"
									value="${pd.name}" />
									<input type="hidden" name="taskName" id="taskName"
									value="${pd.taskName}" />
									<input type="hidden" name="PCSTATE" id="PCSTATE"
									value="${pd.PCSTATE}" />
								<input type="hidden" name="STAFF_ID" id="STAFF_ID"
									value="${pd.ID}" />PC审批
								<div id="zhongxin" style="padding-top: 13px;">
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
												<td class='center'></td>
											</tr>
											</c:if>
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
									<%-- <table id="table_report"
										class="table table-striped table-bordered table-hover">
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">项目:</td>
											<td><input type="text" name="project" id="project" value="${pd.NAME}"
												maxlength="50" title="项目" style="width: 50%;" disabled="disabled"/> </td>
											<td><input type="radio" name="noproject" value="">无项目</td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">内存:</td>
											<td><input type="text" name="" id="" value="${pd.RAM}"
												maxlength="50" title="内存" style="width: 50%;" disabled="disabled"/> </td>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">硬盘:</td>
											<td> <input type="text" name="" id="" value="${pd.HDISK}"
												maxlength="50" title="硬盘" style="width: 50%;" disabled="disabled"/></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">类型:</td>
											<td><input type="text" name="" id="" value="${pd.TYPE}"
												maxlength="50" title="类型" style="width: 50%;" disabled="disabled"/></td>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">房间:</td>
											<td> <input type="text" name="" id="" value="${pd.ROOM_NAME}"
												maxlength="50" title="房间" style="width: 50%;"  disabled="disabled"/> </td>
										</tr>
										<tr>
										<td
												style="width: 75px; text-align: right; padding-top: 13px;">PC数量:</td>
													<td><input type="text" name="" id="" value="${pd.PCNUMBER}"
												maxlength="50" title="内存" style="width: 50%;" disabled="disabled"/> </td>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">批注:
											</td>
											<td><input type="text" name="comment" id="comment" value=""
												maxlength="50" title="批注" style="width: 98%;" /></td>
												
										</tr>

										<tr>
											<td style="text-align: center;" colspan="10"><a
												class="btn btn-mini btn-primary" onclick="audit(${pd.TASKID},1);">审批通过</a>
												<a class="btn btn-mini btn-danger"
												onclick="audit(${pd.TASKID},2);">驳回</a></td>
										</tr>
									</table> --%>
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<tr>
											<td style="text-align: center;" colspan="10"><a
												class="btn btn-mini btn-primary" onclick="audit(${pd.TASKID},1);">审批通过</a>
												<a class="btn btn-mini btn-danger"
												onclick="audit(${pd.TASKID},2);">驳回</a></td>
										</tr>
										</table>
									<div id="zhongxin"></div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		$(function() {
			var project = $("#project").val();
			if(project==null || project==""){
				$("input[name='noproject']").attr('checked','true');
			}
			
		});
		function audit(id,status){
			var comment = $("#comment").val();
			var name = $("#NAME").val();
			var taskName = $("#taskName").val();
			var pcstate = $("#PCSTATE").val();
			/* if($("#comment").val()==""){
				$("#comment").tips({
					side:3,
		            msg:'请输入批注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#comment").focus();
			return false;
			} */
			if(taskName=="部长审批" || taskName=="项目总监审批"){
				$.post("${pageContext.request.contextPath}/pca/audit_pd",{status:status,taskId:id,pcstate:pcstate,comment:comment},function(result){
					if(result.success){
						alert("处理中，请耐心等待！");
						document.getElementById('zhongxin').style.display = 'none';
						top.Dialog.close();
					}else{
						alert("系统系统,提交失败，请联系管理员！");
					}
				},"json");
			}else if(taskName=="信息安全人员"){
				$.post("${pageContext.request.contextPath}/pca/audit_infoSafes",{status:status,taskId:id,pcstate:pcstate,comment:comment},function(result){
					if(result.success){
						alert("处理中，请耐心等待！");
						document.getElementById('zhongxin').style.display = 'none';
						top.Dialog.close();
					}else{
						alert("系统系统,提交失败，请联系管理员！");
					}
				},"json");
			}else{
				$.post("${pageContext.request.contextPath}/pca/audit_pm",{status:status,taskId:id,pcstate:pcstate,comment:comment},function(result){
					if(result.success){
						alert("处理中，请耐心等待！");
						document.getElementById('zhongxin').style.display = 'none';
						top.Dialog.close();
					}else{
						alert("系统系统,提交失败，请联系管理员！");
					}
				},"json");
			}
			
		}
	</script>
</body>
</html>