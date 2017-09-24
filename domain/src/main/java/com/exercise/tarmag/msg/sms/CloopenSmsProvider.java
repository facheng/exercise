/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.msg.sms;

import java.util.Map;

import com.cloopen.rest.sdk.CCPRestSmsSDK;
import com.dt.tarmag.Constants;
import com.dt.tarmag.msg.model.SmsModel;

/**
 * @author 👤wisdom
 *云通讯 短信平台
 */
public class CloopenSmsProvider implements ISmsProvider {
	
	private CCPRestSmsSDK restAPI = null;
	private final String SUCCESS_CODE = "000000";
	
	public CloopenSmsProvider() {
		super();
		this.init();
	}
	
	protected void init(){
		this.restAPI = new CCPRestSmsSDK();
		this.restAPI.init(Constants.CLOOPEN_SMS_HOST, Constants.CLOOPEN_SMS_PORT);
		this.restAPI.setAccount(Constants.CLOOPEN_SMS_ACCOUNT, Constants.CLOOPEN_SMS_TOKEN);
		this.restAPI.setAppId(Constants.CLOOPEN_SMS_APPID);
	}

	@Override
	public boolean send(SmsModel smsModel) {
		Map<String, Object> result = this.restAPI.sendTemplateSMS(
				smsModel.getPhone(), smsModel.getSmsType().getTemplateId(),
				smsModel.getContents());
		logger.info("send " + smsModel.getPhones() + " reviced: " + result);
		boolean flag = SUCCESS_CODE.equals(result.get("statusCode"));
		if(!flag){
			//异常返回输出错误码和错误信息
			logger.warn("错误码=" + result.get("statusCode") +" 错误信息= "+result.get("statusMsg"));
		}
		return flag;
	}
	
}
