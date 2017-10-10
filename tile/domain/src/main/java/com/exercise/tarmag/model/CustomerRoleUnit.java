package com.dt.tarmag.model;

import com.dt.framework.model.DtSimpleModel;


/**
 * 客户+角色+小区关系
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class CustomerRoleUnit extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -831617848545144058L;
	private long unitId;
	private long customerId;
	private long roleId;
	
	
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
	public long getCustomerId() {
		return customerId;
	}
	public void setCustomerId(long customerId) {
		this.customerId = customerId;
	}
	public long getRoleId() {
		return roleId;
	}
	public void setRoleId(long roleId) {
		this.roleId = roleId;
	}
}
