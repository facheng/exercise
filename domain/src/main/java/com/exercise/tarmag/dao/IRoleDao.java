package com.dt.tarmag.dao;


import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Role;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:43:26
 */
public interface IRoleDao extends Dao<Role, Long> {

	/**
	 * 获取公司的管理员角色
	 * @param companyId
	 * @return
	 */
	public Role findAdminRole(Long companyId);
	
	/**
	 * 查询指定公司的角色个数(不包括管理员)
	 * @param companyId
	 * @param roleName
	 * @return
	 */
	int getRoleCount(long companyId, String roleName);
	
	/**
	 * 查询指定公司的角色列表(不包括管理员)
	 * @param companyId
	 * @param roleName
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Role> getRoleList(long companyId, String roleName, int pageNo, int pageSize);
	
	/**
	 * 根据公司ID查非管理员角色集合
	 * @return
	 */
	List<Role> getRoleListByCompanyId(long companyId, boolean isAdmin);
}
