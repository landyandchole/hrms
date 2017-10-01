package com.hand.controller.app.calendar;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.service.app.calendar.CalendarManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;

/**
 * 说明：工作日历 创建时间：2017-07-05
 */
@Controller
@RequestMapping(value = "/calendar")
public class CalendarController extends BaseController {

	String menuUrl = "calendar/list.do"; // 菜单地址(权限用)
	@Resource(name = "calendarService")
	private CalendarManager calendarService;
	@Resource(name = "fhlogService")
	private FHlogManager FHLOG;

	/**
	 * 去日历页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goCalendarList")
	public ModelAndView goCalendarList() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("app/calendar/calendar_list");
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 获取日程表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/findCalendar")
	public List<PageData> list() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Calendar");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> varList = calendarService.findCalendar(pd); // 列出Calendar列表
		varList = calendarToYMD(varList);
		// 将日期转换为年月日
		return varList;
	}

	/*
	 * 判断是否已经设置日历
	 */
	@ResponseBody
	@RequestMapping(value = "/isSetCalendar")
	public Map<String, Object> isSetCalendar(HttpServletResponse response) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "取消Calendar");
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> varList = calendarService.findByCalendarDate(pd);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (varList.size() > 0) {
			resultMap.put("result", "true");
			resultMap.put("calendar", varList.get(0));
		} else {
			resultMap.put("result", "false");
			resultMap.put("calendar", null);
		}

		return resultMap;
	}

	/*
	 * 取消日历设置
	 */
	@ResponseBody
	@RequestMapping(value = "/cancelCalendar")
	public void cancelCalendar(HttpServletResponse response) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "取消Calendar");
		PageData pd = new PageData();
		pd = this.getPageData();
		calendarService.deleteByCalendar(pd);
		FHLOG.save(Jurisdiction.getUsername(), "取消工作日历设置[CALENDAR_DATE=" + pd.getString("CALENDAR_DATE") + "]", "TB_CALENDAR","CALENDAR_DATE",pd.getString("CALENDAR_DATE"));
	}

	/**
	 * 修改日历设置
	 */
	@ResponseBody
	@RequestMapping(value = "/changeCalendar")
	public void changeCalendar(HttpServletResponse response) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改Calendar");
		PageData pd = new PageData();
		pd = this.getPageData();
		calendarService.changeCalendar(pd);
		FHLOG.save(Jurisdiction.getUsername(), "修改工作日历设置[CALENDAR_DATE=" + pd.getString("CALENDAR_DATE") + ",DATE_STATUS=" + pd.getString("DATE_STATUS") + "]", "TB_CALENDAR","CALENDAR_DATE",pd.getString("CALENDAR_DATE"));
	}

	/**
	 * 查找当前最大的年份
	 * 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/findMaxYear")
	public int findMaxYear(HttpServletResponse response) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "获取最大的年份");
		PageData maxDate = calendarService.findMaxYear();
		Calendar c = Calendar.getInstance();
		java.sql.Date myMaxDate = (java.sql.Date) maxDate.get("maxDate");
		c.setTime(myMaxDate);
		int year = c.get(Calendar.YEAR);
		return year + 1;
	}

	/*
	 * 保存日历设置
	 */
	@ResponseBody
	@RequestMapping(value = "/saveCalendar")
	public void saveCalendar(HttpServletResponse response) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "保存Calendar");
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CALENDAR_ID", this.get32UUID()); // 主键
		calendarService.save(pd);
		FHLOG.save(Jurisdiction.getUsername(), "添加工作日历设置[CALENDAR_DATE=" + pd.getString("CALENDAR_DATE") + ",DATE_STATUS=" + pd.getString("DATE_STATUS") + "]", "TB_CALENDAR","CALENDAR_DATE",pd.getString("CALENDAR_DATE"));
	}

	/**
	 * 按年度设置Calendar
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/setAnnualCalendar")
	public void setAnnualCalendar(HttpServletResponse response) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "按年度设置Calendar");
		PageData pd = new PageData();
		pd = this.getPageData();
		calendarService.insertAnnualCalendar(pd);
		FHLOG.save(Jurisdiction.getUsername(), "年度设置工作日历[maxYear=" + pd.getString("maxYear") + "]", "TB_CALENDAR","",pd.getString("maxYear"));
	}

	/*
	 * 将日历数据分解为日、月、年的形式
	 */
	public List<PageData> calendarToYMD(List<PageData> varList) {
		List<PageData> myList = new ArrayList<PageData>();
		Calendar c = Calendar.getInstance();
		for (PageData pageData : varList) {
			java.sql.Date myData = (java.sql.Date) pageData.get("CALENDAR_DATE");
			c.setTime(myData);
			int y_start = c.get(Calendar.YEAR);
			int m_start = c.get(Calendar.MONTH) + 1;
			int d_start = c.get(Calendar.DATE);
			pageData.put("y_start", y_start);
			pageData.put("m_start", m_start);
			pageData.put("d_start", d_start);
			myList.add(pageData);
		}

		return myList;
	}

}
