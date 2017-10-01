package com.hand.service.app.video;


import java.util.List;

import com.hand.entity.Page;
import com.hand.entity.app.VideoGroup;
import com.hand.util.PageData;

/** 
 * 说明： 组织机构接口类
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 * @version
 */
public interface VideoGroupService{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;

	/**通过编码获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByBianma(PageData pd)throws Exception;
	
	/**
	 * 通过ID获取其子级列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<VideoGroup> listSubVideoByParentId(String parentId) throws Exception;
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<VideoGroup> listAllVideo(String parentId) throws Exception;
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)下拉ztree用
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllVideoToSelect(String parentId, List<PageData> zvideoPdList) throws Exception;
	
	/**获取某个部门所有下级部门ID(返回拼接字符串 in的形式)
	 * @param DEPARTMENT_ID
	 * @return
	 * @throws Exception
	 */
	public String getVIDEO_IDS(String VIDEO_ID) throws Exception;
	
	/**
	 * 
	 */
	public VideoGroup findForName(String VIDEO_ID) throws Exception;
	
}


