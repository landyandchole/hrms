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
					<form action="pca/${msg}.do" name="Form" id="Form" method="post">
						 <input type="hidden" name="P_RAMS" id="P_RAMS"/>
						 <input type="hidden" name="P_HDISKS" id="P_HDISKS"/>
						 <input type="hidden" name="P_TYPES" id="P_TYPES"/>
						 <input type="hidden" name="P_PCNUMBERS" id="P_PCNUMBERS"/>
						 <input type="hidden" name="P_PURPOSES" id="P_PURPOSES"/>
						 <input type="hidden" name="P_EINLASSS" id="P_EINLASSS"/>
						 <input type="hidden" name="P_BUILDINGS" id="P_BUILDINGS"/>
						 <input type="hidden" name="P_ROOMS" id="P_ROOMS"/>
						 <input type="hidden" name="P_ROOM_NAMES" id="P_ROOM_NAMES"/>
						 <input type="hidden" name="P_ACCESSORIESS" id="P_ACCESSORIESS"/>
						 <input type="hidden" name="P_FPCNUMBER" id="P_FPCNUMBER"/>
						 <input type="hidden" name="P_FBUILDINGS" id="P_FBUILDINGS"/>
						 <input type="hidden" name="P_FROOMS" id="P_FROOMS"/>
						 <input type="hidden" name="P_FROOM_NAMES" id="P_FROOM_NAMES"/>
						 <div id="zhongxin" style="padding-top: 13px;"> 
						 <input  id="j" name="j"  type = "hidden" value = "1" >
						 <input  id="str" name="str"  type="hidden"  />
						 <input  id="i" name="i"  type = "hidden" value = "1" >
						 <table id="table_report" class="table table-striped table-bordered table-hover">
						 	<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目:</td>
								<td>
									<select name="NAME" id="NAME" style="width:32%;" >
										
									</select>&nbsp;&nbsp;&nbsp;&nbsp;
									<input  id="PRO" name="PRO"  type = "checkbox" value = "" >无项目
								</td>	
								</tr>
								<tr>
<!-- 								<td style="width:85px;text-align: right;padding-top: 13px;">房间:</td>
								<td name="ROOM_NAME" id="ROOM_NAME" colspan="2">
							    	<select class="chosen-select form-control" name="tag" id="tag" data-placeholder="请选择房间" style="vertical-align:top;width: 160px;"></select>
							    </td> -->										
							</tr>
							</table>
						<table id="table_report" class="table table-striped table-bordered table-hover">
						<thead>
								<tr>
									<th class="center">内存</th>
									<th class="center">硬盘</th>
									<th class="center">类型</th>
									<th class="center">台数</th>
									<th class="center">用途</th>
									<th class="center">入场时间</th>
									<!-- <th class="center">配件</th> -->
									<th class="center">房间</th>
									<th class="center">操作</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<select name="RAM" id="RAM" style="width:98%;">
											
										</select>
									</td>						
									<td>
										<select name="HDISK" id="HDISK" style="width:98%;">
										
										</select>
									</td>						
									<td>
										<select name="TYPE" id="TYPE" style="width:98%;">
											
										</select>
									</td>	
									<td><input type="number" name="PCNUMBER" id="PCNUMBER"  class="spinnerExample" step="1" min="1"></td>
									<!-- <td>
										<input onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text"  name="PCNUMBER" id="PCNUMBER" style="width:160px;">
									</td> -->
									<td>
										<select name="PURPOSE" id="PURPOSE" style="width:98%;">
											
										</select>
									</td>
									<td>
										<input class="span10 date-picker" name="EINLASS" id="EINLASS" value="${pd.EINLASS}" type="text" data-date-format="yyyy-mm-dd"  placeholder="请输入场时间" title="入场时间" style="width:98%;"/>
									</td>
									<td name="ROOM_NAME" id="ROOM_NAME">
								    	<select class="chosen-select form-control" name="tag" id="tag" data-placeholder="请选择房间" style="vertical-align:top;width: 160px;"></select>
								    </td>	
									<td>
										<a href="javascript:;" class="btn btn-mini btn-danger" onclick='{if(confirm("确定要删除这条信息吗?")) {deleteCurrentRow(this); }else {}}'>删除</a>
									</td>
								</tr>
							</tbody>
                         <tbody id="table1">
                                     </tbody>
																									
						
						</table>
						
						<table id="table_report" class="table table-striped table-bordered table-hover">
						     <tr>
								<td style="text-align: center;" colspan="10">
						<img src="<%=basePath%>static/weixin/add.png" id="img" width="35" height="35" alt=""/>
							</td>
							</tr>
						</table>
						<table id="table_report" class="table table-striped table-bordered table-hover">
						<thead>
								<tr>
									<th class="center">配件</th>
									<th class="center">数量</th>
									<th class="center">房间</th>
									<th class="center">操作</th>
								</tr>
							</thead>
							<tbody>
							<td>
							 <select name="ACCESSORIES" id="ACCESSORIES" style="width:98%;">
							 </select>
								</td>
								<td><input type="number" name="FPCNUMBER" id="FPCNUMBER"  class="spinnerExample" step="1" min="1"></td>
							     <td name="FROOM_NAME" id="FROOM_NAME">
								    	<select class="chosen-select form-control" name="Ftag" id="Ftag" data-placeholder="请选择房间" style="vertical-align:top;width: 160px;"></select>
								 </td>
							     <td>
								<a href="javascript:;" class="btn btn-mini btn-danger" onclick='{if(confirm("确定要删除这条信息吗?")) {deleteCurrentRow(this); }else {}}'>删除</a>
							  </td>
							</tbody>
							    <tbody id="table2">
                                </tbody>
                         </table>
                         <table id="table_report" class="table table-striped table-bordered table-hover">
						     <tr>
								<td style="text-align: center;" colspan="10">
						        <img src="<%=basePath%>static/weixin/add.png" id="Typeimg" width="35" height="35" alt=""/>
							</td>
							</tr>
						</table>
						<table id="table_report" class="table table-striped table-bordered table-hover">
						<tr>
							<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
							<td><input type="textarea"  name="REMARK" id="REMARK" value="${pd.REMARK}" maxlength="255"  title="备注" style="width:98%;cols:'3'" /></td>	
							</tr>
						</table>
						
						</div>
						
						<input type = hidden id = proj value ="${pd.pro}"/>
						<div class="page-header position-relative">
						<table id="table_report" class="table table-striped table-bordered table-hover">
						     <tr>
								<td style="text-align: center;" colspan="10">
								<a class="btn btn-mini btn-primary" onclick="save();">提交</a>
								<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						<input type = hidden  id = staname value = ${pd.name}>
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
		$(top.hangge());//关闭加载状态
		$("#img").click(function(){
			   var $trTemp = $("<tr></tr>");
			   var j=$("#j").val();
               //往行里面追加 td单元格
               $trTemp.append('<td><select name="RAM" id="RAM'+j+'" style="width:98%;"></select></td>');
               $trTemp.append('<td><select name="HDISK" id="HDISK'+j+'" style="width:98%;"></select></td>');
               $trTemp.append('<td><select name="TYPE" id="TYPE'+j+'" style="width:98%;"></select></td>');
               $trTemp.append('<td><input type="number" name="PCNUMBER" id="PCNUMBER'+j+'"  class="spinnerExample" step="1" min="1"></td>');
               $trTemp.append('<td><select name="PURPOSE" id="PURPOSE'+j+'" style="width:98%;"></select></td>');
               $trTemp.append('<td><input class="span10 date-picker" name="EINLASS" id="EINLASS'+j+'" value="${pd.EINLASS}" type="text" data-date-format="yyyy-mm-dd"  placeholder="请输入场时间" title="入场时间" style="width:98%;"/></td>');
               $trTemp.append('<td name="ROOM_NAME'+j+'" id="ROOM_NAME'+j+'"><select class="chosen-select form-control" name="tag'+j+'" id="tag'+j+'" data-placeholder="请选择房间" style="vertical-align:top;width: 160px;"></select></td>');
               $trTemp.append('<td><a href="javascript:;" class="btn btn-mini btn-danger" onclick="{if(confirm(&quot;确定要删除这条信息吗?&quot;)) {deleteCurrentRow(this); }else {}}">删除</a></td>');
               $trTemp.appendTo("#table1");
               $('.date-picker').datepicker({autoclose: true,todayHighlight: true});
               if($("#PRO").attr("checked")){
            	   $("#ROOM_NAME"+j+"").html('<td><select name="BUILDING'+j+'" id="BUILDING'+j+'" data-placeholder="请选择状态"  style="vertical-align:top;float:left; width: 33%;height:31px"></select><input type="number" name="ROOM" id="ROOM" maxlength="50" placeholder="这里输入房间号(例:211)" title="PC编号" style="width:66%;float:right"/></td>'); 
               }else{
            	   $("#ROOM_NAME"+j+"").html('<select class="chosen-select form-control" name="tag'+j+'" id="tag'+j+'" data-placeholder="请选择房间" style="vertical-align:top;width: 160px;"  ></select>');
            	   /* var str = $("select[id^='tag']").map(function(){return $(this).val();}).get().join(", ") */
            	   var str =$("#str").val();
            	   var arr=new Array();  
            	   arr=str.split(',');
            	   for(var i=0;i<arr.length;i++){
            		   if(arr[i]!=""){
            			   $("#tag"+j+"").append("<option value="+arr[i]+">"+arr[i]+"</option>");
            		   }
            	   }  
               }
               $.ajax({
   				type: "POST",
   				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
   				dataType:'json',
   				cache: false,
   				success: function(data){
   					/*  $("#NAME").html('<option></option>');
   					 $.each(data.programList, function(i, dvar){
   							$("#NAME").append("<option value="+dvar.PROJECT_ID+">"+dvar.PROJECT_NAME+"</option>");
   					 }); */
   					 $("#RAM"+j+"").html('<option></option>');
   					 $.each(data.ramList, function(i, dvar){
   							$("#RAM"+j+"").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
   					 });
   					 $("#HDISK"+j+"").html('<option></option>');
   					 $.each(data.hdiskList, function(i, dvar){
   							$("#HDISK"+j+"").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
   					 });
   					 $("#TYPE"+j+"").html('<option></option>');
   					 $.each(data.typeList, function(i, dvar){
   							$("#TYPE"+j+"").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
   					 });
   					 $("#PURPOSE"+j+"").html('<option></option>');
   					 $.each(data.purposeList, function(i, dvar){
   							$("#PURPOSE"+j+"").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
   					 });
   					
   					 $.each(data.buildingList, function(i, dvar){
						    $("#BUILDING"+j+"").append("<option value="+dvar.NAMEUse+">"+dvar.NAME+"</option>");
					 });
   				}
               });
               $("#j").val(parseInt(j)+1);
			});
		
		
		$("#Typeimg").click(function(){
			 var $trTemp = $("<tr></tr>");
			 var j=$("#j").val();
			 $trTemp.append('<td><select name="ACCESSORIES" id="ACCESSORIES'+j+'" style="width:98%;"></select></td>');
			 $trTemp.append('<td><input type="number" name="FPCNUMBER" id="FPCNUMBER'+j+'"  class="spinnerExample" step="1" min="1"></td>');
             $trTemp.append('<td name="FROOM_NAME'+j+'" id="FROOM_NAME'+j+'"><select class="chosen-select form-control" name="Ftag'+j+'" id="Ftag'+j+'" data-placeholder="请选择房间" style="vertical-align:top;width: 160px;"></select></td>');
             $trTemp.append('<td><a href="javascript:;" class="btn btn-mini btn-danger" onclick="{if(confirm(&quot;确定要删除这条信息吗?&quot;)) {deleteCurrentRow(this); }else {}}">删除</a></td>');
             $trTemp.appendTo("#table2");
             if($("#PRO").attr("checked")){
          	   $("#FROOM_NAME"+j+"").html('<td><select name="FBUILDING'+j+'" id="FBUILDING'+j+'" data-placeholder="请选择状态"  style="vertical-align:top;float:left; width: 33%;height:31px"></select><input type="number" name="FROOM" id="FROOM" maxlength="50" placeholder="这里输入房间号(例:211)" title="PC编号" style="width:66%;float:right"/></td>'); 
             }else{
          	   $("#FROOM_NAME"+j+"").html('<select class="chosen-select form-control" name="Ftag'+j+'" id="Ftag'+j+'" data-placeholder="请选择房间" style="vertical-align:top;width: 160px;"  ></select>');
          	   /* var str = $("select[id^='tag']").map(function(){return $(this).val();}).get().join(", ") */
          	   var str =$("#str").val();
          	   var arr=new Array();  
          	   arr=str.split(',');
          	   for(var i=0;i<arr.length;i++){
          		   if(arr[i]!=""){
          			   $("#Ftag"+j+"").append("<option value="+arr[i]+">"+arr[i]+"</option>");
          		   }
          	   }  
             }
             $.ajax({
    				type: "POST",
    				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
    				dataType:'json',
    				cache: false,
    				success: function(data){
    					 $("#ACCESSORIES"+j+"").html('<option></option>');
       					 $.each(data.pdaccessoriesList, function(i, dvar){
       							$("#ACCESSORIES"+j+"").append("<option value="+dvar.FITTINGS_ID+">"+dvar.FITTINGS_NAME+"</option>");
       					 });
       					 $.each(data.buildingList, function(i, dvar){
 						    $("#FBUILDING"+j+"").append("<option value="+dvar.NAMEUse+">"+dvar.NAME+"</option>");
 					 	});
    				}
                });
             $("#j").val(parseInt(j)+1);
		});
		
		  function deleteCurrentRow(obj){
	            var tr=obj.parentNode.parentNode;
	            var tbody=tr.parentNode;
	            tbody.removeChild(tr);
	            //只剩行首时删除表格
	          /*   if(tbody.rows.length==1) {
	                tbody.parentNode.removeChild(tbody);
	            } */
	        }
		$(function(){
			$("#NAME").change(function(){
				 var NAME=$("#NAME").val();
				   $.ajax({				
						type: "POST",	
						url: '<%=basePath%>pca/hasU.do',		
						data: {NAME:NAME,tm:new Date().getTime()},
						dataType:'json',
						cache: false,
						success: function(data){
							 if("error" == data.result){
								 $("#NAME").tips({
										side:3,
							            msg:'您不在此项目',
							            bg:'#AE81FF',
							            time:2
							       });
									document.getElementById("NAME").value="";	
									document.getElementById("tag").value="";
							 }else{
								 $("#NAME").css("background-color","white");
								 console.log($("#NAME").val());
								 message($("#NAME").val());
							 } 
							 
						 }
					  });
				
			})
			/* $("#ROOM_NAME").change(function(){
				console.log($("#ROOM_NAME").val());
			})
			 for(var i=1;i<=parseInt($("#j").val());i++){
				 console.log($("#ROOM_NAME"+i+"").val());
				} */
		})
				
/*  		 var qt = document.getElementById('PRO');
		    var pp = document.getElementById('NAME');
		    qt.onclick = function(){
		    	pp.disabled = this.checked;	
		    	pp.value="";
		    	$("#level1").removeAttr("disabled"); 
				$("#level2").removeAttr("disabled");
				$("#level3").removeAttr("disabled"); 
		    }  */
		    
		  function change11(value){
			   if(document.getElementById("NAME").value!=""){
				   var NAME=$("#NAME").val();
				   $.ajax({				
						type: "POST",	
						url: '<%=basePath%>pca/hasU.do',		
						data: {NAME:NAME,tm:new Date().getTime()},
						dataType:'json',
						cache: false,
						success: function(data){
							 if("error" == data.result){
								 $("#NAME").tips({
										side:3,
							            msg:'您不在此项目',
							            bg:'#AE81FF',
							            time:2
							       });
									document.getElementById("NAME").value="";						
							 }else{
								 $("#NAME").css("background-color","white");
							 } 
							 
						 }
					  });
			   }else{
				  
			   }
			   
		   } 
/* 		  $(function(){
			  var $PRO = $("#PRO");
			  $PRO.click(function(){
				  if($PRO.is(":checked")){
					  alert("here");
					  $("#tag").html('<input type="text" id="ROOM_NAME1" name="ROOM_NAME1"/>');
				  }
			  })
		  }) */
			function message(id){
				$("#tag").empty();
				$("#Ftag").empty();
				 for(var i=1;i<=parseInt($("#j").val());i++){
				  $("#tag"+i+"").empty();
				  $("#Ftag"+i+"").empty();
				 }
				$.ajax({
					type: "POST",
					url: '<%=basePath%>pc/level.do?PROJECT_ID='+id,
					dataType:'json',
					cache: false,
					success: function(data){
						var i = 0;
						/* $("#tag").html("<option value=""></option>"); */
						if(data.pdData.length!=1){
							 $("#str").val("");
							for(;i<data.pdData.ROOM_NAMEWWW.length;i++){
								/* $("#tag").append('<tr><td><input type="text" id="i'+i+'" name="i'+i+'" style="width:100%;" value="'+data.pdData.ROOM_NAMEWWW[i]+'"></td><td style="text-align: left;padding-top: 6px;padding-left:15px;"><input type="radio" id="r'+i+'" name="r'+i+' value='+i+'"></td></tr>'); */
								$("#tag").append("<option value="+data.pdData.ROOM_NAMEWWW[i]+">"+data.pdData.ROOM_NAMEWWW[i]+"</option>");
								$("#Ftag").append("<option value="+data.pdData.ROOM_NAMEWWW[i]+">"+data.pdData.ROOM_NAMEWWW[i]+"</option>");
								 for(var j=1;j<=parseInt($("#j").val());j++){
								     $("#tag"+j+"").append("<option value="+data.pdData.ROOM_NAMEWWW[i]+">"+data.pdData.ROOM_NAMEWWW[i]+"</option>");
								     $("#Ftag"+j+"").append("<option value="+data.pdData.ROOM_NAMEWWW[i]+">"+data.pdData.ROOM_NAMEWWW[i]+"</option>");
								 }
								 $("#str").val($("#str").val()+','+data.pdData.ROOM_NAMEWWW[i]);
							}
						}else{
							$("#tag").append("<option value="+data.pdData.ROOM_NAMEWWW+">"+data.pdData.ROOM_NAMEWWW+"</option>");
							$("#Ftag").append("<option value="+data.pdData.ROOM_NAMEWWW+">"+data.pdData.ROOM_NAMEWWW+"</option>"); 
							for(var j=1;j<=parseInt($("#j").val());j++){
							     $("#tag"+j+"").append("<option value="+data.pdData.ROOM_NAMEWWW+">"+data.pdData.ROOM_NAMEWWW+"</option>");
							     $("#Ftag"+j+"").append("<option value="+data.pdData.ROOM_NAMEWWW+">"+data.pdData.ROOM_NAMEWWW+"</option>");
							 }
							 $("#str").val("");
							 $("#str").val(data.pdData.ROOM_NAMEWWW);
						}

					}
				});
			}
			
			

			$(function() {		
				$.ajax({
					type: "POST",
					url: '<%=basePath%>pca/hasP.do?tm='+new Date().getTime(),
					dataType:'json',
					cache: false,
					success: function(data){
						 $("#NAME").html('<option></option>');
						 $.each(data.pdList, function(i, dvar){
								$("#NAME").append("<option value="+dvar.PROJECT_ID+">"+dvar.PROJECT_PID+"&nbsp&nbsp&nbsp&nbsp&nbsp"+dvar.PROJECT_NAME+"</option>");
						 });
					}
				});
			});
		$(function() {		
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevelsByName.do?tm='+new Date().getTime(),
				dataType:'json',
				cache: false,
				success: function(data){
					/*  $("#NAME").html('<option></option>');
					 $.each(data.programList, function(i, dvar){
							$("#NAME").append("<option value="+dvar.PROJECT_ID+">"+dvar.PROJECT_NAME+"</option>");
					 }); */
					 $("#RAM").html('<option></option>');
					 $.each(data.ramList, function(i, dvar){
							$("#RAM").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
					 $("#HDISK").html('<option></option>');
					 $.each(data.hdiskList, function(i, dvar){
							$("#HDISK").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
					 $("#TYPE").html('<option></option>');
					 $.each(data.typeList, function(i, dvar){
							$("#TYPE").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
					 $("#PURPOSE").html('<option></option>');
					 $.each(data.purposeList, function(i, dvar){
							$("#PURPOSE").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
					 $("#ACCESSORIES").html('<option></option>');
					 $.each(data.pdaccessoriesList, function(i, dvar){
							$("#ACCESSORIES").append("<option value="+dvar.FITTINGS_ID+">"+dvar.FITTINGS_NAME+"</option>");
					 });
					 $("#PRO").click(function(){
						 if($("#PRO").attr("checked")){
							 	/* $("#NAME").html(""); */
							 	var a = document.getElementById("NAME");//mySelect是select 的Id
                                a.options[0].selected = true;
								$("#NAME").attr("disabled","disabled");
								$("#NAME").css("background","#FFFAFA");
								/* $("#ROOM_NAME").html('<input type="text" name="tag" id="tag" />'); */
								 $("#ROOM_NAME").html('<td><select name="BUILDING" id="BUILDING" data-placeholder="请选择状态"  style="vertical-align:top;float:left; width: 33%;height:31px"></select><input type="number" name="ROOM" id="ROOM" maxlength="50" placeholder="这里输入房间号(例:211)" title="PC编号" style="width:66%;float:right"/></td>'); 
								 $("#FROOM_NAME").html('<td><select name="FBUILDING" id="FBUILDING" data-placeholder="请选择状态"  style="vertical-align:top;float:left; width: 33%;height:31px"></select><input type="number" name="FROOM" id="FROOM" maxlength="50" placeholder="这里输入房间号(例:211)" title="PC编号" style="width:66%;float:right"/></td>'); 
								 for(var i=1;i<=parseInt($("#j").val());i++){
									$("#ROOM_NAME"+i+"").html('<td><select name="BUILDING'+i+'" id="BUILDING'+i+'" data-placeholder="请选择状态"  style="vertical-align:top;float:left; width: 33%;height:31px"></select><input type="number" name="ROOM" id="ROOM" maxlength="50" placeholder="这里输入房间号(例:211)" title="PC编号" style="width:66%;float:right"/></td>');
									$("#FROOM_NAME"+i+"").html('<td><select name="FBUILDING'+i+'" id="FBUILDING'+i+'" data-placeholder="请选择状态"  style="vertical-align:top;float:left; width: 33%;height:31px"></select><input type="number" name="FROOM" id="FROOM" maxlength="50" placeholder="这里输入房间号(例:211)" title="PC编号" style="width:66%;float:right"/></td>'); 
								}
	 							
	 							/* $("#BUILDING").html('<option></option>'); */
	 							$.each(data.buildingList, function(i, dvar){
	 								$("#BUILDING").append("<option value="+dvar.NAMEUse+">"+dvar.NAME+"</option>");
	 								$("#FBUILDING").append("<option value="+dvar.NAMEUse+">"+dvar.NAME+"</option>");
	 								 for(var j=1;j<=parseInt($("#j").val());j++){
	 									$("#BUILDING"+j+"").append("<option value="+dvar.NAMEUse+">"+dvar.NAME+"</option>");
	 									$("#FBUILDING"+j+"").append("<option value="+dvar.NAMEUse+">"+dvar.NAME+"</option>");
	 								 }
	 							});
						 }else{
							 $("#NAME").css("background","");
							 $("#NAME").removeAttr("disabled"); 
							 $("#ROOM_NAME").html('<select class="chosen-select form-control" name="tag" id="tag" data-placeholder="请选择房间" style="vertical-align:top;width: 120px;"  ></select>');
							 $("#FROOM_NAME").html('<select class="chosen-select form-control" name="Ftag" id="Ftag" data-placeholder="请选择房间" style="vertical-align:top;width: 120px;"  ></select>');
							 for(var i=1;i<=parseInt($("#j").val());i++){
									$("#ROOM_NAME"+i+"").html('<select class="chosen-select form-control" name="tag'+i+'" id="tag'+i+'" data-placeholder="请选择房间" style="vertical-align:top;width: 120px;"></select>');
									$("#FROOM_NAME"+i+"").html('<select class="chosen-select form-control" name="Ftag'+i+'" id="Ftag'+i+'" data-placeholder="请选择房间" style="vertical-align:top;width: 120px;"></select>');
								}
						 }
					 });

					 $("#BUILDING2").html('<option></option>');
					 $.each(data.buildingList, function(i, dvar){
							$("#BUILDING2").append("<option value="+dvar.NAMEUse+">"+dvar.NAME+"</option>");
					 });
				}
			});
		});
		
		
		//保存		
		function save(){
			var j=$("#j").val();
			if(!$("#PRO").attr("checked")){
				if($("#NAME").val()==""){
					$("#NAME").tips({
						side:3,
			            msg:'请选择项目',
			            bg:'#AE81FF',
			            time:2
			       });
					$("#NAME").focus();
					return false;
				}
			}
			
			for(var i=0;i<$("select[id^='RAM']").length;i++){
				if($("select[id^='RAM']").eq(i).val()==""){
					$("select[id^='RAM']").eq(i).tips({
						side:3,
			            msg:'请输入内存',
			            bg:'#AE81FF',
			            time:2
			       });
					$("select[id^='RAM']").eq(i).focus();
				return false;
				}
				if($("select[id^='HDISK']").eq(i).val()==""){
					$("select[id^='HDISK']").eq(i).tips({
						side:3,
			            msg:'请输入硬盘',
			            bg:'#AE81FF',
			            time:2
			       });
				$("select[id^='HDISK']").eq(i).focus();
				return false;
				}
				if($("select[id^='TYPE']").eq(i).val()==""){
					$("select[id^='TYPE']").eq(i).tips({
						side:3,
			            msg:'请输入类型',
			            bg:'#AE81FF',
			            time:2
			       });
				$("select[id^='TYPE']").eq(i).focus();
				return false;
				}
				if($("input[id^='PCNUMBER']").eq(i).val()==""){
					$("input[id^='PCNUMBER']").eq(i).tips({
						side:3,
			            msg:'请输入台数',
			            bg:'#AE81FF',
			            time:2
			       });
				$("input[id^='PCNUMBER']").eq(i).focus();
				return false;
				}
				if($("select[id^='PURPOSE']").eq(i).val()==""){
					$("select[id^='PURPOSE']").eq(i).tips({
						side:3,
			            msg:'请输入用途',
			            bg:'#AE81FF',
			            time:2
			       });
				$("select[id^='PURPOSE']").eq(i).focus();
				return false;
				}
				if($("input[id^='EINLASS']").eq(i).val()==""){
					$("input[id^='EINLASS']").eq(i).tips({
						side:3,
			            msg:'请输入入场时间',
			            bg:'#AE81FF',
			            time:2
			       });
				$("input[id^='EINLASS']").eq(i).focus();
				return false;
				}
				if($("#PRO").attr("checked")){
					if($("select[id^='BUILDING']").eq(i).val()==""){
						$("select[id^='BUILDING']").eq(i).tips({
							side:3,
				            msg:'请输入楼栋',
				            bg:'#AE81FF',
				            time:2
				       });
					$("select[id^='BUILDING']").eq(i).focus();
					return false;
					}
					if($("input[id^='ROOM']").eq(i).val()==""){
						$("input[id^='ROOM']").eq(i).tips({
							side:3,
				            msg:'请输入房间',
				            bg:'#AE81FF',
				            time:2
				       });
					$("input[id^='ROOM']").eq(i).focus();
					return false;
					}
				}else{
					if($("select[id^='tag']").eq(i).val()==""){
						$("select[id^='tag']").eq(i).tips({
							side:3,
				            msg:'请选择房间',
				            bg:'#AE81FF',
				            time:2
				       });
					$("select[id^='tag']").eq(i).focus();
					return false;
					}
				}
				
			}
			
			for(var i=0;i<$("select[id^='ACCESSORIES']").length;i++){
				if($("select[id^='ACCESSORIES']").eq(i).val()==""){
					$("select[id^='ACCESSORIES']").eq(i).tips({
						side:3,
			            msg:'请选择配件',
			            bg:'#AE81FF',
			            time:2
			       });
				$("select[id^='ACCESSORIES']").eq(i).focus();
				return false;
				}
				if($("input[id^='FPCNUMBER']").eq(i).val()==""){
					$("input[id^='FPCNUMBER']").eq(i).tips({
						side:3,
			            msg:'请输入数量',
			            bg:'#AE81FF',
			            time:2
			       });
					$("input[id^='FPCNUMBER']").eq(i).focus();
				return false;
				}
				
				if($("#PRO").attr("checked")){
					if($("select[id^='FBUILDING']").eq(i).val()==""){
						$("select[id^='FBUILDING']").eq(i).tips({
							side:3,
				            msg:'请输入楼栋',
				            bg:'#AE81FF',
				            time:2
				       });
					$("select[id^='FBUILDING']").eq(i).focus();
					return false;
					}
					if($("input[id^='FROOM']").eq(i).val()==""){
						$("input[id^='FROOM']").eq(i).tips({
							side:3,
				            msg:'请输入房间',
				            bg:'#AE81FF',
				            time:2
				       });
					$("input[id^='FROOM']").eq(i).focus();
					return false;
					}
				}else{
					if($("select[id^='Ftag']").eq(i).val()==""){
						$("select[id^='Ftag']").eq(i).tips({
							side:3,
				            msg:'请选择房间',
				            bg:'#AE81FF',
				            time:2
				       });
					$("select[id^='Ftag']").eq(i).focus();
					return false;
					}
				}
			}
			
			
			//收集电脑配置信息，保存到隐藏域
			var ramArr = new Array();
			var hdiskArr = new Array();
			var typeArr = new Array();
			var pcnumberArr = new Array();
			var purposeArr = new Array();
			var einlassArr = new Array();
			var buildingArr = new Array();
			var roomArr = new Array();
			var roomNameArr = new Array();
			var accessoriesArr = new Array();
			var fnumberArr = new Array();
			var fbuildingArr = new Array();
			var froomArr = new Array();
			var froomNameArr = new Array();
			$("select[id^='RAM']").each(function(index,element){
				ramArr.push(element.value);
			});
			$("select[id^='HDISK']").each(function(index,element){
				hdiskArr.push(element.value);
			});
			$("select[id^='TYPE']").each(function(index,element){
				typeArr.push(element.value);
			});
			$("input[id^='PCNUMBER']").each(function(index,element){
				pcnumberArr.push(element.value);
			});
			$("select[id^='PURPOSE']").each(function(index,element){
				purposeArr.push(element.value);
			});
			$("input[id^='EINLASS']").each(function(index,element){
				einlassArr.push(element.value);
			});
			$("select[id^='BUILDING']").each(function(index,element){
				buildingArr.push(element.value);
			});
			$("input[id^='ROOM']").each(function(index,element){
				roomArr.push(element.value);
			});
			$("select[id^='tag']").each(function(index,element){
				roomNameArr.push(element.value);
			});
			$("select[id^='ACCESSORIES']").each(function(index,element){
				accessoriesArr.push(element.value);
			});
			$("input[id^='FPCNUMBER']").each(function(index,element){
				fnumberArr.push(element.value);
			});
			$("select[id^='FBUILDING']").each(function(index,element){
				fbuildingArr.push(element.value);
			});
			$("input[id^='FROOM']").each(function(index,element){
				froomArr.push(element.value);
			});
			$("select[id^='Ftag']").each(function(index,element){
				froomNameArr.push(element.value);
			});
			$('#P_RAMS').val(ramArr.join(","));
			$('#P_HDISKS').val(hdiskArr.join(","));
			$('#P_TYPES').val(typeArr.join(","));
			$('#P_PCNUMBERS').val(pcnumberArr.join(","));
			$('#P_PURPOSES').val(purposeArr.join(","));
			$('#P_EINLASSS').val(einlassArr.join(","));
			$('#P_BUILDINGS').val(buildingArr.join(","));
			$('#P_ROOMS').val(roomArr.join(","));
			$('#P_ROOM_NAMES').val(roomNameArr.join(","));
			$('#P_ACCESSORIESS').val(accessoriesArr.join(","));
			$('#P_FPCNUMBER').val(fnumberArr.join(","));
			$('#P_FBUILDINGS').val(fbuildingArr.join(","));
			$('#P_FROOMS').val(froomArr.join(","));
			$('#P_FROOM_NAMES').val(froomNameArr.join(","));
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		//初始第一级
		$(function() {
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
		    	data: {},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#level1").html('<option></option>');
					 $.each(data.list, function(i, dvar){
							$("#level1").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
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
					$("#level2").html('<option></option>');
					 $.each(data.list, function(i, dvar){
							$("#level2").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
				}
			});
		}
		//第二级值改变事件(初始第三级)
		function change2(value){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
		    	data: {DICTIONARIES_ID:value},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#level3").html('<option></option>');
					 $.each(data.list, function(i, dvar){
							$("#level3").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 });
				}
			});
		}
			
		//第三级值改变事件(初始第四级)
		function change3(value){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>linkage/getLevels.do?tm='+new Date().getTime(),
		    	data: {DICTIONARIES_ID:value},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#level4").html('<option></option>');
					 $.each(data.list, function(i, dvar){
							$("#level4").append("<option value="+dvar.DICTIONARIES_ID+">"+dvar.NAME+"</option>");
					 });
				}
			});
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
				
</body>
</html>