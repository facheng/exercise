package com.dt.tarmag.dao;



import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.RepairPicture;


/**
 * @author yuwei
 * @Time 2015-7-19上午11:03:27
 */
public interface IRepairPictureDao extends Dao<RepairPicture, Long> {
	List<RepairPicture> getPicturesByRepairId(long repairId);
}
