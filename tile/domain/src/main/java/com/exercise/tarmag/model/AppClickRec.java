package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * APP点击记录
 * @author yuwei
 * @Time 2015-7-17下午01:14:18
 */
public class AppClickRec extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4515489052745866457L;
	private byte type;
	private long typeId;
	

	/**
	 * 被点击的功能类别(点击率)
	 */
	public final static byte TYPE_CLICK_RATE = 1;
	/**
	 * 被点击的功能类别(转换率)
	 */
	public final static byte TYPE_TRANSFORM_RATE = 2;
	
	

	public byte getType() {
		return type;
	}

	public void setType(byte type) {
		this.type = type;
	}

	public long getTypeId() {
		return typeId;
	}

	public void setTypeId(long typeId) {
		this.typeId = typeId;
	}
}
