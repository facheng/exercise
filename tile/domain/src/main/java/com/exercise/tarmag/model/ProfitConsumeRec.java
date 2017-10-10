package com.dt.tarmag.model;

import java.util.Date;

import com.dt.framework.model.DtModel;


/**
 * 从电商处获得的消费日志
 * @author yuwei
 * @Time 2015-8-13下午05:17:18
 */
public class ProfitConsumeRec extends DtModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1642092691938422542L;
	private long ecomId;
	private Date consumeTime;
	private String orderId;
	private long unitId;
	private long residentId;
	private double consumeAmount;
	private double profitAmount;
	private byte status;
	
	
	/**
	 * 状态(未对账)
	 */
	public final static byte STATUS_NOT_APPROVE = 0;
	/**
	 * 状态(已对账)
	 */
	public final static byte STATUS_APPROVED = 1;
	
	
	public long getEcomId() {
		return ecomId;
	}
	public void setEcomId(long ecomId) {
		this.ecomId = ecomId;
	}
	public Date getConsumeTime() {
		return consumeTime;
	}
	public void setConsumeTime(Date consumeTime) {
		this.consumeTime = consumeTime;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
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
	public long getResidentId() {
		return residentId;
	}
	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}
}
