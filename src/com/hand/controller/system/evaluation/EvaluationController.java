package com.hand.controller.system.evaluation;


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
import com.hand.service.system.evaluation.EvaluationManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.util.AppUtil;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;

/** 
 * 说明：PC管理
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 */
@Controller
@RequestMapping(value="/evaluation")
public class EvaluationController extends BaseController {
	
	String menuUrl = "evaluation/list.do"; //菜单地址(权限用)
	@Resource(name="evaluationService")
	private EvaluationManager evaluationService;
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
		logBefore(logger, Jurisdiction.getUsername()+"新增evaluation");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String[] el = (String[]) pd.get("EV_ANSWER_NAME");
		List<PageData> pds = new ArrayList<>();
		Set<String> keys = pd.keySet();
		List<String> EV_ANSWER_NAMES = new ArrayList<>();
		List<String> EV_ANSWER_MARKS = new ArrayList<>();
		for(String key: keys) {
			if(key.contains("EV_ANSWER_NAME")) {
				int index = Integer.parseInt(key.substring(key.indexOf("[") + 1, key.indexOf("]")));
				EV_ANSWER_NAMES.add(pd.getString(key));
				EV_ANSWER_MARKS.add(pd.getString("EV_ANSWER_MARK[" + index + "]"));
				continue;
			}
			
		}
		for(int i = 0; i < EV_ANSWER_NAMES.size(); i++) {
			String uuid = this.get32UUID();
			PageData p = new PageData();
			p.put("EV_ANSWER_ID", uuid);
			p.put("EV_QUESTION_TYPE", pd.get("EV_QUESTION_TYPE"));
			p.put("EV_QUESTION_NAME", pd.get("EV_QUESTION_NAME"));
			p.put("EV_ANSWER_NAME", EV_ANSWER_NAMES.get(i));
			p.put("EV_ANSWER_MARK", EV_ANSWER_MARKS.get(i));
			evaluationService.save(p);
			FHLOG.save(Jurisdiction.getUsername(), "新增evaluation","EV_ANSWER","EV_ANSWER_ID",uuid);
			
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
		logBefore(logger, Jurisdiction.getUsername()+"修改evaluation");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		evaluationService.edit(pd);
		FHLOG.save(Jurisdiction.getUsername(), "修改evaluation","EV_ANSWER","EV_ANSWER_ID",pd.getString("EV_ANSWER_ID"));
		pd.put("DATAJUR_ID", pd.getString("EV_ANSWER_ID")); //主键
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
		logBefore(logger, Jurisdiction.getUsername()+"删除evaluation");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		evaluationService.delete(pd);
		FHLOG.save(Jurisdiction.getUsername(), "删除evaluation","EV_ANSWER","EV_ANSWER_ID",pd.getString("EV_ANSWER_ID"));
		out.write("success");
		out.close();
	}
	
	/**列表(检索条件中的部门，只列出此操作用户最高部门权限以下所有部门的员工)
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表evaluation");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");					//检索条件
		if(null != keywords && !"".equals(keywords)){
			//pd.put("keywords", keywords.trim());
		}
		String EV_ANSWER_ID = null == pd.get("EV_ANSWER_ID")?"":pd.get("EV_ANSWER_ID").toString();
		if(null != pd.get("id") && !"".equals(pd.get("id").toString())){
			EV_ANSWER_ID = pd.get("id").toString();
		}
		page.setPd(pd);
		List<PageData> varList=evaluationService.list(page);//列出Dictionaries列表		
		mv.addObject("pd", pd);		//传入上级所有信息
		mv.addObject("EV_ANSWER_ID", EV_ANSWER_ID);			//上级ID
		mv.setViewName("system/evaluation/evaluation_list");
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
		mv.setViewName("system/evaluation/evaluation_edit");
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
		pd = evaluationService.findById(pd);	//根据ID读取
		mv.setViewName("system/evaluation/evaluation_edit");
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
			logBefore(logger, Jurisdiction.getUsername()+"批量删除evaluation");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
			PageData pd = new PageData();		
			Map<String,Object> map = new HashMap<String,Object>();
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				evaluationService.deleteAll(ArrayDATA_IDS);
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
