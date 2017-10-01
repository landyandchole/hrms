package com.hand.controller.fhoa.staff;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.service.app.project.ProjectMemberManager;
import com.hand.service.fhoa.datajur.DatajurManager;
import com.hand.service.fhoa.department.DepartmentManager;
import com.hand.service.fhoa.staff.SalaryManager;
import com.hand.service.fhoa.staff.StaffManager;
import com.hand.service.system.appuser.AppuserManager;
import com.hand.service.system.dictionaries.DictionariesManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.util.Const;
import com.hand.util.FileDownload;
import com.hand.util.FileUpload;
import com.hand.util.Jurisdiction;
import com.hand.util.ObjectExcelRead;
import com.hand.util.PageData;
import com.hand.util.PathUtil;

import net.sf.json.JSONArray;

@Controller
@RequestMapping(value = "/salary")
public class SalaryController extends BaseController {

	String menuUrl = "salary/list.do"; // 菜单地址(权限用)
	@Resource(name = "staffService")
	private StaffManager staffService;
	@Resource(name = "departmentService")
	private DepartmentManager departmentService;
	@Resource(name = "datajurService")
	private DatajurManager datajurService;
	@Resource(name = "dictionariesService")
	private DictionariesManager dictionariesService;
	@Resource(name = "fhlogService")
	private FHlogManager FHLOG;
	@Resource(name = "projectmemberService")
	private ProjectMemberManager projectMemberService;
	@Resource(name = "appuserService")
	private AppuserManager appuserService;
	@Resource(name = "salaryService")
	private SalaryManager salaryService;

	/**
	 * 去薪资列表页面
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView salaryList(Page page) throws Exception {

		logBefore(logger, Jurisdiction.getUsername() + "列表Salary");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String DEPARTMENT_ID = pd.getString("DEPARTMENT_ID");
		// pd.put("DEPARTMENT_ID", null == DEPARTMENT_ID?"0":DEPARTMENT_ID);
		if ("0".equals(DEPARTMENT_ID)) {
			DEPARTMENT_ID = null;
			pd.put("DEPARTMENT_ID", null);
		} else {
			pd.put("DEPARTMENT_ID", null == DEPARTMENT_ID ? "d41af567914a409893d011aa53eda797" : DEPARTMENT_ID);
		}
		pd.put("item", (null == pd.getString("DEPARTMENT_ID") ? Jurisdiction.getDEPARTMENT_IDS() : departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID")))); // 部门检索条件,列出此部门下级所属部门的员工
		if (DEPARTMENT_ID != null) {
			String Temp = pd.getString("item");
			Temp = Temp.replace(")", "");
			Temp = Temp + "," + "\'" + DEPARTMENT_ID + "\'" + ")";
			pd.put("item", Temp);
		}
		page.setPd(pd);
		// page.setShowCount(8);
		List<PageData> varList = salaryService.datalistPage(page); // 列出Salary列表
		// 列表页面树形下拉框用(保持下拉树里面的数据不变)
		String ZDEPARTMENT_ID = pd.getString("ZDEPARTMENT_ID");
		pd.put("ZDEPARTMENT_ID", ZDEPARTMENT_ID);
		List<PageData> zdepartmentPdList = new ArrayList<PageData>();
		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect("0", zdepartmentPdList));
		mv.addObject("zTreeNodes", arr.toString());
		PageData dpd = departmentService.findById(pd);
		if (null != dpd) {
			ZDEPARTMENT_ID = dpd.getString("NAME");
		}
		PageData pda = new PageData();
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		pda.put("username", username);
		mv.addObject("pda", pda);
		mv.addObject("depname", ZDEPARTMENT_ID);
		mv.setViewName("fhoa/salary/salary_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 去薪资修改页面
	 * 
	 * @param
	 * @throws Exception
	 */

	@RequestMapping(value = "/goSalaryEdit")
	public ModelAndView goSalaryEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String s = pd.getString("NO");
		if (s.contains(",")) {
			mv.addObject("msg", "editAll");
			pd.put("msg", "薪资浮动");
		} else {
			PageData sal = salaryService.querySalary(pd);
			if (null != sal) {
				mv.addObject("msg", "editSalary");
				pd.put("msg", "薪资修改");
			} else {
				mv.addObject("msg", "saveSalary");
				pd.put("msg", "薪资新增");
			}
		}
		mv.addObject("pd", pd);
		mv.setViewName("fhoa/salary/salary_edit");
		return mv;
	}

	/**
	 * 薪资新增
	 * 
	 * @param
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/saveSalary")
	public ModelAndView saveSalary() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增员工薪资");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String salary = pd.getString("SALARY");
		pd.put("SALARY_ID", this.get32UUID()); // 主键
		salaryService.saveSalary(pd);
		FHLOG.save(Jurisdiction.getUsername(), "员工薪资新增","OA_SALARY","SALARY_ID",pd.getString("SALARY_ID"));
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 薪资修改
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/editSalary")
	public ModelAndView editSalary(HttpServletRequest request) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改薪资");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		salaryService.editSalary(pd);
		FHLOG.save(Jurisdiction.getUsername(), "员工薪资修改","OA_SALARY","NO",pd.getString("NO"));
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 批量修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/editAll")
	@ResponseBody
	public ModelAndView editAll(HttpServletRequest request) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "批量修改");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		String DATA_IDS = pd.getString("NO");
		String SALARY = pd.getString("SALARY");
		String[] NO = pd.getString("NO").split(",");
		for (int i = 0; i < NO.length; i++) {
			pd.put("NO", NO[i]);
			PageData sal = salaryService.querySalary(pd);
			if (null != sal) {
				salaryService.editAll(pd);
			} else {
				pd.put("SALARY_ID", this.get32UUID()); // 主键
				salaryService.saveSalary(pd);
			}
		}
		FHLOG.save(Jurisdiction.getUsername(), "员工薪资批量修改","OA_SALARY","NO",pd.getString("NO"));
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 打开上传EXCEL页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goUploadExcel")
	public ModelAndView goUploadExcel() throws Exception {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("fhoa/salary/salary_upload");
		return mv;
	}

	/**
	 * 下载模版
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/downExcel")
	public void downExcel(HttpServletResponse response) throws Exception {
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "Salarys.xls", "Salarys.xls");
	}

	/**
	 * 从EXCEL导入到数据库
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/readExcel")
	public ModelAndView readExcel(@RequestParam(value = "excel", required = false) MultipartFile file) throws Exception {
		FHLOG.save(Jurisdiction.getUsername(), "从EXCEL导入到数据库","","","");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
			String fileName = FileUpload.fileUp(file, filePath, "salaryexcel"); // 执行上传
			List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0); // 执行读EXCEL操作,读出的数据导入List
																									// 2:从第3行开始；0:从第A列开始；0:第0个sheet
			for (int i = 0; i < listPd.size(); i++) {
				pd.put("SALARY_ID", this.get32UUID()); // ID
				pd.put("NO", listPd.get(i).getString("var0"));
				pd.put("SALARY", listPd.get(i).getString("var2"));
				if (salaryService.querySalary(pd) != null) {
					salaryService.editSalary(pd);
				} else {
					salaryService.saveSalary(pd);
				}
			}
			/* 存入数据库操作====================================== */
			mv.addObject("msg", "success");
		}
		mv.setViewName("save_result");
		return mv;
	}

}
