package com.dt.tarmag.vo;

import java.util.Date;

/**
 * 从电商处获得的消费日志
 *  @author wangfacheng
 */

public class ProfitConsumeRecVo {

	private long ecomId;
	private String orderId;
	private long unitId;
	private double consumeAmount;
	private double profitAmount;
	private byte status;
	
	private Date startTime;
	private Date endTime;
	
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

	public long getEcomId() {
		return ecomId;
	}
	
	public void setEcomId(long ecomId) {
		this.ecomId = ecomId;
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
	
	
}
