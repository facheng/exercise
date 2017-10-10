package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * 车辆信息
 * @author yuwei
 * @Time 2015-7-30下午01:21:48
 */
public class Car extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6524965314305639342L;
	private long residentId;
	private String plateNo;
	
	
	public long getResidentId() {
		return residentId;
	}
	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}
	public String getPlateNo() {
		return plateNo;
	}
	public void setPlateNo(String plateNo) {
		this.plateNo = plateNo;
	}
}
