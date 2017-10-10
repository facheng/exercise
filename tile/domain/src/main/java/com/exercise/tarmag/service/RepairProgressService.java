package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IRepairDao;
import com.dt.tarmag.dao.IRepairProgressDao;
import com.dt.tarmag.model.Repair;
import com.dt.tarmag.model.RepairProgress;

@Service
public class RepairProgressService implements IRepairProgressService {
	
	@Autowired
	private IRepairProgressDao repairProgressDao;
	
	@Autowired
	private IRepairDao repairDao;

	@Override
	public Map<String, Object> getRepairProgress(Long repairId) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<RepairProgress> repairProgresss = this.repairProgressDao.getRepairProgress(repairId);
		Collections.reverse(repairProgresss);
		List<Map<String, Object>> pros = new ArrayList<Map<String, Object>>();
		for(RepairProgress repairProgress : repairProgresss){
			Map<String, Object> pro = new HashMap<String,Object>();
			pro.put("id", repairProgress.getId());
			pro.put("repairId", repairProgress.getRepairId());
			pro.put("status", repairProgress.getStatus());
			pro.put("statusName", repairProgress.getStatusName());
			pro.put("remark", repairProgress.getRemark());
			pro.put("createDateTime", repairProgress.getCreateDateTime());
			pros.add(pro);
		}
		result.put("progress", pros);
		Repair repair = this.repairDao.get(repairId);
		if(repair.getStatus() == Repair.STATUS_END){
			result.put("scores", repair.toMap(new String[]{"scoreResponse", "scoreDoor", "scoreService", "scoreQuality"}));
		}
		return result;
	}

}
