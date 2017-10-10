package com.dt.tarmag.model;


import com.dt.framework.model.DtModel;


/**
 * 通知
 * @author yuwei
 * @Time 2015-7-6下午06:03:58
 */
public class Notice extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4614881560969916460L;
	private String title;
	private String content;
	private long unitId;
	private byte fromType;
	private byte toType;
	

	/**
	 * 通知类别——————物业
	 */
	public final static byte FROM_TYPE_PROPERTY = 0;
	/**
	 * 通知类别——————居委会
	 */
	public final static byte FROM_TYPE_COMMITTEE = 1;
	

	/**
	 * 通知接收者类型——————业主+租客
	 */
	public final static byte TO_TYPE_ALL = 0;
	/**
	 * 通知接收者类型——————业主
	 */
	public final static byte TO_TYPE_OWNER = 1;
	/**
	 * 通知接收者类型——————租客
	 */
	public final static byte TO_TYPE_RENTER = 2;

	
	
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
	
	
	public String getToTypeName(){
		byte _type = getToType();
		if(_type == TO_TYPE_ALL) {
			return "业主+租客";
		}
		if(_type == TO_TYPE_OWNER) {
			return "业主";
		}
		if(_type == TO_TYPE_RENTER) {
			return "租客";
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
	public byte getToType() {
		return toType;
	}
	public void setToType(byte toType) {
		this.toType = toType;
	}
}
