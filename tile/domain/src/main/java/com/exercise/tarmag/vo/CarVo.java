package com.dt.tarmag.vo;

/**
 * @author yuwei
 * @Time 2015-8-3下午05:41:41
 */
public class CarVo {

	/*
	 * 车牌号
	 */
	private String plateNo;

	/*
	 * 车主
	 */
	private String residentName;

	/*
	 * 车主id
	 */
	private Long residentId;

	public String getPlateNo() {
		return plateNo;
	}

	public void setPlateNo(String plateNo) {
		this.plateNo = plateNo;
	}

	public String getResidentName() {
		return residentName;
	}

	public void setResidentName(String residentName) {
		this.residentName = residentName;
	}

	public Long getResidentId() {
		return residentId;
	}

	public void setResidentId(Long residentId) {
		this.residentId = residentId;
	}

}
