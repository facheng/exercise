/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.vo;

import java.util.Date;

import org.apache.commons.lang.StringUtils;


/**
 * @author 👤wisdom
 *
 */
public class InvitationVo {
	private String userName;
	private String phoneNum;
	private String visitTime;
	private String deadlineTime;
	private String message;
	private long houseId;
	private long inviterId;
	private String tokenId;

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

	public Date getVisitTime() {
		Date visit = null;
		if(StringUtils.isNotBlank(this.visitTime)&&Double.valueOf(this.visitTime) > 0.0){
			visit = new Date(Double.valueOf(this.visitTime).longValue());
		}
		return visit;
	}

	public void setVisitTime(String visitTime) {
		this.visitTime = visitTime;
	}

	public Date getDeadlineTime() {
		Date deadline = null;
		if(StringUtils.isNotBlank(this.deadlineTime)){
			if(Double.valueOf(this.deadlineTime).longValue()>System.currentTimeMillis()){
				deadline = new Date(Double.valueOf(this.deadlineTime).longValue());
			}
		}
		return deadline;
	}

	public void setDeadlineTime(String deadlineTime) {
		this.deadlineTime = deadlineTime;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public long getHouseId() {
		return houseId;
	}

	public void setHouseId(long houseId) {
		this.houseId = houseId;
	}

	public long getInviterId() {
		return inviterId;
	}

	public void setInviterId(long inviterId) {
		this.inviterId = inviterId;
	}

	public String getTokenId() {
		return tokenId;
	}

	public void setTokenId(String tokenId) {
		this.tokenId = tokenId;
	}

}
