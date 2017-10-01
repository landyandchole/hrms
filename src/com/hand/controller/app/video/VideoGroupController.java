package com.hand.controller.app.video;



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
import com.hand.entity.system.Menu;
import com.hand.service.app.video.VideoGroupService;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.util.AppUtil;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;


@Controller
@RequestMapping(value="/video")
public class VideoGroupController extends BaseController {
	String menuUrl = "video/list.do"; //菜单地址(权限用)
	@Resource(name="videoGroupService")
	private VideoGroupService videoGroupService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增video");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("VIDEO_ID", this.get32UUID());	//主键
		videoGroupService.save(pd);
		FHLOG.save(Jurisdiction.getUsername(), "新增视频分组","oa_videogroup OA_VIDEOGROUP","VIDEO_ID",pd.getString("VIDEO_ID"));
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
	public Object delete(@RequestParam String VIDEO_ID) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除video");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd.put("VIDEO_ID", VIDEO_ID);
		String errInfo = "success";
		if(videoGroupService.listSubVideoByParentId(VIDEO_ID).size() > 0){//判断是否有子级，是：不允许删除
			errInfo = "false";
		}else{
			videoGroupService.delete(pd);	//执行删除
			FHLOG.save(Jurisdiction.getUsername(), "删除视频分组","oa_videogroup OA_VIDEOGROUP","VIDEO_ID",pd.getString("VIDEO_ID"));
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
	/*@RequestMapping(value="/addvideogroup")
	public ModelAndView add(Menu menu)throws Exception{
		
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("app/video/video_new"); //保存成功跳转到列表页面
		return mv;
	}*/
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改video");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		videoGroupService.edit(pd);
		FHLOG.save(Jurisdiction.getUsername(), "修改视频分组","oa_videogroup OA_VIDEOGROUP","VIDEO_ID",pd.getString("VIDEO_ID"));
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
		logBefore(logger, Jurisdiction.getUsername()+"列表video");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");					//检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String VIDEO_ID = null == pd.get("VIDEO_ID")?"":pd.get("VIDEO_ID").toString();
		if(null != pd.get("id" ) && !"".equals(pd.get("id").toString())){
			VIDEO_ID = pd.get("id").toString();
		}
		pd.put("VIDEO_ID", VIDEO_ID);					//上级ID
		page.setPd(pd);
		List<PageData>	varList = videoGroupService.list(page);	//列出Dictionaries列表
		mv.addObject("pd", videoGroupService.findById(pd));		//传入上级所有信息
		mv.addObject("VIDEO_ID", VIDEO_ID);			//上级ID
		mv.setViewName("app/video/videogroup_list");
		mv.addObject("varList", varList);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		return mv;
	}
	
	
	/**
	 * 显示列表ztree
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllVideo")
	public ModelAndView listAllVideo(Model model,String VIDEO_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			JSONArray arr = JSONArray.fromObject(videoGroupService.listAllVideo("0"));
			String json = arr.toString();
			json = json.replaceAll("VIDEO_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("NAME", "name").replaceAll("subVideo", "nodes").replaceAll("hasVideo", "checked").replaceAll("treeurl", "url");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("VIDEO_ID",VIDEO_ID);
			mv.addObject("pd", pd);	
			mv.setViewName("app/video/videogroup_ztree");
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
		String VIDEO_ID = null == pd.get("VIDEO_ID")?"":pd.get("VIDEO_ID").toString();
		pd.put("VIDEO_ID", VIDEO_ID);					//上级ID
		mv.addObject("pds",videoGroupService.findById(pd));		//传入上级所有信息
		mv.addObject("VIDEO_ID", VIDEO_ID);			//传入ID，作为子级ID用
		mv.setViewName("app/video/videogroup_edit");
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
		String VIDEO_ID = pd.getString("VIDEO_ID");
		pd = videoGroupService.findById(pd);	//根据ID读取
		mv.addObject("pd", pd);					//放入视图容器
		pd.put("VIDEO_ID",pd.get("PARENT_ID").toString());			//用作上级信息
		mv.addObject("pds",videoGroupService.findById(pd));				//传入上级所有信息
		mv.addObject("VIDEO_ID", pd.get("PARENT_ID").toString());	//传入上级ID，作为子ID用
		pd.put("VIDEO_ID",VIDEO_ID);							//复原本ID
		mv.setViewName("app/video/videogroup_edit");
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
			if(videoGroupService.findByBianma(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}

}
