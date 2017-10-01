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
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- 树形下拉框start -->
<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
<link rel="stylesheet" type="text/css"
	href="plugins/selectZtree/import_fh.css" />
<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
<link type="text/css" rel="stylesheet"
	href="plugins/selectZtree/ztree/ztree.css"></link>
<!-- 树形下拉框end -->
<style type="text/css">
  .my-span{  
      
         width: 100px;  
      
        height: 20px;   
      
        overflow: hidden;  
      
        display: block;  
      
        text-overflow: ellipsis;  
      
        white-space: nowrap;  
      
        cursor: pointer;  
      
    } 

</style>

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
							<form action="staff/staffunuselist.do" method="post" name="Form"
								id="Form">
								<input name="ZDEPARTMENT_ID" id="ZDEPARTMENT_ID" type="hidden"
									value="${pd.ZDEPARTMENT_ID }" /> <input name="DEPARTMENT_ID"
									id="DEPARTMENT_ID" type="hidden" value="${pd.DEPARTMENT_ID }" />
								<table id="table_report"
									class="table table-striped table-bordered table-hover">
									<tr>
										<td style="width: 75px; text-align: right; padding-top: 13px;">时间:</td>
										<td style="width: 200px;"><input
											class="span10 date-picker" name="FREETIME" id="FREETIME"
											value="${pd.FREETIME}" type="text"
											data-date-format="yyyy-mm-dd" readonly="readonly"
											style="width: 98%;" /></td>

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
										<td style="width: 75px; text-align: right; padding-top: 13px;">手机号码:</td>
										<td><input type="text" name="TEL" id="TEL"
											value="<%=request.getParameter("TEL") == null ? "" : request
					.getParameter("TEL")%>"
											maxlength="30" placeholder="这里输入手机号码"
											onfocus="this.placeholder=''"
											onblur="this.placeholder='这里输入手机号码'" title="手机号码"
											style="width: 98%;" /></td>

										<td style="width: 75px; text-align: right; padding-top: 13px;">护照有无:</td>
										<td><select name="PASS" id="PASS" style="width: 98%;">
												<option></option>
												<option value="0"
													<c:if test="${pd.PASS == '0'}">selected</c:if>>否</option>
												<option value="1"
													<c:if test="${pd.PASS == '1'}">selected</c:if>>有</option>
										</select></td>
										<td style="width: 75px; text-align: right; padding-top: 13px;">签证有无:</td>
										<td><select name="VISA" id="VISA" style="width: 98%;">
												<option></option>
												<option value="0"
													<c:if test="${pd.VISA == '0'}">selected</c:if>>否</option>
												<option value="1"
													<c:if test="${pd.VISA == '1'}">selected</c:if>>有</option>
										</select></td>
										<td colspan="2" id="BUTTON"
											style="vertical-align: top; padding-left: 2px;">&nbsp;
											&nbsp;<a class="btn btn-light btn-xs" onclick="tosearch();">查询</a>

											<button class="btn btn-light btn-xs" onclick="back()"
												type="reset">重置</button>
										</td>
									</tr>
								</table>
								<!-- 检索  -->
								<div style="overflow-x: scroll;">
									<div style="width: 3000px">
										<table id="simple-table"
											class="table table-striped table-bordered table-hover"
											style="margin-top: 5px;">
											<thead>
												<tr>
													<!-- <th class="center" style="width: 35px;"><label
												class="pos-rel"><input type="checkbox" class="ace"
													id="zcheckbox" /><span class="lbl"></span></label></th> -->
													<th class="center" id="fhadmincz">操作</th>
													<th class="center">工号</th>
													<th class="center">姓名</th>
													<th class="center">性别</th>
													<th class="center">职称</th>
													<th class="center">预订项目</th>
													<th class="center">手机号码</th>
													<th style="width: 300px; text-align: center;">开发组</th>
												 	<!-- <th class="center">备注</th>  -->
												 	<th style="width: 100px; text-align: center;">备注</th>
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
																	<td class="center"><c:if
																			test="${QX.edit != 1 && QX.del != 1 }">
																			<span
																				class="label label-large label-grey arrowed-in-right arrowed-in"><i
																				class="ace-icon fa fa-lock" title="无权限"></i></span>
																		</c:if> <c:if test="${var.PROHAS==1}">
																			<div class="hidden-sm hidden-xs btn-group">
																				<a class="btn btn-xs btn-info"
																					onclick="nl('${var.STAFF_ID}');"> <i
																					class="ace-icon fa fa-bar-chart-o" title="员工能力"></i>
																				</a> <a class="btn btn-xs btn-success" title="修改备注"
																					onclick="editMe('${var.STAFF_ID}');"> <i
																					class="ace-icon fa fa-pencil-square-o bigger-120"
																					title="修改备注"></i>
																				</a> <a id="has${var.NO}" class="btn btn-xs btn-primary"
																					onclick="proList('${var.NO}','${var.PROHAS}');">
																					<i class="menu-icon fa fa-asterisk" title="项目详情"></i>
																				</a>
																			</div>
																		</c:if> <c:if test="${var.PROHAS==0}">
																			<div class="hidden-sm hidden-xs btn-group">
																				<a class="btn btn-xs btn-info"
																					onclick="nl('${var.STAFF_ID}');"> <i
																					class="ace-icon fa fa-bar-chart-o" title="员工能力"></i>
																				</a> <a class="btn btn-xs btn-success" title="修改备注"
																					onclick="editMe('${var.STAFF_ID}');"> <i
																					class="ace-icon fa fa-pencil-square-o bigger-120"
																					title="修改备注"></i>
																				</a>
																			</div>
																		</c:if>

																		<div class="hidden-md hidden-lg">
																			<div class="inline pos-rel">
																				<button
																					class="btn btn-minier btn-primary dropdown-toggle"
																					data-toggle="dropdown" data-position="auto">
																					<i
																						class="ace-icon fa fa-wrench bigger-120 icon-only"></i>
																				</button>

																				<ul
																					class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">

																					<c:if test="${var.PROHAS==0}">
																						<c:if test="${QX.cha == 1 }">
																							<li><a style="cursor: pointer;"
																								onclick="nl('${var.STAFF_ID}');"
																								class="tooltip-warning" data-rel="tooltip">
																									<span class="blue"> <i
																										class="ace-icon fa fa-bar-chart-o"
																										title="员工能力"></i></span>
																							</a></li>
																						</c:if>

																						<c:if test="${QX.cha == 1 }">
																							<li><a style="cursor: pointer;"
																								onclick="editMe('${var.STAFF_ID}');"
																								class="tooltip-warning" data-rel="tooltip">
																									<span class="green"> <i
																										class="ace-icon fa fa-pencil-square-o bigger-120"
																										title="备注编辑"></i></span>
																							</a></li>
																						</c:if>

																					</c:if>

																					<c:if test="${var.PROHAS==1}">
																						<c:if test="${QX.cha == 1 }">
																							<li><a style="cursor: pointer;"
																								onclick="nl('${var.STAFF_ID}');"
																								class="tooltip-warning" data-rel="tooltip">
																									<span class="blue"> <i
																										class="ace-icon fa fa-bar-chart-o"
																										title="员工能力"></i></span>
																							</a></li>
																						</c:if>

																						<c:if test="${QX.cha == 1 }">
																							<li><a style="cursor: pointer;"
																								onclick="editMe('${var.STAFF_ID}');"
																								class="tooltip-warning" data-rel="tooltip">
																									<span class="green"> <i
																										class="ace-icon fa fa-pencil-square-o bigger-120"
																										title="备注编辑"></i></span>
																							</a></li>
																						</c:if>

																						<c:if test="${QX.cha == 1 }">
																							<li><a style="cursor: pointer;" id="has"
																								onclick="proList('${var.NO}','${var.PROHAS}');"
																								class="tooltip-warning" data-rel="tooltip">
																									<span class="orange"> <i
																										class="menu-icon fa fa-asterisk" title="项目详情"></i></span>
																							</a></li>
																						</c:if>
																					</c:if>

																				</ul>

																			</div>
																		</div></td>
																	<td class='center'>${var.NO}</td>
																	<td class='center'>${var.STAFFNAME}</td>
																	<td class='center'><c:if test="${var.SEX == '1'}">男</c:if>
																		<c:if test="${var.SEX == '0'}">女</c:if></td>
																	<td class='center'>${var.TITLENAME}</td>
																	<td class='center'><c:if
																			test="${var.PROHAS == '1'}">有</c:if> <c:if
																			test="${var.PROHAS == '0'}">无</c:if></td>
																	<td class='center'>${var.TEL}</td>
																	<td class='left'>${var.DEPARTMENT_NAMES}</td>
																	<%-- <td class='center'>${var.MEMO}</td>
																	<td class='left' id="me">${var.MEMO}</td> --%>
								                                   <td> <span class="my-span" title="${var.MEMO}">${var.MEMO}</span></td> 
																	<td class='center'>${var.ENTRY_DATE}</td>
																	<td class='center'>${var.STATUSNAME}</td>
																	<td class='center'>${var.JAPANESENAME}</td>
																	<td class='center'>${var.ENGLISHNAME}</td>
																	<td class='center'><c:if test="${var.PASS == '1'}">有</c:if>
																		<c:if test="${var.PASS == '0'}">否</c:if></td>
																	<td class='center'>${var.PASS_TERM}</td>
																	<td class='center'><c:if test="${var.VISA == '1'}">有</c:if>
																		<c:if test="${var.VISA == '0'}">否</c:if></td>
																	<td class='center'><c:if
																			test="${var.VISA_TYPE == '1'}">单次</c:if> <c:if
																			test="${var.VISA_TYPE == '0'}">多次</c:if></td>
																	<td class='center'>${var.TRAVEL_TYPENAME}</td>
																	<td class='center'>${var.SCHOOL}</td>
																	<td class='center'>${var.GRADUATE_DATE}</td>
																	<td class='center'>${var.BACKSCHOOL_DATE}</td>
																	<td class='center'>${var.BACKCOMPANY_DATE}</td>
																	<td class='center'>${var.LEAVE_DATE}</td>
																	<td class='center'>${var.USER_ID}</td>
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
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>

	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
	 
	 $(function() {
		//日期框
		$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
	}); 
	
	 
	 
	 
			
	$(":reset").click(function(){
		　　var resetArr = $(this).parents("form").find(":text");
		　　for(var i=0; i<resetArr.length; i++){
		　　　　resetArr.eq(i).val("");
		　　}
	     $("#ZDEPARTMENT_ID").val("d41af567914a409893d011aa53eda797"); 
		 $("#DEPARTMENT_ID").val("d41af567914a409893d011aa53eda797");  
		 
		/*  $("#ZDEPARTMENT_ID").val("0"); 
		 $("#DEPARTMENT_ID").val("0"); */
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
		
		
		$(function() {
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
		
		
		$(function() {
			var id=${var.NO}
			alert(id);
			var div = $("#me"+Id+"").text();	
			var divtitle = '';
			if(div.length>3){
			    divtitle = div.substr(0,3)+'...';
			}
			$('div').text(divtitle);
			$("#me"+Id+"").mouseover(function(){$("#me"+Id+"").text(div)})
			$("#me"+Id+"").mouseout(function(){$("#me"+Id+"").text(divtitle)})
				});
		//员工项目列表
		
		<%-- function proList(Id,prohas){
			if(prohas=='0'){
				/* $("#has"+Id+"").tips({
					side:3,
		            msg:'该员工没有预订项目!',
		            bg:'#AE81FF',
		            time:2
		        }); 
				return false;*/
				$("#has"+Id+"").css('display','none'); 
			}else{
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="项目详情";
			 diag.URL = '<%=basePath%>staff/proList.do?NO='+Id;
			 diag.Width = 800;
			 diag.Height =650;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件							
							tosearch();
							diag.close();
			 };
			 diag.show();
			}
		}; --%>
		
		
		function proList(Id,prohas){
			var freeTime = $('#FREETIME').val();
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="项目详情";
			 diag.URL = '<%=basePath%>staff/proList.do?NO='+ Id +'&FREETIME=' + freeTime;
			 diag.Width = 800;
			 diag.Height =650;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件							
							tosearch();
							diag.close();
			 };
			 diag.show();
			
		};
		
		
		//修改备注
		function editMe(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="修改备注";
			 diag.URL = '<%=basePath%>staff/goEditMe.do?STAFF_ID='+Id;
			 diag.Width = 500;
			 diag.Height = 250;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage("${page.currentPage}");
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
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
		
	</script>


</body>
</html>