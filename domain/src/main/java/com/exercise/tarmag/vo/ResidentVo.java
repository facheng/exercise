package com.dt.tarmag.vo;



/**
 * @author WEI
 * @time 2015-7-11 下午08:50:30
 */
public class ResidentVo {
	private long residentId;
	private long houseResidentId;
	private String residentName;
	private String residentType;
	private String idCard;
	private String phoneNum;
	private byte type;
	
	public long getHouseResidentId() {
		return houseResidentId;
	}
	
	public void setHouseResidentId(long houseResidentId) {
		this.houseResidentId = houseResidentId;
	}
	public long getResidentId() {
		return residentId;
	}
	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}
	public String getResidentName() {
		return residentName;
	}
	public void setResidentName(String residentName) {
		this.residentName = residentName;
	}
	public String getResidentType() {
		return residentType;
	}
	public void setResidentType(String residentType) {
		this.residentType = residentType;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public byte getType() {
		return type;
	}
	public void setType(byte type) {
		this.type = type;
	}
}
