package com.dt.tarmag.vo;

/**
 * API 访问记录扩展类
 *
 * @author jiaosf
 * @since 2015-7-30
 */
public class ApiRequestRecVo {

	private long id;
	private long residentId;
	private String loginTime;
	private String latestVisitTime;

	private String userName;
	private String phoneNum;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getResidentId() {
		return residentId;
	}

	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}

	public String getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(String loginTime) {
		this.loginTime = loginTime;
	}

	public String getLatestVisitTime() {
		return latestVisitTime;
	}

	public void setLatestVisitTime(String latestVisitTime) {
		this.latestVisitTime = latestVisitTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

}
