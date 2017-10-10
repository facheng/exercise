package com.dt.tarmag.model;

import com.dt.framework.model.DtSimpleModel;



/**
 * 小区工作人员+(小区)期+工种关系
 * @author yuwei
 * @Time 2015-7-17下午05:15:14
 */
public class WorkerTypePartition extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6778071594507760058L;
	private long workerId;
	private long partitionId;
	private long wtypeId;
	
	
	public long getWorkerId() {
		return workerId;
	}
	public void setWorkerId(long workerId) {
		this.workerId = workerId;
	}
	public long getPartitionId() {
		return partitionId;
	}
	public void setPartitionId(long partitionId) {
		this.partitionId = partitionId;
	}
	public long getWtypeId() {
		return wtypeId;
	}
	public void setWtypeId(long wtypeId) {
		this.wtypeId = wtypeId;
	}
}
