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
					<form action="fittingsmanager/edit.do" name="Form" id="Form" method="post">
						<input type="hidden" name="FIT_ID" id="FIT_ID" value="${pd.FIT_ID}"/>
						<input type="hidden" name="FITTINGS_NO" id="FITTINGS_NO" value="${pd.FITTINGS_NO}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">配件名称:</td>
								<td style="vertical-align:top;padding-left:2px;">
								 	${fittingsDetail.TYPENAME}
								</td>
								<td style="width:75px;text-align: right;padding-top: 13px;">配件编号:</td>
								<td style="vertical-align:top;padding-left:2px;">
								  ${fittingsDetail.FITTINGS_NO}
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">配件参数:</td>
								<td style="vertical-align:top;padding-left:2px;">
								 	
								</td>
							</tr>
							<tbody id="J_TbData">
							<c:forEach items="${propertisList}" var="propertis">
							<tr>
								<td>${propertis.FITTINGS_NAME}</td>
								<td>
									<c:if test="${propertis.isSelect}">
										<select name="FITTINGSTYPE${propertis.FITTINGS_DATAS}" id="FITTINGSTYPE${propertis.FITTINGS_DATAS}">
											<c:forEach items="${propertis.valueList}" var="datavalue">
												<option value="${datavalue.FITTINGS_ID }" <c:if test="${propertis.FITTINGS_DATAVALUE==datavalue.FITTINGS_ID}">selected="selected"</c:if>>${datavalue.FITTINGS_NAME}</option>
											</c:forEach>
										</select>
									</c:if>
									<c:if test="${!propertis.isSelect}">
										<input name="${propertis.FITTINGS_DATAS}" id="${propertis.FITTINGS_DATAS}" value="${propertis.FITTINGS_DATAVALUE}"/>
									</c:if>
								</td>
							</tr>
							</c:forEach>
                            </tbody>	
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
		
		<%-- $(function(){
			$("#FITTINGS_ID").change(function(){
			var id=$("#FITTINGS_ID").val();
			if(id!='1'){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>fittingsmanager/fittingstype.do?tm='+new Date().getTime()+'&PARENT_ID='+id,
				dataType:'json',
				cache: false,
				success: function(data){
						$("#J_TbData").html("");
					     $.each(data.varList, function(i, dvar){
						  if(typeof(dvar.FITTINGS_NAME)=="undefined"){
							  dvar.FITTINGS_NAME="";
						  }
						   var $trTemp = $("<tr></tr>");
			                $trTemp.append('&nbsp&nbsp&nbsp<td style="border:none;">'+dvar.FITTINGS_NAME+':</td>');
			                if(dvar.input=="1"){
			                	$trTemp.append('<td><input type="text" name='+dvar.FITTINGS_ID+' id='+dvar.FITTINGS_ID+' /></td>');
			                }else{
			                	$trTemp.append('<td><select name="FITTINGSTYPE'+dvar.FITTINGS_ID+'" id="FITTINGSTYPE'+dvar.FITTINGS_ID+'" style="width:98%;"></select></td>');
			                }
			                var fittingsid=dvar.FITTINGS_ID;
			                $trTemp.appendTo("#J_TbData");
			                $.ajax({
								type: "POST",
								url: '<%=basePath%>fittings/fittingstype.do?tm='+new Date().getTime()+'&PARENT_ID='+fittingsid,
								dataType:'json',
								cache: false,
								success: function(data){
									$.each(data.varList, function(i, dvar2){
										$("#FITTINGSTYPE"+fittingsid+"").append("<option value="+dvar2.FITTINGS_ID+">"+dvar2.FITTINGS_NAME+"</option>");
									});
								}
			                });
				          });
					   document.getElementById("J_TbData").style.display="";
				 }
			});
			}
			else{
				$("#J_TbData").html("");
			}
		});
		}); --%>
		
		//保存
		function save(){
			if($("#FITTINGS_ID").val()==""){
				$("#FITTINGS_ID").tips({
					side:3,
		            msg:'请选择配件名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FITTINGS_ID").focus();
			return false;
			}
			if($("#FITTINGS_NO").val()==""){
				$("#FITTINGS_NO").tips({
					side:3,
		            msg:'请输入配件编号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FITTINGS_NO").focus();
			return false;
			}
			if($("#FITTINGS_VALUE").val()==""){
				$("#FITTINGS_VALUE").tips({
					side:3,
		            msg:'请选择参数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FITTINGS_VALUE").focus();
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