package com.dt.framework.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import net.sf.json.JSONObject;

public class BeanUtil {

	/**
	 * 属性拷贝 将一个对象中不为空的属性拷贝到另外一个对象里面
	 * 
	 * @param src
	 *            原始对象
	 * @param dist
	 *            目标对象
	 * @param continues
	 *            需要跳过的字段
	 * 
	 */
	@SuppressWarnings("all")
	public static void copyProperty(Object src, Object dist,
			String... continues) {
		copyProperty(src, dist, true, continues);
	}

	/**
	 * 属性拷贝 将一个对象中不为空的属性拷贝到另外一个对象里面
	 * 
	 * @param src
	 *            原始对象
	 * @param dist
	 *            目标对象
	 * @param isFilter
	 *            是否需要虑过空值拷贝
	 * @param continues
	 *            需要跳过的字段
	 * 
	 */
	@SuppressWarnings("all")
	public static void copyProperty(Object src, Object dist, boolean isFilter,
			String... continues) {
		JSONObject srcJson = JSONObject.fromObject(src,
				JSONConfig.getDefaultConfig(isFilter));
		List<String> continueFields = continues == null ? new ArrayList<String>()
				: Arrays.asList(continues);
		for (Iterator<String> iterator = srcJson.keys(); iterator.hasNext();) {
			String key = iterator.next();
			if (continueFields.contains(key))
				continue;
			ClassUtils.set(dist, key, ClassUtils.get(src, key));
		}
	}
}
