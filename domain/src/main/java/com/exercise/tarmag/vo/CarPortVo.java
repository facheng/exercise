package com.dt.tarmag.vo;



/**
 * @author yuwei
 * @Time 2015-7-30下午02:51:28
 */
public class CarPortVo {
	private Byte btype;
	private String pno;
	private Byte rperiod;
	private long residentId;
	
	
	public Byte getBtype() {
		return btype;
	}
	public void setBtype(Byte btype) {
		this.btype = btype;
	}
	public String getPno() {
		return pno;
	}
	public void setPno(String pno) {
		this.pno = pno;
	}
	public Byte getRperiod() {
		return rperiod;
	}
	public void setRperiod(Byte rperiod) {
		this.rperiod = rperiod;
	}
	public long getResidentId() {
		return residentId;
	}
	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}
}
