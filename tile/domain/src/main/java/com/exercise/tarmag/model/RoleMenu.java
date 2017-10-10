package com.dt.tarmag.model;

import com.dt.framework.model.DtSimpleModel;


/**
 * 角色+菜单关系
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class RoleMenu extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5017830797207139821L;
	private long roleId;
	private long menuId;
	
	
	public long getRoleId() {
		return roleId;
	}
	public void setRoleId(long roleId) {
		this.roleId = roleId;
	}
	public long getMenuId() {
		return menuId;
	}
	public void setMenuId(long menuId) {
		this.menuId = menuId;
	}
}
