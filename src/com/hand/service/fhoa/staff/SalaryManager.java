package com.hand.service.fhoa.staff;

import java.util.List;

import com.hand.entity.Page;
import com.hand.util.PageData;

public interface SalaryManager {
	 /**查询员工薪资列表
  	 * @param pd
  	 * @throws Exception
  	 */

 public List<PageData> datalistPage(Page page)throws Exception;
 /**查询员工薪资
  	 * @param pd
  	 * @throws Exception
  	 */

 public PageData  querySalary(PageData pd)throws Exception;  
 /**新增薪资
	 * @param pd
	 * @throws Exception
	 */
	public void saveSalary(PageData pd)throws Exception; 
	/**更新薪资
	 * @param pd
	 * @throws Exception
	 */
	public void editSalary(PageData pd)throws Exception;					
	/**批量修改
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void editAll(PageData pd)throws Exception;
	
	
}
