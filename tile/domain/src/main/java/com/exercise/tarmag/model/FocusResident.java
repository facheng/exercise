package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * 需要关注的业主
 * @author yuwei
 * @Time 2015-7-17下午07:23:16
 */
public class FocusResident extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5999771231141220243L;
	private long hrId;
	private byte residentStatus;
	private String remark;
	

	/**
	 * 易怒
	 */
	public final static byte RESIDENT_STATUS_ANGRY = 1;
	/**
	 * 体弱
	 */
	public final static byte RESIDENT_STATUS_WEAK = 2;
	/**
	 * 迟缴费
	 */
	public final static byte RESIDENT_STATUS_LATEPAY = 3;
	
	
	public long getHrId() {
		return hrId;
	}
	public void setHrId(long hrId) {
		this.hrId = hrId;
	}
	public byte getResidentStatus() {
		return residentStatus;
	}
	public void setResidentStatus(byte residentStatus) {
		this.residentStatus = residentStatus;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
