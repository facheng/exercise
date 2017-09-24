package com.dt.tarmag.push.notifier;

import javapns.back.PushNotificationManager;
import javapns.back.SSLConnectionHelper;
import javapns.data.Device;
import javapns.data.PayLoad;

import org.apache.commons.lang.StringUtils;

import com.dt.tarmag.Constants;
import com.dt.tarmag.model.DeviceManage;
import com.dt.tarmag.vo.PushVo;

public class IosNotifier implements INotifier{
	private String host = "gateway.sandbox.push.apple.com"; // 测试用的苹果推送服务器
//	private String host = "gateway.push.apple.com"; // 正式用的苹果推送服务器
	private int port = 2195;
	private String certificatePath = "D:/doubletuan/cer/iwing_dev_push.p12"; // 刚才在mac系统下导出的证书       测试
//	private String certificatePath = "D:/doubletuan/cer/zs/iwing_dist_push.p12"; // 刚才在mac系统下导出的证书      正式
	private String certificatePassword = "123456";
	
	private PushNotificationManager pushManager;

	@Override
	public void beginNotify(String appType) throws Exception {
		pushManager = PushNotificationManager.getInstance();
		host = Constants.PUSH_IOS_HOST;
		port = Constants.PUSH_IOS_PORT;
		if(DeviceManage.APP_TYPE_IWING.equals(appType)){//i家园环境
			certificatePath = Constants.PUSH_IOS_IWING_CERTIFICATEPATH;
			certificatePassword = Constants.PUSH_IOS_IWING_CERTIFICATEPASSWORD;
		}
		pushManager.initializeConnection(host, port, certificatePath,
				certificatePassword, SSLConnectionHelper.KEYSTORE_TYPE_PKCS12);
	}

	@Override
	public void endNotify() throws Exception {
		pushManager.stopConnection();
		pushManager = null;
	}

	@Override
	public void nofity(PushVo pushVo) throws Exception {
		try {
			PayLoad payLoad = new PayLoad();
			String content = pushVo.getContent();
			if(StringUtils.isNotBlank(content)&&content.length()>60){
				content = content.substring(0,60) + "....";
			}
			payLoad.addAlert(content);
			payLoad.addBadge(1);
			payLoad.addSound("default");
			//payLoad.addCustomDictionary("noticeId", msg.getId());
			payLoad.addCustomDictionary("type", pushVo.getType());//推送的类型
			pushManager.addDevice(pushVo.getDeviceModel(), pushVo.getnToken());
			Device client = pushManager.getDevice(pushVo.getDeviceModel());
			pushManager.sendNotification(client, payLoad); // 推送消息
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(pushManager!=null){
				try {
					pushManager.stopConnection();
				} catch (Exception e) {
					e.printStackTrace();
				}finally{
					pushManager.removeDevice(pushVo.getDeviceModel());
				}
			}
		}
		
	}
}
