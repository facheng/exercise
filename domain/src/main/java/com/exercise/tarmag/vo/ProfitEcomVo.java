package com.dt.tarmag.vo;

/**
 * 电商清算vo
 * @author wangfacheng
 * @Time 2015年8月14日13:22:31
 *
 */
public class ProfitEcomVo {
	
	private String code;
	private String ecomName;
	
	private Long id ;
	private String remark;
	
	private Byte autoCalculate;
	
	
	public Byte getAutoCalculate() {
		return autoCalculate;
	}

	
	public void setAutoCalculate(Byte autoCalculate) {
		this.autoCalculate = autoCalculate;
	}
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getEcomName() {
		return ecomName;
	}
	public void setEcomName(String ecomName) {
		this.ecomName = ecomName;
	}
	
}
