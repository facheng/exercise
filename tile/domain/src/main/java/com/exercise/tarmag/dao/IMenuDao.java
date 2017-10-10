package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.Menu;
import com.dt.tarmag.util.PageResult;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:42:38
 */
public interface IMenuDao extends Dao<Menu, Long> {
	List<Menu> getFirstLevelMenus(long roleId);
	List<Menu> getSecondeLevelMenus(long roleId, long parentId);
	
	/**
	 * 通过条件查询菜单
	 * @param params
	 * @return
	 */
	public PageResult<Map<String, Object>> findMenu(final Map<String, Object> params, final Page page);
	
	/**获取最大编码
	 * @return
	 */
	public String getMaxCode(Map<String, Object> params);
	
	/**
	 * 获取所有的一级菜单
	 * @return
	 */
	public List<Menu> findAllParents();
	
	/**
	 * 获取所有菜单
	 * @return
	 */
	public List<Map<String, Object>> findAll();
	
	/**
	 * 根据角色id获取角色下面拥有的菜单
	 * @param roleId
	 * @return
	 */
	public List<Long> findOwns(Long companyId);
	
	/**
	 * 查询集合中指定的二级菜单
	 * @param menuIds
	 * @return
	 */
	List<Menu> getSecondMenuList(List<Long> menuIds);
}
