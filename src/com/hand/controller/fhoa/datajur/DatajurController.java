package com.hand.controller.fhoa.datajur;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.service.fhoa.datajur.DatajurManager;
import com.hand.service.fhoa.department.DepartmentManager;
import com.hand.service.fhoa.staff.StaffManager;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;

/** 
 * 说明：组织数据权限表
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 */
@Controller
@RequestMapping(value="/datajur")
public class DatajurController extends BaseController {
	
	String menuUrl = "datajur/list.do"; //菜单地址(权限用)
	@Resource(name="datajurService")
	private DatajurManager datajurService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="staffService")
	private StaffManager staffService;
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Datajur");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("DEPARTMENT_IDS", departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID")));		//部门ID集
		datajurService.edit(pd);
		String DEPARTMENT_ID = pd.getString("DEPARTMENT_ID");
		String STAFF_ID = pd.getString("DATAJUR_ID");
		pd.put("STAFF_ID", STAFF_ID);
		PageData staff = staffService.findById(pd);
		String DEPARTMENT_ID1 = staff.getString("DEPARTMENT_ID");
		if(!DEPARTMENT_ID.equals(DEPARTMENT_ID1)){
			String DEPARTMENT_NAMES = departmentService.getDEPARTMENT_NAMES(DEPARTMENT_ID);
			pd.put("DEPARTMENT_NAMES", DEPARTMENT_NAMES);
		}else{
			pd.put("DEPARTMENT_NAMES", staff.getString("DEPARTMENT_NAMES"));
		}
		staffService.setDEPARTMENT_NAMES(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> zdepartmentPdList = new ArrayList<PageData>();
		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect(Jurisdiction.getDEPARTMENT_ID(),zdepartmentPdList));
		mv.addObject("zTreeNodes", (null == arr ?"":arr.toString()));
		pd = datajurService.findById(pd);	//根据ID读取
		mv.addObject("DATAJUR_ID", pd.getString("DATAJUR_ID"));
		pd = departmentService.findById(pd);//读取部门数据(用部门名称)
		mv.setViewName("fhoa/datajur/datajur_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
