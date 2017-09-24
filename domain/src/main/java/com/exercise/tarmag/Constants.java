package com.dt.tarmag;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Constants {

	public static final String IMG_URL = "img";//图片上传路径
	public static final String TEMPLATE_URL = "template";//模板上传路径

	public static String DOMAIN_URL = "";
	public static String FILE_STORE_URL = "";
	public static String FILE_ACCESS_URL = "";
	
	public static String PUSH_IOS_HOST = "";
	public static int PUSH_IOS_PORT;
	public static String PUSH_IOS_IWING_CERTIFICATEPATH = "";
	public static String PUSH_IOS_IWING_CERTIFICATEPASSWORD = "";
	
	//android推送	
	public static String PUSH_ANDROID_HOST = "";
	public static String PUSH_APP_ID = "";
	public static String PUSH_APP_KEY = "";
	public static String PUSH_MASTER_SECRET = "";
	
	//邀约二维码路径
	public static String QR_CODE_URL = "";
	
	//云通信相关配置
	public static String CLOOPEN_SMS_HOST = "";
	public static String CLOOPEN_SMS_PORT = "";
	public static String CLOOPEN_SMS_ACCOUNT = "";
	public static String CLOOPEN_SMS_TOKEN = "";
	public static String CLOOPEN_SMS_APPID = "";
	
	protected static Properties pro = new Properties();
	static {
		InputStream is = Constants.class.getClassLoader().getResourceAsStream("constants.properties");
		try {
			pro.load(is);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	static {
		DOMAIN_URL = pro.getProperty("DOMAIN_URL");
		FILE_STORE_URL = pro.getProperty("FILE_STORE_URL");
		FILE_ACCESS_URL = pro.getProperty("FILE_ACCESS_URL");
		
		PUSH_IOS_HOST = pro.getProperty("PUSH_IOS_HOST");
		
		String iosPort = pro.getProperty("PUSH_IOS_PORT");
		if(iosPort != null) {
			PUSH_IOS_PORT = new Integer(iosPort);
		}
		PUSH_IOS_IWING_CERTIFICATEPATH = pro.getProperty("PUSH_IOS_IWING_CERTIFICATEPATH");
		PUSH_IOS_IWING_CERTIFICATEPASSWORD = pro.getProperty("PUSH_IOS_IWING_CERTIFICATEPASSWORD");
		
		PUSH_ANDROID_HOST = pro.getProperty("PUSH_ANDROID_HOST");
		PUSH_APP_ID = pro.getProperty("PUSH_APP_ID");
		PUSH_APP_KEY = pro.getProperty("PUSH_APP_KEY");
		PUSH_MASTER_SECRET = pro.getProperty("PUSH_MASTER_SECRET");
		QR_CODE_URL = pro.getProperty("QR_CODE_URL");
		
		CLOOPEN_SMS_HOST = pro.getProperty("CLOOPEN_SMS_HOST");
		CLOOPEN_SMS_PORT = pro.getProperty("CLOOPEN_SMS_PORT");
		CLOOPEN_SMS_ACCOUNT = pro.getProperty("CLOOPEN_SMS_ACCOUNT");
		CLOOPEN_SMS_TOKEN = pro.getProperty("CLOOPEN_SMS_TOKEN");
		CLOOPEN_SMS_APPID = pro.getProperty("CLOOPEN_SMS_APPID");
	}
}
