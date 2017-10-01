package com.hand.service.fhoa.staff;

import java.util.List;

import com.hand.entity.Page;
import com.hand.util.PageData;

/** 
 * 说明： 员工管理接口
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 * @version
 */
public interface StaffManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	public void saveev(PageData pd)throws Exception;
	
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
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editRole(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editByNo(PageData pd)throws Exception;
	
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
	
	/**通过findByUserId获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByUserId(PageData pd)throws Exception;
	
	/**通过No获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByNo(PageData pd)throws Exception;
	/**通过ID获取项目经理和项目总监名字
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByNo1(PageData pd)throws Exception;
	
	
	/**
	 * 通过邮箱获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByEmail(PageData pd) throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void editStaffAll(PageData pd)throws Exception;
	
	
	/**绑定用户
	 * @param pd
	 * @throws Exception
	 */
	public void userBinding(PageData pd)throws Exception;

	public void setDEPARTMENT_NAMES(PageData pd) throws Exception;
	public List<String> findType(PageData pd)throws Exception;
	public List<String> findQuestionByType(String t)throws Exception;
	public List<PageData> findAnswerByQuestion(PageData pd)throws Exception;
	public List<Page> findAnswerId(PageData pd)throws Exception;
	public PageData findAnswerById(PageData pd)throws Exception;
	public String findTypeByQuestion(String key)throws Exception;
	
	
	/**
	 * 获取员工平均分
	 */
	 public PageData findScoreById(PageData pd)throws Exception;

		/**更新薪资
		 * @param pd
		 * @throws Exception
		 */
		public void editMe(PageData pd)throws Exception;

		public PageData findTitleName(PageData pd) throws Exception;
		
		/**
		 * 获取员工角色
		 */
		 public List<PageData> findRoleById(String id)throws Exception;
	

}

