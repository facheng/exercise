package com.dt.tarmag.service;



import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.DateUtil;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.dao.IPropertyChargeBillDao;
import com.dt.tarmag.dao.IPropertyChargeRuleDao;
import com.dt.tarmag.model.PropertyChargeBill;
import com.dt.tarmag.model.PropertyChargeRule;
import com.dt.tarmag.vo.PropertyChargeBillSearchVo;



/**
 * @author yuwei
 * @Time 2015-8-21上午10:01:59
 */
@Service
public class PropertyChargeService implements IPropertyChargeService {
	
	@Autowired
	private IPropertyChargeRuleDao propertyChargeRuleDao;
	@Autowired
	private IPropertyChargeBillDao propertyChargeBillDao;
	
	

	@Override
	public int getChargeRuleCount(byte isEffect) {
		return propertyChargeRuleDao.getChargeRuleCount(isEffect);
	}

	@Override
	public List<PropertyChargeRule> getChargeRuleList(byte isEffect, int pageNo, int pageSize) {
		return propertyChargeRuleDao.getChargeRuleList(isEffect, pageNo, pageSize);
	}

	@Override
	public void save_tx(PropertyChargeBill bill) {
		propertyChargeBillDao.save(bill);
	}
	
	protected void disposeTime(List<Map<String, Object>> results){
		if(results == null) return;
		for(Map<String, Object> result : results){
			Object startDate = result.get("startDate");
			if(startDate != null){
				result.put("startDate", DateUtil.formatDate((Date)startDate, DateUtil.PATTERN_DATE3));
			}
			Object endDate = result.get("endDate");
			if(endDate != null){
				result.put("endDate", DateUtil.formatDate((Date)endDate, DateUtil.PATTERN_DATE3));
			}
			Object createtime = result.get("createtime");
			if(createtime != null){
				result.put("createtime", DateUtil.formatDate((Date)createtime, DateUtil.PATTERN_DATE3));
			}
		}
	}

	@Override
	public int getPropertyChargeCount(Long unitId, PropertyChargeBillSearchVo pblSearchVo) {
		return this.propertyChargeBillDao.getPropertyChargeCount(unitId, pblSearchVo);
	}

	@Override
	public List<Map<String, Object>> getPropertyChargeList(
			Long unitId,
			PropertyChargeBillSearchVo pbSearchVo,
			Integer pageNo,
			Integer pageSize) {
		
		List<Map<String, Object>> propertyChargeList = this.propertyChargeBillDao.getPropertyChargeList(unitId, pbSearchVo, pageNo, pageSize);
		
		this.disposeTime(propertyChargeList);
		
		return propertyChargeList;
	}

	@Override
	public void updatePropertyChargeStatus_tx(List<Long> idList ,String opt) {
		if (idList == null || idList.size() <= 0) {
			return;
		}
		
		if(StringUtils.isNotBlank(opt)){
			if(opt.equals("jf")){
				for (long pcId : idList) {
					PropertyChargeBill propertyChargeBill = this.propertyChargeBillDao.get(pcId);
					if (propertyChargeBill != null){
						if(propertyChargeBill.getStatus() == PropertyChargeBill.STATUS_UNCHARGED){
							propertyChargeBill.setStatus(PropertyChargeBill.STATUS_CHARGED);
							propertyChargeBillDao.update(propertyChargeBill);
						}
					}else{
						continue;
					}
					
				}
			}
			if(opt.equals("kp")){
				for (long pcId : idList) {
					PropertyChargeBill propertyChargeBill = this.propertyChargeBillDao.get(pcId);
					if (propertyChargeBill != null){
						if(propertyChargeBill.getStatus() == PropertyChargeBill.STATUS_CHARGED){
							propertyChargeBill.setStatus(PropertyChargeBill.STATUS_CHARGED_AND_INVOICE);
							propertyChargeBillDao.update(propertyChargeBill);
						}
					}else{
						continue;
					}
					
				}
			}
			
		}else{
			return;
		}
		
	}
	
}
