package com.dt.framework.util;

import java.util.regex.Pattern;

public class Validator {
	
	/**匹配email地址*/
	public final static String REGEX_EMAIL = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
	
	/**
	 * 手机号码匹配
	 */
	public final static String REGEX_PHONE_NUM = "^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$";
	
	/**
	 * 电话号码
	 */
	public final static String REGEX_CELL_PHONE_NUM = "^(\\(\\d{3,4}-)|\\d{3.4}-)?\\d{7,8}$";
	
	public final static boolean isPhoneNum(String phoneNum){
		return isMatches(REGEX_PHONE_NUM, phoneNum);
	}
	
	public final static boolean isEmail(String email){
		return isMatches(REGEX_EMAIL, email);
	}
	
	public final static boolean isCellPhone(String cellPhone){
		return isMatches(REGEX_CELL_PHONE_NUM, cellPhone);
	}
	
	protected static boolean isMatches(String regex, String str){
		return Pattern.compile(REGEX_PHONE_NUM).matcher(str).find();
	}
}

