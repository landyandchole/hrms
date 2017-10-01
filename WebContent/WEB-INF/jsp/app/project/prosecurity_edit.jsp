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
	<!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css" />
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
						<input type="hidden" name="PC_STATE" id="PC_STATE" value="${pd.PC_STATE}" >
						<div id="zhongxin" style="padding-top: 13px;">
						<div><td style="vertical-align:top;padding-left:300px"><font style="color:red";>申请的电脑数据：</font></td>
						   <td>电脑类型：${pageData.TYPE}&nbsp&nbsp电脑硬盘：${pageData.RAM}&nbsp&nbsp电脑内存：${pageData.HDISK}</td></div>
						   <table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
							     <td style="width:90px;text-align: right;padding-top: 13px;">pc编号:</td>
								 <td style="vertical-align:top;padding-left:8px;" id="NUMBER">
									<select class="chosen-select form-control" name="PC_NUMBER" id="PC_NUMBER" value="${pd.PC_NUMBER}" data-placeholder="请选择PC编号" style="width:90% ">	
													
									<c:if test="${pd.PC_NUMBER!=null}">
									<option value="${pd.PC_NUMBER}">${pd.PC_NUMBER}</option>
									</c:if>
									<option value=""></option>
									<c:forEach items="${pcList}" var="pc">
										<option value="${pc.PC_ID},${pc.PC_NO}"  <%-- <c:if test="${pd.PC_NUMBER!=null">selected</c:if> --%>>${pc.PC_NO}&nbsp&nbsp${pc.TYPE}&nbsp&nbsp${pc.RAM}&nbsp&nbsp${pc.HDISK} </option>
									</c:forEach>
									
								  	</select>
								 </td>
							</tr>							
							<tr>
								 <td style="width:90px;text-align: right;padding-top: 13px;">使用者:</td>								
								 <td style="vertical-align:top;padding-left:8px;" id="user" >				
								 	<select class="chosen-select form-control" name="USER" id="USER" value="${pd.USER}" data-placeholder="请输入工号" style="width:90% ">								
									<option value=""></option> 
									<c:if test="${pd.PROJECT_ID!=null}">		
									<c:forEach items="${proStaffList}" var="userid">
										<option value="${userid.USER_ID},${userid.NAME}"  <c:if test="${pd.USER==userid.NAME}">selected</c:if>>${userid.NO } ${userid.NAME}</option>
									</c:forEach>	
									</c:if>	
									<c:if test="${pd.PROJECT_ID==null}">					
									<c:forEach items="${useridList}" var="userid">
										<option value="${userid.USER_ID},${userid.NAME}"  <c:if test="${pd.USER==userid.NAME}">selected</c:if>>${userid.NO } ${userid.NAME}</option>
									</c:forEach>
									</c:if>
								  	</select>
								</td>
							</tr>
							<tr>
								 <td style="width:90px;text-align: right;padding-top: 13px;">入场负责人:</td>								 
								 <td style="vertical-align:top;padding-left:8px;" id="ADMISSION" >				
								 	<select class="chosen-select form-control" name="ADMISSIONCHARGE" id="ADMISSIONCHARGE" value="${pd.ADMISSIONCHARGE}" data-placeholder="请输入工号" style="width:90%;">								
									<option value=""></option> 									
									<c:forEach items="${staffList}" var="staff">
										<option value="${staff.NAME}"  <c:if test="${pd.ADMISSIONCHARGE==staff.NAME}">selected</c:if>>${staff.NAME}</option>
									</c:forEach>
								  	</select>
								</td>
							</tr>
							<tr>
								 <td style="width:90px;text-align: right;padding-top: 13px;">退场负责人:</td>								
								 <td style="vertical-align:top;padding-left:8px;" id="EXIT" >				
								 	<select class="chosen-select form-control" name="EXITCHARGE" id="EXITCHARGE" value="${pd.EXITCHARGE}" data-placeholder="请输入工号" style="width:90%;">								
									<option value=""></option> 									
									<c:forEach items="${staffList}" var="staff">
										<option value="${staff.NAME}"  <c:if test="${pd.EXITCHARGE==staff.NAME}">selected</c:if>>${staff.NAME}</option>
									</c:forEach>
								  	</select>
								</td>
							</tr>
							<tr>
								 <td style="text-align: center;" colspan="10">
									 <a class="btn btn-mini btn-primary" id="a1" onclick="save();">保存</a>
									 <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								 </td>
							</tr>
						   </table>					  
						 <%--  <input type="hidden" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}" > --%> 
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
		
		//下拉框
		$(function() {	
		var  pcstate=document.getElementById("PC_STATE").value;
		    if(pcstate=="91263f5998e24af3b0cf011bba426557"){
		    	 //alert("入场准备中");
		    	 $("#PC_NUMBER").attr("disabled",true);
				 $("#USER").attr("disabled",true); 
				 $("#EXITCHARGE").attr("disabled",true); 
				 $("#a1").click(function(){
					 save1();
				 });
		    }else if(pcstate=="afd972ec76334ba7949c8ed093449b29"){
		    	//alert("入场中");		   
		    	$("#PC_NUMBER").removeAttr("disabled"); 
		    	 $("#USER").attr("disabled",true); 
				 $("#EXITCHARGE").attr("disabled",true); 
				 $("#a1").click(function(){
                	 save2();
				 });
		    }else if(pcstate=="8b2bb55faa4e4258870ebd1aaeedf489"){
		    	//alert("已入场");		    
		    	$("#USER").removeAttr("disabled");
		    	$("#EXITCHARGE").attr("disabled",true);		    	
		    	$("#a1").click(function(){
               	    save3();
				 });
		    }else  if(pcstate=="141b48c7bc554d58bd298dc9acff3f46"){
		    	//alert("退场准备中");		  
		    	$("#EXITCHARGE").removeAttr("disabled");
		    	$("#a1").click(function(){
               	    save4();
				 });
		    }
		});
		
		function  save1(){
			if($("#ADMISSIONCHARGE").val()==""){
				$("#ADMISSION").tips({
					side:3,
		            msg:'请输入入场负责人',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#ADMISSIONCHARGE").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		function  save2(){
			if($("#PC_NUMBER").val()==""){
				$("#NUMBER").tips({
					side:3,
		            msg:'请输入PC编号',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#PC_NUMBER").focus();
			return false;
			}
			
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		function  save3(){
			if($("#USER").val()==""){
				$("#user").tips({
					side:3,
		            msg:'请输入使用者',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#USER").focus();
			return false;
			}
			
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		function  save4(){
			if($("#EXITCHARGE").val()==""){
				$("#EXIT").tips({
					side:3,
		            msg:'请输入退场负责人',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#EXITCHARGE").focus();
			return false;
			}
			
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
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