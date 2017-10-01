package com.hand.service.app.project;


import java.util.List;

import com.hand.entity.Page;
import com.hand.util.PageData;

/** 
 * 说明： 成员页面开发接口
 * 创建时间：2017-07-03
 * @version
 */
public interface ProjectMemberManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	public void saveev(PageData pd)throws Exception;
	
	public void editEv(PageData pd)throws Exception;
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	public void deleteev(PageData pd)throws Exception;
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
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listMember(PageData pd)throws Exception;
	/**
	 * 单个项目成员
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	
	public List<PageData> member(PageData pd)throws Exception;
	
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
	
	/**
	 * 获取员工平均分
	 */
	 public PageData findScoreById(PageData pd)throws Exception;
	
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void editMemberAll(PageData pd)throws Exception;
	/**
	 * 获得级别成本
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	
	public PageData getLevel(PageData pd)throws Exception;
	
	/**
	 * 查询空闲员工
	 */
	public List<PageData> getFreeStaff(PageData pd)throws Exception;
	/*
	 * 项目是否有项目经理
	 */
	public PageData hasM(PageData pd)throws Exception;
	
	
	/**
	 * 查询闲置资源
	 */
	/*public List<PageData> getUnusedStaffPage(PageData pd)throws Exception;*/
	
	
	
	
	/**空闲员工预订项目列表*/
	public List<PageData> getunusedProject(Page page)throws Exception;

	public List<String> findType(PageData pd)throws Exception;
	public List<String> findQuestionByType(String t)throws Exception;
	public List<PageData> findAnswerByQuestion(PageData pd)throws Exception;
	public PageData findMark(PageData pd)throws Exception;
	public PageData findManagerMark(PageData pd)throws Exception;
	public String findTypeByQuestion(String key)throws Exception;
	public List<String> findAnswerId(PageData pd)throws Exception;
	public PageData findAnswerById(PageData pd)throws Exception;

	List<PageData> getunusedProject(PageData pd) throws Exception;


}

