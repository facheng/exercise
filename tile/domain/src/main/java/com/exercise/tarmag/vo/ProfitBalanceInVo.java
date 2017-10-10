package com.dt.tarmag.vo;

import java.util.Date;

/**
 * 
 * @author wangfacheng
 *
 */
public class ProfitBalanceInVo {

	private Long id;
	
	private long ecomId;
	private Date startTime;
	private Date endTime;
	private double consumeAmount;
	private double profitAmount;
	private String status;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
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
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
