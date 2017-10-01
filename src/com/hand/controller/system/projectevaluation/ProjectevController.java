package com.hand.controller.system.projectevaluation;


import java.io.PrintWriter;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.service.fhoa.datajur.DatajurManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.service.system.projectevaluation.ProjectevManager;
import com.hand.util.AppUtil;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;


@Controller
@RequestMapping(value="/projectev")
public class ProjectevController extends BaseController {
	
	String menuUrl = "projectev/list.do"; //菜单地址(权限用)
	@Resource(name="projectevService")
	private ProjectevManager projectevService;
	@Resource(name="datajurService")
	private DatajurManager datajurServices;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增projectevaluation");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String[] el = (String[]) pd.get("ANSWER_NAME");
		List<PageData> pds = new ArrayList<>();
		Set<String> keys = pd.keySet();
		List<String> ANSWER_NAMES = new ArrayList<>();
		List<String> ANSWER_MARKS = new ArrayList<>();
		for(String key: keys) {
			if(key.contains("ANSWER_NAME")) {
				int index = Integer.parseInt(key.substring(key.indexOf("[") + 1, key.indexOf("]")));
				ANSWER_NAMES.add(pd.getString(key));
				ANSWER_MARKS.add(pd.getString("ANSWER_MARK[" + index + "]"));
				continue;
			}
			
		}
		for(int i = 0; i < ANSWER_NAMES.size(); i++) {
			String uuid = this.get32UUID();
			PageData p = new PageData();
			
			p.put("EV_ID", uuid);
			p.put("QUESTION_TYPE", pd.get("QUESTION_TYPE"));
			p.put("QUESTION_NAME", pd.get("QUESTION_NAME"));
			p.put("ANSWER_NAME", ANSWER_NAMES.get(i));
			p.put("ANSWER_MARK", ANSWER_MARKS.get(i));
			projectevService.save(p);
			FHLOG.save(Jurisdiction.getUsername(), "新增projectevaluation","PRO_EV_ANSWER","EV_ID",uuid);
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改projectevaluation");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		projectevService.edit(pd);
		FHLOG.save(Jurisdiction.getUsername(), "修改projectevaluation","PRO_EV_ANSWER","EV_ID",pd.getString("EV_ID"));
		pd.put("DATAJUR_ID", pd.getString("EV_ID")); //主键
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
		logBefore(logger, Jurisdiction.getUsername()+"删除projectevaluation");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		projectevService.delete(pd);
		FHLOG.save(Jurisdiction.getUsername(), "删除projectevaluation","PRO_EV_ANSWER","EV_ID",pd.getString("EV_ID"));
		out.write("success");
		out.close();
	}
	
	/**列表(检索条件中的部门，只列出此操作用户最高部门权限以下所有部门的员工)
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表projectevaluation");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");					//检索条件
		if(null != keywords && !"".equals(keywords)){
			//pd.put("keywords", keywords.trim());
		}
		String EV_ID = null == pd.get("EV_ID")?"":pd.get("EV_ID").toString();
		if(null != pd.get("id") && !"".equals(pd.get("id").toString())){
			EV_ID = pd.get("id").toString();
		}
		page.setPd(pd);
		List<PageData> varList=projectevService.list(page);//列出Dictionaries列表		
		mv.addObject("pd", pd);		//传入上级所有信息
		mv.addObject("EV_ID", EV_ID);			//上级ID
		mv.setViewName("system/projectevaluation/projectevaluation_list");
		mv.addObject("varList", varList);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
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
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		mv.setViewName("system/projectevaluation/projectevaluation_edit");
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
		pd = projectevService.findById(pd);	//根据ID读取
		mv.setViewName("system/projectevaluation/projectevaluation_edit");
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
			logBefore(logger, Jurisdiction.getUsername()+"批量删除projectevaluation");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
			PageData pd = new PageData();		
			Map<String,Object> map = new HashMap<String,Object>();
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				projectevService.deleteAll(ArrayDATA_IDS);
				FHLOG.save(Jurisdiction.getUsername(), "批量删除projectevaluation","PRO_EV_ANSWER","EV_ID",DATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
			return AppUtil.returnObject(pd, map);
		}
		
		
		
		@InitBinder
		public void initBinder(WebDataBinder binder){
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
		}
}
