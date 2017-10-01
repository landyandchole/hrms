package com.hand.controller.app.fittings;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.hand.service.app.fittings.FittingsManager;
import com.hand.util.AppUtil;
import com.hand.util.Jurisdiction;
import com.hand.util.ObjectExcelView;
import com.hand.util.PageData;

/**
 * 说明：配件列表 创建时间：2017-09-26
 */
@Controller
@RequestMapping(value = "/fittings")
public class FittingsController extends BaseController {

	String menuUrl = "fittings/list.do"; // 菜单地址(权限用)
	@Resource(name = "fittingsService")
	private FittingsManager fittingsService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增Fittings");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("FITTINGS_ID", this.get32UUID()); // 主键
		fittingsService.save(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "删除Fittings");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		fittingsService.delete(pd);
		fittingsService.deleteP(pd);
		out.write("success");
		out.close();
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改Fittings");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		fittingsService.edit(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Fittings");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PARENT", "PARENT");
		page.setPd(pd);
		List<PageData> varList = fittingsService.list(page); // 列出Fittings列表
		List<PageData> typeList = fittingsService.listAll(pd); // 列出Fittings列表
		mv.setViewName("app/fittings/fittings_list");
		mv.addObject("varList", varList);
		mv.addObject("typeList", typeList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	@RequestMapping(value = "/fittingstype")
	@ResponseBody
	public Object hasproSecurity() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String errInfo = "success";
		Page page = new Page();
		PageData pd = new PageData();
		pd = this.getPageData();
		String PRARENT_ID = (String) pd.get("PARENT_ID");
		String PRARENT = PRARENT_ID.replaceAll("/", "");
		pd.put("PARENT_ID", PRARENT);
		List<PageData> FittingsDatas = fittingsService.listAll(pd);
		page.setPd(pd);
		page.setShowCount(FittingsDatas.size());
		List<PageData> proSecurity = fittingsService.list(page); // 列出ProjectMember列表
		map.put("varList", proSecurity);
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData pda = new PageData();
		pda = this.getPageData();
		String PRARENT_ID = (String) pda.get("PARENT_ID");
		String PRARENT = PRARENT_ID.replaceAll("/", "");
		pd.put("PARENT_ID", PRARENT);
		mv.setViewName("app/fittings/fittings_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = fittingsService.findById(pd); // 根据ID读取
		mv.setViewName("app/fittings/fittings_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去查看页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goList")
	public ModelAndView goList() throws Exception {
		ModelAndView mv = this.getModelAndView();
		Page page = new Page();
		PageData pd = new PageData();
		pd = this.getPageData();
		String PRARENT_ID = (String) pd.get("PARENT_ID");
		String PRARENT = PRARENT_ID.replaceAll("/", "");
		pd.put("PARENT_ID", PRARENT);
		List<PageData> FittingsDatas = fittingsService.listAll(pd);
		page.setPd(pd);
		page.setShowCount(FittingsDatas.size());
		List<PageData> proSecurity = fittingsService.list(page);
		mv.addObject("varList", proSecurity);
		mv.setViewName("app/fittings/fittings_xq");
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 批量删除
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "批量删除Fittings");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} // 校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			fittingsService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出Fittings到excel");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("备注1"); // 1
		titles.add("备注2"); // 2
		dataMap.put("titles", titles);
		List<PageData> varOList = fittingsService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("FITTINGS_ID")); // 1
			vpd.put("var2", varOList.get(i).getString("FITTINGS_NAME")); // 2
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
