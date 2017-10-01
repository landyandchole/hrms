package com.hand.service.system.appuser;

import java.util.List;

import com.hand.entity.Page;
import com.hand.entity.system.User;
import com.hand.util.PageData;

/**
 * 会员接口类 创建人：HAND 赵帮恩 创建时间：2017年6月15日
 */
public interface AppuserManager {

	/**
	 * 列出某角色下的所有会员
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllAppuserByRorlid(PageData pd) throws Exception;

	/**
	 * 会员列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPdPageUser(Page page) throws Exception;

	/**
	 * 通过用户名获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUsername(PageData pd) throws Exception;

	/**
	 * 通过邮箱获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByEmail(PageData pd) throws Exception;

	/**
	 * 通过编号获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByNumber(PageData pd) throws Exception;

	/**
	 * 保存用户
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd) throws Exception;

	/**
	 * 删除用户
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd) throws Exception;

	/**
	 * 修改用户
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void updateU(PageData pd) throws Exception;
	/**
	 * 修改用户
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void updateM(PageData pd) throws Exception;
	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUiId(PageData pd) throws Exception;

	/**
	 * 全部会员
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllUser(PageData pd) throws Exception;

	/**
	 * 批量删除用户
	 * 
	 * @param USER_IDS
	 * @throws Exception
	 */
	public void deleteAllU(String[] USER_IDS) throws Exception;

	/**
	 * 获取总数
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData getAppUserCount(String value) throws Exception;

	public PageData getUserByNameAndPwd(PageData pd1) throws Exception;

	public User getUserAndRoleById(String user_ID) throws Exception;

}
