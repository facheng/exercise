package com.dt.tarmag.model;


import java.util.Date;


/**
 * I家园手机端用户访问API的记录
 * @author yuwei
 * @Time 2015-7-19上午11:36:25
 */
public class ApiRequestRec implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8944408690250714413L;
	private long id;
	private long residentId;
	private Date loginTime;
	private Date latestVisitTime;
	
	
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
	public Date getLoginTime() {
		return loginTime;
	}
	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}
	public Date getLatestVisitTime() {
		return latestVisitTime;
	}
	public void setLatestVisitTime(Date latestVisitTime) {
		this.latestVisitTime = latestVisitTime;
	}
}
