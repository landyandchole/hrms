package com.hand.service.fhoa.staff.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.service.fhoa.staff.SalaryManager;
import com.hand.util.PageData;
@Service("salaryService")
public class SalaryService implements SalaryManager {
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/**查询员工薪资
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> datalistPage(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SalaryMapper.datalistPage", page);
	}
	/**新增薪资
	 * @param pd
	 * @throws Exception
	 */
	public void saveSalary(PageData pd)throws Exception{
		dao.save("SalaryMapper.insertSalary", pd);
	}
	/**修改薪资
	 * @param pd
	 * @throws Exception
	 */
	public void editSalary(PageData pd)throws Exception{
		dao.update("SalaryMapper.editSalary", pd);
	}

	@Override
	public PageData querySalary(PageData pd) throws Exception {
		
		return (PageData)dao.findForObject("SalaryMapper.querySalary", pd);		
	}
			
	/**批量修改
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void editAll(PageData pd)throws Exception{
		dao.update("SalaryMapper.editAll", pd);
	}


}
