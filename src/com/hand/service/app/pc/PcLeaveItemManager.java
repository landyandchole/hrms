package com.hand.service.app.pc;

import java.util.List;

import com.hand.util.PageData;

public interface PcLeaveItemManager {

	/**
	 * 新增
	 */
	public void save(PageData pd) throws Exception;

	/**
	 * 查找所有的流程实例ID
	 */
	public List<String> findAllProcessInstanceId() throws Exception;

	/**
	 * 根据流程实例ID查找申请人信息和流程信息
	 */
	public PageData findStaffProByProInstId(PageData pd) throws Exception;

	/**
	 * 根据申请人和状态查询记录总数
	 */
	public PageData getCountByStatusAndUser(PageData pd) throws Exception;

	/**
	 * 根据申请人和状态查询记录
	 */
	public List<PageData> getPcLevelByStatusAndUser(PageData pd) throws Exception;

	/**
	 * 根据流程ID查找pc_leave_item
	 */
	public PageData getItemByProInstId(PageData pd) throws Exception;

	/**
	 * 根据ID查找pc_leave_item
	 */
	public PageData getItemById(PageData pd) throws Exception;

	/**
	 * 根据PC_LEAVEID查找pc_leave_item
	 * @return
	 * @throws Exception
	 */
	public PageData getItemByIds(PageData pd) throws Exception;

	PageData findById(PageData pd) throws Exception;

	void updateIsReapply(PageData pd) throws Exception;

}
