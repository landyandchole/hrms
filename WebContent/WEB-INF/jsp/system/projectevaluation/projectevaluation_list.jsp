<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
<link type="text/css" rel="stylesheet" href="plugins/selectZtree/ztree/ztree.css"></link>
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
						<form action="projectev/list.do" method="post" name="Form" id="Form">	
						 <input type="hidden" name="QUESTION_TYPE" id="QUESTION_TYPE" value="${pd.QUESTION_TYPE}"/>				
						<table style="margin-top:10px;">	
							<tr>
							    <td style="width:75px;text-align: right;padding-top: 5px;">题目类型:</td>
							    <td  style="padding-left:10px"></td>	
						        <td>
									<select class="QUESTION_TYPE" name="QUESTION_TYPE" id="QUESTION_TYPE" style="width:98%;">
									    <option value="" <c:if test="${pd.QUESTION_TYPE == ''}">selected</c:if>></option>
										<option value="0" <c:if test="${pd.QUESTION_TYPE == '0'}">selected</c:if>>设计能力</option>
										<option value="1" <c:if test="${pd.QUESTION_TYPE == '1'}">selected</c:if>>开发能力</option>
										<option value="2" <c:if test="${pd.QUESTION_TYPE == '2'}">selected</c:if>>沟通能力</option>
										<option value="3" <c:if test="${pd.QUESTION_TYPE == '3'}">selected</c:if>>工作效率</option>
										<option value="4" <c:if test="${pd.QUESTION_TYPE == '4'}">selected</c:if>>工作品质</option>										
										<option value="5" <c:if test="${pd.QUESTION_TYPE == '5'}">selected</c:if>>责任心</option>
										<option value="6" <c:if test="${pd.QUESTION_TYPE == '6'}">selected</c:if>>出勤率</option>
										<option value="7" <c:if test="${pd.QUESTION_TYPE == '7'}">selected</c:if>>管理能力</option>				
									</select>
									
								</td>
								<td>
									&nbsp;  &nbsp;<a class="btn btn-light btn-xs" onclick="tosearch();"  >查询</a>
								</td>
								
										
							</tr>		
							</table>
							
						    <table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:10px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center">题目类型</th>
									<th class="center">题目</th>
									<th class="center">答案</th>
									<th class="center">分值</th>
									<th class="center" style="width:130px;" id="fhadmincz">操作</th>
								</tr>
							</thead>
							
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
							
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.EV_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
									<%-- 		<td class='center' style="width: 30px;">${vs.index+1}</td> --%>
											<td class='center'>
											<c:if test="${var.QUESTION_TYPE == '0'}">设计能力</c:if>
											<c:if test="${var.QUESTION_TYPE == '1'}">开发能力</c:if>
											<c:if test="${var.QUESTION_TYPE == '2'}">沟通能力</c:if>
											<c:if test="${var.QUESTION_TYPE == '3'}">工作效率</c:if>
											<c:if test="${var.QUESTION_TYPE == '4'}">工作品质</c:if>
											<c:if test="${var.QUESTION_TYPE == '5'}">责任心</c:if>
											<c:if test="${var.QUESTION_TYPE == '6'}">出勤率</c:if>
											<c:if test="${var.QUESTION_TYPE == '7'}">管理能力</c:if>											
											
											</td>
											<td class='center'>${var.QUESTION_NAME}</td>
											<td class='center'>${var.ANSWER_NAME}</td>
											<td class='center'>${var.ANSWER_MARK}</td>
											<td class='center'>
												
												
												
												<div class="hidden-sm hidden-xs btn-group">												
													
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.EV_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													
													
													<a class="btn btn-xs btn-danger" onclick="del('${var.EV_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													
													
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-wrench bigger-120 icon-only"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.EV_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															
															
															<li>
																<a style="cursor:pointer;" onclick="del('${var.EV_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															
														</ul>
													</div>
												</div>
											</td>
										</tr>
									</c:forEach>
									</c:if>
									</c:when></c:choose>
									
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									
									<a class="btn btn-mini btn-success" onclick="add();">新增</a>
									
									
									<a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									
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
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>	
	<script type="text/javascript">
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
		 diag.URL = '<%=basePath%>projectev/goAdd.do';
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
					var url = "<%=basePath%>projectev/delete.do?EV_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>projectev/goEdit.do?EV_ID='+Id;
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
								url: '<%=basePath%>projectev/deleteAll.do?tm='+new Date().getTime(),
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
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
		</script>
</body>
</html>