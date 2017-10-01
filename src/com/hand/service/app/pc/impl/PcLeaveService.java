package com.hand.service.app.pc.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.service.app.pc.PcLeaveManager;
import com.hand.util.PageData;

/** 
 * 说明： PC入场申请
 * 创建时间：2017年7月7日
 * @version
 */
/**
 * @author hand
 *
 */
@Service("PcLeaveService")
public class PcLeaveService implements PcLeaveManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pc_leave, List<PageData> items) throws Exception {
		dao.save("PcLeaveMapper.save", pc_leave);
		for (PageData item : items) {
			dao.save("PcLeaveItemMapper.save", item);
		}
	}

	/**
	 * 根据pc_leave id找pc_leaveItem子级信息
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> LeaveItemlist(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveMapper.leaveItemlist", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveMapper.datalistPage", page);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> itemlist(Page page) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveItemMapper.datalistPagetwo", page);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listtwo(Page page) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveItemMapper.datalistPage", page);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getnextpd(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveMapper.getnextpd", pd);
	}

	/**
	 * 列表（2）
	 * 
	 * @param page
	 * @throws Exception
	 */
	public PageData getLeaveByTaskId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.getLeaveByTaskId", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	public PageData getByTaskId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.getByTaskId", pd);
	}

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS) throws Exception {
		dao.delete("PcLeaveMapper.deleteAll", ArrayDATA_IDS);

	}

	/**
	 * @param pd
	 * @throws Exception
	 */
	public void updateState(PageData pd) throws Exception {
		dao.update("PcLeaveMapper.updateState", pd);
	}

	/**
	 * @param pd
	 * @throws Exception
	 */
	public void updateStateName(PageData pd) throws Exception {
		dao.update("PcLeaveMapper.updateStateName", pd);
	}

	/**
	 * 详细信息
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public PageData pca(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.pca", pd);
	}

	@SuppressWarnings("unchecked")
	public List<PageData> pca2(PageData pc) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveMapper.pca2", pc);
	}

	public PageData GetNextUser(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.getnextuser", pd);
	}

	public PageData getDEPARTMENT_ID(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.getDEPARTMENT_ID", pd);
	}

	public PageData getPARENT_ID(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.getPARENT_ID", pd);
	}

	@SuppressWarnings("unchecked")
	public PageData GetNextbz(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.getnextbz", pd);
	}

	@SuppressWarnings("unchecked")
	public List<PageData> GetNextbzById(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveMapper.getnextbzbyid", pd);
	}

	@SuppressWarnings("unchecked")
	public List<PageData> getPcLevelByStatusAndUser(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveMapper.getPcLevelByStatusAndUser", pd);
	}

	@Override
	public void updateStateOnly(PageData pd) throws Exception {
		dao.update("PcLeaveMapper.updateStateOnly", pd);
	}

	/**
	 * 根据ID查找（2）
	 */
	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.findById", pd);
	}

	@Override
	public PageData findByPS(String id) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.findByps", id);
	}

	@SuppressWarnings("unchecked")
	public PageData getUserPorject(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.getUserPorject", pd);
	}

	/***
	 * 按用户名查询
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getByname(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveMapper.getProjectByname", pd);
	}

	@Override
	public void update(PageData pd) throws Exception {
		dao.update("PcLeaveMapper.update", pd);
	}

	@Override
	public PageData getCountByStatusAndUser(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.getCountByStatusAndUser", pd);
	}

	@Override
	public PageData getUser(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.getUser", pd);
	}

	@Override
	public PageData getInfoSafes(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.getInfoSafes", pd);
	}

	@Override
	public PageData staname(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.staname", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> select_hi_NAME_(Page page) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveMapper.select_hi_NAME_", page);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> select_hi_MESSAGE_(Page page) throws Exception {
		return (List<PageData>) dao.findForList("PcLeaveMapper.select_hi_MESSAGE_", page);
	}

	@Override
	public PageData getPcstateIdByTaskId(PageData pd) throws Exception {

		return (PageData) dao.findForObject("PcLeaveMapper.getByProcessinstanceId", pd);
	}

	@Override
	public List<String> findAllProcessInstanceId() throws Exception {
		return (List<String>) dao.findForList("PcLeaveMapper.findAllProcessInstanceId", null);
	}

	@Override
	public PageData findByProjectIdAndRoleName(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PcLeaveMapper.findByProjectIdAndRoleName", pd);
	}

	@Override
	public void updateIsReapply(PageData pd) throws Exception {
		dao.update("PcLeaveMapper.updateIsReapply", pd);
	}
}
