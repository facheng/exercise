package com.dt.tarmag.model;


import java.util.Date;

import com.dt.framework.model.DtSimpleModel;


/**
 * 报修的评论
 * @author yuwei
 * @Time 2015-7-19上午11:08:56
 */
public class RepairComment extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3608371891609333157L;
	private long repairId;
	private String content;
	private long residentId;
	private Date createTime;
	
	
	public long getRepairId() {
		return repairId;
	}
	public void setRepairId(long repairId) {
		this.repairId = repairId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public long getResidentId() {
		return residentId;
	}
	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
