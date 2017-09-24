package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * 物业客户角色
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class Role extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2502783158091861954L;
	private String roleName;
	private long companyId;
	private boolean isAdmin;

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}
	public boolean getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
}
