package com.dt.tarmag.dao;


import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.CarGarage;


/**
 * @author yuwei
 * @Time 2015-7-30下午01:25:55
 */
@Repository
public class CarGarageDao extends DaoImpl<CarGarage, Long> implements ICarGarageDao {

	@Override
	public CarGarage getGarageByPartitionIdAndGarageNo(long partitionId, String garageNo) {
		String sql = "SELECT * FROM DT_CAR_GARAGE A WHERE A.DELETED =:deleted AND A.PARTITION_ID=:partitionId AND A.GARAGE_NO =:garageNo";
		
		Map<String ,Object> mapParams = new HashMap<String, Object>();
		
		mapParams.put("deleted", Constant.MODEL_DELETED_N);
		mapParams.put("partitionId", partitionId);
		mapParams.put("garageNo", garageNo);
		
		return queryForObject(sql , CarGarage.class , mapParams);
	}

	@Override
	public CarGarage getCarGarageByUnitIdAndGarageNo(Long unitId, String garageNo) {
		String sql = "SELECT * FROM DT_CAR_GARAGE A WHERE A.PARTITION_ID IN (SELECT A.ID FROM DT_UNIT_PARTITION A WHERE A.UNIT_ID =:unitId) AND A.DELETED =:deleted AND A.GARAGE_NO=:garageNo";
		Map<String ,Object> mapParams = new HashMap<String, Object>();
		
		mapParams.put("deleted", Constant.MODEL_DELETED_N);
		mapParams.put("unitId", unitId);
		mapParams.put("garageNo", garageNo);
		
		return queryForObject(sql , CarGarage.class , mapParams);
	}
	
}
