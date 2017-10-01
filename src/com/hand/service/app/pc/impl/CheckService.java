package com.hand.service.app.pc.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.service.app.pc.CheckManager;
import com.hand.util.PageData;

/** 
 * 说明： 员工管理
 * 创建人：HAND 赵帮恩
 * 创建时间：2017年6月15日
 * @version
 */
@Service("checkService")
public class CheckService implements CheckManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("CheckMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.update("CheckMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("CheckMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("CheckMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CheckMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CheckMapper.findById", pd);
	}
	
	
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("CheckMapper.deleteAll", ArrayDATA_IDS);
	}

	
	
	/**
	 * 通过PC-ID查找检查记录
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findPC(PageData pd) throws Exception {
		
		return (List<PageData>)dao.findForList("CheckMapper.find_PC", pd);
	}
	
	@Override
	public PageData findTime(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CheckMapper.findTime", pd);
	}
	
	@Override
	public PageData findTimetwo(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CheckMapper.findTimetwo", pd);
	}

}

