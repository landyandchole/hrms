package com.hand.controller.app.pc;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.service.app.pc.CheckManager;
import com.hand.service.app.pc.PcManager;
import com.hand.service.app.pc.impl.PcService;
import com.hand.service.app.project.ProSecurityManager;
import com.hand.service.app.video.VideoService;
import com.hand.service.system.fhlog.FHlogManager;
import com.hand.util.AppUtil;
import com.hand.util.ObjectExcelView;
import com.hand.util.PageData;
import com.hand.util.Jurisdiction;
import com.hand.util.Tools;

/** 
 * 说明：P入场/退场检查
 * 创建时间：2017-07-03
 */
@Controller
@RequestMapping(value="/pccheck")

public class CheckController extends BaseController {
	
	String menuUrl = "checkcontroller/list.do"; //菜单地址(权限用)
	@Resource(name="checkService")
	private CheckManager checkService;
	@Autowired
	private  HttpServletRequest request;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="prosecurityService")
	private ProSecurityManager prosecurityService;
	@Resource(name = "pcService")
	private PcService pcService;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"pc检查");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CHECK_ID", this.get32UUID());
			
		String checkdate=pd.getString("CHECK_DATE");
		String check_type= request.getParameter("CHECK_TYPE");
		String PROJECT_ID =request.getParameter("PROJECT_ID");
		pd.put("PROJECT_ID", PROJECT_ID);
		if( ("-1").equals(check_type)){//入场检查
			pd.put("ENTRY_DATE", checkdate);
			pd.put("EXIT_DATE",null);
			pd.put("CHECK_TYPE", "-1");
		}
		else if (("0").equals(check_type)){//月别检查
			pd.put("ENTRY_DATE", pd.getString("CHECK_DATE"));
			pd.put("EXIT_DATE",null);
			pd.put("CHECK_TYPE", "0");
		}
		
		else if(("1").equals(check_type)){//退场检查
			pd.put("EXIT_DATE", pd.getString("CHECK_DATE"));
			pd.put("ENTRY_DATE",null);
			pd.put("CHECK_TYPE", "1");
			String USB_DISABLE2=pd.getString("USB_DISABLE2");
			if(null!=USB_DISABLE2||!("").equals(USB_DISABLE2)){
				pd.put("USB_DISABLE", USB_DISABLE2);
			}
			String OFFICE_ACTIV2=pd.getString("OFFICE_ACTIVE2");
			if(null!=OFFICE_ACTIV2||!("").equals(OFFICE_ACTIV2)){
				pd.put("OFFICE_ACTIVE", OFFICE_ACTIV2);
			}
			String WINDOWS_ACTIVE2=pd.getString("WINDOWS_ACTIVE2");
			if(null!=WINDOWS_ACTIVE2||!("").equals(WINDOWS_ACTIVE2)){
				pd.put("WINDOWS_ACTIVE", WINDOWS_ACTIVE2);
			}
			String VIRUS_ISOLATION2=pd.getString("VIRUS_ISOLATION2");
			if(null!=VIRUS_ISOLATION2||!("").equals(VIRUS_ISOLATION2)){
				pd.put("VIRUS_ISOLATION", VIRUS_ISOLATION2);
			}
		}
		
		String REMARK= pd.getString("REMARK");
		if(REMARK==null||REMARK.equals("")){
			pd.put("REMARK", "无");
		}
		
		String PC_STATE=pd.getString("PC_STATE");
		if(("afd972ec76334ba7949c8ed093449b29").equals(PC_STATE)){//已入场
			pd.put("PC_STATE", "8b2bb55faa4e4258870ebd1aaeedf489");
			pd.put("PC_ADMISSION", "已完成");
			pd.put("ADMISSIONDATE", checkdate);
			prosecurityService.pcEntried(pd);
		
			PageData pda=new PageData();
			String PC_NO=pd.getString("PC_NO");
			String DEPOT = "c44b146e55cc4c96b3a7ddaa81609c55";//在库情况已入场
			pda.put("PC_NO", PC_NO);
			pda.put("DEPOT", DEPOT);
			pcService.editDepot(pda);
			
		}
		if(("141b48c7bc554d58bd298dc9acff3f46").equals(PC_STATE)){//已退场
			PageData pdas=new PageData();
			String PC_NO=pd.getString("PC_NO");
			pdas.put("DEPOT", "b7c839d9661e47a785a20c47d4d66ab6");
			pdas.put("PC_NO", PC_NO);
			pcService.editDepot(pdas);//修改为退场准备中
			pd.put("PC_STATE", "23311be958564db8a9697d23361ee0bf");
			pd.put("PC_EXIT", "已完成");
			pd.put("EXITDATE", checkdate);
			prosecurityService.pcExited(pd);
			PageData pda=new PageData();
			String DEPOT = "cd11cb2ebefa4e99b94a62aa5ab44a59";
			pda.put("PC_NO", PC_NO);
			pda.put("DEPOT", DEPOT);//修改为已退场
			pda.put("PROGRAM", "");
			pda.put("ROOM_NAME","");
			pcService.editDepot(pda);
			
		}
		pd.put("FLAG", "0");
		checkService.save(pd);
		FHLOG.save(Jurisdiction.getUsername(), "添加PC_CHECK","PC_CHECK","CHECK_ID",pd.getString("CHECK_ID"));
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		mv.addObject("pd",pd);
		return mv;
		
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改CheckController");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String  check_type= request.getParameter("CHECK_TYPE");
		String checkdate=pd.getString("CHECK_DATE");
		
		if(("-1").equals(check_type)||("0").equals(check_type)){
			pd.put("ENTRY_DATE", checkdate);
			pd.put("EXIT_DATE",null);
			pd.put("CHECK_TYPE", check_type);
			pd.put("C_FOMAT", null);
			pd.put("C_RESTORY", null);
			pd.put("GC_CLEAR", null);
			pd.put("NO_EXCEL", null);
		}
		
		else if(("1").equals(check_type)){//退场
			pd.put("EXIT_DATE", checkdate);
			pd.put("ENTRY_DATE", pd.getString("ENTRY_DATE"));
			pd.put("CHECK_TYPE", check_type);
			pd.put("PASSWORDSET",null);
			pd.put("PASSWORDUP", null);
			pd.put("SCREEN", null);
			pd.put("VIRUS_CHECK", null);
			pd.put("NEWVIRUS_UPLOAD", null);
			pd.put("WHITE_LIST", null);
			pd.put("PORT_FASTEN", null);
			pd.put("FILEEXCHANGE_DISABLE", null);
			pd.put("PORT_FASTEN", null);
			
		String REMARK= pd.getString("REMARK");
		if(REMARK==null||REMARK.equals("")){
			pd.put("REMARK", "无");
		}
		String USB_DISABLE=pd.getString("USB_DISABLE2");
		if(null!=USB_DISABLE||!("").equals(USB_DISABLE)){
			pd.put("USB_DISABLE", USB_DISABLE);
		}
		String OFFICE_ACTIVE=pd.getString("OFFICE_ACTIVE2");
		if(null!=OFFICE_ACTIVE||!("").equals(OFFICE_ACTIVE)){
			pd.put("OFFICE_ACTIVE", OFFICE_ACTIVE);
		}
		String WINDOWS_ACTIVE=pd.getString("WINDOWS_ACTIVE2");
		if(null!=WINDOWS_ACTIVE||!("").equals(WINDOWS_ACTIVE)){
			pd.put("WINDOWS_ACTIVE", WINDOWS_ACTIVE);
		}
		String VIRUS_ISOLATION=pd.getString("VIRUS_ISOLATION2");
		if(null!=VIRUS_ISOLATION||!("").equals(VIRUS_ISOLATION)){
			pd.put("VIRUS_ISOLATION", VIRUS_ISOLATION);
		}
		
		
		}
		checkService.edit(pd);
		FHLOG.save(Jurisdiction.getUsername(), "修改PC_CHECK","PC_CHECK","CHECK_ID",pd.getString("CHECK_ID"));
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
		
	}
	
	
	
	/**列表(检索条件中的部门，只列出此操作用户最高部门权限以下所有部门的员工)
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表check");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String sts = (String) pd.get("PC_STATE");
		String stn = (String) pd.get("PC_NO");
		if(sts != "" && sts != null){
		String PC_STATE = sts.replaceAll("/", "");
		pd.put("PC_STATE",PC_STATE);
		}
		if(stn !="" && sts != null){
			String PC_NO = stn.replaceAll("/", "");
			pd.put("PC_NO", PC_NO);
		}
		PageData PROGRAM=pcService.getPDByIds(pd);
		if(PROGRAM != null){
			pd.put("PROGRAM", PROGRAM.get("PROGRAM"));
			pd.put("PC_ID", PROGRAM.get("PC_ID"));
		}
		String keywords = pd.getString("keywords");					//检索条件
		if(null != keywords && !"".equals(keywords)){
			//pd.put("keywords", keywords.trim());
		}
		String CHECK_ID = null == pd.get("CHECK_ID")?"":pd.get("CHECK_ID").toString();
		if(null != pd.get("id") && !"".equals(pd.get("id").toString())){
			CHECK_ID = pd.get("id").toString();
		}
		page.setPd(pd);
		List<PageData> varList=checkService.list(page);//列出所有pc下的check				
		mv.addObject("pd", pd);		
		mv.addObject("CHECK_ID", CHECK_ID);			
		mv.setViewName("app/pc/check_list");
		mv.addObject("varList", varList);
		mv.addObject("QX",Jurisdiction.getHC());			
		return mv;
	}
		/**获取pc状态
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/getState")
		@ResponseBody
		public Object getState() throws Exception{
			    Map<String,Object> map = new HashMap<String,Object>();
				PageData pd = new PageData();
				pd = this.getPageData();		
				pd = prosecurityService.getPcState(pd);	
				map.put("pdData", pd);
				return AppUtil.returnObject(new PageData(), map);						
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
		PageData pc = prosecurityService.getPcState(pd);	
		String pc_state = pc.getString("PC_STATE");
		pd.put("PC_STATE", pc_state);
		if("afd972ec76334ba7949c8ed093449b29".equals(pc_state)){//入场中
			pd.put("CHECK_TYPE", "-1");
		}else if("8b2bb55faa4e4258870ebd1aaeedf489".equals(pc_state)){//已入場，月別
			pd.put("CHECK_TYPE", "0");
		}else if("141b48c7bc554d58bd298dc9acff3f46".equals(pc_state)){//退場中，退場檢查
			pd.put("CHECK_TYPE", "1");
		}
		mv.setViewName("app/pc/check_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	

	/**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String time=null;
		try {
			time= checkService.findTimetwo(pd).getString("EXIT_DATE");
		} catch (Exception e) {
			time=null;			
		}		
		pd= checkService.findById(pd);
		String extd=pd.getString("EXIT_DATE");
		String entd=pd.getString("ENTRY_DATE");
		if(extd==null){
			pd.put("CHECK_DATE", entd);
		}else{
			pd.put("CHECK_DATE", extd);
		}
		pd.put("EXIT_DATE", time);
		mv.setViewName("app/pc/check_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
			
		return mv;
	}	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
	
	
	
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除PcCHECK");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		String id=pd.getString("CHECK_ID");
		pd.put("CHECK_ID", id.split(",")[0]);
		pd.put("CHECK_TYPE", id.split(",")[1]);
		if(!pd.getString("CHECK_TYPE").equals("-1")){
		   checkService.delete(pd);
		   FHLOG.save(Jurisdiction.getUsername(), "删除PC_CHECK","PC_CHECK","CHECK_ID",pd.getString("CHECK_ID"));
		   out.write("success");	   
		}else{			
		  out.write("err");
		}
		out.close();
	}
	
	
	/**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除PCcheck");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			checkService.deleteAll(ArrayDATA_IDS);
			 FHLOG.save(Jurisdiction.getUsername(), "批量删除PC_CHECK","PC_CHECK","CHECK_ID",DATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	
	
	
	
	
	/**
	 * ajax判断
	 * @return
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value="/checkType")
	public Object checkType() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		pd = this.getPageData();
		String check_type=pd.getString("CHECK_TYPE");
		List<PageData> checkImfo = checkService.findPC(pd);
		if(check_type.equals("1") && checkImfo.size()==0){
			errInfo = "error3";
		}else if(check_type.equals("0") && checkImfo.size()==0){
			errInfo = "error3";
		}
		for (PageData pageData : checkImfo) {
		   if (check_type.equals("-1") && check_type.equals(pageData.getString("CHECK_TYPE"))) {
				errInfo = "error1";
			} else if (check_type.equals("1") && check_type.equals(pageData.getString("CHECK_TYPE"))) {
				errInfo = "error2";
			}
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
//**check时间*/
	@ResponseBody
	@RequestMapping(value="/checkTime")
	public Object checkTime() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "";
		PageData pd = new PageData();
		pd = this.getPageData();
		String check_type=pd.getString("CHECK_TYPE");
		String time=pd.getString("CHECK_DATE");	
		if(check_type.equals("-1")){
			errInfo = "result";	
		}else{
			PageData checkImfo = checkService.findTime(pd);	
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			String ENTRY_DATE=checkImfo.getString("ENTRY_DATE");
			Date entrytime =sdf.parse(ENTRY_DATE); //数据库入场时间
			Date datetime =sdf.parse(time); //页面传过来的时间
			if(check_type.equals("1") && datetime.compareTo(entrytime)<0){
				errInfo = "error1"; //退场时间在入场时间前
			}else if(check_type.equals("0") && datetime.compareTo(entrytime)<0){
				errInfo = "error2"; //月别时间在入场时间前
			}else{
				errInfo = "result";	
			}
		}		
		map.put("result", errInfo);		
		return AppUtil.returnObject(new PageData(), map);
	}
	 /**导出到excel
		 * @param
		 * @throws Exception
		 */
		/*@RequestMapping(value="/excel")
		public ModelAndView exportExcel() throws Exception{
			logBefore(logger, Jurisdiction.getUsername()+"导出check到excel");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
			ModelAndView mv = new ModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("姓名");	//1
			titles.add("英文");	//2
			titles.add("编码");	//3
			titles.add("部门");	//4
			titles.add("职责");	//5
			titles.add("电话");	//6
			titles.add("邮箱");	//7
			titles.add("性别");	//8
			titles.add("出生日期");	//9
			titles.add("民族");	//10
			titles.add("岗位类别");	//11
			titles.add("参加工作时间");	//12
			titles.add("籍贯");	//13
			titles.add("政治面貌");	//14
			titles.add("入团时间");	//15
			titles.add("身份证号");	//16
			titles.add("婚姻状况");	//17
			titles.add("进本单位时间");	//18
			titles.add("现岗位");	//19
			titles.add("上岗时间");	//20
			titles.add("学历");	//21
			titles.add("毕业学校");	//22
			titles.add("专业");	//23
			titles.add("职称");	//24
			titles.add("职业资格证");	//25
			titles.add("劳动合同时长");	//26
			titles.add("签订日期");	//27
			titles.add("终止日期");	//28
			titles.add("现住址");	//29
			titles.add("绑定账号ID");	//30
			titles.add("备注");	//31
			dataMap.put("titles", titles);
			List<PageData> varOList = checkService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("NAME"));	    //1
				vpd.put("var2", varOList.get(i).getString("NAME_EN"));	    //2
				vpd.put("var3", varOList.get(i).getString("BIANMA"));	    //3
				vpd.put("var4", varOList.get(i).getString("DEPARTMENT_ID"));	    //4
				vpd.put("var5", varOList.get(i).getString("FUNCTIONS"));	    //5
				vpd.put("var6", varOList.get(i).getString("TEL"));	    //6
				vpd.put("var7", varOList.get(i).getString("EMAIL"));	    //7
				vpd.put("var8", varOList.get(i).getString("SEX"));	    //8
				vpd.put("var9", varOList.get(i).getString("BIRTHDAY"));	    //9
				vpd.put("var10", varOList.get(i).getString("NATION"));	    //10
				vpd.put("var11", varOList.get(i).getString("JOBTYPE"));	    //11
				vpd.put("var12", varOList.get(i).getString("JOBJOINTIME"));	    //12
				vpd.put("var13", varOList.get(i).getString("FADDRESS"));	    //13
				vpd.put("var14", varOList.get(i).getString("POLITICAL"));	    //14
				vpd.put("var15", varOList.get(i).getString("PJOINTIME"));	    //15
				vpd.put("var16", varOList.get(i).getString("SFID"));	    //16
				vpd.put("var17", varOList.get(i).getString("MARITAL"));	    //17
				vpd.put("var18", varOList.get(i).getString("DJOINTIME"));	    //18
				vpd.put("var19", varOList.get(i).getString("POST"));	    //19
				vpd.put("var20", varOList.get(i).getString("POJOINTIME"));	    //20
				vpd.put("var21", varOList.get(i).getString("EDUCATION"));	    //21
				vpd.put("var22", varOList.get(i).getString("SCHOOL"));	    //22
				vpd.put("var23", varOList.get(i).getString("MAJOR"));	    //23
				vpd.put("var24", varOList.get(i).getString("FTITLE"));	    //24
				vpd.put("var25", varOList.get(i).getString("CERTIFICATE"));	    //25
				vpd.put("var26", varOList.get(i).get("CONTRACTLENGTH").toString());	//26
				vpd.put("var27", varOList.get(i).getString("CSTARTTIME"));	    //27
				vpd.put("var28", varOList.get(i).getString("CENDTIME"));	    //28
				vpd.put("var29", varOList.get(i).getString("ADDRESS"));	    //29
				vpd.put("var30", varOList.get(i).getString("USER_ID"));	    //30
				vpd.put("var31", varOList.get(i).getString("BZ"));	    //31
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
			return mv;
		}
	*/
}
