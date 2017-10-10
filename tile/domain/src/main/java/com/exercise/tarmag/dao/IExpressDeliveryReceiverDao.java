package com.dt.tarmag.dao;

import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.ExpressDeliveryReceiver;

/**
 * @author yuwei
 * @Time 2015-7-8下午07:41:59
 */
public interface IExpressDeliveryReceiverDao extends
		Dao<ExpressDeliveryReceiver, Long> {
	/**
	 * 获取快递读取记录
	 * @param deliveryId 快递id
	 * @param residentId 用户id
	 * @return
	 */
	public ExpressDeliveryReceiver getExpressDeliveryReceiver(Long deliveryId,
			Long residentId);

	/**
	 * 清除已读快递信息
	 * @param residentId
	 * @param houseId 
	 */
	public void clean(Long residentId, Long houseId);
	
	/**
	 * 查询快递信息被阅读次数
	 * @param deliveryId
	 * @return
	 */
	int getReadCountByDeliveryId(long deliveryId);

	/**
	 * 查询快递消息已读记录
	 * @param deliveryId
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<ExpressDeliveryReceiver> getExpressDeliveryReadList(long deliveryId, int pageNo, int pageSize);
	
	/**
	 * 通过id串查询需要推送的数据
	 * @param broadcastId
	 * @return
	 */
	List<Map<String, Object>> getPushVos(long broadcastId);
}
