package com.dt.tarmag.vo;
/**
 * 推送对象
 * @author jason
 *
 */
public class PushVo {

	private long id;//推送表的id
	private String content;//推送内容
	private String type;//推送类型  0 公告 1通知 2快递...
	private long userId;//用户id
	private String appType;//app类型
	private String nToken;//设备ID
	private String deviceModel;//model
	private String deviceType;//设备类型
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
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
	public String getDeviceModel() {
		return deviceModel;
	}
	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
	}
	public String getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}
}
