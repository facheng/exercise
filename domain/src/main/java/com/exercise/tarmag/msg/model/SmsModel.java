/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.msg.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang.StringUtils;

/**
 * @author 👤wisdom
 *
 */
public class SmsModel {
	/**
	 * 要发送的手机号码
	 */
	private List<String> phones = new ArrayList<String>();
	/**
	 * 发送的消息类型 @see SmsType
	 */
	private SmsType smsType;
	/**
	 * 要发送的消息内容
	 */
	private List<String> content = new ArrayList<String>();

	public SmsModel() {
		super();
	}

	public SmsModel(List<String> phones, SmsType smsType, List<String> content) {
		super();
		this.phones = phones;
		this.smsType = smsType;
		this.content = content;
	}
	
	public void addPhone(String phone){
		this.phones.add(phone);
	}
	
	public void addContent(String content){
		this.content.add(content);
	}
	
	public void addContents(String[] contents){
		this.content.addAll(Arrays.asList(contents));
	}
	
	public String getPhone(){
		return StringUtils.join(this.phones, ",");
	}
	
	public String[] getContents(){
		return this.content.toArray(new String[0]);
	}
	
	public List<String> getContent() {
		return content;
	}

	public List<String> getPhones() {
		return phones;
	}

	public SmsType getSmsType() {
		return smsType;
	}

	public void setContent(List<String> content) {
		this.content = content;
	}

	public void setPhones(List<String> phones) {
		this.phones = phones;
	}

	public void setSmsType(SmsType smsType) {
		this.smsType = smsType;
	}

	public String getMsg(){
		String msg = this.getSmsType().getTemplate();
		for(String arg : this.getContent()){
			msg = msg.replaceFirst("\\{\\d+\\}", arg);
		}
		return msg;
	}
}
