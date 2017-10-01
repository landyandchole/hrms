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
					
					<form action="project/${msg }.do" name="Form" id="Form" method="post">
 						<input type="hidden" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<c:if test="${msg == 'edit'}">	
							<tr>
								<td style="width:90px;text-align: right;padding-top: 13px;">项目编号:</td>
								<td colspan="3"><input type="text" name="PROJECT_PID" id="PROJECT_PID" value="${pd.PROJECT_PID}" maxlength="255" placeholder="这里输入项目编号" title="项目编号" readonly="readonly" style="width:97.2%;"/></td>
							</tr>
							</c:if>
							<tr>
								<td style="width:90px;text-align: right;padding-top: 13px;">项目名称:</td>
								<td colspan="3"><input type="text" name="PROJECT_NAME" id="PROJECT_NAME" value="${pd.PROJECT_NAME}" maxlength="255" placeholder="这里输入项目名称" title="项目名称" style="width:97.2%;"/></td>
							</tr>
							<tr>
								<td style="width:90px;text-align: right;padding-top: 13px;">合同金额:</td>
								<td colspan="3"><input type="number" name="PROJECT_PRICE" id="PROJECT_PRICE" value="${pd.PROJECT_PRICE}" maxlength="32" placeholder="这里输入合同金额" title="合同金额" style="width:97.2%;"/></td>
							</tr>
							<tr>
								<td style="width:90px;text-align: right;padding-top: 13px;">项目状态:</td>						
								<td >
									<select style=width:160px; name="PROJECT_STATE" id="PROJECT_STATE"></select>
                               </td>
							
							<td style="width:80px;text-align: right;padding-top: 13px;">所属部门:</td>
								<td style="width:250px">
									<input type="hidden" name="DEPARTMENT_ID" id="DEPARTMENT_ID" value="${pd.DEPARTMENT_ID}"/>
									<div class="selectTree" id="selectTree"></div>
								</td>
								
							</tr>
							<tr>
								<td style="width:90px;text-align: right;padding-top: 13px;">开始时间:</td>
								<td colspan="3"><input class="span10 date-picker" name="PROJECT_BTIME" id="PROJECT_BTIME" value="${pd.PROJECT_BTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开始时间" title="开始时间" style="width:97.2%;"/></td>
							</tr>
							<tr>
								<td style="width:90px;text-align: right;padding-top: 13px;">结束时间:</td>
								<td colspan="3"><input class="span10 date-picker" name="PROJECT_ETIME" id="PROJECT_ETIME" value="${pd.PROJECT_ETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="结束时间" title="结束时间" style="width:97.2%;"/></td>
							</tr>	
							<c:if test="${msg == 'save'}">				
							<tr>
							<td style="width:90px;text-align: right;padding-top: 13px;">项目经理:</td>
							<td style="vertical-align:top;padding-left:8px;width:80px;" id="MANAGER" >				
								 	<select class="chosen-select form-control" name="PROJECT_MANAGER" id="PROJECT_MANAGER" value="${pd.PROJECT_MANAGER}" data-placeholder="请输入工号">								
									<option value=""></option> 									
									<c:forEach items="${staffList}" var="staff">
										<option value="${staff.NO}"  <c:if test="${pd.PROJECT_MANAGER==staff.NO}">selected</c:if>>${staff.NO } ${staff.NAME}</option>
									</c:forEach>
								  	</select>
								</td>	
															
								<td style="width:90px;text-align: right;padding-top: 13px;">项目总监:</td>
								<td style="vertical-align:top;padding-left:8px;width:80px;" id="DIRECTOR" >				
								 	<select class="chosen-select form-control" name="PROJECT_DIRECTOR" id="PROJECT_DIRECTOR" value="${pd.PROJECT_DIRECTOR}" data-placeholder="请输入工号">								
									<option value=""></option> 									
									<c:forEach items="${staffList}" var="staff">
										<option value="${staff.NO}"  <c:if test="${pd.PROJECT_DIRECTOR==staff.NO}">selected</c:if>>${staff.NO } ${staff.NAME}</option>
									</c:forEach>
								  	</select>
								</td>	
							</tr> 
							
							<tr>
								<td style="width:112px;height:49px;text-align: left;padding-top: 13px;">项目室:
									<input type="button" id="button" value="+" style="width:24px;height:25px;text-align: center;font-size: 16px;margin:0px; padding:0px;" onclick="addtext();">
									<input type="button" id="button2" value="-" style="width:24px;height:25px;text-align: center;font-size: 16px;margin:0px; padding:0px;" onclick="deletetext();">
								</td>
								<td colspan="3" id="tag"></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
							</c:if>
							<c:if test="${msg == 'edit'}">
							<tr>
								<td style="width:90px;text-align: right;padding-top: 13px;">项目室:</td>
								<td colspan="3"><input type="text" id="ROOM_NAME" name="ROOM_NAME" value="${pd.ROOM_NAME}" maxlength="255" placeholder="请务必按照项目室格式书写(例:A211、B222、C333)" title="项目室" style="width:99.5%;"></td>
							</tr>
							
							
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="bc();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
							</c:if>
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
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		$(document).ready(function(){
			if($("#PROJECT_ID").val()!=""){
				//$("#PROJECT_NAME").attr("readonly","readonly");
				$("#PROJECT_NAME").css("color","gray");
			}
			
		});  
		
		
		 var flag = 0; 
		//保存
		function save(){
			if($("#PROJECT_NAME").val()==""){
				$("#PROJECT_NAME").tips({
					side:3,
		            msg:'请输入项目名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_NAME").focus();
			return false;
			}
			if($("#PROJECT_PRICE").val()==""){
				$("#PROJECT_PRICE").tips({
					side:3,
		            msg:'请输入合同金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_PRICE").focus();
			return false;
			}
			if($("#PROJECT_STATE").val()==""){
				$("#PROJECT_STATE").tips({
					side:3,
		            msg:'请输入项目状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_STATE").focus();
			return false;
			}
			
			if($("#DEPARTMENT_ID").val()==""){
				$("#DEPARTMENT_ID").tips({
					side:3,
		            msg:'请选择所属部门',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DEPARTMENT_ID").focus();
			return false;
			}
			if($("#PROJECT_BTIME").val()==""){
				$("#PROJECT_BTIME").tips({
					side:3,
		            msg:'请输入开始时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_BTIMET").focus();
			return false;
			}
			if($("#PROJECT_ETIME").val()==""){
				$("#PROJECT_ETIME").tips({
					side:3,
		            msg:'请输入结束时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_ETIME").focus();
			return false;
			}
			if($("#PROJECT_BTIME").val()!= "" && $("#PROJECT_ETIME").val() != ""){
				var t1 = $("#PROJECT_BTIME").val();
				var t2 = $("#PROJECT_ETIME").val();
				t1 = Number(t1.replace('-', '').replace('-', ''));
				t2 = Number(t2.replace('-', '').replace('-', ''));
				if(t1-t2>0){
					
					$("#PROJECT_ETIME").tips({
						side:3,
			            msg:'结束日期必须大于开始日期',
			            bg:'#AE81FF',
			            time:3
			        });
					
					return false;
				}
				
			
			} 
			
			 if($("#PROJECT_MANAGER").val()==""){
				$("#MANAGER").tips({
					side:3,
		            msg:'请选择项目经理',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_MANAGER").focus();
			return false;
			}	 
			   if($("#PROJECT_DIRECTOR").val()==""){
					$("#DIRECTOR").tips({
						side:3,
			            msg:'请输入项目总监',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#PROJECT_DIRECTOR").focus();
				return false;
				} 
				if(flag != 0){
					for(var i=1;i<=3;i++){
						if($('#BUILDING_'+ i).val()==""){
							$('#BUILDING_'+ i).tips({
								side:3,
					            msg:'请至少选择一个楼栋',
					            bg:'#AE81FF',
					            time:2
					        });
							$('#BUILDING_'+ i).focus();
							return false;
						}
						if($('#ROOM_'+ i).val()==""){
							$('#ROOM_'+ i).tips({
								side:3,
					            msg:'请至少输入一个项目室',
					            bg:'#AE81FF',
					            time:2
					        });
							$('#BUILDING_'+ i).focus();
							return false;
						}
					}
					if($("#BUILDING_1").length>0 && $("#BUILDING_3").length>0){
						if($("#BUILDING_1").val() == $("#BUILDING_2").val() && $("#ROOM_1").val() == $("#ROOM_2").val()){
							$('#ROOM_2').tips({
								side:3,
					            msg:'你有毒吧，输重了',
					            bg:'#AE81FF',
					            time:2
					        });
							$('#ROOM_2').focus();
							return false;
						}
					}
					if($("#BUILDING_1").length>0 && $("#BUILDING_3").length>0){
						if($("#BUILDING_1").val() == $("#BUILDING_3").val() && $("#ROOM_1").val() == $("#ROOM_3").val()){
							$('#ROOM_3').tips({
								side:3,
					            msg:'你有毒吧，输重了',
					            bg:'#AE81FF',
					            time:2
					        });
							$('#ROOM_3').focus();
							return false;
						}
					}
					if($("#BUILDING_2").length>0 && $("#BUILDING_3").length>0){
	 					if($("#BUILDING_2").val() == $("#BUILDING_3").val() && $("#ROOM_2").val() == $("#ROOM_3").val()){
							$('#ROOM_3').tips({
								side:3,
					            msg:'你有毒吧，输重了',
					            bg:'#AE81FF',
					            time:2
					        });
							$('#ROOM_3').focus();
							return false;
						} 
					}
				}else{
						$("#button").tips({
							side:3,
				            msg:'点一下 + 增加一个项目室吧',
				            bg:'#AE81FF',
				            time:2
				        });
						$("#button").focus();
						return false;
					}
				
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}	
            
		//保存
		function bc(){
			if($("#PROJECT_NAME").val()==""){
				$("#PROJECT_NAME").tips({
					side:3,
		            msg:'请输入项目名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_NAME").focus();
			return false;
			}
			if($("#PROJECT_PRICE").val()==""){
				$("#PROJECT_PRICE").tips({
					side:3,
		            msg:'请输入合同金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_PRICE").focus();
			return false;
			}
			if($("#PROJECT_STATE").val()==""){
				$("#PROJECT_STATE").tips({
					side:3,
		            msg:'请输入项目状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_STATE").focus();
			return false;
			}
			
			if($("#DEPARTMENT_ID").val()==""){
				$("#DEPARTMENT_ID").tips({
					side:3,
		            msg:'请选择所属部门',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DEPARTMENT_ID").focus();
			return false;
			}
			if($("#PROJECT_BTIME").val()==""){
				$("#PROJECT_BTIME").tips({
					side:3,
		            msg:'请输入开始时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_BTIMET").focus();
			return false;
			}
			if($("#PROJECT_ETIME").val()==""){
				$("#PROJECT_ETIME").tips({
					side:3,
		            msg:'请输入结束时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_ETIME").focus();
			return false;
			}
			if($("#PROJECT_BTIME").val()!= "" && $("#PROJECT_ETIME").val() != ""){
				var t1 = $("#PROJECT_BTIME").val();
				var t2 = $("#PROJECT_ETIME").val();
				t1 = Number(t1.replace('-', '').replace('-', ''));
				t2 = Number(t2.replace('-', '').replace('-', ''));
				if(t1-t2>0){
					
					$("#PROJECT_ETIME").tips({
						side:3,
			            msg:'结束日期必须大于开始日期',
			            bg:'#AE81FF',
			            time:3
			        });
					
					return false;
				}				
			} 	
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}	
            
		 $(function() {
				//日期框
				$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
				
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
		  //下拉树
			var defaultNodes = {"treeNodes":${zTreeNodes}};
			function initComplete(){
				//绑定change事件
				$("#selectTree").bind("change",function(){
					if(!$(this).attr("relValue")){
				      //  top.Dialog.alert("没有选择节点");
				    }else{
						//alert("选中节点文本："+$(this).attr("relText")+"<br/>选中节点值："+$(this).attr("relValue"));
						$("#DEPARTMENT_ID").val($(this).attr("relValue"));
				    }
				});
				//赋给data属性
				$("#selectTree").data("data",defaultNodes);  
				$("#selectTree").render();
				$("#selectTree2_input").val("${null==depname?'请选择':depname}");
			}  
			//下拉框
			 $(function() {		
					$.ajax({
						type: "POST",
						url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
						dataType:'json',
						cache: false,
						success: function(data){
							$("#PROJECT_STATE").html('<option value="">请选择</option>');
							 $.each(data.projectStatelist, function(i, dvar){
									$("#PROJECT_STATE").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
							 });
							 $("#PROJECT_STATE").val("${pd.PROJECT_STATE}");
							
						}
					});
				}); 
				
			
			//按一下按钮就增加一个下拉框一个文本框
			   var i = 1;
			   function addtext(){
				   $.ajax({
						type: "POST",
						url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
						dataType:'json',
						cache: false,
						success: function(data){
							
							if(i<=3){
							    $("#tag").append('<td style="width:215px;"><select onchange="block()" style="width:55px;height:31px" class="name" id="BUILDING_'+ i +'" name="BUILDING_['+ i +']"></select><input type="text" placeholder="这里输入房间号(例:211)" style="width:158px;height:31px;border:1px solid #D3D3D3;" name="ROOM_['+ i +']" id="ROOM_'+ i +'"></td>');
								$("#BUILDING_"+ i +"").append('<option></option>');
								var j=i;
								$.each(data.buildingList, function(i, dvar){
									$("#BUILDING_"+ j +"").append("<option value="+dvar.NAMEUse+">"+dvar.NAME+"</option>");
								});
								i++;
								flag++;
							}else{
								$("#tag").tips({
									side:3,
							           msg:'你要这多房干啥，最多就三个',
							           bg:'#AE81FF',
							           time:2
							    });
								$("#tag").focus();
							return false;
							}

						}
				   })

			   }
			   //删除最后一个节点
			   function deletetext(){
					$("#tag").children().last().remove();
					if(i>1&&flag>0){
						i--;
						flag--;
					}else{
						$("#button2").tips({
							side:3,
					           msg:'别点了，已经被删光了',
					           bg:'#AE81FF',
					           time:2
					    });
						$("#button2").focus();
					}
			   }
			   //当选择青浦外时，锁掉后边的文本框
			   function block(){
				   var i=1;
				   for(;i<=3;i++){
					   if($("#BUILDING_"+ i +"").val()==("不在园区内")){
						   $("#ROOM_"+ i +"").attr("readonly","readonly");
					   }else{
						   $("#ROOM_"+ i +"").removeAttr("readonly");
					   }
				   }
			   }
			
		</script>
</body>
</html>