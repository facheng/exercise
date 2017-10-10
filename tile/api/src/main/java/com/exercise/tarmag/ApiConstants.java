package com.dt.tarmag;


/**
 * @author wei
 **/
public class ApiConstants extends Constants{
	public static boolean IS_DEBUGGER = false;
	public static String QR_CODE_LOGO_URL;
	
	static{
		IS_DEBUGGER = pro.containsKey("IS_DEBUGGER");
		QR_CODE_LOGO_URL = pro.getProperty("QR_CODE_LOGO_URL");
	}
}
