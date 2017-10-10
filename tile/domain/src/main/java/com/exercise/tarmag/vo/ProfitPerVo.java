package com.dt.tarmag.vo;


public class ProfitPerVo {
	
	private Long id;
	
	private String companyName;
	
	/**
	 * 公司ID
	 */
	private Long cId;
	
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

	
	public String getCompanyName() {
		return companyName;
	}

	
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	
	public Long getcId() {
		return cId;
	}


	
	public void setcId(Long cId) {
		this.cId = cId;
	}


	public Double getPercent() {
		return percent;
	}

	
	public void setPercent(Double percent) {
		this.percent = percent;
	}
	
}
