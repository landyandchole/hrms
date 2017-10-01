package com.hand.service.app.project.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.util.PageData;
import com.hand.service.app.project.ProjectMemberManager;

/** 
 * 说明： 成员页面开发
 * 创建人：FH Q313596790
 * 创建时间：2017-07-03
 * @version
 */
@Service("projectmemberService")
public class ProjectMemberService implements ProjectMemberManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ProjectMemberMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ProjectMemberMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ProjectMemberMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ProjectMemberMapper.datalistPage", page);
	}
	/**项目成员列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> member(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProjectMemberMapper.proMember", pd);
	}
	
	/**项目成员列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listMember(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProjectMemberMapper.listMember", pd);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProjectMemberMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProjectMemberMapper.findById", pd);
	}
	
	@Override
	public List<String> findQuestionByType(String t) throws Exception {
		return (List<String>)dao.findForList("ProjectMemberMapper.findQuestionByType", t);
	}

	@Override
	public List<PageData> findAnswerByQuestion(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ProjectMemberMapper.findAnswerByQuestion", pd);
	}

	@Override
	public void saveev(PageData pd) throws Exception {
		dao.save("ProjectMemberMapper.saveev", pd);
	}
	@Override
	public void editEv(PageData pd) throws Exception {
		dao.update("ProjectMemberMapper.editEv", pd);
	}

	@Override
	public String findTypeByQuestion(String key) throws Exception {
		return (String)dao.findForObject("ProjectMemberMapper.findTypeByQuestion", key);
	}

	/**批量修改
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void editMemberAll(PageData pd)throws Exception{
		dao.update("ProjectMemberMapper.editMemberAll", pd);
	}
	/**
	 *  获取级别成本
	 */
	@Override
	public PageData getLevel(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("ProjectMemberMapper.getLevel", pd);
	}
	/**
	 *  是否有项目经理
	 */
	@Override
	public PageData hasM(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("ProjectMemberMapper.hasM", pd);
	}
	
	/**
	 *  空闲人员
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getFreeStaff(PageData pd) throws Exception {
		
		return (List<PageData>)dao.findForList("ProjectMemberMapper.freeStaff", pd);
	}

	
	/**闲置人员预订项目*/
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getunusedProject(Page page) throws Exception {
		
		return (List<PageData>)dao.findForList("StaffMapper.prolist", page);
	}
/**闲置人员预订项目*/
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getunusedProject(PageData pd) throws Exception {
		
		return (List<PageData>)dao.findForList("StaffMapper.prolistbtime", pd);
	}

	@Override
	public PageData findScoreById(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("ProjectMemberMapper.findScoreById", pd);
	}

	@Override
	public List<String> findType(PageData pd) throws Exception {
		return (List<String>)dao.findForList("ProjectMemberMapper.findType", pd);
		
	}

	@Override
	public PageData findAnswerById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("ProjectMemberMapper.findAnswerById", pd);
	}

	@Override
	public PageData findMark(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ProjectMemberMapper.findMark", pd);
	}
	@Override
	public PageData findManagerMark(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ProjectMemberMapper.findManagerMark", pd);
	}

	@Override
	public void deleteev(PageData pd) throws Exception {
		dao.delete("ProjectMemberMapper.deleteev", pd);
		
	}

	@Override
	public List<String> findAnswerId(PageData pd) throws Exception {
		return (List<String>)dao.findForList("ProjectMemberMapper.findAnswerId", pd);
	}


	/**闲置资源（人员）*/
	/*@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getUnusedStaffPage(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("ProjectMemberMapper.unusedStaffPage", pd);
	}
	*/

	
}

