package com.dt.tarmag.model;

import java.util.Date;

import com.dt.framework.model.DtSimpleModel;


/**
 * 短信验证码
 * @author yuwei
 * @Time 2015-6-25下午04:19:26
 */
public class SmsCode extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7662933276977991649L;
	private String phoneNum;
	private String code;
	private String type;
	private String content;
	private Date validTime;
	private Date createTime;
	
	
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getValidTime() {
		return validTime;
	}
	public void setValidTime(Date validTime) {
		this.validTime = validTime;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
