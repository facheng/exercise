package com.dt.framework.web.vo;

import org.apache.commons.lang.StringUtils;

import com.dt.framework.util.TextUtil;

public class Fail extends MsgResponse {

	private static final long serialVersionUID = 1L;

	public Fail() {
		super();
		this.setStatus(STATUS_FAIL);
	}

	public Fail(String msg){
		this();
		String message = TextUtil.getText(msg);
		this.setMsg(StringUtils.isBlank(message)?msg:message);
	}
	
	
	public Fail(String key, Object value){
		super(key, value);
		this.setStatus(STATUS_FAIL);
	}
}
