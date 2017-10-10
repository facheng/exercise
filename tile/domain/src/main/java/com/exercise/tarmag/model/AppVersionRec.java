package com.dt.tarmag.model;

import java.util.Date;



/**
 * APP版本记录
 * @author yuwei
 * @Time 2015-6-27下午05:34:26
 */
public class AppVersionRec implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7103812346196805104L;
	private long id;
	private int appId;
	private String versionNo;
	private boolean forceUpdate;
	private String updateUrl;
	private Date createTime;
	
	
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
	public String getVersionNo() {
		return versionNo;
	}
	public void setVersionNo(String versionNo) {
		this.versionNo = versionNo;
	}
	public boolean getForceUpdate() {
		return forceUpdate;
	}
	public void setForceUpdate(boolean forceUpdate) {
		this.forceUpdate = forceUpdate;
	}
	public String getUpdateUrl() {
		return updateUrl;
	}
	public void setUpdateUrl(String updateUrl) {
		this.updateUrl = updateUrl;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
