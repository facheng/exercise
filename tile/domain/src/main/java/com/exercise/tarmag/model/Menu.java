package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * 功能菜单
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class Menu extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4324300440611509448L;
	private long parentId;
	private String url;
	private String title;
	private String code;
	private int seq;
	
	
	public long getParentId() {
		return parentId;
	}
	public void setParentId(long parentId) {
		this.parentId = parentId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
}
