package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.model.PropertyChargeBill;
import com.dt.tarmag.model.PropertyChargeRule;
import com.dt.tarmag.vo.PropertyChargeBillSearchVo;





/**
 * 缴费管理
 * @author yuwei
 * @Time 2015-8-21上午10:01:19
 */
public interface IPropertyChargeService {
	
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
	
	void save_tx(PropertyChargeBill bill);
	
	/**
	 * 获取物业缴费记录列表总数
	 * @param unitId
	 * @param status
	 * @param roomNum
	 * @param partitionId
	 * @return
	 */
	public int getPropertyChargeCount(Long unitId, PropertyChargeBillSearchVo pblSearchVo);
	
	/**
	 * 获取物业缴费记录列表
	 * @param unitId
	 * @param status
	 * @param roomNum
	 * @param partitionId
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> getPropertyChargeList(
			Long unitId,
			PropertyChargeBillSearchVo pblSearchVo,
			Integer pageNo,
			Integer pageSize);
	
	/**
	 * 修改物业缴费记录状态
	 * @param idList
	 */
	public void updatePropertyChargeStatus_tx(List<Long> idList ,String opt);
}
