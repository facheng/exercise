package com.dt.tarmag.msg.sms;

import java.util.ArrayList;
import java.util.UUID;

import com.esms.MessageData;
import com.esms.PostMsg;
import com.esms.common.entity.Account;
import com.esms.common.entity.GsmsResponse;
import com.esms.common.entity.MTPack;
import com.esms.common.entity.MTPack.MsgType;
import com.esms.common.entity.MTPack.SendType;

/**
 * 
 * @author frank
 */
public class XwSmsUtil {
	/** 用户名 */
	private static final String ACCOUNT_NAME = "cadmin@ttxx";
	/** 密码 */
	private static final String ACCOUNT_PASS = "Ttxx@400Sms";
	/** 网关IP */
	private static final String GATEWAY_IP = "211.147.239.62";
	/** 网关PORT */
	private static final int GATEWAY_PORT = 8450;

	/**
	 * 注册模板
	 */
	public static String LOGIN_TEMPLATE = "您本次的验证码为:${code},请3分钟内使用";

	/**
	 * E家洁模板
	 */
	public static String EJIA_TEMPLATE = "感谢您使用家政宝服务，为提升您的家政体验服务，给您提供一张价值30元的优惠券:${code}，有效期至:${validDate}";

	/**
	 * E家洁模板
	 */
	public static String BINDNG_NOTICE_TEMPLATE = "亲爱的用户，在您绑定认证房屋后使用家政版块可以获得优惠哟！";
	/**
	 * 邀约地址
	 */
	public static String INVITE_TEMPLATE = "您好，${yiName}先生/女士，${name}向您发送了一条访客邀请${url}，您可在进小区前向保安出示，我们恭候您的到来！（以上短信请勿删除，以备进出小区时使用！";

	/**
	 * 
	 * @param phone
	 * @param content
	 * @param purpose
	 * @return
	 */
	public static synchronized int singleSms(String phone, String content,
			SmsPurpose purpose) {
		int resultFlag = -99;
		try {
			Account account = new Account(ACCOUNT_NAME, ACCOUNT_PASS);
			PostMsg pm = new PostMsg();
			pm.getCmHost().setHost(GATEWAY_IP, GATEWAY_PORT);

			MTPack pack = new MTPack();
			pack.setBatchID(UUID.randomUUID());
			pack.setBatchName(purpose.getName());
			pack.setMsgType(MsgType.SMS);
			pack.setBizType(1);
			pack.setDistinctFlag(false);
			ArrayList<MessageData> msgs = new ArrayList<MessageData>();

			pack.setSendType(SendType.MASS);
			msgs.add(new MessageData(phone, content));
			pack.setMsgs(msgs);

			GsmsResponse resp = pm.post(account, pack);
			resultFlag = resp.getResult();
		} catch (Exception e) {
			resultFlag = -999;
		}

		return resultFlag;
	}

	public static void main(String[] args) {
		String str = "423634";
		String cotent = XwSmsUtil.LOGIN_TEMPLATE.replace("${code}", str);
		int dd = singleSms("13918174767", cotent, SmsPurpose.LOGIN_CAPTCHA);
		System.out.println(dd);
	}
}
