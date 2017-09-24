/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.msg.sms;

import com.dt.tarmag.msg.model.SmsModel;
import com.dt.tarmag.msg.model.SmsType;

/**
 * @author 👤wisdom
 *
 */
public class SmsProviderFactory {
	/**
	 * 获取系统默认的短信发送平台
	 * 
	 * @return
	 */
	protected static ISmsProvider getDefaultSmsProvider() {
		return new CloopenSmsProvider();
	}

	public static boolean send(SmsModel smsModel) {
		return getDefaultSmsProvider().send(smsModel);
	}

	public static SmsModel getSmsModel(String phoneNum, SmsType smsType,
			String[] contents) {
		SmsModel model = new SmsModel();
		model.addPhone(phoneNum);
		model.addContents(contents);
		model.setSmsType(smsType);
		return model;
	}

	public static boolean send(String phoneNum, SmsType smsType,
			String[] contents) {
		return getDefaultSmsProvider().send(
				getSmsModel(phoneNum, smsType, contents));
	}
}
