package com.hand.service.app.pc;

import java.util.List;

import com.hand.entity.Page;
import com.hand.util.PageData;

/**
 * 说明：PC入场申请接口 创建时间：2017-07-07
 * 
 * @version
 */
public interface PcLeaveManager {
	/**
	 * 新增（2）
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pc_leave, List<PageData> items) throws Exception;

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS) throws Exception;

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page) throws Exception;

	/**
	 * @param pd
	 */
	public void updateState(PageData pd) throws Exception;

	/**
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData pca(PageData pd) throws Exception;

	public PageData GetNextUser(PageData pd) throws Exception;

	public PageData getCountByStatusAndUser(PageData pd) throws Exception;

	public List<PageData> getPcLevelByStatusAndUser(PageData pd) throws Exception;

	public PageData getUserPorject(PageData pd) throws Exception;

	/**
	 * 根据ID查找（2）
	 */
	public PageData findById(PageData pd) throws Exception;

	public void updateStateOnly(PageData pd) throws Exception;

	public void update(PageData pd) throws Exception;

	public PageData getUser(PageData pd) throws Exception;

	public PageData staname(PageData pd) throws Exception;

	public List<PageData> select_hi_NAME_(Page page) throws Exception;

	public List<PageData> select_hi_MESSAGE_(Page page) throws Exception;

	PageData findByPS(String id) throws Exception;

	public PageData getPcstateIdByTaskId(PageData pd) throws Exception;

	public List<String> findAllProcessInstanceId() throws Exception;

	public PageData findByProjectIdAndRoleName(PageData pd) throws Exception;

	public PageData getInfoSafes(PageData pd) throws Exception;

	public PageData getLeaveByTaskId(PageData pd) throws Exception;

	public void updateIsReapply(PageData pd) throws Exception;
}
