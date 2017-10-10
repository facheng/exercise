/**
 * 
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.model.CustomerRoleUnit;
import com.dt.tarmag.model.Menu;
import com.dt.tarmag.vo.RoleVo;
import com.dt.tarmag.vo.Tree;


/**
 * @author yuwei
 * @Time 2015-6-29下午04:03:00
 */
public interface IRoleService {
	List<Menu> getFirstLevelMenus(long roleId);
	List<Menu> getSecondeLevelMenus(long roleId, long parentId);
	
	/**
	 * 根据客户和小区查找角色集合
	 * @param customerId
	 * @param unitId
	 * @return
	 */
	List<Map<String, Object>> getRoleListByCustomerAndUnit(long customerId, long unitId);
	
	/**
	 * 根据公司ID查非管理员角色集合
	 * @return
	 */
	List<Map<String, Object>> getRoleListByCompanyId(long companyId, boolean isAdmin);
	
	/**
	 * @param customerId
	 * @param roleId
	 * @param unitId
	 * @return
	 */
	CustomerRoleUnit getCustomerRoleUnit(long customerId, long roleId, long unitId);
	/**
	 * 保存客户+角色+小区关系
	 * @param customerId
	 * @param roleId
	 * @param unitId
	 */
	void saveCustomerRoleUnit_tx(long customerId, long roleId, long unitId);
	
	/**
	 * 删除用户+角色+小区关系
	 * @param cruId
	 */
	void deleteCustomerRoleUnit_tx(long cruId);
	
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
	List<Map<String ,Object>> getRoleList(long companyId, String roleName, int pageNo, int pageSize);
	
	/**
	 * 查询角色供编辑
	 * @param roleId
	 * @return
	 */
	Map<String, Object> getRoleToEdit(long roleId);
	
	void createRole_tx(RoleVo vo);
	void updateRole_tx(long roleId, RoleVo vo);
	/**
	 * 删除角色。
	 * 如果该角色已分配人，则不许删除
	 * @param roleId
	 * @return
	 */
	boolean deleteRole_tx(long roleId);
	
	/**
	 * 查询指定公司的所有授权功能(菜单)。
	 * @param companyId
	 * @return
	 */
	List<Tree> getAuthedMenuTreeByCompanyId(long companyId);
	
	/**
	 * 查询指定角色对应的公司下所有的授权菜单，并将该角色对应的菜单做标记
	 * @param companyId
	 * @return
	 */
	List<Tree> getAuthedMenuTreeByRoleId(long roleId);
	
	/**
	 * 给指定的角色设置权限菜单
	 * @param roleId
	 * @param menuIdList
	 */
	void updateRoleMenus_tx(long roleId, List<Long> menuIdList);
}
