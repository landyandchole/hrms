package com.hand.service.app.project.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.util.PageData;
import com.hand.service.app.project.ProjectManager;

/** 
 * 说明： 项目管理
 * 创建人：FH Q313596790
 * 创建时间：2017-07-04
 * @version
 */
@Service("projectService")
public class ProjectService implements ProjectManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@SuppressWarnings("unchecked")
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ProjectMapper.save", pd);
	}
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void saveDouble(List list) throws Exception {
		
		dao.batchSave("ProjectMapper.saveDouble", list);
	}

	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ProjectMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ProjectMapper.edit", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editA(PageData pd)throws Exception{
		dao.update("ProjectMapper.editA", pd);
	}
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editE(PageData pd)throws Exception{
		dao.update("ProjectMapper.editE", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ProjectMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProjectMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectMapper.findById", pd);
	}
	
	/**批量修改
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void editProjectAll(PageData pd)throws Exception{
		dao.update("ProjectMapper.editProjectAll", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> memberList(PageData pd) throws Exception {
		
		return (List<PageData>)dao.findForList("ProjectMapper.memberList", pd);
	}

	/**通过编号获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByPID(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectMapper.findByPId", pd);
	}	


	
	
	/**查询项目人员数
	 * @param pd
	 * @throws Exception
	 */

	@SuppressWarnings("unchecked")
	@Override
	public Long getCount(PageData pd) throws Exception {
		List<PageData> list= (List<PageData>) dao.findForList("ProjectMapper.getCount", pd);
		return   (Long) list.get(0).get("count");
		
	}
	
	/**查询项目费用
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Double getMoney(PageData pd) throws Exception {
		List<PageData> list= (List<PageData>) dao.findForList("ProjectMapper.getMoney", pd);
		 return (Double) list.get(0).get("money");
		
	}
	/**查询项目已收取金额
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Double getReceiving(PageData pd) throws Exception {
		List<PageData> list= (List<PageData>) dao.findForList("ProjectMapper.getReceiving", pd);
		 return (Double) list.get(0).get("receiving");
		
	}
	/**查询项目实际成本
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Double getCost(PageData pd) throws Exception {
		List<PageData> list= (List<PageData>) dao.findForList("ProjectMapper.getCost", pd);
		 return (Double) list.get(0).get("cost");
		
	}
	/**查询项目级别成本
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Double getActual(PageData pd) throws Exception {
		List<PageData> list= (List<PageData>) dao.findForList("ProjectMapper.getActual", pd);
		 return (Double) list.get(0).get("chengben");
		
	}
	
	/**查询项目经理
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public PageData queryManager(PageData pd) throws Exception {	
		
		return (PageData)dao.findForObject("ProjectMapper.queryManager", pd);	
	}

	/**查询项目总监
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public PageData queryDirector(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectMapper.queryDirector", pd);
	}
	/**通过房间获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	/*public List<PageData> findByRM(PageData pd) throws Exception {
		return (List<PageData>) dao.findForObject("ProjectMapper.findByRoom",pd);
	}
*/
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByRM(PageData pd) throws Exception {
		 		List<PageData> list= (List<PageData>) dao.findForList("ProjectMapper.findByRoom", pd);
		 		return list;
	}
	/**通过编号获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getName(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectMapper.getName", pd);
	}
	/**获取上次项目pid
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public String getPID(PageData pd) throws Exception {
		List<PageData> list= (List<PageData>) dao.findForList("ProjectMapper.getPID", pd);	 
		if(list!=null && !list.isEmpty()){				
		return (String) list.get(0).get("PROJECT_PID");
		}
		return "";
	}


}

