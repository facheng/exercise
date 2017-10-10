package com.dt.tarmag.model;


import java.util.Date;

import com.dt.framework.model.DtModel;


/**
 * 快递
 * @author yuwei
 * @Time 2015-7-8下午07:29:45
 */
public class ExpressDelivery extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6900715274565313046L;
	private String title;
	private String content;
	private long unitId;
	private long houseId;
	private long receiverId;
	private Date reveiveTime;
	
	
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
	public long getHouseId() {
		return houseId;
	}
	public void setHouseId(long houseId) {
		this.houseId = houseId;
	}
	public long getReceiverId() {
		return receiverId;
	}
	public void setReceiverId(long receiverId) {
		this.receiverId = receiverId;
	}
	public Date getReveiveTime() {
		return reveiveTime;
	}
	public void setReveiveTime(Date reveiveTime) {
		this.reveiveTime = reveiveTime;
	}
}
