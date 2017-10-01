package com.hand.controller.app.pc;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.entity.system.Role;
import com.hand.entity.system.User;
import com.hand.service.app.pc.impl.PcLeaveService;
import com.hand.service.fhoa.staff.impl.StaffService;
import com.hand.service.system.appuser.AppuserManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.service.system.role.impl.RoleService;
import com.hand.service.system.user.UserManager;
import com.hand.util.Const;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;

import net.sf.json.JSONObject;

/**
 * 说明：PC入场申请 创建时间：2017年7月7日
 */
@Controller
@RequestMapping(value = "/pcleave")
public class PcLeave1Controller extends BaseController {

	String menuUrl = "pcleave/list.do"; // 菜单地址(权限用)
	@Resource(name = "PcLeaveService")
	private PcLeaveService pcLeaveService;
	// 注入activitiService服务
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private TaskService taskService;
	@Resource
	private HistoryService historyService;
	@Resource(name = "roleService")
	private RoleService roleService;
	@Resource(name = "userService")
	private UserManager userService;
	@Resource(name = "appuserService")
	private AppuserManager appuserService;
	@Resource(name = "staffService")
	private StaffService staffService;
	@Resource(name = "fhlogService")
	private FHlogManager FHLOG;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	/*
	 * @RequestMapping(value = "/save") public ModelAndView save() throws Exception { Session
	 * session = Jurisdiction.getSession(); PageData pd = new PageData(); pd = this.getPageData();
	 * 
	 * String username = (String) session.getAttribute(Const.SESSION_USERNAME);
	 * pd.put("USERNAME",username); PageData pdUser = new PageData(); PageData pdStaff = new
	 * PageData();
	 * 
	 * pdUser = userService.findByUsername(pd); if(pdUser == null){ pdUser =
	 * appuserService.findByUsername(pd); } pd.put("USER_ID", pdUser.getString("USERNAME")); pdStaff
	 * = staffService.findByUserId(pd);
	 * 
	 * Date date = new Date(); DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	 * String time = format.format(date); ModelAndView mv = this.getModelAndView(); String building
	 * = pd.getString("level1"); String floor = pd.getString("level2"); String room =
	 * pd.getString("level3"); pd.put("BUILDING", building); pd.put("FLOOR", floor); pd.put("ROOM",
	 * room); pd.put("ID", this.get32UUID()); // 主键 pd.put("USERNAME", username);
	 * //pd.put("USERNAME", pdStaff.getString("NAME")); pd.put("DATE", time); pd.put("STATE",
	 * "未提交");
	 * 
	 * 
	 * pcLeaveService.save(pd); mv.addObject("msg", "success"); mv.setViewName("save_result");
	 * return mv; }
	 * 
	 *//**
		 * 去新增页面
		 * 
		 * @param
		 * @throws Exception
		 */
	/*
	 * @RequestMapping(value = "/goAdd") public ModelAndView goAdd() { String pro; ModelAndView mv =
	 * this.getModelAndView(); PageData pd = new PageData(); pd = this.getPageData(); Session
	 * session = Jurisdiction.getSession(); pd.put("pro", (String)
	 * session.getAttribute(Const.SESSION_USERNAME)); try { pro =
	 * pcLeaveService.getUserPorject(pd).getString("project_name"); } catch (Exception e) { pro =
	 * ""; } pd.put("pro", pro); mv.addObject("msg", "save"); mv.addObject("pd", pd);
	 * mv.setViewName("app/pc/application_edit"); return mv; }
	 * 
	 *//**
		 * 批量删除
		 * 
		 * @param
		 * @throws Exception
		 *//*
		 * @RequestMapping(value = "/deleteAll")
		 * 
		 * @ResponseBody public Object deleteAll() throws Exception { logBefore(logger,
		 * Jurisdiction.getUsername() + "批量删除PC"); if (!Jurisdiction.buttonJurisdiction(menuUrl,
		 * "del")) { return null; } // 校验权限 PageData pd = new PageData(); Map<String, Object> map =
		 * new HashMap<String, Object>(); pd = this.getPageData(); List<PageData> pdList = new
		 * ArrayList<PageData>(); String DATA_IDS = pd.getString("DATA_IDS"); if (null != DATA_IDS
		 * && !"".equals(DATA_IDS)) { String ArrayDATA_IDS[] = DATA_IDS.split(",");
		 * pcLeaveService.deleteAll(ArrayDATA_IDS); pd.put("msg", "ok"); } else { pd.put("msg",
		 * "no"); } pdList.add(pd); map.put("list", pdList); return AppUtil.returnObject(pd, map); }
		 */

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest request,Page page) throws Exception {
		String name;
		logBefore(logger, Jurisdiction.getUsername() + "列表pcleave");
		ModelAndView mv = this.getModelAndView();
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERNAME", username);
		
		// 获取设置分页数据
				String currentPageStr = request.getParameter("page.currentPage");
				String showCountStr = request.getParameter("page.showCount");
				int currentPageInt = 0;
				int showCountInt = 0;
				int currentResult = 0;
				if (!StringUtils.isBlank(currentPageStr)) {
					currentPageInt = Integer.parseInt(currentPageStr);
					page.setCurrentPage(currentPageInt);
				}
				if (!StringUtils.isBlank(showCountStr)) {
					showCountInt = Integer.parseInt(showCountStr);
					page.setShowCount(showCountInt);
				}
				if (!StringUtils.isBlank(currentPageStr) && !StringUtils.isBlank(showCountStr)) {
					currentResult = (currentPageInt - 1) * showCountInt;
					if (currentResult < 0) {
						currentResult = 0;
					}
					pd.put("CURRENT_RESULT", currentResult);
				} else {
					pd.put("CURRENT_RESULT", 0);
				}
				pd.put("SHOW_COUNT", page.getShowCount());
				
		try {
			name = pcLeaveService.staname(pd).getString("NAME");
		} catch (Exception e) {
			name = null;
		}
		pd.put("name", name);
		pd.put("STATENAME", "退场");
		page.setPd(pd);
		List<PageData> varList = pcLeaveService.itemlist(page);// 列出Dictionaries列表
		
		pd.put("STATENAME", "审核通过");
		page.setPd(pd);
		List<PageData> varList2 = pcLeaveService.listtwo(page);// 列出Dictionaries列表
		if(varList2.size()>0){
		  varList.addAll(varList2);
		}
		Long totalResult = (long) varList.size();
		page.setTotalResult(totalResult.intValue());
		page.getTotalPage();
		
		List<PageData> curPageList = fenye(varList, page.getShowCount(), page.getCurrentPage());
		mv.setViewName("app/pc/pc_leave");
		mv.addObject("varList", curPageList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
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
