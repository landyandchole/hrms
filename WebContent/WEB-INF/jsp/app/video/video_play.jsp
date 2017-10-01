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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>">

<%@ include file="../../system/index/top.jsp"%>
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="plugins/uploadify/swfobject.js"></script>
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
			<div align="center">
                 <object id="MediaPlayer"
					classid="clsid:22D6F312-B0F6-11D0-94AB-0080C74C7E95" width="1000" align="middle"
					height="700" standby="Loading Windows Media Player components…"  type="application/x-oleobject" 	
					codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,4,7,1112">
					<s:if test="#request.fileName!=null">
						<param name="FileName" value="<%=basePath%>uploadFiles/uploadFile/${pd.path}">
					</s:if>
					<s:else>
						<param name="FileName" >
					</s:else>
					<param name="AutoStart" value="true">
					<param name="ShowControls" value="true">
					<param name="BufferingTime" value="2">
					<param name="ShowStatusBar" value="true">
					<param name="AutoSize" value="true">
					<param name="InvokeURLs" value="false">
					<param name="AnimationatStart" value="0">
					<param name="TransparentatStart" value="0">
					<param name="enableContextMenu" value="false">
					<param name="fullScreen" value="true">
					<param name="Loop" value="1">
		 			<embed type="application/x-mplayer2"   name="MediaPlayer" autostart="1" showstatusbar="1" showdisplay="1"
						showcontrols="1" loop="0" videoborder3d="0"  pluginspage="http://www.microsoft.com/Windows/MediaPlayer/"
						align="middle"  allowScriptAccess="sameDomain" width="1000" height="700">
					</embed>			
		 		</object> 			 			
		</div>


				<!-- <div id="a1"></div> -->
			</div>
		</div>
	</div>
	<%@ include file="../../system/index/foot.jsp"%>
	<script type="text/javascript">
		$(top.hangge());
	</script>
		<!-- <script type="text/javascript" src="ckplayer/ckplayer.js"></script>
<script type="text/javascript">
	var flashvars={
		p:0,
		e:1,
		i:'http://www.ckplayer.com/static/images/cqdw.jpg'
		};
	var video=['<%=basePath%>uploadFiles/uploadFile/${pd.path}->video/${pd.ext}'];
	alert(video);
	var support=['all'];
	CKobject.embedHTML5('a1','ckplayer_a1',800,600,video,flashvars,support);
</script>-->


</body>
</html>