/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.framework.util.Page;
import com.dt.tarmag.model.Menu;
import com.dt.tarmag.util.PageResult;

/**
 * @author raymond
 *
 */
public interface IMenuService {
	/**
	 * 根据条件分页查询公司
	 * @param params
	 * @param page
	 * @return
	 */
	public PageResult<Map<String, Object>> findMenu(final Map<String, Object> params,
			final Page page);
	
	
	/**
	 * 查询所有的菜单
	 * @return
	 * 
	 */
	public List<Menu> findAll();
	/**
	 * 根据id获取菜单
	 * @param id
	 * @return
	 */
	public Menu findMenuById(long id);
	
	/**
	 * 保存菜单信息
	 * @param menu
	 */
	public void saveMenu_tx(Menu menu);
	
	/**
	 * 删除公司
	 * @param ids
	 */
	public void delete_tx(Long[] ids);
}
