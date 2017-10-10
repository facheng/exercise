package com.dt.tarmag.model;

import java.util.Date;



/**
 * APP版本修改内容
 * @author yuwei
 * @Time 2015-6-27下午05:37:42
 */
public class AppVersionContent implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1798208346000026258L;
	private long id;
	private long recId;
	private String content;
	private Date createTime;
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getRecId() {
		return recId;
	}
	public void setRecId(long recId) {
		this.recId = recId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
