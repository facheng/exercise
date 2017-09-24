package com.dt.tarmag.model;

import java.util.Date;

import com.dt.framework.model.DtSimpleModel;



/**
 * 通知的接收者(居住者)
 * @author yuwei
 * @Time 2015-7-6下午06:05:55
 */
public class NoticeReceiver extends DtSimpleModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5524460594052484565L;
	private long noticeId;
	private long residentId;
	private boolean isRead;
	private Date readTime;
	
	
	public long getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(long noticeId) {
		this.noticeId = noticeId;
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
