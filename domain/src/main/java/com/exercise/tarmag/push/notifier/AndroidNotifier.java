/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.push.notifier;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import cn.jpush.api.JPushClient;
import cn.jpush.api.push.model.Message;
import cn.jpush.api.push.model.Options;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.notification.AndroidNotification;
import cn.jpush.api.push.model.notification.Notification;

import com.dt.tarmag.Constants;
import com.dt.tarmag.vo.PushVo;

/**
 * @author 👤wisdom
 *
 */
public class AndroidNotifier implements INotifier {

	private static final Logger logger = Logger
			.getLogger(AndroidNotifier.class);

	private String masterSecret;
	private String appKey;
	private String appId;
	private String title;
	private String logo = "push.png";
	private String logoUrl = "";
	private String transmissionContent = "";
	private int transmissionType = 2;
	private long expireTime = 7 * 24 * 3600 * 1000;

	private JPushClient push;

	@Override
	public void beginNotify(String appType) throws Exception {
		appId = Constants.PUSH_APP_ID;
		appKey = Constants.PUSH_APP_KEY;
		masterSecret = Constants.PUSH_MASTER_SECRET;
		
		push = new JPushClient(masterSecret, appKey, 3);
	}

	@Override
	public void endNotify() throws Exception {
		
	}

	@Override
	public void nofity(PushVo pushVo) throws Exception {
		try {
			String title = pushVo.getContent();
			if (StringUtils.isNotBlank(title) && title.length() > 60) {
				title = title.substring(0, 60) + "....";
			}
			Map<String, String> params = new HashMap<String, String>();
			JSONObject json = JSONObject.fromObject(pushVo);
			for(@SuppressWarnings("unchecked")
			Iterator<String> iterator = json.keys(); iterator.hasNext();){
				String key = iterator.next();
				params.put(key, json.get(key).toString());
			}
			PushPayload payload = PushPayload.newBuilder()
            .setPlatform(Platform.android())
            .setAudience(Audience.alias(pushVo.getnToken()))
            .setNotification(Notification.newBuilder()
                    .addPlatformNotification(AndroidNotification.newBuilder()
                            .setAlert(title)
                            .addExtras(params)
                            .build())
                    .build())
             .setMessage(Message.content(pushVo.getContent()))
             .setOptions(Options.newBuilder()
                     .setApnsProduction(true)
                     .build())
             .build();
			push.sendPush(payload);
		} catch (Throwable e) {
			logger.error("android alias["+pushVo.getnToken()+"] push message fail", e);
		}
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

}
