package com.dt.framework.util;


import java.util.List;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class CommonUtil {
	private final static String[] strs = {"A", "B", "C", "D", "E", "F", "G"
											, "H", "I", "J", "K", "L", "M", "N"
											, "O", "P", "Q", "R", "S", "T"
											, "U", "V", "W", "X", "Y", "Z"
											, "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
    
    public static boolean isEmail(String email) {
    	if (email == null || email.trim().equals("")) {
            return false;
        }
        String regex = "\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(email);
        return m.find();
    }

	
	public static String getRandCode(int length) {
		Random random = new Random();
		StringBuffer buf = new StringBuffer("");
		for (int i = 0; i < length; i++){  
			buf.append(strs[random.nextInt(strs.length)]);
		}
		return buf.toString();
	}

    public static boolean isMobile(String mobile) {
    	if (mobile == null || mobile.trim().equals("")) {
            return false;
        }
        Pattern p = Pattern.compile("^[1][3-8]\\d{9}$");
        Matcher m = p.matcher(mobile);
        return m.find();
	}
    
    public static boolean isPhone(String phone) {
    	if (phone == null || phone.trim().equals("")) {
            return false;
        }
        Pattern p = Pattern.compile("^[\\d]{5,20}$");
        Matcher m = p.matcher(phone);
        return m.find();
	}
	
	/**
	 * 按指定长度截取字符串(一个汉字相当于两个字符)，超过的以省略号代替
	 * @param str
	 * @param len
	 * @return
	 */
	public static String cutString(String str, int len){
		if(str == null || str.length() <= 0 || len <= 0) return "";
		
		StringBuffer buf = new StringBuffer("");
		int count = 0;
		for(int i=0; i<str.length(); i++){
			char c = str.charAt(i);
			count += isChineseChar(c) ? 2 : 1;
			
			if(count > len){
				buf.append("......");
				break;
			}
			buf.append(c);
		}
		
		return buf.toString();
	}
	
	/**
	 * 以纯文本形式显示时的过滤逻辑
	 * @param str
	 * @return
	 */
	public static String escape(String str){
		if(str == null || str.length() <= 0) return "";
		
		return str.trim().replace("<", "&lt;").replace(">", "&gt;").replace("\"", "\\\"").replace("\r\n", "<br/>").replace("\n", "<br/>");
	}
	
	/**
	 * 需要显示html标签时的过滤逻辑
	 * @param str
	 * @return
	 */
	public static String escape2(String str){
		if(str == null || str.length() <= 0) return "";
		
		return str.trim().replace("\"", "\\\"").replace("\r\n", "<br/>").replace("\n", "<br/>");
	}
	
	public static boolean isChineseChar(char c){
		return Character.isLetter(c) && c>255;
	}
	/**
     * 数组array中是否包含元素t
     *
     * @param array
     * @param n
     * @return
     */
    public static boolean exists(Integer[] array, int n) {
        if (array == null || array.length <= 0) return false;
        for (int _n : array) {
            if (n == _n) {
                return true;
            }
        }
        return false;
    }
    
    public static boolean exists(List<String> list, String str){
    	if (list == null || str == null) {
        	throw new RuntimeException();
        }
    	
    	for(String astr : list){
    		if(astr.trim().equals(str.trim())) {
    			return true;
    		}
    	}
    	return false;
    }

}
