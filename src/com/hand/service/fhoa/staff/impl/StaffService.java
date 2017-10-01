package com.hand.service.fhoa.staff.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.service.fhoa.staff.StaffManager;
import com.hand.util.PageData;

/** 
 * 说明： 员工管理
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 * @version
 */
@Service("staffService")
public class StaffService implements StaffManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("StaffMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("StaffMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("StaffMapper.edit", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editRole(PageData pd)throws Exception{
		dao.update("StaffMapper.editRole", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editByNo(PageData pd)throws Exception{
		dao.update("StaffMapper.editByNo", pd);
	}
	
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("StaffMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("StaffMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("StaffMapper.findById", pd);
	}
	
	/**通过findByUserId获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByUserId(PageData pd)throws Exception{
		return (PageData)dao.findForObject("StaffMapper.findByUserId", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByNo(PageData pd)throws Exception{
		return (PageData)dao.findForObject("StaffMapper.findByNo", pd);
	}
	
	/**通过ID获取项目经理和项目总监名字
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findByNo1(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("StaffMapper.findByNo1", pd);
	}

	
	/**
	 * 通过邮箱获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByEmail(PageData pd) throws Exception {
		return (PageData) dao.findForObject("StaffMapper.findByEmail", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("StaffMapper.deleteAll", ArrayDATA_IDS);
	}
	
	/**批量修改
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void editStaffAll(PageData pd)throws Exception{
		dao.update("StaffMapper.editAll", pd);
	}
	
	/**绑定用户
	 * @param pd
	 * @throws Exception
	 */
	public void userBinding(PageData pd)throws Exception{
		dao.update("StaffMapper.userBinding", pd);
	}

	@Override
	public void setDEPARTMENT_NAMES(PageData pd) throws Exception {
		dao.update("StaffMapper.updateDepartNames",pd);
	}

	@Override
	public List<String> findType(PageData pd) throws Exception {
		return (List<String>)dao.findForList("StaffMapper.findType", pd);
		
	}

	@Override
	public List<String> findQuestionByType(String t) throws Exception {
		return (List<String>)dao.findForList("StaffMapper.findQuestionByType", t);
	}

	@Override
	public List<PageData> findAnswerByQuestion(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("StaffMapper.findAnswerByQuestion", pd);
	}

	@Override
	public void saveev(PageData pd) throws Exception {
		dao.save("StaffMapper.saveev", pd);
	}

	@Override
	public String findTypeByQuestion(String key) throws Exception {
		return (String)dao.findForObject("StaffMapper.findTypeByQuestion", key);
	}

	@Override
	public PageData findScoreById(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("StaffMapper.findScoreById", pd);
	}
	@Override
	public void editMe(PageData pd) throws Exception {//修改备注
		dao.update("StaffMapper.editMe", pd);
		
	}
	@Override
	public PageData findTitleName(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("StaffMapper.findTitleName", pd);
	}
	
	/**
	 * 获取员工角色
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findRoleById(String id) throws Exception {
		return (List<PageData>)dao.findForList("StaffMapper.findRoleById", id);
	}

	@Override
	public void deleteev(PageData pd) throws Exception {
		dao.delete("StaffMapper.deleteev", pd);
	}

	@Override
	public List<Page> findAnswerId(PageData pd) throws Exception {
		return (List<Page>)dao.findForList("StaffMapper.findAnswerId", pd);
	}

	@Override
	public PageData findAnswerById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("StaffMapper.findAnswerById", pd);
	}

	
}

