package com.dt.tarmag.service;

import java.util.Map;

public interface IRepairProgressService {
	
	/**
	 * 报修进度
	 * @param repairId
	 * @return
	 */
	Map<String, Object> getRepairProgress(Long repairId);
}
