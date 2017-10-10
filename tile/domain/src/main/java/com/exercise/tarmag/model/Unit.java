package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * 小区
 * @author yuwei
 * @Time 2015-6-25上午11:02:42
 */
public class Unit extends DtModel{
	
	public static final String IMG_PATH = "unit";//图片上传的相对路径
	
	private static final long serialVersionUID = 8353206836403867637L;
	private String code;
	private String unitName;
	/**
	 * 纬度
	 */
	private double lantitude;
	/**
	 * 经度
	 */
	private double longitude;
	private String address;
	private long branchId;
	private long companyId;
	private String remark;
	private long districtId;
	private String appBackgroundImg;
	private byte isAuto;
	private String qrCode;
	

	/**
	 * 钥匙类型(手动)
	 */
	public final static byte IS_AUTO_MANUAL = 0;
	/**
	 * 钥匙类型(自动)
	 */
	public final static byte IS_AUTO_AUTOMATIC = 1;
	
	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getUnitName() {
		return unitName;
	}
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	public double getLantitude() {
		return lantitude;
	}
	public void setLantitude(double lantitude) {
		this.lantitude = lantitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public long getBranchId() {
		return branchId;
	}
	public void setBranchId(long branchId) {
		this.branchId = branchId;
	}
	public long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public long getDistrictId() {
		return districtId;
	}
	public void setDistrictId(long districtId) {
		this.districtId = districtId;
	}
	public String getAppBackgroundImg() {
		return appBackgroundImg;
	}
	public void setAppBackgroundImg(String appBackgroundImg) {
		this.appBackgroundImg = appBackgroundImg;
	}
	public byte getIsAuto() {
		return isAuto;
	}
	public void setIsAuto(byte isAuto) {
		this.isAuto = isAuto;
	}
	public String getQrCode() {
		return qrCode;
	}
	public void setQrCode(String qrCode) {
		this.qrCode = qrCode;
	}
}
