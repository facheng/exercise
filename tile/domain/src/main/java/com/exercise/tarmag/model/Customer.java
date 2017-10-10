package com.dt.tarmag.model;


import com.dt.framework.model.DtModel;


/**
 * 物业客户
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class Customer extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1668143663790440883L;
	private String userName;
	private String realName;
	private String password;
	private long companyId;
	private long branchId;
	private String idCard;
	private boolean isAdmin;
	
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public long getBranchId() {
		return branchId;
	}
	public void setBranchId(long branchId) {
		this.branchId = branchId;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
}
