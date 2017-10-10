package com.dt.framework.web.vo;

import org.apache.commons.lang.StringUtils;

import com.dt.framework.util.TextUtil;

public class Success extends MsgResponse {

	private static final long serialVersionUID = 1L;

	public Success() {
		super();
		this.setStatus(STATUS_SUCCESS);
	}
	
	public Success(String msg){
		this();
		String message = TextUtil.getText(msg);
		this.setMsg(StringUtils.isBlank(message)?msg:message);
	}
	
	public Success(String key, Object value){
		super(key, value);
		this.setStatus(STATUS_SUCCESS);
	}
}
