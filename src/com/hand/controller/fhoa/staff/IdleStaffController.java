package com.hand.controller.fhoa.staff;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.service.fhoa.department.DepartmentManager;
import com.hand.service.fhoa.staff.IdleStaffManager;
import com.hand.service.fhoa.staff.StaffManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;

@Controller
@RequestMapping(value = "/idleStaff")
public class IdleStaffController extends BaseController {

	@Resource(name = "idleStaffService")
	private IdleStaffManager idleStaffService;
	@Resource(name = "departmentService")
	private DepartmentManager departmentService;
	@Resource(name = "staffService")
	private StaffManager staffService;
	@Resource(name = "fhlogService")
	private FHlogManager FHLOG;

	@RequestMapping(value = "goStaffRemarkEdit")
	public ModelAndView goStaffRemarkEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		// 获取员工信息
		PageData staff = staffService.findById(pd);
		mv.addObject("pd", staff);
		mv.setViewName("fhoa/staff/staff_remark_edit");
		return mv;
	}

	@RequestMapping(value = "staffRemarkEdit")
	public ModelAndView staffRemarkEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		// 修改员工信息
		idleStaffService.staffRemarkEdit(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		FHLOG.save(Jurisdiction.getUsername(), "修改员工备注", "OA_STAFF", "STAFF_ID", pd.getString("STAFF_ID"));
		return mv;
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "idleStaffList")
	private Object idleStaffList() throws Exception {
		Session session = Jurisdiction.getSession();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		PageData pd = new PageData();
		pd = this.getPageData();
		if (pd.getString("FREETIME") == "" || pd.getString("FREETIME") == null) {
			pd.put("FREETIME", sdf.format(new Date()));
		} else {
			pd.put("FREETIME", pd.getString("FREETIME"));
		}
		List<PageData> idleStaffList = idleStaffService.idleStaffList(pd);

		// 将空闲时间存入session
		session.setAttribute("idleDate", pd.getString("FREETIME"));

		// 查找出所有的部门
		Map<String, PageData> zdepartmentPdMap = new HashMap<String, PageData>();
		Map<String, PageData> departmentMap = idleStaffService.listAllDepartmentToZtree("0", zdepartmentPdMap);

		// 将所有的空闲员工按部门分配
		Iterator<PageData> iterator = idleStaffList.iterator();
		while (iterator.hasNext()) {
			PageData idleStaff = iterator.next();
			// 向部门中添加员工
			PageData department = departmentMap.get(idleStaff.getString("DEPARTMENT_ID"));
			if (department != null) {
				List<PageData> childrens = (List<PageData>) department.get("children");
				// 增加部门员工的总数
				int totalStaff = (int) department.get("totalStaff");
				department.put("totalStaff", ++totalStaff);
				childrens.add(idleStaff);
			}
		}

		// 将部门关联起来
		PageData rootDept = null;
		Set<String> keys = departmentMap.keySet();
		for (String departmentId : keys) {
			PageData dept = departmentMap.get(departmentId);
			String parentId = dept.getString("parentId");
			if ("0".equals(parentId)) {
				dept.put("name", dept.getString("name") + " （" + dept.get("totalStaff") + "）");
				rootDept = dept;
				continue;
			}
			PageData pdept = departmentMap.get(parentId);
			// 如果父部门为海外事业本部的时候
			if ("0".equals(pdept.getString("parentId"))) {
				if ("项目经理组".equals(dept.getString("dname"))) {
					dept.put("sort", 2);
				} else if ("第一本部".equals(dept.getString("dname"))) {
					dept.put("sort", 3);
				} else if ("第二本部".equals(dept.getString("dname"))) {
					dept.put("sort", 4);
				} else if ("第三本部".equals(dept.getString("dname"))) {
					dept.put("sort", 5);
				} else {
					dept.put("sort", 6);
				}
			}

			List<PageData> pchildren = (List<PageData>) pdept.get("children");
			pchildren.add(dept);
			List<PageData> pchildrenDepts = (List<PageData>) pdept.get("childrenDepts");
			pchildrenDepts.add(dept);
			// 设置父部门是否有子部门
			pdept.put("hasChildrenDept", true);
		}

		// 将海外事业部下面的部门进行排序
		List<PageData> rootChildren = (List<PageData>) rootDept.get("children");
		Collections.sort(rootChildren, new sortComparator());

		setIdleNumber(rootDept, null);

		return rootDept;
	}

	// 递归设置部门空闲员工总数
	private void setIdleNumber(PageData rootDept, PageData parentDept) {
		rootDept.put("name", rootDept.getString("dname") + " [" + rootDept.get("totalStaff") + "人]");
		// 如果没有子部门
		if (!(boolean) rootDept.get("hasChildrenDept")) {
			// 增加父部门的空闲人数
			int pTotalStaff = (int) parentDept.get("totalStaff");
			int rTotalStaff = (int) rootDept.get("totalStaff");
			parentDept.put("totalStaff", pTotalStaff + rTotalStaff);
			parentDept.put("name", parentDept.getString("dname") + " [" + parentDept.get("totalStaff") + "人]");
			return;
		}

		// 如果有子部门
		List<PageData> childrenDepts = (List<PageData>) rootDept.get("childrenDepts");
		for (PageData childrenDept : childrenDepts) {
			setIdleNumber(childrenDept, rootDept);
		}
		// 增加父部门的空闲人数
		if (parentDept != null) {
			int pTotalStaff = (int) parentDept.get("totalStaff");
			int rTotalStaff = (int) rootDept.get("totalStaff");
			parentDept.put("totalStaff", pTotalStaff + rTotalStaff);
			parentDept.put("name", parentDept.getString("dname") + " [" + parentDept.get("totalStaff") + "人]");
		}
	}

	//
	class sortComparator implements Comparator {
		@Override
		public int compare(Object o1, Object o2) {
			Map<String, Object> oo1 = (Map<String, Object>) o1;
			Map<String, Object> oo2 = (Map<String, Object>) o2;
			int sort1 = (int) oo1.get("sort");
			int sort2 = (int) oo2.get("sort");
			int result = sort1 - sort2;
			return result;
		}
	}

}
