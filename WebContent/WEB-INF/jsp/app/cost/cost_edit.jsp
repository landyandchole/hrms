<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
					
					<form action="cost/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}"/>
						<input type="hidden" name="COST_ID" id="COST_ID" value="${pd.COST_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
							    <td style="width:75px;text-align: right;padding-top: 13px;">费用类目:</td>
								<td style="vertical-align:top;padding-left:8px;">
								<select  name="COST_ITEMS" id="COST_ITEMS" style="width:98%;">
								 </select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">费用金额:</td>
								<td><input type="number" name="COST_MONEY" id="COST_MONEY" value="${pd.COST_MONEY}" maxlength="32" placeholder="这里输入费用金额" title="费用金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">生成时间:</td>
								<td><input class="span10 date-picker" name="COST_USEDATE" id="COST_USEDATE" value="${pd.COST_USEDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="创建时间" title="创建时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建人:</td>
								<td style="vertical-align:top;padding-left:8px;width:150px;" id="MEMBER_NA" >
								<c:if test="${msg == 'save'}">				
								 	<select class="chosen-select form-control" name="COST_FOUNDER" id="COST_FOUNDER" value="${pd.COST_FOUNDER}" data-placeholder="请输入工号" style="vertical-align:top;width: 109%;"  >								
								 	<option  selected="selected" value="${pdf.founders }">${pdf.founders } ${pdf.founderName }</option> 	
									<c:forEach items="${staffList}" var="staff">
										<option value="${staff.NO}"  <c:if test="${pd.COST_FOUNDER==staff.NO}">selected</c:if>>${staff.NO } ${staff.NAME}</option>									
									</c:forEach>
								  	</select>
								  </c:if>
								  
								  <c:if test="${msg == 'edit'}">
								  <select class="chosen-select form-control" name="COST_FOUNDER" id="COST_FOUNDER" value="${pd.COST_FOUNDER}" data-placeholder="请输入工号" style="vertical-align:top;width: 109%;"  >								
									<option  selected="selected" >${pd.COST_FOUNDER }</option> 									
									<c:forEach items="${staffList}" var="staff">
										<option value="${staff.NO}"  <c:if test="${pd.COST_FOUNDER==staff.NO}">selected</c:if>>${staff.NO } ${staff.NAME}</option>
									</c:forEach>
								  	</select>
								  </c:if>
								  	
								</td>
								
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="COST_NOTE" id="COST_NOTE" value="${pd.COST_NOTE}" maxlength="32" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#COST_ITEMS").val()==""){
				$("#COST_ITEMS").tips({
					side:3,
		            msg:'请输入费用类目',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COST_ITEMS").focus();
			return false;
			}
			if($("#COST_MONEY").val()==""){
				$("#COST_MONEY").tips({
					side:3,
		            msg:'请输入费用金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COST_MONEY").focus();
			return false;
			}
			if($("#COST_USEDATE").val()==""){
				$("#COST_USEDATE").tips({
					side:3,
		            msg:'请输入创建时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COST_USEDATE").focus();
			return false;
			}
		 	if($("#COST_FOUNDER").val()==""){
				$("#MEMBER_NA").tips({
					side:3,
		            msg:'请选择创建人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COST_FOUNDER").focus();
			return false;
			} 
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		//下拉框
		$(function() {		
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
				dataType:'json',
				cache: false,
				success: function(data){

					 $("#COST_ITEMS").html('<option value="">请选择</option>');
					 $.each(data.expenseNameList, function(i, dvar){
							$("#COST_ITEMS").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
						$("#COST_ITEMS").val("${pd.COST_ITEMS}");
				}
			});
		});
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
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
		});
		</script>
</body>
</html>