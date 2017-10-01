package com.hand.controller.event;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.ProcessBuilder.Redirect;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.http.HttpHeaders;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.entity.system.Role;
import com.hand.service.event.event.EventManager;
import com.hand.util.AppUtil;
import com.hand.util.Const;
import com.hand.util.FileDownload;
import com.hand.util.FileUtil;
import com.hand.util.Jurisdiction;
import com.hand.util.ObjectExcelView;
import com.hand.util.PageData;
import com.hand.util.PathUtil;

/**
 * 说明：事件 创建时间：2017-07-04
 */
@Controller
@RequestMapping(value = "/event")
public class EventController extends BaseController {

	String menuUrl = "event/list.do"; // 菜单地址(权限用)
	@Resource(name = "eventService")
	private EventManager eventService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	// @RequestMapping(value="/save")
	public ModelAndView save() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增Event");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("EVENT_ID", this.get32UUID()); // 主键
		// pd.put("USERNAME", ""); //用户名
		pd.put("FILESIZE",
				FileUtil.getFilesize(PathUtil.getClasspath()
						+ Const.FILEPATHFILEOA + pd.getString("FILEPATH"))); // 文件大小
		eventService.save(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "删除Event");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		eventService.delete(pd);
		out.write("success");
		out.close();
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	// public ModelAndView edit() throws Exception{
	// ModelAndView mv = this.getModelAndView();
	// PageData pd = new PageData();
	// pd = this.getPageData();
	// eventService.edit(pd);
	// mv.addObject("msg","success");
	// mv.setViewName("save_result");
	// return mv;
	public String edit(HttpServletRequest request) throws Exception {
		{
			String param4 = null;
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
					request.getSession().getServletContext());
			// 检查form中是否有enctype="multipart/form-data"
			if (multipartResolver.isMultipart(request)) {
				// 将request变成多部分request
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				// 获取multiRequest 中所有的文件名
				PageData pd = new PageData();
				
				String eventId = multiRequest.getParameter("EVENT_ID");
				param4 = multiRequest.getParameter("EVENT_FILE");
				pd = this.getPageData();
				pd.put("EVENT_ID", eventId);

				Iterator iter = multiRequest.getFileNames();
				String param = multiRequest.getParameter("EVENT_NAME");
				String param1 = multiRequest.getParameter("EVENT_DATE");
				String param2 = multiRequest.getParameter("EVENT_PERSON");
				String param3 = multiRequest.getParameter("EVENT_BS");
				
				while (iter.hasNext()) {
					// 一次遍历所有文件
					MultipartFile file = multiRequest.getFile(iter.next()
							.toString());
					String fileName = file.getOriginalFilename();

					if (file != null && fileName!= null
							&& fileName != "") {
						String basePath = request.getSession()
								.getServletContext().getRealPath("/");
						Date date = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat(
								"yyyyMMddHHmmss");
						String dt = "/uploadFiles/" + sdf.format(date).trim();
						File dir = new File(basePath + dt,
								file.getOriginalFilename());
						if (!dir.exists()) {
							dir.mkdirs();
						}
						System.out.println(basePath + dt + "/"
								+ file.getOriginalFilename());
						// 上传
						file.transferTo(dir);
						param4 = dt + "/" + file.getOriginalFilename();

					}
				}
				String param5 = multiRequest.getParameter("EVENT_DDATE");
				pd.put("EVENT_DATE", param1); // 用户名
				pd.put("EVENT_PERSON", param2); // 用户名
				pd.put("EVENT_BS", param3); // 用户名
				pd.put("EVENT_NAME", param); // 用户名
				pd.put("EVENT_FILE", param4); // 用户名
				pd.put("EVENT_DDATE", param5); // 用户名
				eventService.edit(pd);
			}
			return "save_result";
		}
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Event");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList = eventService.list(page); // 列出Event列表
		for(int i=0;i<varList.size();i++){
			String filenames=null;
			String filename=varList.get(i).getString("EVENT_FILE");
			System.out.println(filename);
			if(filename!=null){
				String name=filename.substring(filename.lastIndexOf("/"));
				filenames=name.substring(1);
				filename=filenames;
				varList.get(i).put("EVENT_FILE", filename);
			}
		}
		mv.setViewName("event/event_list");
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
		mv.setViewName("event/event_add");
		mv.addObject("msg", "save");
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
		System.out.println(pd.getString("EVENT_ID"));
		pd = eventService.findById(pd); // 根据ID读取
		mv.setViewName("event/event_edit");
		mv.addObject("msg", "edit");
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
		logBefore(logger, Jurisdiction.getUsername() + "批量删除Event");
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
			eventService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,
				true));
	}

	@RequestMapping(value = "/save")
	public String upfile(HttpServletRequest request) throws Exception {
		{
			String param4 = null;
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
					request.getSession().getServletContext());
			// 检查form中是否有enctype="multipart/form-data"
			if (multipartResolver.isMultipart(request)) {
				// 将request变成多部分request
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				// 获取multiRequest 中所有的文件名
				Iterator iter = multiRequest.getFileNames();
				String param = multiRequest.getParameter("EVENT_NAME");
				String param1 = multiRequest.getParameter("EVENT_DATE");
				String param2 = multiRequest.getParameter("EVENT_PERSON");
				String param3 = multiRequest.getParameter("EVENT_BS");
				String param5 = multiRequest.getParameter("EVENT_DDATE");

				while (iter.hasNext()) {
					// 一次遍历所有文件
					MultipartFile file = multiRequest.getFile(iter.next()
							.toString());

					if (!file.isEmpty()) {
						String basePath = request.getSession()
								.getServletContext().getRealPath("/");
						Date date = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat(
								"yyyyMMddHHmmss");
						String dt = "/uploadFiles/" + sdf.format(date).trim();
						File dir = new File(basePath + dt,
								file.getOriginalFilename());
						if (!dir.exists()) {
							dir.mkdirs();
						}
						System.out.println(basePath + dt + "/"
								+ file.getOriginalFilename());
						// 上传
						file.transferTo(dir);
						param4 = dt + "/" + file.getOriginalFilename();

					}
				}
				PageData pd = new PageData();
				pd = this.getPageData();
				pd.put("EVENT_ID", this.get32UUID());
				pd.put("EVENT_DATE", param1); // 用户名
				pd.put("EVENT_PERSON", param2); // 用户名
				pd.put("EVENT_BS", param3); // 用户名
				pd.put("EVENT_NAME", param); // 用户名
				pd.put("EVENT_FILE", param4); // 用户名
				pd.put("EVENT_DDATE", param5); // 用户名
				eventService.save(pd);
			}
			return "save_result";
		}
	}

	@RequestMapping("/download")
	public String download(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("utf-8");
        
		String basePath = request.getSession().getServletContext()
				.getRealPath("");
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData pdd = eventService.findById(pd);
		String fileName = pdd.getString("EVENT_FILE");
		String fileNames = fileName.substring(fileName.lastIndexOf("/"));
		String name=fileNames.substring(1);
		FileDownload.fileDownloads(request,response, basePath+fileName,name);
		/*try {
			String basePath = request.getSession().getServletContext()
					.getRealPath("/");
			PageData pd = new PageData();
			pd = this.getPageData();
			PageData pdd = eventService.findById(pd);
			String fileName = pdd.getString("EVENT_FILE");
			fileName = fileName.substring(fileName.lastIndexOf("/"));
			System.out.println(fileName);
			response.setContentType("multipart/form-data");
			response.setHeader("Content-Disposition", "attachment;fileName="
					+ fileName);
			System.out.println(basePath+ pdd.getString("EVENT_FILE"));
			InputStream inputStream = new FileInputStream(new File(basePath
					+ pdd.getString("EVENT_FILE")));
			OutputStream os = response.getOutputStream();
			byte[] b = new byte[2048];
			int length;
			while ((length = inputStream.read(b)) > 0) {
				os.write(b, 0, length);
			}
			// 这里主要关闭。
			os.flush();

			inputStream.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}*/
		// 返回值要注意，要不然就出现下面这句错误！
		return null; // java+getOutputStream() has already been called for this
						// response

	}
}
