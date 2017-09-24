package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Notice;


/**
 * @author yuwei
 * @Time 2015-7-6下午07:04:04
 */
public interface INoticeDao extends Dao<Notice, Long> {

	/**
	 * 获取通知列表
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> notices(Map<String, Object> params, int pageNo);

	/**
	 * 清空已读
	 * @param unitId 小区id
	 * @param residentId 用户id
	 */
	public void clean(Long unitId, Long residentId);

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
	List<Notice> getNoticeList(long unitId, Byte type, int pageNo, int pageSize);
}
