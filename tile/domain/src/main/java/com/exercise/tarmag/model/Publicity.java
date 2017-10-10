package com.dt.tarmag.model;


import com.dt.framework.model.DtModel;


/**
 * 宣传
 * @author yuwei
 * @Time 2015-7-6下午06:09:13
 */
public class Publicity extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7716988666295050075L;
	private String title;
	private String content;
	private long unitId;
	
	
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
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
}
