package com.hand.service.app.levelcost;

import java.util.List;

import com.hand.entity.Page;
import com.hand.util.PageData;

/** 
 * 说明： 级别成本接口
 * 创建时间：2017-07-07
 * @version
 */
public interface LevelCostManager {
	
	
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
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	
	/**通过级别获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByLC(PageData pd)throws Exception;

	
	
}	

