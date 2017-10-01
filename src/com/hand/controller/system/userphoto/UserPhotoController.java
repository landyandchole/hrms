package com.hand.controller.system.userphoto;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.controller.base.BaseController;
import com.hand.service.system.userphoto.UserPhotoManager;
import com.hand.util.AppUtil;
import com.hand.util.DelAllFile;
import com.hand.util.Jurisdiction;
import com.hand.util.PageData;
import com.hand.util.PathUtil;
import com.hand.util.Tools;

/** 
 * 说明：用户头像
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 */
@Controller
@RequestMapping(value="/userphoto")
public class UserPhotoController extends BaseController {
	
	@Resource(name="userphotoService")
	private UserPhotoManager userphotoService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public Object save() throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERNAME", Jurisdiction.getUsername());	//用户名
		String type = pd.getString("type");				//类型，1：带原图的。2不带原图
		String strphotos = pd.getString("strphotos");	//图片路径拼接
		String[] arrayStr = strphotos.split(",fh,");
		if("1".equals(type)){
			String tu0 = arrayStr[0].split("angle=")[0];
			tu0 = tu0.substring(0, tu0.length()-1);
			pd.put("PHOTO0", tu0);			//原图
			pd.put("PHOTO1", arrayStr[1]);	//头像1
			pd.put("PHOTO2", arrayStr[2]);	//头像2
			pd.put("PHOTO3", arrayStr[3]);	//头像3
		}else{
			pd.put("PHOTO0", "");			//原图
			pd.put("PHOTO1", arrayStr[0]);	//头像1
			pd.put("PHOTO2", arrayStr[1]);	//头像2
			pd.put("PHOTO3", arrayStr[2]);	//头像3
		}
		map.put("userPhoto",pd.getString("PHOTO2"));
		PageData ypd = userphotoService.findById(pd);
		if(null == ypd){			//没有数据就新增，否则就修改
			pd.put("USERPHOTO_ID", this.get32UUID());		//主键
			userphotoService.save(pd);
		}else{
			userphotoService.edit(pd);
			String PHOTO0 = ypd.getString("PHOTO0");
			String PHOTO1 = ypd.getString("PHOTO1");
			String PHOTO2 = ypd.getString("PHOTO2");
			String PHOTO3 = ypd.getString("PHOTO3");
			if(Tools.notEmpty(PHOTO0)){
				DelAllFile.delFolder(PathUtil.getClasspath()+ PHOTO0); //删除原图
			}
			DelAllFile.delFolder(PathUtil.getClasspath()+ PHOTO1); //删除图1
			DelAllFile.delFolder(PathUtil.getClasspath()+ PHOTO2); //删除图2
			DelAllFile.delFolder(PathUtil.getClasspath()+ PHOTO3); //删除图3
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
}
