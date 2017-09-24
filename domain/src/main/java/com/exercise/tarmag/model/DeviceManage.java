package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;
/**
 * APP用户驱动管理
 * @author jason
 *
 */
public class DeviceManage extends DtModel{

	private static final long serialVersionUID = 808595877028459161L;
	
	private String appType;//app类型    iwing-i家园
	private String nToken;//设备ID
	private long userId;//用户id     有可能是住户id或者保安保修id
	private String deviceType;//设备类型     ios-苹果  android-安卓
	private String deviceModel;// iphone     android
	
	public final static String APP_TYPE_IWING = "iwing";
	public final static String DEVICE_TYPE_IOS = "ios";
	public final static String DEVICE_TYPE_ANDROID = "android";
	public final static String DEVICE_MODEL_IPHONE = "iphone";
	public final static String DEVICE_MODEL_ANDROID = "android";
	
	
	
	public String getAppType() {
		return appType;
	}
	public void setAppType(String appType) {
		this.appType = appType;
	}

	public String getnToken() {
		return nToken;
	}
	public void setnToken(String nToken) {
		this.nToken = nToken;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}
	public String getDeviceModel() {
		return deviceModel;
	}
	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
	}
	
}
