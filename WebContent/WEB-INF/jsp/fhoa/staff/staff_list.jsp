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
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 树形下拉框start -->
<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
<link rel="stylesheet" type="text/css"
	href="plugins/selectZtree/import_fh.css" />
<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
<link type="text/css" rel="stylesheet"
	href="plugins/selectZtree/ztree/ztree.css"></link>
<!-- 树形下拉框end -->
</head>

<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<!-- 检索  -->
							<form action="staff/list.do" method="post" name="Form" id="Form">
								<input name="ZDEPARTMENT_ID" id="ZDEPARTMENT_ID" type="hidden"
									value="${pd.ZDEPARTMENT_ID }" /> <input name="DEPARTMENT_ID"
									id="DEPARTMENT_ID" type="hidden" value="${pd.DEPARTMENT_ID }" />
								<table id="table_report"
									class="table table-striped table-bordered table-hover">
									<tr>
										<td style="width: 75px; text-align: right; padding-top: 13px;">姓名:</td>
										<td><input type="text" name="STAFFNAME" id="STAFFNAME"
											value="<%=request.getParameter("STAFFNAME") == null ? "" : request
					.getParameter("STAFFNAME")%>"
											maxlength="50" placeholder="这里输入姓名"
											onfocus="this.placeholder=''"
											onblur="this.placeholder='这里输入姓名'" title="姓名"
											style="width: 98%;" /></td>
										<td style="width: 75px; text-align: right; padding-top: 13px;">工号:</td>
										<td><input type="text" name="NO" id="NO"
											value="<%=request.getParameter("NO") == null ? "" : request
					.getParameter("NO")%>"
											maxlength="100" placeholder="这里输入工号"
											onfocus="this.placeholder=''"
											onblur="this.placeholder='这里输入工号'" title="编码"
											style="width: 98%;" /></td>
										<td style="width: 75px; text-align: right; padding-top: 13px;">手机号码:</td>
										<td><input type="text" name="TEL" id="TEL"
											value="<%=request.getParameter("TEL") == null ? "" : request
					.getParameter("TEL")%>"
											maxlength="30" placeholder="这里输入手机号码"
											onfocus="this.placeholder=''"
											onblur="this.placeholder='这里输入手机号码'" title="手机号码"
											style="width: 98%;" /></td>
										<td style="width: 75px; text-align: right; padding-top: 13px;">开发组:</td>
										<td style="padding-left: 10px"><div class="selectTree"
												id="selectTree"></div></td>
									</tr>
									<tr>

										<td style="width: 75px; text-align: right; padding-top: 13px;">职称:</td>
										<td><select name="TITLE" id="TITLE" style="width: 98%;">
										</select></td>
										<td style="width: 75px; text-align: right; padding-top: 13px;">状态:</td>
										<td><select name="STATUS" id="STATUS" style="width: 98%;">
										</select></td>
										<td style="width: 75px; text-align: right; padding-top: 13px;">日语水平:</td>
										<td><select name="JAPANESE" id="JAPANESE"
											style="width: 98%;">

										</select></td>
										<td style="width: 75px; text-align: right; padding-top: 13px;">英语水平:</td>
										<td><select name="ENGLISH" id="ENGLISH"
											style="width: 98%;">
										</select></td>
									</tr>
									<tr>
									 <td style="width: 75px; text-align: right; padding-top: 13px;">学校:</td>
										<td><input type="text" name="SCHOOL" id="SCHOOL"
											value="<%=request.getParameter("SCHOOL") == null ? "" : request
					.getParameter("SCHOOL")%>"
											maxlength="30" placeholder="这里输入学校"
											onfocus="this.placeholder=''"
											onblur="this.placeholder='这里输入学校'" title="学校地址"
											style="width: 98%;" /></td>

                            <td style="width:75px;text-align: right;padding-top: 13px;">护照有无:</td>
								<td>
									<select name="PASS" id="PASS" style="width:98%;">
										<option></option>
										<option value="0"<c:if test="${pd.PASS == '0'}">selected</c:if>>否</option>
										<option value="1"<c:if test="${pd.PASS == '1'}">selected</c:if>>有</option>
									</select>
								</td>
										<td style="width:75px;text-align: right;padding-top: 13px;">签证有无:</td>
								<td>
									<select name="VISA" id="VISA" style="width:98%;">
										<option></option>
										<option value="0"<c:if test="${pd.VISA == '0'}">selected</c:if>>否</option>
										<option value="1"<c:if test="${pd.VISA == '1'}">selected</c:if>>有</option>
									</select>
								</td>
										<td colspan="2" id="BUTTON" style=" vertical-align: top; padding-left: 2px;">
										&nbsp;  &nbsp;<a class="btn btn-light btn-xs" onclick="tosearch();"  >查询</a>
									 <button class="btn btn-light btn-xs" onclick="back()" type="reset" >重置</button> 
								 <c:if test="${pda.username=='admin'}">
									 <a class="btn btn-light btn-xs" onclick="fromExcel();" title = "导入" >导入</a> 
								 </c:if>
							</td>
					</tr>
								</table>
								<!-- 检索  -->
                    <div  style="overflow-x: scroll;">
                    <div style="width:3000px">
						<table id="simple-table"
									class="table table-striped table-bordered table-hover"
									style="margin-top: 5px;">
									<thead>
										<tr>
											<th class="center" style="width: 35px;"><label
												class="pos-rel"><input type="checkbox" class="ace"
													id="zcheckbox" /><span class="lbl"></span></label></th>
											<th class="center" style="width: 250px;" id="fhadmincz">操作</th>
											<th class="center">工号</th>
											<th class="center">姓名</th>
											<th class="center">性别</th>
											<th class="center">职称</th>
											<th class="center">手机号码</th>
											<th class="center">邮箱</th>
											<th style="width:300px;text-align: center;">开发组</th>
											<th class="center">入职日期</th>
										    <th class="center">状态</th>	
											<th class="center">日语水平</th>
											<th class="center">英语水平</th>
											<th class="center">护照有无</th>
											<th class="center">护照期限</th>	
											<th class="center">签证有无</th>
											<th class="center">签证类型</th>
										    <th class="center">出差类型</th>
											<th class="center">毕业学校</th>
											<th class="center">毕业时间</th>
											<th class="center">返校时间</th>
											<th class="center">回公司时间</th>	
											<th class="center">离职时间</th>
											<th class="center">用户绑定</th>									
											<!--<th class="center">权限组</th>-->
											
										</tr>
									</thead>

									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:if test="${QX.cha == 1 }">
													<c:forEach items="${varList}" var="var" varStatus="vs">
														<tr>
															<td class='center'><label class="pos-rel">
															<input	type='checkbox' name='ids' value="${var.STAFF_ID}" id="${var.EMAIL }"
																	class="ace" /><span class="lbl"></span></label></td>
															<%-- 		<td class='center' style="width: 30px;">${vs.index+1}</td> --%>
															<td class="center"><c:if
																	test="${QX.edit != 1 && QX.del != 1 }">
																	<span
																		class="label label-large label-grey arrowed-in-right arrowed-in"><i
																		class="ace-icon fa fa-lock" title="无权限"></i></span>
																</c:if>
																<div class="hidden-sm hidden-xs btn-group">
																	<a class="btn btn-xs btn-info"
																		onclick="nl('${var.STAFF_ID}');"> <i
																		class="ace-icon fa fa-bar-chart-o" title="员工能力"></i>
																	</a>
																	<c:if test="${QX.userBinding == 1 }">
																		<a class="btn btn-xs btn-info" title="绑定用户"
																			onclick="userBinding('${var.STAFF_ID}');"> <i
																			class="ace-icon glyphicon glyphicon-user"></i>
																		</a>
																	</c:if>
																	<%-- <c:if test="${QX.Datajur == 1 }">
																		<a class="btn btn-warning btn-xs" title="设置开发组"
																			onclick="setDatajur('${var.STAFF_ID}');"> <i
																			class="ace-icon fa fa-wrench bigger-120 icon-only"></i>
																		</a>
																	</c:if>		 --%>														
																	 <c:if test="${(QX.edit == 1 and pda.username ==var.USER_ID) or pda.username=='admin'}">
																		<a class="btn btn-xs btn-success" title="编辑"
																			onclick="edit('${var.STAFF_ID}');"> <i
																			class="ace-icon fa fa-pencil-square-o bigger-120"
																			title="编辑"></i>
																		</a>
																	</c:if>	
																	<c:if test="${QX.edit == 1}">
																		<a class="btn btn-xs btn-danger" title="查看详情"
																			onclick="editlook('${var.STAFF_ID}');"> <i
																			class="ace-icon fa fa-search-plus bigger-120"
																			title="查看详情"></i>
																		</a>
																	</c:if>	 	 																																	
																	<c:if test="${QX.del == 1 }">
																		<a class="btn btn-warning btn-xs"
																			onclick="ev('${var.STAFF_ID}');"> <i
																			class="ace-icon fa fa-bolt bigger-120 icon-only"
																			title="评估"></i>
																		</a>
																	</c:if>																		
																	<c:if test="${QX.del == 1 and pda.username == 'admin'}">
																		<a class="btn btn-xs btn-danger"
																			onclick="del('${var.STAFF_ID}');"> <i
																			class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
																		</a>
																	</c:if>

																</div>
																
																<div class="hidden-md hidden-lg">
																	<div class="inline pos-rel">
																		<button
																			class="btn btn-minier btn-primary dropdown-toggle"
																			data-toggle="dropdown" data-position="auto">
																			<i class="ace-icon fa fa-wrench bigger-120 icon-only"></i>
																		</button>

																		<ul
																			class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																			
																		<c:if test="${QX.cha == 1 }">
																		  <li>	<a style="cursor: pointer;"
																		  onclick="nl('${var.STAFF_ID}');" class="tooltip-warning" data-rel="tooltip"> 
																	     <span class="blue">	<i class="ace-icon fa fa-bar-chart-o"  title="员工能力"></i></span>
																	      </a>
																	      </li></c:if>
																			
																			<c:if test="${QX.userBinding == 1 }">
																				<li><a style="cursor: pointer;"
																					onclick="userBinding('${var.STAFF_ID}');"
																					class="tooltip-warning" data-rel="tooltip"
																					title="绑定用户"> <span class="blue"> <i
																							class="ace-icon glyphicon glyphicon-user"></i>
																					</span>
																				</a></li>
																			</c:if>
																			
																			<%-- <c:if test="${QX.Datajur == 1 }">
																				<li><a style="cursor: pointer;"
																					onclick="setDatajur('${var.STAFF_ID}');"
																					class="tooltip-warning" data-rel="tooltip"
																					title="设置开发组"> <span class="orange"> <i
																							class="ace-icon fa fa-wrench bigger-120 icon-only"></i>
																					</span>
																				</a></li>
																			</c:if> --%>

																			 <c:if test="${(QX.edit == 1 and pda.username ==var.USER_ID) or pda.username=='admin'}">
																				<li><a style="cursor: pointer;"
																					onclick="edit('${var.STAFF_ID}');"
																					class="tooltip-success" data-rel="tooltip"
																					title="修改"> <span class="green"> 
																					<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																					</span>
																				</a></li>
																			</c:if>
																			
																			<c:if test="${QX.del == 1 }">
																			<li>	<a style="cursor: pointer;"
													 								onclick="ev('${var.STAFF_ID}');"> 
													 								<span class="orange"><i class="ace-icon fa fa-bolt bigger-120 icon-only" data-rel="tooltip"
																					title="评估"></i></span>
																				</a></li>
																			</c:if>
																			<c:if test="${QX.del == 1 and pda.username == 'admin'}">
																				<li><a style="cursor: pointer;"
																					onclick="del('${var.STAFF_ID}');"
																					class="tooltip-error" data-rel="tooltip" title="删除">
																						<span class="red"> <i
																							class="ace-icon fa fa-trash-o bigger-120"></i>
																					</span>
																				</a></li>
																			</c:if>
																			
																		</ul>
																	</div>
																</div></td>
															<td class='center'>${var.NO}</td>
															<td class='center'>${var.STAFFNAME}</td>
															<td class='center'><c:if test="${var.SEX == '1'}">男</c:if>
																<c:if test="${var.SEX == '0'}">女</c:if></td>
															<td class='center'>${var.TITLENAME}</td>
															<td class='center'>${var.TEL}</td>
															<td class='center'>${var.EMAIL}</td>
															<td class='left'> ${var.DEPARTMENT_NAMES}</td>
															<td class='center'> ${var.ENTRY_DATE}</td>
															<td class='center'>${var.STATUSNAME}</td>
															<td class='center'>${var.JAPANESENAME}</td>
															<td class='center'>${var.ENGLISHNAME}</td>
															<td class='center'><c:if test="${var.PASS == '1'}">有</c:if>
																<c:if test="${var.PASS == '0'}">否</c:if></td>
																<td class='center'>${var.PASS_TERM}</td>
															<td class='center'><c:if test="${var.VISA == '1'}">有</c:if>
																<c:if test="${var.VISA == '0'}">否</c:if></td>
															<td class='center'>${var.VISATYPENAME}</td>
															<td class='center'>${var.TRAVEL_TYPENAME}</td>
															<td class='center'>${var.SCHOOL}</td>
															<td class='center'>${var.GRADUATE_DATE}</td>
															<td class='center'>${var.BACKSCHOOL_DATE}</td>
															<td class='center'>${var.BACKCOMPANY_DATE}</td>
															<td class='center'>${var.LEAVE_DATE}</td>
															<td class='center'>${var.USER_ID}</td>
															<!--<td class='center'>${var.ROLNAME}</td>-->
															
														</tr>

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
													<td colspan="100" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								</div>
								</div>
								<div class="page-header position-relative">
									<table style="width: 100%;">
										<tr>
											<td style="vertical-align: top;">
											<c:if test="${QX.add == 1 }">
													<a class="btn btn-mini btn-success" onclick="add();">新增</a>
												</c:if> 													
												 <c:if test="${QX.del == 1 }">
													<a class="btn btn-mini btn-danger"
														onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除"><i
														class='ace-icon fa fa-trash-o bigger-120'></i></a>
												</c:if></td>
											<td style="vertical-align: top;"><div class="pagination"
													style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
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

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->
<!-- </div> -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
	
	$(":reset").click(function(){
		　　var resetArr = $(this).parents("form").find(":text");
		　　for(var i=0; i<resetArr.length; i++){
		　　　　resetArr.eq(i).val("");
		　　}
		 $("#ZDEPARTMENT_ID").val("0"); 
		 $("#DEPARTMENT_ID").val("0"); 
		　　return false;　　//一定要return false，阻止reset按钮功能，不然值又会变成aa
		});
	
		$(function() {		
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
				dataType:'json',
				cache: false,
				success: function(data){
					$("#JAPANESE").html('<option></option>');
					 $.each(data.list, function(i, dvar){
							$("#JAPANESE").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
					 $("#JAPANESE").val("${pd.JAPANESE}");
					 $("#ENGLISH").html('<option></option>');
					 $.each(data.englishlist, function(i, dvar){
							$("#ENGLISH").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
					 $("#ENGLISH").val("${pd.ENGLISH}");
					 $("#TITLE").html('<option></option>');
					 $.each(data.titlelist, function(i, dvar){
							$("#TITLE").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
					 $("#TITLE").val("${pd.TITLE}");
					 $("#TRAVEL_TYPE").html('<option></option>');
					 $.each(data.travelTypelist, function(i, dvar){
							$("#TRAVEL_TYPE").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
					 $("#TRAVEL_TYPE").val("${pd.TRAVEL_TYPE}");
					 $("#STATUS").html('<option></option>');
					 $.each(data.statuslist, function(i, dvar){
							$("#STATUS").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
					 $("#STATUS").val("${pd.STATUS}");
					 $("#VISA_TYPE").html('<option value=""></option>');
					 $.each(data.visaTypelist, function(i, dvar){
							$("#VISA_TYPE").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
					 $("#VISA_TYPE").val("${pd.VISA_TYPE}");
				}
			});
		});
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {
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
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>staff/goAdd.do';
			 diag.Width = 800;
			 diag.Height = 500;
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
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>staff/delete.do?STAFF_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		

		//修改
		function editlook(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="员工详情";
			 diag.URL = '<%=basePath%>staff/goEditlook.do?STAFF_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 500;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>staff/goEdit.do?STAFF_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 500;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		function ev(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>staff/goEv.do?STAFF_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 500;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
	
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
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
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
								url: '<%=basePath%>staff/deleteAll.do?tm='+new Date().getTime(),
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
						}
					}
				}
			});
		};
		
	
		function initComplete(){
			//下拉树
			var defaultNodes = {"treeNodes":${zTreeNodes}};
			//绑定change事件
			$("#selectTree").bind("change",function(){
				if(!$(this).attr("relValue")){
			      //  top.Dialog.alert("没有选择节点");
			    }else{
					//alert("选中节点文本："+$(this).attr("relText")+"<br/>选中节点值："+$(this).attr("relValue"));
					$("#DEPARTMENT_ID").val($(this).attr("relValue"));
					$("#ZDEPARTMENT_ID").val($(this).attr("relValue"));
			    }
			});
			//赋给data属性
			$("#selectTree").data("data",defaultNodes);  
			$("#selectTree").render();
			$("#selectTree2_input").val("${'0'==depname?'请选择':depname}");
			/* $("#selectTree2_input").val("请选择"); */
		}
		
		//授权(组织机构数据权限)
		function setDatajur(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="授予组织机构数据权限";
			 diag.URL = '<%=basePath%>datajur/goEdit.do?DATAJUR_ID='+Id;
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//打开绑定用户窗口
		function userBinding(STAFF_ID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="绑定用户";
			 diag.URL = '<%=basePath%>user/listUsersForWindow.do';
			 diag.Width = 700;
			 diag.Height = 545;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					var USERNAME = diag.innerFrame.contentWindow.document.getElementById('USERNAME').value;
					var url = "<%=basePath%>staff/userBinding.do?STAFF_ID="+STAFF_ID+"&USER_ID="+USERNAME+"&tm="+new Date().getTime();
					$.get(url,function(data){
						$("#fhadmincz").tips({
							side:1,
				            msg:'绑定成功',
				            bg:'#009933',
				            time:3
				        });
						tosearch();
					});
				 }
				diag.close();
			 };
			 diag.show();
		}
		
		//转向员工能力信息
		
		function nl(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="员工能力信息";
			 diag.URL = '<%=basePath%>staff/nl.do?STAFF_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 500;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		};
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>staff/excel.do';
		}		

		//清空
		function back(){
			$("#staffNAME").val(""); 
			$("#NO").val(""); 
			$("#TEL").val(""); 
			$("#selectTree").get(0).selectedIndex=0; 
			$("#TITLE").get(0).selectedIndex=0; 
			$("#STATUS").get(0).selectedIndex=0;
			$("#JAPANESE").get(0).selectedIndex=0;
			$("#ENGLISH").get(0).selectedIndex=0;
			$("#SCHOOL").val("");
			$("#PASS").get(0).selectedIndex=0;
			$("#VISA").get(0).selectedIndex=0;
		}
		//去发送电子邮件页面
		function sendEmail(EMAIL){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="发送电子邮件";
			 diag.URL = '<%=basePath%>head/goSendEmail.do?EMAIL='+EMAIL;
			 diag.Width = 660;
			 diag.Height = 486;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		//打开上传excel页面
		function fromExcel(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="EXCEL 导入到数据库";
			 diag.URL = '<%=basePath%>staff/goUpload.do';
			 diag.Width = 300;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}	
	</script>


</body>
</html>