package com.dt.tarmag.model;

import java.util.Date;

import com.dt.framework.model.DtSimpleModel;



/**
 * 邀约
 * @author yuwei
 * @Time 2015-7-6下午12:56:04
 */
public class Invitation extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1388503268592513461L;
	private long inviterId;
	private long inviteeId;
	private long houseId;
	private Date visitTime;
	private Date deadlineTime;
	private String message;
	private String qrCode;
	private Date createTime;
	
	
	public long getInviterId() {
		return inviterId;
	}
	public void setInviterId(long inviterId) {
		this.inviterId = inviterId;
	}
	public long getInviteeId() {
		return inviteeId;
	}
	public void setInviteeId(long inviteeId) {
		this.inviteeId = inviteeId;
	}
	public long getHouseId() {
		return houseId;
	}
	public void setHouseId(long houseId) {
		this.houseId = houseId;
	}
	public Date getVisitTime() {
		return visitTime;
	}
	public void setVisitTime(Date visitTime) {
		this.visitTime = visitTime;
	}
	public Date getDeadlineTime() {
		return deadlineTime;
	}
	public void setDeadlineTime(Date deadlineTime) {
		this.deadlineTime = deadlineTime;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getQrCode() {
		return qrCode;
	}
	public void setQrCode(String qrCode) {
		this.qrCode = qrCode;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
