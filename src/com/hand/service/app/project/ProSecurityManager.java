package com.hand.service.app.project;

import java.util.List;

import com.hand.entity.Page;
import com.hand.util.PageData;

public interface ProSecurityManager {

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception;

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception;

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(PageData pd) throws Exception;

	/**
	 * 修改PC状态
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editstate(PageData pd) throws Exception;

	/**
	 * 修改pc状态
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editpcstate(PageData pd) throws Exception;

	/**
	 * 修改pc状态为已入场
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void pcEntried(PageData pd) throws Exception;

	/**
	 * 修改pc状态为已退场
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void pcExited(PageData pd) throws Exception;

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page) throws Exception;

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listProsecurityleave(Page page) throws Exception;

	/**
	 * 列表(全部)
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd) throws Exception;

	/**
	 * 查询品管信息部人员
	 */
	public List<PageData> getFreeStaff(PageData pd) throws Exception;

	/**
	 * 查询品管信息部人员
	 */
	public List<PageData> getProStaff(PageData pd) throws Exception;

	/**
	 * 通过USER_ID查询品管信息部人员
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData staffuser(PageData pd) throws Exception;

	/**
	 * 查询USER_ID不为空的员工
	 */
	public List<PageData> getUseridStaff(PageData pd) throws Exception;

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception;

	/**
	 * 通过id获取退场负责人
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData exitid(PageData pd) throws Exception;

	/**
	 * 批量修改
	 * 
	 * @throws Exception
	 */
	public void editAll(PageData pd) throws Exception;

	/**
	 * 批量修改入场负责人
	 * 
	 * @throws Exception
	 */
	public void admissioneditAll(PageData pd) throws Exception;

	/**
	 * 批量修改入场负责人
	 * 
	 * @throws Exception
	 */
	public void exitditAll(PageData pd) throws Exception;

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS) throws Exception;

	/**
	 * 根据PC_LEAVEID获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByPcleaveid(PageData pd) throws Exception;

	public PageData findBypro(PageData pd) throws Exception;

	public PageData findbyPCstate(PageData pd) throws Exception;

	/**
	 * 根据PC_LEAVEID修改pc状态
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void updatePcStateByPcleaveId(PageData pd) throws Exception;

	/**
	 * 查找
	 * 
	 * @param pd
	 * @throws Exception
	 */

	public PageData getPcState(PageData pd) throws Exception;

	/**
	 * 根据pc编号修改在库情况-->
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editdepot(PageData pd) throws Exception;

	/**
	 * 查询applicant-->
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData getApplicant(PageData pd) throws Exception;

	/**
	 * 查询applicant-->
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData applicantname(PageData pd) throws Exception;

	/**
	 * 修改applicant
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editApplicant(PageData pd) throws Exception;

	public void delCheck(PageData pd) throws Exception;

	public PageData findByPcleaveitemid(PageData pd) throws Exception;

	public void updateItemidById(PageData pd) throws Exception;
}
