package com.dt.tarmag.model;

import com.dt.framework.model.DtSimpleModel;


/**
 * 系统管理员
 * @author yuwei
 * @Time 2015-6-25上午10:47:34
 */
public class SysAdmin extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7083891024859446267L;
	private String userName;
	private String password;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
