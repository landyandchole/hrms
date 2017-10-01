<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
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
						<form action="backapply/list.do" method="post" name="Form" id="Form">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: center;padding-top: 13px;">工作流名称:</td>
								<td style="width:200px;"><input type="text" name="PROCESS_NAME" id="PROCESS_NAME" value="${pd.PROCESS_NAME}"   title="工作流名称" style="width:90%;"/></td>
								
								<td style="width:75px;text-align: center;padding-top: 13px;">处理者:</td>
								<td style="width:250px;"><input type="text" name="ASSIGNEE" id="ASSIGNEE" value="${pd.ASSIGNEE}"   title="处理者" style="width:90%;"/></td>								
								<td style="width:75px;text-align: center;padding-top: 13px;">工作流属性:</td>
								<td style="width:200px;">
									<select name="PROCESSTYPE" id="PROCESSTYPE" data-placeholder="请选择工作流属性"  style="vertical-align:top;float:left; width: 98%;height:31px">
								  		<option value="">&nbsp;</option>
								  		<option value="入场流程" <c:if test="${pd.PROCESSTYPE=='入场流程'}">selected="selected"</c:if>>入场流程</option>
								  		<option value="退场流程" <c:if test="${pd.PROCESSTYPE=='退场流程'}">selected="selected"</c:if>>退场流程</option>
								  	</select>
								</td> 
   						     	
							</tr>
								
							<tr>
								<td style="width:75px;text-align: center;padding-top: 13px;">退回时间:</td>
								<td style="width:200px;"><input class="span10 date-picker" name="MIN_BACKTIME" id="MIN_BACKTIME" value="${pd.MIN_BACKTIME}"
								 type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开始日期" title="开始日期" style="width:44%;"/>~ 
								<input class="span10 date-picker" name="MAX_BACKTIME" id="MAX_BACKTIME" value="${pd.MAX_BACKTIME}" 
								type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="结束日期" title="结束日期" style="width:44%;"/></td>	

								<td style="width:280px;" colspan="4">	                           
		                            &nbsp;&nbsp; <a class="btn btn-light btn-xs" onclick="tosearch();"  title = "查询" >查询</a>
										 <a class="btn btn-light btn-xs" onclick="reset();" title = "重置" >重置</a> 
								</td>									 
							
							</tr>
									
						</table>
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<thead>
								<tr>
													
									<th class="center" style="width:50px;">序号</th>					
									<th class="center">工作流名称</th>
									<th class="center">工作流属性</th>
									<th class="center">处理者</th>
									<th class="center">退回时间</th>
									<th class="center">批注</th>
									<th class="center">重新申请</th>
								</tr>
							</thead>

																									
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
									<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index + 1}</td>				
											<td class='center'>${var.PROCESS_NAME}</td>
											<td class='center'>${var.PROCESSTYPE}</td>
											<td class='center'>${var.ASSIGNEE}</td>
											<td class='center'><fmt:formatDate  value="${var.BACKTIME}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td class='center'>${var.COMMENT}</td>
											<td class='center'>
												<a class="btn btn-mini btn-primary" onclick="modifyApply('${var.ID}','${var.PROCESSTYPE=='入场流程'?1:2}');">重新申请</a>
											</td>											
										</tr>
									
									</c:forEach>
								
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
						
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
						</form>
					
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
		//日期框
		$('.date-picker').datepicker({
			autoclose: true,
			todayHighlight: true
		});
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
			
		}
		//修改申请
		function modifyApply(leave_id,processtype){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="重新申请";
			 diag.URL = '<%=basePath%>backapply/toModifyApply.do?ID='+leave_id+'&PROCESSTYPE=' + processtype;
			 diag.Width = 500;
			 diag.Height = 520;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				  if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage("${page.currentPage}");
					 }
				} 
				diag.close();
			 };
			 diag.show();
		}
		
		function reset(){
			$('#PROCESS_NAME').val('');
			$('#ASSIGNEE').val('');
			$('#PROCESSTYPE').val('');
			$('#MIN_BACKTIME').val('');
			$('#MAX_BACKTIME').val('');
		}
	</script>


</body>
</html>