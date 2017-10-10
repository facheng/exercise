package com.dt.tarmag.model;



/**
 * 县/区 
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class District implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5964796901265502653L;
	private long id;
	private long districtId;
	private String districtName;
	private long cityId;
	private String locale;
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getDistrictId() {
		return districtId;
	}
	public void setDistrictId(long districtId) {
		this.districtId = districtId;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public long getCityId() {
		return cityId;
	}
	public void setCityId(long cityId) {
		this.cityId = cityId;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
}
