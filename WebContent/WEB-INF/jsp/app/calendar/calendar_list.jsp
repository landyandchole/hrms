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

<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日历插件 -->
<link rel="stylesheet" href="static/ace/css/fullcalendar.css" />
<link rel="stylesheet" href="static/ace/css/ace.min.css" />
<link href="static/ace/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="static/ace/css/font-awesome.min.css" />
<style type="text/css">
.modal-dialog {
	width: 550px;
	margin: 0px auto;
	z-index: 1px;
}

.modal-header {
	min-height: 16.428571429px;
	padding: 15px;
	border-bottom: 1px solid #e5e5e5;
}

.modal-body {
	position: relative;
	padding: 20px;
}

.modal-footer {
	padding-top: 12px;
	padding-bottom: 14px;
	border-top-color: #e4e9ee;
	-webkit-box-shadow: none;
	box-shadow: none;
	background-color: #eff3f8;
}

.modal-footer {
	padding: 19px 20px 20px;
	padding-top: 19px;
	padding-bottom: 20px;
	margin-top: 15px;
	text-align: right;
	border-top: 1px solid #e5e5e5;
	border-top-color: rgb(229, 229, 229);
}

.model {
	width: 602px;
	height: 218px;
}

.modal-open {
	overflow: visible;
	overflow-x: visible;
	overflow-y: visible;
}
</style>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content" style="margin-left: 0px;">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<!-- PAGE CONTENT BEGINS -->

							<div class="row">
								<div class="col-sm-9">
									<div class="space"></div>
									<c:if test="${QX.cha == 1  }">
									<div id="calendar"></div>
									</c:if>
									<c:if test="${QX.cha != 1  }">
									您无权查看
									</c:if>
								</div>

								<div class="col-sm-3">
									<c:if test="${QX.add == 1 && QX.cha == 1  }">
										<div class="widget-box transparent">
											<div class="widget-header">
												<h4>年度设置</h4>
											</div>

											<div class="widget-body">
												<div class="widget-main no-padding">
													<div id="external-events">
														<div>
															<br /> <input id="my_max_year" type="text"
																style="width: 130px;" />&nbsp;&nbsp;&nbsp; <a
																class="btn btn-mini btn-primary" id="sc"
																onclick="setAnnualCalendar()"
																style="margin-bottom: 11px;">生成</a> <input
																id="my_max_year2" type="hidden" style="width: 130px;" />
														</div>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</div>
							</div>

							<!-- PAGE CONTENT ENDS -->


						</div>
						<!-- /.main-content -->

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
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
	</script>


	<!-- basic scripts -->

	<!--[if !IE]> -->

	<script type="text/javascript">
			window.jQuery || document.write("<script src='static/ace/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>

	<!-- <![endif]-->

	<!--[if IE]>
		<script type="text/javascript">
		 window.jQuery || document.write("<script src='static/ace/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
		</script>
		<![endif]-->

	<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='static/ace/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
	<script src="static/ace/js/bootstrap.min.js"></script>
	<script src="static/ace/js/typeahead-bs2.min.js"></script>

	<!-- page specific plugin scripts -->

	<script src="static/ace/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="static/ace/js/jquery.ui.touch-punch.min.js"></script>
	<script src="static/ace/js/fullcalendar.min.js"></script>
	<script src="static/ace/js/bootbox.min.js"></script>

	<!-- ace scripts -->

	<script src="static/ace/js/ace-elements.min.js"></script>
	<script src="static/ace/js/ace.min.js"></script>

	<!-- inline scripts related to this page -->

	<script type="text/javascript">
			jQuery(function($) {
				//记录页面是否为第一次加载
				var count = 0;
				//为弹出框加锁
				var unlock = true;
				
				//页面加载时设置最大年份
				setMaxYear();
		/* initialize the external events
			-----------------------------------------------------------------*/
		
			$('#external-events div.external-event').each(function() {
		
				// create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
				// it doesn't need to have a start or end
				var eventObject = {
					title: $.trim($(this).text()) // use the element's text as the event title
				};
		
				// store the Event Object in the DOM element so we can get to it later
				$(this).data('eventObject', eventObject);
		
				// make the event draggable using jQuery UI
				$(this).draggable({
					zIndex: 999,
					revert: true,      // will cause the event to go back to its
					revertDuration: 0  //  original position after the drag
				});
				
			});
		
		
		
		
			/* initialize the calendar
			-----------------------------------------------------------------*/
		
			var date = new Date();
			var d = date.getDate();
			var m = date.getMonth();
			var y = date.getFullYear();
		
			
			var calendar = $('#calendar').fullCalendar({
				width:'893.25px',
				 buttonText: {
					prev: '<i class="icon-chevron-left"></i>',
					next: '<i class="icon-chevron-right"></i>',
					prevYear: '<i class="icon-chevron-left"></i>',
					nextYear: '<i class="icon-chevron-right"></i>'
				},
			
				header: {
					left: 'prev,next month prevYear,nextYear year',
					center: 'title',
					right: 'today'
				},
				events: [
				{
					title: 'All Day Event',
					start: new Date(y, m, 1),
					className: 'label-important'
				},
				{
					title: 'Long Event',
					start: new Date(y, m, d-5),
					end: new Date(y, m, d-2),
					className: 'label-success'
				},
				{
					title: 'Some Event',
					start: new Date(y, m, d-3, 16, 0),
					allDay: false
				}]
				,
				editable: false,
				droppable: true, // this allows things to be dropped onto the calendar !!!
				events:function(start,end,callback){
					if(count > 0){
						calendar.fullCalendar('removeEvents');
					}
					count++;
					var startDate = start.getFullYear() + '-' + (start.getMonth() + 1) + '-' + start.getDate(); 
				    var endDate = end.getFullYear() + '-' + (end.getMonth() + 1) + '-' + end.getDate();
					 $.ajax({
		                      url:"calendar/findCalendar.do",
		                      type:"post",
		                      data:{
		                    	  startDay:startDate,
		                    	  endDay:endDate
		                      },
		                      dataType: 'json',
		                      success: function(res){
		                    	  var events =[];
		                    	   for (i in res) {
		                    			if (res[i].DATE_STATUS == '1') {
		                    				events.push({
		                    					title : '工作日',
		                    					start : new Date(res[i].y_start, res[i].m_start-1,
		                    							res[i].d_start),
		                    					color : '#5092FF'
		            
		                    				});
		                    			} else if(res[i].DATE_STATUS == '2'){
		                    				events.push({
		                    					title : '休息日',
		                    					start : new Date(res[i].y_start, res[i].m_start-1,
		                    							res[i].d_start),
		                    					color : '#FFD79C'
		            
		                    				});
		                    			} 
		                    		} 
		                    	   callback(events);
     	                          }
	
		                     
		               }); 
				},
				drop: function(date, allDay) { // this function is called when something is dropped
				
					// retrieve the dropped element's stored Event Object
					var originalEventObject = $(this).data('eventObject');
					var $extraEventClass = $(this).attr('data-class');
					
					
					// we need to copy it, so that multiple events don't have a reference to the same object
					var copiedEventObject = $.extend({}, originalEventObject);
					
					// assign it the date that was reported
					copiedEventObject.start = date;
					copiedEventObject.allDay = allDay;
					if($extraEventClass) copiedEventObject['className'] = [$extraEventClass];
					
					// render the event on the calendar
					// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
					$('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
					
					// is the "remove after drop" checkbox checked?
					if ($('#drop-remove').is(':checked')) {
						// if so, remove the element from the "Draggable Events" list
						$(this).remove();
					}
					
				}
				,
				selectable: true,
				selectHelper: true,
				select: function(start, end, allDay) {
					if((end-start) > 0){
						calendar.fullCalendar('unselect');
						return;
					}
					var startDate = start.getFullYear() + '-' + (start.getMonth() + 1) + '-' + start.getDate();
					//查询数据库该日期是否已经设置
					var isSet = true;
					$.ajax({
						url:'calendar/isSetCalendar.do',
						type:'post',
						async: false,
						data:{
	                    	  CALENDAR_DATE:startDate
	                    },
	                    success: function(res){
	                    	if(res.result == 'true'){
	                    		//修改工作日设置
	                    		isSet = true;
	                    	}else if(res.result == 'false'){
	                    		//工作日设置
	                    		isSet = false;
	                    	}
			     	     }
					});

					if(isSet){
						return;
					}
					
					//权限判断
					if('${QX.add == 1 }' == 'false'){
						return;
					}
					
					//为弹出框加锁
					if(unlock){
						//加锁
						unlock = false;
					}else{
						return;
					}
					
				 	bootbox.dialog({
					    title : "工作日设置",
					    message : "<div style='height: 33px;'>是否为工作日：<input id='my_switch_box' name='switch-field-1' class='ace ace-switch ace-switch-3' type='checkbox'><span class='lbl'></span></div>",
			            onEscape: function() {
			            	//解锁
							unlock = true;
			            },
					    buttons : {
					        "success" : {
					            "label" : "<i class='icon-ok'></i> 保存",
					            "className" : "btn-sm btn-success",
					            "callback" : function() {
					                var my_switch = $('#my_switch_box').is(':checked')?1:2;
					                var my_status = $('#my_switch_box').is(':checked')?'工作日':'休息日';
					                var my_color = $('#my_switch_box').is(':checked')?'#5092FF':'#FFD79C';
									//通过ajax修改日期的状态
					                $.ajax({
					                      url:"calendar/saveCalendar.do",
					                      type:"post",
					                      data:{
					                    	  CALENDAR_DATE:startDate,
					                    	  DATE_STATUS:my_switch
					                      },
					                      success: function(res){
					                    	calendar.fullCalendar('renderEvent',
													{
														title: my_status,
														start: start,
														end: end,
														allDay: allDay,
														color: my_color
													},
													true // make the event "stick"
												);
					                    	//重新设置最大年份
					                    	setMaxYear();
			     	                      }
	
					                     
					              }); 
								//解锁
								unlock = true;
					            }
					        },
					        "cancel" : {
					            "label" : "<i class='icon-info'></i> 取消",
					            "className" : "btn-sm btn-danger",
					            "callback" : function() {
					            	//解锁
									unlock = true;
					            }
					            
					        }
					        
					    }
					}); 
					
					
					calendar.fullCalendar('unselect');
					
				},
				dayClick: function(date, allDay, jsEvent, view) {
					var startDate = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate(); 
					//查询数据库该日期是否已经设置
					var isSet = true;
					var my_calendar;
					$.ajax({
						url:'calendar/isSetCalendar.do',
						type:'post',
						async: false,
						data:{
	                    	  CALENDAR_DATE:startDate
	                    },
	                    success: function(res){
	                    	if(res.result == 'true'){
	                    		//修改工作日设置
	                    		isSet = true;
	                    		my_calendar = res.calendar;
	                    	}else if(res.result == 'false'){
	                    		//工作日设置
	                    		isSet = false;
	                    	}
			     	     }
					}); 

	
					 if(isSet){
						 
						//权限判断
						if('${QX.del == 1 }' == 'false' && '${QX.edit == 1}' == 'false'){
							return;
						}
						
						if(unlock){
								//加锁
								unlock = false;
						}else{
								return;
						}
						
					 //如果工作日已经设置修改工作日	
					 var title = my_calendar.DATE_STATUS==1?'工作日':'休息日';
					 var events = $('#calendar').fullCalendar('clientEvents', function(event) {
				            var theDate = date.format('YYYY-MM-dd');
				            var eventStart = event.start.format('YYYY-MM-dd');
				            var eventEnd = event.end ? event.end.format('YYYY-MM-dd') : null;
				            // Make sure the event starts on or before date and ends afterward
				            // Events that have no end date specified (null) end that day, so check if start = date
				            return (eventStart <= theDate && (eventEnd >= theDate) && !(eventStart < theDate && (eventEnd == theDate))) || (eventStart == theDate && (eventEnd === null));
				     });

					 var form;
					 	if('${QX.del == 1 }' == 'true' && '${QX.edit == 1}' == 'false'){
					 		form = $("<form class='form-inline'><label><b>取消工作日设置&nbsp;</b></label></form><br>");
					 		form.append("<div style='height:24px;'>是否取消设置？<br/><br/></div>");
					 	}else{
					 		form = $("<form class='form-inline'><label><b>修改工作日设置&nbsp;</b></label></form><br>");
							if(title == '休息日'){
								form.append("<div>是否为工作日：<input id='my_switch_box2' name='switch-field-1' class='ace ace-switch ace-switch-3' type='checkbox'><span class='lbl'></span></div> ");
							}else if(title == '工作日'){
								form.append("<div>是否为工作日：<input id='my_switch_box2' name='switch-field-1' checked class='ace ace-switch ace-switch-3' type='checkbox'><span class='lbl'></span></div> ");
							}
					 	}
						var startDate = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate(); 
						var div = bootbox.dialog({
							message: form,
							onEscape: function() {
				            	//解锁
								unlock = true;
				            },
							buttons: {
								<c:if test="${QX.del == 1 }">
								"delete" : {
									"label" : "<i class='icon-trash'></i> 取消设置",
									"className" : "btn-sm btn-danger",
									"callback": function() {
										//调用后台取消设置
										//通过ajax修改日期的状态
						                    $.ajax({
						                      url:"calendar/cancelCalendar.do",
						                      type:"post",
						                      data:{
						                    	  CALENDAR_DATE:startDate,
						                    	  DATE_STATUS:0
						                      },
						                      success: function(res){
						                    	  calendar.fullCalendar('removeEvents' , function(ev){
														return (ev._id == events[0]._id);
												  })
												  //重新设置最大年份
												  setMaxYear();
				     	                      } 
											
						                     
						               }); 
										
										//解锁
						                unlock = true;
										
									}
								} ,
								</c:if>
								<c:if test="${QX.edit == 1 }">
								"save" : {
									"label" : "保存设置",
									"className" : "btn-sm btn-success",
									"callback": function() {
										var my_switch = $('#my_switch_box2').is(':checked')?1:2;
										var my_status = $('#my_switch_box2').is(':checked')?'工作日':'休息日';
										var my_color = $('#my_switch_box2').is(':checked')?'#5092FF':'#FFD79C';
										   $.ajax({
								                      url:"calendar/changeCalendar.do",
								                      type:"post",
								                      data:{
								                    	  CALENDAR_DATE:startDate,
								                    	  DATE_STATUS:my_switch
								                    	  
								                      },
								                      success: function(res){
								                    	  events[0].title = my_status;
								                    	  events[0].color = my_color;
								                    	  calendar.fullCalendar('updateEvent', events[0]);
						     	                      } 
											 });	
										 //解锁
							             unlock = true;
									}
								} ,
								</c:if>
								"close" : {
									"label" : "<i class='icon-remove'></i> 关闭",
									"className" : "btn-sm",
									"callback" : function() {
						            	//解锁
										unlock = true;
						            }
								} 
							}
			
						}); 
					}
			    },
				eventClick: function(calEvent, jsEvent, view) {

					//权限判断
					if('${QX.del == 1 }' == 'false' && '${QX.edit == 1}' == 'false'){
						return;
					}
					
					if(unlock){
						//加锁
						unlock = false;
					}else{
							return;
					}

					 var form;
					 	if('${QX.del == 1 }' == 'true' && '${QX.edit == 1}' == 'false'){
					 		form = $("<form class='form-inline'><label><b>取消工作日设置&nbsp;</b></label></form><br>");
					 		form.append("<div style='height:24px;'>是否取消设置？<br/><br/></div>");
					 	}else{
					 		form = $("<form class='form-inline'><label><b>修改工作日设置&nbsp;</b></label></form><br>");
							if(calEvent.title == '休息日'){
								form.append("<div>是否为工作日：<input id='my_switch_box2' name='switch-field-1' class='ace ace-switch ace-switch-3' type='checkbox'><span class='lbl'></span></div> ");
							}else if(calEvent.title == '工作日'){
								form.append("<div>是否为工作日：<input id='my_switch_box2' name='switch-field-1' checked class='ace ace-switch ace-switch-3' type='checkbox'><span class='lbl'></span></div> ");
							}
					 	}
					var startDate = calEvent.start.getFullYear() + '-' + (calEvent.start.getMonth() + 1) + '-' + calEvent.start.getDate(); 
					var div = bootbox.dialog({
						message: form,
						onEscape: function() {
			            	//解锁
							unlock = true;
			            },
						buttons: {
							<c:if test="${QX.del == 1 }">
							"delete" : {
								"label" : "<i class='icon-trash'></i> 取消设置",
								"className" : "btn-sm btn-danger",
								"callback": function() {
									//调用后台取消设置
									//通过ajax修改日期的状态
					                    $.ajax({
					                      url:"calendar/cancelCalendar.do",
					                      type:"post",
					                      data:{
					                    	  CALENDAR_DATE:startDate,
					                    	  DATE_STATUS:0
					                      },
					                      success: function(res){
					                    	  calendar.fullCalendar('removeEvents' , function(ev){
													return (ev._id == calEvent._id);
											  })
											  //重新设置最大年份
											  setMaxYear();
			     	                      } 
										
					                     
					               }); 
								
					               //加锁
									unlock = true;
									
								}
							} ,
							</c:if>
							<c:if test="${QX.edit == 1 }">
							"save" : {
								"label" : "保存设置",
								"className" : "btn-sm btn-success",
								"callback": function() {
									var my_switch = $('#my_switch_box2').is(':checked')?1:2;
									var my_status = $('#my_switch_box2').is(':checked')?'工作日':'休息日';
									var my_color = $('#my_switch_box2').is(':checked')?'#5092FF':'#FFD79C';
									   $.ajax({
							                      url:"calendar/changeCalendar.do",
							                      type:"post",
							                      data:{
							                    	  CALENDAR_DATE:startDate,
							                    	  DATE_STATUS:my_switch
							                      },
							                      success: function(res){
							                    	  calEvent.title = my_status;
							                    	  calEvent.color = my_color;
							          				  calendar.fullCalendar('updateEvent', calEvent);
					     	                      } 
										 });
									   //加锁
										unlock = true;
									
								}
							} ,
							</c:if>
							"close" : {
								"label" : "<i class='icon-remove'></i> 关闭",
								"className" : "btn-sm",
								"callback" : function() {
					            	//解锁
									unlock = true;
					            }
							} 
						}
		
					});
					
				}
				
			});
		
		
		})
		

			
			Date.prototype.format = function (format) {
			    var date = {
			        "M+": this.getMonth() + 1,
			        "d+": this.getDate(),
			        "h+": this.getHours(),
			        "m+": this.getMinutes(),
			        "s+": this.getSeconds(),
			        "q+": Math.floor((this.getMonth() + 3) / 3),
			        "S+": this.getMilliseconds()
			    };
			    if (/(y+)/i.test(format)) {
			        format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
			    }
			    for (var k in date) {
			        if (new RegExp("(" + k + ")").test(format)) {
			            format = format.replace(RegExp.$1, RegExp.$1.length == 1
			                            ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
			        }
			    }
			    return format;
			}
			
			
			//设置最大年份
			function setMaxYear(){
				$.ajax({
					url: 'calendar/findMaxYear.do',
					type: 'post',
					success: function(data){
						$('#my_max_year').val(data);
						$('#my_max_year2').val(data);
					}
					
				});
			}
			
			//年度生成工作日历
			function setAnnualCalendar(){
				//验证输入参数的合法性
				var year = $('#my_max_year').val();
				var year2 = $('#my_max_year2').val();
				if(year == ''){
					alert('请输入要设置的年份！');
					return false;
				}else if(isNaN(year)){
					alert('请输入一个合法的数字！');
					return false;
				}else if(year < year2){
					alert('输入值不能小于等于已存在日期最大年份:'+ (year2-1) );
					return false;
				}
				
				
				$('#sc').unbind("click");
				$.ajax({
					url: 'calendar/setAnnualCalendar.do',
					type: 'post',
					async: false,
					data: {
						maxYear: $.trim($('#my_max_year').val())
					},
					success: function(data){
						 bootbox.alert({  
					            buttons: {  
					               ok: {  
					                    label: '确定',  
					                    className: 'btn-success'  
					                }  
					            },  
					            message: '<div style="height:33px;">' + $('#my_max_year').val() + '年设置成功！</div>',  
					            callback: function() {  
					            },  
					            title: "年度设置",  
					        });  
					}
					
				});
				
				//重新设置最大年份
				setMaxYear();
				$('#calendar').fullCalendar('gotoDate', $('#my_max_year').val(), 0,1);
				$('#sc').attr("onclick","setAnnualCalendar()");
			}
		</script>


</body>
</html>
