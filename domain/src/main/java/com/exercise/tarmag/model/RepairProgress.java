package com.dt.tarmag.model;



/**
 * 报修处理进度
 * @author yuwei
 * @Time 2015-7-19下午12:18:07
 */
public class RepairProgress extends RepairStatus{

	public static final String IMG_PATH = "repairprogress";//图片上传的相对路径
	/**
	 * 
	 */
	private static final long serialVersionUID = 3381423373601338658L;
	private long repairId;
	private long workerId;
	private String workerName;
	private String phoneNum;
	private String remark;
	private String img;
	
	
	public long getRepairId() {
		return repairId;
	}
	public void setRepairId(long repairId) {
		this.repairId = repairId;
	}
	public long getWorkerId() {
		return workerId;
	}
	public void setWorkerId(long workerId) {
		this.workerId = workerId;
	}
	public String getWorkerName() {
		return workerName;
	}
	public void setWorkerName(String workerName) {
		this.workerName = workerName;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
}
