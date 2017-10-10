package com.dt.tarmag.model;

import java.util.Date;

import com.dt.framework.model.DtSimpleModel;



/**
 * 公告阅读者
 * @author yuwei
 * @Time 2015-7-6下午06:01:03
 */
public class BroadcastReader extends DtSimpleModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -9055017324194686350L;
	private long broadcastId;
	private long residentId;
	private boolean isRead;
	private Date readTime;
	
	
	public long getBroadcastId() {
		return broadcastId;
	}
	public void setBroadcastId(long broadcastId) {
		this.broadcastId = broadcastId;
	}
	public long getResidentId() {
		return residentId;
	}
	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}
	public boolean getIsRead() {
		return isRead;
	}
	public void setIsRead(boolean isRead) {
		this.isRead = isRead;
	}
	public Date getReadTime() {
		return readTime;
	}
	public void setReadTime(Date readTime) {
		this.readTime = readTime;
	}
}
