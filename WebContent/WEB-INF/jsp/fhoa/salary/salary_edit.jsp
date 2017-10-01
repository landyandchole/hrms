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
	<!-- 树形下拉框start -->
<!-- 	<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
	<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
	<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
	<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/selectZtree/ztree/ztree.css"></link> -->
<!-- 树形下拉框end -->
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
					
					<form action="salary/${msg}.do" name="Form" id="Form" method="post">
 						<input type="hidden" name="SALARY_ID" id="SALARY_ID" value="${pd.SALARY_ID}"/>
 						<input type="hidden" name="msg" id="msg" value="${msg}" />
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
						
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">工号:</td>
								<td><input type="text" name="NO" id="NO" value="${pd.NO}" maxlength="255" placeholder="这里输入工号" title="工号" readonly="true" style="width:99.5%;"/></td>
								<td style="width:75px;text-align: right;padding-top: 13px;">${pd.msg}:</td>
								<td><input type="text" name="SALARY" id="SALARY" value="${pd.SALARY}" maxlength="255" placeholder="这里输入薪资" title="薪资" style="width:99.5%;"/></td>
							   
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
		$(document).ready(function(){
			if($("#SALARY_ID").val()!=""){
				//$("#PROJECT_NAME").attr("readonly","readonly");
				$("#SALARY").css("color","gray");
			}
			
		});  
		
		//保存
		function save(){
		
			if($("#NO").val()==""){
				$("#NO").tips({
					side:3,
		            msg:'请输入工号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NO").focus();
			return false;
			}
			if($("#SALARY").val()==""){
				$("#SALARY").tips({
					side:3,
		            msg:'请输入薪资',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SALARY").focus();
			return false;
			}
		
			
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
	
		</script>
</body>
</html>