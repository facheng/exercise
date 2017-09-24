package com.dt.tarmag.model;


import com.dt.framework.model.DtSimpleModel;


/**
 * 住户、小区和钥匙的绑定关系
 * @author yuwei
 * @Time 2015-7-24下午01:58:06
 */
public class ResidentUnitKey extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3804549907406810551L;
	private long residentUnitId;
	private long keyDeviceId;
	
	
	public long getResidentUnitId() {
		return residentUnitId;
	}
	public void setResidentUnitId(long residentUnitId) {
		this.residentUnitId = residentUnitId;
	}
	public long getKeyDeviceId() {
		return keyDeviceId;
	}
	public void setKeyDeviceId(long keyDeviceId) {
		this.keyDeviceId = keyDeviceId;
	}
}
