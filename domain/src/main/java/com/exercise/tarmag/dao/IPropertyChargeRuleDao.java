package com.dt.tarmag.dao;



import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.PropertyChargeRule;
import com.dt.tarmag.vo.PropertyChargeRuleVo;


/**
 * @author yuwei
 * @Time 2015-8-21上午09:54:04
 */
public interface IPropertyChargeRuleDao extends Dao<PropertyChargeRule, Long> {
	/**
	 * 查询收费规则条数
	 * @return
	 */
	int getChargeRuleCount(byte isEffect);
	
	/**
	 * 查询收费规则
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<PropertyChargeRule> getChargeRuleList(byte isEffect, int pageNo, int pageSize);
	
	/**
	 * 查询所有物业费规则
	 * @param searchVo
	 * @return
	 */
	public List<Map<String , Object>> findPropertyChargeRules(PropertyChargeRuleVo searchVo);
	
	/**
	 * 根据小区期数id查询物业费规则
	 * @param partitionId
	 * @return
	 */
	public PropertyChargeRule getPropertyChargeRuleByPartitionId(long partitionId);
	
}
