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
import com.hand.service.app.fittings.FittingsMaManager;
import com.hand.service.app.fittings.FittingsManager;
import com.hand.util.AppUtil;
import com.hand.util.Jurisdiction;
import com.hand.util.ObjectExcelView;
import com.hand.util.PageData;

/**
 * 说明：配件列表 创建时间：2017-09-27
 */
@Controller
@RequestMapping(value = "/fittingsmanager")
public class FittingsMaController extends BaseController {

	String menuUrl = "fittingsmanager/list.do"; // 菜单地址(权限用)
	@Resource(name = "fittingsmaService")
	private FittingsMaManager fittingsmanagerService;

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
		logBefore(logger, Jurisdiction.getUsername() + "新增FittingsManager");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String pfittings_id = pd.getString("FITTINGS_ID");
		List<PageData> properities = fittingsService.findByParent(pd);
		for (PageData proper : properities) {
			String fittings_id = proper.getString("FITTINGS_ID");
			String fi = pd.getString(fittings_id);
			if (null == fi || "".equals(fi)) {
				fi = pd.getString("FITTINGSTYPE" + fittings_id);
			}
			PageData fitting = new PageData();
			fitting.put("FIT_ID", this.get32UUID());
			fitting.put("FITTINGS_ID", pfittings_id); // 主键
			fitting.put("FITTINGS_NO", pd.getString("FITTINGS_NO"));
			fitting.put("FITTINGS_DATAS", fittings_id);
			fitting.put("FITTINGS_DATAVALUE", fi);
			fittingsmanagerService.save(fitting);
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
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
		List<PageData> fittingsList = new ArrayList<PageData>();
		List<PageData> proSecurity = fittingsService.list(page); // 列出ProjectMember列表
		for (PageData pageData : proSecurity) {
			pd.put("PARENT_ID", pageData.getString("FITTINGS_ID"));
			page.setPd(pd);
			List<PageData> list = fittingsService.list(page); // 列出ProjectMember列表
			if (list.size() > 0) {
				pageData.put("input", "0");
			} else {
				pageData.put("input", "1");
			}
			fittingsList.add(pageData);
		}
		map.put("fittingsList", fittingsList);
		map.put("varList", fittingsList);
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "删除FittingsManager");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		fittingsmanagerService.delete(pd);
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
		logBefore(logger, Jurisdiction.getUsername() + "修改FittingsManager");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		fittingsmanagerService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername() + "列表FittingsManager");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PARENT", "PARENT");
		page.setPd(pd);
		List<PageData> varList = fittingsmanagerService.list(page);// 列出FittingsManager列表
		List<PageData> FittingsData = fittingsService.listAll(pd);
		for (PageData fittingdata : varList) {
			String FITTINGS_NO = fittingdata.getString("FITTINGS_NO");
			PageData param = new PageData();
			param.put("FITTINGS_NO", FITTINGS_NO);
			List<PageData> alist = fittingsmanagerService.findByNo(param);
			StringBuffer propertisStr = new StringBuffer("参数:[");
			for (PageData propertis : alist) {
				String propertis_name = propertis.getString("FITTINGS_NAME");
				String propertis_value = propertis.getString("DATAVALUE");
				if ("".equals(propertis_value) || null == propertis_value) {
					propertis_value = propertis.getString("FITTINGS_DATAVALUE");
				}
				propertisStr.append(propertis_name + ":" + propertis_value);
				propertisStr.append(";");
			}
			propertisStr.substring(0, propertisStr.length() - 1);
			propertisStr.append("]");
			fittingdata.put("PARAM", propertisStr.toString());
		}
		mv.setViewName("app/fittings/fittingsma_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("FittingsData", FittingsData);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
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
		Page page = new Page();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PARENT", "PARENT");
		List<PageData> FittingsDatas = fittingsService.listAll(pd);
		page.setPd(pd);
		page.setShowCount(FittingsDatas.size());
		List<PageData> FittingsData = fittingsService.list(page);
		mv.setViewName("app/fittings/fittingsma_add");
		mv.addObject("pd", pd);
		mv.addObject("FittingsData", FittingsData);
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
		List<PageData> propertisList = fittingsmanagerService.findByNo(pd); // 根据ID读取
		for (PageData propertis : propertisList) {
			String datavalue = propertis.getString("DATAVALUE");
			if (!"".equals(datavalue) && null != datavalue) {
				String data = propertis.getString("FITTINGS_DATAS");
				PageData param = new PageData();
				param.put("FITTINGS_ID", data);
				List<PageData> propertisValues = fittingsService.findByParent(param);
				propertis.put("isSelect", true);
				propertis.put("valueList", propertisValues);
			} else {
				propertis.put("isSelect", false);
			}
		}
		// 查找配件名和配件编号
		PageData fittingsDetail = propertisList.get(0);
		mv.setViewName("app/fittings/fittingsma_edit");
		mv.addObject("propertisList", propertisList);
		mv.addObject("fittingsDetail", fittingsDetail);
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
		logBefore(logger, Jurisdiction.getUsername() + "批量删除FittingsManager");
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
			fittingsmanagerService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername() + "导出FittingsManager到excel");
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
		titles.add("备注3"); // 3
		dataMap.put("titles", titles);
		List<PageData> varOList = fittingsmanagerService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("FIT_ID")); // 1
			vpd.put("var2", varOList.get(i).getString("FITTINGS_NAME")); // 2
			vpd.put("var3", varOList.get(i).getString("FITTINGS_VALUE")); // 3
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
