package com.dt.tarmag.vo;



public class ProfitBalanceOutVo {
	
	private Long id;
	private Long companyId;
	private Long ecomId;
	private String startTime;
	private String endTime;
	private Double consumeAmount;
	private Double profitAmount;
	private Double totalProfitAmount;
	private Byte status;
	
	
	/**
	 * 物业公司名称
	 */
	private String companyName;
	
	/**
	 * 结算比例
	 */
	private Double percent;

	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}


	public Long getCompanyId() {
		return companyId;
	}

	
	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	
	public Long getEcomId() {
		return ecomId;
	}

	
	public void setEcomId(Long ecomId) {
		this.ecomId = ecomId;
	}

	
	public String getStartTime() {
		return startTime;
	}

	
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	
	public String getEndTime() {
		return endTime;
	}

	
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	
	public Double getConsumeAmount() {
		return consumeAmount;
	}

	
	public void setConsumeAmount(Double consumeAmount) {
		this.consumeAmount = consumeAmount;
	}

	
	public Double getProfitAmount() {
		return profitAmount;
	}

	
	public void setProfitAmount(Double profitAmount) {
		this.profitAmount = profitAmount;
	}

	
	public Byte getStatus() {
		return status;
	}

	
	public void setStatus(Byte status) {
		this.status = status;
	}

	
	public String getCompanyName() {
		return companyName;
	}

	
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	
	public Double getPercent() {
		return percent;
	}

	
	public void setPercent(Double percent) {
		this.percent = percent;
	}
	
	public Double getTotalProfitAmount() {
		return totalProfitAmount;
	}
	
	public void setTotalProfitAmount(Double totalProfitAmount) {
		this.totalProfitAmount = totalProfitAmount;
	}
	
	

}
