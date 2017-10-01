package com.hand.service.app.pc.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.service.app.pc.PcManager;
import com.hand.util.PageData;

/** 
 * 说明： 员工管理
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 * @version
 */
@Service("pcService")
public class PcService implements PcManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("PcMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("PcMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("PcMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PcMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAllpc(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PcMapper.listAllpc", pd);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listpro(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PcMapper.listAllpro", pd);
	}
	
	
	/**一条数据
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> Alist(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PcMapper.AdatalistPage", page);
	}
	
	/**一条数据
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> PCstate(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PcMapper.PCstate", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PcMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PcMapper.findById", pd);
	}
	
	/**通过No获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByNo(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PcMapper.findByNo", pd);
	}
	
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
//	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
//		dao.delete("PcMapper.deleteAll", ArrayDATA_IDS);
//	}
	public PageData deleteAll(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PcMapper.deleteAll", pd);
	}
	
	/**
	 *  
	 */
	public PageData getLevel(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("PcMapper.getLevel", pd);
	}
	
	public PageData count(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("PcMapper.count", pd);
	}
	public PageData countdepot_have(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("PcMapper.countdepot_have", pd);
	}
	public PageData countdepot_no(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("PcMapper.countdepot_no", pd);
	}
	public PageData countdepot(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("PcMapper.countdepot", pd);
	}
	public PageData countdep(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("PcMapper.countdep", pd);
	}
	
	
	/**
	 * 通过pc_no修改在库状态
	 */
	@Override
	public void editDepot(PageData pd) throws Exception {
		dao.update("PcMapper.editDepot", pd);
		
	}

	
	
	/**
	 * 查询闲置PC
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> showDepot(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("PcMapper.showDepot", pd);
	}

	@Override
	public void editPandR(PageData pd) throws Exception {
		dao.update("PcMapper.editPandR", pd);
		
	}
	
	@Override
	public PageData getPDByIds(PageData pdb)throws Exception {
			return (PageData) dao.findForObject("PcMapper.getPDByIds", pdb);
	}
}

