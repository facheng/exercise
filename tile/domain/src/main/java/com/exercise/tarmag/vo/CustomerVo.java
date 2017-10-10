package com.dt.tarmag.vo;



/**
 * @author yuwei
 * @Time 2015-7-7下午04:35:29
 */
public class CustomerVo {
	private String userName;
	private String realName;
	private String password;
	private String idCard;
	private long branchId;
	private byte changePassword;

	public final static byte CHANGE_PASSWORD_N = 0;
	public final static byte CHANGE_PASSWORD_Y = 1;
	
	
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
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public long getBranchId() {
		return branchId;
	}
	public void setBranchId(long branchId) {
		this.branchId = branchId;
	}
	public byte getChangePassword() {
		return changePassword;
	}
	public void setChangePassword(byte changePassword) {
		this.changePassword = changePassword;
	}
}
