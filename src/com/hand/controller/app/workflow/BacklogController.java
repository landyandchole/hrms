package com.hand.controller.app.workflow;

import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.entity.system.Role;
import com.hand.entity.system.User;
import com.hand.service.app.pc.impl.PcLeaveService;
import com.hand.service.system.role.impl.RoleService;
import com.hand.util.Const;
import com.hand.util.Jurisdiction;
//import com.hand.util.Jurisdiction;
//import com.hand.util.PageData;
import com.hand.util.PageData;

/**
 * 说明：PC管理 创建人：HAND 赵帮恩 创建时间：2017年6月15日
 */
@Controller
@RequestMapping(value = "/backlog")
public class BacklogController extends BaseController {
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private TaskService taskService;
	@Resource(name = "PcLeaveService")
	private PcLeaveService pcLeaveService;
	@Resource
	private RepositoryService repositoryService;
	String menuUrl = "backlog/approval.do"; // 菜单地址(权限用)
	@Resource
	private HistoryService historyService;
	@Resource(name = "roleService")
	private RoleService roleService;

	/**
	 * 列表(检索条件中的部门，只列出此操作用户最高部门权限以下所有部门的员工)
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/approval")
	public ModelAndView list(Page page, HttpServletRequest request) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表backlog");
		PageData mypd = new PageData();
		mypd = this.getPageData();
		page.setPd(mypd);
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		String proname = null;
		String userId = null;
		String PCSTATE = null;
		int currentPageInt = 0;
		int showCountInt = 0;
		int currentResult = 0;

		String USERNAME = request.getParameter("USERNAME");
		String TASKSNAME = request.getParameter("TASKSNAME");// 任务名称
		String TASKSPCSTATE = request.getParameter("TASKSPCSTATE");// 工作流属性
		String CREATETIME = request.getParameter("CREATETIME");// 创建时间
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		User currentUser = (User) session.getAttribute(Const.SESSION_USER);
		// 获取当前用户的角色
		Role currentRole = roleService.getRoleById(currentUser.getROLE_ID());
		/*
		 * String currentPageStr = request.getParameter("page.currentPage"); String showCountStr =
		 * request.getParameter("page.showCount"); if (!StringUtils.isBlank(currentPageStr)) {
		 * page.setCurrentPage(Integer.parseInt(currentPageStr)); } if
		 * (!StringUtils.isBlank(showCountStr)) { page.setShowCount(Integer.parseInt(showCountStr));
		 * }
		 */
		// Long totalResult = null;
		List<HistoricTaskInstance> histList = null;
		PageData pda = new PageData();
		pda = this.getPageData();
		pda.put("USER_ID", username);
		PageData infoSafes=null;
		try {
			infoSafes=pcLeaveService.getInfoSafes(pda);
		} catch (Exception e) {
			infoSafes=null;
		}
		// 根据用户角色做不同的查询
		if (null!=infoSafes) {
			String currentPageStr = request.getParameter("page.currentPage");
			String showCountStr = request.getParameter("page.showCount");
			mypd.put("SHOW_COUNT", page.getShowCount());
			/*
			 * long total = taskService.createTaskQuery().taskCandidateUser(username).count();
			 * page.setTotalResult((int) total); // 总记录数
			 */ List<Task> tasks = taskService.createTaskQuery().taskCandidateUser(username).orderByTaskCreateTime().desc().list();
			List<PageData> pdList = new ArrayList<PageData>();
			for (Task task : tasks) {
				PageData pd = new PageData();
				pd = this.getPageData();
				Task t = taskService.createTaskQuery().taskId(task.getId()).singleResult();
				pd.put("PROCESSINSTANCEID", t.getProcessInstanceId());
				PageData pc = pcLeaveService.getUser(pd);
			/*	
				try {
					proname = pcLeaveService.getUser(pd).getString("name");
				} catch (Exception e1) {
					proname = null;
				}
				try {
					PCSTATE = pcLeaveService.getUser(pd).getString("PCSTATE");
				} catch (Exception e1) {
					PCSTATE = null;
				}*/
				pd.put("pcleaveid", pc.getString("ID"));
				pd.put("taskid", pc.getString("TASKID"));
				pd.put("username", pc.getString("name"));
				pd.put("userId", userId);
				pd.put("PCSTATE", pc.getString("PCSTATE"));
				pd.put("PCNUMBER", pc.getString("PCNUMBER"));
				pd.put("id", task.getId());
				pd.put("name", task.getName());
				pd.put("createTime", task.getCreateTime());
				String dateStr = new SimpleDateFormat("yyyy-MM-dd").format(task.getCreateTime());
				if (StringUtils.isBlank(USERNAME) && StringUtils.isBlank(TASKSPCSTATE) && StringUtils.isBlank(TASKSNAME) && StringUtils.isBlank(CREATETIME)) {
					pdList.add(pd);
					continue;
				} else if (!StringUtils.isBlank(PCSTATE) && !StringUtils.isBlank(TASKSPCSTATE) && !PCSTATE.equals(TASKSPCSTATE)) {
					continue;
					// }else if (!StringUtils.isBlank(task.getName()) &&
					// !StringUtils.isBlank(TASKSNAME) &&!task.getName().equals(TASKSNAME)) {
					// 原开发所写，页面赋值为ID改为如下
				} else if (!StringUtils.isBlank(mypd.getString(TASKSNAME)) && !StringUtils.isBlank(TASKSNAME) && !mypd.get(TASKSNAME).equals(TASKSNAME)) {
					continue;
				} else if (!StringUtils.isBlank(dateStr) && !StringUtils.isBlank(CREATETIME) && !dateStr.equals(CREATETIME)) {
					continue;
				} else if (!StringUtils.isBlank(proname) && !StringUtils.isBlank(USERNAME)) {
					if (proname.indexOf(USERNAME) != -1) {
						pdList.add(pd);
					}
				} else {
					pdList.add(pd);
				}
			}
			if (!StringUtils.isBlank(currentPageStr)) {
				page.setCurrentPage(Integer.parseInt(currentPageStr));
			}
			if (!StringUtils.isBlank(showCountStr)) {
				page.setShowCount(Integer.parseInt(showCountStr));
			}
			page.setTotalResult(pdList.size());
			List<PageData> curPageList = fenye(pdList, page.getShowCount(), page.getCurrentPage());
			page.getTotalPage();
			mv.addObject("pd", mypd);
			mv.addObject("tasks", curPageList);
			mv.addObject("pdList", curPageList);

		} else {
			String currentPageStr = request.getParameter("page.currentPage");
			String showCountStr = request.getParameter("page.showCount");
			mypd.put("SHOW_COUNT", page.getShowCount());
			// long total = taskService.createTaskQuery().taskAssignee(username).count();
			// page.setTotalResult((int) total); // 总记录数
			// List<Task> tasks =
			// taskService.createTaskQuery().taskAssignee(username).listPage(page.getCurrentResult(),
			// page.getShowCount());
			List<Task> tasks = taskService.createTaskQuery().taskAssignee(username).orderByTaskCreateTime().desc().list();

			List<PageData> pdList = new ArrayList<PageData>();
			for (Task task : tasks) {
				PageData pd = new PageData();
				pd = this.getPageData();
				Task t = taskService.createTaskQuery().taskId(task.getId()).singleResult();
				pd.put("PROCESSINSTANCEID", t.getProcessInstanceId());
				PageData pc = pcLeaveService.getUser(pd);
				/*try {
					proname = pcLeaveService.getUser(pd).getString("name");
				} catch (Exception e1) {
					proname = null;
				}
				try {
					userId = pcLeaveService.getUser(pd).getString("user_id");
				} catch (Exception e1) {
					userId = null;
				}
				try {
					PCSTATE = pcLeaveService.getUser(pd).getString("PCSTATE");
				} catch (Exception e1) {
					PCSTATE = null;
				}*/
				pd.put("pcleaveid", pc.getString("ID"));
				pd.put("taskid", pc.getString("TASKID"));
				pd.put("username", pc.getString("name"));
				pd.put("userId", pc.getString("user_id"));
				pd.put("PCSTATE", pc.getString("PCSTATE"));
				pd.put("PCNUMBER", pc.getString("PCNUMBER"));
				pd.put("id", task.getId());
				pd.put("name", task.getName());
				pd.put("createTime", task.getCreateTime());
				String dateStr = new SimpleDateFormat("yyyy-MM-dd").format(task.getCreateTime());
				if (StringUtils.isBlank(USERNAME) && StringUtils.isBlank(TASKSPCSTATE) && StringUtils.isBlank(TASKSNAME) && StringUtils.isBlank(CREATETIME)) {
					pdList.add(pd);
					continue;
				} else if (!StringUtils.isBlank(PCSTATE) && !StringUtils.isBlank(TASKSPCSTATE) && !PCSTATE.equals(TASKSPCSTATE)) {
					continue;
				} else if (!StringUtils.isBlank(mypd.getString(TASKSNAME)) && !StringUtils.isBlank(TASKSNAME) && !mypd.get(TASKSNAME).equals(TASKSNAME)) {// 如果有新增加任务名称
																																							// 在这里修改，添加判断条件即可
					continue;
				} else if (!StringUtils.isBlank(dateStr) && !StringUtils.isBlank(CREATETIME) && !dateStr.equals(CREATETIME)) {
					continue;
				} else if (!StringUtils.isBlank(proname) && !StringUtils.isBlank(USERNAME)) {
					if (proname.indexOf(USERNAME) != -1) {
						pdList.add(pd);
					}
				} else {
					pdList.add(pd);
				}

			}
			if (!StringUtils.isBlank(currentPageStr)) {
				page.setCurrentPage(Integer.parseInt(currentPageStr));
			}
			if (!StringUtils.isBlank(showCountStr)) {
				page.setShowCount(Integer.parseInt(showCountStr));
			}
			page.setTotalResult(pdList.size());
			List<PageData> curPageList = fenye(pdList, page.getShowCount(), page.getCurrentPage());
			page.getTotalPage();
			mv.addObject("pd", mypd);
			mv.addObject("tasks", curPageList);
			mv.addObject("pdList", curPageList);
		}

		mv.setViewName("app/pc/pc_approval");
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}

	/**
	 * 查询流程信息
	 * 
	 * @param response
	 * @param taskId
	 *            流程实例ID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getLeaveByTaskId")
	public ModelAndView getLeaveByTaskId() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String taskId = pd.getString("processInstanceId");
		String name = pd.getString("name");
		
		// 先根据流程ID查询
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		String taskName = task.getName();
		pd.put("PROCESSINSTANCEID", task.getProcessInstanceId());
		pd = pcLeaveService.getLeaveByTaskId(pd);
		List<PageData> pc = new ArrayList<>();
		pc = pcLeaveService.pca2(pd);
		for (PageData pageData : pc) {
			if (pageData.getString("PROJECTNAME") == null) {
				pageData.put("PROJECTNAME", "无项目");
			}
		}
		pd.put("TASKID", taskId);
		pd.put("taskName", taskName);
		pd.put("name", name);
		mv.addObject("pd", pd);
		mv.addObject("pc", pc);
		mv.setViewName("app/pc/pc_activity");
		return mv;
	}
	/**
	 * @param response
	 * @param taskId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/showActivityView")
	public ModelAndView showActivityView(HttpServletResponse response,String ID, String taskId){
		ModelAndView mv = new ModelAndView();
		String taskName=null;
		String name=null;
		String state=null;
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			name= pcLeaveService.findById(pd).getString("NAME");
		} catch (Exception e) {
			name=null;
		}
		try {
			state= pcLeaveService.findById(pd).getString("STATE");
		} catch (Exception e) {
			state=null;
		}
		if (!StringUtils.isBlank(taskId)) {
		    HistoricTaskInstance task = historyService.createHistoricTaskInstanceQuery() // 创建任务查询
					.taskId(taskId) // 根据任务id查询
					.singleResult();
		    taskName=task.getName();
		    if (!StringUtils.isBlank(name)) {
			    if("员工发起申请".equals(taskName)){
					pd.put("PG", "1");
					pd.put("PM", "0");
					pd.put("PD", "0");
					pd.put("XINGUAN", "0");
				}else if("项目经理审批".equals(taskName)){
					pd.put("PG", "1");
					pd.put("PM", "1");
					pd.put("PD", "0");
					pd.put("XINGUAN", "0");
				}else if("项目总监审批".equals(taskName)){
					pd.put("PG", "1");
					pd.put("PM", "1");
					pd.put("PD", "1");
					pd.put("XINGUAN", "0");
				}else if("信息安全人员".equals(taskName)){
					pd.put("PG", "1");
					pd.put("PM", "1");
					pd.put("PD", "1");
					pd.put("XINGUAN", "1");
				}
		   }else{
			   if("员工发起申请".equals(taskName)){
					pd.put("PG", "1");
					pd.put("SPM", "0");
					pd.put("XINGUAN", "0");
				}else if("部长审批".equals(taskName)){
					pd.put("PG", "1");
					pd.put("SPM", "1");
					pd.put("XINGUAN", "0");
				}else if("信息安全人员".equals(taskName)){
					pd.put("PG", "1");
					pd.put("SPM", "1");
					pd.put("XINGUAN", "1");
				}
		   }
		}else{
			taskName=""; 
			if (StringUtils.isBlank(name)) {
					pd.put("PG", "0");
					pd.put("SPM", "0");
					pd.put("XINGUAN", "0");
			}else{
					pd.put("PG", "0");
					pd.put("PM", "0");
					pd.put("PD", "0");
					pd.put("XINGUAN", "0");
			}
		}
		pd.put("name", name);
		mv.addObject("pd", pd);
		mv.setViewName("app/pc/activityView");
		return mv;
	}
	/**
	 * @param response
	 * @param taskId
	 * @return
	 */
	@RequestMapping("/showCurrentView")
	public ModelAndView showCurrentView(HttpServletResponse response, String taskId) {
		// 视图
		ModelAndView mav = new ModelAndView();
		String processDefinitionId = null;
		if (!StringUtils.isBlank(taskId)) {
			HistoricTaskInstance task = historyService.createHistoricTaskInstanceQuery() // 创建任务查询
					.taskId(taskId) // 根据任务id查询
					.singleResult();
			// 获取流程定义id
			processDefinitionId = task.getProcessDefinitionId();
			// 图片资源文件名称
			// 获取流程实例id
			String processInstanceId = task.getProcessInstanceId();
			// 根据流程实例id获取流程实例
			ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
			// 根据活动id获取活动实例
			if (pi != null) {
				ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) repositoryService.getProcessDefinition(processDefinitionId);
				ActivityImpl activityImpl = processDefinitionEntity.findActivity(pi.getActivityId());
				// 整理好View视图返回到显示页面
				mav.addObject("x", activityImpl.getX());
				mav.addObject("y", activityImpl.getY());
				mav.addObject("width", activityImpl.getWidth());
				mav.addObject("height", activityImpl.getHeight());
			} else {
				// 如果为空，直接设置结束坐标
				mav.addObject("x", 985);
				mav.addObject("y", 175);
				mav.addObject("width", 52);
				mav.addObject("height", 52);
			}
		} else {
			processDefinitionId = "myProcess:1:342538";
			mav.addObject("x", 261);
			mav.addObject("y", 170);
			mav.addObject("width", 113);
			mav.addObject("height", 64);
		}
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery() // 创建流程定义查询
				// 根据流程定义id查询
				.processDefinitionId(processDefinitionId).singleResult();
		// 部署id
		mav.addObject("deploymentId", processDefinition.getDeploymentId());
		mav.addObject("diagramResourceName", processDefinition.getDiagramResourceName());
		mav.setViewName("app/pc/currentView");
		return mav;
	}

	/**
	 * @param deploymentId
	 * @param diagramResourceName
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/showView")
	public String showView(String deploymentId, String diagramResourceName, HttpServletResponse response) throws Exception {
		diagramResourceName = new String(diagramResourceName.getBytes("ISO-8859-1"), "UTF-8");
		InputStream inputStream = repositoryService.getResourceAsStream(deploymentId, diagramResourceName);
		OutputStream out = response.getOutputStream();
		for (int b = -1; (b = inputStream.read()) != -1;) {
			out.write(b);
		}
		out.close();
		inputStream.close();
		return null;
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
