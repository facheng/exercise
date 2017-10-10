package com.dt.tarmag.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.PropertyChargeRule;
import com.dt.tarmag.vo.PropertyChargeRuleVo;


/**
 * @author yuwei
 * @Time 2015-8-21上午09:59:14
 */
@Repository
public class PropertyChargeRuleDao extends DaoImpl<PropertyChargeRule, Long> implements IPropertyChargeRuleDao {

	@Override
	public int getChargeRuleCount(byte isEffect) {
		String sql = "SELECT COUNT(ID) FROM DT_PROPERTY_CHARGE_RULE WHERE IS_EFFECT = ? AND DELETED = ?";
		return queryCount(sql, new Object[]{isEffect, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<PropertyChargeRule> getChargeRuleList(byte isEffect, int pageNo, int pageSize) {
		String sql = "SELECT * FROM DT_PROPERTY_CHARGE_RULE WHERE IS_EFFECT = ? AND DELETED = ?";
		return query(sql, PropertyChargeRule.class, pageNo, pageSize, new Object[]{isEffect, Constant.MODEL_DELETED_N});
	}
	
	@Override
	public List<Map<String, Object>> findPropertyChargeRules(PropertyChargeRuleVo searchVo) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT A.ID id, A.PARTITION_ID partitionId , A.CYCLE cycle , ")
			.append(" A.CTYPE ctype , A.FEE_AREA feeArea , A.FEE_LIFT feeLift ,")
			.append(" A.FEE_ALL feeAll , A.BASEMENT_FEE_AREA basementFeeArea ,")
			.append(" A.IS_EFFECT isEffect")
			.append(" FROM DT_PROPERTY_CHARGE_RULE A INNER JOIN DT_UNIT_PARTITION B")
			.append(" ON A.PARTITION_ID = B.ID AND B.DELETED = :deleted ")
			.append(" WHERE A.DELETED = :deleted AND  B.UNIT_ID = :unitId");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("unitId", searchVo.getUnitId());
		
		return this.queryForMapList(sql.toString(), params);
		
	}

	@Override
	public PropertyChargeRule getPropertyChargeRuleByPartitionId(long partitionId) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT * FROM DT_PROPERTY_CHARGE_RULE A WHERE A.PARTITION_ID = :partitionId AND A.DELETED = :deleted");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("partitionId", partitionId);
		
		return this.queryForObject(sql.toString(), PropertyChargeRule.class, params);
	}
	
}
