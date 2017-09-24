package com.dt.framework.web.vo;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;

import com.dt.framework.util.ActionUtil;

/**
 * 返回值封装
 * 
 * @author jason
 *
 */
public class MsgResponse implements Serializable {

	private static final long serialVersionUID = 570540595877281047L;

	protected static final int STATUS_SUCCESS = 1;
	protected static final int STATUS_FAIL = 0;
	public static boolean IS_DEBUGGER = false;
	/**
	 * 返回码 0 成功 1 失败
	 */
	private int status;
	/**
	 * 提示信息
	 */
	private String msg;

	/**
	 * 请求参数
	 */
	private String request;

	/**
	 * 返回信息
	 */
	private Map<String, Object> data = new HashMap<String, Object>();

	public MsgResponse() {
		if (IS_DEBUGGER) {
			String uri = ActionUtil.getRequest().getRequestURI();
			this.request = uri + ":"
					+ ActionUtil.getRequest().getAttribute(uri);
		} else {
			this.request = StringUtils.EMPTY;
		}
	}
	
	public MsgResponse(Map<String, Object> data){
		this();
		this.data = data;
	}

	public MsgResponse(String key, Object value) {
		this();
		this.put(key, value);
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getData() {
		return this.data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}

	/**
	 * 添加数据 keys eg: a.b.c 数据层级{a={b={c=2}}}
	 * 
	 * @param keys
	 * @param value
	 */
	@SuppressWarnings("unchecked")
	public MsgResponse put(String keys, Object value) {
		Map<String, Object> val = this.data;
		String[] keyArray = keys.split("\\.");
		for (int i = 0; i < keyArray.length; i++) {
			String key = keyArray[i];
			if (i == keyArray.length - 1) {
				val.put(key, value);
				break;
			}
			if (val.containsKey(key)) {
				val = (Map<String, Object>) val.get(key);
			} else {
				Map<String, Object> newData = new HashMap<String, Object>();
				val.put(key, newData);
				val = newData;
			}
		}
		return this;
	}

	/**
	 * 根据key获取数据
	 * 
	 * @param keys
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Object get(String keys) {
		Map<String, Object> val = this.data;
		Object value = null;
		String[] keyArray = keys.split("\\.");
		for (int i = 0; i < keyArray.length; i++) {
			value = val.get(keyArray[i]);
			if (i < keyArray.length - 1) {
				val = (Map<String, Object>) value;
			}
		}
		return value;
	}

	/**
	 * 添加数据
	 * 
	 * @param data
	 */
	public void putAll(Map<String, Object> data) {
		this.data.putAll(data);
	}

	/**
	 * 清除数据
	 */
	public void clear() {
		this.data.clear();
	}

	public String getRequest() {
		return request;
	}

	public void setRequest(String request) {
		this.request = request;
	}

	@Override
	public String toString() {
		return JSONObject.fromObject(this).toString();
	}
}
