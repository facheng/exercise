package com.dt.tarmag.enumeration;





/**
 * 电商的Code
 * @author yuwei
 * @Time 2015-8-14下午05:24:08
 */
public enum EcommerceCode {
	YHD("yhd");
	
	private String code;

	
	
	
	
	private EcommerceCode(String code) {
		this.code = code;
	}

	public String getCode() {
		return code;
	}

}
