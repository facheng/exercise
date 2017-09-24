/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.util;

import java.util.Date;
import java.util.Map;

import com.dt.framework.util.DateUtil;

/**
 * @author 👤wisdom 
 *
 */
public class DateUtils {
	/**
	 * 处理创建日期 用于快递 通知 公告接口
	 * @param expressdelivery
	 */
	public static void disposeCreateDateTime(Map<String, Object> expressdelivery){
		Object time = expressdelivery.get("createDateTime");
		if(time instanceof Date){
			Date ceateDateTime = (Date)time;
			if (DateUtil.formatDate(new Date(), "yyyyMMdd").equals(DateUtil.formatDate(ceateDateTime, "yyyyMMdd"))) {
				time = "今天" + DateUtil.formatDate(ceateDateTime, " HH:mm");
			} else {
				time = DateUtil.formatDate(ceateDateTime, "yyyy年MM月dd日 HH:mm");
			}
		}
		expressdelivery.put("time", time);
	}
}
