/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.msg.model;


/**
 * @author 👤wisdom
 *
 */
public enum SmsType {
	LOGIN_CAPTCHA("30967", "【i家园】您本次的验证码为:{1},请{2}分钟内使用"), // 登录验证码
	INVITE_ADDRESS(), // 邀约
	COUPON_TYPE();// 优惠券

	private String templateId;
	private String template;

	private SmsType() {
	}

	private SmsType(String templateId) {
		this.templateId = templateId;
	}

	private SmsType(String templateId, String template) {
		this.templateId = templateId;
		this.template = template;
	}

	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}

	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}
}
