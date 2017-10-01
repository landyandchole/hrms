package com.hand.controller.app.pc;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.entity.system.User;
import com.hand.service.app.pc.impl.PcLeaveItemService;
import com.hand.service.app.pc.impl.PcLeaveService;
import com.hand.service.app.project.ProjectManager;
import com.hand.service.system.appuser.AppuserManager;
import com.hand.util.Const;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;

/**
 * 说明：我退回的申请 创建时间：2017年7月7日
 */
@Controller
@RequestMapping(value = "/backapply")
public class BackApplyController extends BaseController {

	String menuUrl = "pca/list.do"; // 菜单地址(权限用)
	@Resource(name = "PcLeaveService")
	private PcLeaveService pcLeaveService;

	@Resource(name = "pcLeaveItemService")
	private PcLeaveItemService pcLeaveItemService;

	@Resource
	private HistoryService historyService;

	@Resource
	private RepositoryService repositoryService;

	@Resource
	private RuntimeService runtimeService;

	@Resource
	private TaskService taskService;

	@Resource(name = "appuserService")
	private AppuserManager appuserService;

	@Resource(name = "projectService")
	private ProjectManager projectService;

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest request, Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表pc");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		Session session = Jurisdiction.getSession();

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

		// 查找当前用户
		User currentUser = (User) session.getAttribute(Const.SESSION_USER);
		pd.put("USERNAME", currentUser.getUSERNAME());
		pd.put("STATE", "入场审核未通过");
		pd.put("STATE2", "退场审核未通过");

		pd.put("SHOW_COUNT", page.getShowCount());
		Long totalResult = (Long) pcLeaveItemService.getCountByStatusAndUser(pd).get("total");
		page.setTotalResult(totalResult.intValue());
		// page.setCurrentResult(page.getCurrentResult());
		List<PageData> varList = pcLeaveItemService.getPcLevelByStatusAndUser(pd);// 列出Dictionaries列表
		page.getTotalPage();

		List<PageData> myList = new ArrayList<PageData>();
		for (PageData pcLevel : varList) {
			PageData myPageData = pcLevel;
			// 工作流名称（在流程定义表中，通过历史流程实例表查出流程定义ID）
			HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()// 创建历史流程实例查询
					.processInstanceId(pcLevel.getString("PROCESSINSTANCEID"))// 根据流程实例ID查询
					.singleResult();
			ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()// 创建流程定义查询
					.processDefinitionId(historicProcessInstance.getProcessDefinitionId())// 根据流程定义ID查询
					.singleResult();
			Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(processDefinition.getDeploymentId()).singleResult();
			myPageData.put("PROCESS_NAME", deployment.getName());

			// 工作流属性
			myPageData.put("PROCESSTYPE", pcLevel.getString("PROCESSTYPE"));

			// 处理者
			HistoricTaskInstance historicTaskInstance = historyService.createHistoricTaskInstanceQuery()// 创建历史任务查询
					.processInstanceId(pcLevel.getString("PROCESSINSTANCEID"))// 根据流程实例ID查询
					.orderByHistoricTaskInstanceEndTime().desc().list().get(0);
			PageData paramPd = new PageData();
			paramPd.put("USERNAME", historicTaskInstance.getAssignee());
			myPageData.put("ASSIGNEE", appuserService.findByUsername(paramPd).getString("NAME"));
			// 退回时间
			myPageData.put("BACKTIME", historicTaskInstance.getEndTime());
			if (!isFitCondition(pd, myPageData)) {
				continue;
			}
			// 批注
			myPageData.put("COMMENT", taskService.getTaskComments(historicTaskInstance.getId()).get(0).getFullMessage());
			myList.add(myPageData);
		}
		// 根据退回时间降序排序
		Collections.sort(myList, new backTimeComparator());
		List<PageData> curPageList = fenye(myList, page.getShowCount(), page.getCurrentPage());
		mv.setViewName("app/pc/user_backapply");
		mv.addObject("varList", curPageList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "toModifyApply")
	public ModelAndView toModifyApply(HttpServletResponse response, HttpServletRequest request, Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		String ID = request.getParameter("ID");
		String PROCESSTYPE = request.getParameter("PROCESSTYPE");
		PROCESSTYPE = PROCESSTYPE.equals("1") ? "入场流程" : "退场流程";
		pd.put("ID", ID);
		pd.put("PROCESSTYPE", PROCESSTYPE);

		// 根据ID查找PC申请信息
		PageData pc_leave = new PageData();
		List<PageData> items = new ArrayList<PageData>();
		PageData item = new PageData();
		if ("入场流程".equals(PROCESSTYPE)) {
			pc_leave = pcLeaveService.findById(pd);
			items = pcLeaveService.LeaveItemlist(pd);
			pd.put("pc_leave", pc_leave);
			pd.put("items", items);
		} else if ("退场流程".equals(PROCESSTYPE)) {
			item = pcLeaveItemService.getItemById(pd);
			PageData paramPd = new PageData();
			paramPd.put("ID", item.getString("PC_LEAVEID"));
			pc_leave = pcLeaveService.findById(pd);
			pd.put("pc_leave", pc_leave);
			pd.put("item", item);
		} else {
			throw new Exception("对应的流程类别不存在!");
		}

		String PROJECT_ID = pc_leave.getString("PROJECT_ID");
		if (PROJECT_ID != null && !"".equals(PROJECT_ID)) {
			PageData paramPd = new PageData();
			paramPd.put("PROJECT_ID", PROJECT_ID);
			PageData project = projectService.findById(paramPd);
			String roomNames = project.getString("ROOM_NAME");
			if (roomNames != null && !"".equals(roomNames)) {
				mv.addObject("haveRoom", true);
				mv.addObject("rooms", roomNames.split("、"));
			}
			mv.addObject("haveRoom", false);
		}
		mv.addObject("pd", pd);
		mv.setViewName("app/pc/backapply_edit");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/modifyLeave")
	public ModelAndView modifyLeave() throws Exception {
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		Date date = new Date();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = format.format(date);
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERNAME", username);
		pd.put("DATE", time);

		// 设置重新申请时的状态
		PageData currentLeave = pcLeaveService.findById(pd);
		if ("0".equals(currentLeave.getString("PCSTATE"))) {
			pd.put("STATE", "申请成功，入场审核中");
			if ("".equals(currentLeave.getString("NAME")) || currentLeave.getString("NAME") == null) {
				pd.put("ROOM_NAME", pd.getString("BUILDING") + pd.getString("ROOM"));
			}
		} else if ("1".equals(currentLeave.getString("PCSTATE"))) {
			pd.put("STATE", "申请成功，退场审核中");
		}

		// ====================================重新申请=================================================================
		String nextus_id;
		User user = (User) session.getAttribute(Const.SESSION_USER);
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put("pc_leaveId", pd.getString("ID"));
		// 启动流程
		ProcessInstance pi = runtimeService.startProcessInstanceByKey("myProcess", variables);
		// 根据流程实例Id查询任务
		Task task = taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();

		// 完成 学生填写请假单任务
		String name = currentLeave.getString("PROJECT_ID");
		pd.put("user_id", user.getUSER_ID());
		pd.put("name", name);
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
			StringBuffer buf = new StringBuffer();
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
		pd.put("TASKID", task.getId());
		pd.put("PROCESSINSTANCEID", pi.getProcessInstanceId());

		// 修改请假单状态
		pcLeaveService.update(pd);
		taskService.setAssignee(task.getId(), user.getUSERNAME());
		taskService.complete(task.getId(), variables);

		mv.addObject("msg", "success");
		mv.setViewName("my_save_result");
		return mv;
	}

	public boolean isFitCondition(PageData pd, PageData record) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String PROCESS_NAME = pd.getString("PROCESS_NAME");
		String ASSIGNEE = pd.getString("ASSIGNEE");
		String PROCESSTYPE = pd.getString("PROCESSTYPE");
		String MIN_BACKTIME = pd.getString("MIN_BACKTIME");
		String MAX_BACKTIME = pd.getString("MAX_BACKTIME");
		// 工作流名称
		if (!"".equals(PROCESS_NAME) && PROCESS_NAME != null) {
			Pattern p = Pattern.compile(PROCESS_NAME.toLowerCase());
			Matcher m = p.matcher(record.getString("PROCESS_NAME").toLowerCase());
			if (!m.find()) {
				return false;
			}
		}
		// 处理者
		if (!"".equals(ASSIGNEE) && ASSIGNEE != null) {
			Pattern p = Pattern.compile(ASSIGNEE.toLowerCase());
			Matcher m = p.matcher(record.getString("ASSIGNEE").toLowerCase());
			if (!m.find()) {
				return false;
			}
		}
		// 工作流属性
		if (!"".equals(PROCESSTYPE) && PROCESSTYPE != null) {
			if (!PROCESSTYPE.equals(record.getString("PROCESSTYPE"))) {
				return false;
			}
		}
		// 退回时间下限
		if (!"".equals(MIN_BACKTIME) && MIN_BACKTIME != null) {
			Date pdMinBackTime = sdf.parse(MIN_BACKTIME);
			Date rBackTime = (Date) record.get("BACKTIME");
			if (rBackTime.getTime() < pdMinBackTime.getTime()) {
				return false;
			}
		}
		// 退回时间上限
		if (!"".equals(MAX_BACKTIME) && MAX_BACKTIME != null) {
			Date pdMaxBackTime = sdf.parse(MAX_BACKTIME);
			Date rBackTime = (Date) record.get("BACKTIME");
			cal.setTime(pdMaxBackTime);
			cal.add(Calendar.DATE, 1);
			pdMaxBackTime = cal.getTime();
			if (rBackTime.getTime() > pdMaxBackTime.getTime()) {
				return false;
			}
		}
		return true;
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

	static class backTimeComparator implements Comparator {
		@Override
		public int compare(Object o1, Object o2) {
			Map<String, Object> oo1 = (Map<String, Object>) o1;
			Map<String, Object> oo2 = (Map<String, Object>) o2;
			Date date1 = (Date) oo1.get("BACKTIME");
			Date date2 = (Date) oo2.get("BACKTIME");
			Long result = date2.getTime() - date1.getTime();
			return result.intValue();
		}
	}

}
