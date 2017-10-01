package com.hand.controller.app.project;

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

import org.apache.shiro.session.Session;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.entity.system.User;
import com.hand.util.AppUtil;
import com.hand.util.Const;
import com.hand.util.ObjectExcelView;
import com.hand.util.PageData;
import com.hand.util.Jurisdiction;
import com.hand.service.app.project.ProjectMemberManager;
import com.hand.service.system.fhlog.FHlogManager;


/** 
 * 说明：项目成员页面开发
 * 创建时间：2017-07-03
 */
@Controller
@RequestMapping(value="/projectmember")
public class ProjectMemberController extends BaseController {
	
	String menuUrl = "projectmember/list.do"; //菜单地址(权限用)
	@Resource(name="projectmemberService")
	private ProjectMemberManager projectmemberService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		Session session = Jurisdiction.getSession();
		boolean flag = flag();
		if(flag == true){
		logBefore(logger, Jurisdiction.getUsername()+"新增ProjectMember");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键
		pd.put("FLAG","0");
		Date date=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
		String update=sdf.format(date);	
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		pd.put("CREATIONDATE",update);
		pd.put("CREATIONUSER",username);
		projectmemberService.save(pd);
		FHLOG.save(Jurisdiction.getUsername(), "新增项目人员","PRO_MEMBER","ID",pd.getString("ID"));
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
		logBefore(logger, Jurisdiction.getUsername()+"删除ProjectMember");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData member=projectmemberService.findById(pd);
		member.put("FLAG", "1");
		  Date date=new Date();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
			String update=sdf.format(date);	
			String username = (String) session.getAttribute(Const.SESSION_USERNAME);
			member.put("UPDATEDATE",update);
			member.put("UPDATEUSER",username);
			FHLOG.save(Jurisdiction.getUsername(), "删除项目人员","PRO_MEMBER","ID",pd.getString("ID"));
		projectmemberService.edit(member);
		out.write("success");
		out.close();
	}
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
		logBefore(logger, Jurisdiction.getUsername()+"修改ProjectMember");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Date date=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
		String update=sdf.format(date);	
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		pd.put("FLAG","0");
		pd.put("UPDATEDATE",update);
		pd.put("UPDATEUSER",username);
		FHLOG.save(Jurisdiction.getUsername(), "修改项目人员","PRO_MEMBER","ID",pd.getString("ID"));
		projectmemberService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
		return null;
		
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表ProjectMember");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = projectmemberService.list(page);	//列出ProjectMember列表	
		mv.setViewName("app/project/project_member");		
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
		String kxsj = pd.getString("kxsj");				//关键词检索条件
		if(null != kxsj && !"".equals(kxsj)){
			pd.put("kxsj", kxsj);
		}
		List<PageData> staffList = projectmemberService.getFreeStaff(pd);		
		mv.setViewName("app/project/projectmember_edit");
		mv.addObject("msg", "save");
		mv.addObject("staffList",staffList);
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
		pd = this.getPageData();
		pd = projectmemberService.findById(pd);	//根据ID读取
		mv.setViewName("app/project/projectmember_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	 /**进入员工评估界面
	 * @param
	 * @throws Exception
	 */
@RequestMapping(value="/goEv")
public ModelAndView goEv() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"员工评价");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		PageData pd2 = null;
		pd = this.getPageData();
		List<String> answerid = projectmemberService.findAnswerId(pd);
		pd.put("ANSWERID", answerid);
		List<String> type = projectmemberService.findType(pd);
		List<String> questionlist = new ArrayList<String>();
		HashMap typequestion=new HashMap();
		HashMap questionanswer =null;
		Iterator it1 = type.iterator();
       
        while(it1.hasNext()){
        	 String typeone=(String)it1.next();
             questionlist =projectmemberService.findQuestionByType(typeone);
             Iterator it2 = questionlist.iterator();
             questionanswer =new HashMap();
             while(it2.hasNext()){
            	 String questionone=(String)it2.next();
            	 pd2 = new PageData();
            	 pd2.put("questionone", questionone);
            	 pd2.put("typeone", typeone);
            	 List<PageData> pd3=projectmemberService.findAnswerByQuestion(pd2);
            	 questionanswer.put(questionone,pd3);
             }
             
             typequestion.put(typeone, questionanswer);
        }
		mv.setViewName("app/project/project_ev");
		mv.addObject("pd", pd);
		mv.addObject("typehash", typequestion);
		return mv;
}
@RequestMapping(value="/saveev")
public ModelAndView saveev() throws Exception{	
	Session session = Jurisdiction.getSession();
	ModelAndView mv = this.getModelAndView();
	PageData pd = new PageData();
	
	pd = this.getPageData();
	User user = (User) session.getAttribute(Const.SESSION_USER);
	String ev_managerid = user.getUSER_ID();
	String memberId = pd.getString("MEMBER_ID");
	String projectId = pd.getString("PROJECT_ID");
	
	String[] PRO_ANSWER_NAMES = ((String)pd.get("PRO_ANSWER_NAMES")).split(",");
	String[] PRO_QUESTION_NAMES = ((String)pd.get("PRO_QUESTION_NAMES")).split(",");
	String[] PRO_QUESTION_TYPES = ((String)pd.get("PRO_QUESTION_TYPES")).split(",");
	projectmemberService.deleteev(pd);
	
	for(int i=0;i<PRO_ANSWER_NAMES.length;i++){
		String answerId = PRO_ANSWER_NAMES[i];
		String questionName = PRO_QUESTION_NAMES[i];
		String questionType = PRO_QUESTION_TYPES[i];
		PageData paramPd = new PageData();
		paramPd.put("EV_ID", answerId);
		
		PageData answer = projectmemberService.findAnswerById(paramPd);
		PageData result = new PageData();
		result.put("PRO_EV_ID", this.get32UUID());
		result.put("PRO_QUESTION_TYPE", questionType);
		result.put("PRO_QUESTION_NAME", questionName);
		result.put("PRO_ANSWER_NAME", answer.getString("ANSWER_NAME"));
		result.put("PRO_ANSWER_MARK", (Integer)answer.get("ANSWER_MARK"));
		result.put("PRO_MEMBER_ID",memberId);
		result.put("PROJECT_ID",projectId);
		result.put("PRO_EV_MANAGER", ev_managerid);
		result.put("PRO_EV_TIME", new Date());
		result.put("ANSWERID", answerId);
		projectmemberService.saveev(result);
	}
	PageData projectmark= projectmemberService.findMark(pd);
	projectmark.get("PROJECT_EV");
	PageData managermark= projectmemberService.findManagerMark(pd);
	managermark.get("MANAGER_EV");
	pd.put("PROJECT_EV", projectmark.get("PROJECT_EV"));
	pd.put("MANAGER_EV", managermark.get("MANAGER_EV"));
	projectmemberService.editEv(pd);
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
		boolean flag = flag();
		if(flag == true){
		logBefore(logger, Jurisdiction.getUsername()+"批量删除ProjectMember");
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
			pd.put("ID", ArrayDATA_IDS[i]);
			projectmemberService.editMemberAll(pd);	
	}
		FHLOG.save(Jurisdiction.getUsername(), "批量删除项目人员","PRO_MEMBER","ID",DATA_IDS);
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
		return flag;
}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出ProjectMember到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("成员Id");	//1
	//	titles.add("成员姓名");	//2
		titles.add("成员角色");	//3
		titles.add("开始日期");	//4
		titles.add("结束日期");	//5
		titles.add("级别成本");	//6
		titles.add("实际成本");	//7
		titles.add("项目ID");	//8
		dataMap.put("titles", titles);
		List<PageData> varOList = projectmemberService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ID"));	    //1
		//	vpd.put("var2", varOList.get(i).getString("MEMBER_NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("MEMBER_ROLE"));	    //3
			vpd.put("var4", varOList.get(i).getString("MEMBER_BTIME"));	    //4
			vpd.put("var5", varOList.get(i).getString("MEMBER_ETIME"));	    //5
			vpd.put("var6", varOList.get(i).get("MEMBER_COST").toString());	//6
			vpd.put("var7", varOList.get(i).get("MEMBER_ACTUL").toString());	//7
			vpd.put("var8", varOList.get(i).getString("PROJECT_ID"));	    //8
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	  /**级别成本
		 * @param
		 * @throws Exception
		 */
	@RequestMapping(value="/level")
	@ResponseBody
	public Object level() throws Exception{
		    Map<String,Object> map = new HashMap<String,Object>();
			PageData pd = new PageData();
			pd = this.getPageData();		
			pd = projectmemberService.getLevel(pd);	
			map.put("pdData", pd);
			return AppUtil.returnObject(new PageData(), map);						
		}	
	  /**判断项目是否有项目经理
			 * @param
			 * @throws Exception
			 */
		@RequestMapping(value="/hasM")
		@ResponseBody
		public Object hasM() throws Exception{
			    Map<String,Object> map = new HashMap<String,Object>();
			    String err ="";
				PageData pd = new PageData();
				pd = this.getPageData();	
				String role = pd.getString("roleId");
				pd = projectmemberService.hasM(pd);	
				String mr = pd.getString("MEMBER_ROLE");
				if(pd.get("MEMBER_ID")!=null && role.equals(mr)){
					err = "error";
				}				
				map.put("result", err);
				return AppUtil.returnObject(new PageData(), map);						
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
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
