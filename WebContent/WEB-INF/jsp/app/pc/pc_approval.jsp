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
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/2.6/zTreeStyle.css" />
<script type="text/javascript"
	src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
<link rel="stylesheet" href="static/ace/css/chosen.css" />
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
								<table id="table_report"
									class="table table-striped table-bordered table-hover">
									<tr>
										<td style="width: 100px; text-align: right; padding-top: 13px;">任务申请人:</td>
										<td><input type="text" name="USERNAME" id="USERNAME"
											value="<%=request.getParameter("USERNAME") == null ? "" : request
					.getParameter("USERNAME")%>"
											maxlength="30" placeholder="这里输入任务申请人"
											onfocus="this.placeholder=''"
											onblur="this.placeholder='这里输入任务申请人'" title="任务申请人"
											style="width: 60%;" /></td>
										<td style="width: 100px; text-align: right; padding-top: 13px;">任务名称:</td>
										<td><input type="text" name="TASKSNAME" id="TASKSNAME"
											value="<%=request.getParameter("TASKSNAME") == null ? "" : request
					.getParameter("TASKSNAME")%>"
											maxlength="30" placeholder="这里输入任务名称"
											onfocus="this.placeholder=''"
											onblur="this.placeholder='这里输入任务名称'" title="任务任务名称"
											style="width: 80%;" /></td>

									</tr>
									<tr>
										<td style="width: 75px; text-align: right; padding-top: 13px;">工作流属性:</td>
								<td>
									<select name="TASKSPCSTATE" id="TASKSPCSTATE" value="<%=request.getParameter("TASKSPCSTATE") == null ? "" : request.getParameter("TASKSPCSTATE")%>" style="width:98%;">
										<option value="">请选择</option>
										<option value="0"<c:if test="${pd.TASKSPCSTATE == '0'}">selected</c:if>>入场流程</option>
										<option value="1"<c:if test="${pd.TASKSPCSTATE == '1'}">selected</c:if>>退场流程</option>
									</select>
								</td>
										<td
											style="width: 75px; text-align: center; padding-top: 13px;">创建时间:</td>
										<td style="width: 200px;"><input
											class="span10 date-picker" name="CREATETIME" id="CREATETIME"
											value="<%=request.getParameter("CREATETIME") == null ? "" : request.getParameter("CREATETIME")%>" type="text"
											data-date-format="yyyy-mm-dd" readonly="readonly"
											placeholder="创建时间" title="创建时间" style="width: 60%;" /></td>
										<!-- <td colspan="4" id="BUTTON"
											style="vertical-align: top; padding-left: 100px;">
											&nbsp; &nbsp;<a class="btn btn-light btn-xs"
											onclick="funreset();">查询</a>
											<button class="btn btn-light btn-xs" onclick="tosearch()" type="reset">重置</button>
										</td> -->
										<td colspan="2" id="BUTTON" style=" vertical-align: top; padding-left: 2px;">
										&nbsp;  &nbsp;<a class="btn btn-light btn-xs" onclick="tosearch();"  >查询</a>
									 <a class="btn btn-light btn-xs" onclick="funreset()" type="reset" >重置</a> 
							             </td>									
							          </tr>
								</table>

								<table id="simple-table"
									class="table table-striped table-bordered table-hover"
									style="margin-top: 5px;">
									<thead>
										<tr>
										<th class="center" style="width: 35px;"><label
												class="pos-rel"><input type="checkbox" class="ace"
													id="zcheckbox" /><span class="lbl"></span></label></th>
											<th field="id" class="center">任务名称</th>
											<th field="name" class="center">任务节点</th>
											<th field="username" class="center">任务申请人</th>
											<th field="username" class="center">申请的PC数目</th>
											 <th class="center">工作流属性</th>
											<th field="createTime" class="center">创建时间</th>
											<th field="action" class="center" formatter="formatAction">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty tasks}">
												<%-- <c:if test="${QX.cha == 1 }"> --%>
												<%-- <c:forEach items="${pdList}" var="tk" varStatus="vs"> --%>
												<c:forEach items="${pdList}" var="tk" varStatus="vs">
													<tr>
													<td class='center'><label class="pos-rel"><input
																	type='checkbox' name='ids' value="${tk.id}"
																	class="ace" /><span class="lbl"></span></label></td>
														<td class='center'>PC申请</td>
														<td class='center'>${tk.name}</td>
														<td class='center'>${tk.username}</td>
														<td class='center'>${tk.PCNUMBER}台</td>
														<td class='center'><c:if test="${tk.PCSTATE == '1'}">退场流程</c:if>
																<c:if test="${tk.PCSTATE == '0'}">入场流程</c:if></td>
											           
														<td class='center'><fmt:formatDate  value="${tk.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>												
														<td style="text-align: center;" colspan="10"><a
															class="btn btn-mini btn-primary" onclick="handle('${tk.id}','${tk.userId}','${tk.name}');">办理任务</a>
															<a class="btn btn-mini btn-danger"
															onclick="lookimg('${tk.pcleaveid}','${tk.taskid}',);">查看当前流程图</a></td>
													</tr>
												</c:forEach>
												<%-- </c:if> --%>
												<c:if test="${QX.cha == 0 }">
													<tr>
														<td colspan="100" class="center">您无权查看</td>
													</tr>
												</c:if>
											</c:when>
										</c:choose>
									</tbody>
								</table>
								<div class="page-header position-relative">
								<table style="width: 100%;">
								<td style="vertical-align: top;">
								   <a class="btn btn-mini btn-success" onclick="makeAll('确定要处理选中的数据吗?',1);">批量审批</a>
								    <a class="btn btn-mini btn-success" onclick="makeAll('确定要处理选中的数据吗?',2);">批量驳回</a>
								  </td>
									<tr>
										<td style="vertical-align: top;"><div class="pagination"
												style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
									</tr>
								</table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

		<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
		<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		
		
		$(function() {
				//日期框
				$('.date-picker').datepicker({
					autoclose: true,
					todayHighlight: true
				});
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
				
		function funreset(){
			$("#TASKSNAME").val("");
			$("#USERNAME").val(""); 
			$("#TASKSPCSTATE").val("");
			$("#CREATETIME").val("");
		}
		
		
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		function makeAll(msg,status){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
				        if(msg == '确定要处理选中的数据吗?'){
				        	$.post("${pageContext.request.contextPath}/pca/audit_all",{DATA_IDS:str,status:status},function(result){
								if(result.success){
									alert("处理中，请耐心等待！");
									$("#Form").submit();
								}else{
									alert("系统系统,审批提交失败，请联系管理员！");
								}
							},"json");
							<%-- top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>pca/audit_all.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
		   					    //beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});  --%>
						} 
					}
				}
			});
		};
	
		function handle(id,name,taskName){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="审批画面";
			 diag.URL = '<%=basePath%>backlog/getLeaveByTaskId.do?processInstanceId='+id+'&name='+name+'&taskName='+taskName;
			 diag.Width = 750;
			 diag.Height = 380;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 top.jzts();
					 $("#Form").submit();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		function lookimg(id,taskId){
			if(!taskId){
				taskId="";
			}
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="流程图";
			 diag.URL = '<%=basePath%>backlog/showActivityView.do?ID='+id+'&taskId='+taskId;
			 diag.Width =800;
			 diag.Height = 350;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 top.jzts();
				}
				diag.close();
			 };
			 diag.show();
		}
		
	</script>
</body>
</html>