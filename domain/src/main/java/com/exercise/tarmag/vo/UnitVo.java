package com.dt.tarmag.vo;

/**
 * 小区信息
 * 
 * @author jiaosf
 * @since 2015-7-17
 */
public class UnitVo {
	
	private long id;
	
	/**
	 * 小区名
	 */
	private String unitName;
	/**
	 * 纬度
	 */
	private Double lantitude;
	/**
	 * 经度
	 */
	private Double longitude;
	private String address;
	private Long branchId;
	private String remark;
	/**
	 * 区/县
	 */
	private Long districtId;
	
	/**
	 * 背景图
	 */
	private String appBackgroundImg;

	
	public long getId() {
		return id;
	}

	
	public void setId(long id) {
		this.id = id;
	}

	
	public String getUnitName() {
		return unitName;
	}

	
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	
	public Double getLantitude() {
		return lantitude;
	}

	
	public void setLantitude(Double lantitude) {
		this.lantitude = lantitude;
	}

	
	public Double getLongitude() {
		return longitude;
	}

	
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	
	public String getAddress() {
		return address;
	}

	
	public void setAddress(String address) {
		this.address = address;
	}

	
	public Long getBranchId() {
		return branchId;
	}

	
	public void setBranchId(Long branchId) {
		this.branchId = branchId;
	}

	
	public String getRemark() {
		return remark;
	}

	
	public void setRemark(String remark) {
		this.remark = remark;
	}

	
	public Long getDistrictId() {
		return districtId;
	}

	
	public void setDistrictId(Long districtId) {
		this.districtId = districtId;
	}

	
	public String getAppBackgroundImg() {
		return appBackgroundImg;
	}

	
	public void setAppBackgroundImg(String appBackgroundImg) {
		this.appBackgroundImg = appBackgroundImg;
	}
	
}
