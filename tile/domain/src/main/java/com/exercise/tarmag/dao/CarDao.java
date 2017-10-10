package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.Car;
import com.dt.tarmag.vo.CarVo;

/**
 * @author yuwei
 * @Time 2015-7-30下午01:24:47
 */
@Repository
public class CarDao extends DaoImpl<Car, Long> implements ICarDao {

	@Override
	public int getCarCount(long unitId, CarVo searchVo) {

		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(c.ID) ")
				.append(" FROM DT_RESIDENT_UNIT a ")
				.append(" INNER JOIN DT_RESIDENT b ON a.RESIDENT_ID = b.ID ")
				.append(" INNER JOIN DT_CAR c ON b.ID = c.RESIDENT_ID ")
				.append(" WHERE a.UNIT_ID = :unitId ")
				.append(" AND a.DELETED = :deleted ")
				.append(" AND b.DELETED = :deleted ")
				.append(" AND c.DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		// 设置车牌号
		if (searchVo != null && searchVo.getPlateNo() != null && !"".equals(searchVo.getPlateNo().trim())) {
			sql.append(" AND c.PLATE_NO LIKE :plateNo ");
			params.put("plateNo", "%" +  searchVo.getPlateNo().trim() + "%");
		}

		// 设置车主信息
		if (searchVo != null && searchVo.getResidentName() != null && !"".equals(searchVo.getResidentName().trim())) {
			sql.append(" AND b.USER_NAME LIKE :residentName ");
			params.put("residentName", "%" + searchVo.getResidentName().trim() + "%");
		}

		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Car> getCarList(long unitId, CarVo searchVo, int pageNo, int pageSize) {

		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT c.* ")
				.append(" FROM DT_RESIDENT_UNIT a ")
				.append(" INNER JOIN DT_RESIDENT b ON a.RESIDENT_ID = b.ID ")
				.append(" INNER JOIN DT_CAR c ON b.ID = c.RESIDENT_ID ")
				.append(" WHERE a.UNIT_ID = :unitId ")
				.append(" AND a.DELETED = :deleted ")
				.append(" AND b.DELETED = :deleted ")
				.append(" AND c.DELETED = :deleted ");
				
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		// 设置车牌号
		if (searchVo != null && searchVo.getPlateNo() != null && !"".equals(searchVo.getPlateNo().trim())) {
			sql.append(" AND c.PLATE_NO LIKE :plateNo ");
			params.put("plateNo", "%" +  searchVo.getPlateNo().trim() + "%");
		}

		// 设置车主信息
		if (searchVo != null && searchVo.getResidentName() != null && !"".equals(searchVo.getResidentName().trim())) {
			sql.append(" AND b.USER_NAME LIKE :residentName ");
			params.put("residentName", "%" + searchVo.getResidentName().trim() + "%");
		}

		sql.append(" ORDER BY c.CREATE_DATE_TIME DESC ");
		return query(sql.toString(), Car.class, pageNo, pageSize, params);
	}

	@Override
	public Car getCarByPlateNo(String plateNo) {
		
		if(plateNo == null || "".equals(plateNo.trim()) ){
			return null;
		}
		
		String sql = "SELECT * FROM DT_CAR a WHERE a.PLATE_NO = :plateNo AND a.DELETED = :deleted";
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("plateNo", plateNo);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		return queryForObject(sql, Car.class, params);
	}

}
