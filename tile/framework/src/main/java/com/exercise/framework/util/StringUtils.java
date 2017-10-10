package com.dt.framework.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 对于org.apache.commons.lang.StringUtils拓展
 * 
 * @author raymond
 *
 */
public class StringUtils extends org.apache.commons.lang.StringUtils {

	/**
	 * 将userName==》USER_NAME
	 * 
	 * @param fieldName
	 *            属性名
	 * @return
	 */
	public static String field2ColumnName(String fieldName) {
		if (fieldName.indexOf("_") != -1)//如果包含下划线，认为该名字为字段名
			return fieldName;
		Matcher matcher = Pattern.compile("[A-Z]").matcher(fieldName);
		StringBuffer columnBuf = new StringBuffer(fieldName);
		int index = 0;// 定位大写字母在bug中的位置
		while (matcher.find()) {
			int start = matcher.start();
			if (start == 0)
				continue;
			columnBuf.insert(start + index, '_');
			index++;
		}
		return columnBuf.toString().toUpperCase();
	}

	/**
	 * 将USER_NAME==》userName
	 * 
	 * @param columnName
	 *            字段名
	 * @return
	 */
	public static String column2FieldName(String columnName) {
		if (columnName.indexOf("_") == -1)//如果不包含下划线，默认该名字为属性名
			return columnName;
		Matcher matcher = Pattern.compile("(\\_)([a-z])").matcher(
				columnName.toLowerCase());
		StringBuffer fieldBuf = new StringBuffer(columnName.toLowerCase());
		int index = 0;
		while (matcher.find()) {
			int start = matcher.start();
			int end = matcher.end();
			String replaceStr = matcher.group(2).toUpperCase();
			if (start == 0) {
				replaceStr = replaceStr.toLowerCase();
			}
			fieldBuf.replace(start + index, end + index, replaceStr);
			index--;
		}
		return fieldBuf.toString();
	}
	
	/**
	 * 
	 * @param count
	 * @return
	 */
	public static String replenish(int count, char character){
		StringBuffer result = new StringBuffer();
		while(count>0){
			result.append(character);
			count --;
		}
		return result.toString();
	}

}
