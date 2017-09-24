package com.dt.tarmag.vo;

/**
 * 需要关注的业主扩展类
 * @author jiaosf
 * @since 2015-7-21
 */
public class FocusResidentVo {
	
	private Long id;
	private Long hrId;
	private Byte residentStatus;
	private String remark;
	
	
	//设置修改回显参数
	
	private Long houseId;
	
	private Long storyId;
	
	private Long partitionId;
	
	public Long getHouseId() {
		return houseId;
	}

	
	public void setHouseId(Long houseId) {
		this.houseId = houseId;
	}

	
	public Long getStoryId() {
		return storyId;
	}

	
	public void setStoryId(Long storyId) {
		this.storyId = storyId;
	}

	
	public Long getPartitionId() {
		return partitionId;
	}

	
	public void setPartitionId(Long partitionId) {
		this.partitionId = partitionId;
	}

	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}

	public Long getHrId() {
		return hrId;
	}
	
	public void setHrId(Long hrId) {
		this.hrId = hrId;
	}
	
	public Byte getResidentStatus() {
		return residentStatus;
	}
	
	public void setResidentStatus(Byte residentStatus) {
		this.residentStatus = residentStatus;
	}
	
	public String getRemark() {
		return remark;
	}
	
	public void setRemark(String remark) {
		this.remark = remark;
	}

	
}
