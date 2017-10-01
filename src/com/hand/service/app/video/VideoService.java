package com.hand.service.app.video;

import java.util.List;

import com.hand.entity.Page;
import com.hand.util.PageData;

public interface VideoService {

	List<PageData> getAllVideo(Page param)throws Exception;
	
	void deleteV(PageData pd)throws Exception;
	
	PageData findByViId(String ID)throws Exception;
	
	void editV(PageData pd)throws Exception;
	
	void deleteAllV(String ArrayVideo_IDS[])throws Exception;
	
	
	/**
	 * 视频新增
	 * @param pd
	 */
	public boolean videoSave(PageData pd) throws Exception;
	
	
	List<PageData> findByVG(String VIDEOGROUP)throws Exception;
	
	
	
}
