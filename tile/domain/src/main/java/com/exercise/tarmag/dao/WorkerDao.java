package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.model.Worker;
import com.dt.tarmag.vo.WorkerVo;

/**
 * @author yuwei
 * @Time 2015-7-17下午05:35:38
 */
@Repository
public class WorkerDao extends DaoImpl<Worker, Long> implements IWorkerDao {

	@Override
	public int getWorkerCount(Long unitId, WorkerVo worker) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append("SELECT COUNT( DISTINCT (A.ID))FROM DT_WORKER A INNER JOIN DT_WORKER_TYPE_PARTITION B ON B.WORKER_ID = A.ID");
		sql.append(" INNER JOIN DT_WORK_TYPE C ON C.ID = B.WTYPE_ID WHERE A.DELETED = :deleted");
		sql.append(" AND B.PARTITION_ID IN (SELECT D.ID FROM DT_UNIT_PARTITION D WHERE D.UNIT_ID =:unitId)");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		if (worker != null) {
			if (StringUtils.isNotBlank(worker.getUserName())) {
				sql.append(" AND A.USER_NAME LIKE :userName ");
				params.put("userName", "%" + worker.getUserName().trim() + "%");
			}

			if (worker.getWtType() != null && worker.getWtType() > 0) {
				sql.append(" AND C.TYPE = :wtType");
				params.put("wtType", worker.getWtType());
			}

			if (worker.getPartitionId() != null && worker.getPartitionId() > 0) {
				sql.append(" AND B.PARTITION_ID = :partitionId");
				params.put("partitionId", worker.getPartitionId());
			}
		}

		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Map<String, Object>> getWorkerList(Long unitId,
			WorkerVo worker, Integer pageNo, Integer pageSize) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append("SELECT DISTINCT (A.ID), A.*, C.ID wtId, C.NAME wtName, C.TYPE wtType FROM DT_WORKER A");
		sql.append(" INNER JOIN DT_WORKER_TYPE_PARTITION B ON B.WORKER_ID = A.ID INNER JOIN DT_WORK_TYPE C ON C.ID = B.WTYPE_ID");
		sql.append(" WHERE A.DELETED = :deleted AND B.PARTITION_ID IN (SELECT D.ID FROM DT_UNIT_PARTITION D WHERE D.UNIT_ID =:unitId)");

		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		if (worker != null) {
			if (StringUtils.isNotBlank(worker.getUserName())) {
				sql.append(" AND A.USER_NAME LIKE :userName ");
				params.put("userName", "%" + worker.getUserName().trim() + "%");
			}

			if (worker.getWtType() != null && worker.getWtType() > 0) {
				sql.append(" AND C.TYPE = :wtType");
				params.put("wtType", worker.getWtType());
			}

			if (worker.getPartitionId() != null && worker.getPartitionId() > 0) {
				sql.append(" AND B.PARTITION_ID = :partitionId");
				params.put("partitionId", worker.getPartitionId());
			}
		}
		return queryForMapList(sql.toString(), pageNo, pageSize, params);
	}

	@Override
	public List<Map<String, Object>> getEditWorker(Long workId) {
		String sql = "SELECT A.*, B.ID wtpId, B.PARTITION_ID unitPID, C.ID workTypeID, "
				+ "C.TYPE TYPE FROM DT_WORKER A INNER JOIN DT_WORKER_TYPE_PARTITION B ON B.WORKER_ID = A.ID "
				+ "INNER JOIN DT_WORK_TYPE C ON C.ID = B.WTYPE_ID WHERE A.ID = ? AND A.DELETED = 'N'";

		return queryForMapList(sql.toString(), workId);
	}

	@Override
	public Worker getWorkerByPhoneNum(String phoneNum) {
		String sql = "SELECT * FROM DT_WORKER A WHERE A.PHONE_NUM = ? AND A.DELETED = 'N'";
		return queryForObject(sql, Worker.class, phoneNum);
	}

	@Override
	public Map<String, Object> login(String phoneNum, byte type) {
		String sql = "SELECT DISTINCT U.ID unitId,U.UNIT_NAME unitName,W.ID id,W.USER_NAME userName,W.PHONE_NUM phoneNum,WT.`NAME` workType,WT.ID workTypeId,W.TOKEN_ID tokenId FROM DT_WORKER W INNER JOIN DT_WORKER_TYPE_PARTITION WTP ON WTP.WORKER_ID=W.ID INNER JOIN DT_UNIT_PARTITION UP ON WTP.PARTITION_ID=UP.ID INNER JOIN DT_WORK_TYPE WT ON WT.DELETED='N' AND WT.ID=WTP.WTYPE_ID AND WT.TYPE=? INNER JOIN DT_UNIT U ON U.ID=UP.UNIT_ID AND U.DELETED='N' WHERE W.DELETED='N' AND W.PHONE_NUM=?";
		List<Map<String, Object>> results = this.queryForMapList(sql, type,
				phoneNum);
		return results == null || results.isEmpty() ? null : results.get(0);
	}

	@Override
	public Worker getWorkerManager(Long unitId) {
		StringBuffer sql = new StringBuffer("");
		
		sql.append("SELECT DISTINCT (A.ID) id,A.* FROM DT_WORKER A INNER JOIN ");
		
		sql.append(" DT_WORKER_TYPE_PARTITION B ON B.WORKER_ID = A.ID INNER JOIN DT_WORK_TYPE C ON C.ID = B.WTYPE_ID");
		
		sql.append(" WHERE A.DELETED = 'N' AND B.PARTITION_ID IN");
		sql.append(" (SELECT D.ID FROM DT_UNIT_PARTITION D WHERE D.UNIT_ID = ? ) AND C.NAME LIKE '%保修经理%'");
		return queryForObject(sql.toString(), Worker.class, unitId);
	}
}
