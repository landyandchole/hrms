package com.hand.service.system.dictionaries.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.entity.system.Dictionaries;
import com.hand.service.system.dictionaries.DictionariesManager;
import com.hand.util.PageData;

/**
 * 说明： 数据字典 创建人：HAND 赵帮恩 创建时间：2017年6月15日
 * 
 * @version
 */
@Service("dictionariesService")
public class DictionariesService implements DictionariesManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception {
		dao.save("DictionariesMapper.save", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception {
		dao.delete("DictionariesMapper.delete", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {
		dao.update("DictionariesMapper.edit", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("DictionariesMapper.datalistPage", page);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("DictionariesMapper.findById", pd);
	}

	/**
	 * 通过编码获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByBianma(PageData pd) throws Exception {
		return (PageData) dao.findForObject("DictionariesMapper.findByBianma", pd);
	}

	/**
	 * 通过ID获取其子级列表
	 * 
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Dictionaries> listSubDictByParentId(String parentId) throws Exception {
		return (List<Dictionaries>) dao.findForList("DictionariesMapper.listSubDictByParentId", parentId);
	}

	/**
	 * 通过Name获取其子级列表
	 * 
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Dictionaries> listSubDictByName(String name) throws Exception {
		return (List<Dictionaries>) dao.findForList("DictionariesMapper.listSubDictByName", name);
	}

	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * 
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Dictionaries> listAllDict(String parentId) throws Exception {
		List<Dictionaries> dictList = this.listSubDictByParentId(parentId);
		for (Dictionaries dict : dictList) {
			dict.setTreeurl("dictionaries/list.do?DICTIONARIES_ID=" + dict.getDICTIONARIES_ID());
			dict.setSubDict(this.listAllDict(dict.getDICTIONARIES_ID()));
			dict.setTarget("treeFrame");
		}
		return dictList;
	}

	/**
	 * 排查表检查是否被占用
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findFromTbs(PageData pd) throws Exception {
		return (PageData) dao.findForObject("DictionariesMapper.findFromTbs", pd);
	}

	/**
	 * 获取职称
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getTitle(String value) throws Exception {
		return (List<PageData>) dao.findForList("DictionariesMapper.getTitle", value);
	}

	/**
	 * 获取性别
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getSex(String value) throws Exception {
		return (List<PageData>) dao.findForList("DictionariesMapper.getSex", value);
	}

	/**
	 * 获取英语水平
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getEnglish(String value) throws Exception {
		return (List<PageData>) dao.findForList("DictionariesMapper.getEnglish", value);
	}

	/**
	 * 获取日语水平
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getJapanese(String value) throws Exception {
		return (List<PageData>) dao.findForList("DictionariesMapper.getJapanese", value);
	}

	/**
	 * 获取状态
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getStatus(String value) throws Exception {
		return (List<PageData>) dao.findForList("DictionariesMapper.getStatus", value);
	}

	/**
	 * 根据父NAME和Name获取数据字典
	 */
	@Override
	public PageData findByParentNameAndName(PageData pd) throws Exception {
		return (PageData) dao.findForObject("DictionariesMapper.findByParentNameAndName", pd);
	}

}
