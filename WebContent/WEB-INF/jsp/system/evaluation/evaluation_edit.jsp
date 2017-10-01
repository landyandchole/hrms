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

<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<!-- 树形下拉框start -->
<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
<link rel="stylesheet" type="text/css"
	href="plugins/selectZtree/import_fh.css" />
<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/2.6/zTreeStyle.css" />
<script type="text/javascript"
	src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
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

							<form action="evaluation/${msg}.do" name="Form" id="Form"
								method="post">
								<input type="hidden" name="EV_ANSWER_ID" id="EV_ANSWER_ID"
									value="${pd.EV_ANSWER_ID}" />
								<input type="hidden" name="msg" id="msg" value="${msg}">
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">

										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">类别:</td>

											<td><select class="EV_QUESTION_TYPE"
												name="EV_QUESTION_TYPE" id="EV_QUESTION_TYPE"
												style="width: 98%;">
													<option value="请选择">请选择</option>
													<option value="0" <c:if test="${pd.EV_QUESTION_TYPE == '0'}">selected</c:if>>工作年限</option>
										            <option value="1" <c:if test="${pd.EV_QUESTION_TYPE == '1'}">selected</c:if>>工作态度</option>
										            <option value="2" <c:if test="${pd.EV_QUESTION_TYPE == '2'}">selected</c:if>>日语水平</option>
										            <option value="3" <c:if test="${pd.EV_QUESTION_TYPE == '3'}">selected</c:if>>英语水平</option>
										            <option value="4" <c:if test="${pd.EV_QUESTION_TYPE == '4'}">selected</c:if>>ABAP水平</option>										
										            <option value="5" <c:if test="${pd.EV_QUESTION_TYPE == '5'}">selected</c:if>>JAVA水平</option>
											</select></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">题目:</td>
											<td colspan="10"><input type="text"
												name="EV_QUESTION_NAME" id="EV_QUESTION_NAME"
												value="${pd.EV_QUESTION_NAME}" maxlength="100"
												placeholder="这里输入题目" title="题目" style="width: 98%;" /></td>
										</tr>
										
										<c:if test="${msg=='save'}" >
										<tr class="mark_answer">
											<td style="width: 75px; text-align: right; padding-top: 13px;">答案:</td>
											<td><input type="text" id="1" name="EV_ANSWER_NAME[0]"
												maxlength="50" value="${pd.EV_ANSWER_NAME}"
												placeholder="这里输入答案" title="答案" style="width: 98%;" /></td>
											<td	style="width: 75px; text-align: right; padding-top: 13px;">分值:</td>
											<td><input type="text" id="2" name="EV_ANSWER_MARK[0]"
												value="${pd.EV_ANSWER_MARK}" maxlength="50"
												placeholder="这里输入分值" title="请输入数字" style="width: 70%;" onKeyUp="shuru(this);" />
												</td>
												
											<td id="buttontd">											
											<input type="button" value="增加" id="addTable" class="addTable"/>
                                            <input type="button" value="删除" id="deleteTable" class="deleteTable"/>
											<input class="mark_answer_a" type="hidden" id="mark_answer_a" name="mark_answer_a"> 
											<input class="mark_answer_q" type="hidden" id="mark_answer_q" name="mark_answer_q">
											</td>
										</tr>
										</c:if>
										
                                    <c:if test="${msg=='edit'}" >
                                    <tr class="mark_answer">
											<td style="width: 75px; text-align: right; padding-top: 13px;">答案:</td>
											<td><input type="text" id='1' name="EV_ANSWER_NAME"
												maxlength="50" value="${pd.EV_ANSWER_NAME}"
												placeholder="这里输入答案" title="答案" style="width: 98%;" /></td>
											<td	style="width: 75px; text-align: right; padding-top: 13px;">分值:</td>
											<td><input type="text" id="2" name="EV_ANSWER_MARK"
												value="${pd.EV_ANSWER_MARK}" maxlength="50"
												placeholder="这里输入分值" title="请输入数字" style="width: 70%;" onKeyUp="shuru(this);"  />
												</td>
                                    </c:if>
									</table>
									<table align="center">
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
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>

	<script type="text/javascript">
		 $(top.hangge());//关闭加载状态
		 
	  $(document).ready(function(){

			    $(".addTable").click(function(){
			    	addTable();
			    });
			    
			    $(".deleteTable").click(function(){
			    	removeTr($(this));
			    	
			    });
			    
	 	  var msg=document.getElementById("msg").value;
	 	   if(msg=='edit'){
			  $("#buttontd").hide() 
	 	   } 	 
			});  
		 
		 var trcount = $(".mark_answer").length;
		 function addTable() {
			 $("#table_report").append('<tr class="mark_answer" ><td style="width: 75px; text-align: right; padding-top: 13px;">答案:</td><td><input type="text" id="1" name="EV_ANSWER_NAME['+ trcount +']" maxlength="50" placeholder="这里输入答案" title="答案" style="width:98%;"/></td>	<td style="width:75px;text-align: right;padding-top: 13px;">分值:</td><td><input type="text" id="2" name="EV_ANSWER_MARK['+ trcount +']" maxlength="50"  placeholder="这里输入分值" title="请输入数字" style="width:70%;" onKeyUp="shuru(this);" /><td><input type="button" value="增加" class="addTable"/><input type="button" value="删除" class="deleteTable"/></td></tr>');
			 $(".addTable").last().on('click', function () {
				 addTable();
			 });
			 $(".deleteTable").last().on('click', function () {
				 removeTr($(this));
			 });
			 trcount++;
		 }
		 
		 function removeTr(_this) {
			var count =  $(".mark_answer").length;
	    	if (count > 1) {
	    		_this.parent().parent().remove();
	    	}
		 }
			
		
	 function save(){
				var namearr = [];
		 		var markarr = [];
		 		$(".mark_answer").each(function (index,element) {
		 			namearr.push($(element).find('[name=EV_ANSWER_NAME]').val());
		 			markarr.push($(element).find('[name=EV_ANSWER_MARK]').val());
		 		});
					$("#mark_answer_a").val(namearr.join('\n'))
					$("#mark_answer_q").val(markarr.join('\n'))
					
				if($("#EV_QUESTION_TYPE").val()=="请选择"){
					$("#EV_QUESTION_TYPE").tips({
						side:3,
			            msg:'请输入类别',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#EV_QUESTION_TYPE").focus();
				return false;
				}
					
				if($("#EV_QUESTION_NAME").val()==""){
					$("#EV_QUESTION_NAME").tips({
						side:3,
			            msg:'请输入题目',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#EV_QUESTION_NAME").focus();
				return false;
				}
				
				var a ;
				$("input[id='1']").each(function(){
				if($(this).val()==""){
					$(this).tips({
						side:3,
			            msg:'请输入答案',
			            bg:'#AE81FF',
			            time:2
			        });
					$(this).focus();
					a=false;
					}
				})
				 if(a==false){
					 return false;
					 }
				
				var b ;
				$("input[id='2']").each(function(){
				if($(this).val()==""){
					$(this).tips({
						side:3,
			            msg:'请输入分值',
			            bg:'#AE81FF',
			            time:2
			        });
					$(this).focus();
					b=false;
					}
				})
				 if(b==false){
					 return false;
					 }
				
				$("#Form").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
			} 
	    
	     function shuru(txt){
	    	  txt.value=txt.value.replace(/\D/g,"");
	    	  
			  } 
	    
       $(function() {
				//日期框
				$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			}); 
	</script>

</body>
</html>