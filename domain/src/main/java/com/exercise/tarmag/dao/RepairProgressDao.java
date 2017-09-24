package com.dt.tarmag.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.RepairProgress;

/**
 * @author yuwei
 * @Time 2015-7-19下午12:24:47
 */
@Repository
public class RepairProgressDao extends DaoImpl<RepairProgress, Long> implements IRepairProgressDao {

	@Override
	public List<RepairProgress> getRepairProgress(Long repairId) {
		String sql = " select * from DT_REPAIR_PROGRESS where REPAIR_ID = ? AND DELETED = ? ";
		return this.query(sql, RepairProgress.class, new Object[]{repairId, Constant.MODEL_DELETED_N});
	}

	@Override
	public Map<String, Object> pictures(Long workerId, Long repairId, int status) {
		String sql = "SELECT IMG img FROM DT_REPAIR_PROGRESS WHERE REPAIR_ID = ? AND DELETED = 'N' AND WORKER_ID=? AND STATUS=?";
		List<Map<String, Object>> pictures = this.queryForMapList(sql, repairId, workerId, status);
		return pictures.isEmpty() ? new HashMap<String, Object>() : pictures.get(0);
	}
}
