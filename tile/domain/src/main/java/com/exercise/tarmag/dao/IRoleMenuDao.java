package com.dt.tarmag.dao;


import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.RoleMenu;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:43:57
 */
public interface IRoleMenuDao extends Dao<RoleMenu, Long> {

	/**
	 * 根据角色id删除关系表
	 * @param roleId
	 */
	public void deleteByRoleId(Long roleId);
	
	/**
	 * @param roleId
	 * @return
	 */
	List<Long> getMenuIdListByRoleId(long roleId);
	RoleMenu getRoleMenu(long roleId, long menuId);
}
