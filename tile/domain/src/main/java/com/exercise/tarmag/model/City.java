package com.dt.tarmag.model;



/**
 * 市 
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class City implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5748051370799172451L;
	private long id;
	private long cityId;
	private String cityName;
	private long provinceId;
	private String locale;
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getCityId() {
		return cityId;
	}
	public void setCityId(long cityId) {
		this.cityId = cityId;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public long getProvinceId() {
		return provinceId;
	}
	public void setProvinceId(long provinceId) {
		this.provinceId = provinceId;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
}
