/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.KeyDevice;
import com.dt.tarmag.vo.KeyDeviceSearchVo;

/**
 * @author 👤wisdom
 *
 */
@Repository
public class KeyDeviceDao extends DaoImpl<KeyDevice, Long> implements
		IKeyDeviceDao {

	@Override
	public List<KeyDevice> findKeyDevice(Long houseId) {
		String sql = "SELECT K.* FROM DT_KEY_DEVICE K WHERE K.DELETED='N' AND EXISTS (SELECT 1 FROM DT_HOUSE H WHERE H.DELETED='N' AND H.ID=? AND (K.STORY_ID=H.STORY_ID OR (K.UNIT_ID=H.UNIT_ID AND K.STORY_ID IS NULL)))";
		return this.query(sql, KeyDevice.class, houseId);
	}

	@Override
	public List<Map<String, Object>> findkeyDevice(Long unitId,
			List<Long> storyIds) {
		Map<String, Object> params = new HashMap<String, Object>();
		StringBuffer sqlbuf = new StringBuffer("SELECT KEY_NAME keyName,DEVICE_NAME deviceName,STORY_ID storyId,DEVICE_ADDRESS deviceAddress,DEVICE_PASSWORD devicePassword,KEY_TYPE keyType,DEVICE_TYPE deviceType,UNIT_NAME unitName FROM DT_KEY_DEVICE K,DT_UNIT U WHERE K.DELETED='N' AND U.DELETED='N' AND U.ID=K.UNIT_ID");
		if(unitId != null){
			sqlbuf.append(" AND UNIT_ID=:unitId ");
			params.put("unitId", unitId);
		}
		//绑定楼栋查询重复
		if(storyIds != null && !storyIds.isEmpty()){
			sqlbuf.append(" AND (STORY_ID='0' OR STORY_ID IN (");
			String ids = storyIds.toString();
			sqlbuf.append(ids.substring(1, ids.length()-1));
			sqlbuf.append("))");
		}else{
			sqlbuf.append(" AND STORY_ID='0' ");
		}
		return this.queryForMapList(sqlbuf.toString(), params);
	}

	@Override
	public int getKeyDeviceCount(long unitId, KeyDeviceSearchVo vo) {
		if(vo == null) {
			vo = new KeyDeviceSearchVo();
		}
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(ID) ")
		   .append(" FROM DT_KEY_DEVICE ")
		   .append(" WHERE UNIT_ID = :unitId AND DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(vo.getDeviceType() != null) {
			sql.append(" AND DEVICE_TYPE = :deviceType ");
			params.put("deviceType", vo.getDeviceType());
		}
		
		if(vo.getKeyName() != null && !vo.getKeyName().trim().equals("")) {
			sql.append(" AND KEY_NAME LIKE :keyName ");
			params.put("keyName", "%" + vo.getKeyName().trim() + "%");
		}
		
		if(vo.getAddr() != null && !vo.getAddr().trim().equals("")) {
			sql.append(" AND DEVICE_ADDRESS LIKE :addr ");
			params.put("addr", "%" + vo.getAddr().trim() + "%");
		}
		
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<KeyDevice> getKeyDeviceList(long unitId, KeyDeviceSearchVo vo, int pageNo, int pageSize) {
		if(vo == null) {
			vo = new KeyDeviceSearchVo();
		}
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT * ")
		   .append(" FROM DT_KEY_DEVICE ")
		   .append(" WHERE UNIT_ID = :unitId AND DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(vo.getDeviceType() != null) {
			sql.append(" AND DEVICE_TYPE = :deviceType ");
			params.put("deviceType", vo.getDeviceType());
		}
		
		if(vo.getKeyName() != null && !vo.getKeyName().trim().equals("")) {
			sql.append(" AND KEY_NAME LIKE :keyName ");
			params.put("keyName", "%" + vo.getKeyName().trim() + "%");
		}
		
		if(vo.getAddr() != null && !vo.getAddr().trim().equals("")) {
			sql.append(" AND DEVICE_ADDRESS LIKE :addr ");
			params.put("addr", "%" + vo.getAddr().trim() + "%");
		}
		
		sql.append(" ORDER BY (CASE WHEN UPDATE_DATE_TIME IS NOT NULL THEN UPDATE_DATE_TIME ELSE CREATE_DATE_TIME END) DESC ");
		return query(sql.toString(), KeyDevice.class, pageNo, pageSize, params);
	}

	@Override
	public List<KeyDevice> getKeyDeviceListByUnitId(long unitId) {
		String sql = "SELECT K.* FROM DT_KEY_DEVICE K WHERE K.DELETED='N' AND K.UNIT_ID=?";
		return this.query(sql, KeyDevice.class, unitId);
	}
	
	@Override
	public KeyDevice getKeyDeviceByAddress(String deviceAddress) {
		String sql = "SELECT * FROM DT_KEY_DEVICE A WHERE A.DEVICE_ADDRESS = ? AND A.DELETED = ?";
		return queryForObject(sql , KeyDevice.class , deviceAddress ,Constant.MODEL_DELETED_N);
	}

	@Override
	public int getUnitIdByKeyId(Long keyId) {
		String sql = "SELECT UNIT_ID FROM DT_KEY_DEVICE WHERE ID = ?";
		return queryCount(sql, new Object[]{keyId});
	}

	@Override
	public List<KeyDevice> findkeyDeviceByUnitAndStory(Long unitId, Long storyId) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT A.* FROM DT_KEY_DEVICE A INNER JOIN DT_UNIT B ")
			.append(" ON A.DELETED = :deleted AND B.DELETED = :deleted AND B.ID=A.UNIT_ID ")
			.append(" WHERE A.UNIT_ID = :unitId AND (A.STORY_ID = 0 OR A.STORY_ID = :storyId )");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("storyId", storyId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		return this.query(sql.toString(), KeyDevice.class, params);
	}
}
