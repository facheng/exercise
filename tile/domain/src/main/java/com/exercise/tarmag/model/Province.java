package com.dt.tarmag.model;



/**
 * 省份
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class Province implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -190166199769351852L;
	private long id;
	private long provinceId;
	private String provinceName;
	private String locale;
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getProvinceId() {
		return provinceId;
	}
	public void setProvinceId(long provinceId) {
		this.provinceId = provinceId;
	}
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
}
