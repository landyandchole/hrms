<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>

<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>

<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<!-- 树形下拉框start -->
<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
<link type="text/css" rel="stylesheet" href="plugins/selectZtree/ztree/ztree.css"></link>
<!-- 树形下拉框end -->
<!-- 闲置资源样式start -->
<style type="text/css">
.ztree li span.demoIcon{padding:0 2px 0 10px;}
.ztree li span.button.icon01{margin:0; background: url(plugins/zTree_v3/css/zTreeStyle/img/diy/3.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.icon02{margin:0; background: url(plugins/zTree_v3/css/zTreeStyle/img/diy/4.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.icon03{margin:0; background: url(plugins/zTree_v3/css/zTreeStyle/img/diy/5.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.icon04{margin:0; background: url(plugins/zTree_v3/css/zTreeStyle/img/diy/6.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.icon05{margin:0; background: url(plugins/zTree_v3/css/zTreeStyle/img/diy/7.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.icon06{margin:0; background: url(plugins/zTree_v3/css/zTreeStyle/img/diy/8.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
</style>
<!-- 闲置资源样式end -->
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
						<form action="project/list.do" method="post" name="Form" id="Form">
						<input name="ZDEPARTMENT_ID" id="ZDEPARTMENT_ID" type="hidden"
									value="${pd.ZDEPARTMENT_ID }" /> <input name="DEPARTMENT_ID"
									id="DEPARTMENT_ID" type="hidden" value="${pd.DEPARTMENT_ID }" />
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: center;padding-top: 13px;">项目名称:</td>
								<td style="width:200px;"><input type="text" name="pName" id="pName" value="${pd.pName}"   title="项目名称" style="width:90%;"/></td>
								
								<td style="width:75px;text-align: center;padding-top: 13px;">毛利率:</td>
									<td style="width:250px;"><input type="text" name="lmll" id="lmll" value="${pd.lmll}"   title="毛利率" style="width:44%;"/>~	
									<input type="text" name="hmll" id="hmll" value="${pd.hmll}"  title="毛利率" style="width:44%;"/>&nbsp;%</td>								
								
								<td style="width:75px;text-align: center;padding-top: 13px;">项目日期:</td>
								<td style="width:200px;"><input class="span10 date-picker" name="lastStart" id="lastStart" value="${pd.lastStart}"
								 type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开始日期" title="开始日期" style="width:44%;"/>~ 
								<input class="span10 date-picker" name="lastEnd" id="lastEnd" value="${pd.lastEnd}" 
								type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="结束日期" title="结束日期" style="width:44%;"/></td> 
   						     	
							
							
								<td style="width:75px;text-align: center;padding-top: 13px;">合同金额:</td>
									<td style="width:200px;"><input type="text" name="lPrice" id="lPrice" value="${pd.lPrice}"   title="合同金额" style="width:44%;"/>~	
									<input type="text" name="hPrice" id="hPrice" value="${pd.hPrice}"  title="合同金额" style="width:44%;"/></td>	
							</tr>
								
							<tr>	
								
								<td style="width:85px;text-align: center;padding-top: 13px;">项目室:</td>
									<td><select name="BUILDING" id="BUILDING" data-placeholder="请选择状态"  style="vertical-align:top;float:left; width: 33%;height:31px">
								  	</select>
								  	<input onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" name="ROOM" id="ROOM" value="<%=request.getParameter("ROOM")==null?"":request.getParameter("ROOM")%>" maxlength="50" placeholder="这里输入房间号(例:211)" onfocus="this.placeholder=''" onblur="this.placeholder='这里输入房间号(例:211)'" title="房间" style="width:66%;float:right"/></td>	
								 							 
								<td style="width:75px;text-align: center;padding-top: 13px;">项目经理:</td>
								<td style="width:200px;"><input  name="pManager" id="pManager"  value="${pd.pManager}" type="text"  style="width:90%;"  title="项目经理"/></td> 		       						    	 						       						    
							
							
								<td style="width:75px;text-align: center;padding-top: 13px;">项目总监:</td>
								<td style="width:200px;"><input  name="pDirector" id="pDirector"  value="${pd.pDirector}" type="text"  style="width:90%;"  title="项目总监"/></td>
							
								<td style="width:75px;text-align: center;padding-top: 13px;">项目成员:</td>
								<td style="width:200px;"><input  name="pMember" id="pMember"  value="${pd.pMember}" type="text"  style="width:90%;"  title="项目成员"/></td>
									</tr>
							<tr>
							<td style="width: 100px; text-align: center; padding-top: 13px;">所属部门:</td>
										<td style="padding-left: 10px"><div class="selectTree"
												id="selectTree" ></div></td>
								<td style="width:75px;text-align: center;padding-top: 13px;">项目状态:</td>
								<td style="width:280px;"><select  name="PROJECT_STATE" id="PROJECT_STATE" title="项目状态" style="width:40%;"></select>	                           
	                           
								<td colspan="2" id="BUTTON" style=" vertical-align: top; padding-left: 2px;">
										&nbsp;  &nbsp;<a class="btn btn-light btn-xs" onclick="tosearch();"  >查询</a>
									 <button class="btn btn-light btn-xs" onclick="reset()" type="reset" >重置</button> 
									 <c:if test="${pda.username=='admin'}">
									 <a class="btn btn-light btn-xs" onclick="fromExcel();" title = "导入项目" >导入项目</a> 
									 <a class="btn btn-light btn-xs" onclick="fromExcelM();" title = "导入人员" >导入人员</a> 
							         </c:if>
							</td>
								</td>														
							</tr>
									
							</table>
					  <!-- 闲置人员搜索 -->	
					  <div style="width:19%;float:left;margin-right:3px;">
					  	<table class="table table-striped table-bordered table-hover">
						  	<tr>
							  	<td>
							  	<label for="form-field-1">空闲日期:</label>
								<div style="float:right;">
								    <input class="span10 date-picker" name="idleDate" id="idleDate" value="" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:90px;height:22px;" title="日期" type="text">
									&nbsp;<a class="btn btn-light btn-xs" onclick="idlesearch();" style="height:22px;line-height:10px;margin-right:8px;"  title = "查询" >查询</a><br>
								</div>
								<div style="clear:both"><a class="btn btn-light btn-xs" id="openButton" style="height:22px;line-height:10px;"  title = "展开" >展开</a>&nbsp;&nbsp;<a class="btn btn-light btn-xs" id="closeButton" style="height:22px;line-height:10px;"  title = "关闭" >关闭</a></div>
							  	</td>
						  	</tr>
						  	<tr>
							  	<td style="padding:2px;"><div style="overflow-y:scroll;overflow-x:scroll;width:220px;height:440px;"><ul id="treeDemo" class="ztree" ></ul></div></td>
						  	</tr>
					  	</table>
					  </div>
					  <!-- 闲置人员搜索end -->
							
						<!-- 检索  -->
					  <div  style="overflow-x: scroll;">
                      <div style="width:1800px">
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<tr>
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:150px;">操作</th>	
									<th class="center" >序号</th>	
									<th class="center">项目编号</th>
									<th class="center">项目名称</th>
									<th class="center">合同金额</th>
									<th class="center">项目状态</th>
									<th class="center">项目经理</th>
									<th class="center">项目总监</th>
									<th class="center">所属部门</th>
									<th class="center">实际成本</th>
									<th class="center">级别成本</th>
									<th class="center">费用</th>
									<th class="center">毛利</th>
									<th class="center">毛利率</th>
									<th class="center">已收取金额</th>
									<th class="center">未收取金额</th>
									<th class="center">人员数</th>
									<th class="center" style="width:100px">开始时间</th>
									<th class="center" style="width:100px">结束时间</th>
									<th class="center">项目室</th>
									
								</tr>
							</thead>
											
							<tbody>
							
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
						<tr>
							<th class='center'></th>
							<th class='center'></th>
							<th class='center'></th>
							<th class='center'></th>
							<th class='center'>合计</th>
							<th class='center'><fmt:formatNumber type="number" value="${pda.ppricesum }" pattern="#,##0.00#"/></th>
							<th class='center'></th>
							<th class='center'></th>
							<th class='center'></th>
							<th class='center'></th>
							<th class='center'><fmt:formatNumber type="number" value="${pda.pcostsum }" pattern="#,##0.00#"/></th>
							<th class='center'><fmt:formatNumber type="number" value="${pda.pactualsum }" pattern="#,##0.00#"/></th>
							<th class='center'><fmt:formatNumber type="number" value="${pda.pmoneysum }" pattern="#,##0.00#"/></th>
							<th class='center'><fmt:formatNumber type="number" value="${pda.pmlsum }" pattern="#,##0.00#"/></th>
							<th class='center'><fmt:formatNumber type="number" value="${pda.pmllsumg + 0.0001 }" pattern="0.00" maxFractionDigits="2"/>%</th>
							<th class='center'><fmt:formatNumber type="number" value="${pda.phavesum }" pattern="#,##0.00#"/></th>
							<th class='center'><fmt:formatNumber type="number" value="${pda.phavenotsum}" pattern="#,##0.00#"/></th>
							<th class='center'></th>
							<th class='center'></th>
							<th class='center'></th>
							<th class='center'></th>
							</tr>
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
																		
										<tr <c:if test="${var.PROJECT_MLL<0}"> style="background-color: #FF6666 ;"</c:if>
										<c:if test="${var.PROJECT_MLL<=30 && var.PROJECT_MLL>=0}"> style="background-color:#FFCC66;"</c:if>>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.PROJECT_ID}" class="ace" /><span class="lbl"></span></label>
											
											
											</td>	
										
											<td>
											
													<div class="hidden-sm hidden-xs btn-group">
												   <a id="membera${var.PROJECT_ID}" class="btn btn-xs btn-info"  onclick="proMember(this,'${var.PROJECT_ID}','${pd.pMember}');">
														+
													</a>
													<%-- <c:if test="${fn:contains(var.PROJECT_MANAGER, pda.username)  or pda.username == 'admin'}"> --%>
													<a class="btn btn-xs btn-info" title="团队成员" onclick="teamMember('${var.PROJECT_ID}');">
														<i class="ace-icon glyphicon glyphicon-user" title="团队成员"></i>
													</a>
													<a class="btn btn-warning btn-xs" title="费用" onclick="expense('${var.PROJECT_ID}');">
														<i class="ace-icon fa fa-wrench bigger-120 icon-only" title="费用"></i>
													</a>
																										
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.PROJECT_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>													
													
													<a class="btn btn-xs btn-danger" onclick="del('${var.PROJECT_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													<%-- </c:if> --%>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<li>
																<a style="cursor:pointer;" onclick="teamMember('${var.PROJECT_ID}');" class="tooltip-success" data-rel="tooltip" title="团队成员">
																	<span class="blue">
																		<i class="ace-icon glyphicon glyphicon-user"></i>
																	</span>
																</a>
															</li>
															<li>
																<a style="cursor:pointer;" onclick="expense('${var.PROJECT_ID}');" class="tooltip-success" data-rel="tooltip" title="费用">
																	<span class="yellow">
																		<i class="ace-icon fa fa-wrench bigger-120 icon-only"></i>
																	</span>
																</a>
															</li>
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.PROJECT_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.PROJECT_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>	
												</td>
													
												<td class='center' style="width: 30px;">${vs.index+1}</td>								
											<td class='center' id ='PROJECT_PID'>${var.PROJECT_PID}</td>
											<td class='center' id ='PROJECT_NAME'>${var.PROJECT_NAME}</td>
											<td class='center' id ='PROJECT_PRICE'><fmt:formatNumber type="number" value="${var.PROJECT_PRICE}" pattern="#,##0.00#"/></td>
											<td class='center' id ='PROJECT_STATENAME'>${var.PROJECT_STATENAME}</td>
											<td class='center' id ='PROJECT_MANAGER'>${var.PROJECT_MANAGER}</td>
											<td class='center' id ='PROJECT_DIRECTOR'>${var.PROJECT_DIRECTOR}</td>
											<td class='left' > ${var.DEPARTMENT_NAMES}</td>
											<td class='center' id ='PROJECT_COST'><fmt:formatNumber type="number" value="${var.PROJECT_COST}" pattern="#,##0.00#"/></td>
											<td class='center' id ='PROJECT_ACTUAL'><fmt:formatNumber type="number" value="${var.PROJECT_ACTUAL}" pattern="#,##0.00#"/></td>
											<td class='center' id ='PROJECT_MONEY'><fmt:formatNumber type="number" value="${var.PROJECT_MONEY}" pattern="#,##0.00#" /></td>
											<td class='center' id= 'PROJECT_ML'> 
										    <fmt:formatNumber type="number" value="${var.PROJECT_ML}" pattern="#,##0.00#"/></td>
											<td class='center' id= 'PROJECT_MLL'> 
										    <fmt:formatNumber type="number" value="${var.PROJECT_MLL}" pattern="0.00" maxFractionDigits="2"/>%</td>	
										    <td class='center' id ='PROJECT_HAVE' onclick="goMoney('${var.PROJECT_PID}');">
											<u><fmt:formatNumber type="number" value="${var.PROJECT_HAVE}" pattern="#,##0.00#"/></u></td>
											<td class='center' id ='PROJECT_HAVENOT'><fmt:formatNumber type="number" value="${var.PROJECT_HAVENOT}" pattern="#,##0.00#" /></td>
										    
										    <td class='center' id ='PROJECT_NUMBER'>${var.PROJECT_NUMBER}</td>
											<td class='center' id ='PROJECT_BTIME'>${var.PROJECT_BTIME}</td>
											<td class='center' id ='PROJECT_ETIME'>${var.PROJECT_ETIME}</td>
											<td class='center' id ='ROOM_NAME'>${var.ROOM_NAME}</td> 
											<%-- <td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
											</td>  --%>
											
										</tr>
										
										<tr>
							      <thead id="div${var.PROJECT_ID}" style="display:none;">
								   <tr>
								   <th style="border:none;" class="center"></th>
								   <th style="border:none;" class="center"></th>
								   <th class="center" style="border:none;"></th>
									<th class="center" style="border:2.5px inset;">成员工号</th>
									<th class="center" style="border:2.5px inset;">成员姓名</th>
									<th class="center" style="border:2.5px inset;">成员角色</th>
									<th class="center" style="border:2.5px inset;">开始日期</th>
									<th class="center" style="border:2.5px inset;">结束日期</th>
									<th class="center" style="border:2.5px inset;">参考成本</th>
									<th class="center" style="border:2.5px inset;">级别成本</th>
									<th class="center" style="border:2.5px inset;">项目评价</th>
									<th class="center" style="border:2.5px inset;">管理评价</th>
									<th class="center" style="border:none;"></th>
									<th class="center" style="border:none;"></th>
								    <th class="center" style="border:none;"></th>
								    <th class="center" style="border:none;"></th>
									<th class="center" style="border:none;"></th>
									<th class="center" style="border:none;"></th>
									<th class="center" style="border:none;"></th>
									<th class="center" style="border:none;"></th>
								  </tr>
							     </thead>
									<tbody id="J_TbData${var.PROJECT_ID}">
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
						<table style="width:80%;float:right;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="add();">新增</a>
									</c:if>
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
	$(":reset").click(function(){
		　　var resetArr = $(this).parents("form").find(":text");
		　　for(var i=0; i<resetArr.length; i++){
		　　　　resetArr.eq(i).val("");
		　　}
		 $("#ZDEPARTMENT_ID").val("0"); 
		 $("#DEPARTMENT_ID").val("0"); 
		　　return false;　　//一定要return false，阻止reset按钮功能，不然值又会变成aa
		});
		$(top.hangge());//关闭加载状态		
		
		//检索
		function tosearch(){
			top.jzts();		
			$("#Form").submit();
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
		
		
		function proMember(obj,id,name){
			 if (obj.innerHTML.indexOf('+') != -1) {	
					$.ajax({
						type: "POST",
						url: '<%=basePath%>project/hasproMerber.do?tm='+new Date().getTime()+'&PROJECT_ID='+id+'&pMember='+name,
						dataType:'json',
						cache: false,
						success: function(data){
							if(data.memberList==""){
								alert("该项目还没有项目人员！");
							}else{
								document.getElementById("div"+id+"").style.display="";
								$("#J_TbData"+id+"").html("");
							  $.each(data.memberList, function(i, dvar){
								  if(typeof(dvar.MANAGER_EV)=="undefined"){
									  dvar.MANAGER_EV="";
								  }
								  if(typeof(dvar.PROJECT_EV)=="undefined"){
									  dvar.PROJECT_EV="";
								  }
								 var $trTemp = $("<tr></tr>");
					                //往行里面追加 td单元格
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.MEMBER_ID+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.MEMBER_NAME+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.MEMBER_ROLENAME+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.MEMBER_BTIME+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.MEMBER_ETIME+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.MEMBER_COST+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.MEMBER_ACTUL+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.PROJECT_EV+'</td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.MANAGER_EV+'</td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.appendTo("#J_TbData"+id+"");
					
						          });
							   document.getElementById("J_TbData"+id+"").style.display="";
							   obj.innerHTML = '-';
							}
						}
					});
				
				
			} else {		
				document.getElementById("div"+id+"").style.display="none";
				document.getElementById("J_TbData"+id+"").style.display="none";
				obj.innerHTML = '+';
			}  
			
		}
		
		function teamMember(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="团队成员";
			 diag.URL = '<%=basePath%>projectmember/list.do?PROJECT_ID='+Id;
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
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>project/goAdd.do';
			 diag.Width = 820;
			 diag.Height = 500;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 tosearch();
					 }else{						
						 tosearch();
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
					var url = "<%=basePath%>project/delete.do?PROJECT_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="修改";
			 diag.URL = '<%=basePath%>project/goEdit.do?PROJECT_ID='+Id;
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
						 nextPage("${page.currentPage}");
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//去收取金额页面
		function goMoney(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="金额";
			 diag.URL = '<%=basePath%>projectmoney/list.do?PROJECT_PID='+Id;
			 diag.Width = 800;
			 diag.Height = 500;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
								
				diag.close();
				 tosearch();
			 };
			 diag.show();
		}
		
		
		
		//费用
		function expense(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title = "费用";
			 diag.URL = '<%=basePath%>cost/list.do?PROJECT_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 650;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
		     diag.CancelEvent = function(){ //关闭事件
		    	 tosearch();
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
				            time:10
				        });
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>project/deleteAll.do?tm='+new Date().getTime(),
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
		
		
		
		//下拉框
		$(function() {		
					$.ajax({
						type: "POST",
						url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
						dataType:'json',
						cache: false,
						success: function(data){
							 $("#BUILDING").html('<option></option>');
							 $.each(data.buildingList, function(i, dvar){
									$("#BUILDING").append("<option value="+dvar.NAMEUse+">"+dvar.NAME+"</option>");
							 });
							 $("#BUILDING").val("${pd.BUILDING}");
							 $("#PROJECT_STATE").html('<option value="">请选择</option>');
							 $.each(data.projectStatelist, function(i, dvar){
									$("#PROJECT_STATE").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
							 });
							 $("#PROJECT_STATE").val("${pd.PROJECT_STATE}");
							 
							 
						}
					});
				}); 
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>project/excel.do';
		}
		function reset(){
			$("#pName").val("");  
            $("#pManager").val("");  
            $("#pDirector").val("");  
            $("#pMember").val("");  
            $("#PROJECT_BUILDING").val("");  
            $("#PROJECT_FLOOR").val("");  
            $("#PROJECT_ROOMS").val("");  
            $("#lPrice").val("");  
            $("#hPrice").val("");  
            $("#lmll").val("");  
            $("#hmll").val("");  
            $("#lastStart").val("");  
            $("#lastEnd").val("");  
            $("#PROJECT_STATE").val("");  
            $("#BUILDING").val("");  
            $("#ROOM").val(""); 
        	$("#selectTree").get(0).selectedIndex=0; 
		}
		
	</script>
	
	<!-- 闲置资源 -->
	<SCRIPT type="text/javascript">
		<!--

		var IDMark_Switch = "_switch",
		IDMark_Icon = "_ico",
		IDMark_Span = "_span",
		IDMark_Input = "_input",
		IDMark_Check = "_check",
		IDMark_Edit = "_edit",
		IDMark_Remove = "_remove",
		IDMark_Ul = "_ul",
		IDMark_A = "_a";
		
		var setting = {
			view: {
				addDiyDom: addDiyDom,
				showIcon: true
			}
		};

		var zNodes =[];
		
		function addDiyDom(treeId, treeNode) {
			var isParent = treeNode.isParent;
			if(isParent) return;
			var aObj = $("#" + treeNode.tId + IDMark_A);
			var editStr = "<input type='button' value='备注' style='margin-right:0px;' onclick='editRemark(" + "\"" + treeNode.id + "\"" +")'>";
			aObj.after(editStr);
		}

		function addHoverDom(treeId, treeNode) {
		/* 	if (treeNode.parentNode && treeNode.parentNode.id!=1) return;
			var aObj = $("#" + treeNode.tId + IDMark_A);
			if ($("#diyBtn1_"+treeNode.id).length>0) return;
			if ($("#diyBtn2_"+treeNode.id).length>0) return;
			var editStr = "<a id='diyBtn1_" +treeNode.id+ "' onclick='alert(1);return false;' style='margin:0 0 0 5px;'>链接1</a>";
			aObj.append(editStr); */
		}

		function removeHoverDom(treeId, treeNode) {

			/* $("#diyBtn1_"+treeNode.id).unbind().remove(); */
		}
		
		function idlesearch() {
			//查询当前日期的闲置资源
			$.ajax({
				url:'idleStaff/idleStaffList.do',
				type:'post',
				dataType:'json',
				async:false,
				data:{
					FREETIME:$('#idleDate').val()
				},
				success:function(data){
					zNodes = data;
				}
			});
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		}

		$(document).ready(function(){
			if('${sessionScope.idleDate}' == ''){
				//设置空闲日期为当前日期
				var myDate = new Date();
				var year = myDate.getFullYear();
				var month = myDate.getMonth()+1;
				var day = myDate.getDate();
				var clock = year + "-";		       
		        if(month < 10)
		            clock += "0";	       
		        clock += month + "-";	       
		        if(day < 10)
		            clock += "0";	           
		        clock += day + " ";
	
				$('#idleDate').val(clock);
			}else{
				$('#idleDate').val('${sessionScope.idleDate}');
			}
			
			//查询当前日期的闲置资源
			$.ajax({
				url:'idleStaff/idleStaffList.do',
				type:'post',
				dataType:'json',
				async:false,
				data:{
					FREETIME:$('#idleDate').val()
				},
				success:function(data){
					zNodes = data;
				}
			});
		
			
			var treeObject = $.fn.zTree.init($("#treeDemo"), setting, zNodes); 
			$('#openButton').click(function(){
				treeObject.expandAll(true); 
			});
			$('#closeButton').click(function(){
				treeObject.expandAll(false); 
			});
		});
		//-->
		
		//修改闲置员工的备注
		function editRemark(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="备注";
			 diag.URL = '<%=basePath%>idleStaff/goStaffRemarkEdit.do?STAFF_ID='+Id;
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
						 nextPage(${page.currentPage});
					 }
				}
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
			 diag.URL = '<%=basePath%>project/goUploadExcel.do';
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
		
		//打开上传excel页面
		function fromExcelM(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="EXCEL 导入到数据库";
			 diag.URL = '<%=basePath%>project/goUpload.do';
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
	
	</SCRIPT>
</body>
</html>
