package com.dt.tarmag.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.HouseResident;
import com.dt.tarmag.model.Resident;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class ResidentDao extends DaoImpl<Resident, Long> implements IResidentDao {

	@Override
	public Resident getResidentByPhoneNum(String phoneNum) {
		String sql = "SELECT * FROM DT_RESIDENT WHERE PHONE_NUM = ? AND DELETED = ?";
		return this.queryForObject(sql, Resident.class, new Object[]{phoneNum, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<Map<String, Object>> getResidentByHouseId(long houseId) {
		Map<String, Object> params = new HashMap<String, Object>();
		StringBuffer sql = new StringBuffer("");
		sql.append("select a.ID,a.TYPE,b.USER_NAME,b.PHONE_NUM,b.ID_CARD ,b.ID residentId ")
		.append("from DT_HOUSE_RESIDENT a ")
		.append("left join DT_RESIDENT b on a.RESIDENT_ID = b.ID ")
		.append("where a.DELETED = :deleted and a.HOUSE_ID = :houseId and a.IS_APPROVED = :approved ");
		params.put("houseId", houseId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("approved", HouseResident.IS_APPROVED_YES);
		return queryForMapList(sql.toString(), params);
	}

	@Override
	public List<Resident> getResident(Map<String, Object> paramsMap) {
		StringBuffer sql = new StringBuffer("SELECT * FROM DT_RESIDENT A WHERE A.DELETED = 'N' AND A.ID IN (SELECT B.RESIDENT_ID FROM DT_HOUSE_RESIDENT B WHERE B.HOUSE_ID =:houseId)");
		
		if(paramsMap.containsKey("userName")){
			sql.append(" AND USER_NAME=:userName");
		}
		if(paramsMap.containsKey("phoneNum")){
			sql.append(" AND PHONE_NUM=:phoneNum");
		}
		if(paramsMap.containsKey("idCard")){
			sql.append(" AND ID_CARD=:idCard");
		}
		
		return query(sql.toString(), Resident.class, paramsMap);
	}

	@Override
	public List<Resident> getResidentListByUnitId(long unitId) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT c.* ")
		   .append(" FROM DT_HOUSE a ")
		   .append(" INNER JOIN DT_HOUSE_RESIDENT b ON a.ID = b.HOUSE_ID ")
		   .append(" INNER JOIN DT_RESIDENT c ON b.RESIDENT_ID = c.ID ")
		   .append(" WHERE a.DELETED = :deleted AND b.DELETED = :deleted AND c.DELETED = :deleted AND a.UNIT_ID = :unitId ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("unitId", unitId);
		
		return query(sql.toString(), Resident.class, params);
	}

	@Override
	public List<Resident> getResidentListByHouseId(long houseId) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT b.* ")
		   .append(" FROM DT_HOUSE_RESIDENT a ")
		   .append(" INNER JOIN DT_RESIDENT b ON a.RESIDENT_ID = b.ID ")
		   .append(" WHERE a.DELETED = :deleted AND b.DELETED = :deleted AND a.HOUSE_ID = :houseId ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("houseId", houseId);
		
		return query(sql.toString(), Resident.class, params);
	}
	
	@Override
	public List<Resident> getResidentList(long houseId, List<Byte> typeList) {
		if(houseId <= 0
				|| typeList == null || typeList.size() <= 0) {
			return new ArrayList<Resident>();
		}

		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT b.* ")
		   .append(" FROM DT_HOUSE_RESIDENT a ")
		   .append(" INNER JOIN DT_RESIDENT b ON a.RESIDENT_ID = b.ID ")
		   .append(" WHERE a.DELETED = :deleted AND b.DELETED = :deleted AND a.HOUSE_ID = :houseId AND a.TYPE IN (:typeList) ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("houseId", houseId);
		params.put("typeList", typeList);
		
		return query(sql.toString(), Resident.class, params);
	}
	
	@Override
	public List<Resident> getResidentList(List<Long> houseIdList, List<Byte> typeList) {
		if(houseIdList == null || houseIdList.size() <= 0
				|| typeList == null || typeList.size() <= 0) {
			return new ArrayList<Resident>();
		}
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT b.* ")
		   .append(" FROM DT_HOUSE_RESIDENT a ")
		   .append(" INNER JOIN DT_RESIDENT b ON a.RESIDENT_ID = b.ID ")
		   .append(" WHERE a.DELETED = :deleted AND b.DELETED = :deleted AND a.HOUSE_ID IN (:houseIdList) AND a.TYPE IN (:typeList)");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("houseIdList", houseIdList);
		params.put("typeList", typeList);
		
		return query(sql.toString(), Resident.class, params);
	}

	@Override
	public List<Map<String, Object>> getResidentByHouseIdAndType(long houseId , List<Byte> typeList) {
		
		
		if(houseId <= 0
				|| typeList == null || typeList.size() <= 0) {
			List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
			return list;
		}

		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT a.ID hrId,a.TYPE hrType, b.* ")
		   .append(" FROM DT_HOUSE_RESIDENT a ")
		   .append(" INNER JOIN DT_RESIDENT b ON a.RESIDENT_ID = b.ID ")
		   .append(" WHERE a.DELETED = :deleted AND b.DELETED = :deleted AND a.HOUSE_ID = :houseId AND a.TYPE IN (:typeList) ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("houseId", houseId);
		params.put("typeList", typeList);
		
		return queryForMapList(sql.toString(), params);
	}

	@Override
	public List<Resident> findResidentListByUnitId(long unitId) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT A.* ")
		   .append(" FROM DT_RESIDENT A ")
		   .append(" INNER JOIN DT_RESIDENT_UNIT B ON A.ID = B.RESIDENT_ID ")
		   .append(" WHERE A.DELETED = :deleted AND B.DELETED = :deleted  AND B.UNIT_ID = :unitId ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("unitId", unitId);
		
		return query(sql.toString(), Resident.class, params);
	}
}
