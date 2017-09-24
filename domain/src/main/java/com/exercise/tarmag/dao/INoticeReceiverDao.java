package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.NoticeReceiver;


/**
 * @author yuwei
 * @Time 2015-7-6下午07:05:07
 */
public interface INoticeReceiverDao extends Dao<NoticeReceiver, Long> {

	/**
	 * 根据通知id和房屋id查询通知回复
	 * @param noticeId 通知id
	 * @param residentId 用户id
	 * @return
	 */
	NoticeReceiver getNoticeReceiver(Long noticeId, Long residentId);
	
	/**
	 * 查询指定通知被阅读次数
	 * @param noticeId
	 * @return
	 */
	int getReadCountByNoticeId(long noticeId);
	
	/**
	 * 查询通知已读记录
	 * @param noticeId
	 * @return
	 */
	List<NoticeReceiver> getNoticeReadList(long noticeId, int pageNo, int pageSize);
	
	/**
	 * 通过id串查询需要推送的数据
	 * @param broadcastId
	 * @return
	 */
	List<Map<String, Object>> getPushVos(long broadcastId);
}
