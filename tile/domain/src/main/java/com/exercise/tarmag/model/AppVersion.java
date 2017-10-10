package com.dt.tarmag.model;

import java.util.Date;



/**
 * APP当前版本 
 * @author yuwei
 * @Time 2015-6-27下午05:30:37
 */
public class AppVersion implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1803301244972148454L;
	private long id;
	private int appId;
	private String appName;
	private String versionNo;
	private Date createTime;
	
	
	public final static int APP_ID_ANDROID = 1;


	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public int getAppId() {
		return appId;
	}
	public void setAppId(int appId) {
		this.appId = appId;
	}
	public String getAppName() {
		return appName;
	}
	public void setAppName(String appName) {
		this.appName = appName;
	}
	public String getVersionNo() {
		return versionNo;
	}
	public void setVersionNo(String versionNo) {
		this.versionNo = versionNo;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
