package com.dt.tarmag.vo;



/**
 * @author yuwei
 * @Time 2015-7-13下午04:51:50
 */
public class KeyDeviceVo {
	private long unitId;
	private String keyName;
	private int keyType;
//	private String deviceName;
	private int deviceType;
//	private String deviceUuid;
	private String deviceAddress;
	private String password;
	private String remark;
	private long storyId;
	
	
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
	public String getKeyName() {
		return keyName;
	}
	public void setKeyName(String keyName) {
		this.keyName = keyName;
	}
	public int getKeyType() {
		return keyType;
	}
	public void setKeyType(int keyType) {
		this.keyType = keyType;
	}
//	public String getDeviceName() {
//		return deviceName;
//	}
//	public void setDeviceName(String deviceName) {
//		this.deviceName = deviceName;
//	}
	public int getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(int deviceType) {
		this.deviceType = deviceType;
	}
//	public String getDeviceUuid() {
//		return deviceUuid;
//	}
//	public void setDeviceUuid(String deviceUuid) {
//		this.deviceUuid = deviceUuid;
//	}
	public String getDeviceAddress() {
		return deviceAddress;
	}
	public void setDeviceAddress(String deviceAddress) {
		this.deviceAddress = deviceAddress;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public long getStoryId() {
		return storyId;
	}
	public void setStoryId(long storyId) {
		this.storyId = storyId;
	}
}
