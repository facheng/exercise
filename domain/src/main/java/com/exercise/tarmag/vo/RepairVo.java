package com.dt.tarmag.vo;

/**
 * @author yuwei
 * @Time 2015-7-21下午12:36:42
 */
public class RepairVo {
	private byte repairType;
	private byte serviceType;
	private long houseId;
	private long unitId;
	private long residentId;
	private String residentName;
	private String phoneNum;
	private String orderTime;
	private byte isPublic;
	private String address;
	private String remark;
	private byte urgentState;
	private long workTypeId;
	private long workerId;

	public long getWorkerId() {
		return workerId;
	}

	public void setWorkerId(long workerId) {
		this.workerId = workerId;
	}

	public byte getRepairType() {
		return repairType;
	}

	public void setRepairType(byte repairType) {
		this.repairType = repairType;
	}

	public byte getServiceType() {
		return serviceType;
	}

	public void setServiceType(byte serviceType) {
		this.serviceType = serviceType;
	}

	public long getHouseId() {
		return houseId;
	}

	public void setHouseId(long houseId) {
		this.houseId = houseId;
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

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public byte getUrgentState() {
		return urgentState;
	}

	public void setUrgentState(byte urgentState) {
		this.urgentState = urgentState;
	}

	public long getWorkTypeId() {
		return workTypeId;
	}

	public void setWorkTypeId(long workTypeId) {
		this.workTypeId = workTypeId;
	}

	public byte getIsPublic() {
		return isPublic;
	}

	public void setIsPublic(byte isPublic) {
		this.isPublic = isPublic;
	}

	public long getUnitId() {
		return unitId;
	}

	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

}
