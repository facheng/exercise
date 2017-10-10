package com.dt.tarmag.dao;



import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.CarGarage;


/**
 * @author yuwei
 * @Time 2015-7-30下午01:25:32
 */
public interface ICarGarageDao extends Dao<CarGarage, Long> {
	
	/**
	 * 通过片区 ID和车库号查询车库
	 * @param partitionId
	 * @param garageNo
	 * @return
	 */
	public CarGarage getGarageByPartitionIdAndGarageNo(long partitionId, String garageNo);
	
	/**
	 * 根据小区ID和车库号查询车库
	 * @param unitId
	 * @param garageNo
	 * @return
	 */
	public CarGarage getCarGarageByUnitIdAndGarageNo(Long unitId, String garageNo);
	
}
