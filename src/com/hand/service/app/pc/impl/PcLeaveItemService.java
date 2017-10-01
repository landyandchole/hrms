package com.hand.service.app.pc.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.service.app.pc.PcLeaveItemManager;
import com.hand.util.PageData;

@Service("pcLeaveItemService")
public class PcLeaveItemService implements PcLeaveItemManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@Override
	public List<String> findAllProcessInstanceId() throws Exception {
		return (List<String>) dao.findForList("PcLeaveItemMapper.findAllProcessInstanceId", null);
	}

	@Override
	public PageData findStaffProByProInstId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveItemMapper.findStaffProByProInstId", pd);
	}

	@Override
	public PageData getCountByStatusAndUser(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveItemMapper.getCountByStatusAndUser", pd);
	}

	/**
	 * 改变退场工作流状态以及申请人
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void updateStateName(PageData pd) throws Exception {
		dao.update("PcLeaveItemMapper.updateStateName", pd);
	}

	/**
	 * 改变退场工作流状态
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void updateState(PageData pd) throws Exception {
		dao.update("PcLeaveItemMapper.updateState", pd);
	}

	@Override
	public List<PageData> getPcLevelByStatusAndUser(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveItemMapper.getPcLevelByStatusAndUser", pd);
	}

	@Override
	public void save(PageData pd) throws Exception {
		dao.save("PcLeaveItemMapper.save", pd);
	}

	@Override
	public PageData getItemByProInstId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveItemMapper.getItemByProInstId", pd);
	}

	@Override
	public PageData getItemById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveItemMapper.getItemById", pd);
	}
	@Override
	public PageData getItemByIds(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveItemMapper.getItemByIds", pd);
	}

	/**
	 * 根据ID查找（2）
	 */
	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveItemMapper.findById", pd);
	}

	@Override
	public void updateIsReapply(PageData pd) throws Exception {
		dao.update("PcLeaveItemMapper.updateIsReapply", pd);
	}

}
