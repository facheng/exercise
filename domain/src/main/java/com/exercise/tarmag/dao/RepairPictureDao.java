package com.dt.tarmag.dao;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.RepairPicture;

/**
 * @author yuwei
 * @Time 2015-7-19上午11:04:00
 */
@Repository
public class RepairPictureDao extends DaoImpl<RepairPicture, Long> implements IRepairPictureDao {

	@Override
	public List<RepairPicture> getPicturesByRepairId(long repairId) {
		String sql = "SELECT * FROM DT_REPAIR_PICTURE WHERE REPAIR_ID = ? AND DELETED = ?";
		return query(sql, RepairPicture.class, new Object[]{repairId, Constant.MODEL_DELETED_N});
	}
	
}
