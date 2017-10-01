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
						<form action="pc/list.do" method="post" name="Form" id="Form">
						<input name="ZDEPARTMENT_ID" id="ZDEPARTMENT_ID" type="hidden" value="${pd.PROJECT_ID }" />	
						<input name="PROJECT_ID" id="PROJECT_ID" type="hidden" value="${pd.PROJECT_ID }" />					
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: center;padding-top: 13px;">PC编号:</td>
								<td style="width:270px"><input type="text" name="PC_NO" id="PC_NO" value="<%=request.getParameter("PC_NO")==null?"":request.getParameter("PC_NO")%>" maxlength="50" placeholder="这里输入编号" onfocus="this.placeholder=''" onblur="this.placeholder='这里输入编号'" title="PC编号" style="width:100%;"/></td>
								<td style="width:75px;text-align: center;padding-top: 13px;">品牌:</td>
									<td style="width:270px">
										<select name="BRAND" id="BRAND" style="width:100%;">
										</select>
								    </td>	
								<td style="width:75px;text-align: center;padding-top: 13px;">内存:</td>
								<td style="width:270px">
									<select name="RAM" id="RAM" style="width:100%;">
									</select>
								    </td>
								<td style="width:75px;text-align: center;padding-top: 13px;">硬盘:</td>
								<td>
									<select name="HDISK" id="HDISK" style="width:100%;">
									</select>
								</td>											
							</tr>
							<tr>
								<td style="width:85px;text-align: center;padding-top: 13px;">房间:</td>
								<td><select name="BUILDING" id="BUILDING" data-placeholder="请选择状态"  style="vertical-align:top;float:left; width: 33%;height:31px">
								  	</select>
								  	<input type="number" name="ROOM" id="ROOM" value="<%=request.getParameter("ROOM")==null?"":request.getParameter("ROOM")%>" maxlength="50" placeholder="这里输入房间号(例:211)" onfocus="this.placeholder=''" onblur="this.placeholder='这里输入房间号(例:211)'" title="PC编号" style="width:66%;float:right"/></td>
<!-- 								  	<div>
									  	<select class="chosen-select form-control" name="level2" id="level2"  onchange="change2(this.value)" data-placeholder="请选择状态" style="vertical-align:top;float:left;width: 33.33%;">
									  	</select>
									  	<select class="chosen-select form-control" name="level3" id="level3"   onchange="change3(this.value)" data-placeholder="请选择状态" style="vertical-align:top;float:right;width: 33.33%;">
									  	</select>
								  	</div> -->
								<td style="width:75px;text-align: center;padding-top: 13px;">项目:</td>
								<td>
									<select name="PROGRAM" id="PROGRAM" style="width:100%;">
									</select>
								</td>
								<td style="width:75px;text-align: center;padding-top: 13px;">保修时间:</td>
								<td><input class="span10 date-picker" name="G_TIME" id="G_TIME" value="${pd.G_TIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="请输入保修时间" title="保修时间" style="width:100%;"/></td>
						        <td style="width:75px;text-align: center;padding-top: 13px;">在库情况:</td>
								<td>
									<select name="DEPOT" id="DEPOT" style="width:100%;">
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: center;padding-top: 13px;">质保期:</td>
								<td>
									<select name="DEFECTS_LIABILITY_PERIOD" id="DEFECTS_LIABILITY_PERIOD" style="width:100%;">
									</select>
								</td>
								<td colspan="2" style="vertical-align:top;padding-left:2px">
						        	<div style="padding-left: 15px;">
							        	<a class="btn btn-light btn-xs" onclick="gsearch();"  title="查询">
											<div style="color:#000000">查询</div>
							        	</a>&nbsp;&nbsp;
										<a class="btn btn-light btn-xs" id="button" title="重置" onclick="back();">
											<div style="color:#000000;">重置</div>
										</a>
						        	</div>
						        </td>
							</tr>
							<tr><td style="width:85px;padding-top: 13px;" id="total" name="total" colspan="8"><div style="margin-left:20px;float:left">电脑总数</div></td></tr>		
							</table>
							
						    <table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center">PC编号</th>
									<th class="center">品牌</th>
									<th class="center">内存</th>
									<th class="center">硬盘</th>
									<th class="center">芯片</th>
									<th class="center">类型</th>

									<th class="center">操作系统</th>
									<th class="center">在库情况</th>
									<th class="center">质保期</th>
									<th class="center">电脑成本</th>
									<th class="center">项目</th>
									<th class="center">房间</th>
									<th class="center">保修时间</th>
									<th class="center">MAC地址</th>									
									<th class="center">备注</th>
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
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.PC_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
									<%-- 		<td class='center' style="width: 30px;">${vs.index+1}</td> --%>
											<td class='center'>${var.PC_NO}</td>
											<td class='center'>${var.BRAND}</td>
											<td class='center'>${var.RAM}</td>
											<td class='center'>${var.HDISK}</td>
											<td class='center'>${var.CHIP}</td>
											<td class='center'>${var.TYPE}</td>
											
											<td class='center'>${var.OS}</td>
											<td class='center'>${var.NAME}</td>
											<td class='center'>${var.DEFECTS_LIABILITY_PERIOD}</td>
											<td class='center'>${var.COST}</td>
											
										    <td class="center">${var.PROJECT_NAME}</td>
											<td class='center'>${var.ROOM_NAME}</td>
						
											<td class='center'>${var.G_TIME}</td>
											<td class='center'>${var.MAC}</td>
											<td class='center'>${var.NOTE}</td>
											<td class='center'>
											<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												
												<div class="hidden-sm hidden-xs btn-group">	
													<c:if test="${QX.edit == 1 }">
														<a class="btn btn-xs btn-danger" title="折扣" onclick="">
															<span id="discount" style="width:18px;height:18px;">折</span>
															<!-- <i class="ace-icon fa fa-pencil-square-o bigger-120" title="折扣"></i> -->
														</a>
													</c:if>										
													<c:if test="${QX.edit == 1 }">
														<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.PC_ID}');">
															<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
														</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
														<a class="btn btn-xs btn-danger" onclick="del('${var.PC_ID}');">
															<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
														</a>
													</c:if>
														<%-- <a class="btn btn-xs btn-primary" onclick="safe('${var.PC_ID}','${var.PROGRAM}');">
															<i class="glyphicon glyphicon-flag" title="安全检查"></i>
														</a> --%>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-wrench bigger-120 icon-only"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.PC_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															
															
															<li>
																<a style="cursor:pointer;" onclick="del('${var.PC_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															
															<%-- <li>
																<a style="cursor:pointer;" onclick="safe('${var.PC_ID}','${var.PROGRAM}');" class="tooltip-error" data-rel="tooltip" title="安全检查">
																	<span class="blue">
																		<i class="glyphicon glyphicon-flag"></i>
																	</span>
																</a>
															</li> --%>
															
																		
														</ul>
													</div>
												</div>
											</td>
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
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
								</c:choose>
									
							</tbody>
						</table>
						<div class="page-header position-relative">
						
						<table style="width:100%;">
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
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>	
	<script type="text/javascript">
	$(function() {		
		$.ajax({
			type: "POST",
			url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
			dataType:'json',
			cache: false,
			success: function(data){
				 $("#BRAND").html('<option></option>');
				 $.each(data.brandList, function(i, dvar){
						$("#BRAND").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
				 });
				 $("#BRAND").val("${pd.BRAND}");
				 $("#RAM").html('<option></option>');
				 $.each(data.ramList, function(i, dvar){
						$("#RAM").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
				 });
				 $("#RAM").val("${pd.RAM}");
				 $("#HDISK").html('<option></option>');
				 $.each(data.hdiskList, function(i, dvar){
						$("#HDISK").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
				 });
				 $("#HDISK").val("${pd.HDISK}");
				 $("#PROGRAM").html('<option></option>');
				 $.each(data.programList, function(i, dvar){
						$("#PROGRAM").append("<option value="+dvar.PROJECT_NAME+">"+dvar.PROJECT_NAME+"</option>");
				 });
				 $("#PROGRAM").val("${pd.PROGRAM}");
				 $("#BUILDING").html('<option></option>');
				 $.each(data.buildingList, function(i, dvar){
						$("#BUILDING").append("<option value="+dvar.NAMEUse+">"+dvar.NAME+"</option>");
				 });
				 $("#BUILDING").val("${pd.BUILDING}");
				 $("#DEPOT").html('<option></option>');
				 $.each(data.depotNameList, function(i, dvar){
						$("#DEPOT").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
				 });
				 $("#DEPOT").val("${pd.DEPOT}");
				 $("#DEFECTS_LIABILITY_PERIOD").html('<option></option>');
				 $.each(data.liabilityNameList, function(i, dvar){
						$("#DEFECTS_LIABILITY_PERIOD").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
				 });
				 $("#DEFECTS_LIABILITY_PERIOD").val("${pd.DEFECTS_LIABILITY_PERIOD}");
			} 
		});
	});
	$(top.hangge());//关闭加载状态
	
	
	//检索
	function gsearch(){
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
	$(function(){
		var comma = ",";
		
		//电脑总数统计
		$.ajax({
			type:"POST",
			url:"<%=basePath%>pc/count.do",
			dataType:"json",
			success:function(data){
				var enter = data.pdData2.have1 + data.pdData2.have2;
				$("#total").append('<div style="color:red;float:left;font-weight:bold">'+ data.pdData.total +'</div>'+'<div style="float:left;">台</div>');
				$("#total").append('<div style="margin-left:20px;float:left">已入场</div><div style="color:red;float:left;font-weight:bold">'+ data.pdData2.have3 +'</div>'+'<div style="float:left;">台</div>');
				$("#total").append('<div style="float:left;">'+comma+'</div>');
				$("#total").append('<div style="margin-left:20px;float:left">退场准备中</div><div style="color:red;float:left;font-weight:bold">'+ data.pdData2.have4 +'</div>'+'<div style="float:left;">台</div>');
				$("#total").append('<div style="float:left;">'+comma+'</div>');
				$("#total").append('<div style="margin-left:20px;float:left">闲置</div><div style="color:red;float:left;font-weight:bold">'+ data.pdData2.have5 +'</div>'+'<div style="float:left;">台</div>');
				$("#total").append('<div style="float:left;">'+comma+'</div>');
				$("#total").append('<div style="margin-left:20px;float:left">损坏</div><div style="color:red;float:left;font-weight:bold">'+ data.pdData2.have6 +'</div>'+'<div style="float:left;">台</div>');
				$("#total").append('<div style="float:left;">'+comma+'</div>');
				$("#total").append('<div style="margin-left:20px;float:left">入场预定</div><div style="color:red;float:left;font-weight:bold">'+ enter +'</div>'+'<div style="float:left;">台</div>');
			}
		})
	})
	//新增
	function add(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增";
		 diag.URL = '<%=basePath%>pc/goAdd.do';
		 diag.Width = 800;
		 diag.Height = 500;
		 diag.Modal = true;				//有无遮罩窗口
		 diag. ShowMaxButton = true;	//最大化按钮
	     diag.ShowMinButton = true;		//最小化按钮
	     diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				 if('${page.currentPage}' == '0'){						 
					 gsearch();
					
				 }else{
					 gsearch();
				 } 
			}
			diag.close();
		 };
		 diag.show();
	}
	
	
	//安全检查
   <%--  function safe(pc_Id,pro_Id){
   	 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="安全检查";
		 diag.URL = '<%=basePath%>pccheck/list.do?PC_ID='+pc_Id+'&pro_Id='+pro_Id;
		 alert(pro_Id);
		 diag.Width = 1200;
		 diag.Height =800;
		 diag.Modal = true;				//有无遮罩窗口
		 diag. ShowMaxButton = true;	//最大化按钮
	     diag.ShowMinButton = true;		//最小化按钮 
		 diag.CancelEvent = function(){ //关闭事件
						diag.close();
		 };
		 diag.show();
	} 
	 --%>
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>pc/delete.do?PC_ID="+Id+"&tm="+new Date().getTime();
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
			 diag.URL = '<%=basePath%>pc/goEdit.do?PC_ID='+Id;
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
								url: '<%=basePath%>pc/deleteAll.do?tm='+new Date().getTime(),
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
		//初始第一级
		$(function() {
			$.ajax({
				type: "POST",
				anync:false,
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
		    	data: {},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#level1").html('<option value=""></option>');
					 $.each(data.list, function(i, dvar){
							$("#level1").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
					 $("#level1").val("${pd.level1}");
				}
			});
		});
	
		//第一级值改变事件(初始第二级)
		function change1(value){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
		    	data: {DICTIONARIES_ID:value},
				dataType:'json',
				cache: false,
				success: function(data){
					if($("#level1").val() == ""){
						$("#level2").html('<option value=""></option>');
						$("#level3").html('<option value=""></option>');
						}else{
						$("#level2").html('<option value=""></option>');
						$.each(data.list, function(i, dvar){
							$("#level2").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
						});
						}
				}
			});
		}
		//下拉框
		 $(function() {		
				$.ajax({
					type: "POST",
					anync:false,
					url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
					dataType:'json',
					cache: false,
					success: function(data){
						 $("#level2").html('<option value=""></option>');
						 $.each(data.roomList, function(i, dvar){
								$("#level2").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
						 });
						 $("#level2").val("${pd.level2}");
					}
				});
			}); 
		//第二级值改变事件(初始第三级)
		function change2(value){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
		    	data: {DICTIONARIES_ID:value},
				dataType:'json',
				cache: false,
				success: function(data){
					if( $("#level1").val() == ""){
						$("#level3").html('<option value=""></option>');
						}else{
							$("#level3").html('<option value=""></option>');
							 $.each(data.list, function(i, dvar){
								$("#level3").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
						 });
						}
				}
			});
		}	
		
 		$(function() {		
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
				dataType:'json',
				cache: false,
				success: function(data){

					if($("#level1").val() == ""){
						$("#level2").html('<option value=""></option>');
						$("#level3").html('<option value=""></option>');
						}else{
					$("#level2").html('<option value=""></option>');
					 $.each(data.roomList, function(i, dvar){
							$("#level2").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
					 $("#level2").val("${pd.level2}");

					 if( $("#level2").val()=="fe12952106f348caa1b7942517255b34"){							 
						 $("#level3").html('<option value=""></option>');
						 $.each(data.towFloorList, function(i, dvar){
								$("#level3").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
						 });
						 $("#level3").val("${pd.level3}");
						 alert(dvar.DICTIONARIES_ID);
						 }else if($("#level2").val()=="012f429aa60447049bbc11f17a3c4f0c"){
						 $("#level3").html('<option value=""></option>');
						 $.each(data.towFloorLists, function(i, dvar){
								$("#level3").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
						 });
						 $("#level3").val("${pd.level3}");
						 } else if($("#level2").val()=="f9d8ba081d904ff4a000c7134a682937"){
						 $("#level3").html('<option value=""></option>');
						 $.each(data.towFloorListss, function(i, dvar){
								$("#level3").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
						 });
						 $("#level3").val("${pd.level3}");
						 } else if($("#level2").val()=="743bd6b9d5694c63a52e39d21654fb00"){
						 $("#level3").html('<option value=""></option>');
						 $.each(data.towFloorListsss, function(i, dvar){
								$("#level3").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
						 });
						 $("#level3").val("${pd.level3}");
						 }
						} 
				}
			});
		});
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		//清空
		function back(){
			$("#PC_NO").val(""); 
			$("#BRAND").val(""); 
			$("#RAM").val(""); 
			$("#HDISK").val(""); 
			$("#BUILDING").val(""); 
			$("#ROOM").val(""); 
			$("#PROGRAM").val("");
			$("#G_TIME").val("");
			$("#DEPOT").val("");
			$("#DEFECTS_LIABILITY_PERIOD").val("");
		}
		</script>
</body>
</html>