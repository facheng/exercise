package com.dt.tarmag.vo;



/**
 * @author yuwei
 * @Time 2015-7-9下午05:39:25
 */
public class BroadcastVo {
	private byte fromType;
	private String title;
	private String content;
	private long unitId;
	
	
	public byte getFromType() {
		return fromType;
	}
	public void setFromType(byte fromType) {
		this.fromType = fromType;
	}
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
