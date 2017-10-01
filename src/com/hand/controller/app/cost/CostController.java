package com.hand.controller.app.cost;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.hand.service.app.cost.CostManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.util.AppUtil;
import com.hand.util.Const;
import com.hand.util.Jurisdiction;
import com.hand.util.ObjectExcelView;
import com.hand.util.PageData;

/** 
 * 说明：费用
 * 创建时间：2017-07-06
 */
@Controller
@RequestMapping(value="/cost")
public class CostController extends BaseController {
	
	String menuUrl = "cost/list.do"; //菜单地址(权限用)
	@Resource(name="costService")
	private CostManager costService;
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
		logBefore(logger, Jurisdiction.getUsername()+"新增Cost");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COST_ID", this.get32UUID());	//主键
		pd.put("FLAG","0");
		Date date=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
		String update=sdf.format(date);	
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		pd.put("CREATIONDATE",update);
		pd.put("CREATIONUSER",username);
		costService.save(pd);
		FHLOG.save(Jurisdiction.getUsername(), "新增费用","PROJECT_COST","COST_ID",pd.getString("COST_ID"));
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Cost");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData cost=costService.findById(pd);
		cost.put("FLAG", "1");
		  Date date=new Date();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
			String update=sdf.format(date);	
			String username = (String) session.getAttribute(Const.SESSION_USERNAME);
			cost.put("UPDATEDATE",update);
			cost.put("UPDATEUSER",username);
			FHLOG.save(Jurisdiction.getUsername(), "删除费用","PROJECT_COST","COST_ID",pd.getString("COST_ID"));
		costService.edit(cost);
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
		logBefore(logger, Jurisdiction.getUsername()+"修改Cost");
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
		FHLOG.save(Jurisdiction.getUsername(), "修改费用","PROJECT_COST","COST_ID",pd.getString("COST_ID"));
		costService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Cost");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String identification = pd.getString("identification");	
		if(null != identification && !"".equals(identification)){
			pd.remove("COST_ITEMS");
			pd.remove("COST_USEDATE");
			pd.remove("COST_FOUNDER");
		}
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = costService.list(page);	//列出Cost列表
		mv.setViewName("app/cost/cost_list");
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
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		List<PageData> staffList = costService.getCostFreeStaff(pd);
		for(int i= 0;i<staffList.size(); i++){
			String founder = staffList.get(i).getString("USER_ID");
			if(username.equals(founder)){
				PageData pdf = new PageData();
				pdf = this.getPageData();
				Object founders= staffList.get(i).get("NO");
				Object founderName= staffList.get(i).get("NAME");
				pdf.put("founders", founders);
				pdf.put("founderName", founderName);
				mv.addObject("pdf", pdf);
				break;
			}else{
				PageData pdf = new PageData();
				pdf = this.getPageData();
				pdf.put("founders",username);
				pdf.put("founderNames", null);
				mv.addObject("pdf", pdf);
			}
				
		}
		mv.addObject("staffList",staffList);
		mv.setViewName("app/cost/cost_edit");
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
		pd = this.getPageData();
		pd = costService.findById(pd);	//根据ID读取
		List<PageData> staffList = costService.getCostFreeStaff(pd);
		mv.addObject("staffList",staffList);
		mv.setViewName("app/cost/cost_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Cost");
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
			pd.put("COST_ID", ArrayDATA_IDS[i]);
			costService.editMemberAll(pd);
		}
		FHLOG.save(Jurisdiction.getUsername(), "批量删除费用","PROJECT_COST","COST_ID",DATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Cost到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("备注1");	//1
		titles.add("费用类目");	//2
		titles.add("费用金额");	//3
		titles.add("创建时间");	//4
		dataMap.put("titles", titles);
		List<PageData> varOList = costService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("COST_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("COST_ITEMS"));	    //2
			vpd.put("var3", varOList.get(i).get("COST_MONEY").toString());	//3
			vpd.put("var4", varOList.get(i).getString("COST_USEDATE"));	    //4
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
	
	public boolean flag() throws Exception{
		Session session = Jurisdiction.getSession();
		boolean flag = false;
		User user = (User)session.getAttribute(Const.SESSION_USER);	
		if(user != null ){
			flag = true;
		}
		return flag;
	}
}
