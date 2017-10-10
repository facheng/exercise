package com.dt.tarmag;


/**
 * @author wei
 **/
public class AdminConstants extends Constants {
	/**
	 * 定时程序开关
	 */
	public static boolean OPEN_SCHEDULE = false;
	
	static{
		OPEN_SCHEDULE = Boolean.parseBoolean(pro.getProperty("OPEN_SCHEDULE"));
	}
}
