package com.dt.tarmag.model;


import com.dt.framework.model.DtSimpleModel;


/**
 * 住户APP菜单
 * @author yuwei
 * @Time 2015-7-19上午10:34:51
 */
public class AppMenuResident extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7344619358298238766L;
	private long appMenuId;
	private long residentId;
	
	
	public long getAppMenuId() {
		return appMenuId;
	}
	public void setAppMenuId(long appMenuId) {
		this.appMenuId = appMenuId;
	}
	public long getResidentId() {
		return residentId;
	}
	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}
}
