package com.dt.tarmag.msg.sms;

/**
 * 
 * @author frank
 */
public enum SmsPurpose {
	LOGIN_CAPTCHA("0001", "注册验证码"),
	AUTH_CAPTCHA("0002", "授权验证码"),
	INVITE_ADDRESS("0003","发送邀约地址"),
	EJIA_TICKET("0004","E家洁优惠券发送"),
	BINDING_NOTICE("0005","绑定房屋提醒");
	private final String code;
	private final String name;

	private SmsPurpose(String code, String name) {
		this.code = code;
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public String getName() {
		return name;
	}

}
