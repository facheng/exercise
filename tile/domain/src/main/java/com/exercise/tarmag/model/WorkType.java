package com.dt.tarmag.model;


import com.dt.framework.model.DtModel;


/**
 * 工种
 * @author yuwei
 * @Time 2015-7-17下午03:32:21
 */
public class WorkType extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4161220721312115592L;
	private String name;
	private byte type;
	

	/**
	 * 类型(保安)
	 */
	public final static byte TYPE_SECURIY = 1;
	/**
	 * 类型(保修)
	 */
	public final static byte TYPE_REPIAR = 2;
	
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public byte getType() {
		return type;
	}
	public void setType(byte type) {
		this.type = type;
	}
}
