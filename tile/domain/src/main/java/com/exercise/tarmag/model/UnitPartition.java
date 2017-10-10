package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * 小区片区
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class UnitPartition extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2990186359595641756L;
	private long unitId;
	private String partitionName;
	private String aliasName;
	private String remark;
	
	
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
	public String getPartitionName() {
		return partitionName;
	}
	public void setPartitionName(String partitionName) {
		this.partitionName = partitionName;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getAliasName() {
		return aliasName;
	}
	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}
}
