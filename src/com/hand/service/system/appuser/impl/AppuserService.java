package com.hand.service.system.appuser.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.dao.DaoSupport;
import com.hand.entity.Page;
import com.hand.entity.system.User;
import com.hand.service.system.appuser.AppuserManager;
import com.hand.util.PageData;

/**
 * 类名称：AppuserService 创建人：HAND 赵帮恩 创建时间：2017年6月15日
 */
@Service("appuserService")
public class AppuserService implements AppuserManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 列出某角色下的所有会员
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAllAppuserByRorlid(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("AppuserMapper.listAllAppuserByRorlid", pd);
	}

	/**
	 * 会员列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listPdPageUser(Page page) throws Exception {
		return (List<PageData>) dao.findForList("AppuserMapper.userlistPage", page);
	}

	/**
	 * 通过用户名获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUsername(PageData pd) throws Exception {
		return (PageData) dao.findForObject("AppuserMapper.findByUsername", pd);
	}

	/**
	 * 通过邮箱获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByEmail(PageData pd) throws Exception {
		return (PageData) dao.findForObject("AppuserMapper.findByEmail", pd);
	}

	/**
	 * 通过编号获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByNumber(PageData pd) throws Exception {
		return (PageData) dao.findForObject("AppuserMapper.findByNumber", pd);
	}

	/**
	 * 保存用户
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd) throws Exception {
		dao.save("AppuserMapper.saveU", pd);
		dao.save("ActuserMapper.saveU", pd);
		dao.save("ActMembershipMapper.save", pd);
	}
	
	/**
	 * 删除用户
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd) throws Exception {
		dao.delete("AppuserMapper.deleteU", pd);
		dao.delete("ActMembershipMapper.delete", pd);
		dao.delete("ActuserMapper.deleteU", pd);
	}

	/**
	 * 修改用户
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void updateU(PageData pd) throws Exception {
		dao.update("AppuserMapper.editU", pd);
		if ("true".equals(pd.getString("nameIsChange"))) {
			dao.update("ActuserMapper.edit", pd);
		}
		if ("true".equals(pd.getString("roleIsChange"))) {
			dao.update("ActMembershipMapper.edit", pd);
		}
	}
	/**
	 * 修改用户
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void updateM(PageData pd) throws Exception {
		dao.update("AppuserMapper.editM", pd);
		if ("true".equals(pd.getString("nameIsChange"))) {
			dao.update("ActuserMapper.edit", pd);
		}
		if ("true".equals(pd.getString("roleIsChange"))) {
			dao.update("ActMembershipMapper.edit", pd);
		}
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUiId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("AppuserMapper.findByUiId", pd);
	}

	/**
	 * 全部会员
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAllUser(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("AppuserMapper.listAllUser", pd);
	}

	/**
	 * 批量删除用户
	 * 
	 * @param USER_IDS
	 * @throws Exception
	 */
	public void deleteAllU(String[] USER_IDS) throws Exception {
		dao.delete("AppuserMapper.deleteAllU", USER_IDS);
	}

	/**
	 * 获取总数
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData getAppUserCount(String value) throws Exception {
		return (PageData) dao.findForObject("AppuserMapper.getAppUserCount", value);
	}

	@Override
	public PageData getUserByNameAndPwd(PageData pd) throws Exception {
		return (PageData)dao.findForObject("AppuserMapper.getUserInfo", pd);
	}

	@Override
	public User getUserAndRoleById(String user_ID) throws Exception {
		return (User) dao.findForObject("AppuserMapper.getUserAndRoleById", user_ID);
	}

}
