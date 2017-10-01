
package com.hand.service.app.project;

import java.util.List;

import com.hand.entity.Page;
import com.hand.util.PageData;

/** 
 * 说明： 项目管理接口
 * 创建时间：2017-07-04
 * @version
 */
public interface ProjectManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void saveDouble(List list)throws Exception;
	
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
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editA(PageData pd)throws Exception;
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editE(PageData pd)throws Exception;
	
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
	public void editProjectAll(PageData pd)throws Exception;
	
	/**
	 * 团队成员
	 */
	public List<PageData> memberList(PageData pd)throws Exception;

	/**通过编号获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByPID(PageData pd)throws Exception;


	 /**查询项目经理
	 * @param pd
	 * @throws Exception
	 */

    public PageData queryManager(PageData pd)throws Exception;

    /**查询项目总监
   	 * @param pd
   	 * @throws Exception
   	 */

    public PageData queryDirector(PageData pd)throws Exception;
    /**查询项目人员数
	 * @param pd
	 * @throws Exception
	 */ 
    public Long getCount(PageData pd)throws Exception; 
    
    
    /**查询各项目费用
  	 * @param pd
  	 * @throws Exception
  	 */

      public Double getMoney(PageData pd)throws Exception; 
      
      /**查询各项目已收取金额
    	 * @param pd
    	 * @throws Exception
    	 */

        public Double getReceiving(PageData pd)throws Exception; 
          
      /**查询各项目实际成本
    	 * @param pd
    	 * @throws Exception
    	 */

        public Double getCost(PageData pd)throws Exception; 
      /**查询各项目级别成本
    	 * @param pd
    	 * @throws Exception
    	 */

        public Double getActual(PageData pd)throws Exception; 
        
        /**通过房间获取数据
    	 * @param pd
    	 * @return
    	 * @throws Exception
    	 */
    	public List<PageData> findByRM(PageData pd)throws Exception;
    	
    	  /**通过房间获取数据
    	 * @param pd
    	 * @return
    	 * @throws Exception
    	 */
    	public PageData getName(PageData pd)throws Exception;
    	
    	 /**查询上次PID
    	 * @param pd
    	 * @throws Exception
    	 */

        public String getPID(PageData pd)throws Exception;
}





