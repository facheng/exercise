package com.dt.tarmag.dao;



import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.PropertyChargeBill;
import com.dt.tarmag.vo.PropertyChargeBillSearchVo;


/**
 * @author yuwei
 * @Time 2015-8-21上午09:59:49
 */
public interface IPropertyChargeBillDao extends Dao<PropertyChargeBill, Long> {
	
	/**
	 * 查询物业缴费记录列表总数
	 * @param unitId
	 * @param status
	 * @param roomNum
	 * @param partitionId
	 * @return
	 */
	public int getPropertyChargeCount(Long unitId, PropertyChargeBillSearchVo pblSearchVo);
	
	/**
	 * 查询物业缴费记录列表
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
	
}
