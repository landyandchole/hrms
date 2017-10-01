package com.hand.controller.activiti.publish;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.List;
import java.util.zip.ZipInputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author liuwei
 * 说明:工作流部署
 * 开发时间:2017-07-10
 */
@Controller
@RequestMapping(value="/publish")
public class PublishController extends BaseController {

	//注入activitiService服务
	@Resource	
	private RepositoryService repositoryService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	
	/**列表
	 * @param page
	 * @param keywords
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page,HttpServletRequest request,String keywords) throws Exception{
 		if(keywords==null){
			keywords = "";
		}
 		
		ModelAndView mv = this.getModelAndView();
		String currentPageStr = request.getParameter("page.currentPage");
		String showCountStr = request.getParameter("page.showCount");
		if (!StringUtils.isBlank(currentPageStr)) {
			page.setCurrentPage(Integer.parseInt(currentPageStr));
		}
		if (!StringUtils.isBlank(showCountStr)) {
			page.setShowCount(Integer.parseInt(showCountStr));
		}
		PageData pd = new PageData();
		pd = this.getPageData();	
		Long deployCount=repositoryService.createDeploymentQuery().deploymentNameLike("%"+keywords+"%")
				.count();
		page.setTotalResult(deployCount.intValue());//设置页面查询总数
		page.setPd(pd);
		List<Deployment> deployList=repositoryService.createDeploymentQuery()//创建流程查询实例
				.orderByDeploymenTime().desc()  //降序
				.deploymentNameLike("%"+keywords+"%")   //根据Name模糊查询
				.listPage(page.getCurrentResult(), page.getShowCount());
		mv.setViewName("activiti/publish/publish_list");
		mv.addObject("varList", deployList);	
		mv.addObject("pd", pd);		
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**跳转新增页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("activiti/publish/publish_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	/**新增
	 * @param response
	 * @param deployFile
	 * @return
	 * @throws IOException 
	 * @throws Exception
	 */
	@RequestMapping("/addDeploy")
	public ModelAndView addDeploy(HttpServletResponse response,MultipartFile deployFile) throws IOException {
		ModelAndView mv = this.getModelAndView();
		if(deployFile.getOriginalFilename().split(".z").length==2){
			repositoryService.createDeployment() //创建部署
			.name(deployFile.getOriginalFilename().split(".z")[0])	//需要部署流程名称
			.addZipInputStream(new ZipInputStream(deployFile.getInputStream(),Charset.forName("gbk")))//添加ZIP输入流
			.deploy();//开始部署
			mv.addObject("msg", "success");
		} else{
			mv.addObject("msg", "fail");
		}
		mv.setViewName("activiti/publish/publish_result");
		try {
			FHLOG.save(Jurisdiction.getUsername(), "PC申请新增","pc_leave","","");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}					
}
