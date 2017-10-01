package com.hand.controller.fhoa.staff;

import java.io.File;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.entity.system.Role;
import com.hand.entity.system.User;
import com.hand.service.app.project.ProjectMemberManager;
import com.hand.service.fhoa.datajur.DatajurManager;
import com.hand.service.fhoa.department.DepartmentManager;
import com.hand.service.fhoa.staff.IdleStaffManager;
import com.hand.service.fhoa.staff.StaffManager;
import com.hand.service.system.appuser.AppuserManager;
import com.hand.service.system.dictionaries.DictionariesManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.service.system.user.UserManager;
import com.hand.util.AppUtil;
import com.hand.util.Const;
import com.hand.util.FileDownload;
import com.hand.util.FileUpload;
import com.hand.util.GetPinyin;
import com.hand.util.Jurisdiction;
import com.hand.util.MD5;
import com.hand.util.NameToId;
import com.hand.util.ObjectExcelRead;
import com.hand.util.ObjectExcelView;
import com.hand.util.PageData;
import com.hand.util.PathUtil;
import com.hand.util.Tools;

/** 
 * 说明：员工管理
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 */
@Controller
@RequestMapping(value="/staff")
public class StaffController extends BaseController {
	
	String menuUrl = "staff/list.do"; //菜单地址(权限用)
	@Resource(name="staffService")
	private StaffManager staffService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="datajurService")
	private DatajurManager datajurService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="projectmemberService")
	private ProjectMemberManager projectMemberService;
	@Resource(name = "appuserService")
	private AppuserManager appuserService;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		Session session = Jurisdiction.getSession();
		boolean flag = flag();
		if(flag == true){
			logBefore(logger, Jurisdiction.getUsername()+"新增Staff");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			if (pd.getString("ENTRY_DATE").equals("")) {
				pd.put("ENTRY_DATE", null);
			}
			if (pd.getString("GRADUATE_DATE").equals("")) {
				pd.put("GRADUATE_DATE", null);
			}
			if (pd.getString("LEAVE_DATE").equals("")) {
				pd.put("LEAVE_DATE", null);
			}
			if (pd.getString("BACKSCHOOL_DATE").equals("")) {
				pd.put("BACKSCHOOL_DATE", null);
			}
			if (pd.getString("BACKCOMPANY_DATE").equals("")) {
				pd.put("BACKCOMPANY_DATE", null);
			}
			if (pd.getString("PASS_TERM").equals("")) {
				pd.put("PASS_TERM", null);
			}	
					
			pd.put("STAFF_ID", this.get32UUID());	//主键
			pd.put("USER_ID", pd.getString("NO"));					//绑定账号ID
			String DEPARTMENT_NAMES = departmentService.getDEPARTMENT_NAMES(pd.getString("DEPARTMENT_ID"));
			pd.put("DEPARTMENT_NAMES", DEPARTMENT_NAMES);
			pd.put("FLAG","0");
			Date date=new Date();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
			String update=sdf.format(date);	
			String username = (String) session.getAttribute(Const.SESSION_USERNAME);
			pd.put("CREATIONDATE",update);
			pd.put("CREATIONUSER",username);
			staffService.save(pd);					//保存员工信息到员工表
			saveC(pd);
			/*if (!pd.getString("USER_ID").equals("")|| !pd.getString("USER_ID").equals(null)) {
				pd.put("USERNAME", pd.getString("USER_ID"));
				pd.put("TITLE", pd.getString("STATUS"));
				String USERSTATUS = staffService.findTitleName(pd).getString("TITLENAME");
				if (USERSTATUS.equals("离职")) {
					pd.put("USERSTATUS", USERSTATUS);
				} else {
					pd.put("USTATUS", USERSTATUS);
				}
				if (!"".equals(pd.getString(""))) {
					staffService.editRole(pd);
				}
			}*/
			FHLOG.save(Jurisdiction.getUsername(), "新增员工","OA_STAFF","NO",pd.get("NO").toString());
			String DEPARTMENT_IDS = departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID"));//获取某个部门所有下级部门ID
			pd.put("DATAJUR_ID", pd.getString("STAFF_ID")); //主键
			pd.put("DEPARTMENT_IDS", DEPARTMENT_IDS);		//部门ID集
			datajurService.save(pd);						//把此员工默认部门及以下部门ID保存到组织数据权限表
			mv.addObject("msg","success");
			mv.setViewName("save_result");
			return mv;
		}
		return null;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		boolean flag = flag();
		Session session = Jurisdiction.getSession();
		if(flag == true){
			logBefore(logger, Jurisdiction.getUsername()+"删除Staff");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
			PageData pd = new PageData();
			pd = this.getPageData();
			PageData staff = staffService.findById(pd);
			staff.put("STAFFNAME", staff.get("NAME"));
			staff.put("FLAG","1");
		    Date date=new Date();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
			String update=sdf.format(date);	
			String username = (String) session.getAttribute(Const.SESSION_USERNAME);
			staff.put("UPDATEDATE",update);
			staff.put("UPDATEUSER",username);
			staffService.edit(staff);
			FHLOG.save(Jurisdiction.getUsername(), "删除员工","OA_STAFF","NO",staff.get("NO").toString());
			//staffService.delete(pd);
			out.write("success");
			out.close();
		}
	}
	
	/**判断工号是否存在
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/hasU")
	@ResponseBody
	public Object hasU() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData no = staffService.findByNo(pd);
		try{
			if(null != no){
				errInfo = "error";				
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
	/**
	 * 判断邮箱是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/hasE")
	@ResponseBody
	public Object hasE() {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			if (staffService.findByEmail(pd) != null) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		boolean flag = flag();
		Session session = Jurisdiction.getSession();
		if(flag == true){
			logBefore(logger, Jurisdiction.getUsername()+"修改Staff");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			if(!pd.getString("USER_ID").equals("") || !pd.getString("USER_ID").equals(null)){
				pd.put("USERNAME", pd.getString("USER_ID"));
				if(!pd.getString("STAFFTITLE").equals(pd.getString("TITLE"))){
					pd.put("DICTIONARIES_ID", pd.getString("TITLE"));
					String s=dictionariesService.findById(pd).getString("NAME");
					String[] str_string = s.split("\\d");
					pd.put("DEPARTMENT_NAMES", str_string[0]);
				}				
			}
			if (pd.getString("ENTRY_DATE").equals("")) {
				pd.put("ENTRY_DATE", null);
			}
			if (pd.getString("GRADUATE_DATE").equals("")) {
				pd.put("GRADUATE_DATE", null);
			}
			if (pd.getString("LEAVE_DATE").equals("")) {
				pd.put("LEAVE_DATE", null);
			}
			if (pd.getString("BACKSCHOOL_DATE").equals("")) {
				pd.put("BACKSCHOOL_DATE", null);
			}
			if (pd.getString("BACKCOMPANY_DATE").equals("")) {
				pd.put("BACKCOMPANY_DATE", null);
			}
			if (pd.getString("PASS_TERM").equals("")) {
				pd.put("PASS_TERM", null);
			}
			if(pd.getString("STATUS").equals("49aabbb9c9f6442cbf2f6d8849d68202")){
				PageData pda = new PageData();
				pda.put("USERNAME", pd.getString("USERNAME"));
				pda.put("STATUS", "0");
				 staffService.editRole(pda);
			}else{
				PageData pda = new PageData();
				pda.put("USERNAME", pd.getString("USERNAME"));
				pda.put("STATUS", "1");
				 staffService.editRole(pda);
			}
			String DEPARTMENT_ID = pd.getString("DEPARTMENT_ID");
			PageData staff = staffService.findById(pd);
			String DEPARTMENT_ID1 = staff.getString("DEPARTMENT_ID");
			if(!DEPARTMENT_ID.equals(DEPARTMENT_ID1)){
				String DEPARTMENT_NAMES = departmentService.getDEPARTMENT_NAMES(DEPARTMENT_ID);
				pd.put("DEPARTMENT_NAMES", DEPARTMENT_NAMES);
			}else{
				pd.put("DEPARTMENT_NAMES", staff.getString("DEPARTMENT_NAMES"));
			}
			Date date=new Date();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
			String update=sdf.format(date);	
			String username = (String) session.getAttribute(Const.SESSION_USERNAME);
			pd.put("FLAG","0");
			pd.put("UPDATEDATE",update);
			pd.put("UPDATEUSER",username);
			staffService.edit(pd);
			String DEPARTMENT_IDS = departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID"));//获取某个部门所有下级部门ID
			pd.put("DATAJUR_ID", pd.getString("STAFF_ID")); //主键
			pd.put("DEPARTMENT_IDS", DEPARTMENT_IDS);		//部门ID集
			datajurService.edit(pd);						//把此员工默认部门及以下部门ID保存到组织数据权限表
			FHLOG.save(Jurisdiction.getUsername(), "修改员工","OA_STAFF","NO",pd.get("NO").toString());
			mv.addObject("msg","success");
			mv.setViewName("save_result");
			return mv;
		}
		return null;
	}
	
	/**列表(检索条件中的部门，只列出此操作用户最高部门权限以下所有部门的员工)
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		
		logBefore(logger, Jurisdiction.getUsername()+"列表Staff");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String DEPARTMENT_ID = pd.getString("DEPARTMENT_ID");
		if("0".equals(DEPARTMENT_ID)){
			DEPARTMENT_ID = null;
			pd.put("DEPARTMENT_ID", null);
		}else{
			pd.put("DEPARTMENT_ID", null == DEPARTMENT_ID?"d41af567914a409893d011aa53eda797":DEPARTMENT_ID);
		}
		
//		pd.put("DEPARTMENT_ID", null == DEPARTMENT_ID?Jurisdiction.getDEPARTMENT_ID():DEPARTMENT_ID);	//只有检索条件穿过值时，才不为null,否则读取缓存
		
		
		pd.put("item", (null == pd.getString("DEPARTMENT_ID")?Jurisdiction.getDEPARTMENT_IDS():departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID"))));	//部门检索条件,列出此部门下级所属部门的员工
//		pd.put("item", departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID")));	//部门检索条件,列出此部门下级所属部门的员工
		
//		pd.put("item",Jurisdiction.getDEPARTMENT_ID());
		if(DEPARTMENT_ID != null){
			String Temp = pd.getString("item");
			Temp = Temp.replace(")", "");
			Temp = Temp + ","+ "\'" + DEPARTMENT_ID + "\'" + ")";
			pd.put("item", Temp);
		}

		/* 比如员工 张三 所有部门权限的部门为 A ， A 的下级有  C , D ,F ，那么当部门检索条件值为A时，只列出A以下部门的员工(自己不能修改自己的信息，只能上级部门修改)，不列出部门为A的员工，当部门检索条件值为C时，可以列出C及C以下员工 */
//		if(!(null == DEPARTMENT_ID || DEPARTMENT_ID.equals(Jurisdiction.getDEPARTMENT_ID()))){
//			pd.put("item", pd.getString("item").replaceFirst("\\(", "\\('"+DEPARTMENT_ID+"',"));
//		}
		
		page.setPd(pd);	
		List<PageData>	varList = staffService.list(page);					//列出Staff列表
		//列表页面树形下拉框用(保持下拉树里面的数据不变)
		String ZDEPARTMENT_ID = pd.getString("ZDEPARTMENT_ID");
//		ZDEPARTMENT_ID = Tools.notEmpty(ZDEPARTMENT_ID)?ZDEPARTMENT_ID:Jurisdiction.getDEPARTMENT_ID();
//		ZDEPARTMENT_ID = Tools.notEmpty(ZDEPARTMENT_ID)?ZDEPARTMENT_ID:"0";
		pd.put("ZDEPARTMENT_ID", ZDEPARTMENT_ID);
		List<PageData> zdepartmentPdList = new ArrayList<PageData>();
		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect("0",zdepartmentPdList));
		mv.addObject("zTreeNodes", arr.toString());
		PageData dpd = departmentService.findById(pd);
		if(null != dpd){
			ZDEPARTMENT_ID = dpd.getString("NAME");
		}
		PageData pda = new PageData();
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		pda.put("username", username);
		mv.addObject("pda",pda);		
		mv.addObject("depname", ZDEPARTMENT_ID);
		mv.setViewName("fhoa/staff/staff_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> zdepartmentPdList = new ArrayList<PageData>();
//		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect(Jurisdiction.getDEPARTMENT_ID(),zdepartmentPdList));
		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect("0",zdepartmentPdList));
		mv.addObject("zTreeNodes", (null == arr ?"":arr.toString()));
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		mv.setViewName("fhoa/staff/staff_edit");
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
//		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect(Jurisdiction.getDEPARTMENT_ID(),zdepartmentPdList));
		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect("0",zdepartmentPdList));
		mv.addObject("zTreeNodes", (null == arr ?"":arr.toString()));
		pd = staffService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/staff/staff_edit");
		PageData pa = new PageData();
		pa = departmentService.findById(pd);
		if(pa != null){
			mv.addObject("depname", departmentService.findById(pd).getString("NAME"));
		}
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	/**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditlook")
	public ModelAndView goEditlook()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> zdepartmentPdList = new ArrayList<PageData>();
//		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect(Jurisdiction.getDEPARTMENT_ID(),zdepartmentPdList));
		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect("0",zdepartmentPdList));
		mv.addObject("zTreeNodes", (null == arr ?"":arr.toString()));
		pd = staffService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/staff/staff_lookedit");
		mv.addObject("depname", departmentService.findById(pd).getString("NAME"));
		mv.addObject("pd", pd);
		return mv;
	}	
	

	/**去闲置人员查询页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/staffunuselist")
	public ModelAndView nuuseStaff(Page page)throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Staff");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		PageData pd = new PageData();
		pd = this.getPageData();
		System.out.println(pd.getString("FREETIME"));
		if("".equals(pd.getString("FREETIME")) || pd.getString("FREETIME")==null){
			pd.put("FREETIME", sdf.format(new Date()));
		}else{
			pd.put("FREETIME", pd.getString("FREETIME"));
		}
		String DEPARTMENT_ID = pd.getString("DEPARTMENT_ID");
//		pd.put("DEPARTMENT_ID", null == DEPARTMENT_ID?Jurisdiction.getDEPARTMENT_ID():DEPARTMENT_ID);	//只有检索条件穿过值时，才不为null,否则读取缓存
		pd.put("DEPARTMENT_ID", null == DEPARTMENT_ID?"d41af567914a409893d011aa53eda797":DEPARTMENT_ID);
		
		pd.put("item", (null == pd.getString("DEPARTMENT_ID")?Jurisdiction.getDEPARTMENT_IDS():departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID"))));	//部门检索条件,列出此部门下级所属部门的员工
//		pd.put("item", departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID")));	//部门检索条件,列出此部门下级所属部门的员工
		
//		pd.put("item",Jurisdiction.getDEPARTMENT_ID());
		if(DEPARTMENT_ID != null){
			String Temp = pd.getString("item");
			Temp = Temp.replace(")", "");
			Temp = Temp + ","+ "\'" + DEPARTMENT_ID + "\'" + ")";
			pd.put("item", Temp);
		}

		/* 比如员工 张三 所有部门权限的部门为 A ， A 的下级有  C , D ,F ，那么当部门检索条件值为A时，只列出A以下部门的员工(自己不能修改自己的信息，只能上级部门修改)，不列出部门为A的员工，当部门检索条件值为C时，可以列出C及C以下员工 */
//		if(!(null == DEPARTMENT_ID || DEPARTMENT_ID.equals(Jurisdiction.getDEPARTMENT_ID()))){
//			pd.put("item", pd.getString("item").replaceFirst("\\(", "\\('"+DEPARTMENT_ID+"',"));
//		}
		
		page.setPd(pd);
	//	page.setShowCount(8);
		List<PageData>	varList=new ArrayList<PageData>();
		List<PageData> pdlist = staffService.list(page);					//列出空闲Staff列表
		for (PageData pageData : pdlist) {
			 Date entrytime = sdf.parse(pd.getString("FREETIME")); // 当前时间		
			 pageData.put("FREETIME", pd.getString("FREETIME"));
			List<PageData>	proList = projectMemberService.getunusedProject(pageData);
			if(null == proList || proList.size() ==0 ){
				pageData.put("PROHAS", "0");// 无项目
			}else{
			 for (PageData pd2 : proList) {				 				
					if (pd2.get("MEMBER_BTIME") == ""
							|| pd2.get("MEMBER_BTIME") == null) {
						pageData.put("PROHAS", "0");// 无项目
					} else {
						String data = pd2.get("MEMBER_BTIME").toString();
						Date datetime = sdf.parse(data); // 数据库时间
						if (datetime.compareTo(entrytime) < 0) {
							pageData.put("PROHAS", "0");// 无项目
						} else {
							pageData.put("PROHAS", "1");// 有项目
						}
					}									
			 	}
			}
			 varList.add(pageData);			
		}
		//列表页面树形下拉框用(保持下拉树里面的数据不变)
		String ZDEPARTMENT_ID = pd.getString("ZDEPARTMENT_ID");
//		ZDEPARTMENT_ID = Tools.notEmpty(ZDEPARTMENT_ID)?ZDEPARTMENT_ID:Jurisdiction.getDEPARTMENT_ID();
//		ZDEPARTMENT_ID = Tools.notEmpty(ZDEPARTMENT_ID)?ZDEPARTMENT_ID:"0";
		pd.put("ZDEPARTMENT_ID", ZDEPARTMENT_ID);
		List<PageData> zdepartmentPdList = new ArrayList<PageData>();
		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect("0",zdepartmentPdList));
		mv.addObject("zTreeNodes", arr.toString());
		PageData dpd = departmentService.findById(pd);
		if(null != dpd){
			ZDEPARTMENT_ID = dpd.getString("NAME");
		}
		PageData pda = new PageData();
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		pda.put("username", username);
		mv.addObject("pda",pda);		
		mv.addObject("depname", ZDEPARTMENT_ID);
		mv.setViewName("fhoa/staff/staff_unused");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}	
	
	
	 
		
		
		/**预订项目列表
		 * @param page
		 * @throws Exception
		 */
		@RequestMapping(value="/proList")
		public ModelAndView listOrder(Page page) throws Exception{
			logBefore(logger, Jurisdiction.getUsername()+"列表");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			page.setPd(pd);		
				List<PageData>	varList = projectMemberService.getunusedProject(page);	
				mv.setViewName("fhoa/staff/prolist");		
				mv.addObject("varList", varList);
				mv.addObject("pd", pd);
				mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			
				return mv;
		}
		
		
		 /**去修改备注页面
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/goEditMe")
		public ModelAndView goEditMe()throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd = staffService.findById(pd);	//根据ID读取
			mv.setViewName("fhoa/staff/memo_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
			return mv;
		}	
		
		/**修改备注
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/editMe")
		public ModelAndView editMe() throws Exception{
			boolean flag = flag();
			Session session = Jurisdiction.getSession();
			if(flag == true){
				logBefore(logger, Jurisdiction.getUsername()+"修改备注");
				if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
				ModelAndView mv = this.getModelAndView();
				PageData pd = new PageData();
				pd = this.getPageData();
				String MEMO=pd.getString("MEMO");
				if(null!=MEMO||!("").equals(MEMO)){
					pd.put("MEMO", MEMO);
				}else{
					pd.put("MEMO", null);
				}
				Date date=new Date();
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
				String update=sdf.format(date);	
				String username = (String) session.getAttribute(Const.SESSION_USERNAME);
				pd.put("FLAG","0");
				pd.put("UPDATEDATE",update);
				pd.put("UPDATEUSER",username);
				staffService.editMe(pd);
				/*String DEPARTMENT_IDS = departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID"));//获取某个部门所有下级部门ID
				pd.put("DATAJUR_ID", pd.getString("STAFF_ID")); //主键
				pd.put("DEPARTMENT_IDS", DEPARTMENT_IDS);		//部门ID集
				datajurService.edit(pd);			*/			//把此员工默认部门及以下部门ID保存到组织数据权限表
				mv.addObject("msg","success");
				mv.setViewName("save_result");
				return mv;
			}
			
			return null;
		
		}
		
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		boolean flag = flag();
		if(flag == true){
			logBefore(logger, Jurisdiction.getUsername()+"批量删除Staff");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
			PageData pd = new PageData();		
			Map<String,Object> map = new HashMap<String,Object>();
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			
			String DATA_IDS = pd.getString("DATA_IDS");
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				Session session = Jurisdiction.getSession();
				Date date=new Date();
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
				String update=sdf.format(date);	
				String username = (String) session.getAttribute(Const.SESSION_USERNAME);
				pd.put("FLAG","1");
				pd.put("UPDATEDATE",update);
				pd.put("UPDATEUSER",username);
				pd.put("STAFF_ID", ArrayDATA_IDS[i]);
				staffService.editStaffAll(pd);
			}
			/*if(null != DATA_IDS && !"".equals(DATA_IDS)){
				
				
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}*/
			FHLOG.save(Jurisdiction.getUsername(), "批量删除员工","OA_STAFF","STAFF_ID",DATA_IDS);
			pdList.add(pd);
			map.put("list", pdList);
			return AppUtil.returnObject(pd, map);
		}
		return flag;
	}
	
	 /**绑定用户
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/userBinding")
	@ResponseBody
	public Object userBinding() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"绑定用户");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		staffService.userBinding(pd);
		return AppUtil.returnObject(pd, map);
	}


	 /**进入员工评估界面
		 * @param
		 * @throws Exception
		 */
	@RequestMapping(value="/goEv")
	public ModelAndView goEv() throws Exception{
			logBefore(logger, Jurisdiction.getUsername()+"修改Staff");
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			PageData pd2 = null;
			pd = this.getPageData();
			List<Page> answerid = staffService.findAnswerId(pd);
			pd.put("ANSWERID", answerid);
			List<String> type = staffService.findType(pd);	
			List<String> questionlist = new ArrayList<String>();
			HashMap typequestion=new HashMap();
			HashMap questionanswer =null;
			Iterator it1 = type.iterator();
	        while(it1.hasNext()){
	        	 String typeone=(String)it1.next();
	             questionlist =staffService.findQuestionByType(typeone);
	             Iterator it2 = questionlist.iterator();
	             questionanswer =new HashMap();
	             while(it2.hasNext()){
	            	 String questionone=(String)it2.next();
	            	 pd2 = new PageData();
	            	 pd2.put("questionone", questionone);
	            	 pd2.put("typeone", typeone);
	            	 List<PageData> pd3=staffService.findAnswerByQuestion(pd2);
	            	 questionanswer.put(questionone,pd3);
	             }
	             
	             typequestion.put(typeone, questionanswer);
	        }
			mv.setViewName("fhoa/staff/staff_ev");
			mv.addObject("pd", pd);
			mv.addObject("typehash", typequestion);
			return mv;

	}


	
	
	@RequestMapping(value = "/saveev")
	public ModelAndView saveev() throws Exception {
		Session session = Jurisdiction.getSession();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		
		pd = this.getPageData();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		String managerid = user.getUSER_ID();
		String staffId = pd.getString("STAFF_ID");
		
		String[] ANSWER_NAMES = ((String)pd.get("ANSWER_NAMES")).split(",");
		String[] QUESTION_NAMES = ((String)pd.get("QUESTION_NAMES")).split(",");
		String[] QUESTION_TYPES = ((String)pd.get("QUESTION_TYPES")).split(",");
		staffService.deleteev(pd);
		
		for(int i=0;i<ANSWER_NAMES.length;i++){
			String answerId = ANSWER_NAMES[i];
			String questionName = QUESTION_NAMES[i];
			String questionType = QUESTION_TYPES[i];
			PageData paramPd = new PageData();
			paramPd.put("EV_ANSWER_ID", answerId);
			
			PageData answer = staffService.findAnswerById(paramPd);
			PageData result = new PageData();
			result.put("EV_ID", this.get32UUID());
			result.put("QUESTION_TYPE", questionType);
			result.put("QUESTION_NAME", questionName);
			result.put("ANSWER_NAME", answer.getString("EV_ANSWER_NAME"));
			result.put("ANSWER_MARK", (Integer)answer.get("EV_ANSWER_MARK"));
			result.put("STAFF_ID",staffId);
			result.put("EV_MANAGER", managerid);
			result.put("EV_TIME", new Date());
			result.put("ANSWERID", answerId);
			staffService.saveev(result);
		}
	
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;

	}
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Staff到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("姓名");	//1
		titles.add("英文");	//2
		titles.add("编码");	//3
		titles.add("部门");	//4
		titles.add("职责");	//5
		titles.add("电话");	//6
		titles.add("邮箱");	//7
		titles.add("性别");	//8
		titles.add("出生日期");	//9
		titles.add("民族");	//10
		titles.add("岗位类别");	//11
		titles.add("参加工作时间");	//12
		titles.add("籍贯");	//13
		titles.add("政治面貌");	//14
		titles.add("入团时间");	//15
		titles.add("身份证号");	//16
		titles.add("婚姻状况");	//17
		titles.add("进本单位时间");	//18
		titles.add("现岗位");	//19
		titles.add("上岗时间");	//20
		titles.add("学历");	//21
		titles.add("毕业学校");	//22
		titles.add("专业");	//23
		titles.add("职称");	//24
		titles.add("职业资格证");	//25
		titles.add("劳动合同时长");	//26
		titles.add("签订日期");	//27
		titles.add("终止日期");	//28
		titles.add("现住址");	//29
		titles.add("绑定账号ID");	//30
		titles.add("备注");	//31
		dataMap.put("titles", titles);
		List<PageData> varOList = staffService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("NAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("NAME_EN"));	    //2
			vpd.put("var3", varOList.get(i).getString("BIANMA"));	    //3
			vpd.put("var4", varOList.get(i).getString("DEPARTMENT_ID"));	    //4
			vpd.put("var5", varOList.get(i).getString("FUNCTIONS"));	    //5
			vpd.put("var6", varOList.get(i).getString("TEL"));	    //6
			vpd.put("var7", varOList.get(i).getString("EMAIL"));	    //7
			vpd.put("var8", varOList.get(i).getString("SEX"));	    //8
			vpd.put("var9", varOList.get(i).getString("BIRTHDAY"));	    //9
			vpd.put("var10", varOList.get(i).getString("NATION"));	    //10
			vpd.put("var11", varOList.get(i).getString("JOBTYPE"));	    //11
			vpd.put("var12", varOList.get(i).getString("JOBJOINTIME"));	    //12
			vpd.put("var13", varOList.get(i).getString("FADDRESS"));	    //13
			vpd.put("var14", varOList.get(i).getString("POLITICAL"));	    //14
			vpd.put("var15", varOList.get(i).getString("PJOINTIME"));	    //15
			vpd.put("var16", varOList.get(i).getString("SFID"));	    //16
			vpd.put("var17", varOList.get(i).getString("MARITAL"));	    //17
			vpd.put("var18", varOList.get(i).getString("DJOINTIME"));	    //18
			vpd.put("var19", varOList.get(i).getString("POST"));	    //19
			vpd.put("var20", varOList.get(i).getString("POJOINTIME"));	    //20
			vpd.put("var21", varOList.get(i).getString("EDUCATION"));	    //21
			vpd.put("var22", varOList.get(i).getString("SCHOOL"));	    //22
			vpd.put("var23", varOList.get(i).getString("MAJOR"));	    //23
			vpd.put("var24", varOList.get(i).getString("FTITLE"));	    //24
			vpd.put("var25", varOList.get(i).getString("CERTIFICATE"));	    //25
			vpd.put("var26", varOList.get(i).get("CONTRACTLENGTH").toString());	//26
			vpd.put("var27", varOList.get(i).getString("CSTARTTIME"));	    //27
			vpd.put("var28", varOList.get(i).getString("CENDTIME"));	    //28
			vpd.put("var29", varOList.get(i).getString("ADDRESS"));	    //29
			vpd.put("var30", varOList.get(i).getString("USER_ID"));	    //30
			vpd.put("var31", varOList.get(i).getString("BZ"));	    //31
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	/**打开上传EXCEL页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goUpload")
	public ModelAndView goUpload()throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("fhoa/staff/upload");
		return mv;
	}
	/**下载模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/download")
	public void download(HttpServletResponse response)throws Exception{
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "Staffs.xls", "Staffs.xls");
	}
	/**从EXCEL导入到数据库
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/readStaff")
	public ModelAndView readStaff(
			@RequestParam(value="excel",required=false) MultipartFile file
			) throws Exception{
		FHLOG.save(Jurisdiction.getUsername(), "从EXCEL导入到数据库","","","");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;								//文件上传路径
			String fileName =  FileUpload.fileUp(file, filePath, "staffexcel");							//执行上传
			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);		//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet					
			for(int i=0;i<listPd.size();i++){	
				Session session = Jurisdiction.getSession();
				pd.put("FLAG","0");
				Date date=new Date();
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
				String update=sdf.format(date);	
				String username = (String) session.getAttribute(Const.SESSION_USERNAME);				
				pd.put("STAFF_ID", this.get32UUID());				//ID	
				pd.put("NO", Integer.valueOf(listPd.get(i).getString("var0")).intValue());
				pd.put("USER_ID", pd.get("NO").toString());	
				pd.put("STAFFNAME",listPd.get(i).getString("var1") );				
				pd.put("SEX",NameToId.getValue(listPd.get(i).getString("var2")));								
				pd.put("SCHOOL", listPd.get(i).getString("var3"));
				pd.put("ADDRESS", listPd.get(i).getString("var4"));
				pd.put("TEL", listPd.get(i).getString("var5"));							
				pd.put("ENTRY_DATE",listPd.get(i).getString("var6"));
				pd.put("IDCARD", listPd.get(i).getString("var7"));
				pd.put("JAPANESE", NameToId.getValue("J"+listPd.get(i).getString("var8")));
				pd.put("ENGLISH", NameToId.getValue("E"+listPd.get(i).getString("var9")));
				pd.put("PASS", NameToId.getValue(listPd.get(i).getString("var10")));
				pd.put("PASS_NO", listPd.get(i).getString("var11"));
				if(listPd.get(i).getString("var12")!=null && !listPd.get(i).getString("var12").equals("")){
					pd.put("GRADUATE_DATE", listPd.get(i).getString("var12"));	
				}else {
					pd.put("GRADUATE_DATE", null);	
				}				
			//	pd.put("titleName", listPd.get(i).getString("var13"));
				pd.put("TITLE", NameToId.getValue(listPd.get(i).getString("var13")));
				pd.put("STATUS", NameToId.getValue(listPd.get(i).getString("var14")));				
				pd.put("DEPARTMENT_ID", NameToId.getValue(listPd.get(i).getString("var15")));				
				pd.put("DEPARTMENT_NAMES", listPd.get(i).getString("var15"));
				if(listPd.get(i).getString("var16")!=null && !listPd.get(i).getString("var16").equals("")){
					pd.put("PASS_TERM", listPd.get(i).getString("var16"));	
				}else {
					pd.put("PASS_TERM", null);	
				}							
				pd.put("VISA", NameToId.getValue(listPd.get(i).getString("var17")));				
				pd.put("VISA_TYPE", NameToId.getValue(listPd.get(i).getString("var18")));				
				pd.put("TRAVEL_TYPE",NameToId.getValue(listPd.get(i).getString("var19")));				
				pd.put("STRENGTHS", listPd.get(i).getString("var20"));				
				pd.put("EMAIL", listPd.get(i).getString("var21"));				
				if(staffService.findByNo(pd)!=null){
					pd.put("UPDATEDATE",update);
					pd.put("UPDATEUSER",username);	
					staffService.editByNo(pd);
				}else{
					pd.put("CREATIONDATE",update);
					pd.put("CREATIONUSER",username);
					staffService.save(pd);	
					saveC(pd);
				}			
		}
			/*存入数据库操作======================================*/
			mv.addObject("msg","success");
		}
		mv.setViewName("save_result");
		return mv;
	}
	 /**员工能力
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/nl")
	public ModelAndView nl(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"员工能力");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData staff = staffService.findScoreById(pd);		
		mv.setViewName("fhoa/staff/staff_nl");
		mv.addObject("pd", staff);
		
		return mv;
		}
	
	public boolean flag() throws Exception{
		Session session = Jurisdiction.getSession();
		boolean flag = false;
		User user = (User)session.getAttribute(Const.SESSION_USER);	
		if(user != null ){
			flag = true;
		}
		return flag;
	}
	
	
	
	public void saveC(PageData pd) throws Exception{
		pd.put("USER_ID",this.get32UUID());
		pd.put("USERNAME",pd.get("NO").toString());
		pd.put("PASSWORD",MD5.md5("handhand"));
		pd.put("chkpwd",MD5.md5("handhand"));
		if(pd.getString("STATUS").equals("49aabbb9c9f6442cbf2f6d8849d68202")){
			pd.put("STATUS","0");
		}else{
			pd.put("STATUS","1");
		}			
		pd.put("NAME",pd.getString("STAFFNAME"));
		PageData  pda = staffService.findTitleName(pd);
		String title = pda.getString("TITLENAME");
		if(title!=null && !title.equals("")){
			if(title.equals("A")){
				pd.put("ROLE_ID","115b386ff04f4352b060dffcd2b5d1da");
			}else if(title.equals("PG1")||title.equals("PG2")){
				pd.put("ROLE_ID","1b67fc82ce89457a8347ae53e43a347e");
			}else if(title.equals("SE1")||title.equals("SE2")){
				pd.put("ROLE_ID","3bd8099dbcb346b698e02a5746f793d1");
			}else if(title.equals("PL1")||title.equals("PL2")){
				pd.put("ROLE_ID","a01a35cae4cb4f62b34f385eecd5f9ec");
			}else if(title.equals("PM1")||title.equals("PM2")){
				pd.put("ROLE_ID","7d1d664c50c641089d1590cde121a81a");
			}else if(title.equals("SPM")){
				pd.put("ROLE_ID","459739685620425093ae9f9abe374528");
			}			
		}	
		pd.put("ID_",pd.get("NO").toString());
		pd.put("FIRST_",pd.getString("STAFFNAME"));
		pd.put("USER_ID_",pd.get("NO").toString());
		pd.put("GROUP_ID_",pd.getString("ROLE_ID"));
		appuserService.saveU(pd);
	}	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
