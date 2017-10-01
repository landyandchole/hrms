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
<%@ include file="../../system/index/foot.jsp"%>
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
					
					<form action="publish/addDeploy.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
						<input type="hidden" name="EVENT_ID" id="EVENT_ID" value=""/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
						    <%-- <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">流程名称:</td>
								<td><input type="text" name="s_name" id="EVENT_NAME" value="${pd.EVENT_NAME}" maxlength="255" placeholder="这里输入事件名称" title="事件名称" style="width:98%;"/></td>
							</tr> --%> 
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">流程附件:</td>
								<td><input type="file" name="deployFile" id="EVENT_FILE" maxlength="255" placeholder="这里选择附件" title="附件" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">提交</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						<table id="table_report1" class="table table-striped table-bordered table-hover">
							<tr>
								<span><font color = "#5B5B5B">&nbsp;&nbsp;&nbsp;说明：请将".bpmn"文件和".png"文件打包为".zip"格式上传，工作流名称将会使用文件包名命名。如文件包为"activiti.zip"，工作流名称则为"activti"。
								<br>&nbsp;&nbsp;&nbsp;注意：其他格式的文件包（如".rar",".7z"等）将无法上传。</font></span>
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
	<%@ include file="../../system/index/top.jsp"%>
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
			if($("#EVENT_NAME").val()==""){
				$("#EVENT_NAME").tips({
					side:3,
		            msg:'请输入事件名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EVENT_ NAME").focus();
			return false;
			}
					
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>