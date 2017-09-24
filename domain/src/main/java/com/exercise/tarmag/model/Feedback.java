package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * 用户反馈信息
 * @author yuwei
 * @Time 2015-7-17下午01:11:37
 */
public class Feedback extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1464766975034902236L;
	private String message;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
