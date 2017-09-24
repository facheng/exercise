package com.dt.tarmag.model;


import java.util.Date;

import com.dt.framework.model.DtModel;


/**
 * 活动
 * @author yuwei
 * @Time 2015-7-6下午03:51:38
 */
public class Event extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1996005871842765802L;
	private String title;
	private String content;
	private Date eventTime;
	private String position;
	private int expectedCount;
	private int consumption;
	private String gatherPosition;
	private Date gatherTime;
	
	
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
	public Date getEventTime() {
		return eventTime;
	}
	public void setEventTime(Date eventTime) {
		this.eventTime = eventTime;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public int getExpectedCount() {
		return expectedCount;
	}
	public void setExpectedCount(int expectedCount) {
		this.expectedCount = expectedCount;
	}
	public int getConsumption() {
		return consumption;
	}
	public void setConsumption(int consumption) {
		this.consumption = consumption;
	}
	public String getGatherPosition() {
		return gatherPosition;
	}
	public void setGatherPosition(String gatherPosition) {
		this.gatherPosition = gatherPosition;
	}
	public Date getGatherTime() {
		return gatherTime;
	}
	public void setGatherTime(Date gatherTime) {
		this.gatherTime = gatherTime;
	}
}
