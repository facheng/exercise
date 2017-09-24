package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.model.PropertyChargeRule;
import com.dt.tarmag.vo.PropertyChargeRuleVo;

/**
 * 物业规则service
 * @author wangfacheng
 * @date 2015年8月21日13:41:13
 *
 */
public interface IPropertyChargeRuleService {

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
	public PropertyChargeRule getPropertyChargeRuleByPartitionId(Long unitId , Long partitionId);
	
	
	/**
	 * 添加物业规则
	 */
	public boolean saveOrUpdatePropertyChargeRule_tx(PropertyChargeRuleVo vo) throws RuntimeException;
	
	
}
