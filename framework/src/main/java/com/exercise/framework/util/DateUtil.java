package com.dt.framework.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * @author wei
 *
 */
public class DateUtil {
	public static final String PATTERN_YM = "yyyy-MM";
	public static final String PATTERN_DATE = "yyyy-MM-dd";
	public static final String PATTERN_DATE_T_TIME = "yyyy-MM-dd'T'HH:mm:ss";
	public static final String PATTERN_DATE_TIME = "yyyy-MM-dd HH:mm:ss";
	public static final String PATTERN_YMD = "yyyy/MM/dd";
	public static final String PATTERN_DATE_TIME_FILENAME = "yyyyMMddHHmmss";

	public final static SimpleDateFormat format = new SimpleDateFormat(PATTERN_YMD);
	public final static int UNIT_DAY = 1;
	public final static int UNIT_WEEK = 2;
	public final static int UNIT_MONTH = 3;
	public final static int UNIT_YEAR = 4;

	public static int getCurYear() {
		Calendar cal = Calendar.getInstance();
		return cal.get(Calendar.YEAR);
	}

	public static String formatDate(Date date) {
		return format.format(date);
	}

	public static Date parseDate(String dateStr, String pattern) {
		DateFormat df = new SimpleDateFormat(pattern);
		try {
			return df.parse(dateStr);
		} catch (ParseException e) {
			throw new RuntimeException(e.getLocalizedMessage());
		}
	}

	public static String formatDate(Date date, String pattern) {
		return new SimpleDateFormat(pattern).format(date);
	}

	public static Date getDateOffset(Date date, int offset, int unit) {
		Calendar cal = new GregorianCalendar();
		cal.setTime(date);
		if (offset != 0) {
			switch (unit) {
			case UNIT_DAY:
				cal.add(Calendar.DAY_OF_YEAR, offset);
				break;
			case UNIT_WEEK:
				cal.add(Calendar.WEEK_OF_YEAR, offset);
				break;
			case UNIT_MONTH:
				cal.add(Calendar.MONTH, offset);
				break;
			case UNIT_YEAR:
				cal.add(Calendar.YEAR, offset);
				break;
			}
		}
		return cal.getTime();
	}

	public static int getYear(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.get(Calendar.YEAR);
	}

	public static int getMonth(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.get(Calendar.MONTH) + 1;
	}

	public static int getDay(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.get(Calendar.DAY_OF_MONTH);
	}

	public static int getHour(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.get(Calendar.HOUR_OF_DAY);
	}

	public static int getMinute(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.get(Calendar.MINUTE);
	}

	public static Date getNextDay(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		return calendar.getTime();
	}

	public static Date getStartOfDate(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}

	public static Date getLastSecOfDate(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 59);
		calendar.set(Calendar.SECOND, 59);
		return calendar.getTime();
	}

	/**
	 * 获取时间 dd HH:mm:ss
	 * 
	 * @param time
	 * @return
	 */
	public static long getTime(String time) {
		long msec = 0l;
		if (StringUtils.isNotBlank(time) && time.matches("\\d+[dDhHmMsS]")) {
			char unit = time.substring(time.length() - 1).toLowerCase()
					.charAt(0);
			time = time.substring(0, time.length() - 1);
			msec = Long.valueOf(time) * 1000;// 转换成秒
			if (unit <= 'm') {
				msec *= 60;
			}
			if (unit <= 'h') {
				msec *= 60;
			}
			if (unit <= 'd') {
				msec *= 24;
			}
		} else if (time.matches("\\d+")) {
			msec = Long.valueOf(time);
		}
		return msec;
	}
}
