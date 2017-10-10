package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IPropertyChargeRuleDao;
import com.dt.tarmag.dao.IUnitPartitionDao;
import com.dt.tarmag.model.PropertyChargeRule;
import com.dt.tarmag.model.UnitPartition;
import com.dt.tarmag.vo.PropertyChargeRuleVo;

/**
 * 物业费规则业务逻辑
 * @author wangfacheng
 * @date 2015年8月21日13:41:13
 */
@Service
public class PropertyChargeRuleService implements IPropertyChargeRuleService {

	private static Logger logger = Logger.getLogger(PropertyChargeRuleService.class);

	@Autowired
	private IPropertyChargeRuleDao propertyChargeRuleDao;
	
	@Autowired
	private IUnitPartitionDao unitPartitionDao;

	@Override
	public List<Map<String, Object>> findPropertyChargeRules(PropertyChargeRuleVo searchVo) {

		if (searchVo == null) {
			return null;
		}

		return propertyChargeRuleDao.findPropertyChargeRules(searchVo);
	}

	@Override
	public PropertyChargeRule getPropertyChargeRuleByPartitionId(Long unitId , Long partitionId) {

		UnitPartition unitPartition = this.unitPartitionDao.get(partitionId);
		if (unitPartition == null) {
			logger.error("未查询到小区id["+unitId+"]下期数id为["+partitionId+"]的小区信息");
			return null;
		}
		
		PropertyChargeRule propertyChargeRule = this.propertyChargeRuleDao.getPropertyChargeRuleByPartitionId(unitPartition.getId());

		return propertyChargeRule;
	}

	@Override
	public boolean saveOrUpdatePropertyChargeRule_tx(PropertyChargeRuleVo vo) throws RuntimeException {

		if ( vo == null) {
			logger.error("更新物业规则时发生错误，传入参数为空");
			return false;
		}

		try {
				PropertyChargeRule propertyCRule = this.propertyChargeRuleDao.getPropertyChargeRuleByPartitionId(vo.getPartitionId());
			
				//一个小区期数id只能对应一条物业费规则,有了就更新。没有就插入
				if(propertyCRule != null){
					
					propertyCRule = convertPropertyChargeRule(vo , propertyCRule);
					this.propertyChargeRuleDao.update(propertyCRule);
					
				} else {
					
					propertyCRule = convertPropertyChargeRule(vo , propertyCRule);
					this.propertyChargeRuleDao.save(propertyCRule);
				}
					
				return true;
			
		}
		catch (Exception e) {
			logger.error("修改物业费规则时发生错误,"+ e.getMessage() , e);
			throw new RuntimeException(e.getMessage());
		}

	}

	private PropertyChargeRule convertPropertyChargeRule(PropertyChargeRuleVo vo , PropertyChargeRule dto){
		
		if(dto == null ){
			dto = new PropertyChargeRule();
		}
		
		if(vo != null ){
			
			if(PropertyChargeRule.CTYPE_AREA == vo.getCtype()){
				dto.setBasementFeeArea(vo.getBasementFeeArea());
				dto.setCtype(PropertyChargeRule.CTYPE_AREA);
				dto.setFeeArea(vo.getFeeArea());
				dto.setFeeLift(vo.getFeeLift());
				dto.setIsEffect(vo.getIsEffect());
				dto.setPartitionId(vo.getPartitionId());
				dto.setCycle(vo.getCycle());
				
			} else if(PropertyChargeRule.CTYPE_HOUSE == vo.getCtype()){
				
				dto.setCtype(PropertyChargeRule.CTYPE_HOUSE);
				dto.setBasementFeeArea(0);
				dto.setFeeArea(0);
				dto.setFeeLift(0);
				dto.setIsEffect(vo.getIsEffect());
				dto.setPartitionId(vo.getPartitionId());
				dto.setCycle(vo.getCycle());
				dto.setFeeAll(vo.getFeeAll());
			}
			
		}
		return dto;
		
	}
	
	@SuppressWarnings("unused")
	private boolean checkPropertyChargeRuleParams(PropertyChargeRuleVo vo){
		
		if(vo == null ){
			logger.error("传入参数为空");
			return false;
		}
		
		if(!PropertyChargeRule.getCtypeKeys().contains(vo.getCtype())){
			logger.error("传入收费类型错误");
			return false;
		}
		if(!PropertyChargeRule.getCycleKeys().contains(vo.getCycle())){
			logger.error("传入缴费周期错误");
			return false;
		}
		if(!PropertyChargeRule.getIsEffectKeys().contains(vo.getIsEffect())){
			logger.error("传入是否生效值错误");
			return false;
		}
		
		if(PropertyChargeRule.CTYPE_AREA == vo.getCtype()){
			if(vo.getFeeArea() < 0 || vo.getFeeLift() < 0 || vo.getBasementFeeArea() < 0){
				logger.error("传入了错误的单价(负数)");
				return false;
			}
			
		} else if(PropertyChargeRule.CTYPE_HOUSE == vo.getCtype()){
			if(vo.getFeeAll() < 0){
				logger.error("传入整套房屋费用值为负数");
				return false;
			}
		}
		
		return true;
	}

}
