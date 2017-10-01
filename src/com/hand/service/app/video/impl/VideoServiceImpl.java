package com.hand.service.app.video.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.entity.app.Video;
import com.hand.service.app.video.VideoService;
import com.hand.util.PageData;

@Service("videoService")
public class VideoServiceImpl implements VideoService{
	
	@Resource(name="daoSupport")
	private DaoSupport dao;

	/**
	 * 视频列表
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getAllVideo(Page param) throws Exception {
		return (List<PageData>)dao.findForList("VideoMapper.datalistPage", param);
	}

	/**
	 * 视频删除
	 * @throws Exception 
	 */
	@Override
	public void deleteV(PageData pd) throws Exception {
		dao.delete("VideoMapper.deleteV", pd);
		
	}
	
	/**
	 * 跳转至修改页面
	 * @throws Exception 
	 */
	@Override
	public PageData findByViId(String ID) throws Exception {
		return (PageData)dao.findForObject("VideoMapper.findById", ID);
	}

	/**
	 * 视频编辑
	 */
	@Override
	public void editV(PageData pd) throws Exception {
		dao.update("VideoMapper.editV", pd);
	}

	@Override
	public void deleteAllV(String[] ArrayVideo_IDS) throws Exception {
		dao.delete("VideoMapper.deleteAllV", ArrayVideo_IDS);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByVG(String VIDEOGROUP) throws Exception {
		return (List<PageData>)dao.findForObject("VideoMapper.findByVG", VIDEOGROUP);
	}

	
	/**
	 * 添加视频
	 */
	@SuppressWarnings("null")
	@Override
	public boolean videoSave(PageData pd) throws Exception {
		boolean flag=false;
		if(pd!=null||!pd.equals("")){
		dao.save("VideoMapper.save", pd);
		flag=true;
		}
		return flag;
	}

	
	
}
