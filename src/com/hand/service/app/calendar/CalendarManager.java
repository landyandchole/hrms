package com.hand.service.app.calendar;

import java.util.List;

import com.hand.entity.Page;
import com.hand.util.PageData;

/**
 * 说明： 工作日历接口 创建时间：2017-07-05
 * 
 * @version
 */
public interface CalendarManager {

	/**
	 * 根据起始日期查询日历
	 * 
	 * @param startDay
	 *            开始日期
	 * @param endDay
	 *            结束日期后一天
	 * @return 日历信息列表
	 * @throws Exception
	 */
	public List<PageData> findCalendar(PageData pd) throws Exception;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception;

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception;

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;

	public void deleteByCalendar(PageData pd) throws Exception;

	/**
	 * 根据日期修改日历
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void changeCalendar(PageData pd) throws Exception;

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page) throws Exception;

	/**
	 * 列表(全部)
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd) throws Exception;

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception;

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS) throws Exception;

	/**
	 * 根据日期查找日历数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findByCalendarDate(PageData pd) throws Exception;

	/**
	 * 查找当前最大的年份
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findMaxYear() throws Exception;

	/**
	 * 按年度设置Calendar
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void insertAnnualCalendar(PageData pd) throws Exception;

}
