package com.dt.tarmag.model;

import java.util.Date;

import com.dt.framework.model.DtModel;


/**
 * 优惠券
 * @author yuwei
 * @Time 2015-8-10下午02:08:52
 */
public class Coupon extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2984731409615478209L;
	private long typeId;
	private String code;
	private long receiverId;
	private Date receivedTime;
	
	
	
	
	public long getTypeId() {
		return typeId;
	}
	public void setTypeId(long typeId) {
		this.typeId = typeId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public long getReceiverId() {
		return receiverId;
	}
	public void setReceiverId(long receiverId) {
		this.receiverId = receiverId;
	}
	public Date getReceivedTime() {
		return receivedTime;
	}
	public void setReceivedTime(Date receivedTime) {
		this.receivedTime = receivedTime;
	}
}
