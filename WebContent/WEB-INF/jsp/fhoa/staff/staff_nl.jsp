<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="static/js/echarts.js"></script>
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
</head>
<body>
	<form action="staff/nl.do" method="post" name="Form" id="Form">
		<div class="main-container" id="main-container">
			<!-- /section:basics/sidebar -->
			<div class="main-content">
				<div class="main-content-inner">
					<div class="page-content">
						<div class="row">
							<div class="col-xs-12">
								<div id="zhongxin" style="padding-top: 13px;">
									<table style="width:100px" id="table_report"
										class="table table-striped table-bordered table-hover" >
										<tr>
											<td class="center">工号</td>
											<td class="center">${pd.NO}</td>
										</tr>
										<tr>
											<td class="center">姓名</td>
											<td class="center">${pd.NAME}</td>
										</tr>
									</table>
								</div>
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
		<div id="main" style="width: 600px; height: 400px;text-align:center;margin:0 auto"></div>
		<!-- basic scripts -->
		<!-- 页面底部js¨ -->
		<%@ include file="../../system/index/foot.jsp"%>
		<script type="text/javascript">
   	$(top.hangge());//关闭加载状态
	 	// 基于准备好的dom，初始化echarts实例
	    var myChart = echarts.init(document.getElementById('main'));
	 	// 指定图表的配置项和数据
    		var option = {
   		    title: {
   		    	x:'center',
   		    	y:'top',
   		        text: '员工能力展示'
   		    },
   		    tooltip: {},
   		    radar: {
   	          radius: '70%',
   	          splitNumber: 10,
   	          axisLine: {
   	              lineStyle: {
   	                  color: 'rgba(0,0,0,.7)',
   	                  opacity: .2
   	              }
   	          },
   	          splitLine: {
   	              lineStyle: {
   	                  color: '#rgba(0,0,0,.7)',
   	                  opacity: .2
   	              }
   	          },
   	          splitArea: {
   	              areaStyle: {
   	                  color: 'rgba(255,255,255,.7)',
   	                  opacity: 1,
   	                  shadowBlur: 45,
   	                  shadowColor: 'rgba(0,0,0,.5)',
   	                  shadowOffsetX: 0,
   	                  shadowOffsetY: 15,
   	              }
   	          },
 		        indicator: [
 		           { name: '工作态度', max: 100},
 		           { name: '工作年限', max: 100},
 		           { name: 'ABAP水平', max: 100},
 		           { name: 'JAVA水平', max: 100},
 		           { name: '英语水平', max: 100},
 		           { name: '日语水平', max: 100}
 		        ]
 		    },
   		    series: [{
		          name: '员工个人能力',
		          type: 'radar',
		          symbolSize: 0,
		          areaStyle: {
		              normal: {
		                  shadowBlur: 13,
		                  shadowColor: 'rgba(0,0,0,.2)',
		                  shadowOffsetX: 0,
		                  shadowOffsetY: 10,
		                  opacity: 1
		              }
		          },
   		        data : [
   		            {
   		                value : [${pd.ATTITUDE_MARK}, ${pd.YEARS_MARK}, ${pd.ABAP_MARK}, ${pd.JAVA_MARK}, ${pd.ENGLISH_MARK}, ${pd.JAPANESE_MARK}],
   		                name : '员工能力展示）'
   		            }
   		        ]
   		    }],color: ['rgba(0,0,244,.4)'],
   		}; 
	 	
   		/* var option = {
			      title: {
			          text: '员工能力展示'
			      },
				  tooltip: {},  
			      radar: {
			          radius: '60%',//雷达图本身大小
			          splitNumber: 5,//雷达图蜘蛛线条数
			          axisLine: {
			              lineStyle: {
			                  color: '#fff',//字颜色
			                  opacity: .2//字着色程度
			              }
			          },
			          splitLine: {
			              lineStyle: {
			                  color: '#fff',
			                  opacity: .2
			              }
			          },
			          splitArea: {
			              areaStyle: {
			                  color: 'rgba(127,95,132,.3)',//RGB+Alpha(透明度)
			                  opacity: 1,
			                  shadowBlur: 45,
			                  shadowColor: 'rgba(0,0,0,.5)',
			                  shadowOffsetX: 0,
			                  shadowOffsetY: 15,
			              }
			          },
			          indicator: [{
			              name: '工作态度',
			              max: 100
			          }, {
			              name: '工作年限',
			              max: 100
			          }, {
			              name: 'ABAP水平',
			              max: 100
			          }, {
			              name: 'JAVA水平',
			              max: 100
			          }, {
			              name: '英语水平',
			              max: 100
			          }, {
			              name: '日语水平',
			              max: 100
			          }]
			      },
			      series: [{
			          name: '员工个人能力',
			          type: 'radar',
			          symbolSize: 0,
			          areaStyle: {
			              normal: {
			                  shadowBlur: 13,
			                  shadowColor: 'rgba(0,0,0,.1)',
			                  shadowOffsetX: 0,
			                  shadowOffsetY: 10,
			                  opacity: 1
			              }
			          },
			          data: [{
			              value: [${pd.ATTITUDE_MARK}, ${pd.YEARS_MARK}, ${pd.ABAP_MARK}, ${pd.JAVA_MARK}, ${pd.ENGLISH_MARK}, ${pd.JAPANESE_MARK}],
			              name: '员工能力展示',
			          }]
			      }],
			      color: ['rgba(244,210,111,.2)'],
			      backgroundColor: {
			          type: 'radial',
			          x: 0.4,
			          y: 0.4,
			          r: 0.35,
			          colorStops: [{
			              offset: 0,
			              color: '#895355' // 0% 处的颜色//高光处颜色
			          }, {
			              offset: .4,
			              color: '#593640' // 100% 处的颜色//高光处颜色
			          }, {
			              offset: 1,
			              color: '#39273d' // 100% 处的颜色//背景颜色
			          }],
			          globalCoord: false // 缺省为 false
			      }
			  }; */
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
   	</script>
	</form>
</body>
</html>