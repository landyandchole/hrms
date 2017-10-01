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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>

<body class="no-skin">
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							
					
					<form action="pccheck/${msg}.do" method="post" id="testform" enctype="mutipart/form-data">
					
					<div id="zhongxin" style="padding-top: 13px;">
					<input  type="hidden" name="PC_ID" id="PC_ID" value="${pd.PC_ID}" />
					<input  type="hidden" name="PC_NO" id="PC_NO" value="${pd.PC_NO}" />
					<input  type="hidden" name="CHECK_ID" id="CHECK_ID" value="${pd.CHECK_ID}" >
					<input  type="hidden" name="EXIT_DATE" id="EXIT_DATE" value="${pd.EXIT_DATE}" >
					<input  type="hidden" name="PC_STATE" id="PC_STATE" value="${pd.PC_STATE}"/>
					<input type="hidden" name="msg" id="msg" value="${msg}" />
					<input type="hidden" name="CHECK_TYPE" id="CHECK_TYPE" value="${pd.CHECK_TYPE}" />
					<c:if test="${pd.CHECK_TYPE == -1 ||pd.CHECK_TYPE == 0}">
					<table id="table1" style="margin-top:5px;" class="table table-striped table-bordered table-hover">
							<tr>
							<td>检查类型:</td>
							    <c:if test="${pd.CHECK_TYPE == -1}">
								<td style="vertical-align:top;padding-left:2px;">
									 <input class="nCHECK_TYPE" type="text" id="nCHECK_TYPE" name="nCHECK_TYPE"  value="入场检查" readonly="readonly" style="width:98%;"/>
								</td>	
								</c:if>
								<c:if test="${pd.CHECK_TYPE == 0}">
								<td style="vertical-align:top;padding-left:2px;">
									 <input class="nCHECK_TYPE" type="text" id="nCHECK_TYPE" name="nCHECK_TYPE"  value="月别检查" readonly="readonly" style="width:98%;"/>
								</td>	
								</c:if>	
								<td>检查时间：</td>		
								<td><input class="span10 date-picker" name="CHECK_DATE" id="CHECK_DATE" value="${pd.CHECK_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="检查时间" title="检查时间" style="width:98%;"/></td>	
											
							<td id="m">
							<label>
							                            <input  class="ace m"  type="radio" name="a1" id="selAll" > 
							                              <span class="lbl">已检查</span>
							</label> 
							<label>
														<input  class="ace v"  type="radio"  name="a1" id="choAll" > 
														 <span class="lbl">未检查 </span>
                           </label>  
                           <label>
														<input  class="ace p"   type="radio" name="a1" id="sel"> 
														 <span class="lbl">无需检查</span>
							</label> 
							</td>
							</tr>
							</table>
							
							<table  id="thead1" style="margin-top:5px;" class="table table-striped table-bordered table-hover">
								<tr>
								
									<th class="center">密码设置</th>
									<td id="t1">
												<label>
														<input name="PASSWORDSET" class="ace m" value="Y"
														id="PASSWORDSET" type="radio"
														<c:if test="${pd.PASSWORDSET == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="PASSWORDSET" class="ace v" value="N"
														id="PASSWORDSET" type="radio"
														<c:if test="${pd.PASSWORDSET == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="PASSWORDSET" class="ace p" value="--"
														id="PASSWORDSET" type="radio"
														<c:if test="${pd.PASSWORDSET == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">密码更新</th>
									<td id="t2">
												<label>
														<input name="PASSWORDUP" class="ace m" value="Y"
														id="PASSWORDUP" type="radio"
														<c:if test="${pd.PASSWORDUP == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="PASSWORDUP" class="ace v" value="N"
														id="PASSWORDUP" type="radio"
														<c:if test="${pd.PASSWORDUP == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="PASSWORDUP" class="ace p" value="--"
														id="PASSWORDUP" type="radio"
														<c:if test="${pd.PASSWORDUP == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">屏保设置</th>
									<td id="t3">
												<label>
														<input name="SCREEN" class="ace m" value="Y"
														id="SCREEN" type="radio"
														<c:if test="${pd.SCREEN == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="SCREEN" class="ace v" value="N" 
														id="SCREEN" type="radio"
														<c:if test="${pd.SCREEN == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="SCREEN" class="ace p" value="--"
														id="SCREEN" type="radio"
														<c:if test="${pd.SCREEN == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												
												</td>
									<th class="center">病毒检查</th>
									<td id="t4">
												<label>
														<input name="VIRUS_CHECK" class="ace m" value="Y"
														id="VIRUS_CHECK" type="radio"
														<c:if test="${pd.VIRUS_CHECK == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="VIRUS_CHECK" class="ace v" value="N"
														id="VIRUS_CHECK" type="radio"
														<c:if test="${pd.VIRUS_CHECK == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="VIRUS_CHECK" class="ace p" value="--"
														id="VIRUS_CHECK" type="radio"
														<c:if test="${pd.VIRUS_CHECK == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
								</tr>
								<tr>
									<th class="center">病毒隔离区检查</th>
									<td id="t5">
												<label>
														<input name="VIRUS_ISOLATION" class="ace m" value="Y"
														id="VIRUS_ISOLATION" type="radio"
														<c:if test="${pd.VIRUS_ISOLATION == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="VIRUS_ISOLATION" class="ace v" value="N"
														id="VIRUS_ISOLATION" type="radio"
														<c:if test="${pd.VIRUS_ISOLATION == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="VIRUS_ISOLATION" class="ace p" value="--"
														id="VIRUS_ISOLATION" type="radio"
														<c:if test="${pd.VIRUS_ISOLATION == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">WINDOWS激活确认</th>
									<td id="t6">
												<label>
														<input name="WINDOWS_ACTIVE" class="ace m" value="Y"
														id="WINDOWS_ACTIVE" type="radio"
														<c:if test="${pd.WINDOWS_ACTIVE == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="WINDOWS_ACTIVE" class="ace v" value="N"
														id="WINDOWS_ACTIVE" type="radio"
														<c:if test="${pd.WINDOWS_ACTIVE == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="WINDOWS_ACTIVE" class="ace p" value="--"
														id="WINDOWS_ACTIVE" type="radio"
														<c:if test="${pd.WINDOWS_ACTIVE == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">UPDATE更新确认</th>
									<td id="t7">
												<label>
														<input name="UPDATE_CONFIRM" class="ace m" value="Y"
														id="UPDATE_CONFIRM" type="radio"
														<c:if test="${pd.UPDATE_CONFIRM == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="UPDATE_CONFIRM" class="ace v" value="N"
														id="UPDATE_CONFIRM" type="radio"
														<c:if test="${pd.UPDATE_CONFIRM == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="UPDATE_CONFIRM" class="ace p" value="--"
														id="UPDATE_CONFIRM" type="radio"
														<c:if test="${pd.UPDATE_CONFIRM == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">OFFICE激活确认</th>
									<td id="t8">
												<label>
														<input name="OFFICE_ACTIVE" class="ace m" value="Y"
														id="OFFICE_ACTIVE" type="radio"
														<c:if test="${pd.OFFICE_ACTIVE == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="OFFICE_ACTIVE" class="ace v" value="N"
														id="OFFICE_ACTIVE" type="radio"
														<c:if test="${pd.OFFICE_ACTIVE == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="OFFICE_ACTIVE" class="ace p" value="--"
														id="OFFICE_ACTIVE" type="radio"
														<c:if test="${pd.OFFICE_ACTIVE == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
								</tr>
								<tr>
									<th class="center">最近病毒下载</th>
									<td id="t9">
												<label>
														<input name="NEWVIRUS_UPLOAD" class="ace m" value="Y"
														id="NEWVIRUS_UPLOAD" type="radio"
														<c:if test="${pd.NEWVIRUS_UPLOAD == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="NEWVIRUS_UPLOAD" class="ace v" value="N"
														id="NEWVIRUS_UPLOAD" type="radio"
														<c:if test="${pd.NEWVIRUS_UPLOAD == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="NEWVIRUS_UPLOAD" class="ace p" value="--"
														id="NEWVIRUS_UPLOAD" type="radio"
														<c:if test="${pd.NEWVIRUS_UPLOAD == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">白名单RL</th>
									<td id="t10">
												<label>
														<input name="WHITE_LIST" class="ace m" value="Y"
														id="WHITE_LIST" type="radio"
														<c:if test="${pd.WHITE_LIST == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="WHITE_LIST" class="ace v" value="N"
														id="WHITE_LIST" type="radio"
														<c:if test="${pd.WHITE_LIST == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="WHITE_LIST" class="ace p" value="--"
														id="WHITE_LIST" type="radio"
														<c:if test="${pd.WHITE_LIST == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">电脑接线口固定确认</th>
									<td id="t11">
												<label>
														<input name="PORT_FASTEN" class="ace m" value="Y"
														id="PORT_FASTEN" type="radio"
														<c:if test="${pd.PORT_FASTEN == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="PORT_FASTEN" class="ace v" value="N"
														id="PORT_FASTEN" type="radio"
														<c:if test="${pd.PORT_FASTEN == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="PORT_FASTEN" class="ace p" value="--"
														id="PORT_FASTEN" type="radio"
														<c:if test="${pd.PORT_FASTEN == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">USB禁用检查</th>
									<td id="t12">
												<label>
														<input name="USB_DISABLE" class="ace m" value="Y"
														id="USB_DISABLE" type="radio"
														<c:if test="${pd.USB_DISABLE == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="USB_DISABLE" class="ace v" value="N"
														id="USB_DISABLE" type="radio"
														<c:if test="${pd.USB_DISABLE == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="USB_DISABLE" class="ace p" value="--"
														id="USB_DISABLE" type="radio"
														<c:if test="${pd.USB_DISABLE == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
								</tr>
								<tr>
									<th class="center">禁用文件交换软件</th>
									<td id="t13">
												<label>
														<input name="FILEEXCHANGE_DISABLE" class="ace m" value="Y"
														id="FILEEXCHANGE_DISABLE" type="radio"
														<c:if test="${pd.FILEEXCHANGE_DISABLE == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="FILEEXCHANGE_DISABLE" class="ace v" value="N"
														id="FILEEXCHANGE_DISABLE" type="radio"
														<c:if test="${pd.FILEEXCHANGE_DISABLE == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="FILEEXCHANGE_DISABLE" class="ace p" value="--"
														id="FILEEXCHANGE_DISABLE" type="radio"
														<c:if test="${pd.FILEEXCHANGE_DISABLE == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									
									
								</tr>
						         <tr>													
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td colspan="10"><input type="text" name="REMARK" id="REMARK" value="${pd.REMARK}" maxlength="100" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							    </tr>	
						</table>
						</c:if>
						
			   <c:if test="${pd.CHECK_TYPE == 1}">  
			   <table id="table2" style="margin-top:5px;" class="table table-striped table-bordered table-hover">
							<tr>
							<td>检查类型:</td>
								<td style="vertical-align:top;padding-left:2px;">
									 <input class="nCHECK_TYPE" type="text" id="nCHECK_TYPE" name="nCHECK_TYPE"  value="退场检查" readonly="readonly" style="width:98%;"/>
								</td>	
								<td>检查时间：</td>		
								<td><input class="span10 date-picker" name="CHECK_DATE" id="CHECK_DATE" value="${pd.CHECK_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="检查时间" title="检查时间" style="width:98%;"/></td>	
											
							<td id="n">
							<label>
							                            <input  class="ace m"  type="radio" name="b1" id="selAll" > 
							                              <span class="lbl">已检查</span>
							</label> 
							<label>
														<input  class="ace v"  type="radio" name="b1" id="choAll" > 
														 <span class="lbl">未检查 </span>
                           </label>  
                           <label>
														<input  class="ace p"   type="radio" name="b1" id="sel"> 
														 <span class="lbl">无需检查</span>
							</label> 
							</td>
							</tr>
							</table>
			   
			       
			         
				   <table id="thead2" class="table table-striped table-bordered table-hover" style="margin-top:5px; " >
					<tr height="30px"></tr>	
								<tr>
									<th class="center">C盘以外格式化</th>
									<td id="t14" >
												<label>
														<input name="C_FOMAT" class="ace m" value="Y"
														id="C_FOMAT" type="radio"
														<c:if test="${pd.C_FOMAT == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="C_FOMAT" class="ace v" value="N"
														id="C_FOMAT" type="radio"
														<c:if test="${pd.C_FOMAT == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="C_FOMAT" class="ace p" value="--"
														id="C_FOMAT" type="radio"
														<c:if test="${pd.C_FOMAT == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">C盘系统还原</th>
									<td id="t15">
												<label>
														<input name="C_RESTORY" class="ace m" value="Y"
														id="C_RESTORY" type="radio"
														<c:if test="${pd.C_RESTORY == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="C_RESTORY" class="ace v" value="N"
														id="C_RESTORY" type="radio"
														<c:if test="${pd.C_RESTORY == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="C_RESTORY" class="ace p" value="--"
														id="C_RESTORY" type="radio"
														<c:if test="${pd.C_RESTORY == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">垃圾箱清空</th>
									<td id="t16">
												<label>
														<input name="GC_CLEAR" class="ace m" value="Y"
														id="GC_CLEAR" type="radio"
														<c:if test="${pd.GC_CLEAR == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="GC_CLEAR" class="ace v" value="N"
														id="GC_CLEAR" type="radio"
														<c:if test="${pd.GC_CLEAR == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="GC_CLEAR" class="ace p" value="--"
														id="GC_CLEAR" type="radio"
														<c:if test="${pd.GC_CLEAR == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">无EXCEL文件</th>
									<td id="t17">
												<label>
														<input name="NO_EXCEL" class="ace m" value="Y"
														id="NO_EXCEL" type="radio"
														<c:if test="${pd.NO_EXCEL == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="NO_EXCEL" class="ace v" value="N"
														id="NO_EXCEL" type="radio"
														<c:if test="${pd.NO_EXCEL == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="NO_EXCEL" class="ace p" value="--"
														id="NO_EXCEL" type="radio"
														<c:if test="${pd.NO_EXCEL == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
								</tr>
								<tr>
									<th class="center">病毒隔离区检查</th>
									<td id="t18">
												<label>
														<input name="VIRUS_ISOLATION2" class="ace m" value="Y"
														id="VIRUS_ISOLATION2" type="radio"
														<c:if test="${pd.VIRUS_ISOLATION == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="VIRUS_ISOLATION2" class="ace v" value="N"
														id="VIRUS_ISOLATION2" type="radio"
														<c:if test="${pd.VIRUS_ISOLATION == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="VIRUS_ISOLATION2" class="ace p" value="--"
														id="VIRUS_ISOLATION2" type="radio"
														<c:if test="${pd.VIRUS_ISOLATION == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">WINDOWS激活确认</th>
									<td id="t19">
												<label>
														<input name="WINDOWS_ACTIVE2" class="ace m" value="Y"
														id="WINDOWS_ACTIVE2" type="radio"
														<c:if test="${pd.WINDOWS_ACTIVE == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="WINDOWS_ACTIVE2" class="ace v" value="N"
														id="WINDOWS_ACTIVE2" type="radio"
														<c:if test="${pd.WINDOWS_ACTIVE == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="WINDOWS_ACTIVE2" class="ace p" value="--"
														id="WINDOWS_ACTIVE2" type="radio"
														<c:if test="${pd.WINDOWS_ACTIVE == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">OFFICE激活确认</th>
									<td id="t20">
												<label>
														<input name="OFFICE_ACTIVE2" class="ace m" value="Y"
														id="OFFICE_ACTIVE2" type="radio"
														<c:if test="${pd.OFFICE_ACTIVE == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="OFFICE_ACTIVE2" class="ace v" value="N"
														id="OFFICE_ACTIVE2" type="radio"
														<c:if test="${pd.OFFICE_ACTIVE == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="OFFICE_ACTIVE2" class="ace p" value="--"
														id="OFFICE_ACTIVE2" type="radio"
														<c:if test="${pd.OFFICE_ACTIVE == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label>
												</td>
									<th class="center">USB禁用</th>
									<td id="t21">
												<label>
														<input name="USB_DISABLE2" class="ace m" value="Y"
														id="USB_DISABLE2" type="radio"
														<c:if test="${pd.USB_DISABLE == 'Y'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="USB_DISABLE2" class="ace v" value="N"
														id="USB_DISABLE2" type="radio"
														<c:if test="${pd.USB_DISABLE == 'N'}">checked="checked"</c:if>> <span
														class="lbl"></span>

												</label> <label>
														<input name="USB_DISABLE2" class="ace p" value="--"
														id="USB_DISABLE2" type="radio"
														<c:if test="${pd.USB_DISABLE == '--'}">checked="checked"</c:if>> <span
														class="lbl"></span>
												</label>
												</td>
					
								</tr>
								<tr>													
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td colspan="10"><input type="text" name="REMARK" id="REMARK" value="${pd.REMARK}" maxlength="100" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							    </tr>					
						</table>
						  </c:if>
		                  <table align = "center">
		                    <tr>
								<td style="text-align: center;" colspan="10">
									<a id = "b1" class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
					</div>
					</form>		
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			
		</div>
		<!-- /.main-content -->

		<!-- 返回?部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
</div>
	<!-- /.main-container -->
	
</div>
	<!-- basic scripts -->
	<!-- ?面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ?除???窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());
	//保存
	     $(function(){
		  $('#CHECK_TYPE').one("change",function () {
		    $(this).children().eq(0).remove();
		  });
		
	     });
	
	
	     
	     
	     $(function(){
	         //全选和全不选
	         $('#selAll').bind('click',function(){
	             if(this.checked){    //全选
	            	 $("input.m").each(function(){
	                         $(this).prop('checked',true);
	                     });
	                 }else{    //全不选
	                	 $("input.m").each(function(){
	                         $(this).prop('checked',false);
	                     });
	                     }
	             });
	               });
	
	     $(function(){
	         //全选和全不选
	         $('#choAll').bind('click',function(){
	             if(this.checked){    //全选
	            	 $("input.v").each(function(){
	                         $(this).prop('checked',true);
	                     });
	                 }else{    //全不选
	                	 $("input.v").each(function(){
	                         $(this).prop('checked',false);
	                     });
	                     }
	             });
	               });
	     
	     $(function(){
	         //全选和全不选
	         $('#sel').bind('click',function(){
	             if(this.checked){    //全选
	            	 $("input.p").each(function(){
	                         $(this).prop('checked',true);
	                     });
	                     
	             
	                 }else{    //全不选
	                	 $("input.p").each(function(){
	                         $(this).prop('checked',false);
	                     });
	                     }
	             });
	               });
     //保存		
		function save(){	
			if($("#CHECK_DATE").val()==""){
				$("#CHECK_DATE").tips({
					side:3,
		            msg:'请输入检查时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CHECK_DATE").focus();
			return false;
			}
			
			
			//var sel=document.getElementById("CHECK_TYPE").value;
			var sel=${pd.CHECK_TYPE}
		    if(sel=='-1 '||sel=='0')
		     {
		    	var chks=$("#thead1 td input:checked");
				var len = chks.length;
				if(len<13){
					alert("还有选项未选择！");
					return false;
				}
		     }else{
		    		var chkss=$("#thead2 td input:checked");
					var leng = chkss.length;
					if(leng<8){
						alert("还有选项未选择！");
						return false;
					} 
		     }
		    	
		    
			 var msg = document.getElementById("msg").value;
			 
			 if(msg=="edit"){
				 if($("#EXIT_DATE").val()!= "" && $("#CHECK_DATE").val() != "" && ${pd.CHECK_TYPE}== "-1"){
			  /* if($("#EXIT_DATE").val()!= "" && $("#CHECK_DATE").val() != "" && $("#CHECK_TYPE").val()== "-1"){ */
				var t1 = $("#EXIT_DATE").val();
				var t2 = $("#CHECK_DATE").val();
				t1 = Number(t1.replace('-', '').replace('-', ''));
				t2 = Number(t2.replace('-', '').replace('-', ''));
				if(t2-t1>0){				
					$("#CHECK_DATE").tips({
						side:3,
			            msg:'修改入场时间要在退场时间前！',
			            bg:'#AE81FF',
			            time:0.5
			        });			
					document.getElementById("CHECK_DATE").value="";	
					return false;
				}							
			  } 
			 }
			  
			   var PC_ID = document.getElementById("PC_ID").value;
			   var CHECK_DATE = document.getElementById("CHECK_DATE").value;
			 //  var check_type=document.getElementsByName("CHECK_TYPE").value;
					$.ajax({					
						   type : "POST",
						   url: '<%=basePath%>pccheck/checkTime.do?tm='+new Date().getTime(),		
							data: {PC_ID:PC_ID,CHECK_DATE:CHECK_DATE,mag:msg,CHECK_TYPE:${pd.CHECK_TYPE}},
							dataType:'json',
							cache: false,
							success: function(data){						  				 
							  if("error1" == data.result){
								 $("#CHECK_DATE").tips({
										side:3,
							            msg:'退场时间不能早于入场时间!',
							            bg:'#AE81FF',
							            time:0.5
							        });
									document.getElementById("CHECK_DATE").value="";						
							 }
							 
							 if("error2" == data.result){
								 $("#CHECK_DATE").tips({
										side:3,
							            msg:'月别时间不得早于入场时间!',
							            bg:'#AE81FF',
							            time:0.5
							        });
									document.getElementById("CHECK_DATE").value="";						
							 }	
							 if("result" == data.result){
								    $("#testform").submit();
									$("#zhongxin").hide();
									$("#zhongxin2").show();
						 }
					}
					 
				});
		
		}
		
     
			 
		$(function() {
			$("#CHECK_TYPE").val("${pd.CHECK_TYPE}");
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
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
			
			
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
		
		
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>?没有??任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"?定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点?里全?',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '?定要?除?中的数据??'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>checkcontroller/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											tosearch();
									 });
								}
							});
						}
					}
				}
			});
		};
		
		//?出excel
		function toExcel(){
			window.location.href='<%=basePath%>checkcontroller/excel.do';
		}
		
		$(top.hangge());//??加?状?
	</script>

</body>
</html>