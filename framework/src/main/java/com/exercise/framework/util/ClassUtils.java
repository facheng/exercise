package com.dt.framework.util;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class ClassUtils {
	/**
	 * 存放类与属性关系
	 */
	private transient static Map<Class<?>, Map<String, Field>> fieldsMap = new HashMap<Class<?>, Map<String,Field>>(); 
	
	public static Collection<Field> getFields(Class<?> modelClass) {
		Collection<Field> fields = null;
		if (!fieldsMap.containsKey(modelClass)) {// 如果不存在 将对象属性加入到集合中
			fields = getDeclaredFields(modelClass, true).values();
		}else{
			fields = fieldsMap.get(modelClass).values();
		}
		return fields;
	}
	

	/**
	 * @param thisClass
	 * @param isIgnore
	 *            是否忽略静态字段及存储字段
	 * @return
	 */
	public static Map<String, Field> getDeclaredFields(Class<?> thisClass, boolean isIgnore) {
		Map<String, Field> fieldsMap = new HashMap<String,Field>();
		for (Field field : thisClass.getDeclaredFields()) {
			// 忽略 final 及静态字段
			if (isIgnore &&( Modifier.isStatic(field.getModifiers())
					|| Modifier.isFinal(field.getModifiers()))) {
				continue;
			}
			fieldsMap.put(field.getName(), field);
		}
		Class<?> supperClass = thisClass.getSuperclass();
		if (supperClass != null) {
			fieldsMap.putAll(getDeclaredFields(supperClass, isIgnore));
		}
		return fieldsMap;
	}
	
	/**
	 * 根据属性获取属性值
	 * 
	 * @param field
	 * @return
	 */
	public static Object get(Object obj, Field field) {
		Object value = null;
		try {
			field.setAccessible(true);
			value = field.get(obj);
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		return value;
	}
	
	public static void set(Object obj, String fieldName, Object value){
		set(obj, getFiled(obj.getClass(), fieldName), value);
	}

	/**
	 * 根据属性设置属性值
	 * 
	 * @param field
	 * @return
	 */
	public static void set(Object obj, Field field, Object value) {
		try {
			if(field == null) return;
			field.setAccessible(true);
			field.set(obj, value);
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据属性名获取属性对象
	 * 
	 * @param thisClass
	 * @param fieldName
	 * @return
	 */
	public static Field getFiled(Class<?> thisClass, String fieldName) {
		if(!fieldsMap.containsKey(thisClass)){
			fieldsMap.put(thisClass, getDeclaredFields(thisClass, true));
		}
		return fieldsMap.get(thisClass).get(fieldName);
	}
	
	/**
	 * 根据属性名获取属性值
	 * 
	 * @param fieldName
	 * @return
	 */
	public static Object get(Object obj, String fieldName) {
		return get(obj, getFiled(obj.getClass(), fieldName));
	}


	public static boolean isNull(Object obj, Field field) {
		return get(obj, field) == null;
	}

	public static boolean isNull(Object obj, String fieldName) {
		return get(obj, fieldName) == null;
	}
}
