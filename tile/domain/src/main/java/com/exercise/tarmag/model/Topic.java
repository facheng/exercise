package com.dt.tarmag.model;


import com.dt.framework.model.DtModel;


/**
 * 话题
 * @author yuwei
 * @Time 2015-7-6下午02:43:04
 */
public class Topic extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7255681497922910398L;
	private String title;
	private String content;
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
