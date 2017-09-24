package com.dt.tarmag.model;


import com.dt.framework.model.DtModel;



/**
 * 钥匙设备
 * @author yuwei
 * @Time 2015-7-6下午01:25:23
 */
public class KeyDevice extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 936520095620098160L;
	private String keyName;
	private String deviceName;
	private long unitId;
	private long storyId;
	private String remark;
	private String deviceUuid;
	private String deviceAddress;
	private String devicePassword;
	private int deviceType;
	private int keyType;
	
	public static final String TEMPLATE_PATH = "key";//模板上传的相对路径


	/**
	 * 钥匙类型(人行)
	 */
	public final static int KEY_TYPE_FOOT = 0;
	/**
	 * 钥匙类型(车行)
	 */
	public final static int KEY_TYPE_CAR = 1;

	/**
	 * 设备类型(小区)
	 */
	public final static int DEVICE_TYPE_UNIT = 0;
	/**
	 * 设备类型(楼栋)
	 */
	public final static int DEVICE_TYPE_STORY = 1;
	
	
	public String getKeyTypeName() {
		int _type = getKeyType();
		if(_type == KEY_TYPE_FOOT) {
			return "人行";
		}
		if(_type == KEY_TYPE_CAR) {
			return "车行";
		}
		return String.valueOf(_type);
	}
	
	
	public String getDeviceTypeName() {
		int _type = getDeviceType();
		if(_type == DEVICE_TYPE_UNIT) {
			return "小区";
		}
		if(_type == DEVICE_TYPE_STORY) {
			return "楼栋";
		}
		return String.valueOf(_type);
	}
	
	
	public String getKeyName() {
		return keyName;
	}
	public void setKeyName(String keyName) {
		this.keyName = keyName;
	}
	public String getDeviceName() {
		return deviceName;
	}
	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
	public long getStoryId() {
		return storyId;
	}
	public void setStoryId(long storyId) {
		this.storyId = storyId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getDeviceAddress() {
		return deviceAddress;
	}
	public void setDeviceAddress(String deviceAddress) {
		this.deviceAddress = deviceAddress;
	}
	public String getDevicePassword() {
		return devicePassword;
	}
	public void setDevicePassword(String devicePassword) {
		this.devicePassword = devicePassword;
	}
	public int getKeyType() {
		return keyType;
	}
	public void setKeyType(int keyType) {
		this.keyType = keyType;
	}
	public int getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(int deviceType) {
		this.deviceType = deviceType;
	}
	public String getDeviceUuid() {
		return deviceUuid;
	}
	public void setDeviceUuid(String deviceUuid) {
		this.deviceUuid = deviceUuid;
	}
}
