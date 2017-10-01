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
						<form action="pccheck/list.do" method="post" name="Form" id="Form">	
						<input  type="hidden" name="PC_ID" id="PC_ID" value="${pd.PC_ID}"/>
						<input  type="hidden" name="PC_NO" id="PC_NO" value="${pd.PC_NO}"/>
						<%-- <input  type="hidden" name="PROGRAM" id="PROGRAM" value="${pd.PROGRAM}"/> --%>
					<%-- 	<input  type="text" name="PC_STATE" id="PC_STATE" value="${pd.PC_STATE}"/> --%>
							
							 <div id = "dataField" style="overflow: scroll;width:100%;height:500px;" onscroll="javascript:titleTable.style.posLeft=-dataField.scrollLeft">
						    <table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px width:100%;">	
							<thead>
								<tr>
									<!-- <th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th> -->
									<th class="center">检查类型</th>
									<th class="center">密码设置</th>
									<th class="center">密码更新</th>
									<th class="center">屏保设置</th>
									<th class="center">病毒检查</th>
									<th class="center">病毒隔离区检查</th>
									<th class="center">WINDOWS激活确认</th>
									<th class="center">UPDATE更新确认</th>
									<th class="center">OFFICE激活确认</th>
									<th class="center">最近病毒下载</th>
									<th class="center">白名单RL</th>
									<th class="center">电脑接线口固定确认</th>
									<th class="center">USB禁用检查</th>
									<th class="center">禁用文件交换软件</th>
									<th class="center">C盘以外格式化</th>
									<th class="center">C盘系统复原</th>
									<th class="center">垃圾箱清空</th>
									<th class="center">无EXCEL文件</th>
									<th class="center">备注</th>
									<!-- <th class="center">入场时间</th>
									<th class="center">退场时间</th> -->
									<th class="center">检查时间</th>
									
									<th class="center" style="width:100px;" id="fhadmincz">操作</th>
								</tr>
							</thead>
							
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
							
										<tr>
										<%-- 	<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.CHECK_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td> --%>
											<%-- <td class='center'>${var.CHECK_ID}</td> --%>
											<c:choose>
											<c:when test="${var.CHECK_TYPE =='-1'}">
											<td class='center'>入</td>
											</c:when>
											<c:when test="${var.CHECK_TYPE =='0'}">
											<td class='center'>月</td>
											</c:when>
											<c:when test="${var.CHECK_TYPE =='1'}">
											<td class='center'>退</td>
											</c:when>
											</c:choose>
											<td class='center'>${var.PASSWORDSET}</td>
											<td class='center'>${var.PASSWORDUP}</td>
											<td class='center'>${var.SCREEN}</td>
											<td class='center'>${var.VIRUS_CHECK}</td>
											<td class='center'>${var.VIRUS_ISOLATION}</td>
											<td class='center'>${var.WINDOWS_ACTIVE}</td>
											<td class='center'>${var.UPDATE_CONFIRM}</td>
											<td class='center'>${var.OFFICE_ACTIVE}</td>
											<td class='center'>${var.NEWVIRUS_UPLOAD}</td>
											<td class='center'>${var.WHITE_LIST}</td>
											<td class='center'>${var.PORT_FASTEN}</td>
											<td class='center'>${var.USB_DISABLE}</td>
											<td class='center'>${var.FILEEXCHANGE_DISABLE}</td>
											<td class='center'>${var.C_FOMAT}</td>
											<td class='center'>${var.C_RESTORY}</td>
											<td class='center'>${var.GC_CLEAR}</td>
											<td class='center'>${var.NO_EXCEL}</td>
											<td class='center'>${var.REMARK}</td>
											<c:choose>
											<c:when test="${var.ENTRY_DATE ==null}">
											  <td class='center'>${var.EXIT_DATE}</td>
											</c:when>
											<c:when test="${var.EXIT_DATE ==null}">
											  <td class='center'>${var.ENTRY_DATE}</td>
											</c:when>
											</c:choose>
											<td class='center'>
											
												<div class="hidden-sm hidden-xs btn-group">												
													
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.CHECK_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													
													
													<a class="btn btn-xs btn-danger" onclick="del('${var.CHECK_ID},${var.CHECK_TYPE}');">
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
																<a style="cursor:pointer;" onclick="edit('${var.CHECK_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															
															
															<li>
																<a style="cursor:pointer;" onclick="del('${var.CHECK_ID},${var.CHECK_TYPE}');" class="tooltip-error" data-rel="tooltip" title="删除">
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
									</c:when>
									</c:choose>
							</tbody>
						</table>
						</div>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									
									<a class="btn btn-mini btn-success" onclick="add();" title="新增">新增</a>
									
									<!-- <a class="btn btn-mini btn-xs"  onclick="ret();" title="返回">返回</a> -->
									
									<!-- <a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a> -->
									
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
		 var Id = $("#PC_ID").val();
		 var PC_NO=$("#PC_NO").val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>pccheck/getState.do?PC_NO='+PC_NO,
			dataType:'json',
			cache: false,
			success: function(data){					 				
			if(data.pdData.PC_STATE=="23311be958564db8a9697d23361ee0bf"){
				alert("该PC已退场");
			} else{
				 var diag = new top.Dialog();
				 diag.Drag=true;
				 diag.Title ="新增";
				 diag.URL = '<%=basePath%>pccheck/goAdd.do?PC_ID='+Id+'&PC_NO='+PC_NO; 
				 diag.Width = 900;
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
				 
			}
		});		
						
	}
	
		//删除
		function del(Id){
			var id=Id.split(",")[1];
			if(id=='-1'){
				alert("入场检查不能删除！");
			}else{
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>pccheck/delete.do?CHECK_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){					
						nextPage(${page.currentPage});
					});
					 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
						 nextPage(${page.currentPage});
					}
			     
					diag.close();
				}
			});
		}
	}
		
		
		//修改
		function edit(Id){
			/* alert(Id); */
			var pcId=document.getElementById("PC_ID").value;
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = "<%=basePath%>pccheck/goEdit.do?CHECK_ID="+Id+"&PC_ID="+pcId;
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
								url: '<%=basePath%>pccheck/deleteAll.do?tm='+new Date().getTime(),
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
		
		
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>pccheck /excel.do';
		}		
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
		</script>
</body>
</html>