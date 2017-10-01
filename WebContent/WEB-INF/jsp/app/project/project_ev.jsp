<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<%int a=0; %>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="projectmember/saveev.do" name="Form" id="Form" method="post" >
						<input type="hidden" name="MEMBER_ID" id="MEMBER_ID" value="${pd.MEMBER_ID}"/>
						<input type="hidden" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}"/>
						<input type="hidden" name="PRO_ANSWER_NAMES" id="PRO_ANSWER_NAMES"/>
						<input type="hidden" name="PRO_QUESTION_TYPES" id="PRO_QUESTION_TYPES"/>
						<input type="hidden" name="PRO_QUESTION_NAMES" id="PRO_QUESTION_NAMES"/>
						
						  <c:forEach var="answerID" items="${pd.ANSWERID}">   
						 <input type="hidden" name="ANSWERID" id="ANSWERID" value="${answerID.ANSWERID}"/> 
						  </c:forEach> 
						  
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
								<c:forEach var="entry" items="${typehash}" varStatus="status1">
                                <tr><td style="font-size:20px;font-weight:bold">  
                                            <c:if test="${entry.key == '0'}">设计能力</c:if>
											<c:if test="${entry.key == '1'}">开发能力</c:if>
											<c:if test="${entry.key == '2'}">沟通能力</c:if>
											<c:if test="${entry.key == '3'}">工作效率</c:if>
											<c:if test="${entry.key == '4'}">工作品质</c:if>
											<c:if test="${entry.key == '5'}">责任心</c:if>
											<c:if test="${entry.key == '6'}">出勤率</c:if>
											<c:if test="${entry.key == '7'}">管理能力</c:if>	</td></tr>    
                                <c:forEach var="questionlist" items="${entry.value}" varStatus="status">
                                <input type="hidden" name="PRO_QUESTION_TYPE" id="PRO_QUESTION_TYPE" value="${entry.key}"/>
						         <input type="hidden" name="PRO_QUESTION_NAME" id="PRO_QUESTION_NAME" value="${questionlist.key}"/>
                                 <tr><td style="padding-left:50px;">${questionlist.key}</td>  </tr>
                                     <c:forEach var="answerlist" items="${questionlist.value}">   
                                     <tr><td style="padding-left:70px;">
                                     <label>
                                     <input name="${questionlist.key}" id=<%=a %> type="radio" value="${answerlist.ev_id}"
                                     <%--  <c:if test="${ANSWERID.answerid == ev_id}">checked="checked"</c:if> --%>
                                       >${answerlist.answer_name} </label>
                                     <%--  <input name="${questionlist.key}" id=<%=a %> type="radio" value="${answerlist.answer_mark}" />${answerlist.answer_name} </label> --%>
                                    
                                      </td></tr>
                                      </c:forEach>
                                      <%a++; %>
                                  </c:forEach>
                            </c:forEach>							
							
							
							
							
						</table>
						
						
						
						<table id="table_report" class="table table-striped table-bordered table-hover">
						
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

	
		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>


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
		
		obj = document.getElementsByName("ANSWERID");
		for(i=0;i<obj.length;i++){
			  $('input[type="radio"]').each(function () {								
				 if(this.value==obj[i].value){
					 $(this).attr('checked','true');
				 }
				});
		}   
		
	 function save() {
			var answers = [];
	 		var questionTypes = [];
	 		var questions = [];
	 		$("input[type=radio]:checked").each(function (index,element) {

	 			answers.push(element.value);
	 		});
	 		$("input[name=PRO_QUESTION_TYPE]").each(function (index,element) {
	 			questionTypes.push(element.value);
	 		});
	 		$("input[name=PRO_QUESTION_NAME]").each(function (index,element) {
	 			questions.push(element.value);
	 		});
			$("#PRO_ANSWER_NAMES").val(answers.join(','))
			$("#PRO_QUESTION_TYPES").val(questionTypes.join(','))
			$('#PRO_QUESTION_NAMES').val(questions.join(','));
			var b = 0;
			var a = false;
			 $("input[type=radio]").each(function() {
				if ($(this).attr("id") == b){
				if ($(this).is(":checked")) {
					a = true;
					b=b+1;
				} else {
					$(this).tips({
						side : 3,
						msg : '请完成评估',
						bg : '#AE81FF',
						time : 2});
						$(this).focus();
						a = false;
					}
				} 
			})
			 
			
		   if(a==false)
			{return a;}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	</script>


</body>
</html>