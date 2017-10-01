package com.hand.service.fhoa.staff.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.system.Department;
import com.hand.service.fhoa.department.DepartmentManager;
import com.hand.service.fhoa.staff.IdleStaffManager;
import com.hand.util.PageData;

@Service("idleStaffService")
public class IdleStaffService implements IdleStaffManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@Resource(name = "departmentService")
	private DepartmentManager departmentService;

	@Override
	public List<PageData> idleStaffList(PageData pd) throws Exception {
		List<PageData> idleStaffList = (List<PageData>) dao.findForList("StaffMapper.idleStaffList", pd);
		// 过滤字段
		List<PageData> myList = new ArrayList<PageData>();
		for (PageData staff : idleStaffList) {
			PageData myStaff = new PageData();
			myStaff.put("id", staff.get("STAFF_ID"));
			myStaff.put("NO", staff.get("NO"));
			String mome = staff.getString("MEMO");
			if ("".equals(mome) || mome == null) {
				myStaff.put("name", staff.get("NO") + " " + staff.getString("STAFFNAME"));
			} else {
				myStaff.put("name", staff.get("NO") + " " + staff.getString("STAFFNAME") + "(" + mome + ")");
			}
			myStaff.put("DEPARTMENT_ID", staff.get("DEPARTMENT_ID"));
			myStaff.put("icon", "static/images/user.gif");
			myList.add(myStaff);
		}
		return myList;
	}

	/**
	 * 获取所有的部门用于闲置资源树
	 * 
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public Map<String, PageData> listAllDepartmentToZtree(String parentId, Map<String, PageData> zdepartmentPdMap) throws Exception {
		Map<String, PageData>[] arrayDep = this.listAllbyPd(parentId, zdepartmentPdMap);
		Map<String, PageData> departmentPdMap = arrayDep[0];
		for (String key : departmentPdMap.keySet()) {
			this.listAllDepartmentToZtree(key, arrayDep[1]);
		}
		return arrayDep[1];
	}

	/**
	 * 下拉ztree用
	 * 
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, PageData>[] listAllbyPd(String parentId, Map<String, PageData> zdepartmentPdMap) throws Exception {
		List<Department> departmentList = this.listSubDepartmentByParentId(parentId);
		Map<String, PageData> departmentPdMap = new HashMap<String, PageData>();
		for (Department depar : departmentList) {
			PageData pd = new PageData();
			List<PageData> children = new ArrayList<PageData>();
			pd.put("id", depar.getDEPARTMENT_ID());
			pd.put("parentId", depar.getPARENT_ID());
			pd.put("dname", depar.getNAME());
			pd.put("children", children);
			pd.put("isParent", true); // 显示时是否为父节点
			pd.put("totalStaff", 0); // 部门员工总数
			pd.put("open", true); // 显示时是否展开
			pd.put("hasChildrenDept", false); // 是否有子部门
			List<PageData> childrenDepts = new ArrayList<PageData>();
			pd.put("childrenDepts", childrenDepts);
			pd.put("icon", "plugins/zTree_v3/css/zTreeStyle/img/diy/1_open.png");
			departmentPdMap.put(depar.getDEPARTMENT_ID(), pd);
			zdepartmentPdMap.put(depar.getDEPARTMENT_ID(), pd);
		}
		Map<String, PageData>[] arrayDep = new HashMap[2];
		arrayDep[0] = departmentPdMap;
		arrayDep[1] = zdepartmentPdMap;
		return arrayDep;
	}

	/**
	 * 通过ID获取其子级列表
	 * 
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Department> listSubDepartmentByParentId(String parentId) throws Exception {
		return (List<Department>) dao.findForList("DepartmentMapper.listSubDepartmentByParentId", parentId);
	}

	@Override
	public void staffRemarkEdit(PageData pd) throws Exception {
		dao.update("EdleStaffMapper.updateRemark", pd);
	}

}
