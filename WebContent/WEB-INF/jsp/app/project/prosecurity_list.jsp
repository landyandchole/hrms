<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
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
						<!-- 检索  -->
						<form action="security/list.do" method="post" name="Form" id="Form">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: center;padding-top: 13px;">项目名称:</td>
								<td style="width:200px;">
								     <input type="text" name="projectname" id="projectname" value="${pd.projectname}"   title="项目名称" style="width:90%;"/>
								</td>
								<td style="width:75px;text-align: center;padding-top: 13px;">项目经理:</td>
								<td style="width:200px;">
								      <input type="text" name="projectmanager" id="projectmanager" value="${pd.projectmanager}"   title="项目经理" style="width:90%;"/>
								</td>								
								<td style="width:75px;text-align: center;padding-top: 13px;">PC编号:</td>								
								<td style="width:200px;">
								    <input type="text" name="pcnumber" id="pcnumber" value="${pd.pcnumber}"   title="PC编号" style="width:90%;"/>
								</td>
								<td style="width:75px;text-align: center;padding-top: 13px;">PC状态:</td>
								<td style="width:200px;">
								     <select  name="PC_STATE" id="PC_STATE" title="PC状态" style="width:90%;"></select>	                           	                            
								</td>															
							</tr>
							<tr>
								<td style="width:80px;text-align: center;padding-top: 13px;">入场负责人:</td>
								<td style="width:200px;">
								     <input type="text" name="admissioncharge" id="admissioncharge" value="${pd.admissioncharge}"   title="入场负责人" style="width:90%;"/>	                           	                            
								</td>
								<td style="width:80px;text-align: center;padding-top: 13px;">退场负责人:</td>
								<td style="width:200px;">
								     <input type="text" name="exitcharge" id="exitcharge" value="${pd.exitcharge}"   title="退场负责人" style="width:90%;"/>	                           	                            
								</td>
								<td style="width:75px;text-align: center;padding-top: 13px;">申请人:</td>
								<td style="width:200px;">
								     <input type="text" name="applicant" id="applicant" value="${pd.applicant}"   title="申请人" style="width:90%;"/>	                           	                            
								</td>
						        <td colspan="2" style="vertical-align:top;padding-left:2px">
						        	<div style="padding-left: 15px;">
							        	<a class="btn btn-light btn-xs" onclick="tosearch();"  title = "查询" >查询</a>&nbsp;&nbsp;
										<a class="btn btn-light btn-xs" onclick="reset();" title = "重置" >重置</a> 
						        	</div>
						        </td>
							</tr>		
						</table>
						<!-- 检索  -->
					 <div  style="overflow-x: scroll;">
                      <div style="width:1300px">
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
								   <th class="center"></th>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<input type="hidden" name='PC_LEAVEID' value="${var.PC_LEAVEID}"  /><span class="lbl"></span>
									<th class="center">序号</th>
									
									<th class="center">项目名称</th>
									<th class="center">项目经理</th>
									<th class="center">开发室</th>
									<th class="center">所属</th>
									<th class="center">部门</th>
									<th class="center">项目状态</th>
								    <th class="center">项目人数</th>
									<th class="center">申请电脑的台数</th>
									<th class="center">项目电脑状态</th>
									<th class="center"></th>
									<th class="center"></th>
									<th class="center"></th>									
									<th class="center"></th>
									<!-- <th class="center"></th> -->
								<!-- 	<th class="center"></th>
									<th class="center"></th>
									<th class="center"></th>										
									<th class="center"></th>  -->
							<!-- 		<th class="center" style="width:180px;" id="fhadmincz">操作</th> -->
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
										
											<td>
											 <a id="membera${var.PROJECT_ID}" class="btn btn-xs btn-info"  onclick="proMember(this,'${var.PROJECT_ID}',
											 '${pd.pMember}','${pd.projectname}','${pd.projectmanager}','${pd.pcnumber}','${pd.admissioncharge}','${pd.exitcharge}','${pd.applicant}');">
														+
													</a>
											</td>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.PRO_ID}" id="${var.APPLICANT_NO}" <%-- id="${var.EXITCHARGE}" --%>  class="ace" /><span class="lbl"></span></label>
											
											</td>
											<td class='center' style="width: 50px;">${vs.index+1}</td>
											<td class='center'>${var.PROJECT_NAME}</td>
											<td class='center'>${var.PROJECT_MANAGER}</td>
											<td class='center'>${var.ROOM_NAME}</td>
											<td class='center'>${var.PROJECT_THE}</td>
											<td class='center'>${var.PROJECT_DEPARTMENTNAME}</td>
											<td class='center'>${var.PROJECT_STATENAME}</td>
											<td class='center'>${var.PROJECT_NUMBER}</td>
											<td class='center'>${var.PC_NUMBER}</td>
											<td class='center'>${var.PCSTATE}</td>
											<td class='center'></td>
											<td class='center'></td>
											<td class='center'></td>
											<td class='center'></td>
											<%-- <td class='center'>${var.PC_NUMBER}</td>
											<td class='center'>${var.PC_STATENAME}</td>
											<td class='center'>${var.USER}</td>
											<td class='center'>${var.APPLICANT_NO}</td>
											<td class='center'>${var.APPLICANT}</td>
											<td class='center'>${var.PC_ADMISSION}</td>
											<td class='center'>${var.ADMISSIONDATE}</td>
											<td class='center'>${var.ADMISSIONCHARGE}</td>
											<td class='center'>${var.PC_EXIT}</td>
											<td class='center'>${var.EXITDATE}</td>
											<td class='center'>${var.EXITCHARGE}</td>
											<td class='center'>${var.REMARKS}</td> --%>
										<%-- 	<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.PRO_ID}','${var.PC_LEAVEID}','${var.PROJECT_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													
													<a class="btn btn-xs btn-primary" onclick="safe('${var.PROJECT_ID}');">
															<i class="glyphicon glyphicon-flag" title="退出申请"></i>
													</a>	
													<c:if test="${var.STATE == 1}">
													<c:if test="${var.STATE == 1 && var.PC_STATENAME=='已入场'}">
													<a class="btn btn-xs btn-danger" title="退场申请" onclick="startApply('${var.PC_LEAVEID}','${var.PROJECT_ID}');">
															<span id="discount" style="width:18px;height:18px;">退场</span>
															<!-- <i class="ace-icon fa fa-pencil-square-o bigger-120" title="折扣"></i> -->
														</a>
													</c:if>												
													<c:if test="${(QX.email == 1 and pda.ferrname ==var.ADMISSIONCHARGE)}">
													<a class="btn btn-xs btn-info" title='发送电子邮件' onclick="sendEmail('${var.APPLICANT_NO}');">
														<i class="ace-icon fa fa-envelope-o bigger-120" title="发送电子邮件"></i>
													</a>
													</c:if>	
													<c:if test="${(var.PC_NUMBER!=null && var.PC_NUMBER!='')}">
													<c:if test="${var.PC_STATE=='afd972ec76334ba7949c8ed093449b29'
													            ||var.PC_STATE=='141b48c7bc554d58bd298dc9acff3f46'
													            ||var.PC_STATE=='8b2bb55faa4e4258870ebd1aaeedf489'}">
													<a class="btn btn-xs btn-primary" onclick="safe('${var.PRO_ID}','${var.PC_STATE}','${var.PC_NUMBER}');">
															<i class="glyphicon glyphicon-flag" title="安全检查"></i>
													</a>
													</c:if>	
													</c:if>										
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.PRO_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if>													
													
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.PRO_ID}','${var.PC_LEAVEID}','${var.PROJECT_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.PRO_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<li>
															<c:if test="${(var.PC_NUMBER!=null && var.PC_NUMBER!='')}">
															<c:if test="${var.PC_STATE=='afd972ec76334ba7949c8ed093449b29'
													                     ||var.PC_STATE=='141b48c7bc554d58bd298dc9acff3f46'
													                     ||var.PC_STATE=='8b2bb55faa4e4258870ebd1aaeedf489'}">
																<a style="cursor:pointer;" onclick="safe('${var.PRO_ID}','${var.PC_STATE}','${var.PC_NUMBER}');" class="tooltip-error" data-rel="tooltip" title="安全检查">
																	<span class="blue">
																		<i class="glyphicon glyphicon-flag"></i>
																	</span>
																</a>
															</c:if>	
															</c:if>	
															</li>
														</ul>
													</div>
												</div>
											</td> --%>
										</tr>
								<thead id="div${var.PROJECT_ID}" style="display:none;">
								   <tr>
								   <th style="border:none;" class="center"></th>
								   <th style="border:none;" class="center"></th>
								   <th class="center" style="border:none;"></th>
									<th class="center">PC编号</th>
									<th class="center">PC状态</th>
									<th class="center">使用者</th>
									<th class="center">申请人工号</th>
									<th class="center">申请人</th>
									<th class="center">PC入场手续</th>									
									<th class="center">入场日</th>
									<th class="center">入场负责人</th>
									<th class="center">PC退场手续</th>
									<th class="center">退场日</th>
									<th class="center">退场负责人</th>										
									<th class="center">备注</th>
									<th class="center" style="width:180px;" id="fhadmincz">操作</th>
								  </tr>
							     </thead>
									<tbody id="J_TbData${var.PROJECT_ID}">
                                     </tbody>	
                                     <tbody id="J_TbData${var.PC_ID}">
                                     </tbody>									
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						
						</div>
						</div>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.edit == 1 }">
									<a class="btn btn-mini btn-success" onclick="editAll();">批量操作</a>
									</c:if>
									<c:if test="${QX.email == 1 }"><a title="批量发送电子邮件" class="btn btn-mini btn-primary" onclick="makeAll('确定要给选中的用户发送邮件吗?');"><i class="ace-icon fa fa-envelope bigger-120"></i></a></c:if>
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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
		</div>
		<!-- /.main-content -->

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
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
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();		
			$("#Form").submit();
		}
		
		//下拉框
		$(function() {		
		    $.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
				dataType:'json',
				cache: false,
				success: function(data){
					$("#PC_STATE").html('<option></option>');
					$.each(data.pcsstateList, function(i, dvar){
						$("#PC_STATE").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					});										
					$("#PC_STATE").val("${pd.PC_STATE}");
							 							 
				}
			});
		}); 		
		
		function proMember(obj,id,projectname,projectmanager,pcnumber,admissioncharge,exitcharge,applicant){
			//${pd.projectname}${pd.projectmanager}${pd.pcnumber}PC_STATE${pd.admissioncharge}${pd.exitcharge}${pd.applicant}
			var PC_STATE=$("#PC_STATE").val();
			 if (obj.innerHTML.indexOf('+') != -1) {	
					$.ajax({
						type: "POST",
						url: '<%=basePath%>security/hasproSecurity.do?tm='+new Date().getTime()+
								'&PROJECT_ID='+id+'&projectname='+projectname+'&projectmanager='+projectmanager+
								'&pcnumber='+pcnumber+'&PC_STATE='+PC_STATE+'&admissioncharge='+admissioncharge+'&exitcharge='+exitcharge+'&applicant='+applicant,
						dataType:'json',
						cache: false,
						success: function(data){
								document.getElementById("div"+id+"").style.display="";
								$("#J_TbData"+id+"").html("");
							  $.each(data.varList, function(i, dvar){
								  if(typeof(dvar.PC_NUMBER)=="undefined"){
									  dvar.PC_NUMBER="";
								  }
								  if(typeof(dvar.PC_STATENAME)=="undefined"){
									  dvar.PC_STATENAME="";
								  }
								  if(typeof(dvar.USER)=="undefined"){
									  dvar.USER="";
								  }
								  if(typeof(dvar.APPLICANT_NO)=="undefined"){
									  dvar.APPLICANT_NO="";
								  }
								  if(typeof(dvar.APPLICANT)=="undefined"){
									  dvar.APPLICANT="";
								  }
								  if(typeof(dvar.PC_ADMISSION)=="undefined"){
									  dvar.PC_ADMISSION="";
								  }
								  if(typeof(dvar.ADMISSIONDATE)=="undefined"){
									  dvar.ADMISSIONDATE="";
								  }
								  if(typeof(dvar.ADMISSIONCHARGE)=="undefined"){
									  dvar.ADMISSIONCHARGE="";
								  }
								  if(typeof(dvar.PC_EXIT)=="undefined"){
									  dvar.PC_EXIT="";
								  }
								  if(typeof(dvar.EXITDATE)=="undefined"){
									  dvar.EXITDATE="";
								  }
								  if(typeof(dvar.EXITCHARGE)=="undefined"){
									  dvar.EXITCHARGE="";
								  }
								  if(typeof(dvar.REMARKS)=="undefined"){
									  dvar.REMARKS="";
								  }
								 var $trTemp = $("<tr></tr>");
					                //往行里面追加 td单元格
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                alert(dvar.PC_ID);
					                if(dvar.PC_ID==null ||dvar.PC_ID==""){
					                	$trTemp.append('<td style="border:none;"></td>');
					                }else{
					                	$trTemp.append('<td style="border:2.5px inset;text-align: center;"><a id="membera'+dvar.PC_ID+'" class="btn btn-xs btn-info" onclick="pcCheck(this,/'+dvar.PC_ID+'/);">+</a></td>');
					                }
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.PC_NUMBER+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.PC_STATENAME+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.USER+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.APPLICANT_NO+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.APPLICANT+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.PC_ADMISSION+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.ADMISSIONDATE+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.ADMISSIONCHARGE+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.PC_EXIT+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.EXITDATE+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.EXITCHARGE+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.REMARKS+'</td>');
					                $trTemp.append('<td class="center"><a class="btn btn-xs btn-primary" onclick="safe(/'+dvar.PC_STATE+'/,/'+dvar.PC_NUMBER+'/);"><i class="glyphicon glyphicon-flag" title="退出申请"></i></a>')
					                $trTemp.appendTo("#J_TbData"+id+"");
						          });
							   document.getElementById("J_TbData"+id+"").style.display="";
							   obj.innerHTML = '-';
						}
					});
				
				
			} else {		
				document.getElementById("div"+id+"").style.display="none";
				document.getElementById("J_TbData"+id+"").style.display="none";
				obj.innerHTML = '+';
			}  
			
		}
		
		function pcCheck(obj,id){
			 if (obj.innerHTML.indexOf('+') != -1) {	
					$.ajax({
						type: "POST",
						url: '<%=basePath%>security/haspcCheck.do?tm='+new Date().getTime()+'&PC_ID='+id,
						dataType:'json',
						cache: false,
						success: function(data){
							$("#J_TbData"+id+"").html("");
							  $.each(data.varList, function(i, dvar){
								  if(typeof(dvar.PC_NUMBER)=="undefined"){
									  dvar.PC_NUMBER="";
								  }
								 var $trTemp = $("<tr></tr>");
					                //往行里面追加 td单元格
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                if(dvar.CHECK_TYPE =='-1'){
					                	$trTemp.append('<td style="border:2.5px inset;text-align: center;">入</td>');
					                }else if(dvar.CHECK_TYPE =='0'){
					                	$trTemp.append('<td style="border:2.5px inset;text-align: center;">月</td>');
					                }else{
					                	$trTemp.append('<td style="border:2.5px inset;text-align: center;">退</td>');
					                }
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.PASSWORDSET+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.PASSWORDUP+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.SCREEN+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.VIRUS_CHECK+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.VIRUS_ISOLATION+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.WINDOWS_ACTIVE+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.UPDATE_CONFIRM+'</td>');
					                $trTemp.appendTo("#J_TbData"+id+"");
						          });
							   document.getElementById("J_TbData"+id+"").style.display="";
							   obj.innerHTML = '-';
					  }
				
					});
			} else {		
				document.getElementById("typediv").style.display="none";
				document.getElementById("J_TypeData").style.display="none";
				obj.innerHTML = '+';
			}  
			
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';	
					var emstr = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  	
							if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
						  	else emstr += ';' + document.getElementsByName('ids')[i].id;
						  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });						
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>security/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
		   					    //beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}else if(msg == '确定要给选中的用户发送邮件吗?'){
							sendEmail(emstr);
						}else if(msg == '确认批量修改吗?'){
							editAll(str,emstr)
						}
					}
				}
			});
		};
		
		
		function startApply(pc_leaveId,name){
			 var msg='退场';
			 $.post("${pageContext.request.contextPath}/pca/startApply",{pc_leaveId:pc_leaveId,name:name,msg:msg},function(result){
					if(result.success){
						alert("申请提交成功，目前审核中，请耐心等待！");
						$("#Form").submit();
					}else{
						alert("系统系统","申请提交失败，请联系管理员！");
					}
				},"json"); 
			}

		//批量操作
		function editAll(){		
			if($("input[name='ids']:checked").length >= 2){
			 text = $("input:checkbox[name='ids']:checked").map(function(index,elem) {
		           return $(elem).val();
		     }).get().join(',');			 
			 top.jzts(); 
			 var  admissioncharge='';
			 var  exitcharge='';
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>security/gosecurityEdit.do?PRO_ID='+encodeURI(text);
			 diag.Width = 450;
			 diag.Height = 150;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
		     diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show(); 
		}else{
			alert("请选择多条数据");
		}
		};
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>security/delete.do?PRO_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
			});
		}
		
		//修改
		function edit(Id,PC_LEAVEID,PROJECT_ID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>security/goEdit.do?PRO_ID='+Id+'&PC_LEAVEID='+PC_LEAVEID+'&PROJECT_ID='+PROJECT_ID;
			 diag.Width = 450;
			 diag.Height = 410;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 tosearch();
				}
				diag.close();
			 };
			 diag.show();
		}
		//去发送电子邮件页面
		function sendEmail(EMAIL){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="发送电子邮件";
			 diag.URL = '<%=basePath%>head/goEmail.do?NO='+EMAIL;
			 diag.Width = 660;
			 diag.Height = 486;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//安全检查
	    function safe(pc_state,pc_number){
	   	     top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="安全检查";
			 diag.URL = '<%=basePath%>pccheck/list.do?PC_STATE='+pc_state+'&PC_NO='+pc_number;
			 diag.Width = 1200;
			 diag.Height =800;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 tosearch();
				 diag.close();
			 };
			 diag.show();
		} 
		
		$(function() {			
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
			//复选框全选控制
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
				
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>proj/excel.do';
		}
		
		function reset(){
			$("#projectname").val("");  
            $("#projectmanager").val("");             
            $("#pcnumber").val("");  
            $("#PC_STATE").val("");  
            $("#admissioncharge").val("");
            $("#exitcharge").val("");
            $("#applicant").val("");  
		}	
	</script>


</body>
</html>