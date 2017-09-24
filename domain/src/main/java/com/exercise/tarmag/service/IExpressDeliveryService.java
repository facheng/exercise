/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;


/**
 * @author 👤wisdom 
 *
 */
public interface IExpressDeliveryService {

	/**
	 * 获取物业快递代收授权
	 * @param houseId 房屋id
	 * @return
	 */
	public byte security(Long houseId);

	/**
	 * 授权物业代收快递
	 * @param houseId 房屋id
	 */
	public void delegate_tx(Long houseId, int delegateDelivery);

	/**
	 * 获取快递列表
	 * @param houseId 房屋ID
	 * @param residentId 用户ID
	 * @return 
	 */
	public List<Map<String, Object>> expressdeliverys(Long houseId, Long residentId, int pageNo);

	/**
	 * 阅读快递详细
	 * @param id 快递id
	 * @param residentId 用户id
	 */
	public Map<String, Object> expressdelivery_tx(Long id, Long residentId);

	/**
	 * 清除已读
	 * @param residentId
	 * @param houseId 
	 */
	public void clean_tx(Long residentId, Long houseId);

}
