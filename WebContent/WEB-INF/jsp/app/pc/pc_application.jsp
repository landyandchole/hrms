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
	<meta charset="utf-8" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<!-- 树形下拉框start -->
	<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
	<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
	<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
	<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/2.6/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
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
						<form action="pca/list.do" name="Form" id="Form" method="post">
						<input type="hidden" name="msg" id="msg"
									value="入场" />
				        <div id="zhongxin" style="padding-top: 13px;">
				        <table id="table_report"
									class="table table-striped table-bordered table-hover">
									<tr>
										<td style="width:75px;text-align: right;padding-top: 13px;">项目:</td>
								<td>
									<select name="NAME" id="NAME" style="width:80%;" onchange="message(this.value)">
									</select>
								</td>	
										<td style="width:85px;text-align: right;padding-top: 13px;">房间:</td>
								<td>
								<input type="text" name="ROOM_NAME" id="ROOM_NAME" placeholder="请输入房间号(例:C211)" title="房间"   />
							    </td>
										<td style="width:85px; text-align: right; padding-top: 13px;">申请状态：</td>
								<td>
									<select name="STATE" id="STATE" style="width:80%;"   onchange="message(this.value)">
										
									</select>
								</td>
										
										<td colspan="4" id="BUTTON"
											style="vertical-align: top; padding-left: 100px;">
											&nbsp; &nbsp;<a class="btn btn-light btn-xs"
											onclick="tosearch();">查询</a>
											<button class="btn btn-light btn-xs" onclick="back()"type="reset">重置</button>
										</td>
									</tr>
								</table>
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<thead>
								<tr>
								    <th class="center"></th>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>									
									<th class="center">项目</th>
									<!-- <th class="center">内存</th>
									<th class="center">硬盘</th>
									<th class="center">类型</th> -->
									<!-- <th class="center">房间</th> -->
									<th class="center">台数</th>
									<th class="center">备注</th>
									<th class="center">申请状态</th>
									<th class="center">申请时间</th>
								   <!--  <th class="center">工作流属性</th> -->
									<th class="center">流程</th>
									<th class="center">详细信息</th>
									<th class="center">操作</th>
								</tr>
							</thead>

																									
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
									<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
										<td>  <a id="membera${var.ID}" class="btn btn-xs btn-info"  onclick="application(this,'${var.ID}');">
														+
													</a></td>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>											
											<td class='center'>${var.NAME}</td>
											<%-- <td class='center'>${var.RAM}</td>
											<td class='center'>${var.HDISK}</td>
											<td class='center'>${var.TYPE}</td> --%>
											<%-- <td class='center'>${var.ROOM_NAME}</td> --%>
											<td class='center'>${var.PCNUMBER}</td>											
											<td class='center'>${var.REMARK}</td>
											<td class='center'>${var.STATE}</td>
											<td class='center'>${var.DATE}</td>
										  <%--   <td class='center'><c:if test="${var.PCSTATE == '1'}">退场流程</c:if>
																<c:if test="${var.PCSTATE == '0'}">入场流程</c:if></td> --%>
											<td class='center'>
											<a class="btn btn-xs btn-success"  title="Chart" onclick="aa('${var.ID}','${var.TASKID}')">Chart</a>
											</td>
											<td class='center'>
											<c:if test="${var.PROCESSINSTANCEID !=null}">		
											<a class="btn btn-xs btn-success" title="View" onclick="view('${var.ID}','${var.PROCESSINSTANCEID}')">View</a>
											</c:if>
											</td>
											<td class="center">	
											<c:if test="${var.STATE =='入场流程未提交'}">											
												<div class="hidden-sm hidden-xs btn-group">
														<a class="btn btn-xs btn-success" title="申请" onclick="startApply('${var.ID}','${var.PROJECT_ID}')">申请
														</a>
												</div>
											</c:if>	
											<c:if test="${var.STATE =='申请成功，入场审核中'}">											
												<div class="hidden-sm hidden-xs btn-group">
														<a class="btn btn-xs btn-success" title="撤回" onclick="withdraw('${var.PROCESSINSTANCEID}',1);">撤回
														</a>
												</div>
											</c:if>	
											
												<%-- <div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															<li>
																<a style="cursor:pointer;" onclick="del('${var.ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
														</ul>
													</div>
												</div> --%>
											</td>
										</tr>
									<thead id="div${var.ID}" style="display:none;">
								   <tr>
								   <th style="border:none;" class="center"></th>
								   <th style="border:none;" class="center"></th>
								   <th class="center" style="border:none;"></th>
									<th class="center">内存</th>
									<th class="center">硬盘</th>
									<th class="center">类型</th> 
									<th class="center">台数</th>
									<th class="center">房间</th>
									<th class="center">用途</th>
									<th class="center"></th>
									<th class="center"></th>
									<th class="center"></th>
								  </tr>
							     </thead>
									<tbody id="J_TbData${var.ID}">
                                     </tbody>
                                     <thead id="Fittingsdiv${var.ID}" style="display:none;">
								   <tr>
								   <th style="border:none;" class="center"></th>
								   <th style="border:none;" class="center"></th>
								   <th class="center" style="border:none;"></th>
									<th class="center">配件</th>
									<th class="center">数量</th>
									<th class="center"></th> 
									<th class="center"></th>
									<th class="center"></th>
									<th class="center"></th>
									<th class="center"></th>
									<th class="center"></th>
									<th class="center"></th>
								  </tr>
							     </thead>
									<tbody id="J_Fitting${var.ID}">
                                     </tbody>					
									</c:forEach>										
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
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<a class="btn btn-mini btn-success" onclick="havename();">新增</a>
									<!-- <a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a> -->
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						<input type = hidden  id = staname value = ${pd.name}>
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
				
		
		function tosearch(){
			 $("#Form").submit();
		}
		
		function back(){
			 $("#NAME").val("");
			 $("#ROOM_NAME").val(""); 
			 $("#STATE").val(""); 
		}
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>pca/goAdd.do';
			 diag.Width = 1000;
			 diag.Height = 800;
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
		
		
		function application(obj,id){
			 if (obj.innerHTML.indexOf('+') != -1) {	
					$.ajax({
						type: "POST",
						url: '<%=basePath%>pca/hasapplication.do?tm='+new Date().getTime()+'&ID='+id,
						dataType:'json',
						cache: false,
						success: function(data){
								$("#J_TbData"+id+"").html("");
								$("#J_Fitting"+id+"").html("");
							  $.each(data.Leavelist, function(i, dvar){
								  if(typeof(dvar.RAM)=="undefined"){
									  dvar.RAM="";
								  }
								  if(typeof(dvar.HDISK)=="undefined"){
									  dvar.HDISK="";
								  }
								  if(typeof(dvar.TYPE)=="undefined"){
									  dvar.TYPE="";
								  }
								  if(typeof(dvar.PURPOSE)=="undefined"){
									  dvar.PURPOSE="";
								  }
								  if(typeof(dvar.PCNUMBER)=="undefined"){
									  dvar.PCNUMBER="";
								  }
								  if(typeof(dvar.ROOM_NAME)=="undefined"){
									  dvar.ROOM_NAME="";
								  }
								 var $trTemp = $("<tr></tr>");
								 if(dvar.ACCESSORIES=="" || dvar.ACCESSORIES==null){
									 document.getElementById("div"+id+"").style.display="";
									//往行里面追加 td单元格
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.RAM+'</td>');
						                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.HDISK+'</td>');
						                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.TYPE+'</td>');
						                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.PCNUMBER+'</td>');
						                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.ROOM_NAME+'</td>');
						                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.PURPOSE+'</td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.appendTo("#J_TbData"+id+"");
								 }else{
									 document.getElementById("Fittingsdiv"+id+"").style.display="";
									//往行里面追加 td单元格
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.FITTINGS_NAME+'</td>');
						                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.PCNUMBER+'</td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.append('<td style="border:none;"></td>');
						                $trTemp.appendTo("#J_Fitting"+id+"");
								 }
					                
					               
						          });
							   document.getElementById("J_TbData"+id+"").style.display="";
							   document.getElementById("J_Fitting"+id+"").style.display="";
							   obj.innerHTML = '-';
						}
					});
				
				
			} else {		
				document.getElementById("div"+id+"").style.display="none";
				document.getElementById("J_TbData"+id+"").style.display="none";
				document.getElementById("Fittingsdiv"+id+"").style.display="none";
				document.getElementById("J_Fitting"+id+"").style.display="none";
				obj.innerHTML = '+';
			}  
			
		}
		function  aa(id,taskId){
			if(!taskId){
				taskId="";
			}
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="流程图";
			 diag.URL = '<%=basePath%>backlog/showActivityView.do?ID='+id+'&taskId='+taskId;
			 diag.Width =800;
			 diag.Height = 350;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 top.jzts();
				}
				diag.close();
			 };
			 diag.show();
		}

 		  
		$(function() {		
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
				dataType:'json',
				cache: false,
				success: function(data){
				     $("#NAME").html('<option value="">无项目</option>'); 
					 $.each(data.programList, function(i, dvar){
							$("#NAME").append("<option value="+dvar.PROJECT_NAME+">"+dvar.PROJECT_NAME+"</option>");
					 });
					$("#NAME").val('${pd.NAME}');
					 
					 $("#STATE").html('<option value=""></option>');
					 $.each(data.pcstateList, function(i, pcstate){
							$("#STATE").append("<option value="+pcstate.STATE+">"+pcstate.STATE+"</option>");
					 });
					 $("#STATE").val("${pd.STATE}");
					 $("#ROOM_NAME").val("${pd.ROOM_NAME}");
				}
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
								url: '<%=basePath%>pca/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
		   					    //beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
										 top.jzts();
										 $("#Form").submit();
											nextPage(${page.currentPage});
									 });
								}
							});
						}
					}
				}
			});
		};
		
		//详细信息
		function view(Id,PROCESSINSTANCEID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="详细信息";
			 diag.URL = '<%=basePath%>pca/goview.do?ID='+Id+'&&PROCESSINSTANCEID='+PROCESSINSTANCEID;
			 diag.Width = 1200;
			 diag.Height = 800;
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

		function withdraw(processInstanceId,status){
			var name = $("#NAME").val();
			var pcstate = $("#PCSTATE").val();
			$.post("${pageContext.request.contextPath}/pca/withdraw",{processInstanceId:processInstanceId,status:status},function(result){
				if(result.success){
					alert("撤回成功!");
					$("#Form").submit();
				}else{
					alert("系统系统,审批提交失败，请联系管理员！");
				}
			},"json");
		}
		
		function startApply(pc_leaveId,name){
			var msg=$("#msg").val();		
			$.post("${pageContext.request.contextPath}/pca/startApply",{pc_leaveId:pc_leaveId,name:name,msg:msg},function(result){
				if(result.success){
					alert("申请提交成功，目前审核中，请耐心等待！");
					$("#Form").submit();
				}else{
					alert("系统系统","申请提交失败，请联系管理员！");
				}
			},"json"); 
		}
		
		function havename(){
			if($("#staname").val()==""){
				alert("您还没有绑定员工账号！请联系管理员！")
			}else{
				add();
			}
			
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
		
		
	</script>


</body>
</html>