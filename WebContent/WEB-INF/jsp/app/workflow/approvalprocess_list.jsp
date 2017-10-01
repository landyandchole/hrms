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
						<form action="aprroveProccess/finishedList.do" method="post" name="Form" id="Form">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>								
								<td style="width:75px;text-align: center;padding-top: 13px;">申请人:</td>
								<td style="width:250px;"><input type="text" name="username" id="username" value="${pd.username}"   title="申请人" style="width:90%;"/></td>								
								<td style="width:75px;text-align: center;padding-top: 13px;">工作流属性:</td>
								<td style="width:200px;">
									<select name="PROCESSTYPE" id="PROCESSTYPE" style="vertical-align:top;float:left; width: 98%;height:31px">
								  		<option value="">&nbsp;</option>
								  		<option value="入场流程" <c:if test="${pd.PROCESSTYPE=='入场流程'}">selected="selected"</c:if>>入场流程</option>
								  		<option value="退场流程" <c:if test="${pd.PROCESSTYPE=='退场流程'}">selected="selected"</c:if>>退场流程</option>
								  	</select>
								</td> 
								<td style="width:75px;text-align: center;padding-top: 13px;">创建时间:</td>
								<td style="width:200px;"><input class="span10 date-picker" name="MIN_START_TIME_" id="MIN_START_TIME_" value="${pd.MIN_START_TIME_}"
								 type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开始日期" title="开始日期" style="width:44%;"/>~ 
								<input class="span10 date-picker" name="MAX_START_TIME_" id="MAX_START_TIME_" value="${pd.MAX_START_TIME_}" 
								type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="结束日期" title="结束日期" style="width:44%;"/></td>	
   						     	
							</tr>
								
							<tr>
								
							   <td style="width:85px;text-align: center;padding-top: 13px;">结束时间:</td>
									<td><input class="span10 date-picker" name="MIN_END_TIME_" id="MIN_END_TIME_" value="${pd.MIN_END_TIME_}"
								 type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开始日期" title="开始日期" style="width:44%;"/>~ 
								<input class="span10 date-picker" name="MAX_END_TIME_" id="MAX_END_TIME_" value="${pd.MAX_END_TIME_}" 
								type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="结束日期" title="结束日期" style="width:44%;"/></td>	
									<td style="width:280px;" colspan="4">	                           
		                            &nbsp;&nbsp; <a class="btn btn-light btn-xs" onclick="tosearch();"  title = "查询" >查询</a>
										 <a class="btn btn-light btn-xs" onclick="reset();" title = "重置" >重置</a> 
									</td>									 
								
							
							</tr>
									
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center">工作流名称</th>
									<th class="center">工作流属性</th>
									<th class="center">申请人</th>
									<th class="center">创建时间</th>
									<th class="center">结束时间</th>
									<th class="center">流程图解</th>
									<th class="center">详细信息</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<c:if test="${var.username!=null}">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.ID_}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center'>${var.PROCESS_NAME}</td>
											<td class="center">${var.PROCESSTYPE}</td>
											<td class='center'>${var.username}</td>
											<td class='center'><fmt:formatDate  value="${var.START_TIME_}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td class='center'><fmt:formatDate  value="${var.END_TIME_}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td class="center">
												<div class="hidden-sm hidden-xs btn-group">
				
													<a class="btn btn-xs btn-success" title="Chart" onclick="aa('${var.PC_LEAVE_ID}','${var.PC_LEAVE_TASKID}');">Chart</a>
										
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${ID_}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${ID_}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
											</td>
											
											<td class="center">
												<a class="btn btn-xs btn-success" title="View" onclick="view('${var.PC_LEAVE_ID}','${var.PROCESSINSTANCEID}')">View</a>
											</td>
										</tr>
									</c:if>
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
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
			
		}
		$(function() {
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
			
			
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
		
		function reset(){
			$('#PROCESS_NAME').val('');
			$('#username').val('');
			$('#PROCESSTYPE').val('');
			$('#MIN_START_TIME_').val('');
			$('#MAX_START_TIME_').val('');
			$('#MIN_END_TIME_').val('');
			$('#MAX_END_TIME_').val('');
		}
		
		//查看流程图
		function  aa(id,taskId){
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
		
		//详细信息
		function view(Id,PROCESSINSTANCEID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="详细信息";
			 diag.URL = '<%=basePath%>pca/goview.do?ID='+Id+'&&PROCESSINSTANCEID='+PROCESSINSTANCEID;
			 diag.Width = 1200;
			 diag.Height = 800;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
	</script>


</body>
</html>