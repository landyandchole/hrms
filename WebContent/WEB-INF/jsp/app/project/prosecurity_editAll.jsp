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
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<!-- 树形下拉框start -->
	<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
	<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
	<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
	<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/selectZtree/ztree/ztree.css"></link>
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
					<form action="security/${msg}.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PRO_ID" id="PRO_ID" value="${pd.PRO_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						   <table id="table_report" class="table table-striped table-bordered table-hover">					
							<tr>
								 <td style="width:90px;text-align: right;padding-top: 13px;">入场负责人:</td>
								 <td>
									 <input type="text" name="ADMISSIONCHARGE" id="ADMISSIONCHARGE" value="${pd.ADMISSIONCHARGE}" style="width:90%;">
								 </td>
							</tr>
							<tr>
								 <td style="width:90px;text-align: right;padding-top: 13px;">退场负责人:</td>
								 <td>
									 <input type="text" name="EXITCHARGE" id="EXITCHARGE" value="${pd.EXITCHARGE}" style="width:90%;">
								 </td>
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
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());	
		
		//保存		
		function save(){
			/* if($("#ADMISSIONCHARGE").val()==""){
				$("#ADMISSIONCHARGE").tips({
					side:3,
		            msg:'请输入入场负责人',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#ADMISSIONCHARGE").focus();
			return false;
			}
			if($("#EXITCHARGE").val()==""){
				$("#EXITCHARGE").tips({
					side:3,
		            msg:'请输入退场负责人',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#EXITCHARGE").focus();
			return false;
			} */
			
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