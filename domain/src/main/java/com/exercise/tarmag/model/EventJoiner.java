package com.dt.tarmag.model;


import java.util.Date;


/**
 * 活动报名者
 * @author yuwei
 * @Time 2015-7-6下午03:58:48
 */
public class EventJoiner implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4074603219063679107L;
	private long id;
	private long eventId;
	private long joinerId;
	private Date createTime;
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getEventId() {
		return eventId;
	}
	public void setEventId(long eventId) {
		this.eventId = eventId;
	}
	public long getJoinerId() {
		return joinerId;
	}
	public void setJoinerId(long joinerId) {
		this.joinerId = joinerId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
