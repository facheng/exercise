package com.dt.tarmag.model;


import java.util.Date;

import com.dt.framework.model.DtSimpleModel;


/**
 * 住户和小区的绑定关系
 * @author yuwei
 * @Time 2015-7-24下午01:55:44
 */
public class ResidentUnit extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1597589232845658854L;
	private long residentId;
	private long unitId;
	private Date createTime;
	
	
	public long getResidentId() {
		return residentId;
	}
	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
