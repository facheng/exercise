package com.dt.tarmag.dao;


import java.util.List;

import org.springframework.stereotype.Repository;
import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.WorkerTypePartition;

/**
 * @author yuwei
 * @Time 2015-7-17下午05:18:26
 */
@Repository
public class WorkerTypePartitionDao extends DaoImpl<WorkerTypePartition, Long> implements IWorkerTypePartitionDao {

	@Override
	public List<WorkerTypePartition> getWorkerListByPartitionIdAndWtypeId(long partitionId, long wtypeId) {
		String sql = "SELECT * FROM DT_WORKER_TYPE_PARTITION WHERE PARTITION_ID = ? AND WTYPE_ID = ? AND DELETED = ?";
		return query(sql, WorkerTypePartition.class, new Object[]{partitionId, wtypeId, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<WorkerTypePartition> getWorkTypeByWorkId(Long workId , Long unitId) {
		String sql = "SELECT * FROM DT_WORKER_TYPE_PARTITION A WHERE A.PARTITION_ID IN " +
				"(SELECT B.ID FROM DT_UNIT_PARTITION B WHERE B.UNIT_ID = ?) AND A.WORKER_ID = ? AND DELETED = ?";
		return query(sql, WorkerTypePartition.class, new Object[]{unitId, workId ,Constant.MODEL_DELETED_N});
	}

	@Override
	public void deleteAllWorkerTypePartitionByWokerId(Long workerId) {
		String sql = "DELETE FROM DT_WORKER_TYPE_PARTITION WHERE  WORKER_ID = ?";
		execute(sql , workerId);
	}

	
}
