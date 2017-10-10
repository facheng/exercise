package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.ExpressDelivery;
import com.dt.tarmag.util.Params;

/**
 * @author yuwei
 * @Time 2015-7-8下午07:35:12
 */
@Repository
public class ExpressDeliveryDao extends DaoImpl<ExpressDelivery, Long>
		implements IExpressDeliveryDao {

	@Override
	public List<Map<String, Object>> expressdeliverys(
			Params<String, Object> params, int pageNo) {
		String sql = "SELECT ED.ID id, ED.TITLE title, ED.CREATE_DATE_TIME createDateTime, CASE EDR.IS_READ WHEN 1 THEN '1' ELSE '0' END isRead FROM DT_EXPRESS_DELIVERY ED, DT_EXPRESS_DELIVERY_RECEIVER EDR WHERE EDR.DELETED='N' AND ED.ID=EDR.DELIVERY_ID AND ED.DELETED='N' AND ED.HOUSE_ID=:houseId AND EDR.RESIDENT_ID=:residentId";
		return this.queryForMapList(sql, pageNo ==0 ? 1 : pageNo,10, params);
	}


	@Override
	public int getExpressDeliveryCount(long unitId) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append(" SELECT COUNT(ID) ")
		   .append(" FROM DT_EXPRESS_DELIVERY ")
		   .append(" WHERE UNIT_ID = :unitId AND DELETED = :deleted ");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		return queryCount(sql.toString(), params);
	}

	@Override
	public List<ExpressDelivery> getExpressDeliveryList(long unitId, int pageNo, int pageSize) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append(" SELECT * ")
		   .append(" FROM DT_EXPRESS_DELIVERY ")
		   .append(" WHERE UNIT_ID = :unitId AND DELETED = :deleted ");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		sql.append(" ORDER BY (CASE WHEN UPDATE_DATE_TIME IS NOT NULL THEN UPDATE_DATE_TIME ELSE CREATE_DATE_TIME END) DESC ");
		return query(sql.toString(), ExpressDelivery.class, pageNo, pageSize, params);
	}
}
