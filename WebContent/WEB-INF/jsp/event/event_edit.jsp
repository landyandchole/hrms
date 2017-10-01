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
<%@ include file="../system/index/foot.jsp"%>
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
					<!-- <script>alert('eventid:${pd.EVENT_ID}');</script> -->
					<form action="event/edit.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
						<input type="hidden" name="EVENT_ID" id="EVENT_ID" value="${pd.EVENT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:95px;text-align: right;padding-top: 13px;">事件名称:</td>
								<td><input type="text" name="EVENT_NAME" id="EVENT_NAME" value="${pd.EVENT_NAME}" maxlength="255" placeholder="这里输入事件名称" title="事件名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:105px;text-align: right;padding-top: 13px;">事件发起人:</td>
								<td><input type="text" name="EVENT_PERSON" id="EVENT_PERSON" value="${pd.EVENT_PERSON}" maxlength="255" placeholder="这里输入事件发起人" title="事件发起人" style="width:98%;"/></td>
							</tr>
							 <tr>
								<td style="width:105px;text-align: right;padding-top: 13px;">事件发起日期:</td>
								<td><input class="span10 date-picker" name="EVENT_DDATE" id="EVENT_DDATE" value="${pd.EVENT_DDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="事件发起日期" title="事件发起日期" style="width:98%;"/></td>
							</tr>
							<tr> 
								<td style="width:105px;text-align: right;padding-top: 13px;">事件截至日期:</td>
								<td><input class="span10 date-picker" name="EVENT_DATE" id="EVENT_DATE" value="${pd.EVENT_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="事件截至日期" title="事件截至日期" style="width:98%;"/></td>
							</tr>
						<tr>
								<td style="width:105px;text-align: right;padding-top: 13px;" >文件:</td>
								<td>
									<input type="file" id="EVENT_FILE1" name="EVENT_FILE1" id="uploadify1" keepDefaultStyle = "true"/>
									<input type="hidden" name="EVENT_FILE" id="EVENT_FILE" value="${pd.EVENT_FILE}"/>
								</td>
							</tr>
							<tr>
								<td style="width:105px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="EVENT_BS" id="EVENT_BS" value="${pd.EVENT_BS}" maxlength="255" placeholder="这里输入备注" title="附件" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
							<tr>
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
	<%@ include file="../system/index/top.jsp"%>
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
				$("#EVENT_NAME").focus();
			return false;
			}
			if($("#EVENT_PERSON").val()==""){
				$("#EVENT_PERSON").tips({
					side:3,
		            msg:'请输入事件发起人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EVENT_PERSON").focus();
			return false;
			}
			if($("#EVENT_BS").val()==""){
				$("#EVENT_BS").tips({
					side:3,
		            msg:'请输入附件',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EVENT_BS").focus();
			return false;
			}
			if($("#EVENT_FILE").val()==""){
				$("#EVENT_FILE1").tips({
					side:3,
		            msg:'请上传附件',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EVENT_FILE1").focus();
			return false;
			}
			if($("#EVENT_DDATE").val()==""){
				$("#EVENT_DDATE").tips({
					side:3,
		            msg:'请输入事件发起日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EVENT_DDATE").focus();
			return false;
			}
			if($("#EVENT_DATE").val()==""){
				$("#EVENT_DATE").tips({
					side:3,
		            msg:'请输入事件截至日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EVENT_DATE").focus();
			return false;
			}
		  if($("#EVENT_DDATE").val()!= "" && $("#EVENT_DATE").val() != ""){
				var t1 = $("#EVENT_DDATE").val();
				var t2 = $("#EVENT_DATE").val();
				t1 = Number(t1.replace('-', '').replace('-', ''));
				t2 = Number(t2.replace('-', '').replace('-', ''));
				if(t1-t2>0){
						$("#EVENT_DATE").tips({
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
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
 	/* 	function formSubmit(){  
		    var action="event/${msg }.do";         
		    action+="?otherName="+document.upload.otherName.value;  
		    document.upload.action=action;        
		    document.upload.submit();  
		}  */
 	</script>
 	
</body>
</html>