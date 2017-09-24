package com.dt.tarmag.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.CarPort;
import com.dt.tarmag.vo.CarPortVo;


/**
 * @author yuwei
 * @Time 2015-7-30下午01:26:48
 */
@Repository
public class CarPortDao extends DaoImpl<CarPort, Long> implements ICarPortDao {

	@Override
	public int getCarportCount(long unitId, CarPortVo searchVo) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(c.ID) ")
		   .append(" FROM DT_UNIT_PARTITION a ")
		   .append(" INNER JOIN DT_CAR_GARAGE b ON a.ID = b.PARTITION_ID ")
		   .append(" INNER JOIN DT_CAR_PORT c ON b.ID = c.GARAGE_ID ")
		   .append(" WHERE a.UNIT_ID = :unitId ")
		   .append(" AND a.DELETED = :deleted ")
		   .append(" AND b.DELETED = :deleted ")
		   .append(" AND c.DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(searchVo != null && searchVo.getBtype() != null) {
			sql.append(" AND c.BIND_TYPE = :btype ");
			params.put("btype", searchVo.getBtype());
		}
		
		if(searchVo != null && searchVo.getPno() != null && !searchVo.getPno().trim().equals("")) {
			sql.append(" AND c.PORT_NO LIKE :portNo ");
			params.put("portNo", "%" + searchVo.getPno().trim() + "%");
		}
		
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<CarPort> getCarportList(long unitId, CarPortVo searchVo, int pageNo, int pageSize) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT c.* ")
		   .append(" FROM DT_UNIT_PARTITION a ")
		   .append(" INNER JOIN DT_CAR_GARAGE b ON a.ID = b.PARTITION_ID ")
		   .append(" INNER JOIN DT_CAR_PORT c ON b.ID = c.GARAGE_ID ")
		   .append(" WHERE a.UNIT_ID = :unitId ")
		   .append(" AND a.DELETED = :deleted ")
		   .append(" AND b.DELETED = :deleted ")
		   .append(" AND c.DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(searchVo != null && searchVo.getBtype() != null) {
			sql.append(" AND c.BIND_TYPE = :btype ");
			params.put("btype", searchVo.getBtype());
		}
		
		if(searchVo != null && searchVo.getPno() != null && !searchVo.getPno().trim().equals("")) {
			sql.append(" AND c.PORT_NO LIKE :portNo ");
			params.put("portNo", "%" + searchVo.getPno().trim() + "%");
		}
		
		return query(sql.toString(), CarPort.class, pageNo, pageSize, params);
	}

	@Override
	public CarPort getCarPortByNameAndGarageId(long garageId, String portNo) {
		String sql = "SELECT * FROM DT_CAR_PORT A WHERE A.DELETED = :deleted AND A.GARAGE_ID =:garageId  AND A.PORT_NO =:portNo";
		Map<String ,Object> mapParams = new HashMap<String, Object>();
		
		mapParams.put("deleted", Constant.MODEL_DELETED_N);
		mapParams.put("garageId", garageId);
		mapParams.put("portNo", portNo);
		
		return queryForObject(sql , CarPort.class , mapParams);
	}
	
}
