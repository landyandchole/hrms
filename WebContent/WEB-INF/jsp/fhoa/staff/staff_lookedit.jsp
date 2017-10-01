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
					
					<form action="staff/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="STAFF_ID" id="STAFF_ID" value="${pd.STAFF_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">姓名:</td>
								<td><input disabled="disabled" type="text" name="staffNAME" id="staffNAME" value="${pd.NAME}" maxlength="50" placeholder="这里输入姓名" title="姓名" style="width:98%;"/></td>
								<td style="width:75px;text-align: right;padding-top: 13px;">工号:</td>
								<td>
								<input disabled="disabled" type="text" name="NO" id="NO" value="${pd.NO}" maxlength="100" placeholder="这里输入工号" title="工号"  readonly="true" style="width:98%;"/>
								</td>
								<td style="width:75px;text-align: right;padding-top: 13px;">性别:</td>			
								<td>
									<select disabled="disabled" class="SEX" name="SEX" id="SEX" style="width:98%;">
									    <option>请选择</option>
										<option value="1" <c:if test="${pd.SEX == '1'}">selected</c:if>>男</option>
										<option value="0" <c:if test="${pd.SEX == '0'}">selected</c:if>>女</option>
									</select>
								</td>								
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">毕业学校:</td>
								<td><input disabled="disabled" type="text" name="SCHOOL" id="SCHOOL" value="${pd.SCHOOL}" maxlength="30" placeholder="这里输入毕业学校" title="毕业学校" style="width:98%;"/></td>
								<td style="width:75px;text-align: right;padding-top: 13px;">入职日期:</td>
								<td><input disabled="disabled" class="span10 date-picker" name="ENTRY_DATE" id="ENTRY_DATE" value="${pd.ENTRY_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="请输入入职时间" title="入职时间" style="width:100%;"/></td>
								<td style="width:75px;text-align: right;padding-top: 13px;">状态:</td>
								<td>
									<select disabled="disabled" name="STATUS" id="STATUS" style="width:100%;">									
									</select>
								</td>								
							</tr>
							<tr>
							    <td style="width:75px;text-align: right;padding-top: 13px;">手机号码:</td>
								<td><input disabled="disabled" type="text" name="TEL" id="TEL" value="${pd.TEL}" onkeyup="this.value=this.value.replace(/\D/g,'')"  
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="30" placeholder="这里输入手机号码" title="手机号码" style="width:98%;"/></td>
							     <td style="width:79px;text-align: right;padding-top: 13px;">邮箱:</td>
								<td><input type="email" disabled="disabled" name="EMAIL" id="EMAIL"  value="${pd.EMAIL }" maxlength="32" placeholder="这里输入邮箱" title="邮箱"  style="width:98%;" /></td>						
							</tr>
							<tr>													
								<td style="width:75px;text-align: right;padding-top: 13px;">家庭住址:</td>
								<td colspan="10"><input type="text" disabled="disabled" name="ADDRESS" id="ADDRESS" value="${pd.ADDRESS}" maxlength="100" placeholder="这里输入家庭住址" title="家庭住址" style="width:98%;"/></td>
							</tr>
						</table>
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:15px;text-align: right;padding-top: 13px;">开发组:</td>
								<td>
									<input type="hidden" disabled="disabled" name="DEPARTMENT_ID" id="DEPARTMENT_ID" value="${pd.DEPARTMENT_ID}"/>
									<div class="selectTree" disabled="disabled" id="selectTree"></div>
								</td>
								<td style="width:60px;text-align: right;padding-top: 13px;">职称:</td>
								<td>
								   <select name="TITLE" disabled="disabled" id="TITLE" style="width:98%;">								 	
									</select>
								</td>
								
							</tr>							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">毕业时间:</td>
								<td><input disabled="disabled" class="span10 date-picker" name="GRADUATE_DATE" id="GRADUATE_DATE" value="${pd.GRADUATE_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="请输入毕业时间" title="毕业时间" style="width:98%;"/></td>								
								<td style="width:75px;text-align: right;padding-top: 13px;">离职时间:</td>
								<td><input disabled="disabled" class="span10 date-picker" name="LEAVE_DATE" id="LEAVE_DATE" value="${pd.LEAVE_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="请输入离职时间" title="离职时间" style="width:95%;"/></td>
							</tr>
							<tr>								
								<td style="width:75px;text-align: right;padding-top: 13px;">返校时间:</td>
								<td><input disabled="disabled" class="span10 date-picker" name="BACKSCHOOL_DATE" id="BACKSCHOOL_DATE" value="${pd.BACKSCHOOL_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="请输入返校时间" title="返校时间" style="width:98%;"/></td>
								<td style="width:75px;text-align: right;padding-top: 13px;">回公司时间:</td>
								<td><input disabled="disabled" class="span10 date-picker" name="BACKCOMPANY_DATE" id="BACKCOMPANY_DATE" value="${pd.BACKCOMPANY_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="请输入回公司时间" title="回公司时间" style="width:98%;"/></td>
							</tr>
						</table>
						
						<table id="table_report" class="table table-striped table-bordered table-hover">																									
							<tr>						
							 <!--    <td style="width:75px;text-align: right;padding-top: 13px;">权限组:</td>
								<td>									
								   <select name="ROLE_ID" id="ROLE_ID" style="width:98%;">										
									</select>
							    </td> -->
								<td style="width:75px;text-align: right;padding-top: 13px;">日语水平:</td>
								<td>
									<select disabled="disabled" name="JAPANESE" id="JAPANESE" onchange="change1(this.value)" style="width:98%;">
																
									</select>
								</td>
								<td style="width:75px;text-align: right;padding-top: 13px;">英语水平:</td>
								<td>
									<select disabled="disabled" name="ENGLISH" id="ENGLISH" style="width:98%;">			
									<%-- <option > "${pd.ENGLISH}"</option> --%>							
									</select>
								</td>
							</tr>
							<tr>
	
								<td style="width:75px;text-align: right;padding-top: 13px;">护照有无:</td>
								<td>
									<select disabled="disabled" name="PASS" id="PASS" style="width:98%;">
										<option></option>
										<option value="0"  <c:if test="${pd.PASS == '0'}"> selected</c:if>>否</option>
										<option value="1" <c:if test="${pd.PASS == '1'}">selected</c:if>>有</option>
									</select>
								</td>
								<td style="width:85px;text-align: center;padding-top: 13px;">护照期限:</td>
								<td><input disabled="disabled" class="span10 date-picker" name="PASS_TERM" id="PASS_TERM" value="${pd.PASS_TERM}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="这里输入护照有效期" title="护照有效期" style="width:98%;"/></td>
							</tr>
							<tr>
							<td style="width:75px;text-align: right;padding-top: 13px;">签证有无:</td>
								<td>
									<select disabled="disabled" name="VISA" id="VISA" style="width:98%;">
									    <option></option>
										<option value="0" <c:if test="${pd.VISA == '0'}">selected</c:if>>否</option>
										<option value="1" <c:if test="${pd.VISA == '1'}">selected</c:if>>有</option>
									</select>
								</td>
								<td style="width:75px;text-align: right;padding-top: 13px;">签证类型:</td>
								<td>
									<select disabled="disabled" name="VISA_TYPE" id="VISA_TYPE" style="width:98%;">
									    <option></option>
										<option value="0" <c:if test="${pd.VISA_TYPE == '0'}">selected</c:if>>单次</option>
										<option value="1" <c:if test="${pd.VISA_TYPE == '1'}">selected</c:if>>多次</option>
									</select>
								</td>
								<td style="width:75px;text-align: right;padding-top: 13px;">出差类型:</td>
								<td>
									<select disabled="disabled" name="TRAVEL_TYPE" id="TRAVEL_TYPE" style="width:98%;">									
									</select>
								</td>
							</tr>						
						</table>
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">技术强项:</td>
								<td><input disabled="disabled" type="text" name="STRENGTHS" id="STRENGTHS" value="${pd.STRENGTHS}" maxlength="255" placeholder="这里输入技术强项" title="技术强项" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发展意向:</td>
								<td><input disabled="disabled" type="text" name="DEVELOP_INTENT" id="DEVELOP_INTENT" value="${pd.DEVELOP_INTENT}" maxlength="255" placeholder="这里输入发展意向" title="发展意向" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">离职原因:</td>
								<td><input disabled="disabled" type="text" name="LEAVE_REASON" id="LEAVE_REASON" value="${pd.LEAVE_REASON}" maxlength="255" placeholder="这里输入离职原因" title="离职原因" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input disabled="disabled" type="text" name="MEMO" id="MEMO" value="${pd.MEMO}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
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
		
		$(function(){

			$('#SEX').one("change",function () {
			    $(this).children().eq(0).remove();
			});
			$('#JAPANESE').one("change",function () {
			    $(this).children().eq(0).remove();
			});
			$('#ENGLISH').one("change",function () {
			    $(this).children().eq(0).remove();
			});
			$('#TITLE').one("change",function () {
			    $(this).children().eq(0).remove();
			});
			$('#TRAVEL_TYPE').one("change",function () {
			    $(this).children().eq(0).remove();
			});
			$('#STATUS').one("change",function () {
			    $(this).children().eq(0).remove();
			});
			/* $('#ROLE_ID').change(function () {
			    $(this).children().eq(0).remove();
			}); */
			$('#VISA').one("change",function () {
			    $(this).children().eq(0).remove();
			});
			$('#VISA_TYPE').one("change",function () {
			    $(this).children().eq(0).remove();
			})
		});
		//初始第一级
		 $(function() {		
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
				dataType:'json',
				cache: false,
				success: function(data){
				    $("#JAPANESE").html('<option value=""></option>'); 
					 $.each(data.list, function(i, dvar){	
						  $("#JAPANESE").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");  
					 });
					  $("#ENGLISH").html('<option value=""></option>'); 					
					 $.each(data.englishlist, function(i, dvar){
						 $("#ENGLISH").append("<option  value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");												
					 });

					 $("#TITLE").html('<option value=""></option>');
					 $.each(data.titlelist, function(i, dvar){
							$("#TITLE").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });

					 $("#TRAVEL_TYPE").html('<option value=""></option>');
					 $.each(data.travelTypelist, function(i, dvar){
							$("#TRAVEL_TYPE").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });

					 $("#STATUS").html('<option value=""></option>');
					 $.each(data.statuslist, function(i, dvar){
							$("#STATUS").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
						$("#JAPANESE").val("${pd.JAPANESE}");
						$("#ENGLISH").val("${pd.ENGLISH}");
						$("#TITLE").val("${pd.TITLE}");
						$("#TRAVEL_TYPE").val("${pd.TRAVEL_TYPE}");
						$("#STATUS").val("${pd.STATUS}");
				}
			});
		});
		 
		
		
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
		//下拉树
		var defaultNodes = {"treeNodes":${zTreeNodes}};
		function initComplete(){
			//绑定change事件
			$("#selectTree").bind("change",function(){
				if(!$(this).attr("relValue")){
			      //  top.Dialog.alert("没有选择节点");
			    }else{
					//alert("选中节点文本："+$(this).attr("relText")+"<br/>选中节点值："+$(this).attr("relValue"));
					$("#DEPARTMENT_ID").val($(this).attr("relValue"));
			    }
			});
			//赋给data属性
			$("#selectTree").data("data",defaultNodes);  
			$("#selectTree").render();
			$("#selectTree2_input").val("${null==depname?'请选择':depname}");
		}

		</script>
</body>
</html>