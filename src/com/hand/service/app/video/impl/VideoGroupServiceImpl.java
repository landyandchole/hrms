package com.hand.service.app.video.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.entity.app.VideoGroup;
import com.hand.service.app.video.VideoGroupService;
import com.hand.util.PageData;
import com.hand.util.Tools;

/** 
 * 说明： 组织机构
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 * @version
 */
@Service("videoGroupService")
public class VideoGroupServiceImpl implements VideoGroupService{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("VideoGroupMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("VideoGroupMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("VideoGroupMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("VideoGroupMapper.datalistPage", page);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("VideoGroupMapper.findById", pd);
	}
	
	/**通过编码获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByBianma(PageData pd)throws Exception{
		return (PageData)dao.findForObject("VideoGroupMapper.findByBianma", pd);
	}
	
	/**
	 * 通过ID获取其子级列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<VideoGroup> listSubVideoByParentId(String parentId) throws Exception {
		return (List<VideoGroup>) dao.findForList("VideoGroupMapper.listSubVideoByParentId", parentId);
	}
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<VideoGroup> listAllVideo(String parentId) throws Exception {
		List<VideoGroup> videoList = this.listSubVideoByParentId(parentId);
		for(VideoGroup vid : videoList){
			vid.setTreeurl("video/list.do?VIDEO_ID="+vid.getVIDEO_ID());
			vid.setSubVideo(this.listAllVideo(vid.getVIDEO_ID()));
			vid.setTarget("treeFrame");
			vid.setIcon("static/images/video.jpg");
		}
		return videoList;
	}
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)下拉ztree用
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllVideoToSelect(String parentId,List<PageData> zvideoPdList) throws Exception {
		List<PageData>[] arrayVid = this.listAllbyPd(parentId,zvideoPdList);
		List<PageData> videoPdList = arrayVid[1];
		for(PageData pd : videoPdList){
			this.listAllVideoToSelect(pd.getString("id"),arrayVid[0]);
		}
		return arrayVid[0];
	}
	
	
	/**下拉ztree用
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData>[] listAllbyPd(String parentId,List<PageData> zvideoPdList) throws Exception {
		List<VideoGroup> videoList = this.listSubVideoByParentId(parentId);
		List<PageData> videoPdList = new ArrayList<PageData>();
		for(VideoGroup vid : videoList){
			PageData pd = new PageData();
			pd.put("id", vid.getVIDEO_ID());
			pd.put("parentId", vid.getPARENT_ID());
			pd.put("name", vid.getNAME());
			pd.put("icon", "static/images/video.jpg");
			videoPdList.add(pd);
			zvideoPdList.add(pd);
		}
		List<PageData>[] arrayVid = new List[2];
		arrayVid[0] = zvideoPdList;
		arrayVid[1] = videoPdList;
		return arrayVid;
	}
	
	/**获取某个部门所有下级部门ID(返回拼接字符串 in的形式， ('a','b','c'))
	 * @param DEPARTMENT_ID
	 * @return
	 * @throws Exception
	 */
	public String getVIDEO_IDS(String VIDEO_ID) throws Exception {
		VIDEO_ID = Tools.notEmpty(VIDEO_ID)?VIDEO_ID:"0";
		List<PageData> zvideoPdList = new ArrayList<PageData>();
		zvideoPdList = this.listAllVideoToSelect(VIDEO_ID,zvideoPdList);
		StringBuffer sb = new StringBuffer();
		sb.append("(");
		for(PageData dpd : zvideoPdList){
			sb.append("'");
			sb.append(dpd.getString("id"));
			sb.append("'");
			sb.append(",");
		}
		sb.append("'fh')");
		return sb.toString();
	}

	@Override
	public VideoGroup findForName(String VIDEO_ID) throws Exception {
		return (VideoGroup)dao.findForObject("VideoGroupMapper.findForName", VIDEO_ID);
	}

	

	
	
}




