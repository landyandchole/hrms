<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<!-- 百度echarts -->
<script src="plugins/echarts/echarts.min.js"></script>
<script src="static/js/jquery-1.7.2.js"></script>
<script src="plugins/highcharts/highcharts.js"></script>
<script src="plugins/highcharts/highcharts-3d.js"></script>
<script type="text/javascript">
	setTimeout("top.hangge()", 500);
</script>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">

							<div class="alert alert-block alert-success">
								<button type="button" class="close" data-dismiss="alert">
									<i class="ace-icon fa fa-times"></i>
								</button>
								<i class="ace-icon fa fa-check green"></i> 欢迎使用
								汉得海外事业本部HRMS管理系统&nbsp;&nbsp;
							</div>


							<div id="main" style="width: 450px; height: 250px;float:right"></div>
							<script type="text/javascript">
					       // 基于准备好的dom，初始化echarts实例
                             $.get('count_title').done(function (resp) {
                            	var datas = [];
 							 	var legends = [];
 							 	var color = ['#CE0000','#4169E1','#00AEAE','#6F00D2','#D26900','#977C00','#CE0000','#4169E1','#00AEAE','#6F00D2','#D26900','#977C00'];
                                for(var i = 0; i < resp.length; i ++) {
                                   var countInfo = resp[i];
                                   datas.push({
                                	    y: countInfo.titleCount,
                                	    color: color[i]   // 根据值判断给定颜色
                                	  })
                                   legends.push(countInfo.titleName);
                                }
                                var chart = {
                                	      renderTo: 'main',
                                	      type: 'column',
                                	      options3d: {
                                	         enabled: true,
                                	         beta: 15,
                                	         depth: 50,
                                	         viewDistance: 25
                                	      }
                                	   };
                                	   var title = {
                                	      text: '员工职称统计' 
                                	   };
                                	   var xAxis = {
                                			   categories: legends
                                			};
                                	   var yAxis = {
                                			   title: {
                                			         text: ''
                                			      },
                                			   plotLines: [{
                                			      value: 0,
                                			      color: '#CE0000'
                                			   }]
                                			};
                                	   var series = [{
                                		   name :　'人数',
                                		   data : datas,
                                		   showInLegend: false
                                	   }];
                                	   var json = {};   
                                	   json.chart = chart; 
                                	   json.title = title; 
                                	   json.xAxis = xAxis;  
                                	   json.yAxis = yAxis;  
                                	   json.series = series;
                                	   var highchart = new Highcharts.Chart(json);
                             });
							</script>
							<div id="main1" style="width: 40%; height: 250px; float: left;"></div>
							<script type="text/javascript">
								// 基于准备好的dom，初始化echarts实例
								var japaneseChart = echarts.init(document
										.getElementById('main1'));
								// 加载数据
								$
										.get('count_japanese')
										.done(
												function(resp) {
													var datas = [];
													var legends = [];

													for (var i = 0; i < resp.length; i++) {
														var countInfo = resp[i];
														var data = {
															name : countInfo.japaneseName,
															value : countInfo.japaneseCount
														};
														datas.push(data);
														legends
																.push(countInfo.japaneseName);
													}
													// 填入数据
													japaneseChart
															.setOption({
																title : {
																	text : '日语水平统计',
																	x : 'center'
																},
																tooltip : {
																	trigger : 'item',
																	formatter : "{a} <br/>{b} : {c} ({d}%)"
																},
																legend : {
																	orient : 'vertical',
																	left : 'left',
																	data : legends
																},
																series : [ {
																	name : '日语水平统计',
																	type : 'pie',
																	radius : '55%',
																	center : [
																			'50%',
																			'60%' ],
																	data : datas,
																	itemStyle : {
																		emphasis : {
																			shadowBlur : 10,
																			shadowOffsetX : 0,
																			shadowColor : 'rgba(0, 0, 0, 0.5)'
																		}
																	}
																} ]
															});
												});
							</script>

							<div id="main2"
								style="width: 25%; height: 250px; position: absolute; left: 35%"></div>
							<script type="text/javascript">
								// 基于准备好的dom，初始化echarts实例
								var englishChart = echarts.init(document
										.getElementById('main2'));
								// 加载数据
								$
										.get('count_english')
										.done(
												function(resp) {
													var datas = [];
													var legends = [];
													for (var i = 0; i < resp.length; i++) {
														var countInfo = resp[i];
														var data = {
															name : countInfo.englishName,
															value : countInfo.englishCount
														};
														datas.push(data);
														legends
																.push(countInfo.englishName);
													}
													// 填入数据
													englishChart
															.setOption({
																title : {
																	text : '英语水平统计',
																	x : 'center'
																},
																tooltip : {
																	trigger : 'item',
																	formatter : "{a} <br/>{b} : {c} ({d}%)"
																},
																legend : {
																	orient : 'vertical',
																	left : 'left',
																	data : legends
																},
																series : [ {
																	name : '英语水平统计',
																	type : 'pie',
																	radius : '55%',
																	center : [
																			'50%',
																			'60%' ],
																	data : datas,
																	itemStyle : {
																		emphasis : {
																			shadowBlur : 10,
																			shadowOffsetX : 0,
																			shadowColor : 'rgba(0, 0, 0, 0.5)'
																		}
																	}
																} ]
															});
												});
							</script>
							<div id="main4" style="width: 40%; height: 250px;position:absolute;top:60%"></div>
							<script type="text/javascript">
								// 基于准备好的dom，初始化echarts实例
								var statusChart = echarts.init(document
										.getElementById('main4'));
								// 加载数据
								$
										.get('count_status')
										.done(
												function(resp) {
													var datas = [];
													var legends = [];
													for (var i = 0; i < resp.length; i++) {
														var countInfo = resp[i];
														var data = {
															name : countInfo.statusName,
															value : countInfo.statusCount
														};
														datas.push(data);
														legends
																.push(countInfo.statusName);
													}
													// 填入数据
													statusChart
															.setOption({
																title : {
																	text : '状态统计',
																	x : 'center'
																},
																tooltip : {
																	trigger : 'item',
																	formatter : "{a} <br/>{b} : {c} ({d}%)"
																},
																legend : {
																	orient : 'vertical',
																	left : 'left',
																	data : legends
																},
																series : [ {
																	name : '状态统计',
																	type : 'pie',
																	radius : '55%',
																	center : [
																			'50%',
																			'60%' ],
																	data : datas,
																	itemStyle : {
																		emphasis : {
																			shadowBlur : 10,
																			shadowOffsetX : 0,
																			shadowColor : 'rgba(0, 0, 0, 0.5)'
																		}
																	}
																} ]
															});
												});
							</script>
<div id="main5"
								style="width: 25%; height: 250px; position: absolute; left: 35%;top:60%"></div>
							<script type="text/javascript">
								// 基于准备好的dom，初始化echarts实例
								var sexChart = echarts.init(document
										.getElementById('main5'));
								// 加载数据
								$
										.get('count_sex')
										.done(
												function(resp) {
													var datas = [];
													var legends = [];
													for (var i = 0; i < resp.length; i++) {
														var countInfo = resp[i];
														var sex = "男";
														if (countInfo.sexName == 0) {
															sex = "女";
														}
														var data = {
															name : sex,
															value : countInfo.sexCount
														};
														datas.push(data);
														legends.push(sex);
													}
													// 填入数据
													sexChart
															.setOption({
																title : {
																	text : '性别统计',
																	x : 'center'
																},
																tooltip : {
																	trigger : 'item',
																	formatter : "{a} <br/>{b} : {c} ({d}%)"
																},
																legend : {
																	orient : 'vertical',
																	left : 'left',
																	data : legends
																},
																series : [ {
																	name : '性别统计',
																	type : 'pie',
																	radius : '55%',
																	center : [
																			'50%',
																			'60%' ],
																	data : datas,
																	itemStyle : {
																		emphasis : {
																			shadowBlur : 10,
																			shadowOffsetX : 0,
																			shadowColor : 'rgba(0, 0, 0, 0.5)'
																		}
																	}
																} ]
															});
												});
							</script>
							<div id="main3" style="width: 450px; height: 250px;float:right; margin-top: 3.5%"></div>
							<script type="text/javascript">
								// 基于准备好的dom，初始化echarts实例

								$
										.get('count_role')
										.done(
												function(resp) {
													var datas = [];
					 							 	var legends = [];
					 							 	var color = ['#CE0000','#4169E1','#00AEAE','#6F00D2','#D26900','#977C00'];
					                                for(var i = 0; i < resp.length; i ++) {
					                                   var countInfo = resp[i];
					                                   datas.push({
					                                	    y: countInfo.roleCount,
					                                	    color: color[i]   // 根据值判断给定颜色
					                                	  })
					                                   legends.push(countInfo.roleName);
					                                }
					                                var chart = {
					                                	      renderTo: 'main3',
					                                	      type: 'column',
					                                	      options3d: {
					                                	         enabled: true,
					                                	         beta: 15,
					                                	         depth: 50,
					                                	         viewDistance: 25
					                                	      }
					                                	   };
					                                	   var title = {
					                                	      text: '用户角色统计' 
					                                	   };
					                                	   var xAxis = {
					                                			   categories: legends
					                                			};
					                                	   var yAxis = {
					                                			   title: {
					                                			         text: ''
					                                			      },
					                                			   plotLines: [{
					                                			      value: 0,
					                                			      color: '#CE0000'
					                                			   }]
					                                			};
					                                	   var series = [{
					                                		   name :　'人数',
					                                		   data : datas,
					                                		   showInLegend: false
					                                	   }];
					                                	   var json = {};   
					                                	   json.chart = chart; 
					                                	   json.title = title; 
					                                	   json.xAxis = xAxis;  
					                                	   json.yAxis = yAxis;  
					                                	   json.series = series;
					                                	   var highchart = new Highcharts.Chart(json);  
					                             });
							</script>

							
							
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
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		$(top.hangge());
	</script>
	<script type="text/javascript" src="static/ace/js/jquery.js"></script>
</body>
</html>