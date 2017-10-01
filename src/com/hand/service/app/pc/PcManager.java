package com.hand.service.app.pc;

import java.util.List;

import com.hand.entity.Page;
import com.hand.entity.system.Department;
import com.hand.util.PageData;

/** 
 * 说明： 员工管理接口
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 * @version
 */
public interface PcManager{

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
/*	*//**一条数据
	 * @param page
	 * @throws Exception
	 *//*
	public List<PageData> Alist(Page page)throws Exception;
	
	
	*//**申请状态
	 * @param page
	 * @throws Exception
	 *//*
	public List<PageData> PCstate(Page page)throws Exception;
	*/
	/**一条数据
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> Alist(Page page)throws Exception;
	
	
	/**申请状态
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> PCstate(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listpro(PageData pd)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAllpc(PageData pd)throws Exception;
	
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**通过no获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByNo(PageData pd)throws Exception;
	
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
//	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	public PageData deleteAll(PageData pd)throws Exception;
	/**
	 * 获得级别成本
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	
	public PageData getLevel(PageData pd)throws Exception;

	
	/**
	 * 修改在库状态
	 * @param pd
	 * @throws Exception
	 */
	public void editDepot(PageData pd)throws Exception;
	
	public PageData countdep(PageData pd) throws Exception;
	/**
	 * 查询闲置的PC
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> showDepot(PageData pd)throws Exception;
	
	/**
	 * 修改项目和房间
	 * @param pd
	 * @throws Exception
	 */
	public void editPandR(PageData pd)throws Exception;
	
	
	/**
	 * 通过pc编号查询PC_ID
	 * @param pdb
	 * @return
	 * @throws Exception 
	 */
	public PageData getPDByIds(PageData pdb) throws Exception;
}

