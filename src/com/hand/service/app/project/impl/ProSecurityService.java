package com.hand.service.app.project.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.service.app.project.ProSecurityManager;
import com.hand.util.PageData;

/**
 * 说明： 项目信息安全管理 创建人：FH Q313596790 创建时间：2017-08-23
 * 
 * @version
 */
@Service("prosecurityService")
public class ProSecurityService implements ProSecurityManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception {
		dao.save("ProjectSecurityMapper.save", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception {
		dao.delete("ProjectSecurityMapper.delete", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.edit", pd);
	}

	/**
	 * 修改状态
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editstate(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.editstate", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ProjectSecurityMapper.datalistPage", page);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listProsecurityleave(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ProjectSecurityMapper.listProsecurityleave", page);
	}

	/**
	 * 列表(全部)
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ProjectSecurityMapper.listAll", pd);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ProjectSecurityMapper.findById", pd);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findBypro(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ProjectSecurityMapper.findbypro", pd);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findbyPCstate(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ProjectSecurityMapper.findBypro", pd);
	}

	/**
	 * 批量删除
	 * 
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS) throws Exception {
		dao.delete("ProjectSecurityMapper.deleteAll", ArrayDATA_IDS);
	}

	/**
	 * 通过id获取退场负责人
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData exitid(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ProjectSecurityMapper.exitid", pd);
	}

	/**
	 * 批量修改入场负责人
	 * 
	 * @throws Exception
	 */
	public void admissioneditAll(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.admissioneditAll", pd);
	}

	/**
	 * 批量修改退场负责人
	 * 
	 * @throws Exception
	 */
	public void exitditAll(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.exitditAll", pd);
	}

	/**
	 * 批量修改
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void editAll(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.editAll", pd);
	}

	/**
	 * 根据PC_LEAVEID获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByPcleaveid(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ProjectSecurityMapper.findByPcleaveid", pd);
	}

	/**
	 * 根据PC_LEAVEID修改pc状态
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void updatePcStateByPcleaveId(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.updatePcStateByPcleaveId", pd);
	}

	@Override
	public void deleteAll(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.updateAll", pd);
	}

	/**
	 * 修改pc状态
	 */
	@Override
	public void editpcstate(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.editpcstate", pd);

	}

	/**
	 * 查找pcstate
	 */
	@Override
	public PageData getPcState(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ProjectSecurityMapper.getPcState", pd);
	}

	/**
	 * 修改pc状态为已入场
	 */
	@Override
	public void pcEntried(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.pcEntried", pd);

	}

	/**
	 * 修改pc状态为已退场
	 */
	@Override
	public void pcExited(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.pcExited", pd);

	}

	/**
	 * 查询品管信息部人员
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getFreeStaff(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ProjectSecurityMapper.freeStaff", pd);
	}

	/**
	 * 查询品管信息部人员
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getProStaff(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ProjectSecurityMapper.memberList", pd);
	}

	@Override
	public void delCheck(PageData pd) throws Exception {
		dao.update("CheckMapper.delcheck", pd);

	}

	/**
	 * 查询USER_ID不为空的员工
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getUseridStaff(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ProjectSecurityMapper.useridStaff", pd);
	}

	/**
	 * 通过USER_ID查询品管信息部人员
	 */
	@Override
	public PageData staffuser(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ProjectSecurityMapper.staffuser", pd);
	}

	/**
	 * 根据pc编号修改在库情况
	 */
	@Override
	public void editdepot(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.editdepot", pd);
	}

	/**
	 * 根据USER_ID查询名字
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public PageData getApplicant(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ProjectSecurityMapper.getApplicant", pd);
	}

	/**
	 * 修改applicant
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void editApplicant(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.editApplicant", pd);

	}

	/**
	 * 根据NAME查询名字
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData applicantname(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ProjectSecurityMapper.applicantname", pd);
	}

	/**
	 * 根据PC_LEAVE_ITEMID查找记录
	 */
	@Override
	public PageData findByPcleaveitemid(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ProjectSecurityMapper.findByPcleaveitemid", pd);
	}

	@Override
	public void updateItemidById(PageData pd) throws Exception {
		dao.update("ProjectSecurityMapper.updateItemidById", pd);
	}

}
