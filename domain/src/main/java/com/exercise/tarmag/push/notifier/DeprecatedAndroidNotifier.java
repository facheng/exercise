/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.push.notifier;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.dt.tarmag.Constants;
import com.dt.tarmag.vo.PushVo;
import com.gexin.rp.sdk.base.IPushResult;
import com.gexin.rp.sdk.base.impl.SingleMessage;
import com.gexin.rp.sdk.base.impl.Target;
import com.gexin.rp.sdk.http.IGtPush;
import com.gexin.rp.sdk.template.NotificationTemplate;

/**
 * @author 👤wisdom
 *
 */
@Deprecated
public class DeprecatedAndroidNotifier implements INotifier {

	private static final Logger logger = Logger
			.getLogger(DeprecatedAndroidNotifier.class);

	private static String host = "http://sdk.open.api.igexin.com/apiex.htm";
	private String masterSecret;
	private String appKey;
	private String appId;
	private String title;
	private String logo = "push.png";
	private String logoUrl = "";
	private String transmissionContent = "";
	private int transmissionType = 2;
	private long expireTime = 7 * 24 * 3600 * 1000;

	private IGtPush push;

	@Override
	public void beginNotify(String appType) throws Exception {
		host = Constants.PUSH_ANDROID_HOST;
		appId = Constants.PUSH_APP_ID;
		appKey = Constants.PUSH_APP_KEY;
		masterSecret = Constants.PUSH_MASTER_SECRET;
		
		push = new IGtPush(host, appKey, masterSecret);
		push.connect();
	}

	@Override
	public void endNotify() throws Exception {
		push.close();
	}

	@Override
	public void nofity(PushVo pushVo) throws Exception {
		try {
			NotificationTemplate template = notificationTemplate(pushVo);
			SingleMessage message = new SingleMessage();
			message.setOffline(true);
			message.setOfflineExpireTime(expireTime);
			message.setData(template);
			Target target = new Target();
			target.setAppId(appId);
			target.setClientId(pushVo.getnToken());
			IPushResult ret = push.pushMessageToSingle(message, target);
			System.out.println(ret.getResponse().toString());
		} catch (Throwable e) {
			logger.error("android push message fail", e);
		}
	}

	private NotificationTemplate notificationTemplate(PushVo pushVo) {
		NotificationTemplate template = new NotificationTemplate();
		template.setAppId(appId);
		template.setAppkey(appKey);
		template.setTitle(title);
		String title = pushVo.getContent();
		if (StringUtils.isNotBlank(title) && title.length() > 60) {
			title = title.substring(0, 60) + "....";
		}
		template.setText(title);
		template.setLogo(logo);
		template.setLogoUrl(logoUrl);
		template.setIsRing(true);
		template.setIsVibrate(true);
		template.setIsClearable(true);
		template.setTransmissionType(transmissionType);
		JSONObject json = JSONObject.fromObject(pushVo);
		template.setTransmissionContent(json.toString());
		return template;
	}

	public String getMasterSecret() {
		return masterSecret;
	}

	public void setMasterSecret(String masterSecret) {
		this.masterSecret = masterSecret;
	}

	public String getAppKey() {
		return appKey;
	}

	public void setAppKey(String appKey) {
		this.appKey = appKey;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getLogoUrl() {
		return logoUrl;
	}

	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}

	public String getTransmissionContent() {
		return transmissionContent;
	}

	public void setTransmissionContent(String transmissionContent) {
		this.transmissionContent = transmissionContent;
	}

	public int getTransmissionType() {
		return transmissionType;
	}

	public void setTransmissionType(int transmissionType) {
		this.transmissionType = transmissionType;
	}

	public long getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(long expireTime) {
		this.expireTime = expireTime;
	}

	public IGtPush getPush() {
		return push;
	}

	public void setPush(IGtPush push) {
		this.push = push;
	}

}
