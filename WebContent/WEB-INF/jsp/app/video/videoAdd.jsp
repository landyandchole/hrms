<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<!-- 树形下拉框start -->
	<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
	<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
	<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
	<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/selectZtree/ztree/ztree.css"></link>
	<!-- 树形下拉框end -->
	
<!-- 上传插件 -->
<link href="plugins/uploadify/uploadify.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="plugins/uploadify/swfobject.js"></script>
<script type="text/javascript"
	src="plugins/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<!-- 上传插件 -->
<script type="text/javascript">
	var jsessionid = "<%=session.getId()%>";  //勿删，uploadify兼容火狐用到
	</script>

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
							<div style="margin: 0 auto;text-align:center;display:none" id="flash" align="center">
							<h1 style="text-align:center">视频新增</h1>
							<div>
								<div id="swfContainer"  >
				                   	 本组件需要安装Flash Player后才可使用，<br/>
				                   	 请从<a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。
								</div>
							</div>
							<!--  <button type="button" id="upload" style="display:none;margin-top:8px;">swf外定义的上传按钮，点击可执行上传保存操作</button>-->
				        </div>
							<form action="video/videosave.do" name="VideoForm" id="VideoForm"
								method="post">
								 <input name="ZDEPARTMENT_ID" id="ZDEPARTMENT_ID" type="hidden" value="${pd.VIDEO_ID}" /> 
							     <input type="hidden" value="no" id="hasTp1" />
                                 <input name="VIDEOGROUP" id="VIDEOGROUP" type="hidden" value="${pd.VIDEO_ID}" /> 
								<div id="zhongxin" style="padding-top: 13px;" align="center">
									<table id="table_report"
										class="table table-striped table-bordered table-hover"
										style="width: 500px">
										<%-- <tr> 
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">视频id</td>
										<td><input type="text" name="ID" id="ID"
												value="${pd.ID}" maxlength="30" placeholder="输入视频id"
												title="视频id" style="width: 98%;" hidden="" /></td> 
										</tr> --%>
										
										<tr>
											<td  style="width: 75px; text-align: right; padding-top: 13px;">视频分组</td>
											<td  style="padding-left:10px" ><div class="selectTree"  id="selectTree"></div>
											  </td>
                                        </tr>
                                        

										<tr>
											<td style="width: 75px; text-align: right; padding-top: 13px;">视频名</td>
											<td><input type="text" name="VIDEONAME" id="VIDEONAME"
												value="${pd.VIDEONAME}" maxlength="30" placeholder="这里输入视频名"
												title="视频名" style="width: 98%;" /></td>
										</tr>

										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;"
												id="VIDEOPATHn">文件路径</td>
											<td><input type="file" name="File_name" id="uploadify1"
												keepDefaultStyle="true" /> <input type="hidden"
												name="VIDEOPATH" id="VIDEOPATH" value="${pd.VIDEOPATH}" /></td>
										</tr>

					
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">上传用户</td>

                                             <td><input type="text" name="UPLOADUSER" id="UPLOADUSER"
												value="${pd.UPLOADUSER}" maxlength="50" style="width: 98%;"
												readonly /></td>

										</tr>


										<tr>
											<td style="text-align: center;" colspan="10"><a
												class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
												class="btn btn-mini btn-danger"
												onclick="top.Dialog.close();">取消</a></td>
										</tr>

									</table>

								</div>

								<div id="zhongxin2" class="center" style="display: none">
									<br /> <br /> <br /> <br /> <br /> <img
										src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
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
		function CheckFlashPlayer(){
	        var version = swfobject.getFlashPlayerVersion();
	        if (document.getElementById && version["major"] > 0) {
	        	
	            if(version['major']<10) {
	                alert("你的flash播放器版本过低!请安装flash Player 10版本!");
	                return false;
	            }
	        }else{
	        	$("#flash").show();
	        	$("#zhongxin").hide();
	            alert("您还未安装flash Player,请安装 flash Player 10版本!");
	            return false;
	        }
	        return true;
	    }
	 
	     CheckFlashPlayer();
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
		//保存
		function save(){
			if($("#selectTree2_input").val()=="请选择"){
				$("#selectTree2_input").tips({
					side:3,
		            msg:'请选择视频分组',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#selectTree2_input").focus();
			return false;
			}
			if($("#VIDEONAME").val()==""){
				$("#VIDEONAME").tips({
					side:3,
		            msg:'请输入视频名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#VIDEONAME").focus();
			return false;
			}
			if($("#hasTp1").val()=="no"){
				$("#VIDEOPATHn").tips({
					side:3,
		            msg:'请选择视频',
		            bg:'#AE81FF',
		            time:2
		        });
			return false;
			}
			
			$('#uploadify1').uploadifyUpload();
		}
		
	
		
		//====================上传=================
		$(document).ready(function(){
			var str='';
			$("#uploadify1").uploadify({
				'buttonImg'	: 	"<%=basePath%>static/images/fileup.png",
				'uploader'	:	"<%=basePath%>plugins/uploadify/uploadify.swf",
				'script'    :	"<%=basePath%>plugins/uploadify/uploadFile.jsp;jsessionid="+jsessionid,
				'cancelImg' :	"<%=basePath%>plugins/uploadify/cancel.png",
				'folder'	:	"<%=basePath%>uploadFiles/uploadFile",//上传文件存放的路径,请保持与uploadFile.jsp中PATH的值相同
												'queueId' : "fileQueue",
												'queueSizeLimit' : 1,//限制上传文件的数量
												'fileExt'	:	"*.wmv;*.avi",
												//'fileDesc'	:	"RAR *.rar",//限制文件类型
												//'fileExt' : '*.*;*.*;*.*',
												'fileDesc' : '请选择指定格式文件( *.wmv,*.avi)',
												'auto' : false,
												'multi' : true,//是否允许多文件上传
												'simUploadLimit' : 2,//同时运行上传的进程数量
												'buttonText' : "files",
												'scriptData' : {
													'uploadPath' : '/uploadFiles/uploadFile/'
												},//这个参数用于传递用户自己的参数，此时'method' 必须设置为GET, 后台可以用request.getParameter('name')获取名字的值
												'method' : "GET",
												'onComplete' : function(event,
														queueId, fileObj,
														response, data) {
													str = response.trim();//单个上传完毕执行
												},
												'onAllComplete' : function(
														event, data) {
													/* alert(str); //全部上传完毕执行 */
													$("#VIDEOPATH").val(str);
													$("#VideoForm").submit();
													$("#zhongxin").hide();
													$("#zhongxin2").show();
													
												},
												'onSelect' : function(event,
														queueId, fileObj) {
													$("#hasTp1").val("ok");
												}
											});

						});
		//====================上传=================
		//清除空格
		String.prototype.trim = function() {
			return this.replace(/(^\s*)|(\s*$)/g, '');
		};
		
		
		
		//下拉树
		var defaultNodes = {"treeNodes":${zTreeNodes}};
		function initComplete(){
			//绑定change事件
			$("#selectTree").bind("change",function(){
				if(!$(this).attr("relValue")){
			      //  top.Dialog.alert("没有选择节点");
			    }else{
					//alert("选中节点文本："+$(this).attr("relText")+"<br/>选中节点值："+$(this).attr("relValue"));
					$("#VIDEOGROUP").val($(this).attr("relValue"));
			    }
			});
			//赋给data属性
			 $("#selectTree").data("data",defaultNodes);  
			$("#selectTree").render();
			$("#selectTree2_input").val("${null==depname?'请选择':depname}"); 
		}

	</script>
</body>
</html>