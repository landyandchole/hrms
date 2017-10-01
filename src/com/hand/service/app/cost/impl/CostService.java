package com.hand.service.app.cost.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.util.PageData;
import com.hand.service.app.cost.CostManager;

/** 
 * 说明： 费用
 * 创建人：FH Q313596790
 * 创建时间：2017-07-06
 * @version
 */
@Service("costService")
public class CostService implements CostManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("CostMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("CostMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("CostMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("CostMapper.datalistPage", page);
	}
	
	/**项目费用列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> proCosts(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CostMapper.proCost", pd);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CostMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CostMapper.findById", pd);
	}
	
	
	/**批量修改
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void editMemberAll(PageData pd)throws Exception{
		dao.update("CostMapper.editMemberAll", pd);
	}
	
	/**
	 *  获取员工列表
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getCostFreeStaff(PageData pd) throws Exception {
		
		return (List<PageData>)dao.findForList("CostMapper.costFreeStaff", pd);
	}
	
}

