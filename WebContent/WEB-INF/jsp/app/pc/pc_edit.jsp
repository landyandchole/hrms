<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<!-- 树形下拉框start -->
	<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
	<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
	<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
	<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/2.6/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
	<!-- 树形下拉框end -->

<body class="no-skin">	
<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">		
					<form action="pc/${msg}.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PC_ID" id="PC_ID" value="${pd.PC_ID}"/>
						 <div id="zhongxin" style="padding-top: 13px;"> 
						<table id="table_report" class="table table-striped table-bordered table-hover">
							
							<tr>
							    <td style="width:12%;text-align: right;padding-top: 13px;">PC编号:</td>
								<td style="width:38%;"><input type="text" name="PC_NO" id="PC_NO" value="${pd.PC_NO}" maxlength="50" placeholder="这里输入PC编号" title="PC编号" style="width:98%;"/></td>								
								<td style="width:12%;text-align: right;padding-top: 13px;">品牌:</td>
								<td style="width:38%;">
									<select name="BRAND" id="BRAND" style="width:98%;">
										
									</select>
								</td>												
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">内存:</td>
								<td style="width:38%;">
									<select name="RAM" id="RAM" style="width:98%;">
										
									</select>
								</td>	
								<td style="width:75px;text-align: right;padding-top: 13px;">硬盘:</td>
								<td style="width:38%;">
									<select name="HDISK" id="HDISK" style="width:98%;">
										
									</select>
								</td>										
							</tr>
							
							<tr>
							    <td style="width:75px;text-align: right;padding-top: 13px;">芯片:</td>
								<td style="width:38%;">
									<select name="CHIP" id="CHIP" style="width:98%;">
									
									</select>
								</td>
								<td style="width:75px;text-align: right;padding-top: 13px;">类型:</td>			
								<td style="width:38%;">
									<select name="TYPE" id="TYPE" style="width:98%;">
									
									</select>
								</td>
							</tr>
								
							<tr>
								<!-- <td style="width:75px;text-align: right;padding-top: 13px;">项目:</td>
								<td>
									<select name="PROGRAM" id="PROGRAM" style="width:100%;">
									</select>
								</td> -->
								<%-- <td style="width:75px;text-align: right;padding-top: 13px;" >项目:</td>
							    <td style="vertical-align:top;padding-left:8px;width:38%;" >				
								 	<select class="chosen-select form-control" name="PROGRAM" id="PROGRAM" value="${pd.PROGRAM}" data-placeholder="请输入项目" style="vertical-align:top;width:98%;"  >								
									<option value="000">无项目</option> 									
									<c:forEach items="${projectList}" var="project">
										<option id="PROGRAM"  name="PROGRAM" value="${project.PROJECT_ID}"  <c:if test="${pd.PROGRAM==project.PROJECT_ID}">selected</c:if>> ${project.PROJECT_NAME}</option>
									</c:forEach>
								  	</select>
								</td> --%>
								 <td style="width:75px;text-align: right;padding-top: 13px;">操作系统:</td>
								<td style="width:38%;">
									<select name="OS" id="OS" style="width:98%;">
									
									</select>
								</td>
					            <td style="width:75px;text-align: right;padding-top: 13px;">保修时间:</td>
                                <td style="width:38%;"><input class="span10 date-picker" name="G_TIME" id="G_TIME" value="${pd.G_TIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="请输入保修时间" title="保修时间" style="width:98%;"/></td>						
							</tr>		
													
							 <%-- <tr>
							    <td style="width:85px;text-align: right;padding-top: 13px;">房间:</td>
							    <td id="ROOM_NAME" name="ROOM_NAME" style="width:38%;" >
							    	<select class="chosen-select form-control" name="tag" id="tag" data-placeholder="请选择房间" style="vertical-align:top;width: 98%;"></select>
							    	<td colspan="2"><p style="color:red;padding-top: 6px">*在选择之前请先选择项目</p></td>
							    </td>
							    
							   <td><input type="text" id="textroom" name="textroom" style="width:100%;" value="${pd.ROOM_NAME}"></td>
							    <td style="text-align: left;padding-top: 13px;padding-left:15px;"><input type="radio" id="radioroom" name="radioroom"> --%>
								<%-- <c:if test="${msg == 'save'}">
								<td colspan="3">
								<select class="chosen-select form-control" name="LEVEL" id="LEVEL"   onchange="change1(this.value)" data-placeholder="请选择状态" background-color: #EEEEEE;" disabled="disabled" style="vertical-align:top;float:left; width: 33.33%;">
								  	</select>
								  	<div>
								  	<select class="chosen-select form-control" name="FLOOR" id="FLOOR"  onchange="change2(this.value)" data-placeholder="请选择状态" background-color: #EEEEEE;" disabled="disabled" style="vertical-align:top;float:left;width: 33.33%;">
								  	</select>
								  	<select class="chosen-select form-control" name="ROOM" id="ROOM"  onchange="change3(this.value)" data-placeholder="请选择状态" background-color: #EEEEEE;" disabled="disabled" style="vertical-align:top;float:right;width: 33.33%;">
								  	</select>
								  	</div>
								  	</td>
								</c:if>
								<c:if test="${msg == 'edit'}">
								<td colspan="3">
								<select class="chosen-select form-control" name="LEVEL" id="LEVEL"   onchange="change1(this.value)" data-placeholder="请选择状态"  style="vertical-align:top;float:left; width: 33.33%;">
								  	</select>
								  	<div>
								  	<select class="chosen-select form-control" name="FLOOR" id="FLOOR"  onchange="change2(this.value)" data-placeholder="请选择状态" style="vertical-align:top;float:left;width: 33.33%;">
								  	</select>
								  	<select class="chosen-select form-control" name="ROOM" id="ROOM"  onchange="change3(this.value)" data-placeholder="请选择状态" style="vertical-align:top;float:right;width: 33.33%;">
								  	</select>
								  	</div>
								  	</td>
								 </c:if> 
							</tr>--%>
<!-- 							<tr><td ><input type="button" id="button" value="ayaya" onclick="addtext();"></td>
								<td colspan="3" id="tag"></td>
							</tr> -->
							<tr>
							   
								<td style="width:75px;text-align: right;padding-top: 13px;">在库情况:</td>
								<td style="width:38%;">
									<select name="DEPOT" id="DEPOT" style="width:98%;">
									</select>
								</td>
								<td  style="width:75px;text-align: right;padding-top: 13px;">电脑成本:</td>
								<td colspan="3" style="width:38%;"><input  type="number" name="COST" id="COST" maxlength="50" value="${pd.COST}" placeholder="这里输入电脑成本" title="电脑成本" style="width:98%;"/></td>			
							</tr>
							<tr>
							    <td style="width:75px;text-align: right;padding-top: 13px;">质保期:</td>
								<td style="width:38%;">
									<select name="DEFECTS_LIABILITY_PERIOD" id="DEFECTS_LIABILITY_PERIOD" style="width:98%;">
									
									</select>
								</td>	
								
							</tr>
							<tr>	
								<td  style="width:75px;text-align: right;padding-top: 13px;">MAC地址:</td>
								<td colspan="3" ><input  type="text" name="MAC" id="MAC" maxlength="50" value="${pd.MAC}" placeholder="这里输入MAC地址" title="MAC地址" style="width:98%;"/></td>	
							</tr>					
						   
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td colspan="10"><input type="text" name="NOTE" id="NOTE" value="${pd.NOTE}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
</div>
<!-- /.main-container -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>	
	<script type="text/javascript">
		/* $(function(){
			console.log($("#PROGRAM").val());
			message($("#PROGRAM").val());
			$("#PROGRAM").click(function(){
				message($("#PROGRAM").val());
			})
		}) */
		$(top.hangge());
		$(function() {		
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
				dataType:'json',
				cache: false,
				success: function(data){
					 $("#TYPE").html('<option></option>');
					 $.each(data.typeList, function(i, dvar){
							$("#TYPE").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
					$("#BRAND").html('<option></option>');
					 $.each(data.brandList, function(i, dvar){
							$("#BRAND").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
					 $("#RAM").html('<option></option>');
					 $.each(data.ramList, function(i, dvar){
							$("#RAM").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
					 $("#HDISK").html('<option></option>');
					 $.each(data.hdiskList, function(i, dvar){
							$("#HDISK").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
					 $("#CHIP").html('<option></option>');
					 $.each(data.chipList, function(i, dvar){
							$("#CHIP").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
					 $("#OS").html('<option></option>');
					 $.each(data.osNameList, function(i, dvar){
							$("#OS").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
					 $("#DEPOT").html('<option></option>');
					 $.each(data.depotNameList, function(i, dvar){
							$("#DEPOT").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
					  $("#DEFECTS_LIABILITY_PERIOD").html('<option></option>');
					 $.each(data.liabilityNameList, function(i, dvar){
							$("#DEFECTS_LIABILITY_PERIOD").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
					  
					 $("#TYPE").val("${pd.TYPE}");
					 $("#BRAND").val("${pd.BRAND}");
					 $("#RAM").val("${pd.RAM}");
					 $("#HDISK").val("${pd.HDISK}");
					 $("#CHIP").val("${pd.CHIP}");
					 $("#OS").val("${pd.OS}");
					 $("#DEPOT").val("${pd.DEPOT}");
					/*  $("#DEFECTS_LIABILITY_PERIOD").val("${pd.DEFECTS_LIABILITY_PERIOD}"); */
					 
				}
			});
		});
		
		//保存		
			function save(){				
				if($("#PC_NO").val()==""){
					$("#PC_NO").tips({
						side:3,
			            msg:'请输入PC编号',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#PC_NO").focus();
				return false;
				}
				if($("#BRAND").val()==""){
					$("#BRAND").tips({
						side:3,
			            msg:'请输入品牌',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#BRAND").focus();
				return false;
				}			
				if($("#RAM").val()==""){
					$("#RAM").tips({
						side:3,
			            msg:'请输入内存',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#RAM").focus();
				return false;
				}
				if($("#HDISK").val()==""){
					$("#HDISK").tips({
						side:3,
			            msg:'请输入硬盘',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#HDISK").focus();
				return false;
				}
				if($("#CHIP").val()==""){
					$("#CHIP").tips({
						side:3,
			            msg:'请输入芯片',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#CHIP").focus();
				return false;
				}
				if($("#TYPE").val()==""){
					$("#TYPE").tips({
						side:3,
			            msg:'请输入类型',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#TYPE").focus();
				return false;
				}
				/* if($("#PROGRAM").val()==""){
					$("#PROGRAM").tips({
						side:3,
			            msg:'请输入项目',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#PROGRAM").focus();
				return false;
				}
				if($("#LEVEL").val()==""){
					$("#LEVEL").tips({
						side:3,
			            msg:'请输入房间',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#LEVEL").focus();
				return false;
				}
				if($("#FLOOR").val()==""){
					$("#FLOOR").tips({
						side:3,
			            msg:'请输入楼层',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#FLOOR").focus();
				return false;
				}
				if($("#ROOM").val()==""){
					$("#ROOM").tips({
						side:3,
			            msg:'请输入房间号',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#ROOM").focus();
				return false;
				} */
				if($("#DEPOT").val()==""){
					$("#DEPOT").tips({
						side:3,
			            msg:'请输入在库情况',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#DEPOT").focus();
				return false;
				}

				$("#Form").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
			}
		
			$(function() {
				$('#PC_NO').blur(function() {
				var PC_NO = $("#PC_NO").val();			
				$.ajax({				
					type: "POST",	
					url: '<%=basePath%>pc/hasU.do',		
					data: {PC_NO:PC_NO,tm:new Date().getTime()},
					dataType:'json',
					cache: false,
					success: function(data){
						 if("error" == data.result){
							 $("#PC_NO").tips({
									side:3,
						            msg:'此编号已存在!',
						            bg:'#AE81FF',
						            time:2
						        });
								document.getElementById("PC_NO").value="";						
						 }else{
							 $("#PC_NO").css("background-color","white");
						 } 
						 
					 }
				  });
				});
			});
			
			<%-- function message(id){
				if(id==null || id==""){
					$("#tag").html('<option value="217">217</option>');
				}
				else{
				$("#tag").empty();
				$.ajax({
					type: "POST",
					url: '<%=basePath%>pc/level.do?PROJECT_ID='+id,
					dataType:'json',
					cache: false,
					success: function(data){
						var i = 0;
						/* $("#tag").html("<option value=""></option>"); */
						if(data.pdData.length!=1){
							for(;i<data.pdData.ROOM_NAMEWWW.length;i++){
								/* $("#tag").append('<tr><td><input type="text" id="i'+i+'" name="i'+i+'" style="width:100%;" value="'+data.pdData.ROOM_NAMEWWW[i]+'"></td><td style="text-align: left;padding-top: 6px;padding-left:15px;"><input type="radio" id="r'+i+'" name="r'+i+' value='+i+'"></td></tr>'); */
								$("#tag").append("<option value="+data.pdData.ROOM_NAMEWWW[i]+">"+data.pdData.ROOM_NAMEWWW[i]+"</option>");
							}
						}else{
							$("#tag").append("<option value="+data.pdData.ROOM_NAMEWWW+">"+data.pdData.ROOM_NAMEWWW+"</option>");
						}

					}
				});
				}
			}	 --%>
			
			$(function() {
				//日期框
				$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
				
			});

		
			//初始第一级
			$(function() {
				$.ajax({
					type: "POST",
					url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
			    	data: {},
					dataType:'json',
					cache: false,
					success: function(data){
						$("#LEVEL").html('<option value="">请选择</option>');
						 $.each(data.list, function(i, dvar){
								$("#LEVEL").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
						 });
						 $("#LEVEL").val("${pd.LEVEL}");
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
						if($("#LEVEL").val() == ""){
							$("#FLOOR").html('<option value="">请选择</option>');
							$("#ROOM").html('<option value="">请选择</option>');
							}else{
							$("#FLOOR").html('<option value="">请选择</option>');
							 $.each(data.list, function(i, dvar){
									$("#FLOOR").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
							 });
							}
					}
				});
			}
			//下拉框
			 $(function() {		
					$.ajax({
						type: "POST",
						url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
						dataType:'json',
						cache: false,
						success: function(data){
							 $("#FLOOR").html('<option value="">请选择</option>');
							 $.each(data.roomList, function(i, dvar){
									$("#FLOOR").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
							 });
							 $("#FLOOR").val("${pd.FLOOR}");
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
						if( $("#FLOOR").val() == ""){
							$("#ROOM").html('<option value="">请选择</option>');
						}else{
							$("#ROOM").html('<option value="">请选择</option>');
							$.each(data.list, function(i, dvar){
								$("#ROOM").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
						 });
							 $("#ROOM").val("${pd.ROOM}");
							 
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
				 			 if($("#LEVEL").val() == ""){
								$("#FLOOR").html('<option value=""></option>');
								$("#ROOM").html('<option value=""></option>');
								}else{ 
							 $("#FLOOR").html('<option value=""></option>');
							 $.each(data.roomList, function(i, dvar){
									$("#FLOOR").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
							 });
							 $("#FLOOR").val("${pd.FLOOR}");
							 if( $("#FLOOR").val()=="fe12952106f348caa1b7942517255b34"){							 
								 $("#ROOM").html('<option value="">请选择</option>');
								 $.each(data.towFloorList, function(i, dvar){
										$("#ROOM").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
								 });
								 $("#ROOM").val("${pd.ROOM}");
								 }else if($("#FLOOR").val()=="012f429aa60447049bbc11f17a3c4f0c"){
								 $("#ROOM").html('<option value="">请选择</option>');
								 $.each(data.towFloorLists, function(i, dvar){
										$("#ROOM").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
								 });
								 $("#ROOM").val("${pd.ROOM}");
								 } else if($("#FLOOR").val()=="f9d8ba081d904ff4a000c7134a682937"){
								 $("#ROOM").html('<option value="">请选择</option>');
								 $.each(data.towFloorListss, function(i, dvar){
										$("#ROOM").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
								 });
								 $("#ROOM").val("${pd.ROOM}");
								 } else if($("#FLOOR").val()=="743bd6b9d5694c63a52e39d21654fb00"){
								 $("#ROOM").html('<option value="">请选择</option>');
								 $.each(data.towFloorListsss, function(i, dvar){
										$("#ROOM").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
								 });
								 $("#ROOM").val("${pd.ROOM}");
								 }else if($("#FLOOR").val()==""){
									 $("#ROOM").html('<option value="">请选择</option>');
								 }
							 
							}
							 /* alert("${pd.ROOM}"); */
							/*  $("#ROOM").append("<option value="+data.pdData.DICTIONARIES_ID+">"+data.pdData.NAME+"</option>"); */
						 }
					});
				});
		</script>
		
	
	<script type="text/javascript">
		 $(top.hangge());//关闭加载状态
	</script>
				
</body>
</html>