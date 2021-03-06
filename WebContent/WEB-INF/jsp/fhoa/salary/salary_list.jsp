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
							<form action="salary/list.do" method="post" name="Form" id="Form">
								<input name="ZDEPARTMENT_ID" id="ZDEPARTMENT_ID" type="hidden"
									value="${pd.ZDEPARTMENT_ID }" /> <input name="DEPARTMENT_ID"
									id="DEPARTMENT_ID" type="hidden" value="${pd.DEPARTMENT_ID }" />
								<table id="table_report"
									class="table table-striped table-bordered table-hover">
									<tr>
										<td style="width: 70px; text-align: right; padding-top: 13px;">姓名:</td>
										<td><input type="text" name="STAFFNAME" id="STAFFNAME"
											value="<%=request.getParameter("STAFFNAME") == null ? "" : request
					.getParameter("STAFFNAME")%>"
											maxlength="200" placeholder="这里输入姓名"
											onfocus="this.placeholder=''"
											onblur="this.placeholder='这里输入姓名'" title="姓名"
											style="width: 98%;" /></td>
										<td style="width: 65px; text-align: right; padding-top: 13px;">工号:</td>
										<td><input type="text" name="NO" id="NO"
											value="<%=request.getParameter("NO") == null ? "" : request
					.getParameter("NO")%>"
											maxlength="110" placeholder="这里输入工号"
											onfocus="this.placeholder=''"
											onblur="this.placeholder='这里输入工号'" title="工号"
											style="width: 95%;" /></td>
										
											<td style="width:75px;text-align: center;padding-top: 13px;">薪资:</td>
									<td style="width:210px;"><input type="text" name="lsalary" id="lsalary" value="${pd.lsalary}"   title="薪资" style="width:47%;"/>~	
									<input type="text" name="hsalary" id="hsalary" value="${pd.hsalary}"  title="薪资" style="width:47%;"/></td>	
											<td style="width: 100px; text-align: right; padding-top: 13px;style="width:250%;">开发组:</td>
										<td style="padding-left: 10px"><div class="selectTree"
												id="selectTree"></div></td>
									</tr>
									<tr>

										<td style="width: 75px; text-align: right; padding-top: 13px;">职称:</td>
										<td><select name="TITLE" id="TITLE" style="width: 98%;">
										</select></td>
										<td style="width: 75px; text-align: right; padding-top: 13px;">状态:</td>
										<td><select name="STATUS" id="STATUS" style="width: 95%;">
										</select></td>
										<td style="width: 75px; text-align: right; padding-top: 13px;">日语水平:</td>
										<td><select name="JAPANESE" id="JAPANESE"
											style="width: 99%;">

										</select></td>
										<td style="width: 75px; text-align: right; padding-top: 13px;">英语水平:</td>
										<td><select name="ENGLISH" id="ENGLISH"
											style="width:90%;">
										</select></td>
									</tr>
									<tr>                              							
									<td style="width:75px;text-align: center;padding-top: 13px;">入职日期:</td>
								<td style="width:210px;"><input class="span10 date-picker" name="start" id="start" value="${pd.start}"
								 type="text" data-date-format="yyyy-mm-dd" readonly="readonly"  title="开始日期" style="width:47%;"/>~ 
								<input class="span10 date-picker" name="follow" id="follow" value="${pd.follow}" 
								type="text" data-date-format="yyyy-mm-dd" readonly="readonly"  title="结束日期" style="width:47%;"/></td> 
									
									<td colspan="2" id="BUTTON" style=" vertical-align: top; padding-left: 2px;">
										&nbsp;  &nbsp;<a class="btn btn-light btn-xs" onclick="tosearch();"  >查询</a>
									 <button class="btn btn-light btn-xs" onclick="back()" type="reset" >重置</button> 
									<c:if test="${pda.username=='admin'}">
									 <a class="btn btn-light btn-xs" onclick="fromExcel();" title = "导入" >导入</a> 
									 </c:if>
							</td>
							</tr>
							</table>
							</form>		 				
								<!-- 检索  -->
                    <div  style="overflow-x: scroll;">
                    <div style="width:1200px">
						<table id="simple-table"
									class="table table-striped table-bordered table-hover"
									style="margin-top: 5px;">
									<thead>
										<tr>
											<th class="center" style="width: 35px;"><label
												class="pos-rel"><input type="checkbox" class="ace"
													id="zcheckbox" /><span class="lbl"></span></label></th>
											<th class="center" style="width: 80px;" id="fhadmincz">操作</th>
											<th class="center">工号</th>
											<th class="center">姓名</th>
											<th class="center">性别</th>
											<th class="center">职称</th>
											<th class="center">薪资</th>
											<th style="width:300px;text-align: center;">开发组</th>
											<th class="center">入职日期</th>
										    <th class="center">状态</th>	
										
											
										</tr>
									</thead>

									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:if test="${QX.cha == 1 }">
													<c:forEach items="${varList}" var="var" varStatus="vs">
														<tr>
															<td class='center'><label class="pos-rel"><input
																	type='checkbox' name='ids' value="${var.NO}"
																	class="ace" /><span class="lbl"></span></label></td>
															<td class="center">																					
																	 <c:if test="${QX.edit == 1}">
																		<a class="btn btn-xs btn-success" title="编辑"
																			onclick="edit('${var.NO}','${var.SALARY}');"> <i
																			class="ace-icon fa fa-pencil-square-o bigger-120"
																			title="编辑"></i>
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
																		 <c:if test="${QX.edit == 1}">
																				<li><a style="cursor: pointer;"
																					onclick="edit('${var.NO}','${var.SALARY}');"
																					class="tooltip-success" data-rel="tooltip"
																					title="修改"> <span class="green"> <i
																							class="ace-icon fa fa-pencil-square-o bigger-120"></i>
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
															<td class='center'>${var.SALARY}</td>
															<td class='left'> ${var.DEPARTMENT_NAMES}</td>
															<td class='center'> ${var.ENTRY_DATE}</td>
															<td class='center'>${var.STATUSNAME}</td>		
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
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">									
									<c:if test="${QX.edit == 1 }">
									<a class="btn btn-mini btn-success" onclick="editAll();">批量操作</a>
									</c:if>
									
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>					
						</div>
						
							
						
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
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
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
				}
			});
		});
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		//打开上传excel页面
		function fromExcel(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="EXCEL 导入到数据库";
			 diag.URL = '<%=basePath%>salary/goUploadExcel.do';
			 diag.Width = 300;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				
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
		
		
		//修改
		function edit(Id,Salary){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>salary/goSalaryEdit.do?NO='+Id+'&SALARY='+Salary;
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
		}	
		
		

		//批量操作
		function editAll(){
			
			if($("input[name='ids']:checked").length >= 2){
			 text = $("input:checkbox[name='ids']:checked").map(function(index,elem) {
		           return $(elem).val();
		     }).get().join(',');
			 var Salary='';
			 top.jzts(); 
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>salary/goSalaryEdit.do?NO='+text+'&SALARY='+Salary;
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
	
		
		
		//清空
		function back(){
			$("#STAFFNAME").val(""); 
			$("#NO").val(""); 
			$("#selectTree").get(0).selectedIndex=0; 
			$("#TITLE").get(0).selectedIndex=0; 
			$("#STATUS").get(0).selectedIndex=0;
			$("#JAPANESE").get(0).selectedIndex=0;
			$("#ENGLISH").get(0).selectedIndex=0;

		}
		
				
</script>


</body>
</html>