package com.hand.controller.app.pc;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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
import com.hand.service.app.pc.PcManager;
import com.hand.service.app.pc.impl.PcLeaveItemService;
import com.hand.service.app.pc.impl.PcLeaveService;
import com.hand.service.app.project.ProSecurityManager;
import com.hand.service.app.project.ProjectManager;
import com.hand.service.fhoa.staff.impl.StaffService;
import com.hand.service.system.appuser.AppuserManager;
import com.hand.service.system.dictionaries.DictionariesManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.service.system.role.impl.RoleService;
import com.hand.service.system.user.UserManager;
import com.hand.util.AppUtil;
import com.hand.util.Const;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;

import net.sf.json.JSONObject;

/**
 * 说明：PC入场申请 创建时间：2017年7月7日
 */
@Controller
@RequestMapping(value = "/pca")
public class PcLeaveController extends BaseController {

	String menuUrl = "pca/list.do"; // 菜单地址(权限用)
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
	@Resource(name = "projectService")
	private ProjectManager projectService;
	@Resource(name = "fhlogService")
	private FHlogManager FHLOG;
	@Resource(name = "prosecurityService")
	private ProSecurityManager prosecurityService;
	@Resource(name = "pcService")
	private PcManager pcService;
	@Resource(name = "dictionariesService")
	private DictionariesManager dictionariesService;
	@Resource(name = "pcLeaveItemService")
	private PcLeaveItemService pcLeaveItemService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		String time = format.format(date);
		if (pd.containsKey("NAME")) {
			pd.put("PROJECT_ID", pd.getString("NAME"));
			PageData pd2 = projectService.findById(pd);
			pd.put("NAME", pd2.getString("PROJECT_NAME"));
		}

		// 组装pc_leave表中的数据
		PageData pc_leave = new PageData();
		int total_pcnumber = 0;
		String pc_leave_id = this.get32UUID();
		pc_leave.put("ID", pc_leave_id);
		pc_leave.put("USERNAME", username);
		pc_leave.put("NAME", pd.getString("NAME"));
		pc_leave.put("DATE", time);
		pc_leave.put("STATE", "入场流程未提交");
		pc_leave.put("PROJECT_ID", pd.getString("PROJECT_ID"));
		pc_leave.put("PCSTATE", "0");
		pc_leave.put("REMARK", pd.getString("REMARK"));

		// 组装pc_leave_item表的数据
		String rams = pd.getString("P_RAMS");
		String hdisks = pd.getString("P_HDISKS");
		String types = pd.getString("P_TYPES");
		String pcnumbers = pd.getString("P_PCNUMBERS");
		String purposes = pd.getString("P_PURPOSES");
		String einlasss = pd.getString("P_EINLASSS");
		String buildings = pd.getString("P_BUILDINGS");
		String rooms = pd.getString("P_ROOMS");
		String roomnames = pd.getString("P_ROOM_NAMES");
		String accessoriess = pd.getString("P_ACCESSORIESS");
		String fnumbers = pd.getString("P_FPCNUMBER");
		String fbuildings = pd.getString("P_FBUILDINGS");
		String frooms = pd.getString("P_FROOMS");
		String froomnames = pd.getString("P_FROOM_NAMES");
		String[] ramArr = rams.split(",");
		String[] hdiskArr = hdisks.split(",");
		String[] typeArr = types.split(",");
		String[] pcnumberArr = pcnumbers.split(",");
		String[] purposeArr = purposes.split(",");
		String[] einlassArr = einlasss.split(",");
		String[] buildingArr = buildings.split(",");
		String[] roomArr = rooms.split(",");
		String[] roomnameArr = roomnames.split(",");
		String[] accessoriesArr = accessoriess.split(",");
		String[] fnumbersArr = fnumbers.split(",");
		String[] fbuildingArr = fbuildings.split(",");
		String[] froomArr = frooms.split(",");
		String[] froomnameArr = froomnames.split(",");
		List<PageData> items = new ArrayList<PageData>();

		// 处理电脑item的信息
		for (int i = 0; i < ramArr.length; i++) {
			PageData item = new PageData();
			item.put("ID", this.get32UUID());
			item.put("PC_LEAVEID", pc_leave_id);
			item.put("USERNAME", username);
			item.put("RAM", ramArr[i]);
			item.put("HDISK", hdiskArr[i]);
			item.put("TYPE", typeArr[i]);
			item.put("ACCESSORIES", "");
			item.put("PURPOSE", purposeArr[i]);
			if (!pd.containsKey("NAME")) {
				item.put("ROOM_NAME", buildingArr[i] + roomArr[i]);
			} else {
				item.put("ROOM_NAME", roomnameArr[i]);
			}
			item.put("EINLASS", einlassArr[i]);
			item.put("PCNUMBER", pcnumberArr[i]);
			// 累计pc台数
			if ((!"".equals(pcnumberArr[i])) && (pcnumberArr[i] != null)) {
				total_pcnumber += Integer.parseInt(pcnumberArr[i]);
			}
			items.add(item);
		}
		pc_leave.put("PCNUMBER", total_pcnumber);

		// 处理配件item的信息
		for (int i = 0; i < accessoriesArr.length; i++) {
			PageData fit = new PageData();
			fit.put("ID", this.get32UUID());
			fit.put("PC_LEAVEID", pc_leave_id);
			fit.put("USERNAME", username);
			fit.put("ACCESSORIES", accessoriesArr[i]);
			fit.put("PCNUMBER", fnumbersArr[i]);
			if (!pd.containsKey("NAME")) {
				fit.put("ROOM_NAME", fbuildingArr[i] + froomArr[i]);
			} else {
				fit.put("ROOM_NAME", froomnameArr[i]);
			}
			items.add(fit);
		}

		pcLeaveService.save(pc_leave, items);
		FHLOG.save(Jurisdiction.getUsername(), "PC申请新增", "pc_leave", "ID", pd.getString("ID"));
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	@RequestMapping(value = "/hasapplication")
	@ResponseBody
	public Object hasapplication() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> Leavelist = pcLeaveService.LeaveItemlist(pd); // 列出Project列表
		map.put("Leavelist", Leavelist);
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
	public ModelAndView goAdd() {
		String pro = null;
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		mv.setViewName("app/pc/application_edit");
		return mv;
	}

	/**
	 * 判断项目编号是否存在
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
		Session session = Jurisdiction.getSession();
		pd.put("pro", (String) session.getAttribute(Const.SESSION_USERNAME));
		pd.put("name", pd.getString("NAME"));
		PageData no = pcLeaveService.getUserPorject(pd);
		try {
			if (null == no) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 判断项目编号是否存在
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/hasP")
	@ResponseBody
	public Object hasP() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		Session session = Jurisdiction.getSession();
		pd.put("pro", (String) session.getAttribute(Const.SESSION_USERNAME));// 用户名称
		pd.put("name", pd.getString("NAME"));// 项目名称
		List<PageData> pdList = pcLeaveService.getByname(pd);
		map.put("pdList", pdList);
		return AppUtil.returnObject(new PageData(), map);
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
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			pcLeaveService.deleteAll(ArrayDATA_IDS);
			FHLOG.save(Jurisdiction.getUsername(), "PC删除", "pc_leave", "ID", DATA_IDS);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		String name;
		logBefore(logger, Jurisdiction.getUsername() + "列表pc");
		ModelAndView mv = this.getModelAndView();
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERNAME", username);
		try {
			name = pcLeaveService.staname(pd).getString("NAME");
		} catch (Exception e) {
			name = null;
		}
		pd.put("name", name);
		pd.put("STATENAME", "入场");
		page.setPd(pd);
		List<PageData> varList = pcLeaveService.list(page);// 列出Dictionaries列表
		mv.setViewName("app/pc/pc_application");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/listLeave")
	public ModelAndView listLeave(Page page) throws Exception {
		String name;
		logBefore(logger, Jurisdiction.getUsername() + "列表pcLeave");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PCSTATE", "0");
		page.setPd(pd);
		List<PageData> varList = pcLeaveService.list(page);// 列出Dictionaries列表
		mv.setViewName("app/pc/pc_leave");
		mv.addObject("varList", varList);
		/* mv.addObject("pd", pd); */
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 信息安全人员审批
	 * 
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/audit_infoSafes")
	@ResponseBody
	public Object audit_infoSafes(int status, String taskId, String pcstate, String comment) {
		JSONObject result = new JSONObject();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			Task task = taskService.createTaskQuery() // 创建任务查询
					.taskId(taskId) // 根据任务id查询
					.singleResult();
			pd.put("PROCESSINSTANCEID", task.getProcessInstanceId());
			pd = pcLeaveService.getLeaveByTaskId(pd);
			Map<String, Object> variables = new HashMap<String, Object>();
			Session session = Jurisdiction.getSession();
			User user = (User) session.getAttribute(Const.SESSION_USER);
			if (pcstate.equals("1")) {
				if (status == 1) {// status==1位批准
					pd.put("STATE", "退场审核通过");
					pd.put("PCSTATE", "2");
					variables.put("msg", "通过");
					String pc_leaveId = (String) taskService.getVariable(taskId, "pc_leaveId");
					pd.put("PC_LEAVEID", pc_leaveId);
					pd.put("PC_STATE", "退场准备中");
					afterOutApprovePass(taskId);
				} else {
					pd.put("STATE", "退场审核未通过");
					pd.put("PCSTATE", "1");
					variables.put("msg", "未通过");
					if (StringUtils.isBlank(comment)) {
						comment = "不同意！";
					}
				}
			} else {
				if (status == 1) {// status==1位批准
					pd.put("STATE", "入场审核通过");
					pd.put("PCSTATE", "1");
					variables.put("msg", "通过");
					afterEnterApprovePass(taskId);
				} else {
					pd.put("STATE", "入场审核未通过");
					pd.put("PCSTATE", "0");
					variables.put("msg", "未通过");
					if (StringUtils.isBlank(comment)) {
						comment = "不同意！";
					}
				}
			}
			taskService.setAssignee(task.getId(), user.getUSERNAME());
			String pc_leaveId = (String) taskService.getVariable(taskId, "pc_leaveId");
			pd.put("ID", pc_leaveId);
			pd.put("TASKID", task.getId());
			pd.put("PROCESSINSTANCEID", task.getProcessInstanceId());
			pcLeaveService.updateState(pd);
			FHLOG.save(Jurisdiction.getUsername(), "PC审批", "pc_leave", "ID", pc_leaveId);
			Role currentRole = roleService.getRoleById(user.getROLE_ID());
			if (StringUtils.isBlank(comment)) {
				comment = "同意！";
			}
			Authentication.setAuthenticatedUserId(user.getNAME() + "[" + currentRole.getROLE_NAME() + "]");
			taskService.addComment(taskId, task.getProcessInstanceId(), comment);
			taskService.complete(taskId, variables);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 项目经理审批
	 * 
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/audit_pm")
	@ResponseBody
	public Object audit_pm(int status, String taskId, String pcstate, String comment) {
		JSONObject result = new JSONObject();
		Map<String, Object> variables = new HashMap<String, Object>();
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		Task task = taskService.createTaskQuery() // 创建任务查询
				.taskId(taskId) // 根据任务id查询
				.singleResult();

		PageData pd = new PageData();
		try {
			if (pcstate.equals("1")) {
				if (status == 1) {// status==1位批准
					pd.put("STATE", "退场审核中");
					pd.put("PCSTATE", "1");
					variables.put("msg", "通过");
				} else {
					pd.put("STATE", "退场审核未通过");
					pd.put("PCSTATE", "1");
					variables.put("msg", "未通过");
					if (StringUtils.isBlank(comment)) {
						comment = "不同意！";
					}
				}
			} else {
				if (status == 1) {
					pd.put("STATE", "入场审核中");
					pd.put("PCSTATE", "0");
					variables.put("msg", "通过");
				} else {
					pd.put("STATE", "入场审核未通过");
					pd.put("PCSTATE", "0");
					variables.put("msg", "未通过");
					if (StringUtils.isBlank(comment)) {
						comment = "不同意！";
					}
				}
			}

			// 查询项目总监
			PageData paramPd = new PageData();
			paramPd.put("PROCESSINSTANCEID", task.getProcessInstanceId());
			PageData leave = pcLeaveService.getLeaveByTaskId(paramPd);
			// PageData project = projectService.findById(leave);
			paramPd.put("NAME", "PD");
			paramPd.put("PROJECT_ID", leave.getString("PROJECT_ID"));
			PageData projectPD = pcLeaveService.findByProjectIdAndRoleName(paramPd);
			variables.put("pdassignee", projectPD.getString("USER_ID"));
			variables.put("pdname", projectPD.getString("USER_ID"));

			// 设置当前任务的执行人
			taskService.setAssignee(task.getId(), user.getUSERNAME());

			pd.put("ID", leave.getString("ID"));
			pd.put("TASKID", task.getId());
			pd.put("PROCESSINSTANCEID", task.getProcessInstanceId());
			if (pcstate.equals("1")) {
				pcLeaveItemService.updateState(pd);
			} else {
				pcLeaveService.updateState(pd);
			}
			Role currentRole = roleService.getRoleById(user.getROLE_ID());
			if (StringUtils.isBlank(comment)) {
				comment = "同意！";
			}
			Authentication.setAuthenticatedUserId(user.getNAME() + "[" + currentRole.getROLE_NAME() + "]");
			taskService.addComment(taskId, task.getProcessInstanceId(), comment);
			taskService.complete(taskId, variables);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return result;
	}

	/**
	 * 项目总监审批、部长审批
	 * 
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/audit_pd")
	@ResponseBody
	public Object audit_pd(int status, String taskId, String pcstate, String comment) {
		JSONObject result = new JSONObject();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			Task task = taskService.createTaskQuery() // 创建任务查询
					.taskId(taskId) // 根据任务id查询
					.singleResult();
			pd.put("PROCESSINSTANCEID", task.getProcessInstanceId());
			pd = pcLeaveService.getLeaveByTaskId(pd);
			Map<String, Object> variables = new HashMap<String, Object>();
			Session session = Jurisdiction.getSession();
			User user = (User) session.getAttribute(Const.SESSION_USER);
			taskService.setAssignee(task.getId(), user.getUSERNAME());
			List<PageData> pdList = pcLeaveService.getnextpd(pd);
			StringBuilder str = new StringBuilder();
			for (PageData pageData : pdList) {
				str.append(pageData.getString("USER_ID") + ",");
			}
			String ss = str.substring(0, str.length() - 1);
			variables.put("infoSafes", ss);
			if (pcstate.equals("1")) {
				if (status == 1) {// status==1位批准
					pd.put("STATE", "退场审核中");
					pd.put("PCSTATE", "1");
					variables.put("msg", "通过");
				} else {
					pd.put("STATE", "退场审核未通过");
					pd.put("PCSTATE", "1");
					variables.put("msg", "未通过");
					if (StringUtils.isBlank(comment)) {
						comment = "不同意！";
					}
				}
			} else {
				if (status == 1) {
					pd.put("STATE", "入场审核中");
					pd.put("PCSTATE", "0");
					variables.put("msg", "通过");
				} else {
					pd.put("STATE", "入场审核未通过");
					pd.put("PCSTATE", "0");
					variables.put("msg", "未通过");
					if (StringUtils.isBlank(comment)) {
						comment = "不同意！";
					}
				}
			}
			String pc_leaveId = (String) taskService.getVariable(taskId, "pc_leaveId");
			pd.put("ID", pc_leaveId);
			pd.put("TASKID", task.getId());
			pd.put("PROCESSINSTANCEID", task.getProcessInstanceId());
			if (pcstate.equals("1")) {
				pcLeaveItemService.updateState(pd);
			} else {
				pcLeaveService.updateState(pd);
			}
			FHLOG.save(Jurisdiction.getUsername(), "PC审批", "pc_leave", "ID", pc_leaveId);
			Role currentRole = roleService.getRoleById(user.getROLE_ID());
			if (StringUtils.isBlank(comment)) {
				comment = "同意！";
			}
			Authentication.setAuthenticatedUserId(user.getNAME() + "[" + currentRole.getROLE_NAME() + "]");
			taskService.addComment(taskId, task.getProcessInstanceId(), comment);
			taskService.complete(taskId, variables);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 撤回
	 * 
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/withdraw")
	@ResponseBody
	public Object withdraw(int status) {
		JSONObject result = new JSONObject();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String processInstanceId = pd.getString("processInstanceId");
			String pcstate = pd.getString("status");
			Task task = taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult();
			Map<String, Object> variables = new HashMap<String, Object>();
			Session session = Jurisdiction.getSession();
			User user = (User) session.getAttribute(Const.SESSION_USER);
			if (pcstate.equals("3")) {
				pd.put("STATE", "退场流程撤回");
				pd.put("PCSTATE", "4");
				variables.put("msg", "未通过");
			} else {
				pd.put("STATE", "入场流程撤回");
				pd.put("PCSTATE", "2");
				variables.put("msg", "未通过");
			}
			// 设置当前任务的执行人
			taskService.setAssignee(task.getId(), user.getUSERNAME());
			String pc_leaveId = (String) taskService.getVariable(task.getId(), "pc_leaveId");
			pd.put("ID", pc_leaveId);
			pd.put("TASKID", task.getId());
			pd.put("PROCESSINSTANCEID", task.getProcessInstanceId());
			pcLeaveService.updateState(pd);
			FHLOG.save(Jurisdiction.getUsername(), "PC撤回", "pc_leave", "ID", pc_leaveId);
			Role currentRole = roleService.getRoleById(user.getROLE_ID());
			String comment = pd.getString("comment");
			if (StringUtils.isBlank(comment)) {
				comment = "流程撤回";
			}
			Authentication.setAuthenticatedUserId(user.getNAME() + "[" + currentRole.getROLE_NAME() + "]");
			taskService.addComment(task.getId(), task.getProcessInstanceId(), comment);
			taskService.complete(task.getId(), variables);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
		}
		return result;
	}

	/**
	 * 批量审批
	 * 
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/audit_all")
	@ResponseBody
	public Object audit_all(int status) {
		JSONObject result = new JSONObject();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String DATA_IDS = pd.getString("DATA_IDS");
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for (int i = 0; i < ArrayDATA_IDS.length; i++) {
				String taskId = ArrayDATA_IDS[i];
				Task task = taskService.createTaskQuery() // 创建任务查询
						.taskId(taskId) // 根据任务id查询
						.singleResult();
				pd.put("PROCESSINSTANCEID", task.getProcessInstanceId());
				pd = pcLeaveService.getLeaveByTaskId(pd);
				String taskName = task.getName();
				if (taskName.equals("部长审批") || taskName.equals("项目总监审批")) {
					audit_pd(status, taskId, pd.getString("PCSTATE"), "");
				} else if (taskName.equals("信息安全人员")) {
					audit_infoSafes(status, taskId, pd.getString("PCSTATE"), "");
				} else {
					audit_pm(status, taskId, pd.getString("pcstate"), "");
				}

			}
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
		}
		return result;
	}

	/**
	 * 申请
	 * 
	 * @param response
	 * @param pc_leaveId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/startApply")
	@ResponseBody
	public Object startApply(HttpServletResponse response, String pc_leaveId, String name, String msg) throws Exception {
		String nextus_id;
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put("pc_leaveId", pc_leaveId);
		// 启动流程
		ProcessInstance pi = runtimeService.startProcessInstanceByKey("myProcess", variables);
		// 根据流程实例Id查询任务
		Task task = taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
		// 完成 学生填写请假单任务
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("user_id", user.getUSER_ID());
		pd.put("name", name);
		pd.put("USERNAME", user.getUSERNAME());
		try {
			nextus_id = pcLeaveService.GetNextUser(pd).getString("user_id");
		} catch (Exception e) {
			nextus_id = null;
		}

		if (StringUtils.isBlank(name)) {
			nextus_id = null;
		}
		if (nextus_id == null) {
			variables.put("item", 0); // 无项目
			List<PageData> list;
			PageData pd2 = pcLeaveService.getDEPARTMENT_ID(pd); // 取用户所属的部门
			list = pcLeaveService.GetNextbzById(pd2);
			pd2.put("PARENT_ID", pd2.getString("DEPARTMENT_ID"));
			if (list.size() == 0) {
				List<PageData> pdList = new ArrayList<PageData>();
				while (true) {
					PageData pd3 = pcLeaveService.getPARENT_ID(pd2);
					if (pd3.getString("PARENT_ID").equals("0")) {
						break;
					} else {
						pd2.put("PARENT_ID", pd3.getString("PARENT_ID"));
						pdList.add(pd3); // 装本节点的所有上级的节点
					}
				}
				for (PageData pageData : pdList) {
					pageData.put("DEPARTMENT_ID", pageData.getString("PARENT_ID"));
					list = pcLeaveService.GetNextbzById(pageData);
					if (list.size() != 0) {
						for (PageData pageData2 : list) {
							variables.put("spmname", pageData2.getString("user_id"));
							variables.put("spmassignee", pageData2.getString("user_id"));
							break;
						}
					}
					break;
				}
			} else {
				for (PageData pageData2 : list) {
					variables.put("spmname", pageData2.getString("user_id"));
					variables.put("spmassignee", pageData2.getString("user_id"));
				}
			}
		} else {
			variables.put("item", 2); // 有项目
			variables.put("pmname", nextus_id);
			variables.put("assignee", nextus_id);
		}
		// 修改状态
		if (msg.equals("入场")) {
			pd.put("PCSTATE", "0");
		} else {
			pd.put("PCSTATE", "1");
		}
		pd.put("ID", pc_leaveId);
		pd.put("STATE", "申请成功，" + msg + "审核中");
		pd.put("TASKID", task.getId());
		pd.put("PROCESSINSTANCEID", pi.getProcessInstanceId());
		// 修改请假单状态
		if (msg.equals("入场")) {
			pcLeaveService.updateStateName(pd);
		} else {
			pcLeaveItemService.updateStateName(pd);
		}
		FHLOG.save(Jurisdiction.getUsername(), "PC申请", "pc_leave", "ID", pc_leaveId);
		taskService.complete(task.getId(), variables);
		JSONObject result = new JSONObject();
		result.put("success", true);
		return result;
	}

	@RequestMapping(value = "/goview")
	public ModelAndView goview(String Id, String PROCESSINSTANCEID, Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = pcLeaveService.pca(pd);
		pd.put("PROCEDURE", "PC申请");
		pd.put("PROCESSINSTANCEID", PROCESSINSTANCEID);
		String id = pd.getString("PROCESSINSTANCEID");
		page.setPd(pd);
		/** 流程引擎（核心对象），默认加载类路径下命名为activiti.cfg.xml */
		List<Comment> commentList = taskService.getProcessInstanceComments(id);
		// 改变顺序，按原顺序的反向顺序返回list
		// Collections.reverse(commentList);
		// List<PageData> messageList = new ArrayList<>();
		// messageList = pcLeaveService.select_hi_MESSAGE_(page);
		List<PageData> commentList1 = new ArrayList<>();
		commentList1 = pcLeaveService.select_hi_NAME_(page);
		for (PageData pageData : commentList1) {
			String name = pageData.getString("NAME_");
			String SYS_NAME = pageData.getString("SYS_NAME");
			if (SYS_NAME == null) {
				SYS_NAME = "负责人未知";
			}
			// pageData.put("NAME_", name + "["+ pd.getString("NAME") +"]");
			if (pageData.get("END_TIME_") == null) {
				pageData.put("NAME_1", name + "[" + SYS_NAME + "]" + "[ 正在等待审核 ]");
			} else {
				pageData.put("NAME_1", "[全部流程结束]");
			}
		}
		PageData pd2 = new PageData();
		pd2 = commentList1.get(0);
		PageData pd3 = new PageData();
		pd3 = commentList1.get(commentList1.size() - 1);
		pd3.put("NAME_2", pd3.getString("NAME_") + "[" + pd.getString("NAME") + "]");
		// PageData pc = new PageData();
		// pc = this.getPageData();
		// pc = pcLeaveService.pca2(pc);
		List<PageData> pc = new ArrayList<>();
		pc = pcLeaveService.pca2(pd);
		for (PageData pageData : pc) {
			if (pageData.getString("PROJECTNAME") == null) {
				pageData.put("PROJECTNAME", "无项目");
			}
		}
		mv.setViewName("app/pc/user_view");
		mv.addObject("varlist", commentList);
		mv.addObject("pd2", pd2);
		mv.addObject("pd3", pd3);
		mv.addObject("pd", pd);
		mv.addObject("pc", pc);
		return mv;

	}

	/*
	 * 入场审批通过的后续处理
	 */
	public void afterEnterApprovePass(String taskId) throws Exception {
		// 根据任务Id对应的PC申请
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		PageData paramPd = new PageData();
		paramPd.put("PROCESSINSTANCEID", task.getProcessInstanceId());
		PageData pc_leave = pcLeaveService.getLeaveByTaskId(paramPd);
		List<PageData> leave_items = pcLeaveService.LeaveItemlist(pc_leave);

		// 循环创建pc_leave_item记录和Project_Sercurity记录
		PageData myParam = new PageData();
		myParam.put("PARENT_NAME", "PC状态");
		myParam.put("NAME", "入场准备中");
		PageData dic = dictionariesService.findByParentNameAndName(myParam);
		// 根据USERNAME查找工号
		PageData param = new PageData();
		param.put("USER_ID", pc_leave.getString("USERNAME"));
		PageData staff = null;
		try {
			staff = staffService.findByUserId(param);
		} catch (Exception e) {
			e.printStackTrace();
		}

		for (int i = 0; i < leave_items.size(); i++) {
			PageData item = leave_items.get(i);
			String pcNumber = item.getString("PCNUMBER");
			String PC_LEAVEID = item.getString("PC_LEAVEID");
			if (pcNumber != null && !"".equals(pcNumber) && Integer.parseInt(pcNumber) > 0) {
				int pcNumberInt = Integer.parseInt(pcNumber);
				for (int j = 0; j < pcNumberInt; j++) {
					// 往pc_leave_item中添加一条数据
					PageData myItem = new PageData();
					String PC_LEAVE_ITEMID = this.get32UUID();
					myItem.put("ID", PC_LEAVE_ITEMID);
					myItem.put("PC_LEAVEID", PC_LEAVEID);
					myItem.put("USERNAME", item.getString("USERNAME"));
					myItem.put("RAM", item.getString("RAM"));
					myItem.put("HDISK", item.getString("HDISK"));
					myItem.put("TYPE", item.getString("TYPE"));
					myItem.put("ACCESSORIES", item.getString("ACCESSORIES"));
					myItem.put("PURPOSE", item.getString("PURPOSE"));
					myItem.put("ROOM_NAME", item.getString("ROOM_NAME"));
					myItem.put("EINLASS", (Date) item.get("EINLASS"));
					myItem.put("EXIT_DATE", null);
					myItem.put("STATE", "入场审核通过");
					myItem.put("PCNUMBER", "1");
					myItem.put("PROCESSINSTANCEID", "");
					myItem.put("TASKID", "");
					myItem.put("PCSTATE", "5");
					pcLeaveItemService.save(myItem);

					// 往project_sercurity中插入一条对应的数据
					PageData psPd = new PageData();
					String PROJECT_ID = pc_leave.getString("PROJECT_ID");
					if (!"".equals(PROJECT_ID) && PROJECT_ID != null) {
						paramPd.put("PROJECT_ID", PROJECT_ID);
						PageData project = projectService.findById(paramPd);
						psPd.put("PROJECT_ID", PROJECT_ID);
						psPd.put("PROJECT_NAME", project.getString("PROJECT_NAME"));
						psPd.put("PROJECT_MANAGER", project.getString("PROJECT_MANAGER"));
						psPd.put("PROJECT_DEPARTMENT", project.getString("DEPARTMENT_ID"));
						psPd.put("PROJECT_STATE", project.getString("PROJECT_STATE"));
					}
					psPd.put("PRO_ID", this.get32UUID());
					psPd.put("ROOM_NAME", item.getString("ROOM_NAME"));
					psPd.put("PC_STATE", dic.getString("DICTIONARIES_ID"));
					psPd.put("APPLICANT", pc_leave.getString("USERNAME"));
					psPd.put("APPLICANT_NO", (Integer) staff.get("NO"));
					psPd.put("PC_LEAVE_ITEMID", PC_LEAVE_ITEMID);
					psPd.put("PC_LEAVEID", PC_LEAVEID);
					psPd.put("FLAG", 0);
					Session session = Jurisdiction.getSession();
					User user = (User) session.getAttribute(Const.SESSION_USER);
					psPd.put("CREATIONUSER", user.getUSERNAME());
					psPd.put("CREATIONDATE", new Date());
					prosecurityService.save(psPd);
				}
			}
		}
	}

	/*
	 * 退场审批通过的后续处理
	 */
	public void afterOutApprovePass(String taskId) throws Exception {
		// 根据任务Id对应的PC申请
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		PageData paramPd = new PageData();
		paramPd.put("PROCESSINSTANCEID", task.getProcessInstanceId());
		PageData pc_leave = pcLeaveService.getLeaveByTaskId(paramPd);

		// 修改项目信息安全管理表中相应记录的pc状态
		PageData myParam = new PageData();

		myParam.put("PARENT_NAME", "PC状态");
		myParam.put("NAME", "退场准备中");
		PageData psdic = dictionariesService.findByParentNameAndName(myParam);
		myParam.put("PARENT_NAME", "在库情况");
		myParam.put("NAME", "退场准备中");
		PageData pcdic = dictionariesService.findByParentNameAndName(myParam);
		paramPd.put("PC_LEAVEID", pc_leave.getString("ID"));
		PageData proSecurity = prosecurityService.findByPcleaveid(paramPd);
		paramPd.put("PC_STATE", psdic.getString("DICTIONARIES_ID"));
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		paramPd.put("UPDATEUSER", user.getUSERNAME());
		paramPd.put("UPDATEDATE", new Date());
		prosecurityService.updatePcStateByPcleaveId(paramPd);

		// 修改电脑主机信息表中的电脑状态
		String pcNumber = proSecurity.getString("PC_NUMBER");
		paramPd.put("PC_NO", pcNumber);
		PageData pc = pcService.findByNo(paramPd);
		if (pc != null) {
			pc.put("DEPOT", pcdic.getString("DICTIONARIES_ID"));
			pcService.edit(pc);
		}
	}

}
