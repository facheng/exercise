package com.dt.tarmag.convert;

import java.util.HashMap;
import java.util.LinkedHashMap;

import org.apache.commons.lang.StringUtils;

public class ViewTransfer {

	private static Object initLock = new Object();

	public static HashMap<String,String> HOUSE_STATUS_MEMO = null;

	public static HashMap<String,String> initStatusMemo() {
		if (HOUSE_STATUS_MEMO == null) {
			synchronized (initLock) {
				if (HOUSE_STATUS_MEMO == null) {
					HOUSE_STATUS_MEMO = new LinkedHashMap<String,String>();
					HOUSE_STATUS_MEMO.put("0", "自住");
					HOUSE_STATUS_MEMO.put("1", "空置");
					HOUSE_STATUS_MEMO.put("2", "待售");
					HOUSE_STATUS_MEMO.put("3", "出租");
					HOUSE_STATUS_MEMO.put("4", "待租");
				}
			}
		}
		return HOUSE_STATUS_MEMO;
	}

	public static String getHouseStatusMemo(String value) {
		if (StringUtils.isBlank(value)) {
			return "";
		}
		String desc = (String) initStatusMemo().get(value);
		if (desc == null) {
			desc = "";
		}
		return desc;
	}

}
