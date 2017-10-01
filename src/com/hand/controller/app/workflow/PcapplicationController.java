package com.hand.controller.app.workflow;




//import java.util.ArrayList;
//import java.util.List;
//
//import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
//import com.hand.util.Jurisdiction;
//import com.hand.util.PageData;

/** 
 * 说明：PC管理
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 */
@Controller
@RequestMapping(value="/pca")
public class PcapplicationController extends BaseController {
	
	String menuUrl = "pca/application.do"; //菜单地址(权限用)

	
	
	
	/**列表(检索条件中的部门，只列出此操作用户最高部门权限以下所有部门的员工)
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/application")
	public ModelAndView list() throws Exception{
		//logBefore(logger, Jurisdiction.getUsername()+"列表PC");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();		
		mv.setViewName("app/pc/pc_application");
		return mv;
	}
	

	
	
}
