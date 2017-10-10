package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * 电商基本资料(清结算)
 * @author yuwei
 * @Time 2015-8-13下午05:15:09
 */
public class ProfitEcom extends DtModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5966479402071279381L;
	private String code;
	private String ecomName;
	private byte autoCalculate;
	private String remark;
	

	/**
	 * 是否可以自动清算(否)
	 */
	public final static byte AUTO_CALCULATE_NO = 0;
	/**
	 * 是否可以自动清算(是)
	 */
	public final static byte AUTO_CALCULATE_YES = 1;
	
	
	
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public byte getAutoCalculate() {
		return autoCalculate;
	}
	public void setAutoCalculate(byte autoCalculate) {
		this.autoCalculate = autoCalculate;
	}
}
