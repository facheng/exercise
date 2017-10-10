package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.vo.BroadcastVo;
import com.dt.tarmag.vo.DeliveryVo;
import com.dt.tarmag.vo.NoticeVo;


/**
 * 信息管理
 * @author yuwei
 * @Time 2015-7-9下午01:43:55
 */
public interface IInfoService {
	/**
	 * 查询小区的公告条数
	 * @param unitId
	 * @param type
	 * @return
	 */
	int getBroadcastCount(long unitId, Byte type);
	/**
	 * 查询小区的公告
	 * @param unitId
	 * @param type
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Map<String, Object>> getBroadcastMapList(long unitId, Byte type, int pageNo, int pageSize);
	
	/**
	 * 删除公告
	 * @param broadcastId
	 */
	void deleteBroadcast_tx(List<Long> idList);
	
	/**
	 * 查看公告详情
	 * @param broadcastId
	 * @return
	 */
	Map<String, Object> getBroadcastDetail(long broadcastId);
	
	/**
	 * 查询公告供编辑
	 * @param broadcastId
	 * @return
	 */
	Map<String, Object> getBroadcastToEdit(long broadcastId);
	
	/**
	 * 创建新公告
	 * @param vo
	 */
	void createBroadcast_tx(BroadcastVo vo);
	
	/**
	 * 更新公告
	 * @param broadcastId
	 * @param vo
	 */
	void updateBroadcast_tx(long broadcastId, BroadcastVo vo);
	
	/**
	 * 查询公告已读数
	 * @param broadcastId
	 * @return
	 */
	int getReadCountByBroadcastId(long broadcastId);
	
	/**
	 * 查询公告已读记录
	 * @param broadcastId
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Map<String, Object>> getBroadcastReadList(long broadcastId, int pageNo, int pageSize);

	/**
	 * 查询小区的通知条数
	 * @param unitId
	 * @param type
	 * @return
	 */
	int getNoticeCount(long unitId, Byte type);
	/**
	 * 查询小区的通知
	 * @param unitId
	 * @param type
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Map<String, Object>> getNoticeMapList(long unitId, Byte type, int pageNo, int pageSize);
	
	/**
	 * 删除通知
	 * @param noticeId
	 */
	void deleteNotice_tx(List<Long> idList);
	
	/**
	 * 查看通知详情
	 * @param noticeId
	 * @return
	 */
	Map<String, Object> getNoticeDetail(long noticeId);
	
	/**
	 * 查询通知供编辑
	 * @param noticeId
	 * @return
	 */
	Map<String, Object> getNoticeToEdit(long noticeId);
	
	/**
	 * 创建新通知
	 * @param vo
	 */
	void createNotice_tx(NoticeVo vo);
	
	/**
	 * 更新通知
	 * @param noticeId
	 * @param vo
	 */
	void updateNotice_tx(long noticeId, NoticeVo vo);
	
	/**
	 * 查询通知已读数
	 * @param noticeId
	 * @return
	 */
	int getReadCountByNoticeId(long noticeId);
	
	/**
	 * 查询通知已读记录
	 * @param noticeId
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Map<String, Object>> getNoticeReadList(long noticeId, int pageNo, int pageSize);
	
	/**
	 * 查询快递供编辑
	 * @param deliveryId
	 * @return
	 */
	Map<String, Object> getDeliveryToEdit(long deliveryId);
	
	/**
	 * 创建新快递
	 * @param vo
	 */
	void createDelivery_tx(DeliveryVo vo);
	
	/**
	 * 更新快递
	 * @param deliveryId
	 * @param vo
	 */
	void updateDelivery_tx(long deliveryId, DeliveryVo vo);

	/**
	 * 查询小区的快递消息条数
	 * @param unitId
	 * @return
	 */
	int getDeliveryCount(long unitId);
	
	/**
	 * 查询小区的快递消息
	 * @param unitId
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Map<String, Object>> getDeliveryMapList(long unitId, int pageNo, int pageSize);
	
	/**
	 * 删除快递消息
	 * @param deliveryId
	 */
	void deleteDelivery_tx(List<Long> idList);
	
	/**
	 * 查看快递消息详情
	 * @param deliveryId
	 * @return
	 */
	Map<String, Object> getDeliveryDetail(long deliveryId);
	
	/**
	 * 查询快递消息已读数
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
	List<Map<String, Object>> getExpressDeliveryReadList(long deliveryId, int pageNo, int pageSize);
	
	/**
	 * 签收快递
	 * 1成功
	 * 0失败
	 * 前后收，通知这个房屋所有的人，写快递已经被领走，请知悉！
	 * @param deliveryId
	 * @param residentId
	 * @return
	 */
	String signForDelivery_tx(long deliveryId, long residentId);
	
	/**
	 * 发送缴费通知
	 * @param idList
	 * @param unitId
	 */
	public void sendPaymentNotice_tx(List<Long> idList, Long unitId);
}
