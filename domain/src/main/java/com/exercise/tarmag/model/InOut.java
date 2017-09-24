package com.dt.tarmag.model;


import com.dt.framework.model.DtModel;


/**
 * 出入记录表
 * @author yuwei
 * @Time 2015-7-24下午02:18:52
 */
public class InOut extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1789273746133167001L;
	private long unitId;
	private long residentId;
	private long keyDeviceId;
	private int clickTimes;
	
	
	public long getResidentId() {
		return residentId;
	}
	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}
	public long getKeyDeviceId() {
		return keyDeviceId;
	}
	public void setKeyDeviceId(long keyDeviceId) {
		this.keyDeviceId = keyDeviceId;
	}
	public int getClickTimes() {
		return clickTimes;
	}
	public void setClickTimes(int clickTimes) {
		this.clickTimes = clickTimes;
	}
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
}
