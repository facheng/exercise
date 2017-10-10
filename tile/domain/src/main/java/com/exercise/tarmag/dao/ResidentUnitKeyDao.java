package com.dt.tarmag.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.KeyDevice;
import com.dt.tarmag.model.ResidentUnitKey;

/**
 * @author yuwei
 * @Time 2015-7-24下午02:01:46
 */
@Repository
public class ResidentUnitKeyDao extends DaoImpl<ResidentUnitKey, Long> implements IResidentUnitKeyDao {
	
	
	@Override
	public List<Map<String, Object>> findKeys(Long unitId, Long residentId) {
		StringBuffer sql = new StringBuffer();
		sql.append("select kd.ID id,kd.DEVICE_ADDRESS deviceAddress,kd.DEVICE_PASSWORD devicePassword,kd.DEVICE_TYPE deviceType,kd.KEY_TYPE keyType,kd.KEY_NAME keyName ");
		sql.append("from DT_RESIDENT_UNIT_KEY ruk ");
		sql.append("left join DT_RESIDENT_UNIT ru on ru.ID = ruk.RESIDENT_UNIT_ID ");
		sql.append("left join DT_KEY_DEVICE kd on kd.ID = ruk.KEY_DEVICE_ID ");
		sql.append("where ru.RESIDENT_ID = ? and ru.UNIT_ID = ? and ruk.DELETED = 'N' and ru.DELETED = 'N' and kd.DELETED = 'N' ");
		return this.queryForMapList(sql.toString(), residentId,unitId);
	}

	@Override
	public int getResidentUnitStoryKeyCount() {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(a.ID) ")
		   .append(" FROM DT_RESIDENT_UNIT_KEY a ")
		   .append(" INNER JOIN DT_KEY_DEVICE b ON a.KEY_DEVICE_ID = b.ID ")
		   .append(" WHERE a.DELETED = :deleted AND b.DELETED = :deleted AND b.DEVICE_TYPE = :deviceType ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("deviceType", KeyDevice.DEVICE_TYPE_STORY);
		
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<ResidentUnitKey> getResidentUnitStoryKeyList(int pageNo, int pageSize) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT a.* ")
		   .append(" FROM DT_RESIDENT_UNIT_KEY a ")
		   .append(" INNER JOIN DT_KEY_DEVICE b ON a.KEY_DEVICE_ID = b.ID ")
		   .append(" WHERE a.DELETED = :deleted AND b.DELETED = :deleted AND b.DEVICE_TYPE = :deviceType ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("deviceType", KeyDevice.DEVICE_TYPE_STORY);
		
		return query(sql.toString(), ResidentUnitKey.class, pageNo, pageSize, params);
	}
}
