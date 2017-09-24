package com.dt.tarmag.model;


import com.dt.framework.model.DtModel;


/**
 * 公告
 * @author yuwei
 * @Time 2015-7-6下午05:07:43
 */
public class Broadcast extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -59515767688273205L;
	private String title;
	private String content;
	private long unitId;
	private byte fromType;
	

	/**
	 * 公告类别——————物业
	 */
	public final static byte FROM_TYPE_PROPERTY = 0;
	/**
	 * 公告类别——————居委会
	 */
	public final static byte FROM_TYPE_COMMITTEE = 1;
	
	
	public String getFromTypeName(){
		byte _type = getFromType();
		if(_type == FROM_TYPE_PROPERTY) {
			return "物业";
		}
		if(_type == FROM_TYPE_COMMITTEE) {
			return "居委会";
		}
		return "";
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
	public byte getFromType() {
		return fromType;
	}
	public void setFromType(byte fromType) {
		this.fromType = fromType;
	}
}
