package com.hand.controller.app.project;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.app.pc.PcController;
import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.service.app.pc.CheckManager;
import com.hand.service.app.pc.impl.PcLeaveItemService;
import com.hand.service.app.pc.impl.PcLeaveService;
import com.hand.service.app.pc.impl.PcService;
import com.hand.service.app.project.ProSecurityManager;
import com.hand.service.fhoa.department.DepartmentManager;
import com.hand.service.fhoa.staff.StaffManager;
import com.hand.util.AppUtil;
import com.hand.util.Const;
import com.hand.util.Jurisdiction;
import com.hand.util.ObjectExcelView;
import com.hand.util.PageData;

/**
 * 项目信息安全管理
 * @author hand
 *
 */
@Controller
@RequestMapping(value="/security")
public class ProSecurityController extends BaseController {
	
	String menuUrl = "security/list.do"; //菜单地址(权限用)
	@Resource(name="prosecurityService")
	private ProSecurityManager prosecurityService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="staffService")
	private StaffManager staffService;
	@Resource(name = "PcLeaveService")
	private PcLeaveService pcLeaveService;
	@Resource(name="pcService")
	private PcService pcService;
	@Resource(name="checkService")
	private CheckManager checkService;
	@Resource (name = "pcLeaveItemService") 
	private PcLeaveItemService pcLeaveItemService;

	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		Session session = Jurisdiction.getSession();
		logBefore(logger, Jurisdiction.getUsername()+"新增Proj");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PROJECT_ID", this.get32UUID());	//主键
		pd.put("FLAG","0");
		Date date=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
		String update=sdf.format(date);	
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		pd.put("CREATIONDATE",update);
		pd.put("CREATIONUSER",username);
		prosecurityService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Proj");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		Session session = Jurisdiction.getSession();
		PageData pd = new PageData();
		pd = this.getPageData();
		String stw = (String) pd.get("PRO_ID");
		String PRO_ID = stw.replaceAll("/","");
		pd.put("PRO_ID", PRO_ID);
		PageData prosecurity = prosecurityService.findById(pd);
		String  pc=prosecurity.getString("PC_NUMBER");
		prosecurity.put("FLAG","1");
		prosecurity.put("PC_NUMBER",pc);
	    Date date=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
		String update=sdf.format(date);	
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		prosecurity.put("UPDATEDATE",update);
		prosecurity.put("UPDATEUSER",username);
		prosecurityService.edit(prosecurity);
		prosecurityService.editdepot(prosecurity);
		prosecurityService.delCheck(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Proj");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		Session session = Jurisdiction.getSession();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("FLAG","0");
	    Date date=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
		String update=sdf.format(date);	
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		pd.put("UPDATEDATE",update);
		pd.put("UPDATEUSER",username);
		PageData prosecurity=prosecurityService.findById(pd);
		pd.put("PC_STATE", prosecurity.getString("PC_STATE"));
		if(pd.getString("PC_STATE").equals("91263f5998e24af3b0cf011bba426557")){
			pd.put("PC_STATE","afd972ec76334ba7949c8ed093449b29");
		}				
		String exitcharge=pd.getString("EXITCHARGE");
		if(null!=exitcharge&&!("").equals(exitcharge)){
			pd.put("PC_STATE","141b48c7bc554d58bd298dc9acff3f46");
		}
		
		if(!"".equals(pd.getString("PC_NUMBER")) && null!=pd.getString("PC_NUMBER")){
			String[] user = pd.getString("PC_NUMBER").split(",");	
			pd.put("PC_ID", user[0]);
			pd.put("PC_NUMBER", user[1]);
		}
	    
		if(!"".equals(pd.getString("USER")) && null!=pd.getString("USER")){
			String[] user = pd.getString("USER").split(",");	
			pd.put("USER_ID", user[0]);
			pd.put("USER", user[1]);
		}		
		prosecurityService.edit(pd);		
		String PC_NO=pd.getString("PC_NUMBER");
		pd.put("PC_NO", PC_NO);
		pd.put("PROGRAM",prosecurity.get("PROJECT_ID"));
		pd.put("ROOM_NAME",prosecurity.get("ROOM_NAME"));
		if(pd.getString("PC_STATE").equals("8b2bb55faa4e4258870ebd1aaeedf489")){
			pd.put("DEPOT", "c44b146e55cc4c96b3a7ddaa81609c55");
		}else if (pd.getString("PC_STATE").equals("91263f5998e24af3b0cf011bba426557")||
				pd.getString("PC_STATE").equals("afd972ec76334ba7949c8ed093449b29")){
			pd.put("DEPOT", "cd11cb2ebefa4e99b94a62aa5ab44a59");
		}else if(pd.getString("PC_STATE").equals("141b48c7bc554d58bd298dc9acff3f46")){
			pd.put("DEPOT", "b7c839d9661e47a785a20c47d4d66ab6");
		}		
		pcService.editDepot(pd);
		pcService.editPandR(pd);
		
		/*	PageData pda = new PageData();
		pda = this.getPageData();
		String admission=pd.getString("ADMISSIONCHARGE");				
		if(admission!=null){
			String state=pd.getString("PC_STATE");
			String id=pd.getString("PC_NUMBER");		
			pda.put("PC_STATE", state);
			pda.put("PC_NUMBER", id);
			prosecurityService.editpcstate(pda);
		}*/
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	@RequestMapping(value = "/haspcCheck")
	@ResponseBody
	public Object haspcCheck() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String errInfo = "success";
		Page page = new Page();
		PageData pd = new PageData();
		pd = this.getPageData();
		String PC_ID = (String) pd.get("PC_ID");
		String id = PC_ID.replaceAll("/","");
		pd.put("PC_ID",id);
/*		pd.put("PC_ID", pcService.findByNo(pd).getString("PC_ID"));*/
		page.setPd(pd);
		List<PageData> pcCheckList=checkService.list(page);
		map.put("varList", pcCheckList);
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
	@RequestMapping(value = "/hasproSecurity")
	@ResponseBody
	public Object hasproSecurity() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String errInfo = "success";
		Page page = new Page();
		PageData pd = new PageData();
		pd = this.getPageData();
		String pname=pd.getString("projectname");
		String projectname = new String(pname.getBytes("ISO8859-1"), "utf-8");
		pd.put("projectname", projectname);
		String pmanager=pd.getString("projectmanager");
		String projectmanager = new String(pmanager.getBytes("ISO8859-1"), "utf-8");
		pd.put("projectmanager", projectmanager);		
		String admissionr=pd.getString("admissioncharge");
		String admissioncharge = new String(admissionr.getBytes("ISO8859-1"), "utf-8");
		pd.put("admissioncharge", admissioncharge);
		String exit=pd.getString("exitcharge");
		String exitcharge = new String(exit.getBytes("ISO8859-1"), "utf-8");
		pd.put("exitcharge", exitcharge);
		String licant=pd.getString("applicant");
		String applicant = new String(licant.getBytes("ISO8859-1"), "utf-8");
		pd.put("applicant", applicant);		
		page.setShowCount(20);
		if (StringUtils.isBlank(pd.getString("PC_LEAVEID"))) {
			if (StringUtils.isBlank(pd.getString("PROJECT_ID"))) {
				pd.put("PID", "PID");
			}
		}
		page.setPd(pd);
		List<PageData> proSecurity =  prosecurityService.list(page); // 列出ProjectMember列表
		map.put("varList", proSecurity);
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listProsecurityleave")
	public ModelAndView listProsecurityleave(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Proj");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();	
		page.setPd(pd);
		List<PageData>	prosecurityleave = prosecurityService.listProsecurityleave(page);	//列出Proj列表
		//List<PageData>	prosecurityleave = prosecurityService.listProsecurityleave(page);	//列出Proj列表		
		List<PageData> curPageList = fenye(prosecurityleave, page.getShowCount(), page.getCurrentPage());		
		for (PageData pageData : prosecurityleave) {	
			PageData pd1 = new PageData();
			String applicant= pageData.getString("APPLICANT");
			String proid= pageData.getString("PRO_ID");
			pd1.put("APPLICANT", applicant);
			pd1.put("PRO_ID", proid);
			try {
				String  licant=prosecurityService.getApplicant(pd1).getString("NAME");
				pageData.put("APPLICANT", licant);				
			} catch (Exception e) {
				String  licant1=prosecurityService.applicantname(pd1).getString("NAME");
				pageData.put("APPLICANT", licant1);
			}			
			prosecurityService.editApplicant(pageData);
		}			
		mv.setViewName("app/project/prosecurityleave_list");
		mv.addObject("prosecurityleave", prosecurityleave);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Proj");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		String name ;
		String ferrname ;
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		PageData pd = new PageData();
		pd = this.getPageData();	
		pd.put("project", "project");//xml里的if判断
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		pd.put("USER_ID", username);
		try {
			name = staffService.findByUserId(pd).getString("NAME");
		} catch (Exception e) {
			name = null;
		}
		try {
			ferrname=prosecurityService.staffuser(pd).getString("NAME");
		} catch (Exception e) {
			ferrname="1";
		}
		pd.put("name", name);
		pd.put("ferrname", ferrname);
		page.setPd(pd);
		List<PageData>	varList=new ArrayList<PageData>();
		List<PageData>	prosecurity = prosecurityService.list(page);	//列出Proj列表
		if(prosecurity!=null){
		for (PageData pageData : prosecurity) {			
			if("".equals(pageData.getString("PROJECT_NAME")) || null==pageData.getString("PROJECT_NAME")){
				 if(username!=null){                                                //无项目申请人可以退场
					 if(username.equals(pageData.get("APPLICANT_NO").toString())){
							try {
								PageData pc=pcLeaveService.findByPS(pageData.getString("PC_LEAVEID"));
								if(!pc.equals(null)){
									pageData.put("STATE", "1");	
								}
								
							} catch (Exception e) {
								pageData.put("STATE", "0");
							}
						}
				 }				
			}else if(name!=null){
				
				if(name.equals(pageData.getString("PROJECT_MANAGER"))){   //有项目项目经理可以退场
				try {
					PageData pc=pcLeaveService.findByPS(pageData.getString("PC_LEAVEID"));
					if(!pc.equals(null)){
						pageData.put("STATE", "1");	
					}
					
				} catch (Exception e) {
					pageData.put("STATE", "0");
				}
			}
			
		   }
			PageData pd1 = new PageData();
			String applicant= pageData.getString("APPLICANT");
			String proid= pageData.getString("PRO_ID");
			pd1.put("APPLICANT", applicant);
			pd1.put("PRO_ID", proid);
			try {
				String  licant=prosecurityService.getApplicant(pd1).getString("NAME");
				pageData.put("APPLICANT", licant);				
			} catch (Exception e) {
				String  licant1=prosecurityService.applicantname(pd1).getString("NAME");
				pageData.put("APPLICANT", licant1);
			}			
			prosecurityService.editApplicant(pageData);	
			/*if(StringUtils.isBlank(pageData.getString("PROJECT_ID"))){
				pageData.put("PID", "PID");
			}
			PageData pd2 = prosecurityService.findBypro(pageData);
			pageData.put("PC_NUMBER", prosecurityService.findBypro(pageData).getString("conut"));
			try {
				 prosecurityService.findbyPCstate(pageData);
				 pageData.put("PCSTATE", "未入场");
			} catch (Exception e) {
				pageData.put("PCSTATE", "已入场");
			}
			*/
			varList.add(pageData);
		 }
		
		PageData pdd = new PageData();
		pdd.put("name", name);
		mv.addObject("pdd",pdd);
		
		PageData pda = new PageData();
		pda.put("ferrname", ferrname);
		mv.addObject("pda",pda);
		
		}
		mv.setViewName("app/project/prosecurity_list");
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
		mv.setViewName("app/project/prosecurity_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
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
		PageData pda = new PageData();
		pda = this.getPageData();
		String stw = (String) pda.get("PRO_ID");
		String PRO_ID = stw.replaceAll("/","");
		pd.put("PRO_ID", PRO_ID);
		String ste = (String) pda.get("ID");
		String PC_LEAVE_ITEMID = ste.replaceAll("/","");
		pd.put("PC_LEAVE_ITEMID", PC_LEAVE_ITEMID);
		String stq = (String) pda.get("PROJECT_ID");
		String PROJECT_ID = stq.replaceAll("/","");
		pd.put("PROJECT_ID", PROJECT_ID);
		List<PageData> staffList = prosecurityService.getFreeStaff(pd);	  //查询品管信息部人员
		List<PageData> useridList = prosecurityService.getUseridStaff(pd);	//查询USER_ID不为空的员工
		List<PageData> proStaffList=prosecurityService.getProStaff(pd);
		PageData pageData=pcLeaveItemService.getItemByIds(pd);
		pd.put("TYPE", pageData.getString("TYPE"));
		List<PageData> pcList = pcService.showDepot(pd);
		pd = prosecurityService.findById(pd);	//根据ID读取
		mv.setViewName("app/project/prosecurity_edit");
		mv.addObject("msg", "edit");
		mv.addObject("staffList",staffList);
		mv.addObject("useridList",useridList);
		mv.addObject("pcList",pcList);
		mv.addObject("proStaffList",proStaffList);
		mv.addObject("pd", pd);
		mv.addObject("pageData", pageData);
		return mv;
	}	
	
	/**去批量修改页面
	 * @param
	 * @throws Exception */	 
	@RequestMapping(value="/gosecurityEdit")
	public ModelAndView goSalaryEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();		
		//String s=pd.getString("ADMISSIONCHARGE");
		//String w=pd.getString("EXITCHARGE");
		//String q=pd.getString("PROJECT_ID");
		String s=pd.getString("PRO_ID");
		//String q=java.net.URLDecoder.decode("s","UTF-8");
		//String id = new String(s.getBytes("ISO8859-1"), "utf-8");
		//String id1 = new String(w.getBytes("ISO8859-1"), "utf-8");
		//String id2 = new String(q.getBytes("ISO8859-1"), "utf-8");
		//pd.put("ADMISSIONCHARGE", id);
		//pd.put("EXITCHARGE", id1);
		//pd.put("EXITCHARGE", id2);
		if(s.contains(",")){
			mv.addObject("msg", "editAll");
		}
		mv.addObject("pd", pd);
		mv.setViewName("app/project/prosecurity_editAll");
		return mv;
	}
	
	/**批量修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/editAll")
	@ResponseBody
	public  ModelAndView editAll(HttpServletRequest request) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量修改");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();	
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String s=pd.getString("ADMISSIONCHARGE");
		String w=pd.getString("EXITCHARGE");
		String[] project_id  = pd.getString("PRO_ID").split(",");	
		for(int i=0;i<project_id.length;i++){
			pd.put("PRO_ID", project_id[i]);
			//String  exit=prosecurityService.exitid(pd).getString("EXITCHARGE");
			if(s!=null&&w.equals("")){				
				prosecurityService.admissioneditAll(pd);				
			}else  if(w!=null&&s.equals("")){				
				prosecurityService.exitditAll(pd);
			}else{
				prosecurityService.editAll(pd);
			}
				
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
				
	/**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Proj");
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
			pd.put("PRO_ID", ArrayDATA_IDS[i]);
			prosecurityService.deleteAll(pd);
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Proj到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("备注1");	//1
		titles.add("aa");	//2
		dataMap.put("titles", titles);
		List<PageData> varOList = prosecurityService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PROJECT_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("AAA"));	    //2
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	// 分页函数
			public List<PageData> fenye(List<PageData> list, int pagesize, int pageNum) {

				int totalcount = list.size();
				int pagecount = 0;
				int m = totalcount % pagesize;

				if (list.size() == 0) {
					return null;
				}

				if (m > 0) {
					pagecount = totalcount / pagesize + 1;
				} else {
					pagecount = totalcount / pagesize;
				}

				if (pageNum < 1) {
					pageNum = 1;
				}
				if (pageNum > pagecount) {
					pageNum = pagecount;
				}

				if (m == 0) {
					List<PageData> subList = list.subList((pageNum - 1) * pagesize, pagesize * (pageNum));
					return subList;
				} else {
					if (pageNum == pagecount) {
						List<PageData> subList = list.subList((pageNum - 1) * pagesize, totalcount);
						return subList;
					} else {
						List<PageData> subList = list.subList((pageNum - 1) * pagesize, pagesize * (pageNum));
						return subList;
					}

				}

			}

}
