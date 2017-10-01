package com.hand.service.app.calendar.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.service.app.calendar.CalendarManager;
import com.hand.util.PageData;
import com.hand.util.UuidUtil;

/**
 * 说明： 工作日历 创建人：FH Q313596790 创建时间：2017-07-05
 * 
 * @version
 */
@Service("calendarService")
public class CalendarService implements CalendarManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception {
		dao.save("CalendarMapper.save", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception {
		dao.delete("CalendarMapper.delete", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {
		dao.update("CalendarMapper.edit", pd);
	}

	/**
	 * 根据日期修改日历
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void changeCalendar(PageData pd) throws Exception {
		dao.update("CalendarMapper.changeCalendar", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("CalendarMapper.datalistPage", page);
	}

	/**
	 * 列表(全部)
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("CalendarMapper.listAll", pd);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("CalendarMapper.findById", pd);
	}

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS) throws Exception {
		dao.delete("CalendarMapper.deleteAll", ArrayDATA_IDS);
	}

	/**
	 * 根据起始日期查询日历
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findCalendar(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("CalendarMapper.findCalendar", pd);
	}

	/**
	 * 根据日期查找日历数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByCalendarDate(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("CalendarMapper.findByCalendarDate", pd);
	}

	/**
	 * 根据日期删除记录
	 */
	@Override
	public void deleteByCalendar(PageData pd) throws Exception {
		dao.delete("CalendarMapper.deleteByCalendar", pd);

	}

	/**
	 * 查找当前最大的年份
	 */
	@Override
	public PageData findMaxYear() throws Exception {
		return (PageData) dao.findForObject("CalendarMapper.findMaxYear", null);
	}

	@Override
	public void insertAnnualCalendar(PageData pd) throws Exception {
		String maxYear = pd.getString("maxYear");
		int intMaxYear = 0;
		if (!"".equals(maxYear) && maxYear != null) {
			intMaxYear = Integer.parseInt(maxYear);
		}
		Calendar start = Calendar.getInstance();
		start.set(intMaxYear, 0, 1);
		Long startTIme = start.getTimeInMillis();

		Calendar end = Calendar.getInstance();
		end.set(intMaxYear, 11, 31);
		Long endTime = end.getTimeInMillis();

		Long oneDay = 1000 * 60 * 60 * 24l;

		Long time = startTIme;
		while (time <= endTime) {
			Date d = new Date(time);
			Calendar varCalendar = Calendar.getInstance();
			varCalendar.setTime(d);
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			pd.put("CALENDAR_DATE", df.format(d));
			if (varCalendar.get(Calendar.DAY_OF_WEEK) == 7 || varCalendar.get(Calendar.DAY_OF_WEEK) == 1) {
				pd.put("DATE_STATUS", 2);
			} else {
				pd.put("DATE_STATUS", 1);
			}
			pd.put("CALENDAR_ID", UuidUtil.get32UUID());
			dao.save("CalendarMapper.save", pd);
			time += oneDay;
		}

	}

}
