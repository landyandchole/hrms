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
						<form action="fittings/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								
								<td style="width:75px;text-align: right;padding-top: 2px;">配件名称:</td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select  name="FITTINGS_ID" id="FITTINGS_ID" data-placeholder="请选择配件" style="vertical-align:top;width: 120px">
									<option value="">请选择配件</option>
									<c:forEach items="${typeList}" var="fittings">
										<option value="${fittings.FITTINGS_ID}" <c:if test="${pd.FITTINGS_ID==fittings.FITTINGS_ID}">selected</c:if>>${fittings.FITTINGS_NAME}</option>
									</c:forEach>
								  	</select>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td colspan="2" style="vertical-align:top;padding-left:2px">
						        	<div style="padding-left: 15px;">
							        	<a class="btn btn-light btn-xs" onclick="tosearch();"  title="查询">
											<div style="color:#000000">查询</div>
							        	</a>&nbsp;&nbsp;
										<a class="btn btn-light btn-xs" id="button" title="重置" onclick="back();">
											<div style="color:#000000;">重置</div>
										</a>
						        	</div>
						        </td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
								<th class="center"></th>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">配件名称</th>
									<th class="center">操作</th>
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
											 <a id="membera${var.FITTINGS_ID}" class="btn btn-xs btn-info" onclick="fittingsType(this,'${var.FITTINGS_ID}');">
														+
													</a>
											</td>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.FITTINGS_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.FITTINGS_NAME}</td>
											<td class="center">
												<c:if test="${QX.add == 1 }">
									            <a class="btn btn-mini btn-success" onclick="add('${var.FITTINGS_ID}');">新增参数</a>
									            <a class="btn btn-xs btn-danger" onclick="del('${var.FITTINGS_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													
									            </c:if>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.add == 1 }">
									                         <a class="btn btn-mini btn-success" onclick="add('${var.FITTINGS_ID}');">新增参数</a>
									                         <a style="cursor:pointer;" onclick="del('${var.FITTINGS_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
									                        </c:if>
														</ul>
													</div>
												</div>
											</td>
										</tr>
									<thead id="div${var.FITTINGS_ID}" style="display:none;">
								   <tr>
								    <th class="center"></th>
									<th class="center" style="width:35px;"></th>
									<th class="center" style="width:50px;"></th>
									<th class="center">参数名称</th>
									<th class="center"></th>
								  </tr>
							     </thead>
							     <tbody id="J_TbData${var.FITTINGS_ID}">
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
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="add();">新增配件</a>
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
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		function back(){
			$("#FITTINGS_ID").val(""); 
		}
		function fittingsType(obj,id){
			//${pd.projectname}${pd.projectmanager}${pd.pcnumber}PC_STATE${pd.admissioncharge}${pd.exitcharge}${pd.applicant}
			 if (obj.innerHTML.indexOf('+') != -1) {
					$.ajax({
						type: "POST",
						url: '<%=basePath%>fittings/fittingstype.do?tm='+new Date().getTime()+'&PARENT_ID='+id,
						dataType:'json',
						cache: false,
						success: function(data){
								document.getElementById("div"+id+"").style.display="";
								$("#J_TbData"+id+"").html("");
							  $.each(data.varList, function(i, dvar){
								  if(typeof(dvar.FITTINGS_NAME)=="undefined"){
									  dvar.FITTINGS_NAME="";
								  }
								 var $trTemp = $("<tr></tr>");
					                //往行里面追加 td单元格
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:none;"></td>');
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;"><a id="membera'+dvar.FITTINGS_ID+'"></a> </td>'); 
					                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.FITTINGS_NAME+'</td>');
					                $trTemp.append('<td class="center">'
					                +'<c:if test="${QX.edit == 1 }"> <a class="btn btn-xs btn-success" title="编辑" onclick="edit(/'+dvar.FITTINGS_ID+'/)">'
					                +'<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i></a></c:if>'
					               /*  +'<c:if test="${QX.add == 1 }"><a class="btn btn-mini btn-success" onclick="add(/'+dvar.FITTINGS_ID+'/);">新增详情</a>'
					                +'</a></c:if>' */
					                +'<c:if test="${QX.cha == 1 }"><a class="btn btn-xs btn-info" onclick="golist(/'+dvar.FITTINGS_ID+'/);">'
					                +'<i class="ace-icon fa fa-search-plus bigger-120"title="查看详情"></i></a></c:if>'
					                +'<c:if test="${QX.del == 1 }"><a class="btn btn-xs btn-danger" onclick="makeAll("确定要删除选中的数据吗?");" title="删除" >'
					                +'<i class="ace-icon fa fa-trash-o bigger-120"></i></a></c:if>');
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
		
		
		<%-- function fittingsTypeDate(obj,id){
			 if (obj.innerHTML.indexOf('+') != -1) {	
					$.ajax({
						type: "POST",
						url: '<%=basePath%>fittings/fittingstype.do?tm='+new Date().getTime()+'&PARENT_ID='+id,
						dataType:'json',
						cache: false,
						success: function(data){
							document.getElementById("typediv").style.display="";
							$("#J_TypeData").html("");
						  $.each(data.varList, function(i, dvar){
							  if(typeof(dvar.FITTINGS_NAME)=="undefined"){
								  dvar.FITTINGS_NAME="";
							  }
							
							 var $trTemp = $("<tr></tr>");
				                //往行里面追加 td单元格
				                $trTemp.append('<td style="border:none;"></td>');
				                $trTemp.append('<td style="border:none;"></td>');
				                $trTemp.append('<td style="border:none;"></td>');
				                $trTemp.append('<td style="border:2.5px inset;text-align: center;">'+dvar.FITTINGS_NAME+'</td>');

				               /*  $trTemp.append('<td class="center"><c:if test="${QX.edit == 1 }"><a class="btn btn-xs btn-success" title="新增详情" onclick="add(/'+dvar.FITTINGS_ID+'/);"><i class="ace-icon fa fa-pencil-square-o bigger-120" title="新增详情"></i></c:if></a>') */
				                $trTemp.append('<td class="center"><c:if test="${QX.edit == 1 }"><a class="btn btn-xs btn-success" title="编辑" onclick="edit(/'+dvar.FITTINGS_ID+'/)">'
				                +'<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i></a></c:if>'
				                +'<a class="btn btn-mini btn-danger" onclick="makeAll("确定要删除选中的数据吗?");" title="批量删除" >'
				                +'<i class="ace-icon fa fa-trash-o bigger-120"></i></a>');
				                $trTemp.appendTo("#J_TypeData");
					          });
						   document.getElementById("J_TypeData").style.display="";
						   obj.innerHTML = '-';
						}
					});
				
				
			} else {		
				document.getElementById("typediv").style.display="none";
				document.getElementById("J_TypeData").style.display="none";
				obj.innerHTML = '+';
			}  
			
		} --%>
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
		
		//新增
		function add(id){
			 if(typeof(id)=="undefined"){
				 id="";
			  }
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>fittings/goAdd.do?PARENT_ID='+id;
			 diag.Width = 450;
			 diag.Height = 355;
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
		
		//去查看详情页面
		function golist(id){
			 if(typeof(id)=="undefined"){
				 id="";
			  }
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="查看详情";
			 diag.URL = '<%=basePath%>fittings/goList.do?PARENT_ID='+id;
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				/*  if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 tosearch();
					 }else{
						 tosearch();
					 }
				} */
				diag.close();
			 };
			 diag.show(); 
		}
		
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>fittings/delete.do?FITTINGS_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 alert(Id)
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>fittings/goEdit.do?FITTINGS_ID='+Id;
			 diag.Width = 450;
			 diag.Height = 355;
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
								url: '<%=basePath%>fittings/deleteAll.do?tm='+new Date().getTime(),
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
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>fittings/excel.do';
		}
	</script>


</body>
</html>