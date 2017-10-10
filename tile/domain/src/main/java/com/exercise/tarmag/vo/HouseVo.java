package com.dt.tarmag.vo;



/**
 * @author yuwei
 * @Time 2015-7-12下午02:27:13
 */
public class HouseVo {
	private long id;
	private String roomNum;
	private int floorNum;
	private String proNo;
	private double area;
	private byte status;
	private byte delegateDelivery;
	

	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
	}
	public int getFloorNum() {
		return floorNum;
	}
	public void setFloorNum(int floorNum) {
		this.floorNum = floorNum;
	}
	public String getProNo() {
		return proNo;
	}
	public void setProNo(String proNo) {
		this.proNo = proNo;
	}
	public double getArea() {
		return area;
	}
	public void setArea(double area) {
		this.area = area;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
	public byte getDelegateDelivery() {
		return delegateDelivery;
	}
	public void setDelegateDelivery(byte delegateDelivery) {
		this.delegateDelivery = delegateDelivery;
	}
}
