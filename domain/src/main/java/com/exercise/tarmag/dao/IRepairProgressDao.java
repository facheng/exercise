package com.dt.tarmag.dao;



import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.RepairProgress;


/**
 * @author yuwei
 * @Time 2015-7-19下午12:24:07
 */
public interface IRepairProgressDao extends Dao<RepairProgress, Long> {

	List<RepairProgress> getRepairProgress(Long repairId);

	/**
	 * 获取保修图片
	 * @param workerId
	 * @param repairId
	 * @param status
	 * @return
	 */
	Map<String, Object> pictures(Long workerId, Long repairId, int status);
}
