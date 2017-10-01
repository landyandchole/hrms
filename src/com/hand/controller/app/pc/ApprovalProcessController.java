package com.hand.controller.app.pc;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.entity.system.Role;
import com.hand.entity.system.User;
import com.hand.service.app.pc.impl.PcLeaveItemService;
import com.hand.service.app.pc.impl.PcLeaveService;
import com.hand.service.system.appuser.AppuserManager;
import com.hand.service.system.role.RoleManager;
import com.hand.util.Const;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;

/**
 * 说明：我审批的流程 创建时间：2017年7月12日
 */
@Controller
@RequestMapping(value = "/aprroveProccess")
public class ApprovalProcessController extends BaseController {

	@Resource
	private AppuserManager appuserService;

	@Resource
	private HistoryService historyService;

	@Resource(name = "PcLeaveService")
	private PcLeaveService pcLeaveService;

	@Resource(name = "pcLeaveItemService")
	private PcLeaveItemService pcLeaveItemService;

	@Resource(name = "roleService")
	private RoleManager roleService;

	@Resource
	private RepositoryService repositoryService;

	@RequestMapping("/finishedList")
	public ModelAndView finishedList(HttpServletRequest request, Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表finishedList");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);

		// 获取当前用户信息
		String proname;
		Session session = Jurisdiction.getSession();
		User currentUser = (User) session.getAttribute(Const.SESSION_USER);

		// 获取设置分页数据
		String currentPageStr = request.getParameter("page.currentPage");
		String showCountStr = request.getParameter("page.showCount");
		int currentPageInt = 1;
		if (!StringUtils.isBlank(currentPageStr)) {
			page.setCurrentPage(Integer.parseInt(currentPageStr));
			currentPageInt = Integer.parseInt(currentPageStr);
		}
		if (!StringUtils.isBlank(showCountStr)) {
			page.setShowCount(Integer.parseInt(showCountStr));
		}
		int currentResult = (currentPageInt - 1) * page.getShowCount();
		if (currentResult < 0)
			currentResult = 0;

		// 获取当前用户的角色
		Role currentRole = roleService.getRoleById(currentUser.getROLE_ID());
		Long totalResult = null;
		List<HistoricTaskInstance> histList = null;

		// 1.查找出所有满足条件的历史任务（即已经结束且有申请人）
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String MIN_START_TIME_ = pd.getString("MIN_START_TIME_");
		String MAX_START_TIME_ = pd.getString("MAX_START_TIME_");
		String MIN_END_TIME_ = pd.getString("MIN_END_TIME_");
		String MAX_END_TIME_ = pd.getString("MAX_END_TIME_");
		Date minCreatTime = null;
		Date maxCreatTime = null;
		Date minEndTime = null;
		Date maxEndTime = null;
		if (!"".equals(MIN_START_TIME_) && MIN_START_TIME_ != null) {
			minCreatTime = sdf.parse(MIN_START_TIME_);
		}
		if (!"".equals(MAX_START_TIME_) && MAX_START_TIME_ != null) {
			cal.setTime(sdf.parse(MAX_START_TIME_));
			cal.add(Calendar.DATE, 1);
			maxCreatTime = cal.getTime();
		}
		if (!"".equals(MIN_END_TIME_) && MIN_END_TIME_ != null) {
			minEndTime = sdf.parse(MIN_END_TIME_);
		}
		if (!"".equals(MAX_END_TIME_) && MAX_END_TIME_ != null) {
			cal.setTime(sdf.parse(MAX_END_TIME_));
			cal.add(Calendar.DATE, 1);
			maxEndTime = cal.getTime();
		}

		// 查出流程pc_leave表和pc_leave_item表中流程实例Id的集合
		List<String> leaveIdList = pcLeaveItemService.findAllProcessInstanceId();
		if (leaveIdList != null && leaveIdList.size() > 0) {
			histList = historyService.createHistoricTaskInstanceQuery()// 创建查询
					.taskAssignee(currentUser.getUSERNAME())// 根据用户查询
					.taskCreatedAfter(minCreatTime) // 根据创建时间下限
					.taskCreatedBefore(maxCreatTime)// 根据创建时间上限
					.taskCompletedAfter(minEndTime)// 根据结束时间下限
					.taskCompletedBefore(maxEndTime)// 根据结束时间上限
					.finished()// 已完成的
					.processInstanceIdIn(leaveIdList) // 流程id在PC_LEAVE和PC_LEAVE_ITEM表中存在的
					.orderByHistoricTaskInstanceEndTime() // 根据任务创建时间排序
					.desc() // 降序排序
					.list();
		}

		// 循环过滤任务
		List<PageData> taskList = new ArrayList<PageData>();
		int recordCount = 0;
		if (histList != null) {
			for (HistoricTaskInstance hti : histList) {
				PageData myTask = new PageData();
				myTask.put("PROCESSINSTANCEID", hti.getProcessInstanceId());
				PageData staffPro = pcLeaveItemService.findStaffProByProInstId(myTask);
				if (("".equals(pd.getString("username")) || pd.getString("username") == null) && recordCount >= currentResult && recordCount < currentResult + page.getShowCount()) {
					// 设置申请人
					myTask.put("username", staffPro.getString("NAME"));
				} else if (!"".equals(pd.getString("username")) && pd.getString("username") != null) {
					// 设置申请人
					myTask.put("username", staffPro.getString("NAME"));
					// 申请人查询过滤
					Pattern p = Pattern.compile(pd.getString("username").toLowerCase());
					Matcher m = p.matcher(myTask.getString("username").toLowerCase());
					if (!m.find()) {
						continue;
					}
				}

				if (("".equals(pd.getString("PROCESSTYPE")) || pd.getString("PROCESSTYPE") == null) && recordCount >= currentResult && recordCount < currentResult + page.getShowCount()) {
					// 设置工作流属性
					myTask.put("PROCESSTYPE", staffPro.getString("PROCESSTYPE"));
				} else if (!"".equals(pd.getString("PROCESSTYPE")) && pd.getString("PROCESSTYPE") != null) {
					// 设置工作流属性
					myTask.put("PROCESSTYPE", staffPro.getString("PROCESSTYPE"));
					// 工作流属性查询过滤
					if (!pd.getString("PROCESSTYPE").equals(myTask.getString("PROCESSTYPE"))) {
						continue;
					}
				}

				// 只对查询当前页记录的信息
				if (recordCount >= currentResult && recordCount < currentResult + page.getShowCount()) {
					myTask.put("ID_", hti.getId());
					myTask.put("ACT_NAME_", hti.getName());
					myTask.put("START_TIME_", hti.getCreateTime());
					myTask.put("END_TIME_", hti.getEndTime());

					// 设置工作流名称
					myTask.put("PROCESS_NAME", "PC申请");
					// 设置入场申请的ID
					myTask.put("PC_LEAVE_ID", staffPro.getString("ID"));
					// 设置pc_leave表中的taskId
					myTask.put("PC_LEAVE_TASKID", staffPro.getString("TASK_ID"));
				}

				recordCount++;
				taskList.add(myTask);
			}
		}

		// 设置总记录数
		page.setTotalResult(taskList.size());

		// 获取当前页的记录
		List<PageData> varList = fenye(taskList, page.getShowCount(), page.getCurrentPage());

		page.getTotalPage();
		mv.setViewName("app/workflow/approvalprocess_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
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

	public boolean isFitCondition(PageData pd, PageData record) throws ParseException {
		String username = pd.getString("username");
		String PROCESSTYPE = pd.getString("PROCESSTYPE");

		// 申请人
		if (!"".equals(username) && username != null) {
			Pattern p = Pattern.compile(username.toLowerCase());
			Matcher m = p.matcher(record.getString("username").toLowerCase());
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
		return true;
	}

}
