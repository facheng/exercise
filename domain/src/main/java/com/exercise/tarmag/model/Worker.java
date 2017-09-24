package com.dt.tarmag.model;


import java.util.Date;

import com.dt.framework.model.DtModel;


/**
 * 小区工作人员
 * @author yuwei
 * @Time 2015-7-17下午05:31:59
 */
public class Worker extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3531264693511873057L;
	private String phoneNum;
	private String userName;
	private String password;
	private String tokenId;
	private String idCard;
	private Date birthday;
	private Date entryDate;
	
	
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
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
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public Date getEntryDate() {
		return entryDate;
	}
	public void setEntryDate(Date entryDate) {
		this.entryDate = entryDate;
	}
	public String getTokenId() {
		return tokenId;
	}
	public void setTokenId(String tokenId) {
		this.tokenId = tokenId;
	}
}
