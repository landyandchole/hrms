package com.hand.controller.system.appuser;

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
import com.hand.entity.system.Role;
import com.hand.service.system.appuser.AppuserManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.service.system.role.RoleManager;
import com.hand.util.AppUtil;
import com.hand.util.Jurisdiction;
import com.hand.util.MD5;
import com.hand.util.ObjectExcelView;
import com.hand.util.PageData;

/**
 * 类名称：会员管理 创建人：HAND 赵帮恩 创建时间：2017年6月15日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/happuser")
public class AppuserController extends BaseController {

	String menuUrl = "happuser/listUsers.do"; // 菜单地址(权限用)
	@Resource(name = "appuserService")
	private AppuserManager appuserService;
	@Resource(name = "roleService")
	private RoleManager roleService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;

	/**
	 * 显示用户列表
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/listUsers")
	public ModelAndView listUsers(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			String keywords = pd.getString("keywords"); // 检索条件 关键词
			if (null != keywords && !"".equals(keywords)) {
				pd.put("keywords", keywords.trim());
			}
			page.setPd(pd);
			List<PageData> userList = appuserService.listPdPageUser(page); // 列出会员列表
			pd.put("PARENT_ID", "2");
			List<Role> roleList = roleService.listAllRolesByPaId(pd); // 列出会员组角色
			mv.setViewName("system/appuser/appuser_list");
			mv.addObject("userList", userList);
			mv.addObject("roleList", roleList);
			mv.addObject("pd", pd);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 去新增用户页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAddU")
	public ModelAndView goAddU() throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ROLE_ID", "2");
		List<Role> roleList = roleService.listAllRolesByPId(pd); // 列出会员组角色
		mv.setViewName("system/appuser/appuser_edit");
		mv.addObject("msg", "saveU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}

	/**
	 * 保存用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveU")
	public ModelAndView saveU() throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		logBefore(logger, Jurisdiction.getUsername() + "新增会员");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USER_ID", this.get32UUID()); // ID
		pd.put("RIGHTS", "");
		pd.put("LAST_LOGIN", ""); // 最后登录时间
		pd.put("IP", ""); // IP
		pd.put("PASSWORD", MD5.md5(pd.getString("PASSWORD")));
		pd.put("ID_", pd.getString("USERNAME"));
		pd.put("FIRST_", pd.getString("NAME"));
		pd.put("USER_ID_", pd.getString("USERNAME"));
		pd.put("GROUP_ID_", pd.getString("ROLE_ID"));
		if (null == appuserService.findByUsername(pd)) {
			appuserService.saveU(pd); // 判断新增权限
			FHLOG.save(Jurisdiction.getUsername(), "新增普通用户","SYS_APP_USER","USERNAME",pd.getString("USERNAME"));
			mv.addObject("msg", "success");
		} else {
			mv.addObject("msg", "failed");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 判断用户名是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/hasU")
	@ResponseBody
	public Object hasU() {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			if (appuserService.findByUsername(pd) != null) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo); // 返回结果
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
			if (appuserService.findByEmail(pd) != null) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 判断编码是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/hasN")
	@ResponseBody
	public Object hasN() {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			if (appuserService.findByNumber(pd) != null) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 删除用户
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteU")
	public void deleteU(PrintWriter out) throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		logBefore(logger, Jurisdiction.getUsername() + "删除会员");
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData appUser = appuserService.findByUiId(pd);
		if (appUser != null) {
			pd.put("USER_ID_", appUser.getString("USERNAME"));
			pd.put("ID_", appUser.getString("USERNAME"));
			appuserService.deleteU(pd);
			FHLOG.save(Jurisdiction.getUsername(), "删除普通用户","SYS_APP_USER","USER_ID",pd.getString("USER_ID"));
		}
		out.write("success");
		out.close();
	}

	/**
	 * 修改用户
	 * 
	 * @param out
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editU")
	public ModelAndView editU(PrintWriter out) throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		logBefore(logger, Jurisdiction.getUsername() + "修改会员");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (pd.getString("PASSWORD") != null && !"".equals(pd.getString("PASSWORD"))) {
			pd.put("PASSWORD", MD5.md5(pd.getString("PASSWORD")));
		}
		PageData appUser = appuserService.findByUiId(pd);
		if (!appUser.getString("NAME").equals(pd.getString("NAME"))) {
			pd.put("nameIsChange", "true");
			pd.put("ID_", pd.getString("USERNAME"));
			pd.put("FIRST_", pd.getString("NAME"));
		} else {
			pd.put("nameIsChange", "false");
		}
		if (!appUser.getString("ROLE_ID").equals(pd.getString("ROLE_ID"))) {
			pd.put("roleIsChange", "true");
			pd.put("USER_ID_", pd.getString("USERNAME"));
			pd.put("GROUP_ID_", pd.getString("ROLE_ID"));
		} else {
			pd.put("roleIsChange", "false");
		}
		appuserService.updateU(pd);
		FHLOG.save(Jurisdiction.getUsername(), "修改普通用户","SYS_APP_USER","USERNAME",pd.getString("USERNAME"));
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 去修改用户页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/goEditU")
	public ModelAndView goEditU() {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd.put("ROLE_ID", "2");
			List<Role> roleList = roleService.listAllRolesByPId(pd);// 列出会员组角色
			pd = appuserService.findByUiId(pd); // 根据ID读取
			mv.setViewName("system/appuser/appuser_edit");
			mv.addObject("msg", "editU");
			mv.addObject("pd", pd);
			mv.addObject("roleList", roleList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 批量删除
	 * 
	 * @return
	 */
	@RequestMapping(value = "/deleteAllU")
	@ResponseBody
	public Object deleteAllU() {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
		} // 校验权限
		logBefore(logger, Jurisdiction.getUsername() + "批量删除会员");
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String USER_IDS = pd.getString("USER_IDS");
			if (null != USER_IDS && !"".equals(USER_IDS)) {
				String ArrayUSER_IDS[] = USER_IDS.split(",");
				appuserService.deleteAllU(ArrayUSER_IDS);
				FHLOG.save(Jurisdiction.getUsername(), "批量删除普通用户","SYS_APP_USER","USER_ID",USER_IDS);
				pd.put("msg", "ok");
			} else {
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 导出会员信息到excel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() {
		logBefore(logger, Jurisdiction.getUsername() + "导出会员资料");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			if (Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
				String keywords = pd.getString("keywords");
				if (null != keywords && !"".equals(keywords)) {
					pd.put("keywords", keywords.trim());
				}
				String lastLoginStart = pd.getString("lastLoginStart");
				String lastLoginEnd = pd.getString("lastLoginEnd");
				if (lastLoginStart != null && !"".equals(lastLoginStart)) {
					pd.put("lastLoginStart", lastLoginStart + " 00:00:00");
				}
				if (lastLoginEnd != null && !"".equals(lastLoginEnd)) {
					pd.put("lastLoginEnd", lastLoginEnd + " 00:00:00");
				}
				Map<String, Object> dataMap = new HashMap<String, Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("用户名"); // 1
				titles.add("编号"); // 2
				titles.add("姓名"); // 3
				titles.add("手机号"); // 4
				titles.add("身份证号"); // 5
				titles.add("等级"); // 6
				titles.add("邮箱"); // 7
				titles.add("最近登录"); // 8
				titles.add("到期时间"); // 9
				titles.add("上次登录IP"); // 10
				dataMap.put("titles", titles);
				List<PageData> userList = appuserService.listAllUser(pd);
				List<PageData> varList = new ArrayList<PageData>();
				for (int i = 0; i < userList.size(); i++) {
					PageData vpd = new PageData();
					vpd.put("var1", userList.get(i).getString("USERNAME")); // 1
					vpd.put("var2", userList.get(i).getString("NUMBER")); // 2
					vpd.put("var3", userList.get(i).getString("NAME")); // 3
					vpd.put("var4", userList.get(i).getString("PHONE")); // 4
					vpd.put("var5", userList.get(i).getString("SFID")); // 5
					vpd.put("var6", userList.get(i).getString("ROLE_NAME")); // 6
					vpd.put("var7", userList.get(i).getString("EMAIL")); // 7
					vpd.put("var8", userList.get(i).getString("LAST_LOGIN")); // 8
					vpd.put("var9", userList.get(i).getString("END_TIME")); // 9
					vpd.put("var10", userList.get(i).getString("IP")); // 10
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView();
				mv = new ModelAndView(erv, dataMap);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}

}
