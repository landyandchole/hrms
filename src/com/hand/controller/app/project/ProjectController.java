package com.hand.controller.app.project;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpRequest;
import org.apache.shiro.session.Session;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.entity.app.Member;
import com.hand.entity.system.User;
import com.hand.service.app.cost.CostManager;
import com.hand.service.app.project.ProjectManager;
import com.hand.service.app.project.ProjectMemberManager;
import com.hand.service.fhoa.datajur.DatajurManager;
import com.hand.service.fhoa.department.DepartmentManager;
import com.hand.service.fhoa.staff.StaffManager;
import com.hand.service.system.dictionaries.DictionariesManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.util.AppUtil;
import com.hand.util.Const;
import com.hand.util.FileDownload;
import com.hand.util.FileUpload;
import com.hand.util.Jurisdiction;
import com.hand.util.NameToId;
import com.hand.util.ObjectExcelRead;
import com.hand.util.ObjectExcelView;
import com.hand.util.PageData;
import com.hand.util.PathUtil;

import net.sf.json.JSONArray;

/**
 * 说明：项目管理 创建时间：2017-07-04
 */
@Controller
@RequestMapping(value = "/project")
public class ProjectController extends BaseController {

	String menuUrl = "project/list.do"; // 菜单地址(权限用)
	@Resource(name = "projectService")
	private ProjectManager projectService;
	@Resource(name = "departmentService")
	private DepartmentManager departmentService;
	@Resource(name = "datajurService")
	private DatajurManager datajurService;
	@Resource(name = "projectmemberService")
	private ProjectMemberManager projectmemberService;
	@Resource(name = "dictionariesService")
	private DictionariesManager dictionariesService;
	@Resource(name = "costService")
	private CostManager costService;
	@Resource(name = "fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="staffService")
	private StaffManager staffService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		Session session = Jurisdiction.getSession();
		boolean flag = flag();
		if (flag == true) {
			logBefore(logger, Jurisdiction.getUsername() + "新增Project");
			String BUILDING = "";
			String ROOM = "";
			String newroom = "";
			if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
				return null;
			} // 校验权限
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			Map<String, String> map = new HashMap<String, String>();
			Set<String> keys = pd.keySet();
			StringBuffer ROOM_NAME = new StringBuffer();
			for (int i = 1; i <= 3; i++) {
				for (String key : keys) {
					if (key.contains("BUILDING") || key.contains("ROOM")) {

						if (key.equals("BUILDING_[" + i + "]") && pd.getString(key).length() != 0) {
							BUILDING = pd.getString(key);
							map.put("BUIDING[" + i + "]", BUILDING);
						} else {
							BUILDING = "";
						}
						if (key.equals("ROOM_[" + i + "]") && pd.getString(key).length() != 0) {
							ROOM = pd.getString(key);
							map.put("ROOM[" + i + "]", ROOM);
						} else {
							ROOM = "";
						}
						/*
						 * if(BUILDING != "" || ROOM != ""){ newroom = BUILDING + ROOM;
						 * ROOM_NAME.append(newroom); }
						 */
					}
				}
			}
			for (int i = 1; i <= 3; i++) {
				BUILDING = map.get("BUIDING[" + i + "]");
				if (BUILDING == null) {
					BUILDING = "";
				}
				ROOM = map.get("ROOM[" + i + "]");
				if (ROOM == null) {
					ROOM = "";
				}
				if (BUILDING != "" || ROOM != "") {
					newroom = BUILDING + ROOM;
					ROOM_NAME.append(newroom);
					ROOM_NAME.append("、");
				}
			}
			if (ROOM_NAME.length() != 0) {
				String room = ROOM_NAME.substring(0, ROOM_NAME.length() - 1);
				pd.put("ROOM_NAME", room);
			} else {
				pd.put("ROOM_NAME", "");
			}
			/*
			 * if(key.contains("BUILDING_")&&pd.getString(key).length()!=0){
			 * ROOM_NAME.append(pd.getString(key));
			 * if(key.contains("ROOM_")&&pd.getString(key).length()!=0) {
			 * ROOM_NAME.append(pd.getString(key)); ROOM_NAME.append("、"); } } }
			 * if(ROOM_NAME.length()!=0){ String room = ROOM_NAME.substring(0,
			 * ROOM_NAME.length()-1); pd.put("ROOM_NAME", room); }else{ pd.put("ROOM_NAME", ""); }
			 */

			pd.put("PROJECT_ID", this.get32UUID()); // 主键
			StringBuffer sb = new StringBuffer();
			sb.append("P");
			Calendar a = Calendar.getInstance();
			int year = a.get(Calendar.YEAR);
			sb.append(year);
			String pid = projectService.getPID(pd);
			if (pid == null || "".equals(pid)) {
				sb.append("001");
			} else {
				String ly = pid.substring(1, 5);
				int j = Integer.parseInt(ly);
				if (year == j) {
					String s = pid.substring(5, 8);
					int i = Integer.parseInt(s);
					i++;
					String str = String.format("%3d", i).replace(" ", "0");
					sb.append(str);
				} else {
					sb.append("001");
				}
			}
			pd.put("PROJECT_PID", sb.toString());
			String DEPARTMENT_NAMES = departmentService.getDEPARTMENT_NAMES(pd.getString("DEPARTMENT_ID"));
			pd.put("DEPARTMENT_NAMES", DEPARTMENT_NAMES);
			pd.put("FLAG", "0");
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
			String update = sdf.format(date);
			String username = (String) session.getAttribute(Const.SESSION_USERNAME);
			pd.put("CREATIONDATE", update);
			pd.put("CREATIONUSER", username);
			projectService.save(pd);
			FHLOG.save(Jurisdiction.getUsername(), "新增项目", "SYS_PROJECT", "PROJECT_NAME", pd.getString("PROJECT_NAME"));
			List<Member> list = addMD(pd);
			projectService.saveDouble(list);
			String DEPARTMENT_IDS = departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID"));// 获取某个部门所有下级部门ID
			pd.put("DATAJUR_ID", pd.getString("PROJECT_ID")); // 主键
			pd.put("DEPARTMENT_IDS", DEPARTMENT_IDS); // 部门ID集
			datajurService.save(pd);
			mv.addObject("msg", "success");
			mv.setViewName("save_result");
			return mv;
		}
		return null;
	}

	/**
	 * 保存项目经理和项目总监
	 * 
	 * @param
	 * @throws Exception
	 */

	public List<Member> addMD(PageData pd) throws Exception {
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		List<Member> list = new ArrayList<Member>();
		Member manager = new Member();
		Member derector = new Member();
		String manager_id = pd.getString("PROJECT_MANAGER");
		String derector_id = pd.getString("PROJECT_DIRECTOR");
		String project_id = pd.getString("PROJECT_ID");
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date mb = sf.parse((String) pd.get(("PROJECT_BTIME")));
		Date me = sf.parse((String) pd.get(("PROJECT_ETIME")));
		Date mu = sf.parse((String) pd.get(("CREATIONDATE")));
		PageData pa = new PageData();
		pa.put("MEMBER_ID", manager_id);
		PageData mcost = projectmemberService.getLevel(pa);
		Double mc = Double.parseDouble(mcost.getString("MEMBER_COST"));
		pa.put("MEMBER_ID", derector_id);
		PageData dcost = projectmemberService.getLevel(pa);
		Double dc = Double.parseDouble(dcost.getString("MEMBER_COST"));
		manager.setMEMBER_ID(manager_id);
		manager.setPROJECT_ID(project_id);
		manager.setMEMBER_ROLE("b2b170ee435e4ce58b3a7f87e284a81d");
		manager.setMEMBER_BTIME(mb);
		manager.setMEMBER_ETIME(me);
		manager.setMEMBER_COST(mc);
		manager.setMEMBER_ACTUL(mc);
		manager.setCREATIONUSER(username);
		manager.setCREATIONDATE(mu);
		manager.setFLAG("0");
		derector.setMEMBER_ID(derector_id);
		derector.setPROJECT_ID(project_id);
		derector.setMEMBER_ROLE("79a86ec3fd8540588aa17961418a5662");
		derector.setMEMBER_BTIME(mb);
		derector.setMEMBER_ETIME(me);
		derector.setMEMBER_COST(dc);
		derector.setMEMBER_ACTUL(0d);
		derector.setCREATIONUSER(username);
		derector.setCREATIONDATE(mu);
		derector.setFLAG("0");
		list.add(manager);
		list.add(derector);
		// projectService.saveDouble(list);
		return list;
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) throws Exception {
		boolean flag = flag();
		Session session = Jurisdiction.getSession();
		if (flag == true) {
			logBefore(logger, Jurisdiction.getUsername() + "删除Project");
			if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
				return;
			} // 校验权限
			PageData pd = new PageData();
			pd = this.getPageData();
			PageData project = projectService.findById(pd);
			List<PageData> varList = projectmemberService.member(pd);
			List<PageData> varListCost = costService.proCosts(pd);
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
			String update = sdf.format(date);
			String username = (String) session.getAttribute(Const.SESSION_USERNAME);
			for (PageData pageData : varList) {
				pageData.put("FLAG", "1");
				pageData.put("UPDATEDATE", update);
				pageData.put("UPDATEUSER", username);
				projectmemberService.edit(pageData);
			}
			for (PageData pageData : varListCost) {
				pageData.put("FLAG", "1");
				pageData.put("UPDATEDATE", update);
				pageData.put("UPDATEUSER", username);
				costService.edit(pageData);
			}
			project.put("FLAG", "1");
			project.put("UPDATEDATE", update);
			project.put("UPDATEUSER", username);
			projectService.edit(project);
			FHLOG.save(Jurisdiction.getUsername(), "删除项目", "SYS_PROJECT", "PROJECT_NAME", project.getString("PROJECT_NAME"));

			out.write("success");
			out.close();
		}
	}

	/**
	 * 修改
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView editP(HttpServletRequest request) throws Exception {

		boolean flag = flag();
		Session session = Jurisdiction.getSession();
		if (flag == true) {
			logBefore(logger, Jurisdiction.getUsername() + "修改项目");
			if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
				return null;
			} // 校验权限
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			if (pd.getString("PROJECT_BTIME").equals("")) {
				pd.put("PROJECT_BTIME", null);
			}
			if (pd.getString("PROJECT_ETIME").equals("")) {
				pd.put("PROJECT_ETIME", null);
			}
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
			String update = sdf.format(date);
			String username = (String) session.getAttribute(Const.SESSION_USERNAME);
			String DEPARTMENT_NAMES = departmentService.getDEPARTMENT_NAMES(pd.getString("DEPARTMENT_ID"));
			pd.put("DEPARTMENT_NAMES", DEPARTMENT_NAMES);
			pd.put("FLAG", "0");
			pd.put("UPDATEDATE", update);
			pd.put("UPDATEUSER", username);
			projectService.edit(pd);
			FHLOG.save(Jurisdiction.getUsername(), "修改项目", "SYS_PROJECT", "PROJECT_NAME", pd.getString("PROJECT_NAME"));

			mv.addObject("msg", "success");
			mv.setViewName("save_result");
			return mv;
		}
		return null;

	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page, HttpServletRequest request) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Project");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String pName = pd.getString("pName"); // 关键词检索条件
		String lPrice = pd.getString("lPrice");
		String hPrice = pd.getString("hPrice");
		String lmll = pd.getString("lmll");
		String hmll = pd.getString("hmll");
		String pManager = pd.getString("pManager");
		String pDirector = pd.getString("pDirector");
		String pMember = pd.getString("pMember");
		String lastStart = pd.getString("lastStart");
		String lastEnd = pd.getString("lastEnd");
		String PROJECT_STATE = pd.getString("PROJECT_STATE");
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
		if (null != pName && !"".equals(pName)) {
			pd.put("pName", pName);
		}
		if (null != lPrice && !"".equals(lPrice)) {
			pd.put("lPrice", lPrice);
		}
		if (null != hPrice && !"".equals(hPrice)) {
			pd.put("hPrice", hPrice);
		}
		if (null != lmll && !"".equals(lmll)) {
			pd.put("lmll", lmll);
		}
		if (null != hmll && !"".equals(hmll)) {
			pd.put("hmll", hmll);
		}
		if (null != pManager && !"".equals(pManager)) {
			pd.put("pManager", pManager);
		}
		if (null != pDirector && !"".equals(pDirector)) {
			pd.put("pDirector", pDirector);
		}
		if (null != pMember && !"".equals(pMember)) {
			pd.put("pMember", pMember);
		}
		if (null != lastStart && !"".equals(lastStart)) {
			pd.put("lastStart", lastStart);
		}
		if (null != lastEnd && !"".equals(lastEnd)) {
			pd.put("lastEnd", lastEnd);
		}
		if (null != PROJECT_STATE && !"".equals(PROJECT_STATE)) {
			pd.put("PROJECT_STATE", PROJECT_STATE);
		}
		String DEPARTMENT_ID = pd.getString("DEPARTMENT_ID");
		// pd.put("DEPARTMENT_ID", null == DEPARTMENT_ID?"0":DEPARTMENT_ID);
		if ("0".equals(DEPARTMENT_ID)) {
			DEPARTMENT_ID = null;
			pd.put("DEPARTMENT_ID", null);
		} else {
			pd.put("DEPARTMENT_ID", null == DEPARTMENT_ID ? "d41af567914a409893d011aa53eda797" : DEPARTMENT_ID);
		}
		pd.put("item", (null == pd.getString("DEPARTMENT_ID") ? Jurisdiction.getDEPARTMENT_IDS() : departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID")))); // 部门检索条件,列出此部门下级所属部门的员工
		if (DEPARTMENT_ID != null) {
			String Temp = pd.getString("item");
			Temp = Temp.replace(")", "");
			Temp = Temp + "," + "\'" + DEPARTMENT_ID + "\'" + ")";
			pd.put("item", Temp);
		}
		page.setPd(pd);
		List<PageData> varList = projectService.list(page); // 列出Project列表

		// 列表页面树形下拉框用(保持下拉树里面的数据不变)
		String ZDEPARTMENT_ID = pd.getString("ZDEPARTMENT_ID");
		pd.put("ZDEPARTMENT_ID", ZDEPARTMENT_ID);
		List<PageData> zdepartmentPdList = new ArrayList<PageData>();
		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect("0", zdepartmentPdList));
		mv.addObject("zTreeNodes", arr.toString());
		PageData dpd = departmentService.findById(pd);
		if (null != dpd) {
			ZDEPARTMENT_ID = dpd.getString("NAME");
		}

		List<List<PageData>> list = new ArrayList<List<PageData>>();

		List<PageData> proList = new ArrayList<PageData>();
		List<PageData> memberList = null;
		double ppricesum = 0.0;
		double pcostsum = 0.0;
		double pactualsum = 0.0;
		double pmoneysum = 0.0;
		double phavenotsum = 0.0;
		double phavesum = 0.0;
		double pmlsum = 0.0;
		double pmllsum = 0.0;
		int mlavg = 1;
		int avgi = 0;
		for (PageData pda : varList) {
			PageData data = new PageData();
			data.put("PROJECT_ID", pda.getString("PROJECT_ID"));
			data.put("PROJECT_PID", pda.getString("PROJECT_PID"));
			Long projectCount = projectService.getCount(data);
			pda.put("PROJECT_NUMBER", projectCount);
			Double projectMoney = projectService.getMoney(data);
			pda.put("PROJECT_MONEY", projectMoney);
			Double projectReceiving = projectService.getReceiving(data);
			pda.put("PROJECT_HAVE", projectReceiving);
			Double projectUnreceiving = (Double) pda.get("PROJECT_PRICE") - projectReceiving;

			pda.put("PROJECT_HAVENOT", projectUnreceiving);
			Double projectCost = projectService.getCost(data);
			pda.put("PROJECT_COST", projectCost);
			Double projectActual = projectService.getActual(data);
			pda.put("PROJECT_ACTUAL", projectActual);
			Double ml = (Double) pda.get("PROJECT_PRICE") - projectMoney - projectCost;
			pda.put("PROJECT_ML", ml);
			Double mll = ((Double) pda.get("PROJECT_PRICE") - projectMoney - projectCost) / (Double) pda.get("PROJECT_PRICE") * 10000 / 100;
			pda.put("PROJECT_MLL", mll);
			PageData projectManager = projectService.queryManager(data);
			if (projectManager == null) {
				pda.put("PROJECT_MANAGER", "");
			} else {
				pda.put("PROJECT_MANAGER", projectManager.get("manager"));
			}
			PageData projectDirector = projectService.queryDirector(data);
			if (projectDirector == null) {
				pda.put("PROJECT_DIRECTOR", "");
			} else {
				pda.put("PROJECT_DIRECTOR", projectDirector.get("director"));
			}
			Double pprices = (Double) pda.get("PROJECT_PRICE");
			ppricesum += pprices;
			Double pcosts = (Double) pda.get("PROJECT_COST");
			pcostsum += pcosts;
			Double pactuals = (Double) pda.get("PROJECT_ACTUAL");
			pactualsum += pactuals;
			Double pmoneys = (Double) pda.get("PROJECT_MONEY");
			pmoneysum += pmoneys;
			Double phavenots = (Double) pda.get("PROJECT_HAVENOT");
			phavenotsum += phavenots;
			Double phaves = (Double) pda.get("PROJECT_HAVE");
			phavesum += phaves;
			Double pmls = (Double) pda.get("PROJECT_ML");
			pmlsum += pmls;
			Double pmlls = (Double) pda.get("PROJECT_MLL");
			pmllsum += pmlls;
			/*
			 * long pnumbers=(Long) pda.get("PROJECT_NUMBER"); pnumbersum+=pnumbers;
			 */
			/*
			 * int sums =Integer.parseInt(PROJECTPRICESUM); ppricesum+=sums;
			 */
			projectService.editA(pda);
			proList.add(pda);

			list.add(proList);

			mv.addObject("depname", ZDEPARTMENT_ID);
			memberList = projectService.memberList(pda); // 列出Project列表
			list.add(memberList);

			avgi += mlavg;
		}
		PageData pda = new PageData();
		Session session = Jurisdiction.getSession();
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		pda.put("username", username);
		pda.put("ppricesum", ppricesum);
		pda.put("pcostsum", pcostsum);
		pda.put("pactualsum", pactualsum);
		pda.put("pmoneysum", pmoneysum);
		pda.put("phavenotsum", phavenotsum);
		pda.put("phavesum", phavesum);
		pda.put("pmlsum", pmlsum);
		double pmllsumg = (pmllsum / (double) avgi);
		pda.put("pmllsumg", pmllsumg);
		/*
		 * if(!username.equals("admin")){ PageData name = projectService.getName(pda);
		 * pda.put("username", name.get("NAME")); }
		 */
		// 空闲员工要用，请勿删除，谢谢!
		String method = request.getMethod();
		if ("GET".equals(method)) {
			session.removeAttribute("idleDate");
		}
		mv.addObject("pda", pda);
		mv.setViewName("app/project/project_list");
		mv.addObject("memberList", memberList);
		mv.addObject("list", list);
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
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
		PageData pd = new PageData();
		pd = this.getPageData();

		/*
		 * List<PageData> varList = projectService.listManager(pd); mv.addObject("varList",
		 * varList);//列出Project列表
		 */
		List<PageData> staffList = projectmemberService.getFreeStaff(pd);
		List<PageData> zdepartmentPdList = new ArrayList<PageData>();
		String DEPARTMENT_ID = pd.getString("ZDEPARTMENT_ID");
		pd.put("DEPARTMENT_ID", null == DEPARTMENT_ID ? "d41af567914a409893d011aa53eda797" : DEPARTMENT_ID);
		PageData dpd = departmentService.findById(pd);
		if (null != dpd) {
			DEPARTMENT_ID = dpd.getString("NAME");
		}
		mv.addObject("depname", DEPARTMENT_ID);
		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect("0", zdepartmentPdList));
		mv.addObject("zTreeNodes", (null == arr ? "" : arr.toString()));
		mv.setViewName("app/project/project_edit");
		mv.addObject("msg", "save");
		mv.addObject("staffList", staffList);
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
		pd = projectService.findById(pd); // 根据ID读取
		List<PageData> staffList = projectmemberService.getFreeStaff(pd);
		List<PageData> zdepartmentPdList = new ArrayList<PageData>();
		JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartmentToSelect("0",zdepartmentPdList));
		mv.addObject("zTreeNodes", (null == arr ?"":arr.toString()));
		PageData pa = new PageData();
		pa = departmentService.findById(pd);
		if(pa != null){
			mv.addObject("depname", departmentService.findById(pd).getString("NAME"));
		}
//		mv.addObject("depname", pd.getString("DEPARTMENT_ID"));
		mv.setViewName("app/project/project_edit");
		mv.addObject("msg", "edit");
		mv.addObject("staffList", staffList);
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
		boolean flag = flag();
		if (flag == true) {
			logBefore(logger, Jurisdiction.getUsername() + "批量删除Project");
			if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
				return null;
			} // 校验权限
			PageData pd = new PageData();
			Map<String, Object> map = new HashMap<String, Object>();
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for (int i = 0; i < ArrayDATA_IDS.length; i++) {
				Session session = Jurisdiction.getSession();
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
				String update = sdf.format(date);
				String username = (String) session.getAttribute(Const.SESSION_USERNAME);
				pd.put("FLAG", "1");
				pd.put("UPDATEDATE", update);
				pd.put("UPDATEUSER", username);
				pd.put("PROJECT_ID", ArrayDATA_IDS[i]);
				List<PageData> varList = projectmemberService.member(pd);
				for (PageData pageData : varList) {
					pageData.put("FLAG", "1");
					pageData.put("UPDATEDATE", update);
					pageData.put("UPDATEUSER", username);
					projectmemberService.edit(pageData);
				}
				List<PageData> varListCost = costService.proCosts(pd);
				for (PageData pageData : varListCost) {
					pageData.put("FLAG", "1");
					pageData.put("UPDATEDATE", update);
					pageData.put("UPDATEUSER", username);
					costService.edit(pageData);
				}
				projectService.editProjectAll(pd);
			}
			FHLOG.save(Jurisdiction.getUsername(), "删除项目", "SYS_PROJECT", "PROJECT_ID", DATA_IDS);

			pdList.add(pd);
			map.put("list", pdList);
			return AppUtil.returnObject(pd, map);
		}
		return flag;
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出Project到excel");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("项目ID"); // 1
		titles.add("项目编号"); // 2
		titles.add("项目名称"); // 3
		titles.add("项目报价"); // 4
		titles.add("项目状态"); // 5
		titles.add("项目管理者"); // 6
		titles.add("实际成本"); // 7
		titles.add("级别成本"); // 8
		titles.add("费用"); // 9
		titles.add("人员数"); // 10
		titles.add("开始时间"); // 11
		titles.add("结束时间"); // 12
		dataMap.put("titles", titles);
		List<PageData> varOList = projectService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PROJECT_ID")); // 1
			vpd.put("var2", varOList.get(i).getString("PROJECT_PID")); // 2
			vpd.put("var3", varOList.get(i).getString("PROJECT_NAME")); // 3
			vpd.put("var4", varOList.get(i).get("PROJECT_PRICE").toString()); // 4
			vpd.put("var5", varOList.get(i).getString("PROJECT_STATE")); // 5
			vpd.put("var6", varOList.get(i).getString("PROJECT_MANAGER")); // 6
			vpd.put("var7", varOList.get(i).get("PROJECT_COST").toString()); // 7
			vpd.put("var8", varOList.get(i).get("PROJECT_ACTUAL").toString()); // 8
			vpd.put("var9", varOList.get(i).get("PROJECT_MONEY").toString()); // 9
			vpd.put("var10", varOList.get(i).get("PROJECT_NUMBER").toString()); // 10
			vpd.put("var11", varOList.get(i).getString("PROJECT_BTIME")); // 11
			vpd.put("var12", varOList.get(i).getString("PROJECT_ETIME")); // 12
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	/**
	 * 打开上传EXCEL页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goUploadExcel")
	public ModelAndView goUploadExcel() throws Exception {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("app/project/uploadexcel");
		return mv;
	}

	/**
	 * 下载模版
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/downExcel")
	public void downExcel(HttpServletResponse response) throws Exception {
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "Projects.xls", "Projects.xls");
	}

	/**
	 * 从EXCEL导入到数据库
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/readExcel")
	public ModelAndView readExcel(@RequestParam(value = "excel", required = false) MultipartFile file) throws Exception {
		FHLOG.save(Jurisdiction.getUsername(), "从EXCEL导入到数据库", "", "", "");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
			String fileName = FileUpload.fileUp(file, filePath, "projectexcel"); // 执行上传
			List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0); // 执行读EXCEL操作,读出的数据导入List
																									// 2:从第3行开始；0:从第A列开始；0:第0个sheet
			for (int i = 0; i < listPd.size(); i++) {
				pd.put("PROJECT_ID", this.get32UUID()); // ID
				Session session = Jurisdiction.getSession();
				pd.put("FLAG", "0");
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
				String update = sdf.format(date);
				String username = (String) session.getAttribute(Const.SESSION_USERNAME);
				pd.put("PROJECT_PID", listPd.get(i).getString("var0"));
				pd.put("PROJECT_NAME", listPd.get(i).getString("var1"));
				pd.put("PROJECT_PRICE", listPd.get(i).getString("var2"));
				pd.put("PROJECT_STATE", NameToId.getValue(listPd.get(i).getString("var3")));
				pd.put("PROJECT_BTIME", listPd.get(i).getString("var4"));
				pd.put("PROJECT_ETIME", listPd.get(i).getString("var5"));
				pd.put("DEPARTMENT_ID", NameToId.getValue(listPd.get(i).getString("var6")));
				pd.put("DEPARTMENT_NAMES", listPd.get(i).getString("var6"));
				String manager = listPd.get(i).getString("var7");
				String mname = manager.substring(0, manager.indexOf('（'));
				String mno = manager.substring(manager.indexOf("（") + 1, manager.indexOf("）"));
				pd.put("PROJECT_MANAGER", mname);
				String director = listPd.get(i).getString("var8");
				String dname = director.substring(0, director.indexOf("（"));
				String dno = director.substring(director.indexOf("（") + 1, director.indexOf("）"));
				pd.put("PROJECT_DIRECTOR", dname);
				pd.put("ROOM_NAME", listPd.get(i).getString("var9"));
				if (projectService.findByPID(pd) != null) {
					pd.put("UPDATEDATE", update);
					pd.put("UPDATEUSER", username);
					projectService.editE(pd);
				} else {
					pd.put("CREATIONDATE", update);
					pd.put("CREATIONUSER", username);
										
					pd.put("PROJECT_MANAGER", mno);
					pd.put("PROJECT_DIRECTOR", dno);
					PageData pnm = staffService.findByNo1(pd);
					if(pnm!=null){
					if(mname.equals(pnm.getString("MANAGER")) && dname.equals(pnm.getString("DIRECTOR"))){
						projectService.save(pd);
					List<Member> list = addMD(pd);
					projectService.saveDouble(list);
					}
					}
				}
			}
			/* 存入数据库操作====================================== */
			mv.addObject("msg", "success");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 打开上传EXCEL页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goUpload")
	public ModelAndView goUpload() throws Exception {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("app/project/upload");
		return mv;
	}

	/**
	 * 下载模版
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/downLoad")
	public void downLoad(HttpServletResponse response) throws Exception {
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "Members.xls", "Members.xls");
	}

	/**
	 * 从EXCEL导入到数据库
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/readMember")
	public ModelAndView readMember(@RequestParam(value = "excel", required = false) MultipartFile file) throws Exception {
		FHLOG.save(Jurisdiction.getUsername(), "从EXCEL导入到数据库", "", "", "");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
			String fileName = FileUpload.fileUp(file, filePath, "memberexcel"); // 执行上传
			List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0); // 执行读EXCEL操作,读出的数据导入List
																									// 2:从第3行开始；0:从第A列开始；0:第0个sheet
			for (int i = 0; i < listPd.size(); i++) {
				pd.put("ID", this.get32UUID()); // ID
				Session session = Jurisdiction.getSession();
				pd.put("FLAG", "0");
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
				String update = sdf.format(date);
				String username = (String) session.getAttribute(Const.SESSION_USERNAME);
				pd.put("MEMBER_ID", listPd.get(i).getString("var0"));
				String role = listPd.get(i).getString("var2");
				if (role.equals("A")) {
					pd.put("MEMBER_ROLE", NameToId.getValue(role + "1"));
				} else {
					pd.put("MEMBER_ROLE", NameToId.getValue(role));
				}
				pd.put("MEMBER_BTIME", listPd.get(i).getString("var3"));
				pd.put("MEMBER_ETIME", listPd.get(i).getString("var4"));
				pd.put("MEMBER_COST", listPd.get(i).getString("var5"));
				pd.put("MEMBER_ACTUL", listPd.get(i).getString("var6"));
				pd.put("PROJECT_EV", listPd.get(i).getString("var9"));
				pd.put("MANAGER_EV", listPd.get(i).getString("var10"));
				String pid = listPd.get(i).getString("var8");
				pd.put("PROJECT_PID", pid);
				PageData prod = projectService.findByPID(pd);
				if (prod != null) {
					pd.put("PROJECT_ID", prod.getString("PROJECT_ID"));
					if (role.equals("PM") || role.equals("PD")) {
						PageData mrole = new PageData();
						mrole.put("roleId", pd.getString("MEMBER_ROLE"));
						mrole.put("projectId", prod.getString("PROJECT_ID"));
						PageData mr = projectmemberService.hasM(mrole);
						if (mr != null && mr.getString("MEMBER_ROLE").equals(pd.getString("MEMBER_ROLE"))) {
							continue;
						} else {
							pd.put("CREATIONDATE", update);
							pd.put("CREATIONUSER", username);
							projectmemberService.save(pd);
						}
					} else {
						pd.put("CREATIONDATE", update);
						pd.put("CREATIONUSER", username);
						projectmemberService.save(pd);
					}
				} else {
					continue;
				}
			}
			/* 存入数据库操作====================================== */
			mv.addObject("msg", "success");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 判断项目是否存在
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/hasproMerber")
	@ResponseBody
	public Object hasproMerber() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String errInfo = "success";
		Page page = new Page();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> List = projectService.memberList(pd); //列出Project列表
		page.setShowCount(List.size());
		page.setPd(pd);
		List<PageData> memberList = projectmemberService.list(page); // 列出ProjectMember列表
		map.put("memberList", memberList);
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
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
		PageData pid = projectService.findByPID(pd);
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

	public boolean flag() throws Exception {
		Session session = Jurisdiction.getSession();
		boolean flag = false;
		User user = (User) session.getAttribute(Const.SESSION_USER);
		if (user != null) {
			flag = true;
		}
		return flag;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
