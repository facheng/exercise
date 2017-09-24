/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

/**
 * @author raymond
 *
 */
public class Params<K, V> extends HashMap<K, V> {

	private static final long serialVersionUID = 1L;

	public static Params<String, Object> getParams() {
		return new Params<String, Object>();
	}

	public static Params<String, Object> getParams(String key, Object value) {
		return getParams().add(key, value);
	}

	public static Params<String, Object> getParams(Object... keyValues) {
		Params<String, Object> params = getParams();
		if (keyValues != null) {
			if (keyValues.length % 2 != 0) {
				throw new RuntimeException(
						"Keys's size must be equal values's size!");
			}
			for (int i = 0; i < keyValues.length; i += 2) {
				params.add((String) keyValues[i], keyValues[i + 1]);
			}
		}
		return params;
	}

	public static Params<String, Object> getParams(String[] keys,
			Object[] values) {
		Params<String, Object> params = getParams();
		if (keys != null && values != null) {
			if (keys.length != values.length)
				throw new RuntimeException(
						"Keys's size must be equal values's size!");
			for (int i = 0; i < keys.length; i++) {
				params.add(keys[i], values[i]);
			}
		}
		return params;
	}

	public static Params<String, Object> getParams(Map<String, Object> params) {
		return getParams().addAll(params);
	}

	public Params<K, V> add(K key, V value) {
		this.put(key, value);
		return this;
	}

	public Params<K, V> addAll(Map<K, V> params) {
		this.putAll(params);
		return this;
	}

	public Params<K, V> filterEmpty() {
		List<K> removeKeys = new ArrayList<K>();
		for (K key : this.keySet()) {
			V value = this.get(key);
			if (value == null
					|| StringUtils.isBlank(value.toString())
					|| (value.toString().matches("\\d*[.]?\\d*") && Float
							.valueOf(value.toString()) == 0.0f)) {
				removeKeys.add(key);
			}
		}
		for (K key : removeKeys) {
			this.remove(key);
		}
		return this;
	}
}
