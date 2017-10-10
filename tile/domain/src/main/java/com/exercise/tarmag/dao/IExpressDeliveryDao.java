package com.dt.tarmag.dao;

import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.ExpressDelivery;
import com.dt.tarmag.util.Params;

/**
 * @author yuwei
 * @Time 2015-7-8下午07:34:42
 */
public interface IExpressDeliveryDao extends Dao<ExpressDelivery, Long> {

	/**
	 * 获取快递列表
	 * 
	 * @param params
	 *            参数
	 * @return
	 */
	public List<Map<String, Object>> expressdeliverys(Params<String, Object> params, int pageNo);

	/**
	 * 查询小区的快递消息条数
	 * @param unitId
	 * @return
	 */
	int getExpressDeliveryCount(long unitId);
	/**
	 * 查询小区的快递消息
	 * @param unitId
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<ExpressDelivery> getExpressDeliveryList(long unitId, int pageNo, int pageSize);
}
