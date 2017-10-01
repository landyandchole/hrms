package com.hand.controller.fhoa.department;

import java.io.PrintWriter;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.entity.system.Department;
import com.hand.entity.system.Menu;
import com.hand.entity.system.Role;
import com.hand.service.fhoa.department.DepartmentManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.service.system.menu.MenuManager;
import com.hand.util.AppUtil;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;
import com.hand.util.RightsHelper;
import com.hand.util.Tools;

/** 
 * 说明：组织机构
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 */
@Controller
@RequestMapping(value="/department")
public class DepartmentController extends BaseController {
	
	String menuUrl = "department/list.do"; //菜单地址(权限用)
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增department");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("DEPARTMENT_ID", this.get32UUID());	//主键
		String str = pd.getString("pzgl1");
		if(str!=null && str.equals("1")){
			pd.put("PZ_QX", "1");
		}else{
			pd.put("PZ_QX", "0");
		}
		String str1 = pd.getString("pzgl2");
		if(str1!=null && str1.equals("1")){
			pd.put("FJ_QX", "1");
		}else{
			pd.put("FJ_QX", "0");
		}
		String str2 = pd.getString("pzgl3");
		if(str2!=null &&str2.equals("1")){
			pd.put("DN_QX", "1");
		}else{
			pd.put("DN_QX", "0");
		}
		String str3 = pd.getString("pzgl4");
		if(str3!=null &&str3.equals("1")){
			pd.put("SS_QX", "1");
		}else{
			pd.put("SS_QX", "0");
		}
		departmentService.save(pd);
		FHLOG.save(Jurisdiction.getUsername(), "新增架构","OA_DEPARTMENT","NAME",pd.getString("NAME"));
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 * @param DEPARTMENT_ID
	 * @param
	 * @throws Exception 
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object delete(@RequestParam String DEPARTMENT_ID) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除department");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd.put("DEPARTMENT_ID", DEPARTMENT_ID);
		String errInfo = "success";
		if(departmentService.listSubDepartmentByParentId(DEPARTMENT_ID).size() > 0){//判断是否有子级，是：不允许删除
			errInfo = "false";
		}else{
			departmentService.delete(pd);	//执行删除
			FHLOG.save(Jurisdiction.getUsername(), "删除架构","OA_DEPARTMENT","DEPARTMENT_ID",DEPARTMENT_ID);
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改department");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String str = pd.getString("pzgl1");
		if(str!=null && str.equals("1")){
			pd.put("PZ_QX", "1");
		}else{
			pd.put("PZ_QX", "0");
		}
		String str1 = pd.getString("pzgl2");
		if(str1!=null && str1.equals("1")){
			pd.put("FJ_QX", "1");
		}else{
			pd.put("FJ_QX", "0");
		}
		String str2 = pd.getString("pzgl3");
		if(str2!=null &&str2.equals("1")){
			pd.put("DN_QX", "1");
		}else{
			pd.put("DN_QX", "0");
		}
		String str3 = pd.getString("pzgl4");
		if(str3!=null &&str3.equals("1")){
			pd.put("SS_QX", "1");
		}else{
			pd.put("SS_QX", "0");
		}
		departmentService.edit(pd);
		FHLOG.save(Jurisdiction.getUsername(), "修改架构","OA_DEPARTMENT","NAME",pd.getString("NAME"));
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表department");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");					//检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String DEPARTMENT_ID = null == pd.get("DEPARTMENT_ID")?"":pd.get("DEPARTMENT_ID").toString();
		if(null != pd.get("id") && !"".equals(pd.get("id").toString())){
			DEPARTMENT_ID = pd.get("id").toString();
		}
		pd.put("DEPARTMENT_ID", DEPARTMENT_ID);					//上级ID
		page.setPd(pd);
		List<PageData>	varList = departmentService.list(page);	//列出Dictionaries列表
		mv.addObject("pd", departmentService.findById(pd));		//传入上级所有信息
		mv.addObject("DEPARTMENT_ID", DEPARTMENT_ID);			//上级ID
		mv.setViewName("fhoa/department/department_list");
		mv.addObject("varList", varList);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		return mv;
	}
	
	/**
	 * 显示列表ztree
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllDepartment")
	public ModelAndView listAllDepartment(Model model,String DEPARTMENT_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartment("0"));
			String json = arr.toString();
			json = json.replaceAll("DEPARTMENT_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("NAME", "name").replaceAll("subDepartment", "nodes").replaceAll("hasDepartment", "checked").replaceAll("treeurl", "url");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("DEPARTMENT_ID",DEPARTMENT_ID);
			mv.addObject("pd", pd);	
			mv.setViewName("fhoa/department/department_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String DEPARTMENT_ID = null == pd.get("DEPARTMENT_ID")?"":pd.get("DEPARTMENT_ID").toString();
		pd.put("DEPARTMENT_ID", DEPARTMENT_ID);					//上级ID
		mv.addObject("pds",departmentService.findById(pd));		//传入上级所有信息
		mv.addObject("DEPARTMENT_ID", DEPARTMENT_ID);			//传入ID，作为子级ID用
		mv.setViewName("fhoa/department/department_edit");
		mv.addObject("msg", "save");
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String DEPARTMENT_ID = pd.getString("DEPARTMENT_ID");
		pd = departmentService.findById(pd);	//根据ID读取
		mv.addObject("pd", pd);					//放入视图容器
		pd.put("DEPARTMENT_ID",pd.get("PARENT_ID").toString());			//用作上级信息
		mv.addObject("pds",departmentService.findById(pd));				//传入上级所有信息
		mv.addObject("DEPARTMENT_ID", pd.get("PARENT_ID").toString());	//传入上级ID，作为子ID用
		pd.put("DEPARTMENT_ID",DEPARTMENT_ID);							//复原本ID
		mv.setViewName("fhoa/department/department_edit");
		mv.addObject("msg", "edit");
		return mv;
	}	

	/**判断编码是否存在
	 * @return
	 */
	@RequestMapping(value="/hasBianma")
	@ResponseBody
	public Object hasBianma(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(departmentService.findByBianma(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 显示菜单列表ztree(菜单授权菜单)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/menuqx")
	public ModelAndView listAllMenu(Model model,String DEPARTMENT_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		try{
			PageData pd = new PageData();
			pd.put("DEPARTMENT_ID", DEPARTMENT_ID);
			PageData dep = departmentService.findById(pd);
			String roleRights = dep.getString("RIGHTS");			//取出本角色菜单权限
			List<Menu> menuList = menuService.listAllMenuQx("0");	//获取所有菜单
			menuList = this.readMenu(menuList, roleRights);			//根据角色权限处理菜单权限状态(递归处理)
			JSONArray arr = JSONArray.fromObject(menuList);
			String json = arr.toString();
			json = json.replaceAll("MENU_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("MENU_NAME", "name").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("DEPARTMENT_ID",DEPARTMENT_ID);
			mv.setViewName("fhoa/department/menuqx");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**保存角色菜单权限
	 * @param ROLE_ID 角色ID
	 * @param menuIds 菜单ID集合
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/saveMenuqx")
	public void saveMenuqx(@RequestParam String DEPARTMENT_ID,@RequestParam String menuIds,PrintWriter out)throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改菜单权限");
		FHLOG.save(Jurisdiction.getUsername(), "修改组织菜单权限，组织ID为:"+DEPARTMENT_ID,"OA_DEPARTMENT","DEPARTMENT_ID",DEPARTMENT_ID);
		
		try{
			if(null != menuIds && !"".equals(menuIds.trim())){
				BigInteger rights = RightsHelper.sumRights(Tools.str2StrArray(menuIds));//用菜单ID做权处理
				PageData pd = new PageData();
				pd.put("DEPARTMENT_ID", DEPARTMENT_ID);
				PageData dep = departmentService.findById(pd);
				dep.put("RIGHTS",rights.toString());
				departmentService.updateDepRights(dep);				//更新当前角色菜单权限
			//	pd.put("rights",rights.toString());
			}else{				
				PageData pd = new PageData();
				pd.put("DEPARTMENT_ID", DEPARTMENT_ID);
				PageData dep = departmentService.findById(pd);
				dep.put("RIGHTS","");
				departmentService.updateDepRights(dep);			
			}				
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}

	/**请求组织架构授权页面(增删改查)
	 * @param ROLE_ID： 角色ID
	 * @param msg： 区分增删改查
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/b4Button")
	public ModelAndView b4Button(@RequestParam String DEPARTMENT_ID,@RequestParam String msg,Model model)throws Exception{
		ModelAndView mv = this.getModelAndView();
		try{
			List<Menu> menuList = menuService.listAllMenuQx("0"); //获取所有菜单
			PageData pd = new PageData();
			pd.put("DEPARTMENT_ID", DEPARTMENT_ID);
			PageData dep = departmentService.findById(pd);		  //根据角色ID获取角色对象
			String roleRights = "";
			if("add_qx".equals(msg)){
				roleRights = dep.getString("ADD_QX");	//新增权限
			}else if("del_qx".equals(msg)){
				roleRights = dep.getString("DEL_QX");	//删除权限
			}else if("edit_qx".equals(msg)){
				roleRights = dep.getString("EDIT_QX");	//修改权限
			}else if("cha_qx".equals(msg)){
				roleRights = dep.getString("CHA_QX");	//查看权限
			}
			menuList = this.readMenu(menuList, roleRights);		//根据角色权限处理菜单权限状态(递归处理)
			JSONArray arr = JSONArray.fromObject(menuList);
			String json = arr.toString();
			json = json.replaceAll("MENU_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("MENU_NAME", "name").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("DEPARTMENT_ID",DEPARTMENT_ID);
			mv.addObject("msg", msg);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		mv.setViewName("fhoa/department/b4Button");
		return mv;
	}
	/**
	 * 保存角色按钮权限
	 */
	/**
	 * @param ROLE_ID
	 * @param menuIds
	 * @param msg
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/saveB4Button")
	public void saveB4Button(@RequestParam String DEPARTMENT_ID,@RequestParam String menuIds,@RequestParam String msg,PrintWriter out)throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改"+msg+"权限");
		FHLOG.save(Jurisdiction.getUsername(), "修改"+msg+"权限，角色ID为:"+DEPARTMENT_ID,"SYS_ROLE","DEPARTMENT_ID",DEPARTMENT_ID);
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(null != menuIds && !"".equals(menuIds.trim())){
				BigInteger rights = RightsHelper.sumRights(Tools.str2StrArray(menuIds));
				pd.put("value",rights.toString());
			}else{
				pd.put("value","");
			}
			pd.put("DEPARTMENT_ID", DEPARTMENT_ID);
			departmentService.saveB4Button(msg,pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	/**根据角色权限处理权限状态(递归处理)
	 * @param menuList：传入的总菜单
	 * @param roleRights：加密的权限字符串
	 * @return
	 */
	public List<Menu> readMenu(List<Menu> menuList,String roleRights){
		for(int i=0;i<menuList.size();i++){
			menuList.get(i).setHasMenu(RightsHelper.testRights(roleRights, menuList.get(i).getMENU_ID()));
			this.readMenu(menuList.get(i).getSubMenu(), roleRights);					//是：继续排查其子菜单
		}
		return menuList;
	}
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
	
}
