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
					
					<form action="projectmember/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}"/>
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>	
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<c:if test="${msg=='save'}" >
							<tr>
							<td style="width:75px;text-align: right;padding-top: 13px;" >项目成员:</td>
							<td style="vertical-align:top;padding-left:8px;width:150px;" id="MEMBER_NA" >				
								 	<select class="chosen-select form-control" name="MEMBER_ID" id="MEMBER_ID" value="${pd.MEMBER_ID}" data-placeholder="请输入工号" style="vertical-align:top;width: 120px;" onchange = "message(this.options[this.options.selectedIndex].value)" >								
									<option value=""></option> 									
									<c:forEach items="${staffList}" var="staff">
										<option value="${staff.NO}"  <c:if test="${pd.MEMBER_ID==staff.NO}">selected</c:if>>${staff.NO } ${staff.NAME}</option>
									</c:forEach>
								  	</select>
								</td>
								</tr>
							</c:if>
							<c:if test="${msg=='edit'}" >
							<tr>
							<td style="width:75px;text-align: right;padding-top: 13px;">工号:</td>
							<td><input type="text" name="MEMBER_ID" id="MEMBER_ID" value="${pd.MEMBER_ID}" maxlength="11"  title="成员Id" style="width:98%;" readonly="true" /></td>							
							</tr>
							<tr>
							<td style="width:75px;text-align: right;padding-top: 13px;">姓名:</td>
							<td><input type="text" name="MEMBER_NAME" id="MEMBER_NAME" value="${pd.MEMBER_NAME}" maxlength="11"  title="成员姓名" style="width:98%;" readonly="true" /></td>
							</tr>
							</c:if>
							<tr>
							<td style="width:75px;text-align: right;padding-top: 13px;">项目角色:</td>							
								<td><select name="MEMBER_ROLE" id="MEMBER_ROLE" style="width:30%; title="员工角色" onchange = "change(this.options[this.options.selectedIndex].value)">	</select>
							    </td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">开始日期:</td>
								<td><input class="span10 date-picker" name="MEMBER_BTIME" id="MEMBER_BTIME" value="${pd.MEMBER_BTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开始日期" title="开始日期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">结束日期:</td>
								<td><input class="span10 date-picker" name="MEMBER_ETIME" id="MEMBER_ETIME" value="${pd.MEMBER_ETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="结束日期" title="结束日期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">参考成本:</td>
								<td><input type="number" name="MEMBER_COST" id="MEMBER_COST" value="${pd.MEMBER_COST}"  maxlength="32"  title="参考成本" readonly="readonly" style="width:98%;"  /></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">级别成本:</td>
								<td><input type="number" name="MEMBER_ACTUL" id="MEMBER_ACTUL" value="${pd.MEMBER_ACTUL}" maxlength="32" placeholder="这里输入级别成本" title="级别成本" style="width:98%;"/></td>
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
		
			//判断项目经理是否存在
		function change(roleId) {	
			var id=$("input[type=hidden]").val(); //获取值  			
			if(roleId=='b2b170ee435e4ce58b3a7f87e284a81d'||roleId=='79a86ec3fd8540588aa17961418a5662'){				
			$.ajax({				
				type: "POST",	
				url: '<%=basePath%>projectmember/hasM.do?projectId='+id+'&roleId='+roleId,				
				dataType:'json',
				cache: false,
				success: function(data){
					 if("error" == data.result){
						 $("#MEMBER_ROLE").tips({
								side:3,
					            msg:'此项目角色已存在!',
					            bg:'#AE81FF',
					            time:2
					        });
							document.getElementById("MEMBER_ROLE").value="";						
					 }else{
						 $("#MEMBER_ROLE").css("background-color","white");
					 } 
					 
				 }
			  });
			}
		}
			
		//保存
		function save(){
			if($("#MEMBER_ID").val()==""){
				$("#MEMBER_NA").tips({
					side:3,
		            msg:'请选择项目成员',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MEMBER_ID").focus();
			return false;
			}			
			if($("#MEMBER_ROLE").val()==""){
				$("#MEMBER_ROLE").tips({
					side:3,
		            msg:'请选择项目角色',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MEMBER_ROLE").focus();
			return false;
			}
			if($("#MEMBER_BTIME").val()==""){
				$("#MEMBER_BTIME").tips({
					side:3,
		            msg:'请输入开始日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MEMBER_BTIME").focus();
			return false;
			}
			if($("#MEMBER_ETIME").val()==""){
				$("#MEMBER_ETIME").tips({
					side:3,
		            msg:'请输入结束日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MEMBER_ETIME").focus();
			return false;
			}
			if($("#MEMBER_COST").val()==""){
				$("#MEMBER_COST").tips({
					side:3,
		            msg:'请输入参考成本',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MEMBER_COST").focus();
			return false;
			}
			 if($("#MEMBER_ACTUL").val()==""){
				$("#MEMBER_ACTUL").tips({
					side:3,
		            msg:'请输入级别成本',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MEMBER_ACTUL").focus();
			return false;
			} 
			if($("#MEMBER_BTIME").val()!= "" && $("#MEMBER_ETIME").val() != ""){
				var t1 = $("#MEMBER_BTIME").val();
				var t2 = $("#MEMBER_ETIME").val();
				t1 = Number(t1.replace('-', '').replace('-', ''));
				t2 = Number(t2.replace('-', '').replace('-', ''));
				if(t1-t2>0){
					
					$("#MEMBER_ETIME").tips({
						side:3,
			            msg:'结束日期必须大于开始日期',
			            bg:'#AE81FF',
			            time:3
			        });					
					return false;
				}							
			} 			
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		$(function() {		
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
				dataType:'json',
				cache: false,
				success: function(data){

					 $("#MEMBER_ROLE").html('<option value="">请选择</option>');
					 $.each(data.rolelist, function(i, dvar){
							$("#MEMBER_ROLE").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
						$("#MEMBER_ROLE").val("${pd.MEMBER_ROLE}");
				}
			});
		});
		function message(id){
			
			$.ajax({
				type: "POST",
				url: '<%=basePath%>projectmember/level.do?MEMBER_ID='+id,
				dataType:'json',
				cache: false,
				success: function(data){					 				
					$("#MEMBER_COST").val(data.pdData.MEMBER_COST);
					$("#MEMBER_ACTUL").val(data.pdData.MEMBER_COST);
				}
			});
		}	
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