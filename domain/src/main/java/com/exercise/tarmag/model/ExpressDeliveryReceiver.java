package com.dt.tarmag.model;

import java.util.Date;

import com.dt.framework.model.DtSimpleModel;



/**
 * 快递消息接收者
 * @author yuwei
 * @Time 2015-7-8下午07:39:35
 */
public class ExpressDeliveryReceiver extends DtSimpleModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3564693451071500381L;
	private long deliveryId;
	private long residentId;
	private boolean isRead;
	private Date readTime;
	
	
	public long getDeliveryId() {
		return deliveryId;
	}
	public void setDeliveryId(long deliveryId) {
		this.deliveryId = deliveryId;
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
