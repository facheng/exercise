package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.Broadcast;

/**
 * @author yuwei
 * @Time 2015-7-6下午06:59:34
 */
@Repository
public class BroadcastDao extends DaoImpl<Broadcast, Long> implements
		IBroadcastDao {

	@Override
	public int getBroadcastCount(long unitId, Byte type) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append(" SELECT COUNT(ID) ")
				.append(" FROM DT_BROADCAST WHERE UNIT_ID = :unitId AND DELETED = :deleted ");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		if (type != null) {
			sql.append(" AND FROM_TYPE = :fromType ");
			params.put("fromType", type);
		}
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Broadcast> getBroadcastList(long unitId, Byte type, int pageNo,
			int pageSize) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append(" SELECT * ")
				.append(" FROM DT_BROADCAST WHERE UNIT_ID = :unitId AND DELETED = :deleted ");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		if (type != null) {
			sql.append(" AND FROM_TYPE = :fromType ");
			params.put("fromType", type);
		}
		
		sql.append(" ORDER BY (CASE WHEN UPDATE_DATE_TIME IS NOT NULL THEN UPDATE_DATE_TIME ELSE CREATE_DATE_TIME END) DESC ");
		return query(sql.toString(), Broadcast.class, pageNo, pageSize, params);
	}

	@Override
	public void clean(Long residentId, Long unitId) {
		String sql = "UPDATE DT_BROADCAST_READER BR SET BR.DELETED='Y' WHERE BR.DELETED='N' AND BR.IS_READ='1' AND BR.RESIDENT_ID=? AND BR.BROADCAST_ID IN (SELECT ID FROM DT_BROADCAST WHERE DELETED='N' AND UNIT_ID=?)";
		this.execute(sql, residentId, unitId);
	}
}
