package com.hand.service.fhoa.staff;

import java.util.List;
import java.util.Map;

import com.hand.util.PageData;

/**
 * 闲置资源管理接口
 */
public interface IdleStaffManager {

	/**
	 * 根据空闲时间查询空闲资源
	 */
	public List<PageData> idleStaffList(PageData pd) throws Exception;

	/**
	 * 获取所有的部门用于闲置资源树
	 */
	public Map<String, PageData> listAllDepartmentToZtree(String parentId, Map<String, PageData> zdepartmentPdMap) throws Exception;

	/**
	 * 修改员工备注
	 */
	public void staffRemarkEdit(PageData pd) throws Exception;
}
