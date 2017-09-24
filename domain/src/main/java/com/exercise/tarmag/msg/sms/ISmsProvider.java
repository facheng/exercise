/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.msg.sms;

import org.apache.log4j.Logger;

import com.dt.tarmag.msg.model.SmsModel;

/**
 * 短信发送接口
 * 
 * @author 👤wisdom
 *
 */
public interface ISmsProvider {
	final static Logger logger = Logger.getLogger(ISmsProvider.class);

	/**
	 * 消息发送
	 */
	public boolean send(SmsModel smsModel);
}
