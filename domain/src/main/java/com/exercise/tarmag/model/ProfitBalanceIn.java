package com.dt.tarmag.model;

import java.util.Date;

import com.dt.framework.model.DtModel;


/**
 * 反润结算(电商->团团)
 * @author yuwei
 * @Time 2015-8-13下午05:25:44
 */
public class ProfitBalanceIn extends DtModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2625888326908892902L;
	private long ecomId;
	private Date startTime;
	private Date endTime;
	private double consumeAmount;
	private double profitAmount;
	private byte status;
	

	/**
	 * 状态(未结算)
	 */
	public final static byte STATUS_NOT_SETTLED = 0;
	/**
	 * 状态(结算中(发票))
	 */
	public final static byte STATUS_SETTLING = 1;
	/**
	 * 状态(已结算)
	 */
	public final static byte STATUS_SETTLED = 2;
	
	
	public long getEcomId() {
		return ecomId;
	}
	public void setEcomId(long ecomId) {
		this.ecomId = ecomId;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public double getConsumeAmount() {
		return consumeAmount;
	}
	public void setConsumeAmount(double consumeAmount) {
		this.consumeAmount = consumeAmount;
	}
	public double getProfitAmount() {
		return profitAmount;
	}
	public void setProfitAmount(double profitAmount) {
		this.profitAmount = profitAmount;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
}
