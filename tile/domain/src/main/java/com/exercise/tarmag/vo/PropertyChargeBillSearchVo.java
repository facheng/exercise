package com.dt.tarmag.vo;

/**
 * 
 *
 * @author jiaosf
 * @since 2015-8-21
 */
public class PropertyChargeBillSearchVo extends TimeSearchVo{
	
	private String roomNum;
	
	private Byte status;

	
	public String getRoomNum() {
		return roomNum;
	}

	
	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
	}

	
	public Byte getStatus() {
		return status;
	}

	
	public void setStatus(Byte status) {
		this.status = status;
	}

}
