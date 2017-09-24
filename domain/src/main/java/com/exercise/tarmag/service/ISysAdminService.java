/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.model.Menu;

/**
 * @author raymond
 *
 */
public interface ISysAdminService {
	/**
	 * 获取系统菜单
	 * @return
	 */
	public Map<Menu, List<Menu>> sysmenus();
	
	/**
	 * 超级管理员登陆
	 */
	public Map<String, Object> login(String userName, String password);
}
