package com.dt.framework.util;

import java.util.Date;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;
import net.sf.json.util.PropertyFilter;

public class JSONConfig extends JsonConfig {

	public JSONConfig registerJsonValueProcessor(Class<?>... propertyTypes) {
		for (Class<?> propertyType : propertyTypes) {
			this.registerJsonValueProcessor(propertyType,
					new TypeJsonValueProcessor());
		}
		return this;
	}

	public static JSONConfig registerJsonDateProcessor() {
		return new JSONConfig().registerJsonValueProcessor(Date.class,
				java.sql.Date.class);
	}

	public static JSONConfig registerJsonProcessor(Class<?>... propertyTypes) {
		return new JSONConfig().registerJsonValueProcessor(propertyTypes);
	}

	public static JSONConfig getDefaultConfig() {
		return getDefaultConfig(false);
	}

	public static JSONConfig getDefaultConfig(boolean isFilter) {
		JSONConfig jsonConfig = new JSONConfig();
		if (isFilter) {
			jsonConfig.setJsonPropertyFilter(new PropertyFilter() {
				public boolean apply(Object object, String fieldName,
						Object fieldValue) {
					return null == fieldValue
							|| StringUtils.isBlank(fieldValue.toString())
							|| (fieldValue.toString().matches("\\d*[.]?\\d+") && Float
									.parseFloat(fieldValue.toString()) == 0.0f);
				}
			});
		}
		jsonConfig.registerJsonValueProcessor(Integer.class, Long.class,
				Short.class, Byte.class, Date.class, Double.class, Float.class,
				java.sql.Date.class);
		return jsonConfig;
	}

	public class TypeJsonValueProcessor implements JsonValueProcessor {

		@Override
		public Object processArrayValue(Object value, JsonConfig config) {
			return value;
		}

		@Override
		public Object processObjectValue(String key, Object value,
				JsonConfig config) {
			String result = StringUtils.EMPTY;
			if (value != null) {
				if (value instanceof Date) {
					result = DateUtil.formatDate((Date) value,
							DateUtil.PATTERN_DATE_TIME);
				} else if (value instanceof Byte || value instanceof Short
						|| value instanceof Integer || value instanceof Long) {
					if (Long.parseLong(value.toString()) != 0l) {
						result = value.toString();
					}
				} else if (value instanceof Float || value instanceof Double) {
					if (Float.parseFloat(value.toString()) != 0.0f) {
						result = value.toString();
					}
				} else {
					result = value.toString();
				}
			}
			return result;
		}
	}
}
