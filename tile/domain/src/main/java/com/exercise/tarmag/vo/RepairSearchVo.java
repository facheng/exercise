package com.dt.tarmag.vo;



/**
 * 报修查询条件
 * @author yuwei
 * @Time 2015-7-23上午11:30:39
 */
public class RepairSearchVo extends TimeSearchVo {
	/**
	 * 报修类型。
	 * 取值同Repair.repairType，若为空，表示查全部
	 */
	private Byte repairType;
	/**
	 * 维修类型。
	 * 取值同Repair.serviceType，若为空，表示查全部
	 */
	private Byte serviceType;
	/**
	 * 片区Id，若为空，查全部
	 */
	private Long partitionId;
	/**
	 * 报修状态。
	 * 取值同Repair.status。
	 * 若为空，“未分派的报修”查(0待分派，1已分派待接受，2已拒绝)；“已分派的报修”查(3已接，4已签到，5可修，6不可修，7已完成，8已结束)
	 */
	private Byte status;
	/**
	 * 紧急程度
	 * 取值同Repair.urgentState，若为空，表示查全部
	 */
	private Byte urgentState;
	/**
	 * 门牌号码
	 */
	private String rno;
	/**
	 * 户主姓名
	 */
	private String rname;
	
	
	
	
	public Byte getRepairType() {
		return repairType;
	}
	public void setRepairType(Byte repairType) {
		this.repairType = repairType;
	}
	public Byte getServiceType() {
		return serviceType;
	}
	public void setServiceType(Byte serviceType) {
		this.serviceType = serviceType;
	}
	public Long getPartitionId() {
		return partitionId;
	}
	public void setPartitionId(Long partitionId) {
		this.partitionId = partitionId;
	}
	public Byte getStatus() {
		return status;
	}
	public void setStatus(Byte status) {
		this.status = status;
	}
	public Byte getUrgentState() {
		return urgentState;
	}
	public void setUrgentState(Byte urgentState) {
		this.urgentState = urgentState;
	}
	public String getRno() {
		return rno;
	}
	public void setRno(String rno) {
		this.rno = rno;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
}
