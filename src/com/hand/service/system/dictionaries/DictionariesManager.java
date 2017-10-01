package com.hand.service.system.dictionaries;

import java.util.List;

import com.hand.entity.Page;
import com.hand.entity.system.Dictionaries;
import com.hand.util.PageData;

/**
 * 说明： 数据字典接口类 创建人：HAND 赵帮恩 创建时间：2017年6月15日
 * 
 * @version
 */
public interface DictionariesManager {

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception;

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception;

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page) throws Exception;

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception;

	/**
	 * 通过编码获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByBianma(PageData pd) throws Exception;

	/**
	 * 通过ID获取其子级列表
	 * 
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<Dictionaries> listSubDictByParentId(String parentId) throws Exception;

	/**
	 * 通过Name获取其子级列表
	 * 
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<Dictionaries> listSubDictByName(String name) throws Exception;

	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * 
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Dictionaries> listAllDict(String parentId) throws Exception;

	/**
	 * 排查表检查是否被占用
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findFromTbs(PageData pd) throws Exception;

	/**
	 * 获取职称
	 * 
	 * @param value
	 * @return
	 * @throws Exception
	 */
	List<PageData> getTitle(String value) throws Exception;

	/**
	 * 获取性别
	 * 
	 * @param value
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getSex(String value) throws Exception;

	/**
	 * 获取英语等级
	 * 
	 * @param value
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getEnglish(String value) throws Exception;

	/**
	 * 获取日语等级
	 * 
	 * @param value
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getJapanese(String value) throws Exception;

	/**
	 * 获取状态
	 * 
	 * @param value
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getStatus(String value) throws Exception;

	/**
	 * 根据父NAME和Name获取数据字典
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByParentNameAndName(PageData pd) throws Exception;

}
