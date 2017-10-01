package com.hand.controller.app.video;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.entity.app.VideoGroup;
import com.hand.entity.system.Role;
import com.hand.service.app.video.VideoGroupService;
import com.hand.service.app.video.VideoService;
import com.hand.service.fhoa.datajur.DatajurManager;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.service.system.role.RoleManager;
import com.hand.util.AppUtil;
import com.hand.util.Const;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;
import com.hand.util.PathUtil;
import com.hand.util.Tools;


@Controller
@RequestMapping(value="/video")
public class VideoController extends BaseController{

	String menuUrl = "happuser/listUsers.do";
	@Resource(name="videoService")
	private VideoService videoService;
	@Resource(name="videoGroupService")
	private VideoGroupService videoGroupService;
	@Resource(name="roleService")
	private RoleManager roleService;
	@Resource(name="datajurService")
	private DatajurManager datajurService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	
	
	/**
	 * 视频列表遍历
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/videolist")
	public ModelAndView VideoList(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表video");
		ModelAndView mv=this.getModelAndView();
		PageData pd=new PageData();
		try{
			pd = this.getPageData();
			
			/*String keywords = pd.getString("keywords");					//检索条件
			if(null != keywords && !"".equals(keywords)){
				pd.put("keywords", keywords.trim());
			}*/
			
			String VIDEONAME = pd.getString("VIDEONAME");							//检索条件 关键词
			String VGID = pd.getString("VIDEOGROUP_ID");
			if(null != VIDEONAME && !"".equals(VIDEONAME)){
				pd.put("VIDEONAME", VIDEONAME);
			}
			if(null != VGID && !"".equals(VGID)&&!VGID.equals("0")){
				pd.put("VIDEOGROUP", VGID);
			}
			
		
			page.setPd(pd);
		List<PageData> vList=videoService.getAllVideo(page);
		//列表页面树形下拉框用(保持下拉树里面的数据不变)
		String VIDEO_ID = pd.getString("VIDEOGROUP_ID");
//		VIDEO_ID = Tools.notEmpty(VIDEO_ID)?VIDEO_ID:Jurisdiction.getDEPARTMENT_ID();
		pd.put("VIDEO_ID", VIDEO_ID);
		List<PageData> zvideoPdList = new ArrayList<PageData>();
		JSONArray arr = JSONArray.fromObject(videoGroupService.listAllVideoToSelect("0",zvideoPdList));
		mv.addObject("zTreeNodes", arr.toString());
		pd.put("ROLE_ID", "2");
		List<Role> roleList = roleService.listAllRolesByPId(pd);
		PageData dpd = videoGroupService.findById(pd);
		
		if(null != dpd){
			VIDEO_ID = dpd.getString("NAME");
			
		}
		mv.addObject("depname", VIDEO_ID);
		mv.addObject("vlist",vList);
		mv.addObject("roleList", roleList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		mv.setViewName("app/video/video_list");
		}catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 视频删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteV")
	public void deleteU(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除视频");
		PageData pd = new PageData();
		pd = this.getPageData();
		String fileName=videoService.findByViId(pd.getString("ID")).getString("VIDEOPATH");
		String path=PathUtil.getClasspath() + Const.FILEPATHFILEOA + fileName;
		File file1 = new File(path);  
	    // 路径为文件且不为空则进行删除  
	    if (file1.isFile() && file1.exists()) { 
	        file1.delete();
	    }
		videoService.deleteV(pd);
		FHLOG.save(Jurisdiction.getUsername(), "删除视频","TB_VIDEO","ID",pd.getString("ID"));
		out.write("success");
		out.close();
		
	}
	
	/**去修改用户页面
	 * @return
	 */
	@RequestMapping(value="/goEditV")
	public ModelAndView goEditV(){
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {					
			pd = videoService.findByViId(pd.getString("ID"));//根据ID读取
			VideoGroup VG=videoGroupService.findForName(pd.getString("VIDEOGROUP"));
			pd.put("NAME", VG.getNAME());
			String VIDEO_ID = pd.getString("VIDEO_ID");
			VIDEO_ID = Tools.notEmpty(VIDEO_ID)?VIDEO_ID:Jurisdiction.getDEPARTMENT_ID();
			List<PageData> zvideoPdList = new ArrayList<PageData>();
			JSONArray arr = JSONArray.fromObject(videoGroupService.listAllVideoToSelect(VIDEO_ID,zvideoPdList));
			mv.addObject("zTreeNodes", arr.toString());
			mv.addObject("pd", pd);
			mv.setViewName("app/video/video_edit");		
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}	
		return mv;
	}
	
	/**
	 * 视频编辑
	 * @param out
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editV")
	public ModelAndView editU(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改会员");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		videoService.editV(pd);
		FHLOG.save(Jurisdiction.getUsername(), "修改视频","TB_VIDEO","ID",pd.getString("ID"));
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**批量删除
	 * @return
	 */
	@RequestMapping(value="/deleteAllV")
	@ResponseBody
	public Object deleteAllU() {
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"批量删除视频");
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String IDS = pd.getString("IDS");
			if(null != IDS && !"".equals(IDS)){
				String ArrayVideo_IDS[] = IDS.split(",");
				for (int i = 0; i < ArrayVideo_IDS.length; i++) {
					String fileName=videoService.findByViId(ArrayVideo_IDS[i]).getString("VIDEOPATH");
					String path=PathUtil.getClasspath() + Const.FILEPATHFILEOA + fileName;
					File file1 = new File(path);  
				    // 路径为文件且不为空则进行删除  
				    if (file1.isFile() && file1.exists()) { 
				        file1.delete();
				    }
				}
				
				videoService.deleteAllV(ArrayVideo_IDS);
				FHLOG.save(Jurisdiction.getUsername(), "批量删除视频","TB_VIDEO","ID",IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/videoAdd")
	public ModelAndView goAdd(Page page)throws Exception{
		Session session = Jurisdiction.getSession();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String VIDEO_ID = null == pd.get("VIDEO_ID")?"":pd.get("VIDEO_ID").toString();
		if(null != pd.get("id" ) && !"".equals(pd.get("id").toString())){
			VIDEO_ID = pd.get("id").toString();
		}
		String username = (String) session.getAttribute(Const.SESSION_USERNAME);
		pd.put("UPLOADUSER", username);
		page.setPd(pd);
		//List<PageData> vList=videoService.getAllVideo(page);
		
		//列表页面树形下拉框用(保持下拉树里面的数据不变)
	//	String VIDEO_ID = pd.getString("VIDEO_ID");
		VIDEO_ID = Tools.notEmpty(VIDEO_ID)?VIDEO_ID:Jurisdiction.getDEPARTMENT_ID();
		pd.put("VIDEO_ID", VIDEO_ID);
		List<PageData> zvideoPdList = new ArrayList<PageData>();
		JSONArray arr = JSONArray.fromObject(videoGroupService.listAllVideoToSelect(VIDEO_ID,zvideoPdList));
		mv.addObject("zTreeNodes", arr.toString());
		mv.addObject("pd", pd);
		mv.setViewName("app/video/videoAdd");
		return mv;
	}	
	
	/**去播放页面
	 * @param
	 * @throws Exception
	 */
	    @RequestMapping(value="/goPlay")
	    public ModelAndView goPlay()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String path=pd.getString("path");
		pd.put("ext", path.split("\\.")[1]);
		mv.setViewName("app/video/video_play");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	
	/**
	 * 视频添加
	 * @param pd
	 * @throws Exception
	 */
	@RequestMapping(value="/videosave")
	public ModelAndView videoSave() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增视频");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		List<PageData> vList=videoService.getAllVideo(getPage());
		mv.addObject("vlist",vList);
		pd = this.getPageData();
		String ID=pd.getString("ID");
		if(ID==""||null==ID){
			pd.put("ID", this.get32UUID());	                            //ID 主键
		}
		Date date=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:dd:ss");
		String update=sdf.format(date);			
		pd.put("UPLOADTIME",update);		                        //上传时间
		videoService.videoSave(pd);
		FHLOG.save(Jurisdiction.getUsername(), "添加视频","TB_VIDEO","ID",pd.getString("ID"));
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
}
