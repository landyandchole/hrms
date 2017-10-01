package com.hand.controller.information.linkage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hand.controller.base.BaseController;
import com.hand.entity.Page;
import com.hand.entity.system.Dictionaries;
import com.hand.service.app.fittings.FittingsManager;
import com.hand.service.app.pc.PcManager;
import com.hand.service.app.project.ProjectManager;
import com.hand.service.system.dictionaries.DictionariesManager;
import com.hand.util.AppUtil;
import com.hand.util.PageData;
import com.hand.util.Tools;

/** 
 * 说明：明细表
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 */
@Controller
@RequestMapping(value="/linkage")
public class Linkage extends BaseController{
	
	String menuUrl = "linkage/view.do"; //菜单地址(权限用)
	
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	@Resource(name="projectService")
	private ProjectManager projectService;
	@Resource(name="pcService")
	private PcManager pcService;
	@Resource(name="fittingsService")
	private FittingsManager fittingsService;
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/view")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("information/linkage/view");
		return mv;
	}
	
	/**获取连级数据
	 * @return
	 */
	@RequestMapping(value="/getLevels")
	@ResponseBody
	public Object getLevels(){
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String DICTIONARIES_ID = pd.getString("DICTIONARIES_ID");
			DICTIONARIES_ID = Tools.isEmpty(DICTIONARIES_ID)?"2":DICTIONARIES_ID;
			List<Dictionaries>	varList = dictionariesService.listSubDictByParentId(DICTIONARIES_ID); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdList = new ArrayList<PageData>();
			for(Dictionaries d :varList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdList.add(pdf);
			}
			map.put("list", pdList);	
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**获取连级数据
	 * @return
	 */
	@RequestMapping(value="/getLevelsByName")
	@ResponseBody
	
	public Object getLevelsByName(Page page){
		
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		try{
			String name = "日语水平";
			List<Dictionaries>	varList = dictionariesService.listSubDictByName(name); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdList = new ArrayList<PageData>();
			for(Dictionaries d :varList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdList.add(pdf);
			}
			map.put("list", pdList);	
			
			String english = "英语水平";
			List<Dictionaries>	varEnglishList = dictionariesService.listSubDictByName(english); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdEnglishList = new ArrayList<PageData>();
			for(Dictionaries d :varEnglishList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdEnglishList.add(pdf);
			}
			map.put("englishlist", pdEnglishList);
			
			
			String projectState = "项目状态";
			List<Dictionaries>	varprojectStateList = dictionariesService.listSubDictByName(projectState); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdprojectStateList = new ArrayList<PageData>();
			for(Dictionaries d :varprojectStateList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdprojectStateList.add(pdf);
			}
			map.put("projectStatelist", pdprojectStateList);
			
			String projectManager = "项目经理";
			List<Dictionaries>	varprojectManagerList = dictionariesService.listSubDictByName(projectManager); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdprojectManagerList = new ArrayList<PageData>();
			for(Dictionaries d :varprojectManagerList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdprojectManagerList.add(pdf);
			}
			map.put("projectManagerlist", pdprojectManagerList);
			String title = "职称";
			List<Dictionaries>	vartitleList = dictionariesService.listSubDictByName(title); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdtitleList = new ArrayList<PageData>();
			for(Dictionaries d :vartitleList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdtitleList.add(pdf);
			}
			map.put("titlelist", pdtitleList);
			
			String travelType = "出差类型";
			List<Dictionaries>	vartravelTypeList = dictionariesService.listSubDictByName(travelType); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdtravelTypeList = new ArrayList<PageData>();
			for(Dictionaries d :vartravelTypeList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdtravelTypeList.add(pdf);
			}
			map.put("travelTypelist", pdtravelTypeList);
			
			
			String visaType = "签证类型";
			List<Dictionaries>	varvisaTypeList = dictionariesService.listSubDictByName(visaType); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdvisaTypeList = new ArrayList<PageData>();
			for(Dictionaries d :varvisaTypeList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdvisaTypeList.add(pdf);
			}
			map.put("visaTypelist", pdvisaTypeList);
			
			String status = "状态";
			List<Dictionaries>	varstatusList = dictionariesService.listSubDictByName(status); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdstatusList = new ArrayList<PageData>();
			for(Dictionaries d :varstatusList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdstatusList.add(pdf);
			}
			map.put("statuslist", pdstatusList);

			String role = "项目角色";
			List<Dictionaries>	varroleList = dictionariesService.listSubDictByName(role); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdroleList = new ArrayList<PageData>();
			for(Dictionaries d :varroleList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdroleList.add(pdf);
			}
			map.put("rolelist", pdroleList);

			
			String brand = "品牌";
			List<Dictionaries>	varbrandList = dictionariesService.listSubDictByName(brand); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdbrandList = new ArrayList<PageData>();
			for(Dictionaries d :varbrandList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdbrandList.add(pdf);
			}
			map.put("brandList", pdbrandList);
			
			String ram = "内存";
			List<Dictionaries>	varramList = dictionariesService.listSubDictByName(ram); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdramList = new ArrayList<PageData>();
			for(Dictionaries d :varramList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdramList.add(pdf);
			}
			map.put("ramList", pdramList);
			
			String hdisk = "硬盘";
			List<Dictionaries>	varhdiskList = dictionariesService.listSubDictByName(hdisk); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdhdiskList = new ArrayList<PageData>();
			for(Dictionaries d :varhdiskList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdhdiskList.add(pdf);
			}
			map.put("hdiskList", pdhdiskList);
			
			String type = "类型";
			List<Dictionaries>	vartypeList = dictionariesService.listSubDictByName(type); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdtypeList = new ArrayList<PageData>();
			for(Dictionaries d :vartypeList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdtypeList.add(pdf);
			}
			map.put("typeList", pdtypeList);
			
			String chip = "芯片";
			List<Dictionaries>	varchipList = dictionariesService.listSubDictByName(chip); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdchipList = new ArrayList<PageData>();
			for(Dictionaries d :varchipList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdchipList.add(pdf);
			}
			map.put("chipList", pdchipList);
			
			/*String accessories = "配件";
			List<Dictionaries>	accessoriesList = dictionariesService.listSubDictByName(accessories); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdaccessoriesList= new ArrayList<PageData>();
			for(Dictionaries d :accessoriesList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdaccessoriesList.add(pdf);
			}
			map.put("pdaccessoriesList", pdaccessoriesList);*/
			Page p=new Page(); 
			PageData pda = new PageData();
			pda = this.getPageData();
			List<PageData> pdaccessoriesListd=fittingsService.listAll(pda);
			pda.put("PARENT", "PARENT");
			p.setPd(pda);
			p.setShowCount(pdaccessoriesListd.size());
			List<PageData> pdaccessoriesList= fittingsService.list(p);
			map.put("pdaccessoriesList", pdaccessoriesList);
			
			String expenseName = "费用类目";
			List<Dictionaries>	varexpenseNameList = dictionariesService.listSubDictByName(expenseName); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdexpenseNameList = new ArrayList<PageData>();
			for(Dictionaries d :varexpenseNameList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdexpenseNameList.add(pdf);
			}
			map.put("expenseNameList", pdexpenseNameList);
			String room = "房间";
			
			List<Dictionaries>	varroomList = dictionariesService.listSubDictByName(room); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdroomList = new ArrayList<PageData>();
			for(Dictionaries d :varroomList){
				
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdroomList.add(pdf);
			}
			map.put("roomList", pdroomList);
			
			
			String os = "操作系统";
			List<Dictionaries>	varosList = dictionariesService.listSubDictByName(os); //用传过来的ID获取此ID下的子列表数据
			List<PageData> osNameList = new ArrayList<PageData>();
			for(Dictionaries d :varosList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				osNameList.add(pdf);
			}
			map.put("osNameList", osNameList);
			
			String depot = "在库情况";
			List<Dictionaries>	vardepotList = dictionariesService.listSubDictByName(depot); //用传过来的ID获取此ID下的子列表数据
			List<PageData> depotNameList = new ArrayList<PageData>();
			for(Dictionaries d :vardepotList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				depotNameList.add(pdf);
			}
			map.put("depotNameList", depotNameList);
			
			String liability = "质保期";
			List<Dictionaries>	varliabilityList = dictionariesService.listSubDictByName(liability); //用传过来的ID获取此ID下的子列表数据
			List<PageData> liabilityNameList = new ArrayList<PageData>();
			for(Dictionaries d :varliabilityList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				liabilityNameList.add(pdf);
			}
			map.put("liabilityNameList", liabilityNameList);
			
			String building = "楼栋";
			String X = "X-青浦外";
			List<Dictionaries>	varbuildingList = dictionariesService.listSubDictByName(building); //用传过来的ID获取此ID下的子列表数据
			List<PageData> buildingNameList = new ArrayList<PageData>();
			for(Dictionaries d :varbuildingList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				if(d.getNAME().equals(X)){
					pdf.put("NAME", "X-青浦外");
					pdf.put("NAMEUse", "不在园区内");
				}else{
					pdf.put("NAME", d.getNAME());
					pdf.put("NAMEUse", d.getNAME().substring(0, 1));
				}

				buildingNameList.add(pdf);
			}
			map.put("buildingList", buildingNameList);
			
			
			String  purpose="PC用途";
			List<Dictionaries>	varpurposeList = dictionariesService.listSubDictByName(purpose); //用传过来的ID获取此ID下的子列表数据
			List<PageData> purposeNameList = new ArrayList<PageData>();
			for(Dictionaries d :varpurposeList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				purposeNameList.add(pdf);
			}
			map.put("purposeList", purposeNameList);
			
			String  pcstate="PC状态";
			List<Dictionaries>	varpcstateList = dictionariesService.listSubDictByName(pcstate); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pcstateNameList = new ArrayList<PageData>();
			for(Dictionaries d :varpcstateList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pcstateNameList.add(pdf);
			}
			map.put("pcsstateList", pcstateNameList);
			
			
			PageData pd = new PageData();
			pd = this.getPageData();
			try {
				List<PageData> varOList = pcService.listpro(pd);
				page.setShowCount(varOList.size());
				List<PageData> pdprogramList = pcService.Alist(page);
				map.put("programList", pdprogramList);	
			} catch (Exception e) {
				errInfo = "error";
				logger.error(e.toString(), e);
			}
			
			try {
				List<PageData> varOList2 = pcService.listAllpc(pd);
				page.setShowCount(varOList2.size());
				List<PageData> pcstateList = pcService.PCstate(page);
				map.put("pcstateList", pcstateList);	
			} catch (Exception e) {
				errInfo = "error";
				logger.error(e.toString(), e);
			}
			
			
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		
		
		return AppUtil.returnObject(new PageData(), map);
	}


}
