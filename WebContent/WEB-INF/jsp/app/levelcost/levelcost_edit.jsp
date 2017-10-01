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
					
					<form action="levelcost/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="LEVELCOST_ID" id="LEVELCOST_ID" value="${pd.LEVELCOST_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">级别:</td>
								<td>
								<div>
								<!-- 	 <input name="LEVEL" id="LEVEL" style="width:98%;" /> -->
									<%-- <c:if test="${msg } != edit">
										<!-- <select  name="LEVEL" id="LEVEL" style="width:98%;">
									 	</select> -->
									</c:if> --%>
									<c:if test="${msg == 'edit'}">
										<select disabled="false" name="LEVEL" id="LEVEL" style="width:98%;">
										 </select>
									</c:if> 
									<c:if test="${msg == 'save'}">
										<select   name="LEVEL" id="LEVEL" style="width:98%;">
									 	</select>
									</c:if> 
								</div>
								</td>
							</tr>
							<tr>
								<td style="width:105px;text-align: right;padding-top: 13px;">成本:</td>
								<td><input type="text" name="COST" id="COST" value="${pd.COST}" maxlength="100" placeholder="这里输入成本" title="成本" style="width:98%;"/></td>
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
			if($("#LEVEL").val()==""){
				$("#LEVEL").tips({
					side:3,
		            msg:'请输入级别',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LEVEL").focus();
			return false;
			}
			if($("#COST").val()==""){
				$("#COST").tips({
					side:3,
		            msg:'请输入成本',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COST").focus();
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

					 $("#LEVEL").html('<option value="">请选择</option>');
					 $.each(data.titlelist, function(i, dvar){
							$("#LEVEL").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
						$("#LEVEL").val("${pd.LEVEL}");
				}
			});
		});
		
		//判断级别是否存在
		$(function() {
			$('#LEVEL').blur(function() {
			var LEVEL = $("#LEVEL").val();			
			$.ajax({				
				type: "POST",	
				url: '<%=basePath%>levelcost/hasU.do',		
				data: {LEVEL:LEVEL,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					 if("error" == data.result){
						 $("#LEVEL").tips({
								side:3,
					            msg:'此级别已存在!',
					            bg:'#AE81FF',
					            time:2
					        });
							document.getElementById("LEVEL").value="";						
					 }else{
						 $("#LEVEL").css("background-color","white");
					 } 
					 
				 }
			  });
			});
		});
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>