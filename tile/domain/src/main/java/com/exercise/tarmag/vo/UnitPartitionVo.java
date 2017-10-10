package com.dt.tarmag.vo;

/**
 * 小区期数扩展类
 *
 * @author jiaosf
 * @since 2015-7-29
 */
public class UnitPartitionVo {
	
	private Long id;
	private Long unitId;
	private String partitionName;
	private String aliasName;
	private String remark;
	
	/**
	 * 0 否 1是
	 */
	private Integer isChecked; 

	
	public Long getId() {
		return id;
	}

	
	public void setId(Long id) {
		this.id = id;
	}

	
	public Long getUnitId() {
		return unitId;
	}

	
	public void setUnitId(Long unitId) {
		this.unitId = unitId;
	}

	
	public String getPartitionName() {
		return partitionName;
	}

	
	public void setPartitionName(String partitionName) {
		this.partitionName = partitionName;
	}

	
	public String getAliasName() {
		return aliasName;
	}

	
	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}

	
	public String getRemark() {
		return remark;
	}

	
	public void setRemark(String remark) {
		this.remark = remark;
	}

	
	public Integer getIsChecked() {
		return isChecked;
	}

	
	public void setIsChecked(Integer isChecked) {
		this.isChecked = isChecked;
	}
	
}
