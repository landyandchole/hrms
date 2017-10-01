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
	<meta charset="utf-8" />
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
					<form name="Form" id="Form" method="post">
						 <div id="zhongxin" style="padding-top: 13px;"> 
						 <input  id="ID" name="ID"  type ="hidden" value = "${pd.PC_LEVEL_RECORD.ID}">
						<table id="table_report" class="table table-striped table-bordered table-hover">
						    <c:if test="${pd.PC_LEVEL_RECORD.NAME != null && pd.PC_LEVEL_RECORD.NAME != '' }">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目:</td>
								<td>
									<label>${pd.PC_LEVEL_RECORD.NAME}</label>  
								</td>											
							</tr>
							</c:if>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">内存:</td>
								<td>
									<select <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==0}">name="RAM"</c:if> id="RAM" style="width:100%;" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}">disabled="disabled"</c:if>>
										
									</select>
									<c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}"><input type="hidden" name="RAM" value="${pd.PC_LEVEL_RECORD.RAM}"/></c:if>
								</td>						
							</tr>
							<tr>
					            <td style="width:75px;text-align: right;padding-top: 13px;">硬盘:</td>
								<td>
									<select <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==0}">name="HDISK"</c:if> id="HDISK" style="width:100%;" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}">disabled="disabled"</c:if>>
									
									</select>
									<c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}"><input type="hidden" name="HDISK" value="${pd.PC_LEVEL_RECORD.HDISK}"/></c:if>
								</td>						
							</tr>
							<tr>													
								 <td style="width:75px;text-align: right;padding-top: 13px;" >类型:</td>			
								<td>
									<select <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==0}">name="TYPE"</c:if> id="TYPE" style="width:100%;" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}">disabled="disabled"</c:if>>
										
									</select>
									<c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}"><input type="hidden" name="TYPE" value="${pd.PC_LEVEL_RECORD.TYPE}"/></c:if>
								</td>	
							</tr>
							<tr>
							<td style="width:85px;text-align: right;padding-top: 13px;">房间:</td>
							<td>
								<c:choose>
								   <c:when test="${pd.PC_LEVEL_RECORD.PROJECT_ID == null || pd.PC_LEVEL_RECORD.PROJECT_ID == '' }"> 
								    	
								    <select <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==0}">name="BUILDING"</c:if> id="BUILDING" data-placeholder="请选择状态"  style="vertical-align:top;float:left; width: 33%;height:31px" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}">disabled="disabled"</c:if>>
										
									</select>
									<input type="number" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==0}">name="ROOM"</c:if> id="ROOM" maxlength="50" placeholder="这里输入房间号(例:211)" title="PC编号" style="width:66%;float:right" value="${pd.PC_LEVEL_RECORD.ROOM}" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}">disabled="disabled"</c:if>/>
									<c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}">
										<input type="hidden" name="BUILDING" id="BUILDING" value="${pd.PC_LEVEL_RECORD.BUILDING}"/>
										<input type="hidden" name="ROOM" id="ROOM" value="${pd.PC_LEVEL_RECORD.ROOM}"/>
										<input type="hidden" name="ROOM_NAME" value="${pd.PC_LEVEL_RECORD.ROOM_NAME}"/>
									</c:if>
								   </c:when>
								   <c:otherwise>
								   	<select id="ROOM_NAME" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==0}">name="ROOM_NAME"</c:if> style="vertical-align:top;width: 160px;" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}">disabled="disabled"</c:if>>
								  	<c:forEach items="${rooms}" var="room">
								  		<option value="${room}" <c:if test="${room == pd.PC_LEVEL_RECORD.ROOM_NAME}">selected="selected"</c:if>>${room}</option>
								  	</c:forEach>
								  	</select>
									<c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}"><input type="hidden" name="ROOM_NAME" value="${pd.PC_LEVEL_RECORD.ROOM_NAME}"/></c:if>
								   </c:otherwise>
								</c:choose>
							</td>	
							</tr>
							<tr>
							<td style="width:85px;text-align: right;padding-top: 13px;">台数:</td>
								<td>
									<input type="number" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==0}">name="PCNUMBER"</c:if> id="PCNUMBER" value="${pd.PC_LEVEL_RECORD.PCNUMBER}" class="spinnerExample" step="1" min="1" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}">disabled="disabled"</c:if>/>								
									<c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}"><input type="hidden" name="PCNUMBER" value="${pd.PC_LEVEL_RECORD.PCNUMBER}"/></c:if>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">用途:</td>
								<td>
									<select <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==0}">name="PURPOSE"</c:if> id="PURPOSE" style="width:100%;" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}">disabled="disabled"</c:if>>
										
									</select>
									<c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}"><input type="hidden" name="PURPOSE" value="${pd.PC_LEVEL_RECORD.PURPOSE}"/></c:if>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">入场时间:</td>
								<td>
									<input class="span10 date-picker" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==0}">name="EINLASS"</c:if> id="EINLASS" value="${pd.PC_LEVEL_RECORD.EINLASS}" type="text" data-date-format="yyyy-mm-dd"  placeholder="请输入场时间" title="入场时间" style="width:98%;" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}">disabled="disabled"</c:if>/>
									<c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}"><input type="hidden" name="EINLASS" value="${pd.PC_LEVEL_RECORD.EINLASS}"/></c:if>
								</td>
							</tr>
							<tr>
							<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
							<td>
								<input type="textarea" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==0}">name="REMARK"</c:if> id="REMARK" value="${pd.PC_LEVEL_RECORD.REMARK}" maxlength="255"  title="备注" style="width:98%" <c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}">disabled="disabled"</c:if>/>
								<c:if test="${pd.PC_LEVEL_RECORD.PCSTATE==1}"><input type="hidden" name="REMARK" value="${pd.PC_LEVEL_RECORD.REMARK}"/></c:if>
							</td>	
							</tr>
							
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">提交</a>
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
		$(top.hangge());//关闭加载状态
			  					  		  
		$(function() {			
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
				dataType:'json',
				cache: false,
				success: function(data){
					 $("#NAME").html('<option></option>');
					 $.each(data.programList, function(i, dvar){
						 	if('${pd.PC_LEVEL_RECORD.NAME}' == ''){
						 		$('#PRO').attr("checked", true);
						 		$("#NAME").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
						 	}else if('${pd.PC_LEVEL_RECORD.NAME}' == dvar.NAME){
							    $("#NAME").append("<option value="+dvar.NAME+" selected=true>"+dvar.NAME+"</option>");
						 	}else{
						 		$("#NAME").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
						 	}
					 });
					
					 $("#RAM").html('<option></option>');
					 $.each(data.ramList, function(i, dvar){
						 if('${pd.PC_LEVEL_RECORD.RAM}' == dvar.NAME){
							$("#RAM").append("<option value="+dvar.NAME+" selected=true>"+dvar.NAME+"</option>");
						 }else{
							 $("#RAM").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>"); 
						 }
					 });
					 $("#HDISK").html('<option></option>');
					 $.each(data.hdiskList, function(i, dvar){
						 if('${pd.PC_LEVEL_RECORD.HDISK}' == dvar.NAME){
							$("#HDISK").append("<option value="+dvar.NAME+" selected=true>"+dvar.NAME+"</option>");
						 }else{
							$("#HDISK").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
						 }
					 });
					 $("#TYPE").html('<option></option>');
					 $.each(data.typeList, function(i, dvar){
						 if('${pd.PC_LEVEL_RECORD.TYPE}' == dvar.NAME){
							$("#TYPE").append("<option value="+dvar.NAME+" selected=true>"+dvar.NAME+"</option>");
						 }else{
							$("#TYPE").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>"); 
						 }
					 });
					 $("#PURPOSE").html('<option></option>');
					 if('${pd.PC_LEVEL_RECORD.PROJECT_ID}' == ''){
	 					$("#BUILDING").html('<option></option>');
	 					$.each(data.buildingList, function(i, dvar){
	 						 if('${pd.PC_LEVEL_RECORD.BUILDING}' == dvar.NAMEUse){
	 							$("#BUILDING").append("<option value="+dvar.NAMEUse+" selected=true>"+dvar.NAME+"</option>");
	 						 }else{
	 							 $("#BUILDING").append("<option value="+dvar.NAMEUse+">"+dvar.NAME+"</option>"); 
	 						 }
	 					});
				     }
					 $.each(data.purposeList, function(i, dvar){
						 	if('${pd.PC_LEVEL_RECORD.PURPOSE}' == dvar.NAME){
						 		$("#PURPOSE").append("<option value="+dvar.NAME+" selected=true>"+dvar.NAME+"</option>");
						 	}else{
						 		$("#PURPOSE").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
						 	}
							
					 });
					
				}
			});
			
			//设置项目不可以被修改
			$('#NAME').attr("disabled","disabled");  
			
		});
		
		
		//保存		
		function save(){	
			if($("#RAM").val()==""){
				$("#RAM").tips({
					side:3,
		            msg:'请输入内存',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#RAM").focus();
			return false;
			}
			if($("#HDISK").val()==""){
				$("#HDISK").tips({
					side:3,
		            msg:'请输入硬盘',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#HDISK").focus();
			return false;
			}
			if($("#TYPE").val()==""){
				$("#TYPE").tips({
					side:3,
		            msg:'请输入类型',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#TYPE").focus();
			return false;
			}
			if($("#BUILDING").val()==""){
				$("#BUILDING").tips({
					side:3,
		            msg:'请输入楼栋',
		            bg:'#AE81FF',
		            time:2
		    });
			$("#BUILDING").focus();
			return false;
			}
			if($("#BUILDING").val()==""){
				$("#BUILDING").tips({
					side:3,
		            msg:'请输入楼栋',
		            bg:'#AE81FF',
		            time:2
		    });
			$("#BUILDING").focus();
			return false;
			}
			if($("#ROOM").val()==""){
				$("#ROOM").tips({
					side:3,
		            msg:'请输入房间',
		            bg:'#AE81FF',
		            time:2
		    });
			$("#ROOM").focus();
			return false;
			}
			if($("#PCNUMBER").val()==""){
				$("#PCNUMBER").tips({
					side:3,
		            msg:'请输入台数',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#PCNUMBER").focus();
			return false;
			}
					
			if($("#PURPOSE").val()==""){
				$("#PURPOSE").tips({
					side:3,
		            msg:'请输入用途',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#PURPOSE").focus();
			return false;
			}
			if($("#EINLASS").val()==""){
				$("#EINLASS").tips({
					side:3,
		            msg:'请输入入场时间',
		            bg:'#AE81FF',
		            time:2
		       });
			$("#EINLASS").focus();
			return false;
			}
			$("#Form").attr("action", "backapply/modifyLeave.do");
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			
			//台数控制
			$("#PCNUMBER").on("keyup", function(e) {
				var obj = $("#PCNUMBER"),
				value = obj.val();
				if(value==''|| value==null){
					obj.val('');
				}else if (!(/(^\+?[1-9][0-9]*$)/.test(value))) {
				value = value.substring(0,value.length-1);
				obj.val(1);
				}
			});	
		});
		</script>

</body>
</html>