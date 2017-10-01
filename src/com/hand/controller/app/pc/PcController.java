package com.hand.controller.app.pc;

//
//import java.util.ArrayList;
//import java.util.List;
//
//import net.sf.json.JSONArray;

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
import com.hand.entity.system.Dictionaries;
import com.hand.service.app.pc.impl.PcService;
import com.hand.service.app.project.ProSecurityManager;
import com.hand.service.app.project.ProjectManager;
import com.hand.service.fhoa.datajur.DatajurManager;
import com.hand.service.system.dictionaries.DictionariesManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.util.AppUtil;
import com.hand.util.Const;
import com.hand.util.Jurisdiction;
//import com.hand.util.Jurisdiction;
import com.hand.util.PageData;

/**
 * 说明：PC管理 创建人：HAND 赵帮恩 创建时间：2017年6月15日
 */
@Controller
@RequestMapping(value = "/pc")
public class PcController extends BaseController {

	String menuUrl = "pc/list.do"; // 菜单地址(权限用)
	@Resource(name = "pcService")
	private PcService pcService;
	@Resource(name = "datajurService")
	private DatajurManager datajurService;
	@Resource(name = "dictionariesService")
	private DictionariesManager dictionariesService;
	@Resource(name = "projectService")
	private ProjectManager projectService;
	@Resource(name = "fhlogService")
	private FHlogManager FHLOG;
	/*@Resource(name="prosecurityService")
	private ProSecurityManager prosecurityService;*/

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增PC");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (pd.getString("G_TIME").equals("")) {
			pd.put("G_TIME", null);
		}
		pd.put("PC_ID", this.get32UUID()); // 主键
	//	pd.put("ROOM_NAME", pd.getString("tag"));
		pd.put("FLAG", "0");
		pcService.save(pd);
		FHLOG.save(Jurisdiction.getUsername(), "新增PC", "PC_LIST","PC_ID",pd.getString("PC_ID"));
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改PC");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (pd.getString("G_TIME").equals("")) {
			pd.put("G_TIME", null);
		}
		pcService.edit(pd);
		pd.put("DATAJUR_ID", pd.getString("PC_ID")); // 主键
		pd.put("ROOM_NAME", pd.getString("tag"));

		// datajurService.edit(pd); //把此员工默认部门及以下部门ID保存到组织数据权限表
		pcService.edit(pd);
		FHLOG.save(Jurisdiction.getUsername(), "修改PC", "PC_LIST","PC_ID",pd.getString("PC_ID"));
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
		logBefore(logger, Jurisdiction.getUsername() + "删除Pc");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
		String update = sdf.format(date);
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		PageData pageData = new PageData();
		pageData = this.getPageData();
		pageData.put("FLAG", "1");
		pageData.put("UPDATEDATE", update);
		pageData.put("UPDATEUSER", username);
		pcService.delete(pageData);
		FHLOG.save(Jurisdiction.getUsername(), "删除PC", "PC_LIST","PC_ID",pageData.getString("PC_ID"));
		out.write("success");
		out.close();
	}

	/**
	 * 列表(检索条件中的部门，只列出此操作用户最高部门权限以下所有部门的员工)
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		// pd.put("FLOOR", pd.getString("level2"));
		//pd.put("PROGRAM", pd.getString("PROGRAM"));
		/* findMyRoomName 找到ROOM和LEVEL并将它们拼凑为ROOM_NAME */
		String BUILDING = pd.getString("BUILDING");
		String ROOM = pd.getString("ROOM");
		String ROOM_NAME = "";
		if (BUILDING != null && ROOM != null) {
			ROOM_NAME = BUILDING.concat(ROOM);
			pd.put("ROOM_NAME", ROOM_NAME);
		} else if (BUILDING != null) {
			pd.put("ROOM_NAME", BUILDING);
		} else if (ROOM != null) {
			pd.put("ROOM_NAME", ROOM);
		}
		page.setPd(pd);
		List<PageData> varList = pcService.list(page);// 列出Dictionaries列表		
	//	mv.addObject("pd", pcService.findById(pd)); // 传入上级所有信息
		mv.setViewName("app/pc/pc_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 判断PC编号是否存在
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/hasU")
	@ResponseBody
	public Object hasU() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "success";
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData pid = pcService.findByNo(pd);
		;
		try {
			if (null != pid) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
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
		List<PageData> projectList = projectService.listAll(pd);
		// 查询闲置的数据字典
		List<Dictionaries> dictionnarieList = dictionariesService.listSubDictByParentId("0c44edffd0cd47ee915248aee93f52a1");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		mv.addObject("projectList", projectList);
		mv.setViewName("app/pc/pc_edit");
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
		List<PageData> projectList = projectService.listAll(pd);
		pd = pcService.findById(pd); // 根据ID读取
		mv.setViewName("app/pc/pc_edit");
		mv.addObject("msg", "edit");
		mv.addObject("projectList", projectList);
		mv.addObject("pd", pd);
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
		logBefore(logger, Jurisdiction.getUsername() + "批量删除PC");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} // 校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			List<String> list = new ArrayList<String>();
			String[] ArrayDATA_IDS = DATA_IDS.split(",");
			for (int i = 0; i < ArrayDATA_IDS.length; i++) {
				list.add(ArrayDATA_IDS[i]);
			}
			pd.put("ArrayDATA_IDS", list);

			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
			String update = sdf.format(date);
			Session session = Jurisdiction.getSession();
			String username = (String) session.getAttribute(Const.SESSION_USERNAME);
			pd.put("FLAG", "1");
			pd.put("UPDATEDATE", update);
			pd.put("UPDATEUSER", username);

			pcService.deleteAll(pd);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 房间
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/level")
	@ResponseBody
	public Object level() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = projectService.findById(pd);
		List<String> list = new ArrayList<>();
		// String PROJECT_ID = pd.getString("PROJECT_ID");
		// pd.put("ROOM_NAME", pcService.findByProgram(PROJECT_ID));
		if (pd.getString("ROOM_NAME").contains("、")) {
			String[] ROOM_NAMEWWW = pd.getString("ROOM_NAME").split("、");
			for (int i = 0; i < ROOM_NAMEWWW.length; i++) {
				list.add(ROOM_NAMEWWW[i]);
			}
			pd.put("length", list.size());
			pd.put("ROOM_NAMEWWW", list);
		} else {
			pd.put("ROOM_NAMEWWW", pd.getString("ROOM_NAME"));
			pd.put("length", "1");// list.get(i)
		}

		/*
		 * pd.put("DICTIONARIES_ID", pd.getString("PROJECT_ROOMS")); //把第一个框的id取到 PageData pd4 = new
		 * PageData(); pd4 = this.getPageData(); pd4 = projectService.findById(pd); pd4.put("LEVEL",
		 * pd.getString("PROJECT_BUILDING")); //取到第一个框的name pd = dictionariesService.findById(pd);
		 * pd.put("ROOM_NAME", pd.getString("NAME")); pd.put("LEVEL", pd4.getString("LEVEL"));
		 * //取到第二个框的name，id原先pd里有 PageData pd2 = new PageData(); pd2 = this.getPageData(); pd2 =
		 * projectService.findById(pd2); pd2.put("DICTIONARIES_ID", pd2.getString("PROJECT_FLOOR"));
		 * pd2 = dictionariesService.findById(pd2); pd.put("FLOOR_NAME", pd2.getString("NAME"));
		 * //取到第三个框的name，id原先pd里有 PageData pd3 = new PageData(); pd3 = this.getPageData(); pd3 =
		 * projectService.findById(pd3); pd3.put("DICTIONARIES_ID", pd.getString("LEVEL")); pd3 =
		 * dictionariesService.findById(pd3); pd.put("LEVEL_NAME", pd3.getString("NAME"));
		 */
		map.put("pdData", pd);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 计数
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/count")
	@ResponseBody
	public Object count() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = pcService.count(pd);
		pd.put("total", pd.get("COUNT"));
		map.put("pdData", pd);
		// PageData pd2 = new PageData();
		// pd2 = this.getPageData();
		// pd2 = pcService.countdepot_have(pd2);
		// map.put("pdData2", pd2);
		// PageData pd3 = new PageData();
		// pd3 = this.getPageData();
		// pd3 = pcService.countdepot_no(pd3);
		// map.put("pdData3", pd3);
		PageData pd2 = new PageData();
		pd2 = this.getPageData();
		pd2 = pcService.countdepot(pd2);
		map.put("pdData2", pd2);
		return AppUtil.returnObject(new PageData(), map);
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
