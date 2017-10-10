package com.dt.tarmag.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexMap<K, V> extends LinkedHashMap<K, V> {

	private static final long serialVersionUID = 1L;

	public List<V> get(String key, int num) {
		StringBuffer regexBuf = new StringBuffer(key);
		while (num > 0) {
			regexBuf.append(".");
			num--;
		}
		return this.get(regexBuf.toString());
	}

	public List<V> get(String keyRegex) {
		Matcher matcher = this.getMatcher(keyRegex);
		List<V> values = new ArrayList<V>();
		while (matcher.find()) {
			Object key = matcher.group(1);
			V v = this.get(key);
			if(v == null) continue;
			if (!values.contains(v))
				values.add(v);
		}
		return values;
	}

	protected String getKeys() {
		String keys = this.keySet().toString();
		return keys.substring(1, keys.length() - 1) + ",";
	}

	protected Matcher getMatcher(String regex) {
		return Pattern.compile("(" + regex + "),").matcher(this.getKeys());
	}

	public boolean contains(String keyRegex) {
		return this.getMatcher(keyRegex).find();
	}

	public int getMatches(String keyRegex) {
		int count = 0;
		Matcher matcher = this.getMatcher(keyRegex);
		while (matcher.find())
			count++;
		return count;
	}
}
