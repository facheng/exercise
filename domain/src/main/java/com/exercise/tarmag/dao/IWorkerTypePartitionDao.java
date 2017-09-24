package com.dt.tarmag.dao;


import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.WorkerTypePartition;


/**
 * @author yuwei
 * @Time 2015-7-17下午05:17:47
 */
public interface IWorkerTypePartitionDao extends Dao<WorkerTypePartition, Long> {
	public List<WorkerTypePartition> getWorkerListByPartitionIdAndWtypeId(long partitionId, long wtypeId);
	
	/**
	 * 查询当前保安保修人员在当前小区所属期块
	 * @param workId
	 * @param unitId
	 * @return
	 */
	public List<WorkerTypePartition> getWorkTypeByWorkId(Long workId ,Long unitId);
	

	/**
	 * 清空当前保安保修人员关系
	 * @param id
	 */
	public void deleteAllWorkerTypePartitionByWokerId(Long id);
}
