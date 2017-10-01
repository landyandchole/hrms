package com.hand.service.app.cost;

import java.util.List;
import com.hand.entity.Page;
import com.hand.util.PageData;

/** 
 * 说明： 费用接口
 * 创建时间：2017-07-06
 * @version
 */
public interface CostManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**
	 * 单个项目费用
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	
	public List<PageData> proCosts(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void editMemberAll(PageData pd)throws Exception;
	/**
	 * 获取员工列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	List<PageData> getCostFreeStaff(PageData pd) throws Exception;
	
}
